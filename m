Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2756B510186
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Apr 2022 17:13:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350975AbiDZPQl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Apr 2022 11:16:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352134AbiDZPL7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Apr 2022 11:11:59 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70C6F161A73
        for <linux-kernel@vger.kernel.org>; Tue, 26 Apr 2022 08:08:20 -0700 (PDT)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 23QDT12W003733;
        Tue, 26 Apr 2022 15:08:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : subject :
 date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=lmvBg3xZ+MSjAFUNss/pY9W2o34DqElYKaMH18RahWQ=;
 b=bdWliJD3CWzJhcxieeXjSiRs7MtQo9u4WBpo7RjRVWQxqbhFatx1jtcj1BRR6dQt26MF
 73vLIwABDDS1wpvnLB2GnJ2VpU6ao4eR6ICOHPyrdopwaI2BvTJnC1bCgb6mcDOJ0+68
 MxIWJbHL/3k3X2emjCC05dgOaC80lze3aQhWJag/vJKWN3cL+A7Nc9uE+rmmvF+gRz5o
 PQgFZj6hxAcxWA2cM+3yXf1og2ga53WMXPoLiptfRZHecUcmVUeGetBh89+ct7oaqwt2
 4THKozz8F5fuOifRJPyjwr+AlrqirGlqugUAmqKkkJI522phVpAgMguyNDgYrEQ3nlm8 cA== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3fmbb4p75d-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 26 Apr 2022 15:08:14 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 23QF6UIN037839;
        Tue, 26 Apr 2022 15:08:13 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2169.outbound.protection.outlook.com [104.47.56.169])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com with ESMTP id 3fp5yjkvb2-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 26 Apr 2022 15:08:13 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nXp81cMwCWSAlORNUzy6FJ7UlRiTJUsKqIIiGtHC8Lw1ihK2GWFfkgO5HflopzRHlfQ8N5tIASnnjurSYFjqDq6+sTXvoPYWCL5168x+skYsUDkhs1onzchCc9Cf7KibU+MwkOx/sCDDFtxNeaUPrrjEHafky7zRfjtBW2wTu3arkwTqZsdLzkSF27UJcK0EfD8ybWO5xEhQthwGiq6W1MBOPvQ/1g++XJxamzPrYQgVEzSRC+CDxFiUuanp/BnCBJd9sNPfTqw2pXlSogj6O8t6JQeqjtjgf3lotIYK+QUuUqVlGE9ydgWkvh8md+6rdlAWqaZdKznGypcH/fD/uA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lmvBg3xZ+MSjAFUNss/pY9W2o34DqElYKaMH18RahWQ=;
 b=Ev3Poks4ik5NY78Tgw6f8m4aDh4yzXsfwECX4QZGMu0RdW2HGo33ZyEPiYujJfEAeNeK++MngmJsUYyMkAJ3Egon08031aERUTi4Qm1EvyxnDLDsBaGTN2XPtaCFN+WqmDFn2gGZuyQHxpw/djFwq1n3TJY8F1MbAsYeGFLGTf9tWGrhvTr6GRghkAtg7uqYih2dOniI8bit+DQcWMO0bGSZ76pyCki0Vd6uHDZm+DdvI6EKL9kTqHpZZcsdffhEFdW+9CixpKZjJcQNkurHZZcpCC4zK2Kc20DD3CrdSOum+p7cAlfJAwQZ8KF6F3IrQJ0QiJmbwcJ/5DFSpCPucw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lmvBg3xZ+MSjAFUNss/pY9W2o34DqElYKaMH18RahWQ=;
 b=KP0OjKNe/MbuMbQm4pknmzq3ziGxhy+kuHZhbtFshCMX8tz+NioWBMZ0oWkvOFnMk7TMoD8IpKYNSiQFqycTsWNUp1tuy/UEpPgjOJgYFz2eCtzYhr0FfJfSzhPBgyhD8MliyMpvMVZl94fiiPbE8OqZLSai2q8HOQG3QudISl0=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by SN6PR10MB3037.namprd10.prod.outlook.com (2603:10b6:805:dc::26) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.19; Tue, 26 Apr
 2022 15:08:10 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::318c:d02:2280:c2c]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::318c:d02:2280:c2c%7]) with mapi id 15.20.5186.021; Tue, 26 Apr 2022
 15:08:10 +0000
From:   Liam Howlett <liam.howlett@oracle.com>
To:     "maple-tree@lists.infradead.org" <maple-tree@lists.infradead.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Yu Zhao <yuzhao@google.com>
Subject: [PATCH v8 70/70] mm/mmap.c: pass in mapping to __vma_link_file()
Thread-Topic: [PATCH v8 70/70] mm/mmap.c: pass in mapping to __vma_link_file()
Thread-Index: AQHYWX9DDodK3uPYbUGcWxPieY5ICQ==
Date:   Tue, 26 Apr 2022 15:06:54 +0000
Message-ID: <20220426150616.3937571-71-Liam.Howlett@oracle.com>
References: <20220426150616.3937571-1-Liam.Howlett@oracle.com>
In-Reply-To: <20220426150616.3937571-1-Liam.Howlett@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.35.1
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 9dd0a1c8-37e4-4ac4-7421-08da2796940e
x-ms-traffictypediagnostic: SN6PR10MB3037:EE_
x-microsoft-antispam-prvs: <SN6PR10MB3037E5A4C51B2459584611ADFDFB9@SN6PR10MB3037.namprd10.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 4nFiuK2L3glSxUC2zUfrj6dTGT7gTDj0GqcxbXxC9vZNMN+PovaCyk6AaxJWXdZuU9SLY9b8GIXgltzv21hD3WHJEDOvotkEh45i0+REULrRA3Ku+jKlSSZQZ2X1ZEpNy2a1hXrF/mtwH52lhbzFq3aWkMRrKp3r7GbHw0WKWKOt4SKc+2iwV3X8seLuZym2XGAk+qWph1PBoe6B1P2yqWWcqnc8pzYDzGeDEA4MgNR76KtNMirFenigE2BFvZOfYUnHMa17ZdGlNyIl+3DuuVzfA2MKrrV/W0m/8lZcn0oGwYhkIcawQjtBQVr056vURU9lYuaSQMJKX2RF7onpYzw7IKiQ1/cDObHRwhOfbgQJybqWcpnlIcSAyB0ce+Xzw5MyxOblCcA6nulna2N/qVQ7+rk9E67zNbUdPqlQrSFvLRC0/KLV0Ml+mTHDhH/bifxVooACGutR0Rxos+zznsWnPkzSsl8Tv52E141x4gTFGffyEhcayTUNrPnv0ohM8i3rI4c0tMybpdtiN8lBCJDn/xPvyBLWWiUre0tcQcfvxGogZJiu8s0vHIf4howU0QYWUI6mzQ3+4MTWAekwp2ZeBl9kpcrBc2wFFlvtPeumjQx/U4NWyFZsfhERm201kTCigMV4AxmFKWJ3kGq/MBKQaIpNAcEz0ZyX+rpTexWVoDdfboLetm/GbqLZ6iicCOBTC5QINWIWtOuO4M/ZrQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(8676002)(64756008)(83380400001)(66556008)(66476007)(66446008)(66946007)(86362001)(122000001)(91956017)(76116006)(44832011)(2906002)(38070700005)(38100700002)(316002)(2616005)(186003)(1076003)(110136005)(5660300002)(6666004)(8936002)(6506007)(36756003)(508600001)(6486002)(6512007)(71200400001)(26005);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?9HuTl2HTbgzmllUxd24QFlokhxh25hfsD38X9qIOjglE0VYb4reX3qJo1r?=
 =?iso-8859-1?Q?J6QFEi91I6k9nl3KwwbC7Lik145btVN412FvCevmLmW/ml3IH8yRxu3BSB?=
 =?iso-8859-1?Q?y1Jgg8i+4nRyN/jdEUf8EofXI3IIDFDsOkI6dfxkAxANQySRA2XLpfsPju?=
 =?iso-8859-1?Q?0WoRkW3y+Wj1al81dzMb7K+StawPlZf42gAd5mZ2Uofd+Hlp4LXfj6dspq?=
 =?iso-8859-1?Q?wHwKlJYnrK7kWODzbm2izOB6FQb3SwMTCOkAxhknXkx8KPJ62invykGsGB?=
 =?iso-8859-1?Q?85MZvzyunixf1K4YbR9cT4YLSZyQBU/TGxQeKZAyT7krARHOkrp1qzjAB3?=
 =?iso-8859-1?Q?k7javp6oJI5ZDTfgWcUu0w8Anp1ZWSS//ZaUumO9vE+IljyGHB0afPu4A8?=
 =?iso-8859-1?Q?ry0YtfyWFkv3LlAYAG0eJtQ4iLIku2Aeway5UbFMJtkWoxOu8Xa0g6h6fu?=
 =?iso-8859-1?Q?U0WFFAZjUV66bS82TzD+C+LK6SDBz7WF4370BoeGPoaX0fBmDJ5ZyWIrx6?=
 =?iso-8859-1?Q?w1flUtD9TIJdA6fshiu8G5W8PquH3eop3dIuXyQUndXNVghRF5e1z+SWBL?=
 =?iso-8859-1?Q?nxxkSfLtXMbXJjYw7Bntv0ET4W4MeOZ5rNlvfArMdkccLmap/TXo3wj+Zo?=
 =?iso-8859-1?Q?UZRDAHRQ+gmBExEgTF6dbhalPqho/AbKKStoz5++KUAOTxqDTCrQAv+Xct?=
 =?iso-8859-1?Q?+rx9t1yQCOiAq7+aKHu9QppDCAkeXRysszL/wAxRO6sj7jEhv9vOrl6j+f?=
 =?iso-8859-1?Q?+8QlTI/HIRArQdPjbPa4m10/f7wR1mkKe7xiYMqr+/2IaysmWkOCzecR77?=
 =?iso-8859-1?Q?dLC/92bAP1DMeSAIrFZa8J7TrAb/Cah/2z3Iw6t2NxNbKKLMVGVvvHJIhB?=
 =?iso-8859-1?Q?7CaXRvQJUCl2Np5y2DdZKtesnnlW3WxKRnVBksqnEHMaF9LE6bpNSPdnrz?=
 =?iso-8859-1?Q?ltVjPA1fwWy2uDkGooIj8yJ1h5Un42wzDrGXCmAJlUzAXksn43CUnXcs2c?=
 =?iso-8859-1?Q?NHakTiJ+ZJK56PN6M9J/mBDLwAsJf8/RRth6Z0WJ8OG/FrQZ4KSNK4n9/Q?=
 =?iso-8859-1?Q?GBiUrc8AnUX6sx3WlqA1GxGQ3S74YTPuR46XnGGeXEp18liHl4DCA9REPg?=
 =?iso-8859-1?Q?hn8g32jYPIAuKLhJzAZjMbLu173ja7zEqp1l2HEQ0EkPKoHoLj4V8Ef9fO?=
 =?iso-8859-1?Q?3aKYm/09AnQsbWkK201dzFZp1249MfcNWZfHgjnMii0NDzlUnxc5F5nu7U?=
 =?iso-8859-1?Q?g3EZWmA1Piygzrj6GkqUFpg2J8GCwU+8ZZmp26hh74F/W2KunI2PXOvc2O?=
 =?iso-8859-1?Q?Eu+mGjOnI9LZ4cqEaHw7O786c1DFEzb6B/XRHrPBxVBSe0/T672+W3Zs1w?=
 =?iso-8859-1?Q?tFOeK++CwB/kB+VJwh67vWVtALnWbXyALWLjTEBFLjje+u3/l2purjliAE?=
 =?iso-8859-1?Q?Mkx6wUuhlcW9yrnPZQEKrpFfBZUnXIzDy6UVY8ozqkZbxr7Ju6MGpjptjz?=
 =?iso-8859-1?Q?jXZFwLZvAGTKfyYA2il/fEKIZHa3C94MszAfpMtZl8lx15olQZu2H0Y6pc?=
 =?iso-8859-1?Q?S21AnC//pvTSzolRbSv268uaJm5ySPJkGVSmXkhRndsBsrvmnBwCC4sxuj?=
 =?iso-8859-1?Q?BgdeV45c6bhpKanVqZP1RBq6hBNmNVoCnQTEJKZDBiROFaKk85GT4qHDRM?=
 =?iso-8859-1?Q?tIi+/AkgB45j08BNK/b101h05wcyC9vF7OkQXjhx1OD/yjm1g1Q9GQyjhh?=
 =?iso-8859-1?Q?q6O6Qsb+eypz7OAw7TjOf8Y36ti0zb2NHzveB6H5ERlb+5EaVb16srmjG3?=
 =?iso-8859-1?Q?+AJX1LfHYYXyoDMiO1OFPm2xYcjb9UI=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9dd0a1c8-37e4-4ac4-7421-08da2796940e
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Apr 2022 15:06:54.2232
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 7ufNBFlwc1qrxSTUwUvO9Ly3VF+g29nnPGFNxN+lP9NPJnD2hsJwTGm0bwHnn4iuh9+SDegM6H+LUyCd2XJL0w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR10MB3037
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.486,18.0.858
 definitions=2022-04-26_04:2022-04-26,2022-04-26 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 mlxlogscore=999 mlxscore=0
 suspectscore=0 malwarescore=0 spamscore=0 adultscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2202240000
 definitions=main-2204260096
X-Proofpoint-ORIG-GUID: yCGxLh7CNVsXInr1UmSeMqhE-Owa6zq4
X-Proofpoint-GUID: yCGxLh7CNVsXInr1UmSeMqhE-Owa6zq4
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Liam R. Howlett" <Liam.Howlett@Oracle.com>

__vma_link_file() resolves the mapping from the file, if there is one.
Pass through the mapping and check the vm_file externally since most
places already have the required information and check of vm_file.

Signed-off-by: Liam R. Howlett <Liam.Howlett@oracle.com>
---
 mm/mmap.c | 33 ++++++++++++++-------------------
 1 file changed, 14 insertions(+), 19 deletions(-)

diff --git a/mm/mmap.c b/mm/mmap.c
index 01985a0d664e..6a37f5d2e496 100644
--- a/mm/mmap.c
+++ b/mm/mmap.c
@@ -249,6 +249,7 @@ SYSCALL_DEFINE1(brk, unsigned long, brk)
 	if (brk < min_brk)
 		goto out;
=20
+
 	/*
 	 * Check against rlimit here. If this check is done later after the test
 	 * of oldbrk with newbrk then it can escape the test and let the data
@@ -325,7 +326,6 @@ SYSCALL_DEFINE1(brk, unsigned long, brk)
 	if (populate)
 		mm_populate(oldbrk, newbrk - oldbrk);
 	return brk;
-
 out:
 	mmap_write_unlock(mm);
 	return origbrk;
@@ -457,21 +457,15 @@ static unsigned long count_vma_pages_range(struct mm_=
struct *mm,
 	return nr_pages;
 }
=20
-static void __vma_link_file(struct vm_area_struct *vma)
+static void __vma_link_file(struct vm_area_struct *vma,
+			    struct address_space *mapping)
 {
-	struct file *file;
-
-	file =3D vma->vm_file;
-	if (file) {
-		struct address_space *mapping =3D file->f_mapping;
-
-		if (vma->vm_flags & VM_SHARED)
-			mapping_allow_writable(mapping);
+	if (vma->vm_flags & VM_SHARED)
+		mapping_allow_writable(mapping);
=20
-		flush_dcache_mmap_lock(mapping);
-		vma_interval_tree_insert(vma, &mapping->i_mmap);
-		flush_dcache_mmap_unlock(mapping);
-	}
+	flush_dcache_mmap_lock(mapping);
+	vma_interval_tree_insert(vma, &mapping->i_mmap);
+	flush_dcache_mmap_unlock(mapping);
 }
=20
 /*
@@ -518,10 +512,11 @@ static int vma_link(struct mm_struct *mm, struct vm_a=
rea_struct *vma)
 	}
=20
 	vma_mas_store(vma, &mas);
-	__vma_link_file(vma);
=20
-	if (mapping)
+	if (mapping) {
+		__vma_link_file(vma, mapping);
 		i_mmap_unlock_write(mapping);
+	}
=20
 	mm->map_count++;
 	validate_mm(mm);
@@ -762,14 +757,14 @@ int __vma_adjust(struct vm_area_struct *vma, unsigned=
 long start,
 			uprobe_munmap(next, next->vm_start, next->vm_end);
=20
 		i_mmap_lock_write(mapping);
-		if (insert) {
+		if (insert && insert->vm_file) {
 			/*
 			 * Put into interval tree now, so instantiated pages
 			 * are visible to arm/parisc __flush_dcache_page
 			 * throughout; but we cannot insert into address
 			 * space until vma start or end is updated.
 			 */
-			__vma_link_file(insert);
+			__vma_link_file(insert, insert->vm_file->f_mapping);
 		}
 	}
=20
@@ -2982,7 +2977,6 @@ static int do_brk_flags(struct ma_state *mas, struct =
vm_area_struct *vma,
 	struct mm_struct *mm =3D current->mm;
 	validate_mm_mt(mm);
=20
-
 	/*
 	 * Check against address space limits by the changed size
 	 * Note: This happens *after* clearing old mappings in some code paths.
@@ -3037,6 +3031,7 @@ static int do_brk_flags(struct ma_state *mas, struct =
vm_area_struct *vma,
 	mas_set_range(mas, vma->vm_start, addr + len - 1);
 	mas_store_gfp(mas, vma, GFP_KERNEL);
 	mm->map_count++;
+
 out:
 	perf_event_mmap(vma);
 	mm->total_vm +=3D len >> PAGE_SHIFT;
--=20
2.35.1
