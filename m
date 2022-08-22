Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4670C59C261
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Aug 2022 17:14:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236264AbiHVPMy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Aug 2022 11:12:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236434AbiHVPKw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Aug 2022 11:10:52 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D3503AE71
        for <linux-kernel@vger.kernel.org>; Mon, 22 Aug 2022 08:08:08 -0700 (PDT)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 27MEphqd016577;
        Mon, 22 Aug 2022 15:06:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=ZHir5mGGs5Fvowsuy+jXqq6MRrllSXoHg6GgeRFD/Ao=;
 b=yWGF8xxS5cSkqK1SVedBld26TMwvTi//XZp1Ci2yDdam+ofnGDZfQOwxeE+/vExVfi2Z
 A9TKW7PmExs0NaJe/FNlpYnoWsx4c6ndeKXEJIhOgZovCGzg/3fWmhfxB/MytA6D0PVr
 IntJYtqcjfdmKFTlK0FKxL3Ymndu9DIIdotAbzkBiOZrgvnu6aTMrcgnbXdG09cZqTiG
 /dOVy0tcKmV0x7GhnMkFNjCR7gp/nbRIHwltHYDYwDgv5IYTiiH2trhKHqBRFOuQYb93
 4bnR5hYUYbrf4e+Dswkx+7kMHNNffVCdnfaqHs666nE81Vf4lkKwlnVGxlvzWtOWsyqO yA== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3j4bx681jq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 22 Aug 2022 15:06:32 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 27ME4Naf031868;
        Mon, 22 Aug 2022 15:06:31 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2168.outbound.protection.outlook.com [104.47.55.168])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3j3mjd3986-5
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 22 Aug 2022 15:06:31 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WsVlXBj2XPidrsCbreEZ+4SrfzWPLiJgh4bSohROX2Ki6x+J0XJgzw48J8TrTF7kkwpl7x2CGhJ9xmncSXNkAQEjTGgK9Rnpx28qhYP0uMD158Z/jBaxgKSynOBxLhwPj2JHhqgnmtGWzLPDKUiVz0G0NK4b/icuwSt66y7KU7F3b9fCzayZxLh8BvrFEOpGN4kuuXnrz72zqRcCmmfc/ZoxzcuOzHWAS6/npUNmoN0VsEZt6piQMt9EmFtFe0b5MCNXXUBVV4H3h0buAersCHhs+g8nzne5+CnPSlVY8UBfNuN8ro6LxjUtsRVinISqu3EnYl2rZOu/5cJ1YSY2sg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZHir5mGGs5Fvowsuy+jXqq6MRrllSXoHg6GgeRFD/Ao=;
 b=Ay0iArly7L8FeSmJkvDQJIRsWftiNhxFs0G2U2KFJHsS6860UYSPfN8AKZWm3A0vrKVyV0xogMks615g/+dBsx5/idqZB1JbNyllwSHhfz4XsuJugI9Cxt81rdSPPiYe0MI4fpZWCBA60tbeMFDaFlt9bDjr2r8/5WTNohBZwbT5F1l1z974cMm0k4c3vfd3XsN+ZTrcyLT4BFXzct3IxxW7yYxcYWyPVXUWOUs/lMrl6QILyMJixwc9SSVyUplULnak6fXjNh05bmrOtkJkgSz+aUdAjNDMcErl45GJkuxwxokr+eLB8KdiA/XonoMZie6oEHtzfsS43YFmbEsb2A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZHir5mGGs5Fvowsuy+jXqq6MRrllSXoHg6GgeRFD/Ao=;
 b=SkxEgOoRETkIUMG47FLN9U/Kqwj03c/8Fn/CTmphsofXR4nJh5TLvhXiRdPX7WUlp4JO4+UqBg8UoCZ/hX3p22WTUXegvRFdgp1AxQvYAsc2lj00q5VB1lq5d+3HZ07JM1bPtsxjeXtEFToGQ0rzZwUsPoQ6l2IxzFdEIckYqt8=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by DM5PR10MB1433.namprd10.prod.outlook.com (2603:10b6:3:e::22) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5546.21; Mon, 22 Aug 2022 15:06:29 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::3d34:ebb5:d9df:98b3]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::3d34:ebb5:d9df:98b3%5]) with mapi id 15.20.5546.023; Mon, 22 Aug 2022
 15:06:29 +0000
From:   Liam Howlett <liam.howlett@oracle.com>
To:     "maple-tree@lists.infradead.org" <maple-tree@lists.infradead.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
CC:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Liam Howlett <liam.howlett@oracle.com>,
        Vlastimil Babka <vbabka@suse.cz>
Subject: [PATCH v13 47/70] perf: use VMA iterator
Thread-Topic: [PATCH v13 47/70] perf: use VMA iterator
Thread-Index: AQHYtjjAPazIt4SsDEqI6EOiFLleuA==
Date:   Mon, 22 Aug 2022 15:06:27 +0000
Message-ID: <20220822150128.1562046-48-Liam.Howlett@oracle.com>
References: <20220822150128.1562046-1-Liam.Howlett@oracle.com>
In-Reply-To: <20220822150128.1562046-1-Liam.Howlett@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.35.1
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 6f0aff5e-2413-4552-05ab-08da844fe442
x-ms-traffictypediagnostic: DM5PR10MB1433:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: CJdV2xAEbTSk8I4zSG1olB88FVxi2jgHFki1nVXgaDGg5Uc1fLvk99xOOK4BINSNHDcD/b8hBIrjCXpa+8J+cgR1sGyFRazVawn4DLD9rKSUoT60R/flGc7CifnBUBVpOQ7VwOD201L/BAyJnDk84YlvI0gdHgO+EHDbG/0hVsgrUy0zDrrUhG/67LVAR1V/wQHZWWnHlXdVSZJXHyd+DeQHQOQcM2PvilD4tTPYvte1gRJ9b+qzMPzwBnfuG6MZHqhR6nJ13/efJ75PZWSJUbcSr9u0CTBmnm9EGedIkfNLyTHTkBIGo/gXzNFo72ciVYcRLqz+B7eOw4eq2pTVfHMDT6vi3BXcH+4GNS26eJMwfMcirX6c/dhBlHBW/rwgCGek3Ng03d8ExYZ2CcUhIjcVGYHjSY9BBNuHy0jAqVk+cuMGW5ujqThPzrC6OGUebFwDqE9LWUWRcpZh5ehHoJX5YxIZ6dNlUT6D0b9RiqttkHd3Gf8optMqbuDOGNI1yKcv09LalcuappDMm9fXpvWJoRvLXqjNUYTa/AZsrb4m4m+GbQHh2Ivp7MzZ4vWTxhof+PSBxDSSQIdZl9X6M4eq8RSbpdBU1L502scQucGkKKu9rI5KAiLNdn8xHeFbrBGNFynzuP++/me441h6lPapOzR3Uhd2zXShQEqsiVgARXs3yloTAR1bnHIw3Ts59+a20uNHASBfEijnIeLanoaTf0URG7skScLK8Y/7TUVrrKIzQq/gONwpVqXVjGpq1P/Y0LBCtSuGwgNBxsGOFg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(346002)(376002)(396003)(136003)(39860400002)(366004)(5660300002)(8936002)(38100700002)(122000001)(36756003)(41300700001)(44832011)(6486002)(316002)(71200400001)(76116006)(91956017)(110136005)(8676002)(4326008)(64756008)(66446008)(66476007)(66556008)(66946007)(54906003)(478600001)(186003)(1076003)(6512007)(26005)(83380400001)(2616005)(6506007)(2906002)(38070700005)(86362001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?lo+9BYK3OlWxCwRdQL1sNkB+DQt3JAGXKIfyjNPwnZzilliClT3rOxw6DB?=
 =?iso-8859-1?Q?VBlze/zkFWW2RYUzm9C2GEp+IEx/Mt0TPP7MOiPZ6n2QCAGX+nWybzBKRN?=
 =?iso-8859-1?Q?/SZ4QsIRMBfFtzJOeTLKEpFy5kFlSFoIDgd5Daqj7VyEZdHSWnXRC+6+kH?=
 =?iso-8859-1?Q?mkG9Hm7R2+ztOAKQ1HlHR2A+e9vhrmlM80KheqJt6Hwony/QlaT4aq5JoE?=
 =?iso-8859-1?Q?452l/ic/lWpDioHx25W3/XbWTlBHSDMyHu32YUmopnF6V6o8hEtJi/ju7L?=
 =?iso-8859-1?Q?qzquPk5CIHxCXAnykuv/AHFBpgui3njqwHfPH8xaHYYJXzRBh8bJipUjDA?=
 =?iso-8859-1?Q?pXttHXA60k7Zx72OgZofih+cETp158Ks3cwKUzVY5XEDoLdqOjBQP67Tzx?=
 =?iso-8859-1?Q?vTqo8+9k5jl7u7/1+RSFSFYx58b4RVblRGzW484hB38w4x+OhXhSqcATQm?=
 =?iso-8859-1?Q?mpu0PNBpKMJVyGSflfzblQID2AwrcX0lvVHGZ2EzTLhR+EkLBsf6fVXSzr?=
 =?iso-8859-1?Q?CXwVWWk0tD6H3GvvA1R2p2VnyXwcMrYkA9fJKy0dfqDIC511C0WmfjWYkv?=
 =?iso-8859-1?Q?cN9hr+25eZ7Ja7AZNylX45giWBoQ1c8gar/93mWOvAEpXpwBa9Id4tbgjf?=
 =?iso-8859-1?Q?K2BiLPDY++ua0ewN1YUWKI46lt/Jljg4LOtdprsFnTJbdv8QgUZAHUya/e?=
 =?iso-8859-1?Q?3OgW2FjvAculQN1PsvFSW6IxJoLF9KFkxpWnd0/BWs5thftNHsAFr5QIUX?=
 =?iso-8859-1?Q?vwvbC5+jw5H+q8Uz5cbNkDcysVwH3bm4VpFdDnqUev9yUetfd972MRFNRL?=
 =?iso-8859-1?Q?a0MFE3czuGPpyvxvja8ExFQrtXc/JrYPjykAo1Lru9PHOIaSzstgVn+NJ7?=
 =?iso-8859-1?Q?iKEMJR56IZL2wvWqGSYu8hXbqnSr4G/ETIfD1K0NFGXwy/ixmoHWyVv4FW?=
 =?iso-8859-1?Q?pKPvRnGWroPlNATqEUdC5EPBGTvs2VUl9DBjshMEiwDNBRso5iOrx/DZBH?=
 =?iso-8859-1?Q?KjbjdnGljyGIcg/LFhgALjSCV0BA3A9qJZuQnPcbqenCRZ/Gq3mSeP/Xt4?=
 =?iso-8859-1?Q?ZnRDnuVg8arn0mX1fsALBm60c6KVCFrjo5WMVmbafZgTdfOO2l895vnx2A?=
 =?iso-8859-1?Q?xabDoLPcZ4st9wlnDZw8U88aheo+tRG7xpDRz+ul1e7knQEKzVJXXvHckI?=
 =?iso-8859-1?Q?iN0iuKAdSnKnyzJIx8mGuXxjwWrJxHNHpF51JNer6aJdrz+iIN5Inv/wyE?=
 =?iso-8859-1?Q?cQ43tFPfam+/mwMLI7ijqVkNNtEHKFlHnNYvxbLzhXQkfUKFuK2Vm7YUO+?=
 =?iso-8859-1?Q?C2QSVafVbY3mYtc4mFMk84CxoAPfyBh7fNMLWdVcpsW/3W/g7ScvheVRKe?=
 =?iso-8859-1?Q?tHHYMtMXPyALROHAM7W4HX7xPADI+FSIAMOd3uEk2pdktvF/cyy+ldpWqW?=
 =?iso-8859-1?Q?yEPZJC8M/Egiqj1fN5KRnLEV6Dzy/wQwGLD22A4PK7oYrQLBxgBuw6UTSC?=
 =?iso-8859-1?Q?muPV4IyI4zjTTk1pMSDkHXPVbcooWJNnatYLLhqcB2KyQib5HKHvGVjl2g?=
 =?iso-8859-1?Q?7Johcr71yIXRNdVKpo1OLGpEDGkWqTd9CokSfHkKRWFW0qAeKluBwG8z6c?=
 =?iso-8859-1?Q?ZyS7Xodker5u8BWBnOzwLEem/8cUN8ltnAXisHOtSEX5tj4Z9qNtUq5w?=
 =?iso-8859-1?Q?=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6f0aff5e-2413-4552-05ab-08da844fe442
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Aug 2022 15:06:27.1912
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: mC4fwzg7AF1KQSpqWDl5F6B+jC9HMMfagkY1dMoWVP1gWmkksH1l6VTOgfZv+TvK4uA/6x29nll8vutrALeN6A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR10MB1433
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-08-22_09,2022-08-22_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 mlxlogscore=999 adultscore=0
 spamscore=0 phishscore=0 malwarescore=0 bulkscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2207270000
 definitions=main-2208220065
X-Proofpoint-ORIG-GUID: H7Prq5jlYuyCy3DkxVDtKr-vlrCn1zGX
X-Proofpoint-GUID: H7Prq5jlYuyCy3DkxVDtKr-vlrCn1zGX
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Matthew Wilcox (Oracle)" <willy@infradead.org>

The VMA iterator is faster than the linked list and removing the linked
list will shrink the vm_area_struct.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
Signed-off-by: Liam R. Howlett <Liam.Howlett@Oracle.com>
Acked-by: Vlastimil Babka <vbabka@suse.cz>
---
 kernel/events/core.c    | 3 ++-
 kernel/events/uprobes.c | 9 ++++++---
 2 files changed, 8 insertions(+), 4 deletions(-)

diff --git a/kernel/events/core.c b/kernel/events/core.c
index 2621fd24ad26..101c5912c3fc 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -10229,8 +10229,9 @@ static void perf_addr_filter_apply(struct perf_addr=
_filter *filter,
 				   struct perf_addr_filter_range *fr)
 {
 	struct vm_area_struct *vma;
+	VMA_ITERATOR(vmi, mm, 0);
=20
-	for (vma =3D mm->mmap; vma; vma =3D vma->vm_next) {
+	for_each_vma(vmi, vma) {
 		if (!vma->vm_file)
 			continue;
=20
diff --git a/kernel/events/uprobes.c b/kernel/events/uprobes.c
index 2eaa327f8158..401bc2d24ce0 100644
--- a/kernel/events/uprobes.c
+++ b/kernel/events/uprobes.c
@@ -349,9 +349,10 @@ static bool valid_ref_ctr_vma(struct uprobe *uprobe,
 static struct vm_area_struct *
 find_ref_ctr_vma(struct uprobe *uprobe, struct mm_struct *mm)
 {
+	VMA_ITERATOR(vmi, mm, 0);
 	struct vm_area_struct *tmp;
=20
-	for (tmp =3D mm->mmap; tmp; tmp =3D tmp->vm_next)
+	for_each_vma(vmi, tmp)
 		if (valid_ref_ctr_vma(uprobe, tmp))
 			return tmp;
=20
@@ -1231,11 +1232,12 @@ int uprobe_apply(struct inode *inode, loff_t offset=
,
=20
 static int unapply_uprobe(struct uprobe *uprobe, struct mm_struct *mm)
 {
+	VMA_ITERATOR(vmi, mm, 0);
 	struct vm_area_struct *vma;
 	int err =3D 0;
=20
 	mmap_read_lock(mm);
-	for (vma =3D mm->mmap; vma; vma =3D vma->vm_next) {
+	for_each_vma(vmi, vma) {
 		unsigned long vaddr;
 		loff_t offset;
=20
@@ -1983,9 +1985,10 @@ bool uprobe_deny_signal(void)
=20
 static void mmf_recalc_uprobes(struct mm_struct *mm)
 {
+	VMA_ITERATOR(vmi, mm, 0);
 	struct vm_area_struct *vma;
=20
-	for (vma =3D mm->mmap; vma; vma =3D vma->vm_next) {
+	for_each_vma(vmi, vma) {
 		if (!valid_vma(vma, false))
 			continue;
 		/*
--=20
2.35.1
