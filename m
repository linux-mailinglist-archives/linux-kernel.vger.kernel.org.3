Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C03C3519341
	for <lists+linux-kernel@lfdr.de>; Wed,  4 May 2022 03:18:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245127AbiEDBVO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 May 2022 21:21:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245353AbiEDBTB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 May 2022 21:19:01 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B8434348A
        for <linux-kernel@vger.kernel.org>; Tue,  3 May 2022 18:14:53 -0700 (PDT)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 243Li9Ug025194;
        Wed, 4 May 2022 01:14:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : subject :
 date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=GSgt18qY67EAL+pqJaGWuSqF9mRrvnNRwdJ5VRZz3Ws=;
 b=kskQV1DKG1Nqrt1XHrEC+LA4prCHMkB+aJC875Ug3aeN4mdXadLlLlLsRYSBK9gNbUVG
 jXpdteFVAkfOxWfRoIJdjxOnQeJLBm7fy9dt68SuPuMB1W7D32UMXa7Tuo54lhBgt0WC
 5ZnTzE/kzPMAWKilJsCIDgSzSofkB2YQq2Pn2UM6/4x2alOsNQwm/Nx7mXYx3pKtPET/
 n59fil0zAHQclmuOcP7Zxhr2PlR/Q7WzFI/mGp1OYW+ljDONlgd2fkLRY6rYPmsEtg9y
 dVYSCcradespkcHp2oeogbYIAhKslpcR0ZfX7OAsB+8YPEe0KPEYyeuDcosbO7+c6dwy KA== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3fruw2f6cg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 04 May 2022 01:14:46 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 2441BJT6001264;
        Wed, 4 May 2022 01:14:46 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2045.outbound.protection.outlook.com [104.47.66.45])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com with ESMTP id 3fs1a57vyf-6
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 04 May 2022 01:14:45 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nR1Dz6zTEnz+O1X5OkTbPtM7aN4xRB/DjwwpoSkivueZE8FkYRZdk0rXx0rKO6Pjfq/n6hUlmaT6EAv5QvvaAUmz4ANx/T0buD+YNKgAUzJaUqKznI+eTQCEwrNQ0UjHIdjPCUKFZJWp50lFHvXo5YhmP9LsZhe/0kjwVozdqdRiMZc7CGFO0rsMwfvSmVBIs/bY7g1qZrr8Rxdi8CSW1ogjJ5pgxJwcLRMi4/G6ReqasG1oCU2+gcD0uh78BQFAXMJHc8CyT88IKRGgrC0VcWQpZRRRfqKqjf5/nCTmosn+dgrR4DUxG2dbRDktGc/XWZjqPqU1gFt8ycoTWkoA2Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GSgt18qY67EAL+pqJaGWuSqF9mRrvnNRwdJ5VRZz3Ws=;
 b=a1aUdAs0QI3ypkyAa6MnLTp9B1gTlIywvtVCNgkhf9JLolZYmO1JBjILnnjU/6IwwFcKT5Wo1qJYs16TcVycQm7suNEgQ1HbsZkjkuczbaSoXdyS6vLJhntnkzClYad+r4qbQUAKFQO79me1oCE1lUn5PJZ/aBQoKvIoUP7ZMiDScCNhLAuE13iP3lMvVGU57zIpHayy69I28sAgZ6hmR0A5JQQOBBqiIEZND/Wp3bI8gwKUTeNw9PtKOlw2KFd/WYducKI4ycQ1KT8K5+ZpaGYEfhUDI6LKZc7SYHHkpn24SxvKKKA/gaITUX6y0O0FDZu6lp9VKeu6uxMmffEXuQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GSgt18qY67EAL+pqJaGWuSqF9mRrvnNRwdJ5VRZz3Ws=;
 b=r0rfQcwR7n8VLTSQSDwv8AzhDW3LvZ+2t47cYBkRVMdIMjtFZfXFKybPET4tsS1w0YRvruJdfHSvz1rlRtOMMOtfs2eEIC6YXOsx06TEQYB4szltl0M4A7NOJR8rkwvnbt+B3x3Ew062+K+987KoWHNmyd31qFoWLVVXOaAu/jg=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by SN6PR10MB2688.namprd10.prod.outlook.com (2603:10b6:805:4e::31) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5206.13; Wed, 4 May
 2022 01:14:42 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::318c:d02:2280:c2c]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::318c:d02:2280:c2c%7]) with mapi id 15.20.5206.024; Wed, 4 May 2022
 01:14:42 +0000
From:   Liam Howlett <liam.howlett@oracle.com>
To:     "maple-tree@lists.infradead.org" <maple-tree@lists.infradead.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH v9 67/69] mm: remove the vma linked list
Thread-Topic: [PATCH v9 67/69] mm: remove the vma linked list
Thread-Index: AQHYX1RAzsqg1aBYqkCXJCPO8HO1iw==
Date:   Wed, 4 May 2022 01:14:07 +0000
Message-ID: <20220504011345.662299-52-Liam.Howlett@oracle.com>
References: <20220504002554.654642-1-Liam.Howlett@oracle.com>
 <20220504011345.662299-1-Liam.Howlett@oracle.com>
In-Reply-To: <20220504011345.662299-1-Liam.Howlett@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.35.1
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 1496eb45-b858-4aa9-acd9-08da2d6b77f1
x-ms-traffictypediagnostic: SN6PR10MB2688:EE_
x-microsoft-antispam-prvs: <SN6PR10MB26888B906B9A99F11CAF534EFDC39@SN6PR10MB2688.namprd10.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: /Py8XYKswh5NO/IRX0rRn/+q1h4pk8PVibqZ6IXYh2CZp7X5rVAQhWuy/tdWAIJOaoJy1swSzRl3xqfzb74XSBF1ZI1RGM0Y6TcVdWTiRMrsjoNKkNYVcHa/t2CZ10In427x7SA8Tzz9Op4s8hgIOY6EpIfnssXtoLpya27UhwtJYZW/9p9uVaTUnCZd3Tfy4LGFHS7DbVy4ekQBPCDtffkTeoivOTf8X2cx7TVlMGrOQqtirr2ds10IfxC/41MZQsnOF/y+NVDEvGnB7lVpWbpfBHrhU2l42KxiDcT5OSHRKW0Mnkw/KJeKFldlqeBfQ67bSXLl6O84DFxOYNaEZsEGOq1PqHzXZ3es0K7tEzBf1Nk5lli5meFolfIgwxKp4/9cwtLBUNpUPfaScb1fEwvCZFtlXs9NnCFi4x/rtqMhsDpgL04DasFVArtJaa7zj70e7QcDwFXIRCX91sV7Rmq5pbYsaHEllH/mTYTUgDkNhDXqvE4K2V9QSqPJarxvAzXf1Y7m8dgQKTncFR918C2ZBSdqbiBEvJcNlqUjiIQn5Hup+4u8P7/WkOQa35We5iAWmWtRRs+LRNJJ+EwWqJOjVKQrjUyMx7PAKTSVmCUZQ6HwW095e/gLbfcmMkVNmxlUI0JAi5d2AMO/CKx1BvvlGEb5s6CWqc1sI/xX8KSiG6PdGLXpd/794+p4k8f3UGnxcuBrCfbZqIk7pzocBg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(186003)(122000001)(1076003)(2616005)(66476007)(8676002)(66446008)(64756008)(38070700005)(36756003)(316002)(38100700002)(66556008)(66946007)(76116006)(91956017)(110136005)(26005)(6512007)(71200400001)(8936002)(6666004)(6506007)(2906002)(30864003)(86362001)(5660300002)(6486002)(508600001)(83380400001)(44832011)(559001)(579004);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?DW81b8Qr51iF22Xd+usfzJlMpGZXlIUjWH8tOJkySiKwvvZRb2dLUJt2IX?=
 =?iso-8859-1?Q?OCrqU0nl2AZgR2GEkmlG8udwTL54RqET5aBUVsJTlXnaE8g8P2iQE317NK?=
 =?iso-8859-1?Q?mCac/MJJIfPpvxW7E4zB2fz9ffDBh/X7jbIgAMev23iX1Sb8R6NYFpRfjR?=
 =?iso-8859-1?Q?uWvbjGjUEae8xFtMmnzagp4EvMFpNZDxA/72GLTBI1DgZs9r5V17YTfTIa?=
 =?iso-8859-1?Q?NpF6idzz6Xh1wtkFbLSaDkp/9y0drKk4h6JHsCAkjfrEohOnDEEpxQHBwg?=
 =?iso-8859-1?Q?NznX8wr6n/Lldrv1v3UXmaWgXDMdr/GHCFK16WbQQQuyjMyltIO0u7EQM+?=
 =?iso-8859-1?Q?eZk8ObT9UH+hbUchSWh6OoPtAHN62uu+N73w0AuQartns1jCaLEGya5rwN?=
 =?iso-8859-1?Q?LHiC4inN7wHxlh5eJ/T1b/8hhQ9PgRwny/M2IXbz4o8XnBYUg1G4TzT/C1?=
 =?iso-8859-1?Q?eF+IX8QegTqligjtU6iPJ7UelF/G0RTpPSQJ2rQrXZoyX51sE0U+lQjMlN?=
 =?iso-8859-1?Q?8sWYVa57+Ih9hDaQEYPL6Y4moEQIpN3IHlH0Ttge98omYBB+TfWery10Wj?=
 =?iso-8859-1?Q?Zs6rGyeoGbGAbB/UJ3cKpNOMfdLoyUroxU1xoqru1iJMbO2cNrH4yb29cV?=
 =?iso-8859-1?Q?GgHkKinOKJc/44FgYy8VFGbl+nDwIZbYucAp4oOaZoWKHBh33PbXojlgv6?=
 =?iso-8859-1?Q?CPKJ/pjQ5ndrfyWmPZL+m9UcZMZ4YOZSXklu1Dvks6FGNJXgbpQ9k7orvI?=
 =?iso-8859-1?Q?ldYxN9xiJb6YrcBBQ/UTMrVMlXPeqjUF7Ux/4X2iBR1qatrDOCMoRE3o1M?=
 =?iso-8859-1?Q?YW2+o97/O6MKYmghSczDN6NBKZBGMCP2yRIyqEDl8w+dRDUBuibuQsy2Lg?=
 =?iso-8859-1?Q?uaZ2FnRkhKppXb6DLhtX/uHOwyAolo39n+AI5+3Ko583a+/jP6gD6bvmj2?=
 =?iso-8859-1?Q?x5uB3TOFLiBus0HrhSVxd4b6CLITonJA4VEFK7g+vOmUlCzWhlDu8uN+xH?=
 =?iso-8859-1?Q?KnrEpqNsonk0w4QoaJz4IdxzCf8TTFNn6t/AjKwrJEeak8ztcmr0aKqS2e?=
 =?iso-8859-1?Q?dKr2ITp1CUQj3mnbqZCPMs60KwAMAoCwSGDle7XmOpkoma4glnnCtCS4oe?=
 =?iso-8859-1?Q?3TOmWuAjAJawLO5VXVzsj9nbiAWUzX2s91pWxb0zFDpVFeh/6drR1BESyN?=
 =?iso-8859-1?Q?yA0Q/3ek0Eg2gwjlUWavu5zVy1JmiEE7nBySpuMWO41J8V12Disi/vgroy?=
 =?iso-8859-1?Q?quG1Wppw/b31y+813/0NHR6Ncm57bl4BhSG9NzScz10cPIcbzIsNnABvc2?=
 =?iso-8859-1?Q?s6Clb/ydA5HoSKNrQdLQ5Bwm3nRURGjdT8TnvkR32qMshdVB8xKjZyxila?=
 =?iso-8859-1?Q?A25NAmZ0aML+o0IXiWIvAZIjJWeS9BR6JpOw2dri6P6iEAFk7PzYKyr7Hu?=
 =?iso-8859-1?Q?veLw68n1PI2reLOoJvKC2KITcwNwow1IR3QkSJprk0nIcT6vADtzJtiwlY?=
 =?iso-8859-1?Q?/u0VHnRhjHvOK8VikMoiUPDwxT2fHU0nu1+/PVSfJ+VO8YMjZe26OV4pJI?=
 =?iso-8859-1?Q?Yu4asOfFmF0KDF7nF7nPH2e/TCXIqLhDh3fbt8/Lql5pevzo5aA3mROc0N?=
 =?iso-8859-1?Q?xyoCKStOIKf0HRpe0GwFDnnV+IOFZmuU/qoFv8vqpDr6mIyUQhssWGsl0v?=
 =?iso-8859-1?Q?K6aVP2jxW4YneAs1/gIrwmmkR65Vfv5qIut6PHyMG17TbShkRtvEZlkjEe?=
 =?iso-8859-1?Q?+NEP7JsY9JvaV36dlQ8SU2TwehxOULyWJYKBamRdh/ipE3uqq6XzO93S7P?=
 =?iso-8859-1?Q?OrDfZzbjZsk5iSkJLGvMTJvzfQItPqk=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1496eb45-b858-4aa9-acd9-08da2d6b77f1
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 May 2022 01:14:07.5322
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: I/h0nozQN2HPrp7CHL33wjsXDbVekGszOspC3DYp3HJQ5qqceT0KCrfYNl+Zw/NzQcl50JnrpspHAB7BXkUqSw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR10MB2688
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.486,18.0.858
 definitions=2022-05-03_10:2022-05-02,2022-05-03 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 bulkscore=0 malwarescore=0
 spamscore=0 mlxlogscore=999 mlxscore=0 suspectscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2202240000
 definitions=main-2205040006
X-Proofpoint-GUID: qpkrTeYrFTPttEFt2tA9cfCpFEOqaIm7
X-Proofpoint-ORIG-GUID: qpkrTeYrFTPttEFt2tA9cfCpFEOqaIm7
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Liam R. Howlett" <Liam.Howlett@Oracle.com>

Replace any vm_next use with vma_find().

Update free_pgtables(), unmap_vmas(), and zap_page_range() to use the
maple tree.

Use the new free_pgtables() and unmap_vmas() in do_mas_align_munmap().  At
the same time, alter the loop to be more compact.

Now that free_pgtables() and unmap_vmas() take a maple tree as an
argument, rearrange do_mas_align_munmap() to use the new tree to hold the
vmas to remove.

Remove __vma_link_list() and __vma_unlink_list() as they are exclusively
used to update the linked list

Drop linked list update from __insert_vm_struct().

Rework validation of tree as it was depending on the linked list.

Signed-off-by: Liam R. Howlett <Liam.Howlett@Oracle.com>
---
 include/linux/mm.h       |   5 +-
 include/linux/mm_types.h |   4 -
 kernel/fork.c            |  19 +-
 mm/debug.c               |  14 +-
 mm/internal.h            |   8 +-
 mm/memory.c              |  33 ++-
 mm/mmap.c                | 439 +++++++++++++++++----------------------
 mm/nommu.c               |   5 -
 mm/util.c                |  40 ----
 9 files changed, 223 insertions(+), 344 deletions(-)

diff --git a/include/linux/mm.h b/include/linux/mm.h
index 0cc2cb692a78..f16bf2c017ab 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -1867,8 +1867,9 @@ void zap_vma_ptes(struct vm_area_struct *vma, unsigne=
d long address,
 		  unsigned long size);
 void zap_page_range(struct vm_area_struct *vma, unsigned long address,
 		    unsigned long size);
-void unmap_vmas(struct mmu_gather *tlb, struct vm_area_struct *start_vma,
-		unsigned long start, unsigned long end);
+void unmap_vmas(struct mmu_gather *tlb, struct maple_tree *mt,
+		struct vm_area_struct *start_vma, unsigned long start,
+		unsigned long end);
=20
 struct mmu_notifier_range;
=20
diff --git a/include/linux/mm_types.h b/include/linux/mm_types.h
index b844119387a3..bdc5d0a5e76d 100644
--- a/include/linux/mm_types.h
+++ b/include/linux/mm_types.h
@@ -398,8 +398,6 @@ struct vm_area_struct {
 	unsigned long vm_end;		/* The first byte after our end address
 					   within vm_mm. */
=20
-	/* linked list of VM areas per task, sorted by address */
-	struct vm_area_struct *vm_next, *vm_prev;
 	struct mm_struct *vm_mm;	/* The address space we belong to. */
=20
 	/*
@@ -463,7 +461,6 @@ struct vm_area_struct {
 struct kioctx_table;
 struct mm_struct {
 	struct {
-		struct vm_area_struct *mmap;		/* list of VMAs */
 		struct maple_tree mm_mt;
 #ifdef CONFIG_MMU
 		unsigned long (*get_unmapped_area) (struct file *filp,
@@ -478,7 +475,6 @@ struct mm_struct {
 		unsigned long mmap_compat_legacy_base;
 #endif
 		unsigned long task_size;	/* size of task vm space */
-		unsigned long highest_vm_end;	/* highest vma end address */
 		pgd_t * pgd;
=20
 #ifdef CONFIG_MEMBARRIER
diff --git a/kernel/fork.c b/kernel/fork.c
index 9fcbd0b5c0be..536dc3289734 100644
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -474,7 +474,6 @@ struct vm_area_struct *vm_area_dup(struct vm_area_struc=
t *orig)
 		 */
 		*new =3D data_race(*orig);
 		INIT_LIST_HEAD(&new->anon_vma_chain);
-		new->vm_next =3D new->vm_prev =3D NULL;
 		dup_anon_vma_name(orig, new);
 	}
 	return new;
@@ -579,7 +578,7 @@ static void dup_mm_exe_file(struct mm_struct *mm, struc=
t mm_struct *oldmm)
 static __latent_entropy int dup_mmap(struct mm_struct *mm,
 					struct mm_struct *oldmm)
 {
-	struct vm_area_struct *mpnt, *tmp, *prev, **pprev;
+	struct vm_area_struct *mpnt, *tmp;
 	int retval;
 	unsigned long charge =3D 0;
 	MA_STATE(old_mas, &oldmm->mm_mt, 0, 0);
@@ -606,7 +605,6 @@ static __latent_entropy int dup_mmap(struct mm_struct *=
mm,
 	mm->exec_vm =3D oldmm->exec_vm;
 	mm->stack_vm =3D oldmm->stack_vm;
=20
-	pprev =3D &mm->mmap;
 	retval =3D ksm_fork(mm, oldmm);
 	if (retval)
 		goto out;
@@ -614,12 +612,6 @@ static __latent_entropy int dup_mmap(struct mm_struct =
*mm,
 	if (retval)
 		goto out;
=20
-	retval =3D mas_expected_entries(&mas, oldmm->map_count);
-	if (retval)
-		goto out;
-
-	prev =3D NULL;
-
 	retval =3D mas_expected_entries(&mas, oldmm->map_count);
 	if (retval)
 		goto out;
@@ -691,14 +683,6 @@ static __latent_entropy int dup_mmap(struct mm_struct =
*mm,
 		if (is_vm_hugetlb_page(tmp))
 			reset_vma_resv_huge_pages(tmp);
=20
-		/*
-		 * Link in the new vma and copy the page table entries.
-		 */
-		*pprev =3D tmp;
-		pprev =3D &tmp->vm_next;
-		tmp->vm_prev =3D prev;
-		prev =3D tmp;
-
 		/* Link the vma into the MT */
 		mas.index =3D tmp->vm_start;
 		mas.last =3D tmp->vm_end - 1;
@@ -1115,7 +1099,6 @@ static void mm_init_uprobes_state(struct mm_struct *m=
m)
 static struct mm_struct *mm_init(struct mm_struct *mm, struct task_struct =
*p,
 	struct user_namespace *user_ns)
 {
-	mm->mmap =3D NULL;
 	mt_init_flags(&mm->mm_mt, MM_MT_FLAGS);
 	mt_set_external_lock(&mm->mm_mt, &mm->mmap_lock);
 	atomic_set(&mm->mm_users, 1);
diff --git a/mm/debug.c b/mm/debug.c
index 2d625ca0e326..0fd15ba70d16 100644
--- a/mm/debug.c
+++ b/mm/debug.c
@@ -139,13 +139,11 @@ EXPORT_SYMBOL(dump_page);
=20
 void dump_vma(const struct vm_area_struct *vma)
 {
-	pr_emerg("vma %px start %px end %px\n"
-		"next %px prev %px mm %px\n"
+	pr_emerg("vma %px start %px end %px mm %px\n"
 		"prot %lx anon_vma %px vm_ops %px\n"
 		"pgoff %lx file %px private_data %px\n"
 		"flags: %#lx(%pGv)\n",
-		vma, (void *)vma->vm_start, (void *)vma->vm_end, vma->vm_next,
-		vma->vm_prev, vma->vm_mm,
+		vma, (void *)vma->vm_start, (void *)vma->vm_end, vma->vm_mm,
 		(unsigned long)pgprot_val(vma->vm_page_prot),
 		vma->anon_vma, vma->vm_ops, vma->vm_pgoff,
 		vma->vm_file, vma->vm_private_data,
@@ -155,11 +153,11 @@ EXPORT_SYMBOL(dump_vma);
=20
 void dump_mm(const struct mm_struct *mm)
 {
-	pr_emerg("mm %px mmap %px task_size %lu\n"
+	pr_emerg("mm %px task_size %lu\n"
 #ifdef CONFIG_MMU
 		"get_unmapped_area %px\n"
 #endif
-		"mmap_base %lu mmap_legacy_base %lu highest_vm_end %lu\n"
+		"mmap_base %lu mmap_legacy_base %lu\n"
 		"pgd %px mm_users %d mm_count %d pgtables_bytes %lu map_count %d\n"
 		"hiwater_rss %lx hiwater_vm %lx total_vm %lx locked_vm %lx\n"
 		"pinned_vm %llx data_vm %lx exec_vm %lx stack_vm %lx\n"
@@ -183,11 +181,11 @@ void dump_mm(const struct mm_struct *mm)
 		"tlb_flush_pending %d\n"
 		"def_flags: %#lx(%pGv)\n",
=20
-		mm, mm->mmap, mm->task_size,
+		mm, mm->task_size,
 #ifdef CONFIG_MMU
 		mm->get_unmapped_area,
 #endif
-		mm->mmap_base, mm->mmap_legacy_base, mm->highest_vm_end,
+		mm->mmap_base, mm->mmap_legacy_base,
 		mm->pgd, atomic_read(&mm->mm_users),
 		atomic_read(&mm->mm_count),
 		mm_pgtables_bytes(mm),
diff --git a/mm/internal.h b/mm/internal.h
index ddd09245a6db..fe33cb47935b 100644
--- a/mm/internal.h
+++ b/mm/internal.h
@@ -69,8 +69,9 @@ void folio_rotate_reclaimable(struct folio *folio);
 bool __folio_end_writeback(struct folio *folio);
 void deactivate_file_folio(struct folio *folio);
=20
-void free_pgtables(struct mmu_gather *tlb, struct vm_area_struct *start_vm=
a,
-		unsigned long floor, unsigned long ceiling);
+void free_pgtables(struct mmu_gather *tlb, struct maple_tree *mt,
+		   struct vm_area_struct *start_vma, unsigned long floor,
+		   unsigned long ceiling);
 void pmd_install(struct mm_struct *mm, pmd_t *pmd, pgtable_t *pte);
=20
 struct zap_details;
@@ -458,9 +459,6 @@ static inline bool is_data_mapping(vm_flags_t flags)
 }
=20
 /* mm/util.c */
-void __vma_link_list(struct mm_struct *mm, struct vm_area_struct *vma,
-		struct vm_area_struct *prev);
-void __vma_unlink_list(struct mm_struct *mm, struct vm_area_struct *vma);
 struct anon_vma *folio_anon_vma(struct folio *folio);
=20
 #ifdef CONFIG_MMU
diff --git a/mm/memory.c b/mm/memory.c
index e873a6143181..9e5b3ab8f7c0 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -399,12 +399,21 @@ void free_pgd_range(struct mmu_gather *tlb,
 	} while (pgd++, addr =3D next, addr !=3D end);
 }
=20
-void free_pgtables(struct mmu_gather *tlb, struct vm_area_struct *vma,
-		unsigned long floor, unsigned long ceiling)
+void free_pgtables(struct mmu_gather *tlb, struct maple_tree *mt,
+		   struct vm_area_struct *vma, unsigned long floor,
+		   unsigned long ceiling)
 {
-	while (vma) {
-		struct vm_area_struct *next =3D vma->vm_next;
+	MA_STATE(mas, mt, vma->vm_end, vma->vm_end);
+
+	do {
 		unsigned long addr =3D vma->vm_start;
+		struct vm_area_struct *next;
+
+		/*
+		 * Note: USER_PGTABLES_CEILING may be passed as ceiling and may
+		 * be 0.  This will underflow and is okay.
+		 */
+		next =3D mas_find(&mas, ceiling - 1);
=20
 		/*
 		 * Hide vma from rmap and truncate_pagecache before freeing
@@ -423,7 +432,7 @@ void free_pgtables(struct mmu_gather *tlb, struct vm_ar=
ea_struct *vma,
 			while (next && next->vm_start <=3D vma->vm_end + PMD_SIZE
 			       && !is_vm_hugetlb_page(next)) {
 				vma =3D next;
-				next =3D vma->vm_next;
+				next =3D mas_find(&mas, ceiling - 1);
 				unlink_anon_vmas(vma);
 				unlink_file_vma(vma);
 			}
@@ -431,7 +440,7 @@ void free_pgtables(struct mmu_gather *tlb, struct vm_ar=
ea_struct *vma,
 				floor, next ? next->vm_start : ceiling);
 		}
 		vma =3D next;
-	}
+	} while (vma);
 }
=20
 void pmd_install(struct mm_struct *mm, pmd_t *pmd, pgtable_t *pte)
@@ -1632,17 +1641,19 @@ static void unmap_single_vma(struct mmu_gather *tlb=
,
  * ensure that any thus-far unmapped pages are flushed before unmap_vmas()
  * drops the lock and schedules.
  */
-void unmap_vmas(struct mmu_gather *tlb,
+void unmap_vmas(struct mmu_gather *tlb, struct maple_tree *mt,
 		struct vm_area_struct *vma, unsigned long start_addr,
 		unsigned long end_addr)
 {
 	struct mmu_notifier_range range;
+	MA_STATE(mas, mt, vma->vm_end, vma->vm_end);
=20
 	mmu_notifier_range_init(&range, MMU_NOTIFY_UNMAP, 0, vma, vma->vm_mm,
 				start_addr, end_addr);
 	mmu_notifier_invalidate_range_start(&range);
-	for ( ; vma && vma->vm_start < end_addr; vma =3D vma->vm_next)
+	do {
 		unmap_single_vma(tlb, vma, start_addr, end_addr, NULL);
+	} while ((vma =3D mas_find(&mas, end_addr - 1)) !=3D NULL);
 	mmu_notifier_invalidate_range_end(&range);
 }
=20
@@ -1657,8 +1668,11 @@ void unmap_vmas(struct mmu_gather *tlb,
 void zap_page_range(struct vm_area_struct *vma, unsigned long start,
 		unsigned long size)
 {
+	struct maple_tree *mt =3D &vma->vm_mm->mm_mt;
+	unsigned long end =3D start + size;
 	struct mmu_notifier_range range;
 	struct mmu_gather tlb;
+	MA_STATE(mas, mt, vma->vm_end, vma->vm_end);
=20
 	lru_add_drain();
 	mmu_notifier_range_init(&range, MMU_NOTIFY_CLEAR, 0, vma, vma->vm_mm,
@@ -1666,8 +1680,9 @@ void zap_page_range(struct vm_area_struct *vma, unsig=
ned long start,
 	tlb_gather_mmu(&tlb, vma->vm_mm);
 	update_hiwater_rss(vma->vm_mm);
 	mmu_notifier_invalidate_range_start(&range);
-	for ( ; vma && vma->vm_start < range.end; vma =3D vma->vm_next)
+	do {
 		unmap_single_vma(&tlb, vma, start, range.end, NULL);
+	} while ((vma =3D mas_find(&mas, end - 1)) !=3D NULL);
 	mmu_notifier_invalidate_range_end(&range);
 	tlb_finish_mmu(&tlb);
 }
diff --git a/mm/mmap.c b/mm/mmap.c
index 572a2a474b49..7704c879bc6d 100644
--- a/mm/mmap.c
+++ b/mm/mmap.c
@@ -75,9 +75,10 @@ int mmap_rnd_compat_bits __read_mostly =3D CONFIG_ARCH_M=
MAP_RND_COMPAT_BITS;
 static bool ignore_rlimit_data;
 core_param(ignore_rlimit_data, ignore_rlimit_data, bool, 0644);
=20
-static void unmap_region(struct mm_struct *mm,
+static void unmap_region(struct mm_struct *mm, struct maple_tree *mt,
 		struct vm_area_struct *vma, struct vm_area_struct *prev,
-		unsigned long start, unsigned long end);
+		struct vm_area_struct *next, unsigned long start,
+		unsigned long end);
=20
 /* description of effects of mapping type and prot in current implementati=
on.
  * this is due to the limited x86 page protection hardware.  The expected
@@ -177,12 +178,10 @@ void unlink_file_vma(struct vm_area_struct *vma)
 }
=20
 /*
- * Close a vm structure and free it, returning the next.
+ * Close a vm structure and free it.
  */
-static struct vm_area_struct *remove_vma(struct vm_area_struct *vma)
+static void remove_vma(struct vm_area_struct *vma)
 {
-	struct vm_area_struct *next =3D vma->vm_next;
-
 	might_sleep();
 	if (vma->vm_ops && vma->vm_ops->close)
 		vma->vm_ops->close(vma);
@@ -190,7 +189,6 @@ static struct vm_area_struct *remove_vma(struct vm_area=
_struct *vma)
 		fput(vma->vm_file);
 	mpol_put(vma_policy(vma));
 	vm_area_free(vma);
-	return next;
 }
=20
 /*
@@ -215,8 +213,7 @@ static int do_brk_munmap(struct ma_state *mas, struct v=
m_area_struct *vma,
 			 unsigned long newbrk, unsigned long oldbrk,
 			 struct list_head *uf);
 static int do_brk_flags(struct ma_state *mas, struct vm_area_struct *brkvm=
a,
-			unsigned long addr, unsigned long request,
-			unsigned long flags);
+		unsigned long addr, unsigned long request, unsigned long flags);
 SYSCALL_DEFINE1(brk, unsigned long, brk)
 {
 	unsigned long newbrk, oldbrk, origbrk;
@@ -285,7 +282,6 @@ SYSCALL_DEFINE1(brk, unsigned long, brk)
 		 * before calling do_brk_munmap().
 		 */
 		mm->brk =3D brk;
-		mas.last =3D oldbrk - 1;
 		ret =3D do_brk_munmap(&mas, brkvma, newbrk, oldbrk, &uf);
 		if (ret =3D=3D 1)  {
 			downgraded =3D true;
@@ -340,42 +336,20 @@ extern void mt_dump(const struct maple_tree *mt);
 static void validate_mm_mt(struct mm_struct *mm)
 {
 	struct maple_tree *mt =3D &mm->mm_mt;
-	struct vm_area_struct *vma_mt, *vma =3D mm->mmap;
+	struct vm_area_struct *vma_mt;
=20
 	MA_STATE(mas, mt, 0, 0);
-	mas_for_each(&mas, vma_mt, ULONG_MAX) {
-		if (xa_is_zero(vma_mt))
-			continue;
-
-		if (!vma)
-			break;
=20
-		if ((vma !=3D vma_mt) ||
-		    (vma->vm_start !=3D vma_mt->vm_start) ||
-		    (vma->vm_end !=3D vma_mt->vm_end) ||
-		    (vma->vm_start !=3D mas.index) ||
-		    (vma->vm_end - 1 !=3D mas.last)) {
+	mas_for_each(&mas, vma_mt, ULONG_MAX) {
+		if ((vma_mt->vm_start !=3D mas.index) ||
+		    (vma_mt->vm_end - 1 !=3D mas.last)) {
 			pr_emerg("issue in %s\n", current->comm);
 			dump_stack();
 			dump_vma(vma_mt);
-			pr_emerg("and vm_next\n");
-			dump_vma(vma->vm_next);
 			pr_emerg("mt piv: %px %lu - %lu\n", vma_mt,
 				 mas.index, mas.last);
 			pr_emerg("mt vma: %px %lu - %lu\n", vma_mt,
 				 vma_mt->vm_start, vma_mt->vm_end);
-			if (vma->vm_prev) {
-				pr_emerg("ll prev: %px %lu - %lu\n",
-					 vma->vm_prev, vma->vm_prev->vm_start,
-					 vma->vm_prev->vm_end);
-			}
-			pr_emerg("ll vma: %px %lu - %lu\n", vma,
-				 vma->vm_start, vma->vm_end);
-			if (vma->vm_next) {
-				pr_emerg("ll next: %px %lu - %lu\n",
-					 vma->vm_next, vma->vm_next->vm_start,
-					 vma->vm_next->vm_end);
-			}
=20
 			mt_dump(mas.tree);
 			if (vma_mt->vm_end !=3D mas.last + 1) {
@@ -392,11 +366,7 @@ static void validate_mm_mt(struct mm_struct *mm)
 			}
 			VM_BUG_ON_MM(vma_mt->vm_start !=3D mas.index, mm);
 		}
-		VM_BUG_ON(vma !=3D vma_mt);
-		vma =3D vma->vm_next;
-
 	}
-	VM_BUG_ON(vma);
 	mt_validate(&mm->mm_mt);
 }
=20
@@ -404,12 +374,12 @@ static void validate_mm(struct mm_struct *mm)
 {
 	int bug =3D 0;
 	int i =3D 0;
-	unsigned long highest_address =3D 0;
-	struct vm_area_struct *vma =3D mm->mmap;
+	struct vm_area_struct *vma;
+	MA_STATE(mas, &mm->mm_mt, 0, 0);
=20
 	validate_mm_mt(mm);
=20
-	while (vma) {
+	mas_for_each(&mas, vma, ULONG_MAX) {
 #ifdef CONFIG_DEBUG_VM_RB
 		struct anon_vma *anon_vma =3D vma->anon_vma;
 		struct anon_vma_chain *avc;
@@ -421,18 +391,10 @@ static void validate_mm(struct mm_struct *mm)
 			anon_vma_unlock_read(anon_vma);
 		}
 #endif
-
-		highest_address =3D vm_end_gap(vma);
-		vma =3D vma->vm_next;
 		i++;
 	}
 	if (i !=3D mm->map_count) {
-		pr_emerg("map_count %d vm_next %d\n", mm->map_count, i);
-		bug =3D 1;
-	}
-	if (highest_address !=3D mm->highest_vm_end) {
-		pr_emerg("mm->highest_vm_end %lx, found %lx\n",
-			  mm->highest_vm_end, highest_address);
+		pr_emerg("map_count %d mas_for_each %d\n", mm->map_count, i);
 		bug =3D 1;
 	}
 	VM_BUG_ON_MM(bug, mm);
@@ -492,29 +454,13 @@ bool range_has_overlap(struct mm_struct *mm, unsigned=
 long start,
 	struct vm_area_struct *existing;
=20
 	MA_STATE(mas, &mm->mm_mt, start, start);
+	rcu_read_lock();
 	existing =3D mas_find(&mas, end - 1);
 	*pprev =3D mas_prev(&mas, 0);
+	rcu_read_unlock();
 	return existing ? true : false;
 }
=20
-/*
- * __vma_next() - Get the next VMA.
- * @mm: The mm_struct.
- * @vma: The current vma.
- *
- * If @vma is NULL, return the first vma in the mm.
- *
- * Returns: The next VMA after @vma.
- */
-static inline struct vm_area_struct *__vma_next(struct mm_struct *mm,
-					 struct vm_area_struct *vma)
-{
-	if (!vma)
-		return mm->mmap;
-
-	return vma->vm_next;
-}
-
 static unsigned long count_vma_pages_range(struct mm_struct *mm,
 		unsigned long addr, unsigned long end)
 {
@@ -599,8 +545,7 @@ static inline void vma_mas_szero(struct ma_state *mas, =
unsigned long start,
 	mas_store_prealloc(mas, NULL);
 }
=20
-static int vma_link(struct mm_struct *mm, struct vm_area_struct *vma,
-			struct vm_area_struct *prev)
+static int vma_link(struct mm_struct *mm, struct vm_area_struct *vma)
 {
 	MA_STATE(mas, &mm->mm_mt, 0, 0);
 	struct address_space *mapping =3D NULL;
@@ -614,7 +559,6 @@ static int vma_link(struct mm_struct *mm, struct vm_are=
a_struct *vma,
 	}
=20
 	vma_mas_store(vma, &mas);
-	__vma_link_list(mm, vma, prev);
 	__vma_link_file(vma);
=20
 	if (mapping)
@@ -625,22 +569,6 @@ static int vma_link(struct mm_struct *mm, struct vm_ar=
ea_struct *vma,
 	return 0;
 }
=20
-/*
- * Helper for vma_adjust() in the split_vma insert case: insert a vma into=
 the
- * mm's list and the mm tree.  It has already been inserted into the inter=
val tree.
- */
-static void __insert_vm_struct(struct mm_struct *mm, struct ma_state *mas,
-		struct vm_area_struct *vma, unsigned long location)
-{
-	struct vm_area_struct *prev;
-
-	mas_set(mas, location);
-	prev =3D mas_prev(mas, 0);
-	vma_mas_store(vma, mas);
-	__vma_link_list(mm, vma, prev);
-	mm->map_count++;
-}
-
 /*
  * vma_expand - Expand an existing VMA
  *
@@ -717,15 +645,8 @@ inline int vma_expand(struct ma_state *mas, struct vm_=
area_struct *vma,
 	}
=20
 	/* Expanding over the next vma */
-	if (remove_next) {
-		/* Remove from mm linked list - also updates highest_vm_end */
-		__vma_unlink_list(mm, next);
-
-		if (file)
-			__remove_shared_vm_struct(next, file, mapping);
-
-	} else if (!next) {
-		mm->highest_vm_end =3D vm_end_gap(vma);
+	if (remove_next && file) {
+		__remove_shared_vm_struct(next, file, mapping);
 	}
=20
 	if (anon_vma) {
@@ -782,7 +703,6 @@ int __vma_adjust(struct vm_area_struct *vma, unsigned l=
ong start,
 	int remove_next =3D 0;
 	MA_STATE(mas, &mm->mm_mt, 0, 0);
 	struct vm_area_struct *exporter =3D NULL, *importer =3D NULL;
-	unsigned long ll_prev =3D vma->vm_start; /* linked list prev. */
=20
 	if (next && !insert) {
 		if (end >=3D next->vm_end) {
@@ -828,7 +748,7 @@ int __vma_adjust(struct vm_area_struct *vma, unsigned l=
ong start,
 			 * next, if the vma overlaps with it.
 			 */
 			if (remove_next =3D=3D 2 && !next->anon_vma)
-				exporter =3D next->vm_next;
+				exporter =3D find_vma(mm, next->vm_end);
=20
 		} else if (end > next->vm_start) {
 			/*
@@ -927,17 +847,14 @@ int __vma_adjust(struct vm_area_struct *vma, unsigned=
 long start,
 		if (vma->vm_end > end) {
 			if (!insert || (insert->vm_start !=3D end)) {
 				vma_mas_szero(&mas, end, vma->vm_end);
+				mas_reset(&mas);
 				VM_WARN_ON(insert &&
 					   insert->vm_end < vma->vm_end);
-			} else if (insert->vm_start =3D=3D end) {
-				ll_prev =3D vma->vm_end;
 			}
 		} else {
 			vma_changed =3D true;
 		}
 		vma->vm_end =3D end;
-		if (!next)
-			mm->highest_vm_end =3D vm_end_gap(vma);
 	}
=20
 	if (vma_changed)
@@ -957,17 +874,17 @@ int __vma_adjust(struct vm_area_struct *vma, unsigned=
 long start,
 		flush_dcache_mmap_unlock(mapping);
 	}
=20
-	if (remove_next) {
-		__vma_unlink_list(mm, next);
-		if (file)
-			__remove_shared_vm_struct(next, file, mapping);
+	if (remove_next && file) {
+		__remove_shared_vm_struct(next, file, mapping);
 	} else if (insert) {
 		/*
 		 * split_vma has split insert from vma, and needs
 		 * us to insert it before dropping the locks
 		 * (it may either follow vma or precede it).
 		 */
-		__insert_vm_struct(mm, &mas, insert, ll_prev);
+		mas_reset(&mas);
+		vma_mas_store(insert, &mas);
+		mm->map_count++;
 	}
=20
 	if (anon_vma) {
@@ -1006,8 +923,8 @@ int __vma_adjust(struct vm_area_struct *vma, unsigned =
long start,
 			/*
 			 * If "next" was removed and vma->vm_end was
 			 * expanded (up) over it, in turn
-			 * "next->vm_prev->vm_end" changed and the
-			 * "vma->vm_next" gap must be updated.
+			 * "next->prev->vm_end" changed and the
+			 * "vma->next" gap must be updated.
 			 */
 			next =3D next_next;
 		} else {
@@ -1028,34 +945,15 @@ int __vma_adjust(struct vm_area_struct *vma, unsigne=
d long start,
 			remove_next =3D 1;
 			end =3D next->vm_end;
 			goto again;
-		} else if (!next) {
-			/*
-			 * If remove_next =3D=3D 2 we obviously can't
-			 * reach this path.
-			 *
-			 * If remove_next =3D=3D 3 we can't reach this
-			 * path because pre-swap() next is always not
-			 * NULL. pre-swap() "next" is not being
-			 * removed and its next->vm_end is not altered
-			 * (and furthermore "end" already matches
-			 * next->vm_end in remove_next =3D=3D 3).
-			 *
-			 * We reach this only in the remove_next =3D=3D 1
-			 * case if the "next" vma that was removed was
-			 * the highest vma of the mm. However in such
-			 * case next->vm_end =3D=3D "end" and the extended
-			 * "vma" has vma->vm_end =3D=3D next->vm_end so
-			 * mm->highest_vm_end doesn't need any update
-			 * in remove_next =3D=3D 1 case.
-			 */
-			VM_WARN_ON(mm->highest_vm_end !=3D vm_end_gap(vma));
 		}
 	}
-	if (insert && file)
+	if (insert && file) {
 		uprobe_mmap(insert);
+	}
=20
 	mas_destroy(&mas);
 	validate_mm(mm);
+
 	return 0;
 }
=20
@@ -1215,10 +1113,10 @@ struct vm_area_struct *vma_merge(struct mm_struct *=
mm,
 	if (vm_flags & VM_SPECIAL)
 		return NULL;
=20
-	next =3D __vma_next(mm, prev);
+	next =3D find_vma(mm, prev ? prev->vm_end : 0);
 	area =3D next;
 	if (area && area->vm_end =3D=3D end)		/* cases 6, 7, 8 */
-		next =3D next->vm_next;
+		next =3D find_vma(mm, next->vm_end);
=20
 	/* verify some invariant that must be enforced by the caller */
 	VM_WARN_ON(prev && addr <=3D prev->vm_start);
@@ -1352,18 +1250,24 @@ static struct anon_vma *reusable_anon_vma(struct vm=
_area_struct *old, struct vm_
  */
 struct anon_vma *find_mergeable_anon_vma(struct vm_area_struct *vma)
 {
+	MA_STATE(mas, &vma->vm_mm->mm_mt, vma->vm_end, vma->vm_end);
 	struct anon_vma *anon_vma =3D NULL;
+	struct vm_area_struct *prev, *next;
=20
 	/* Try next first. */
-	if (vma->vm_next) {
-		anon_vma =3D reusable_anon_vma(vma->vm_next, vma, vma->vm_next);
+	next =3D mas_walk(&mas);
+	if (next) {
+		anon_vma =3D reusable_anon_vma(next, vma, next);
 		if (anon_vma)
 			return anon_vma;
 	}
=20
+	prev =3D mas_prev(&mas, 0);
+	VM_BUG_ON_VMA(prev !=3D vma, vma);
+	prev =3D mas_prev(&mas, 0);
 	/* Try prev next. */
-	if (vma->vm_prev)
-		anon_vma =3D reusable_anon_vma(vma->vm_prev, vma->vm_prev, vma);
+	if (prev)
+		anon_vma =3D reusable_anon_vma(prev, prev, vma);
=20
 	/*
 	 * We might reach here with anon_vma =3D=3D NULL if we can't find
@@ -2112,8 +2016,8 @@ int expand_upwards(struct vm_area_struct *vma, unsign=
ed long address)
 	if (gap_addr < address || gap_addr > TASK_SIZE)
 		gap_addr =3D TASK_SIZE;
=20
-	next =3D vma->vm_next;
-	if (next && next->vm_start < gap_addr && vma_is_accessible(next)) {
+	next =3D find_vma_intersection(mm, vma->vm_end, gap_addr);
+	if (next && vma_is_accessible(next)) {
 		if (!(next->vm_flags & VM_GROWSUP))
 			return -ENOMEM;
 		/* Check that both stack segments have the same anon_vma? */
@@ -2164,8 +2068,6 @@ int expand_upwards(struct vm_area_struct *vma, unsign=
ed long address)
 				/* Overwrite old entry in mtree. */
 				vma_mas_store(vma, &mas);
 				anon_vma_interval_tree_post_update_vma(vma);
-				if (!vma->vm_next)
-					mm->highest_vm_end =3D vm_end_gap(vma);
 				spin_unlock(&mm->page_table_lock);
=20
 				perf_event_mmap(vma);
@@ -2184,16 +2086,16 @@ int expand_upwards(struct vm_area_struct *vma, unsi=
gned long address)
 int expand_downwards(struct vm_area_struct *vma, unsigned long address)
 {
 	struct mm_struct *mm =3D vma->vm_mm;
+	MA_STATE(mas, &mm->mm_mt, vma->vm_start, vma->vm_start);
 	struct vm_area_struct *prev;
 	int error =3D 0;
-	MA_STATE(mas, &mm->mm_mt, 0, 0);
=20
 	address &=3D PAGE_MASK;
 	if (address < mmap_min_addr)
 		return -EPERM;
=20
 	/* Enforce stack_guard_gap */
-	prev =3D vma->vm_prev;
+	prev =3D mas_prev(&mas, 0);
 	/* Check that both stack segments have the same anon_vma? */
 	if (prev && !(prev->vm_flags & VM_GROWSDOWN) &&
 			vma_is_accessible(prev)) {
@@ -2328,25 +2230,26 @@ find_extend_vma(struct mm_struct *mm, unsigned long=
 addr)
 EXPORT_SYMBOL_GPL(find_extend_vma);
=20
 /*
- * Ok - we have the memory areas we should free on the vma list,
- * so release them, and do the vma updates.
+ * Ok - we have the memory areas we should free on a maple tree so release=
 them,
+ * and do the vma updates.
  *
  * Called with the mm semaphore held.
  */
-static void remove_vma_list(struct mm_struct *mm, struct vm_area_struct *v=
ma)
+static inline void remove_mt(struct mm_struct *mm, struct ma_state *mas)
 {
 	unsigned long nr_accounted =3D 0;
+	struct vm_area_struct *vma;
=20
 	/* Update high watermark before we lower total_vm */
 	update_hiwater_vm(mm);
-	do {
+	mas_for_each(mas, vma, ULONG_MAX) {
 		long nrpages =3D vma_pages(vma);
=20
 		if (vma->vm_flags & VM_ACCOUNT)
 			nr_accounted +=3D nrpages;
 		vm_stat_account(mm, vma->vm_flags, -nrpages);
-		vma =3D remove_vma(vma);
-	} while (vma);
+		remove_vma(vma);
+	}
 	vm_unacct_memory(nr_accounted);
 	validate_mm(mm);
 }
@@ -2356,18 +2259,18 @@ static void remove_vma_list(struct mm_struct *mm, s=
truct vm_area_struct *vma)
  *
  * Called with the mm semaphore held.
  */
-static void unmap_region(struct mm_struct *mm,
+static void unmap_region(struct mm_struct *mm, struct maple_tree *mt,
 		struct vm_area_struct *vma, struct vm_area_struct *prev,
+		struct vm_area_struct *next,
 		unsigned long start, unsigned long end)
 {
-	struct vm_area_struct *next =3D __vma_next(mm, prev);
 	struct mmu_gather tlb;
=20
 	lru_add_drain();
 	tlb_gather_mmu(&tlb, mm);
 	update_hiwater_rss(mm);
-	unmap_vmas(&tlb, vma, start, end);
-	free_pgtables(&tlb, vma, prev ? prev->vm_end : FIRST_USER_ADDRESS,
+	unmap_vmas(&tlb, mt, vma, start, end);
+	free_pgtables(&tlb, mt, vma, prev ? prev->vm_end : FIRST_USER_ADDRESS,
 				 next ? next->vm_start : USER_PGTABLES_CEILING);
 	tlb_finish_mmu(&tlb);
 }
@@ -2451,24 +2354,13 @@ int split_vma(struct mm_struct *mm, struct vm_area_=
struct *vma,
 	return __split_vma(mm, vma, addr, new_below);
 }
=20
-static inline int
-unlock_range(struct vm_area_struct *start, struct vm_area_struct **tail,
-	     unsigned long limit)
+static inline void munmap_sidetree(struct vm_area_struct *vma,
+				   struct ma_state *mas_detach)
 {
-	struct mm_struct *mm =3D start->vm_mm;
-	struct vm_area_struct *tmp =3D start;
-	int count =3D 0;
-
-	while (tmp && tmp->vm_start < limit) {
-		*tail =3D tmp;
-		count++;
-		if (tmp->vm_flags & VM_LOCKED)
-			mm->locked_vm -=3D vma_pages(tmp);
-
-		tmp =3D tmp->vm_next;
-	}
-
-	return count;
+	mas_set_range(mas_detach, vma->vm_start, vma->vm_end - 1);
+	mas_store(mas_detach, vma);
+	if (vma->vm_flags & VM_LOCKED)
+		vma->vm_mm->locked_vm -=3D vma_pages(vma);
 }
=20
 /*
@@ -2488,13 +2380,20 @@ do_mas_align_munmap(struct ma_state *mas, struct vm=
_area_struct *vma,
 		    struct mm_struct *mm, unsigned long start,
 		    unsigned long end, struct list_head *uf, bool downgrade)
 {
-	struct vm_area_struct *prev, *last;
+	struct vm_area_struct *prev, *next =3D NULL;
+	struct maple_tree mt_detach;
+	int count =3D 0;
 	int error =3D -ENOMEM;
-	/* we have start < vma->vm_end  */
+	MA_STATE(mas_detach, &mt_detach, start, end - 1);
+	mt_init_flags(&mt_detach, MM_MT_FLAGS);
+	mt_set_external_lock(&mt_detach, &mm->mmap_lock);
=20
 	if (mas_preallocate(mas, vma, GFP_KERNEL))
 		return -ENOMEM;
=20
+	if (mas_preallocate(&mas_detach, vma, GFP_KERNEL))
+		return -ENOMEM;
+
 	mas->last =3D end - 1;
 	/*
 	 * If we need to split any vma, do it now to save pain later.
@@ -2503,6 +2402,8 @@ do_mas_align_munmap(struct ma_state *mas, struct vm_a=
rea_struct *vma,
 	 * unmapped vm_area_struct will remain in use: so lower split_vma
 	 * places tmp vma above, and higher split_vma places tmp vma below.
 	 */
+
+	/* Does it split the first one? */
 	if (start > vma->vm_start) {
=20
 		/*
@@ -2513,35 +2414,56 @@ do_mas_align_munmap(struct ma_state *mas, struct vm=
_area_struct *vma,
 		if (end < vma->vm_end && mm->map_count >=3D sysctl_max_map_count)
 			goto map_count_exceeded;
=20
+		/*
+		 * mas_pause() is not needed since mas->index needs to be set
+		 * differently than vma->vm_end anyways.
+		 */
 		error =3D __split_vma(mm, vma, start, 0);
 		if (error)
 			goto split_failed;
=20
-		prev =3D vma;
-		vma =3D __vma_next(mm, prev);
-		mas->index =3D start;
-		mas_reset(mas);
-	} else {
-		prev =3D vma->vm_prev;
+		mas_set(mas, start);
+		vma =3D mas_walk(mas);
 	}
=20
-	if (vma->vm_end >=3D end)
-		last =3D vma;
-	else
-		last =3D find_vma_intersection(mm, end - 1, end);
-
-	/* Does it split the last one? */
-	if (last && end < last->vm_end) {
-		error =3D __split_vma(mm, last, end, 1);
+	prev =3D mas_prev(mas, 0);
+	if (unlikely((!prev)))
+		mas_set(mas, start);
=20
-		if (error)
-			goto split_failed;
+	/*
+	 * Detach a range of VMAs from the mm. Using next as a temp variable as
+	 * it is always overwritten.
+	 */
+	mas_for_each(mas, next, end - 1) {
+		/* Does it split the end? */
+		if (next->vm_end > end) {
+			struct vm_area_struct *split;
=20
-		if (vma =3D=3D last)
-			vma =3D __vma_next(mm, prev);
-		mas_reset(mas);
+			error =3D __split_vma(mm, next, end, 1);
+			if (error)
+				goto split_failed;
+
+			mas_set(mas, end);
+			split =3D mas_prev(mas, 0);
+			munmap_sidetree(split, &mas_detach);
+			count++;
+			if (vma =3D=3D next)
+				vma =3D split;
+			break;
+		}
+		count++;
+		munmap_sidetree(next, &mas_detach);
+#ifdef CONFIG_DEBUG_VM_MAPLE_TREE
+		BUG_ON(next->vm_start < start);
+		BUG_ON(next->vm_start > end);
+#endif
 	}
=20
+	mas_destroy(&mas_detach);
+
+	if (!next)
+		next =3D mas_next(mas, ULONG_MAX);
+
 	if (unlikely(uf)) {
 		/*
 		 * If userfaultfd_unmap_prep returns an error the vmas
@@ -2558,35 +2480,36 @@ do_mas_align_munmap(struct ma_state *mas, struct vm=
_area_struct *vma,
 			goto userfaultfd_error;
 	}
=20
-	/*
-	 * unlock any mlock()ed ranges before detaching vmas, count the number
-	 * of VMAs to be dropped, and return the tail entry of the affected
-	 * area.
-	 */
-	mm->map_count -=3D unlock_range(vma, &last, end);
-	/* Drop removed area from the tree */
+	/* Point of no return */
+	mas_set_range(mas, start, end - 1);
+#if defined(CONFIG_DEBUG_VM_MAPLE_TREE)
+	/* Make sure no VMAs are about to be lost. */
+	{
+		MA_STATE(test, &mt_detach, start, end - 1);
+		struct vm_area_struct *vma_mas, *vma_test;
+		int test_count =3D 0;
+
+		rcu_read_lock();
+		vma_test =3D mas_find(&test, end - 1);
+		mas_for_each(mas, vma_mas, end - 1) {
+			BUG_ON(vma_mas !=3D vma_test);
+			test_count++;
+			vma_test =3D mas_next(&test, end - 1);
+		}
+		rcu_read_unlock();
+		BUG_ON(count !=3D test_count);
+		mas_set_range(mas, start, end - 1);
+	}
+#endif
 	mas_store_prealloc(mas, NULL);
-
-	/* Detach vmas from the MM linked list */
-	vma->vm_prev =3D NULL;
-	if (prev)
-		prev->vm_next =3D last->vm_next;
-	else
-		mm->mmap =3D last->vm_next;
-
-	if (last->vm_next) {
-		last->vm_next->vm_prev =3D prev;
-		last->vm_next =3D NULL;
-	} else
-		mm->highest_vm_end =3D prev ? vm_end_gap(prev) : 0;
-
+	mm->map_count -=3D count;
 	/*
 	 * Do not downgrade mmap_lock if we are next to VM_GROWSDOWN or
 	 * VM_GROWSUP VMA. Such VMAs can change their size under
 	 * down_read(mmap_lock) and collide with the VMA we are about to unmap.
 	 */
 	if (downgrade) {
-		if (last && (last->vm_flags & VM_GROWSDOWN))
+		if (next && (next->vm_flags & VM_GROWSDOWN))
 			downgrade =3D false;
 		else if (prev && (prev->vm_flags & VM_GROWSUP))
 			downgrade =3D false;
@@ -2594,10 +2517,12 @@ do_mas_align_munmap(struct ma_state *mas, struct vm=
_area_struct *vma,
 			mmap_write_downgrade(mm);
 	}
=20
-	unmap_region(mm, vma, prev, start, end);
-
-	/* Fix up all other VM information */
-	remove_vma_list(mm, vma);
+	unmap_region(mm, &mt_detach, vma, prev, next, start, end);
+	/* Statistics and freeing VMAs */
+	mas_set(&mas_detach, start);
+	remove_mt(mm, &mas_detach);
+	validate_mm(mm);
+	__mt_destroy(&mt_detach);
=20
=20
 	validate_mm(mm);
@@ -2838,7 +2763,6 @@ unsigned long mmap_region(struct file *file, unsigned=
 long addr,
 		i_mmap_lock_write(vma->vm_file->f_mapping);
=20
 	vma_mas_store(vma, &mas);
-	__vma_link_list(mm, vma, prev);
 	mm->map_count++;
 	if (vma->vm_file) {
 		if (vma->vm_flags & VM_SHARED)
@@ -2890,7 +2814,7 @@ unsigned long mmap_region(struct file *file, unsigned=
 long addr,
 	vma->vm_file =3D NULL;
=20
 	/* Undo any partial mapping done by a device driver. */
-	unmap_region(mm, vma, prev, vma->vm_start, vma->vm_end);
+	unmap_region(mm, mas.tree, vma, prev, next, vma->vm_start, vma->vm_end);
 	charged =3D 0;
 	if (vm_flags & VM_SHARED)
 		mapping_unmap_writable(file->f_mapping);
@@ -2979,11 +2903,12 @@ SYSCALL_DEFINE5(remap_file_pages, unsigned long, st=
art, unsigned long, size,
 		goto out;
=20
 	if (start + size > vma->vm_end) {
-		struct vm_area_struct *next;
+		VMA_ITERATOR(vmi, mm, vma->vm_end);
+		struct vm_area_struct *next, *prev =3D vma;
=20
-		for (next =3D vma->vm_next; next; next =3D next->vm_next) {
+		for_each_vma_range(vmi, next, start + size) {
 			/* hole between vmas ? */
-			if (next->vm_start !=3D next->vm_prev->vm_end)
+			if (next->vm_start !=3D prev->vm_end)
 				goto out;
=20
 			if (next->vm_file !=3D vma->vm_file)
@@ -2992,8 +2917,7 @@ SYSCALL_DEFINE5(remap_file_pages, unsigned long, star=
t, unsigned long, size,
 			if (next->vm_flags !=3D vma->vm_flags)
 				goto out;
=20
-			if (start + size <=3D next->vm_end)
-				break;
+			prev =3D next;
 		}
=20
 		if (!next)
@@ -3039,7 +2963,7 @@ static int do_brk_munmap(struct ma_state *mas, struct=
 vm_area_struct *vma,
 			 struct list_head *uf)
 {
 	struct mm_struct *mm =3D vma->vm_mm;
-	struct vm_area_struct unmap;
+	struct vm_area_struct unmap, *next;
 	unsigned long unmap_pages;
 	int ret;
=20
@@ -3056,6 +2980,7 @@ static int do_brk_munmap(struct ma_state *mas, struct=
 vm_area_struct *vma,
 	ret =3D userfaultfd_unmap_prep(mm, newbrk, oldbrk, uf);
 	if (ret)
 		return ret;
+
 	ret =3D 1;
=20
 	/* Change the oldbrk of vma to the newbrk of the munmap area */
@@ -3077,6 +3002,7 @@ static int do_brk_munmap(struct ma_state *mas, struct=
 vm_area_struct *vma,
=20
 	vma_mas_remove(&unmap, mas);
=20
+	vma->vm_end =3D newbrk;
 	if (vma->anon_vma) {
 		anon_vma_interval_tree_post_update_vma(vma);
 		anon_vma_unlock_write(vma->anon_vma);
@@ -3086,8 +3012,9 @@ static int do_brk_munmap(struct ma_state *mas, struct=
 vm_area_struct *vma,
 	if (vma->vm_flags & VM_LOCKED)
 		mm->locked_vm -=3D unmap_pages;
=20
+	next =3D mas_next(mas, ULONG_MAX);
 	mmap_write_downgrade(mm);
-	unmap_region(mm, &unmap, vma, newbrk, oldbrk);
+	unmap_region(mm, mas->tree, &unmap, vma, next, newbrk, oldbrk);
 	/* Statistics */
 	vm_stat_account(mm, vma->vm_flags, -unmap_pages);
 	if (vma->vm_flags & VM_ACCOUNT)
@@ -3111,11 +3038,9 @@ static int do_brk_munmap(struct ma_state *mas, struc=
t vm_area_struct *vma,
  * do some brk-specific accounting here.
  */
 static int do_brk_flags(struct ma_state *mas, struct vm_area_struct *vma,
-			unsigned long addr, unsigned long len,
-			unsigned long flags)
+		unsigned long addr, unsigned long len, unsigned long flags)
 {
 	struct mm_struct *mm =3D current->mm;
-	struct vm_area_struct *prev =3D NULL;
 	validate_mm_mt(mm);
=20
=20
@@ -3159,7 +3084,6 @@ static int do_brk_flags(struct ma_state *mas, struct =
vm_area_struct *vma,
 		khugepaged_enter_vma_merge(vma, flags);
 		goto out;
 	}
-	prev =3D vma;
=20
 	/* create a vma struct for an anonymous mapping */
 	vma =3D vm_area_alloc(mm);
@@ -3177,12 +3101,6 @@ static int do_brk_flags(struct ma_state *mas, struct=
 vm_area_struct *vma,
 		goto mas_store_fail;
=20
 	mm->map_count++;
-
-	if (!prev)
-		prev =3D mas_prev(mas, 0);
-
-	__vma_link_list(mm, vma, prev);
-	mm->map_count++;
 out:
 	perf_event_mmap(vma);
 	mm->total_vm +=3D len >> PAGE_SHIFT;
@@ -3190,7 +3108,7 @@ static int do_brk_flags(struct ma_state *mas, struct =
vm_area_struct *vma,
 	if (flags & VM_LOCKED)
 		mm->locked_vm +=3D (len >> PAGE_SHIFT);
 	vma->vm_flags |=3D VM_SOFTDIRTY;
-	validate_mm_mt(mm);
+	validate_mm(mm);
 	return 0;
=20
 mas_store_fail:
@@ -3264,6 +3182,8 @@ void exit_mmap(struct mm_struct *mm)
 	struct mmu_gather tlb;
 	struct vm_area_struct *vma;
 	unsigned long nr_accounted =3D 0;
+	MA_STATE(mas, &mm->mm_mt, 0, 0);
+	int count =3D 0;
=20
 	/* mm's last user has gone, and its about to be pulled down */
 	mmu_notifier_release(mm);
@@ -3287,7 +3207,7 @@ void exit_mmap(struct mm_struct *mm)
 	}
=20
 	arch_exit_mmap(mm);
-	vma =3D mm->mmap;
+	vma =3D mas_find(&mas, ULONG_MAX);
 	if (!vma) {
 		/* Can happen if dup_mmap() received an OOM */
 		mmap_write_unlock(mm);
@@ -3299,17 +3219,25 @@ void exit_mmap(struct mm_struct *mm)
 	tlb_gather_mmu_fullmm(&tlb, mm);
 	/* update_hiwater_rss(mm) here? but nobody should be looking */
 	/* Use -1 here to ensure all VMAs in the mm are unmapped */
-	unmap_vmas(&tlb, vma, 0, -1);
-	free_pgtables(&tlb, vma, FIRST_USER_ADDRESS, USER_PGTABLES_CEILING);
+	unmap_vmas(&tlb, &mm->mm_mt, vma, 0, ULONG_MAX);
+	free_pgtables(&tlb, &mm->mm_mt, vma, FIRST_USER_ADDRESS, USER_PGTABLES_CE=
ILING);
 	tlb_finish_mmu(&tlb);
=20
-	/* Walk the list again, actually closing and freeing it. */
-	while (vma) {
+	/*
+	 * Walk the list again, actually closing and freeing it, with preemption
+	 * enabled, without holding any MM locks besides the unreachable
+	 * mmap_write_lock.
+	 */
+	do {
 		if (vma->vm_flags & VM_ACCOUNT)
 			nr_accounted +=3D vma_pages(vma);
-		vma =3D remove_vma(vma);
+		remove_vma(vma);
+		count++;
 		cond_resched();
-	}
+	} while ((vma =3D mas_find(&mas, ULONG_MAX)) !=3D NULL);
+
+	BUG_ON(count !=3D mm->map_count);
+
=20
 	trace_exit_mmap(mm);
 	__mt_destroy(&mm->mm_mt);
@@ -3349,7 +3277,7 @@ int insert_vm_struct(struct mm_struct *mm, struct vm_=
area_struct *vma)
 		vma->vm_pgoff =3D vma->vm_start >> PAGE_SHIFT;
 	}
=20
-	if (vma_link(mm, vma, prev))
+	if (vma_link(mm, vma))
 		return -ENOMEM;
=20
 	return 0;
@@ -3379,7 +3307,8 @@ struct vm_area_struct *copy_vma(struct vm_area_struct=
 **vmap,
 		faulted_in_anon_vma =3D false;
 	}
=20
-	if (range_has_overlap(mm, addr, addr + len, &prev))
+	new_vma =3D find_vma_prev(mm, addr, &prev);
+	if (new_vma->vm_start < addr + len)
 		return NULL;	/* should never get here */
=20
 	new_vma =3D vma_merge(mm, prev, addr, addr + len, vma->vm_flags,
@@ -3422,7 +3351,7 @@ struct vm_area_struct *copy_vma(struct vm_area_struct=
 **vmap,
 			get_file(new_vma->vm_file);
 		if (new_vma->vm_ops && new_vma->vm_ops->open)
 			new_vma->vm_ops->open(new_vma);
-		if (vma_link(mm, new_vma, prev))
+		if (vma_link(mm, new_vma))
 			goto out_vma_link;
 		*need_rmap_locks =3D false;
 	}
@@ -3727,12 +3656,13 @@ int mm_take_all_locks(struct mm_struct *mm)
 {
 	struct vm_area_struct *vma;
 	struct anon_vma_chain *avc;
+	MA_STATE(mas, &mm->mm_mt, 0, 0);
=20
 	mmap_assert_write_locked(mm);
=20
 	mutex_lock(&mm_all_locks_mutex);
=20
-	for (vma =3D mm->mmap; vma; vma =3D vma->vm_next) {
+	mas_for_each(&mas, vma, ULONG_MAX) {
 		if (signal_pending(current))
 			goto out_unlock;
 		if (vma->vm_file && vma->vm_file->f_mapping &&
@@ -3740,7 +3670,8 @@ int mm_take_all_locks(struct mm_struct *mm)
 			vm_lock_mapping(mm, vma->vm_file->f_mapping);
 	}
=20
-	for (vma =3D mm->mmap; vma; vma =3D vma->vm_next) {
+	mas_set(&mas, 0);
+	mas_for_each(&mas, vma, ULONG_MAX) {
 		if (signal_pending(current))
 			goto out_unlock;
 		if (vma->vm_file && vma->vm_file->f_mapping &&
@@ -3748,7 +3679,8 @@ int mm_take_all_locks(struct mm_struct *mm)
 			vm_lock_mapping(mm, vma->vm_file->f_mapping);
 	}
=20
-	for (vma =3D mm->mmap; vma; vma =3D vma->vm_next) {
+	mas_set(&mas, 0);
+	mas_for_each(&mas, vma, ULONG_MAX) {
 		if (signal_pending(current))
 			goto out_unlock;
 		if (vma->anon_vma)
@@ -3807,11 +3739,12 @@ void mm_drop_all_locks(struct mm_struct *mm)
 {
 	struct vm_area_struct *vma;
 	struct anon_vma_chain *avc;
+	MA_STATE(mas, &mm->mm_mt, 0, 0);
=20
 	mmap_assert_write_locked(mm);
 	BUG_ON(!mutex_is_locked(&mm_all_locks_mutex));
=20
-	for (vma =3D mm->mmap; vma; vma =3D vma->vm_next) {
+	mas_for_each(&mas, vma, ULONG_MAX) {
 		if (vma->anon_vma)
 			list_for_each_entry(avc, &vma->anon_vma_chain, same_vma)
 				vm_unlock_anon_vma(avc->anon_vma);
diff --git a/mm/nommu.c b/mm/nommu.c
index d94f6adf9c31..e32561f9f55f 100644
--- a/mm/nommu.c
+++ b/mm/nommu.c
@@ -553,7 +553,6 @@ static void put_nommu_region(struct vm_region *region)
 static void add_vma_to_mm(struct mm_struct *mm, struct vm_area_struct *vma=
)
 {
 	struct address_space *mapping;
-	struct vm_area_struct *prev;
 	MA_STATE(mas, &mm->mm_mt, vma->vm_start, vma->vm_end);
=20
 	BUG_ON(!vma->vm_region);
@@ -572,11 +571,8 @@ static void add_vma_to_mm(struct mm_struct *mm, struct=
 vm_area_struct *vma)
 		i_mmap_unlock_write(mapping);
 	}
=20
-	prev =3D mas_prev(&mas, 0);
-	mas_reset(&mas);
 	/* add the VMA to the tree */
 	vma_mas_store(vma, &mas);
-	__vma_link_list(mm, vma, prev);
 }
=20
 /*
@@ -601,7 +597,6 @@ static void delete_vma_from_mm(struct vm_area_struct *v=
ma)
=20
 	/* remove from the MM's tree and list */
 	vma_mas_remove(vma, &mas);
-	__vma_unlink_list(vma->vm_mm, vma);
 }
=20
 /*
diff --git a/mm/util.c b/mm/util.c
index 3e97807c353b..136e1775d54c 100644
--- a/mm/util.c
+++ b/mm/util.c
@@ -271,46 +271,6 @@ void *memdup_user_nul(const void __user *src, size_t l=
en)
 }
 EXPORT_SYMBOL(memdup_user_nul);
=20
-void __vma_link_list(struct mm_struct *mm, struct vm_area_struct *vma,
-		struct vm_area_struct *prev)
-{
-	struct vm_area_struct *next;
-
-	vma->vm_prev =3D prev;
-	if (prev) {
-		next =3D prev->vm_next;
-		prev->vm_next =3D vma;
-	} else {
-		next =3D mm->mmap;
-		mm->mmap =3D vma;
-	}
-	vma->vm_next =3D next;
-	if (next)
-		next->vm_prev =3D vma;
-	else
-		mm->highest_vm_end =3D vm_end_gap(vma);
-}
-
-void __vma_unlink_list(struct mm_struct *mm, struct vm_area_struct *vma)
-{
-	struct vm_area_struct *prev, *next;
-
-	next =3D vma->vm_next;
-	prev =3D vma->vm_prev;
-	if (prev)
-		prev->vm_next =3D next;
-	else
-		mm->mmap =3D next;
-	if (next) {
-		next->vm_prev =3D prev;
-	} else {
-		if (prev)
-			mm->highest_vm_end =3D vm_end_gap(prev);
-		else
-			mm->highest_vm_end =3D 0;
-	}
-}
-
 /* Check if the vma is being used as a stack by this task */
 int vma_is_stack_for_current(struct vm_area_struct *vma)
 {
--=20
2.35.1
