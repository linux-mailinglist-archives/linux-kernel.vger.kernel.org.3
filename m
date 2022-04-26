Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 082965101AA
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Apr 2022 17:14:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352042AbiDZPO4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Apr 2022 11:14:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351989AbiDZPJ7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Apr 2022 11:09:59 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B617B135B19
        for <linux-kernel@vger.kernel.org>; Tue, 26 Apr 2022 08:06:48 -0700 (PDT)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 23QDT2Og015535;
        Tue, 26 Apr 2022 15:06:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : subject :
 date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=frE3PQA+UYQuEtG8MR1WdcRkePAAYTVlifT3u2khFKs=;
 b=lO1u9dlspkxbHPy8yJRtbeAQj74iWKvr6ppcgShr3WGx9B70eS3Zorqlgb/rLCTYGQoY
 bLvFGBwmixHOJvNjJ1cT9ja52eePMUM4Gg3qYUqEBPU/pubwmyomXVOHCMoyPNCNvWM7
 2JItgx5oox+PdfpDKkALZa7zBhwX6w4e3OQYk9+A21PmS29eOhXS00jsZCgfMrO/wOlj
 03LU4IgIiga1hnx8+vTKoRI7w+PWENjw6VsxwFtKqhfrQN8wXr0vvjLCcWNfKZHLlBtK
 uK3vXYKRH8UR3sw95hRcy1C+IW4i01R2RighPxeqtQtOkpMPd080h9QmcLCuZyPSr9bz Sg== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3fmb9apbht-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 26 Apr 2022 15:06:37 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 23QF6Urt037859;
        Tue, 26 Apr 2022 15:06:36 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2176.outbound.protection.outlook.com [104.47.59.176])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com with ESMTP id 3fp5yjktje-6
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 26 Apr 2022 15:06:36 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=i4ohLk1kiBXQwB24kn3Qzscm9pXpvRl3sPY3YBKhPxSi0VTcioPPIoFLvmFM+OwgR8hOpuz5TRY3Zo36ku9fE9m/+QrvNz0z1rsYQLBKiHyjYe/9Crgmpf0vwH9zyv1WZpJmHaXKsBIxhBRaBOQxWu8kt6a/OUEgEvuREIH6MbE9ooWQv4dPkgVlDxeD0CqGXmu9VGk1K5sLwmgu1t6VKsDKNtu2FU1Yvl3CuZ9atSy59eFNnrcJw3zPC2qPFoAiDmOkI4eQXmC0KRG/vt6AdnSls6PlFPOQN2TNEh7exKCAjeF5fCYWhAEVRLFR9iph+dl7I3tpQuIkWkG0Wmi+Wg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=frE3PQA+UYQuEtG8MR1WdcRkePAAYTVlifT3u2khFKs=;
 b=Bo1Zvd8d2dSTbU370bGpCayQxMoBLwlPP63ZR5mAffFhuDj/QE3V+mJHcHyd3OKIAgdDCkuIYuiMj8xRQ8zp2U9Olyq+P/7XBopMF1B1rR+RxxqrAHc5mXX+md4k58BFMXlNozewEBYT4X/+d5GV6YLaDcrWRkZwug3Hz99zS6T9+rjb8oVz4Eegqu6WbkQUGGWy0SdZhONTuTBSO5DbHHHxCXqPTMCcFa422PwvR6r0n2U5cgjCvcFSGFe21+XjFKeZn7WH1UG1MvL/yW9+0SHhjYt91R49A6Ig+EaX8iXeRwkNJhP94+18/XO0MFq0FaxY5n1D/aEYvrGEfPZ52A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=frE3PQA+UYQuEtG8MR1WdcRkePAAYTVlifT3u2khFKs=;
 b=Hb84epUCeMAFWIJ6zLfcc8A9/lIBanxLnMUVH/QB678ec7sSfSRMIRnWVX8BBENQT9iQLTU2ee2FrM9Q7rtwh0EgdFexskHMWJiY/drLSqjC8WwsQ9hSkcDa5Q3oKpD+YxOVJprEbT+eRyRjuw58DQc1Zdh6uNPfy1em7P3KlaA=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by PH0PR10MB4679.namprd10.prod.outlook.com (2603:10b6:510:3c::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.14; Tue, 26 Apr
 2022 15:06:33 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::318c:d02:2280:c2c]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::318c:d02:2280:c2c%7]) with mapi id 15.20.5186.021; Tue, 26 Apr 2022
 15:06:33 +0000
From:   Liam Howlett <liam.howlett@oracle.com>
To:     "maple-tree@lists.infradead.org" <maple-tree@lists.infradead.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Yu Zhao <yuzhao@google.com>
Subject: [PATCH v8 15/70] kernel/fork: use maple tree for dup_mmap() during
 forking
Thread-Topic: [PATCH v8 15/70] kernel/fork: use maple tree for dup_mmap()
 during forking
Thread-Index: AQHYWX82/u4fkqjRKEewkG+ecezqUg==
Date:   Tue, 26 Apr 2022 15:06:32 +0000
Message-ID: <20220426150616.3937571-16-Liam.Howlett@oracle.com>
References: <20220426150616.3937571-1-Liam.Howlett@oracle.com>
In-Reply-To: <20220426150616.3937571-1-Liam.Howlett@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.35.1
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: d94e16d4-9331-434b-c3dc-08da279659d0
x-ms-traffictypediagnostic: PH0PR10MB4679:EE_
x-microsoft-antispam-prvs: <PH0PR10MB4679142590BDF15E4729CB71FDFB9@PH0PR10MB4679.namprd10.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ukUXt8YWTWx0couaBrrNPXRDC2h/cSrjJ+t9pPMlxRdojNtKgQpw90qfq+NBwYmPquM5IzetSs+yb3UWiOKaHEQOzBYSDHgkVc/+0Ztbk6p05S3JKf8QW1ejna6FD1XTJtqLNyHT/8KGr5/Iz/+i2K/z8bHNhKPzEHHOagmP0R+JZwuPJTeJnS2J9/onFASwa73kBtlZtpSpCpmGQcp6rIGeydaUz7Tez2I3YzgRY9NGJqlriFraxw8KVa9Jq+FR5HjdkEZ7TFGWvVhgfV9nixxU/M9bqLXG3QHknTTeWh1OSLbtUIk1fyUB+ogKeL9J6P2Xp6SxWhumiF2qRdp+xEiMY4dioMbplyxAwByMJWVX7AZf/oaDdkE3n5/pgs1hywEjZGxH45KN36yz5bPqxEYDkcJlgDjX0eJdoiDAkp3n6m3+WkPmoGhHkjQM5FJt74RoUfCcfh6pNX59B7tMeCdVYumNgseuiQznW9W1b19j8eUluAZoMiomRZ485BKf3b77jxbu+1oeOeXHGGlCeWu4GPQyBbF7zMgLM1CCdmgLsTW5XZ312q0YkzR4ownLzGsk9hUH06x1bY10fmsELOdEp8NzWRihSEobF+Yp2BSJaIR4nLiEnyWRKxp3fGm9gTdn8AGqPt0B4zbvs4tTyrmjMlwMyqRV3D2BHgCY/nsfOAQIv6BoU1Y7GuiU6h3+0mOHQPJ2IQmXUJs3DWsYEQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(86362001)(5660300002)(66476007)(38070700005)(316002)(2616005)(122000001)(38100700002)(83380400001)(2906002)(66556008)(76116006)(66946007)(66446008)(64756008)(91956017)(8936002)(44832011)(6512007)(186003)(26005)(1076003)(71200400001)(110136005)(6506007)(6486002)(508600001)(36756003)(8676002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?5H1qz5W2qUI9zomtvScqFSMpIeowXblj0GEyOSNrc5hf0kvl1rDnW/f2nf?=
 =?iso-8859-1?Q?Pp9v1BFLDX8Kfvb4G+CElpFNSKn1qGs0jHC0e73bCgvP0l4+bvN1WNDSdG?=
 =?iso-8859-1?Q?iqfZ05wpERymMKeyaeOd5VF/FAKJON6rD2Owbw2zrrll9lfxT3ETtqEmwn?=
 =?iso-8859-1?Q?YGuoOr3yqMD2PmpX+Y4wZ7rVTLvOPdlrIC/ngIqgfUvX9I427PwRBpXCQq?=
 =?iso-8859-1?Q?B/0ZL+hHhs+7t7Y/qz1GBT1YMMt1XAOna2hHr0aBeNnee12QXkLS3IMJVs?=
 =?iso-8859-1?Q?r2gWPhyjdB2/uswueYnlcb+jVTpcFxMxiWodEm4lQqG9KVRzgSj1l3hA/K?=
 =?iso-8859-1?Q?gTktPwgixFU6vEwqpvmy/cFtl3VlUdw1WlyEDsrsRq0H8kVuJ5qySY0BfP?=
 =?iso-8859-1?Q?7NIRsSWIVJ+itK+NJpI+rf1Wt1cuZublE8Ez7NLG3siD7+Izgr0WxE0Lk9?=
 =?iso-8859-1?Q?+ssO7JIj4Oehx01aa0M/djUTFwycToBX0cVN5vJtTxlJelOEy2f1cuB1OQ?=
 =?iso-8859-1?Q?vEOemd9Ahgb4xxVMAEJftf+T2oiGRjX2uCXGIcgLN8XjDud4ufJ9ULnZpL?=
 =?iso-8859-1?Q?NGnhXCQh6pbXOOzP28Ih0+jTD9qztaiIx0XOCpVSUpHhH1mznPvhdinbCg?=
 =?iso-8859-1?Q?MbcwPhSmqL7CyoJ7BN26BXCPvOBK8P8Scuy1++03huQEWlFtnkas98w2mP?=
 =?iso-8859-1?Q?a/BUJsIc5IiDkmLn3sGZyaCFHD2yL4BexMh8QSJhdTd4gbuOgZTzwwTE4i?=
 =?iso-8859-1?Q?GrEenFZyWRCD2aorGOiWqP4E1W7UiMsG+xT2TqoKsrBx5qZPoBptYfnXvX?=
 =?iso-8859-1?Q?qUiwp40zzq+omUrV1WfXno80W2NkdyagKQaqgrGWw5tKqgNc5nf7XKc5t2?=
 =?iso-8859-1?Q?oZbFMmTcXlwj7KMWy3xzxGgsVEtagDvh4jft9+3Ap/lHD5gxpw9RdAhvYE?=
 =?iso-8859-1?Q?x+vBOvQEwxhB/Ojy1h3wep72Yju3gyU/2prYV3vPi3Fyjv/HzarSiXV9Bq?=
 =?iso-8859-1?Q?lIBQzl9FKiVpjbl9/yg1gtHkn8iwhovdsE5bZ4snQIMIjb+5dQbuH0DaU0?=
 =?iso-8859-1?Q?Wx7GLbdoDNS815adDHiaPPp4y192zL49QYDZ42qFJf0XlJHr+aW6GsR+dB?=
 =?iso-8859-1?Q?pbNtPhWxVt1L2iDWgMoOu1clSRxa8rA6KzkKxeeSh5EIZVOZlkcb9BmPNB?=
 =?iso-8859-1?Q?CR3GQ04q2NymL1/OVPziZ81Il49ngVk8TWkAJo2iOuPTOzZhrQ7Fb+NR2P?=
 =?iso-8859-1?Q?ZVXzkr2ZfDv0qB862IgKj/mhC/EMug0CXwsAXkrkaJ6FF7q/SDUTZu9MKi?=
 =?iso-8859-1?Q?miOdgmYL5czNf4lpqDoFeMDMF9dfMhYKclgN3EEJFMepVHJ+Na3BJj9Y4y?=
 =?iso-8859-1?Q?45wSF9z7XsHrC9v/U3/ZAgC4B21zKcN1sM2p5jAdnvN/uAzw48rvehPMMY?=
 =?iso-8859-1?Q?PUDz7zw20fXx6+DTzuxFRrKP9h+RYPCu1cryRoNr277h9m+iLX2HSuOWc+?=
 =?iso-8859-1?Q?0J63/Cfuj7Bi1ag7ZOKPP7LkzW4T6c+Ndb52PLqKeYbnLJLZ/73hiUdKFS?=
 =?iso-8859-1?Q?tqNt6Fz2yTRkvAAtASRbSFTJYwaDbxCZMGmcGraPTaovEFwjcJdcINLfTa?=
 =?iso-8859-1?Q?Q1kru+JA9kjcjLTaSZwHDk0Al+O2TR5VGAZ8Pp5f3CjjtEd7I7eqqIL+gM?=
 =?iso-8859-1?Q?k2SbLINCTd/c0MmwQ21wirIGfWjpJjoPSwUO/BL7TqGO2xXuYZvSYk0CuJ?=
 =?iso-8859-1?Q?R5fekoQTYAFfeReP7W/7igFHE0Qrs1QqkTPfQ4cQNT+h2zOpOjoZ2uCQ3p?=
 =?iso-8859-1?Q?qaEhy9HZ7eqImcyWwFhRPLAD0AzN8f8=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d94e16d4-9331-434b-c3dc-08da279659d0
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Apr 2022 15:06:32.0216
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: BzlmR9//l/0slAj66Qhupc3oABjBfMT+1a3KE2JAqLrCSysjfKWjqITwX1hvLHaeOw8S5nhByUKmc2BMHpuYYg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB4679
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.486,18.0.858
 definitions=2022-04-26_04:2022-04-26,2022-04-26 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 mlxlogscore=990 mlxscore=0
 suspectscore=0 malwarescore=0 spamscore=0 adultscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2202240000
 definitions=main-2204260096
X-Proofpoint-ORIG-GUID: BrPXtR_3YndeSPdTbpZBISV6tOz10ezW
X-Proofpoint-GUID: BrPXtR_3YndeSPdTbpZBISV6tOz10ezW
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Liam R. Howlett" <Liam.Howlett@Oracle.com>

The maple tree was already tracking VMAs in this function by an earlier
commit, but the rbtree iterator was being used to iterate the list.
Change the iterator to use a maple tree native iterator and switch to the
maple tree advanced API to avoid multiple walks of the tree during insert
operations.  Unexport the now-unused vma_store() function.

For performance reasons we bulk allocate the maple tree nodes.  The node
calculations are done internally to the tree and use the VMA count and
assume the worst-case node requirements.  The VM_DONT_COPY flag does not
allow for the most efficient copy method of the tree and so a bulk loading
algorithm is used.

Signed-off-by: Liam R. Howlett <Liam.Howlett@Oracle.com>
Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
Acked-by: Vlastimil Babka <vbabka@suse.cz>
---
 include/linux/mm.h |  2 --
 kernel/fork.c      | 24 ++++++++++++++++++------
 mm/mmap.c          |  2 +-
 3 files changed, 19 insertions(+), 9 deletions(-)

diff --git a/include/linux/mm.h b/include/linux/mm.h
index 2c639b0a9853..046b3d44e298 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -2610,8 +2610,6 @@ extern bool arch_has_descending_max_zone_pfns(void);
 /* nommu.c */
 extern atomic_long_t mmap_pages_allocated;
 extern int nommu_shrink_inode_mappings(struct inode *, size_t, size_t);
-/* mmap.c */
-void vma_store(struct mm_struct *mm, struct vm_area_struct *vma);
=20
 /* interval_tree.c */
 void vma_interval_tree_insert(struct vm_area_struct *node,
diff --git a/kernel/fork.c b/kernel/fork.c
index c81993dff42c..6420b9500caf 100644
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -583,7 +583,9 @@ static __latent_entropy int dup_mmap(struct mm_struct *=
mm,
 	struct vm_area_struct *mpnt, *tmp, *prev, **pprev;
 	struct rb_node **rb_link, *rb_parent;
 	int retval;
-	unsigned long charge;
+	unsigned long charge =3D 0;
+	MA_STATE(old_mas, &oldmm->mm_mt, 0, 0);
+	MA_STATE(mas, &mm->mm_mt, 0, 0);
 	LIST_HEAD(uf);
=20
 	uprobe_start_dup_mmap();
@@ -617,7 +619,12 @@ static __latent_entropy int dup_mmap(struct mm_struct =
*mm,
 		goto out;
=20
 	prev =3D NULL;
-	for (mpnt =3D oldmm->mmap; mpnt; mpnt =3D mpnt->vm_next) {
+
+	retval =3D mas_expected_entries(&mas, oldmm->map_count);
+	if (retval)
+		goto out;
+
+	mas_for_each(&old_mas, mpnt, ULONG_MAX) {
 		struct file *file;
=20
 		if (mpnt->vm_flags & VM_DONTCOPY) {
@@ -631,7 +638,7 @@ static __latent_entropy int dup_mmap(struct mm_struct *=
mm,
 		 */
 		if (fatal_signal_pending(current)) {
 			retval =3D -EINTR;
-			goto out;
+			goto loop_out;
 		}
 		if (mpnt->vm_flags & VM_ACCOUNT) {
 			unsigned long len =3D vma_pages(mpnt);
@@ -697,7 +704,9 @@ static __latent_entropy int dup_mmap(struct mm_struct *=
mm,
 		rb_parent =3D &tmp->vm_rb;
=20
 		/* Link the vma into the MT */
-		vma_store(mm, tmp);
+		mas.index =3D tmp->vm_start;
+		mas.last =3D tmp->vm_end - 1;
+		mas_store(&mas, tmp);
=20
 		mm->map_count++;
 		if (!(tmp->vm_flags & VM_WIPEONFORK))
@@ -707,10 +716,13 @@ static __latent_entropy int dup_mmap(struct mm_struct=
 *mm,
 			tmp->vm_ops->open(tmp);
=20
 		if (retval)
-			goto out;
+			goto loop_out;
+
 	}
 	/* a new mm has just been created */
 	retval =3D arch_dup_mmap(oldmm, mm);
+loop_out:
+	mas_destroy(&mas);
 out:
 	mmap_write_unlock(mm);
 	flush_tlb_mm(oldmm);
@@ -726,7 +738,7 @@ static __latent_entropy int dup_mmap(struct mm_struct *=
mm,
 fail_nomem:
 	retval =3D -ENOMEM;
 	vm_unacct_memory(charge);
-	goto out;
+	goto loop_out;
 }
=20
 static inline int mm_alloc_pgd(struct mm_struct *mm)
diff --git a/mm/mmap.c b/mm/mmap.c
index c496814f440c..44b5e73dcfa1 100644
--- a/mm/mmap.c
+++ b/mm/mmap.c
@@ -759,7 +759,7 @@ static inline void vma_mt_szero(struct mm_struct *mm, u=
nsigned long start,
  * @mm: The struct_mm
  * @vma: The vm_area_struct to store in the maple tree.
  */
-void vma_store(struct mm_struct *mm, struct vm_area_struct *vma)
+static void vma_store(struct mm_struct *mm, struct vm_area_struct *vma)
 {
 	MA_STATE(mas, &mm->mm_mt, 0, 0);
=20
--=20
2.35.1
