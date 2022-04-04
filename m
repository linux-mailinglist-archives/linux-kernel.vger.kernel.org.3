Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 58E604F1741
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Apr 2022 16:40:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378147AbiDDOlf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Apr 2022 10:41:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378001AbiDDOjH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Apr 2022 10:39:07 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C5C93F8B2
        for <linux-kernel@vger.kernel.org>; Mon,  4 Apr 2022 07:36:30 -0700 (PDT)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 234Dj3YP024447;
        Mon, 4 Apr 2022 14:36:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : subject :
 date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=oK0ImbEJTd2V2uCvo8kyJM73bPFmJc0hclUt2kEwjCE=;
 b=Ict6vW/Twcs+8uQMG+WMRwdPvvNd7dWFKkE/fFPbErhUo5oE48gbz7acR5khMa7KfUma
 K9EcWa4UGOMrsp9bYp/4HeZKjNA1LQxDjQ//yXR8k+ckPAlpuFOWfGAW1uqCM5vCQklK
 Dzv5i7nu/EE3bAeIKUqCQ3VuhPGRCTo6C9lXP5Y41TX+8Ip4rDdR5Ikr0w6z5sUplWIw
 aCe05b2PVmfX8ksFzkRaa4MyWqJbX1aWIz9UOnRzwcM41RRoGPmcxw+R5KDeOhMRx350
 k+tT+5XQRCQP73gm301pXxhSthrXjr6rjAtXxTFZMhnjjVhpJRWPgDugTcQLmBoKwmW6 Ig== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com with ESMTP id 3f6f1t3cv1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 04 Apr 2022 14:36:25 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 234EGcGA027665;
        Mon, 4 Apr 2022 14:36:24 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2176.outbound.protection.outlook.com [104.47.56.176])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com with ESMTP id 3f6cx2gn5h-5
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 04 Apr 2022 14:36:24 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RgVuzd7CrnpTQJVGt0VOza7KuE/01Wf+VS5JF8XFyGDDylRQDLXzb/5s597htPjSWp5q6ZTDUpatPwk9GqTDqfEdIzjka/676E1hVK7WOThhXZcqi7Ilr2iHEcxjKfwq1i1GkUaJr5DAWQbuHnu3fe0B/gdsJaReeLmJrf04cJN0DMzvKEIuQfvN4jrntOsA0bzV8zd6FZG+kYgVK+TwDVhe1iKtP64EQRRSbX7rC0yF4405V/oA2lSFKq6J+V2g6LZ7i0E5sOMuxezuEFYLFra1KmC+N1KjYZpMxTl965dBIajxQSjjshT/nUFgJEdOlhpqoc7owv7JP4ko8CwfAQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oK0ImbEJTd2V2uCvo8kyJM73bPFmJc0hclUt2kEwjCE=;
 b=ioYxHTXviiJc5xOvIhWeXK4xBWtlBEZvJxwxz8G5Wzs04m/VMRK3TbVmPzTyQrORDGKZTxQly0pH75AKasYJYIvMTb+trZWxghITl+DGQSc1R6045eqX2OYNhGR11B3Vm803rWsvhQ3u2fiRNcFOAqTyNnVX4Z8BR13Gak7Es88uQcTHNHKmaL54uTDJMWsiSgJt0I2n9ICfQszoJnwWa8Tb6nyWDxF+PegYL08VVUdvlrm9nrxr8Ne/n9Dkq0EhgxDzgr3yLjMMeCVg8fted2Mo47keYlRvqqnf8LdYNntqZcmo4Jw2f+gREF2Eq3nD7SEb39YB+mOJh27Ti00/7w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oK0ImbEJTd2V2uCvo8kyJM73bPFmJc0hclUt2kEwjCE=;
 b=Qz0CQib324YsDpE2+t7T76unbFffiqd4l6Wmk6A3RwA+Z0G6nXPMQSR4+K3MaExAVBQg/moZNxd991LHACqh3jGdfYpD7lh6Oy30OSjpiofabhsa3X6xdfdpHqKu0XMIFBt7LAyLuNowf4KZ5Ip37ZOkWpc4krKD/llD/6e/MBY=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by CY4PR10MB1381.namprd10.prod.outlook.com (2603:10b6:903:29::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5123.31; Mon, 4 Apr
 2022 14:36:20 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::74fd:df41:4c93:24a5]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::74fd:df41:4c93:24a5%6]) with mapi id 15.20.5123.031; Mon, 4 Apr 2022
 14:36:20 +0000
From:   Liam Howlett <liam.howlett@oracle.com>
To:     "maple-tree@lists.infradead.org" <maple-tree@lists.infradead.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH v7 34/70] powerpc: Remove mmap linked list walks
Thread-Topic: [PATCH v7 34/70] powerpc: Remove mmap linked list walks
Thread-Index: AQHYSDFFlSPUP89GskKeKTPvQccdIg==
Date:   Mon, 4 Apr 2022 14:35:46 +0000
Message-ID: <20220404143501.2016403-35-Liam.Howlett@oracle.com>
References: <20220404143501.2016403-1-Liam.Howlett@oracle.com>
In-Reply-To: <20220404143501.2016403-1-Liam.Howlett@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.34.1
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: cbe25e34-efa7-4edd-05e7-08da16487c8a
x-ms-traffictypediagnostic: CY4PR10MB1381:EE_
x-microsoft-antispam-prvs: <CY4PR10MB1381934E0F3C06D78554866FFDE59@CY4PR10MB1381.namprd10.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: WCh6O+9g4rxVrX1qUDLUJM7PLJqxSa6oN1Egi6DBU3sC0QWiKdbn/O+Xwv8ZOiUrmEizaum4JX6kVWJWqlyQwGSx+nFV9xFXwgqYdiUVkV/j2cLo0yt7tHs3qyNkVCvAOu07ToYSgyDXuC/CpGz5snqa1KOwyZ9bnaDtgabeJFaVseE8UFueoC4eq32YupmSrLJXr7DEU2woj+p5T3Y+fSZIYNX1ScsdpmS7y31rmM7VyqrBGc5B7uezXnQI69kY0N2l8WAvN9beYT4rakggiUuVtbiq1F0oI0Wv1QhXgmi/h6AtD9tHKuhLIN4Baf+S3r0LXUA8Ph+5nyngX9xAtg3N724I6naHUZrCRdFYYjc4LiEtxIzCjqzNI6qezyatU5Get6hqholzksLWWXsFqO2rIZloq4KHGuzdOdLkDQighIDIwS2QlZNYzwipStTWYlxkMW9HkOFYk7ZL4iNg9mw774WdiM5IqHmHtxsZqLbu8Ihhen910gWPRtVFWilOnHEUhOUTPkt+Rhp0PMaes0mp2z+1KW+BAc/gmt0hLgPGdy/fzTNqzlMEBv0zvt+PusUBbMJbaTKuaKf4C0n4xZhhFPfZdZEGdXYqoq2aDfZXU36e4pNu+1n4teWCJdz7ihKpMvLIKoGFfq4M5jIHHfKF5Ju5DU/dxpCG+OAG93odbgT/Gwotx9AVIsOScQOyOB7P1BF39YKlBF63bEu/Bg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(122000001)(6506007)(6666004)(2906002)(66446008)(66946007)(110136005)(66556008)(66476007)(36756003)(8676002)(76116006)(91956017)(64756008)(6512007)(316002)(71200400001)(5660300002)(2616005)(38070700005)(38100700002)(1076003)(83380400001)(186003)(508600001)(26005)(8936002)(86362001)(6486002)(44832011);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?QUcY9TKuoxeQ+ZLfnnR8SaR64uzcUW8/7Cm2RZznHwAA/z4uYs7KFsKIYl?=
 =?iso-8859-1?Q?vJI8vq8UEfWjxlDzIORVhBDZSrDgoez5ZTui1/wg3hkaQ0+64R3JRoPlt5?=
 =?iso-8859-1?Q?/Kp3WFkn9i6L+lEBX0UrOoykRkfzEIB24+AT26ZjN1P0KMMg1XfHJB9863?=
 =?iso-8859-1?Q?rOwmwJRQBc55BrODvfSgkmj7bxa0YtU7QKWeFd1mHSD9CV1UZSGER3gHQM?=
 =?iso-8859-1?Q?Gez+9rgZQUlq3Hw+5nKV++GeZWzUgw/+Egs0uS2TCioUq3FidpQOjce6nS?=
 =?iso-8859-1?Q?Kkek0PGVto1PeQHD+ZW9yGZ6wggw0vmRdIOL2esKnWocx8rPB7fKuauG2o?=
 =?iso-8859-1?Q?HPFoY/m23ohM6YCh61MeicXVIJN03FwRvF9Yosi+aOSxB+OsT12vkmyIL4?=
 =?iso-8859-1?Q?5Ha6me3PyybbaFhY6JNs8D3rf7dTfNbnQ3fqhBrcpfcEnGD/4dnDFoX9mP?=
 =?iso-8859-1?Q?TbSoyICsCsrEw7/hhvVWzvaT8eNp9qAjV10DQS0PcvhgW2AKHNcyB1MPjk?=
 =?iso-8859-1?Q?lltz42Kgysz2bx3rYDOS52IoCP0LobB+LUikpO46VmBTMszhP9+uK5Wm0E?=
 =?iso-8859-1?Q?2/6QdQyNw24WAtwUxBS/jumWN6VJ0ksZcZKhozwQSrbYjlKRrFJtCf20t4?=
 =?iso-8859-1?Q?HMTQ4C+dCt5+dDIj6Nxnaa60pRcQzIFaO60L1g6IlDlhZcgUFoU9y2pcz0?=
 =?iso-8859-1?Q?MwT/R8rzNBvyHT9uWePEmmsWbBQtV88k7h6Lu21/2sfnkVWkIJ2ggLUqiH?=
 =?iso-8859-1?Q?6zpTyMGrVX8ciJpwehwBHFxtbUE54OOB9e2/HMqi9PqO1luauboy6V3QqD?=
 =?iso-8859-1?Q?GyIikBvKfLwEXMGppJayVfKVGMr6QmV6nFcT9NeDlzbRMymdGqc7AH0Emy?=
 =?iso-8859-1?Q?Asd+SGo/sK7ujMuD+nEjKqyJWyZ5lgPijHhk55Ch5mHPDsgibQQ6AtYe/M?=
 =?iso-8859-1?Q?scxG7L9cMX6MFSoRM3zeCuuv5qejKh/44e6D79nwu/f+qAvOb82M56CV6G?=
 =?iso-8859-1?Q?8IaUDwMktPqzl9sfZrvBD4OU2/vZrW0Y7dRaXld1Pvsa46fu91elJ8RRXi?=
 =?iso-8859-1?Q?P1G1Zsui++eRTL9otSKDSQbt55NnefQbfvVa2L71kZ2L5bj+o0tyZm+Er9?=
 =?iso-8859-1?Q?ECDdDClL/IuyCMWXoE4BqcIU4UOL2ULuEv1gGmqkeN+iTRfwK3hF43lSCF?=
 =?iso-8859-1?Q?yHJ67IFKnpdMj00inrl8mIkBVWGLA1NuPusqLA6NsvD2mrs1bI9hl5yUqc?=
 =?iso-8859-1?Q?utrWRjaEjKkoCLrscegzU1VHbW12qNcrcJAaZOFqGEz7pZcfCjSAHIMl70?=
 =?iso-8859-1?Q?A3jV0yi/rnEZDskNSM5GNa3UgRZJOW0oBq6IZ8BG4bmp3Vjo2n8xl/kGgJ?=
 =?iso-8859-1?Q?siZAx1VkN/NLJBG7it1Oxpsegk0n4HInDWZjT0ECWnySjseK2XSj+fY6jN?=
 =?iso-8859-1?Q?ZRFWAeGZZRnNT2QXnNkI1yvRkm2ISMAf1mczTOT/hsj/9yftbG1Rhtr3vR?=
 =?iso-8859-1?Q?vqVWPjJTDIl36K3nHykgwnb2fZ6ovC0mk9zXyrVzGpmlG+/McCVP66IXCT?=
 =?iso-8859-1?Q?lVSVHQnrR2sbums4wI1weyxKU67DFp9oadNLggzLWyvzvtV/Ia2T7+9aMo?=
 =?iso-8859-1?Q?7L9e+X6Lz96lpsTXkaAiO7uK48keByFwP5ErRY3P4ITB5qe9o7DAEd1l4k?=
 =?iso-8859-1?Q?sbweNbcNeFrGxF8Ru+j2wIDfxvNT2cTePeh58nqtFi3aEN1c7X3/rqsHDb?=
 =?iso-8859-1?Q?CdgHRcKZSLihI+zpMNrQtgJhFdF68xuIznfm91AEZX1YydqJwd+TRv4ytG?=
 =?iso-8859-1?Q?RnlLQQER4eJWKsyyDFDHEz+BfE5UbuQ=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cbe25e34-efa7-4edd-05e7-08da16487c8a
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Apr 2022 14:35:46.6590
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: jOEmwSG9fBDtjS0CfPwvC/9aAPL51VfQn+OnjIkn54xUQCL22xpOE410MgICvAURvL5OZEsF/BzZTxR0Fy00IA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR10MB1381
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.425,18.0.850
 definitions=2022-04-04_05:2022-03-30,2022-04-04 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 spamscore=0 adultscore=0
 bulkscore=0 mlxlogscore=999 phishscore=0 suspectscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2202240000
 definitions=main-2204040082
X-Proofpoint-ORIG-GUID: GDIx5PlVn57aFc_BfgEFBmFhso1Io3yT
X-Proofpoint-GUID: GDIx5PlVn57aFc_BfgEFBmFhso1Io3yT
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Liam R. Howlett" <Liam.Howlett@Oracle.com>

Use the VMA iterator instead.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
Signed-off-by: Liam R. Howlett <Liam.Howlett@Oracle.com>
Reviewed-by: Vlastimil Babka <vbabka@suse.cz>
---
 arch/powerpc/kernel/vdso.c              |  6 +++---
 arch/powerpc/mm/book3s32/tlb.c          | 11 ++++++-----
 arch/powerpc/mm/book3s64/subpage_prot.c | 13 ++-----------
 3 files changed, 11 insertions(+), 19 deletions(-)

diff --git a/arch/powerpc/kernel/vdso.c b/arch/powerpc/kernel/vdso.c
index 717f2c9a7573..f70db911e061 100644
--- a/arch/powerpc/kernel/vdso.c
+++ b/arch/powerpc/kernel/vdso.c
@@ -114,18 +114,18 @@ struct vdso_data *arch_get_vdso_data(void *vvar_page)
 int vdso_join_timens(struct task_struct *task, struct time_namespace *ns)
 {
 	struct mm_struct *mm =3D task->mm;
+	VMA_ITERATOR(vmi, mm, 0);
 	struct vm_area_struct *vma;
=20
 	mmap_read_lock(mm);
-
-	for (vma =3D mm->mmap; vma; vma =3D vma->vm_next) {
+	for_each_vma(vmi, vma) {
 		unsigned long size =3D vma->vm_end - vma->vm_start;
=20
 		if (vma_is_special_mapping(vma, &vvar_spec))
 			zap_page_range(vma, vma->vm_start, size);
 	}
-
 	mmap_read_unlock(mm);
+
 	return 0;
 }
=20
diff --git a/arch/powerpc/mm/book3s32/tlb.c b/arch/powerpc/mm/book3s32/tlb.=
c
index 19f0ef950d77..9ad6b56bfec9 100644
--- a/arch/powerpc/mm/book3s32/tlb.c
+++ b/arch/powerpc/mm/book3s32/tlb.c
@@ -81,14 +81,15 @@ EXPORT_SYMBOL(hash__flush_range);
 void hash__flush_tlb_mm(struct mm_struct *mm)
 {
 	struct vm_area_struct *mp;
+	VMA_ITERATOR(vmi, mm, 0);
=20
 	/*
-	 * It is safe to go down the mm's list of vmas when called
-	 * from dup_mmap, holding mmap_lock.  It would also be safe from
-	 * unmap_region or exit_mmap, but not from vmtruncate on SMP -
-	 * but it seems dup_mmap is the only SMP case which gets here.
+	 * It is safe to iterate the vmas when called from dup_mmap,
+	 * holding mmap_lock.  It would also be safe from unmap_region
+	 * or exit_mmap, but not from vmtruncate on SMP - but it seems
+	 * dup_mmap is the only SMP case which gets here.
 	 */
-	for (mp =3D mm->mmap; mp !=3D NULL; mp =3D mp->vm_next)
+	for_each_vma(vmi, mp)
 		hash__flush_range(mp->vm_mm, mp->vm_start, mp->vm_end);
 }
 EXPORT_SYMBOL(hash__flush_tlb_mm);
diff --git a/arch/powerpc/mm/book3s64/subpage_prot.c b/arch/powerpc/mm/book=
3s64/subpage_prot.c
index 60c6ea16a972..d73b3b4176e8 100644
--- a/arch/powerpc/mm/book3s64/subpage_prot.c
+++ b/arch/powerpc/mm/book3s64/subpage_prot.c
@@ -149,24 +149,15 @@ static void subpage_mark_vma_nohuge(struct mm_struct =
*mm, unsigned long addr,
 				    unsigned long len)
 {
 	struct vm_area_struct *vma;
+	VMA_ITERATOR(vmi, mm, addr);
=20
 	/*
 	 * We don't try too hard, we just mark all the vma in that range
 	 * VM_NOHUGEPAGE and split them.
 	 */
-	vma =3D find_vma(mm, addr);
-	/*
-	 * If the range is in unmapped range, just return
-	 */
-	if (vma && ((addr + len) <=3D vma->vm_start))
-		return;
-
-	while (vma) {
-		if (vma->vm_start >=3D (addr + len))
-			break;
+	for_each_vma_range(vmi, vma, addr + len) {
 		vma->vm_flags |=3D VM_NOHUGEPAGE;
 		walk_page_vma(vma, &subpage_walk_ops, NULL);
-		vma =3D vma->vm_next;
 	}
 }
 #else
--=20
2.34.1
