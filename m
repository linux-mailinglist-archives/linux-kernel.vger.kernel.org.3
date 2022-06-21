Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 80D58553C32
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Jun 2022 22:56:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354566AbiFUUyq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Jun 2022 16:54:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354542AbiFUUv3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jun 2022 16:51:29 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2D9A2F663
        for <linux-kernel@vger.kernel.org>; Tue, 21 Jun 2022 13:48:51 -0700 (PDT)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 25LJ6sTu009744;
        Tue, 21 Jun 2022 20:48:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : subject :
 date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=DLUhyCMd6f64X3aY9d9Rfu2AX2rVcCkU9QATI8n63SU=;
 b=phIbCTHwEWHcUUZnUknKA2dzIG6Pcwwy2ygHsQsVQ5uCIWxHZpo5ERYA30QRLTlgECX9
 4RqCXpsIzcxJYEDCmfthvaj/yxoFRcdlqCVUbBCPmwfhrdXx17qTv7SklvQQ7ATmGStD
 CjikIYbRcTMTWgcz+mMqK+z5Zc0Cmp5f+4bXscs9Ulg2dQ5SXa+Iz9/qu3qqX52cWtx7
 /cyIC4LcXhBKDfP6qLaNuN0po5wQSypm+Dzz3XGC9+csyhYnWyyuCJXrDWKN25pU9ZIk
 aa+7gb2tvCM7d4KZi05Qks6VgH5IbA03Rnhxd1IwKEPP+FPlzZVrj33A7N6j4ZW1zmrP pg== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3gs78txpfa-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 21 Jun 2022 20:48:42 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 25LKdwkS010169;
        Tue, 21 Jun 2022 20:48:33 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2046.outbound.protection.outlook.com [104.47.66.46])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com with ESMTP id 3gtkfuvv7n-5
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 21 Jun 2022 20:48:33 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cI4jD0vk79uSQYpci2ATypNZkQgi/IDQXTY/KhS/M5PUgDoQomYQhgZ3DIK0f2J3TIaXtLrLY+yUqCgv/leagP0vGSViley9tNG9Nxssr/YQNI3qXIWSEQgHP2xskXJ+dKMgMkqE+o5nLYqBhaZwXlMrQF7IPHAve14ldUXFdq10YUhUBP2uwfeNmnK0NXoi2YIDSY9+W6chCwS5cp1HIxOz9ZP0IglxFJJtPudlSg+Q1NFTSLMrG9q+aWFR7ZXyV0DF7zg6esIlqVt7PhWJcWsdKPwnYk+nORAHX4CzVV2H/qFtGCimnoImicRSzQKCjnuVOk7AH4tpqXmkiJBcRw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DLUhyCMd6f64X3aY9d9Rfu2AX2rVcCkU9QATI8n63SU=;
 b=PfzjR62oO94xMObdF/ByQEodGVHFGt9dP4eGKtzRhHPFtwAMkgNzly4xHNcOXVwnEq73/s/9v3HLuEnRLmxWXoVrQQcE9b8kSzBkqgxcsIRWvo+8c6VBZIa3nE2uv+l9iLQhzf/qJbDQu72G+APa00rWrR754F/9MudwR3ykfIe2b5WWvKmWHi1omQOod58X7Z0yuQtwGkCeLOImY3banosUT07M2VOrSNhK/cLOqV7sbP/7/Zv2+F4fwq8APodm3SOIWSya1pKjTSRCVuCefaSDQfDzYLsv7w6LGrz6bWmMbxQr/5hZBtUUpvF/0Ew7u1k/lHRe2MzHMwoAx0+kiA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DLUhyCMd6f64X3aY9d9Rfu2AX2rVcCkU9QATI8n63SU=;
 b=G1/trXLviHOnzpdpPhoa87yZhZlarSmZuasGPWw/3fXahVpEZ0Hl9P/cpFJKzdQp5mG3dUKJkhTo98B4FQ8Ec8JdXAV8aSudYaW9wcHU42DC3TwPL0j7N4/mrrUiUgQWfmcLlXEHxDlZbm5WM85PcMHRquY3E58un9dRz5fIVYY=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by MN2PR10MB3869.namprd10.prod.outlook.com (2603:10b6:208:1ba::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5353.16; Tue, 21 Jun
 2022 20:48:30 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::f59a:175d:d24:949c]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::f59a:175d:d24:949c%7]) with mapi id 15.20.5353.022; Tue, 21 Jun 2022
 20:48:30 +0000
From:   Liam Howlett <liam.howlett@oracle.com>
To:     "maple-tree@lists.infradead.org" <maple-tree@lists.infradead.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        "damon @ lists . linux . dev" <damon@lists.linux.dev>,
        SeongJae Park <sj@kernel.org>,
        David Hildenbrand <david@redhat.com>
Subject: [PATCH v10 66/69] riscv: use vma iterator for vdso
Thread-Topic: [PATCH v10 66/69] riscv: use vma iterator for vdso
Thread-Index: AQHYhbAWOyp4CI6srEavKtdCFdh0XA==
Date:   Tue, 21 Jun 2022 20:47:13 +0000
Message-ID: <20220621204632.3370049-67-Liam.Howlett@oracle.com>
References: <20220621204632.3370049-1-Liam.Howlett@oracle.com>
In-Reply-To: <20220621204632.3370049-1-Liam.Howlett@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.35.1
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 971eff8e-c2b1-4a4b-0015-08da53c765f9
x-ms-traffictypediagnostic: MN2PR10MB3869:EE_
x-microsoft-antispam-prvs: <MN2PR10MB38693C25452DDAD6F05B72A2FDB39@MN2PR10MB3869.namprd10.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: IJJ/LMHAwWeVu0D6igu9TvZvN1gvlEuCpHqVjBajcQh2IodHsRoBlHC2dbxskCpniQ8pDDMhi8lWr0Ko7gkwnn9lE6HCALweUXbonypIU2rV91njHAVIm4NeM6z9wBuD7eZOTgKkjAEakoZnfdxRttUZcjljMHbnPGQlPxWZ5Cq/kMne1TWb+lhN1OCD61LxGCLjUBDi2NILnjcup5osTOB6XvVHZIszrq2FN5EKiSRr+GwvbEe6BNJThLqbjVhaBvAmnOiVTUEKtiAnEjpUyHr7MEAzSX7Oi8lekq4sBFIxuG0QuIVujZBKObenFFjQ9LSbooFEt32P+0xWix94kC7cYII59IBSWawKgGiGBX20gdB7FCcmPoTu2HBM843rLQ6AQorQfo43+yoFgP6h23aTlrgwQutVTWTND57mOKH62kMgA9tLHIm29Ef4p/F7/BjYvp8A1afqoUdzt1PfZkla0gLM6iu/LpC3byzQPTdk+YA8VoaPV6f3q64A72Dae/1yymcNYhP8lCrWihCAFca5dTbU8Q8pNa8ubqq17yuqM/cqblhBYEeEGz2eY/y9FGd3RI24qmSN0Z3jvjyG6RLTaQyA0K1iEJbtX2bZ22aHq66H+7zCHXHAv+3oUcEJlyaWD9PeobdwUjEM06zo9vQDa/GOlCTavq/rSkdihX/zMGKapsBuNvbwmGFHzuBQQN+rHL6nerfAy3o6C7NMtZjUp05azKSpu07S4ZVvKaSOhQbNoM20NRQAVNIor2LTlu/Lrp9Y2PfsbYri4sw0lsHfuqfihPlEF8Wu8kUetEM=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(346002)(376002)(136003)(39860400002)(366004)(396003)(26005)(6666004)(2616005)(966005)(91956017)(6512007)(6506007)(186003)(41300700001)(1076003)(122000001)(83380400001)(38100700002)(44832011)(86362001)(8676002)(66556008)(66476007)(38070700005)(5660300002)(316002)(2906002)(110136005)(66946007)(71200400001)(66446008)(6486002)(36756003)(478600001)(8936002)(64756008)(76116006);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?BycsL6uxkrcL9u+iTVPNZ3pkMXfIKczJEepA4dRsK8pCN7ST3UVcY3rgMV?=
 =?iso-8859-1?Q?g+EzMqgwbdLPFJZJRDWBb4uQ7dY0aEyUioOMYyMecq3lIqTldpI8pOkpIv?=
 =?iso-8859-1?Q?2Sjh6aeHC74Xj8EYOfieOK37P2vrnyf6VWEikm/m57dDjzCHZaFefLQ1MJ?=
 =?iso-8859-1?Q?J+Bo1WUvVbDItdwZMzIZs6ust0SBRI+iMX6JhfbpabXoxRdmbQxPaMpAz1?=
 =?iso-8859-1?Q?I9LOEtlralOrRmVBsqNnNBbpMtGlwIa/EFgDpGiIBmDYHmEPEWpPvbxa7q?=
 =?iso-8859-1?Q?XbhX5qLRMV9YPMNfLmko0jlE3sVoNCGQvOQP2tWvCMrhiRmVh5O+vj1hEE?=
 =?iso-8859-1?Q?q/wuDTe1NuE/yUqESgiclgglrdqZOmv+Un53bxRIJbrc+CjOT2eiSRVRH8?=
 =?iso-8859-1?Q?2ky02S4xa45ArDftcgbwuKHN0WQ38AyR4ZVZ6npojGHQ5Wjwervi37NbZh?=
 =?iso-8859-1?Q?D3rN4aBehpnH4ZRKPXp8ddY1Z5Tns104w0OjLKRbOWg3M862+ypQTi/i3L?=
 =?iso-8859-1?Q?+CTSjqxlrqG/0vDx/kKKj6rjbLbejwPaZzlQ5Uv2Jsk3Cu9/bgBXYuAG+L?=
 =?iso-8859-1?Q?vrK3D1DVLh17wnUpVN2gRU047LdfylsnwhXXXnHIZ6mGB8TwngiY07Zpvq?=
 =?iso-8859-1?Q?ErbvbOvGCFLlnvAgLGZrf7wWcSyZGD7umdPFWKZe5hds7z5dxlw9zjf6nF?=
 =?iso-8859-1?Q?xXYN8w0ZASYO3rmf5jzi8pYJDb3bJq3matoj3pVgqN5ZHyYkD7VoHG3nUz?=
 =?iso-8859-1?Q?w+nq4vNnKBtW03gENE0yDOPvfehJ/UFc0tmOH84IoQ00wGLJKq1JGCO65g?=
 =?iso-8859-1?Q?V4peDKgJvGOChU3f3YfI/k3ZpLoCOXmXSRqBOO0S5MzAfTY0xBUo6GN1b1?=
 =?iso-8859-1?Q?kx5+lfDyn4z9IrlzROJ+ZprGJ7yfC7Fop8ftOBvUwaN/iSL1VD/2h6lUel?=
 =?iso-8859-1?Q?mUjz9/EES3EqdoOs9FGczn+xTfi8klahPDNJJyfjlsd3OBFtmoZR1c7mDD?=
 =?iso-8859-1?Q?lGlfwBx/CJQmPeGyfllmtioz/Umi9IG6Fn4SuVxG+NY/3wQK1s2K2VNFvN?=
 =?iso-8859-1?Q?g3RVWFPwbGhaRc5AejU3zZcOL398rZY3dKnrVaEyuFfn4AK79CcbhMrnfn?=
 =?iso-8859-1?Q?1GWKcf0HWSdDRu+zHYwcDlvjAHJwQnF7FjxnlxcQMMZifTY5miqjapOuHX?=
 =?iso-8859-1?Q?oREN/4R9h3dQPXFBuwLGRaGNOS93+xSdMOOnonW51PIEU8UTACfRmG31oq?=
 =?iso-8859-1?Q?DevoNO/NLgFKNZe1E/veYZjIeOUuQYDDLqUO19ABBjew/hlfooCbJjSme9?=
 =?iso-8859-1?Q?jfIF5MfKJBa/o3T3SdFUuUnSJ+QVYI3L/mz2+znqE9gxuMj90Fk7SJ2ZZs?=
 =?iso-8859-1?Q?6G1/f9rLdwV6Mz2ffZx7Pv2w2eulEMokzQmrIDB+OnuslZT85oLjJZkgrw?=
 =?iso-8859-1?Q?l7yvgaYwvlYGg31k45L7pMp6ba7rMiNcXI/6PcbKlUuTMf+RSgfNAGaYz+?=
 =?iso-8859-1?Q?VvnjWhAq9us/zOuF23HbYWEgteuuhzMmfaHjaBpS9C/xHYr6MeTYhHF7rO?=
 =?iso-8859-1?Q?MGE1lLvhE/XTDVEc6yFCNoZanlY41YTQEvkjLslwDqyNzkD0FFfqMM525/?=
 =?iso-8859-1?Q?dcjw4aJq1s0tM9yACU1e/Xg7ZChg/pnRkWcyM7XOsE5rhbvuZWhdTaC1oq?=
 =?iso-8859-1?Q?ORgWtrFiFIs9KiU8BKYtyp21aEHE4fbkGq/l3ZZB6A1Z5ZcV0TMLDcumjK?=
 =?iso-8859-1?Q?TBj7GmR0fVkDUEAhR1vOhr+PbayhiymSTcbik+08NX/w8Z7LbJf9FCQ6Cc?=
 =?iso-8859-1?Q?J1yfEUGZBwU86UIvkE/RJ5RULKpmLT8=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 971eff8e-c2b1-4a4b-0015-08da53c765f9
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Jun 2022 20:47:13.9093
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: LIn7VRycQO8tAwzVTISzaHqUGd7VsE65XT/38O9gLCWftv8/SgXw62FiB+CqsK1k4jHGn1aZJAQquHVqrvmbLg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR10MB3869
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.517,18.0.883
 definitions=2022-06-21_09:2022-06-21,2022-06-21 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 malwarescore=0
 mlxlogscore=906 suspectscore=0 adultscore=0 phishscore=0 bulkscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2204290000 definitions=main-2206210087
X-Proofpoint-GUID: yNXPmroOUC6fMiKS32j4VOKRRaPCD1qE
X-Proofpoint-ORIG-GUID: yNXPmroOUC6fMiKS32j4VOKRRaPCD1qE
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Liam R. Howlett" <Liam.Howlett@Oracle.com>

Remove the linked list use in favour of the vma iterator.

Link: https://lkml.kernel.org/r/20220504011345.662299-51-Liam.Howlett@oracl=
e.com
Signed-off-by: Liam R. Howlett <Liam.Howlett@oracle.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: David Howells <dhowells@redhat.com>
Cc: "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc: SeongJae Park <sj@kernel.org>
Cc: Vlastimil Babka <vbabka@suse.cz>
Cc: Will Deacon <will@kernel.org>
Cc: Davidlohr Bueso <dave@stgolabs.net>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
---
 arch/riscv/kernel/vdso.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/riscv/kernel/vdso.c b/arch/riscv/kernel/vdso.c
index 69b05b6c181b..692e7ae3dcb8 100644
--- a/arch/riscv/kernel/vdso.c
+++ b/arch/riscv/kernel/vdso.c
@@ -114,11 +114,12 @@ int vdso_join_timens(struct task_struct *task, struct=
 time_namespace *ns)
 {
 	struct mm_struct *mm =3D task->mm;
 	struct vm_area_struct *vma;
+	VMA_ITERATOR(vmi, mm, 0);
 	struct __vdso_info *vdso_info =3D mm->context.vdso_info;
=20
 	mmap_read_lock(mm);
=20
-	for (vma =3D mm->mmap; vma; vma =3D vma->vm_next) {
+	for_each_vma(vmi, vma) {
 		unsigned long size =3D vma->vm_end - vma->vm_start;
=20
 		if (vma_is_special_mapping(vma, vdso_info->dm))
--=20
2.35.1
