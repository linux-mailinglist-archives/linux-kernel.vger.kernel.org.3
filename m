Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AABD8553C04
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Jun 2022 22:55:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354660AbiFUUvo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Jun 2022 16:51:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354731AbiFUUsb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jun 2022 16:48:31 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 453A12DD40
        for <linux-kernel@vger.kernel.org>; Tue, 21 Jun 2022 13:48:12 -0700 (PDT)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 25LJDHrq011633;
        Tue, 21 Jun 2022 20:48:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : subject :
 date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=Co7VDThVXeZh2fl2sZYbg23rw2SjbhU++u92TPcnexc=;
 b=rBiv9HbpH8tEgkfQyVR+BQEfROwx8xXVbF6X98c1dt7rmxg5f20HD0tgOm8PgL36rgTu
 HOEp9Ze3s61dkUaQYNHL0JWMcEmRGulUHV2CoS4b5Ks2T13ZryTADrEM/QQr45iDgF67
 jf0HnubjnbcjJH9rCB6urATaUvTbWA+x+9iyNAfwUK4id+uG71KscJ1DMpe8A9qnEiYR
 QZ7kb7sefJnLELNtSwujqriZHDZYH7+PyKN2Tm1VuWCyxTb/CH1p30HWn3S4wtnbn1Pc
 GJTf7uW8uOOOSCEJdp+0d2EUyp72R3rRnJAQZ1IwHhDAofQ9QoEIWTzXqM1fYRbFUugw 6Q== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3gs5a0eqad-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 21 Jun 2022 20:47:59 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 25LKeled037913;
        Tue, 21 Jun 2022 20:47:58 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2105.outbound.protection.outlook.com [104.47.70.105])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com with ESMTP id 3gtg5us974-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 21 Jun 2022 20:47:57 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LsEbrHVqEL+2e6x8YI4aD6gznVZdRPKW1U4M+gJLszx2yDFKfVpBJXPVcmjJ0AFXNhVM9GajP2CtTgaxqDiZBdSebF6s4K8sWlOzEUdwGM/jzbkViCEMxDCg3aRXCfqXUWnTZUfmv9GHvdSxw/ZvEWjVGGti/T38h8aebabN2iQ3ylfLgQX+MQcqGHc28uBe4nrNnIqwNHRgt3KOYbmDV22j+hls9eYHnICe9cgNsU4Owcwv90mR7SBK6iYhN08wAr5Prq1h/3xFJC3oAPaXK7BoVG/0fuu+1Mj5ta8zXLsnxZ5kl6j4s/TAmah2Z4+K2YzHpc90TPkBAMzQceY6+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Co7VDThVXeZh2fl2sZYbg23rw2SjbhU++u92TPcnexc=;
 b=FvxHATFP8AHmE43JCbFF0HT6kOsPsoCbaRR5MxzeJFXcRunfaZEE2Fjz+NjcPApY7NUD7npElKanEVV76XhljQiswGoRTLw/P7xPorpyQEiH7fg2SXYDdNyMeie7LSO1YHOAGAqW8YY6pE2MacrqmNwGZ7HMwNNcdba2o2qbXNXJ1L1HuUqs5rZCnzq8YrAMnLfckutnc6imXv2rSAnOus/bDV35g6DPNHvWdXww22o2kHgvFPx8bIZvKb2Vsc+sUtp2x2VyMJCnTqhuMKjGWY70mUE/romcnip1MccHSn/ybffDls9/HCzqBCAv5EUkr00npHik5OpYtN8c0ImWLA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Co7VDThVXeZh2fl2sZYbg23rw2SjbhU++u92TPcnexc=;
 b=BL+l+f4loUjinMqUfd4edyq1eL4ok4ViOTV5LPyBFpRFNfH6zrEQ+KR33neomvu0Hd2kfN2zeG0oIr3n8ElzibS861BPg6AynTzvkzQ88qmxYcEp2e5P0N4zfeF7Zho5Az9DakUozD8ziAGYGpPoMYPJ5MnBmkdM4xKcJlwrjn0=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by DS7PR10MB5392.namprd10.prod.outlook.com (2603:10b6:5:297::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5353.14; Tue, 21 Jun
 2022 20:47:55 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::f59a:175d:d24:949c]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::f59a:175d:d24:949c%7]) with mapi id 15.20.5353.022; Tue, 21 Jun 2022
 20:47:55 +0000
From:   Liam Howlett <liam.howlett@oracle.com>
To:     "maple-tree@lists.infradead.org" <maple-tree@lists.infradead.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        "damon @ lists . linux . dev" <damon@lists.linux.dev>,
        SeongJae Park <sj@kernel.org>,
        David Hildenbrand <david@redhat.com>
Subject: [PATCH v10 57/69] mm/mlock: use vma iterator and maple state instead
 of vma linked list
Thread-Topic: [PATCH v10 57/69] mm/mlock: use vma iterator and maple state
 instead of vma linked list
Thread-Index: AQHYhbAUk4MnBXy2LkmXMJ9TrmCE6A==
Date:   Tue, 21 Jun 2022 20:47:11 +0000
Message-ID: <20220621204632.3370049-58-Liam.Howlett@oracle.com>
References: <20220621204632.3370049-1-Liam.Howlett@oracle.com>
In-Reply-To: <20220621204632.3370049-1-Liam.Howlett@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.35.1
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 1db363bc-942d-46c3-9d5f-08da53c75153
x-ms-traffictypediagnostic: DS7PR10MB5392:EE_
x-microsoft-antispam-prvs: <DS7PR10MB53920E3A4BA9DFF42F77683CFDB39@DS7PR10MB5392.namprd10.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: I/gIdX7d6NV0DdeWMhkeAsqE+Jx+4E0UwbmYOw5T9kUWbYoOQJZVbj9hRNiPSlA5wir5JE3Z/x4c00hvDS/b7SGTwSF23tzCRWXsbkRUGk514Icxftu8sPQxq8xqyMGAAMriHIddA7nFRGowg6bQ1z6k1e+7wR7JTthv9FCIPkHsEJVUWHvb4UeqcexSwEtZ4JWb6S13NlNvN3YM1XjzWGwtibX+3Rv+AkoeKsDLXAWLXtezHzipRwZjGIpr0VMRgjgofPilqP0+Eq6EN4YBDuZ2TaXM49/6QNMQyCWz7HOp6UdCxnl2noWSJXV8FMcC4nM+c0xuj6J15qEKON43OzfemWpWX+DoeTK52a0af5sy8Di6pahjl01Un0eL4hPbZj6X6KqmXmA6s0I5PT2fvOgUhGU/EinaqFSFyuhUuoFfOUnZNBYyK9WGTYuQsoj3GLt3qHqcmVffq+598tbQy7JFnKjUOnKkDBIxpLk+9Y3HK6IhqCm8LDCxaSjzZuLDGSkw+QJQpVK00k+E3qZ//KTxea+MI4JgIIMgcd4FldMea/h7BvbxihhG2idL29oI9dM+5QemQeoa3IDdOBI2QQNaEB0OWNKVYGHxd34ghJDqQKSRtpOQGJfDnQBJXuc23M3Zi49x28lLb0Tf8gCbYvwqBPJqNzi/yOvp0p0UyB4EIB9ejWoXrm0jqHzQSjwvRdlnZxSylcznHsofG65T5uj/r6VCVNWLUs2bMSyPAaVpvW+Btzv3uqlAiTsIhKB5OmEGhibxPQCgT1cbIptRWv6lOU0M2zIo4OIUjplFp3A=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(39860400002)(396003)(366004)(376002)(346002)(136003)(41300700001)(6486002)(38070700005)(2616005)(186003)(86362001)(26005)(6512007)(38100700002)(122000001)(36756003)(1076003)(83380400001)(316002)(66446008)(66946007)(2906002)(64756008)(44832011)(6666004)(6506007)(8936002)(66556008)(76116006)(66476007)(966005)(478600001)(8676002)(91956017)(71200400001)(110136005)(5660300002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?8xUEx4Wmv6yb9Emhbr1NXDbGUb2FppyS/GdbqzZdB0FgcyXrimwRWAwOhN?=
 =?iso-8859-1?Q?ZVwXtmxMNi3dNazfUHYPjab3g1C2fPq7ZqotK6aU1MH/BmglVIbXUroxVX?=
 =?iso-8859-1?Q?P3sCZWA62MiGfBQEw4VX7UqGUexPnIA8mT7i3yZbJNU10XPipbVfASCydZ?=
 =?iso-8859-1?Q?Vwa6RLJZoaVf/jJJ8gf6nGHoiU8zYVwtjKTwp1bmkkVQ4FDl9EXTH17Ngc?=
 =?iso-8859-1?Q?CF+KxSSBOHrk5TgaRvNhwOA/qp9b1pmEHNzjA6GWFGMHAcUJFVsnTUfVTl?=
 =?iso-8859-1?Q?TlsTBnZZBmuxyUcL9hry9oz3T9V0Hw7h7wMhKJenfX+EtdduwxNUYB2drg?=
 =?iso-8859-1?Q?Dphp6TLmU5P/6lz/A1ehx8otE++YVLupr2tXSoTfYuMoNj6iXgo1G2wtKL?=
 =?iso-8859-1?Q?kKKucychcNK+4s1d6rvMjQ7ZgSYfe/DW2cLknJWvYHZlXOPO/8WHEvV8Kz?=
 =?iso-8859-1?Q?AEB6segMPA8jhku0+VnFWFAucLobyaXADhJcpHa58DgPdM9SpfzJ3e9Ans?=
 =?iso-8859-1?Q?cwwt5tHvV5gYJQOHJuSqzL+1C1AqvCDhk9GtiDkXZpWgScd1gMUB7thQRr?=
 =?iso-8859-1?Q?+JcZUlN/27gaPKcvtviGY2g/kJsiIKQqv7MPazfHZBO+JBpZLLU/sPkVau?=
 =?iso-8859-1?Q?5F1EElqI8GCncHAO9Jk6rOXDhmqUrUHVoMoNfqRefvDd4jlFxEXoqTy8iE?=
 =?iso-8859-1?Q?q4IJXb9oi2h3bi4kCGjaRBh/VQzSIl838q/2OBOadq91r37pU65DHH6jWl?=
 =?iso-8859-1?Q?Mq1IldEPk5CROPErZDs28BkeiK03LUOYGLZcAXlcHIkknaqNOGUwmZWgDl?=
 =?iso-8859-1?Q?Hwtwl9J5/pMxfVsPM3GgzC+GNBdSktcwrTm5iHt1CYMaLQrxne2Wm95zlh?=
 =?iso-8859-1?Q?YUsIBBaqTtUhUVoSr7mUWgcfWJ1tBb9yfME4NJ5LIhCncow/6kNyNJrgbS?=
 =?iso-8859-1?Q?ZhrTXz8k+5Irh3e+ibVSfiT3safbceyTeN6rat1mOcaexI32P4zS8WruaU?=
 =?iso-8859-1?Q?8leC9S0hMl6e2jrZ3GdVxDq4rtvaptxyNSF+zsv1u+Mnbui+OkZo/WZRRk?=
 =?iso-8859-1?Q?zxZrhbo5MIOviQOYiUZXmNhcBsWUZzm89RZSEvVar4s6ZpSlLVzElBMkyZ?=
 =?iso-8859-1?Q?aiXHNDF2J1e6wCeb3zUH4u9csPG1oMndjPdbcBQ2tygwCogPIXRy9vw8Hj?=
 =?iso-8859-1?Q?KZuJLebBqQTO8pUOQOz1SNpefrWILFx24eBtqOoYeBDmDt5Gl02RrO1aDV?=
 =?iso-8859-1?Q?1L9yWram5x5Sce8we5U5eh95UJXLqK1Xq7tSDiLaJqLNJeGqThOqod2h2E?=
 =?iso-8859-1?Q?8MFl4l6+XEeAU+dDjTVRYdOJFve9sA8GAlBdIIW46zqCcgL18NiAGXhK3K?=
 =?iso-8859-1?Q?zYYhy3T0yGS4sH1fDPDivd8TB2RfKqTKhNg56aeqyxXJxb2Ln+I+rSNJQL?=
 =?iso-8859-1?Q?BBtU5bJtsEsPecr778IIUGY+tViTBHywusnK71ajQ608/+Ny48xJH1Og5M?=
 =?iso-8859-1?Q?XeSBzw2fRhS0EA+rNU4QBDpNcZ9kiF8n3Wjds4jraMXQsDQIpYQqDDi3Nz?=
 =?iso-8859-1?Q?ZeSzUGlcvgk28Q4ZUAWuGUtZph1w4Mece6kJGGDJoawn9+n6ZpvMRHFyAU?=
 =?iso-8859-1?Q?uYYXMgU/e08ZZjNyGooHriU5PPpcHOD6b4AWI2AYXqKkHukMCy165Ihb39?=
 =?iso-8859-1?Q?4KbJYSShufJRDSHBRcarJWFMvaoZPIuAHBgH4rwzf3OhFm8GfuvZqDEI0Z?=
 =?iso-8859-1?Q?G3V1wnfGFcbfq5bKQ8i0XIPnsKCKYmiRl06cD4bQVAi9lXD/NPoem8Fo78?=
 =?iso-8859-1?Q?NXmU/iYzC0dOPfO2WPAhichX3sWlccw=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1db363bc-942d-46c3-9d5f-08da53c75153
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Jun 2022 20:47:11.3470
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 7ut+MDznLWlwzAaQDQG7yZ9AiP4tKsVmzscZmm8CnpHen/I7khzJVj/1sNi9dr9T9+HzkmbJb0LxJjOXMb3kiA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR10MB5392
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.517,18.0.883
 definitions=2022-06-21_09:2022-06-21,2022-06-21 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 malwarescore=0
 mlxlogscore=999 bulkscore=0 phishscore=0 suspectscore=0 spamscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2204290000 definitions=main-2206210087
X-Proofpoint-ORIG-GUID: WptGjsrZoBgEokEwDBGfLROMhAikzx-3
X-Proofpoint-GUID: WptGjsrZoBgEokEwDBGfLROMhAikzx-3
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

Handle overflow checking in count_mm_mlocked_page_nr() differently.

Link: https://lkml.kernel.org/r/20220504011345.662299-42-Liam.Howlett@oracl=
e.com
Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
Signed-off-by: Liam R. Howlett <Liam.Howlett@Oracle.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: David Howells <dhowells@redhat.com>
Cc: SeongJae Park <sj@kernel.org>
Cc: Vlastimil Babka <vbabka@suse.cz>
Cc: Will Deacon <will@kernel.org>
Cc: Davidlohr Bueso <dave@stgolabs.net>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
---
 mm/mlock.c | 35 +++++++++++++++++++----------------
 1 file changed, 19 insertions(+), 16 deletions(-)

diff --git a/mm/mlock.c b/mm/mlock.c
index 716caf851043..c41604ba5197 100644
--- a/mm/mlock.c
+++ b/mm/mlock.c
@@ -471,6 +471,7 @@ static int apply_vma_lock_flags(unsigned long start, si=
ze_t len,
 	unsigned long nstart, end, tmp;
 	struct vm_area_struct *vma, *prev;
 	int error;
+	MA_STATE(mas, &current->mm->mm_mt, start, start);
=20
 	VM_BUG_ON(offset_in_page(start));
 	VM_BUG_ON(len !=3D PAGE_ALIGN(len));
@@ -479,13 +480,14 @@ static int apply_vma_lock_flags(unsigned long start, =
size_t len,
 		return -EINVAL;
 	if (end =3D=3D start)
 		return 0;
-	vma =3D find_vma(current->mm, start);
-	if (!vma || vma->vm_start > start)
+	vma =3D mas_walk(&mas);
+	if (!vma)
 		return -ENOMEM;
=20
-	prev =3D vma->vm_prev;
 	if (start > vma->vm_start)
 		prev =3D vma;
+	else
+		prev =3D mas_prev(&mas, 0);
=20
 	for (nstart =3D start ; ; ) {
 		vm_flags_t newflags =3D vma->vm_flags & VM_LOCKED_CLEAR_MASK;
@@ -505,7 +507,7 @@ static int apply_vma_lock_flags(unsigned long start, si=
ze_t len,
 		if (nstart >=3D end)
 			break;
=20
-		vma =3D prev->vm_next;
+		vma =3D find_vma(prev->vm_mm, prev->vm_end);
 		if (!vma || vma->vm_start !=3D nstart) {
 			error =3D -ENOMEM;
 			break;
@@ -526,24 +528,23 @@ static unsigned long count_mm_mlocked_page_nr(struct =
mm_struct *mm,
 {
 	struct vm_area_struct *vma;
 	unsigned long count =3D 0;
+	unsigned long end;
+	VMA_ITERATOR(vmi, mm, start);
=20
 	if (mm =3D=3D NULL)
 		mm =3D current->mm;
=20
-	vma =3D find_vma(mm, start);
-	if (vma =3D=3D NULL)
-		return 0;
-
-	for (; vma ; vma =3D vma->vm_next) {
-		if (start >=3D vma->vm_end)
-			continue;
-		if (start + len <=3D  vma->vm_start)
-			break;
+	/* Don't overflow past ULONG_MAX */
+	if (unlikely(ULONG_MAX - len < start))
+		end =3D ULONG_MAX;
+	else
+		end =3D start + len;
+	for_each_vma_range(vmi, vma, end) {
 		if (vma->vm_flags & VM_LOCKED) {
 			if (start > vma->vm_start)
 				count -=3D (start - vma->vm_start);
-			if (start + len < vma->vm_end) {
-				count +=3D start + len - vma->vm_start;
+			if (end < vma->vm_end) {
+				count +=3D end - vma->vm_start;
 				break;
 			}
 			count +=3D vma->vm_end - vma->vm_start;
@@ -659,6 +660,7 @@ SYSCALL_DEFINE2(munlock, unsigned long, start, size_t, =
len)
  */
 static int apply_mlockall_flags(int flags)
 {
+	MA_STATE(mas, &current->mm->mm_mt, 0, 0);
 	struct vm_area_struct *vma, *prev =3D NULL;
 	vm_flags_t to_add =3D 0;
=20
@@ -679,7 +681,7 @@ static int apply_mlockall_flags(int flags)
 			to_add |=3D VM_LOCKONFAULT;
 	}
=20
-	for (vma =3D current->mm->mmap; vma ; vma =3D prev->vm_next) {
+	mas_for_each(&mas, vma, ULONG_MAX) {
 		vm_flags_t newflags;
=20
 		newflags =3D vma->vm_flags & VM_LOCKED_CLEAR_MASK;
@@ -687,6 +689,7 @@ static int apply_mlockall_flags(int flags)
=20
 		/* Ignore errors */
 		mlock_fixup(vma, &prev, vma->vm_start, vma->vm_end, newflags);
+		mas_pause(&mas);
 		cond_resched();
 	}
 out:
--=20
2.35.1
