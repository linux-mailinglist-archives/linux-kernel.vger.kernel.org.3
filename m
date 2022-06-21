Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7F672553C0D
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Jun 2022 22:55:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354867AbiFUUzB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Jun 2022 16:55:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354608AbiFUUvj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jun 2022 16:51:39 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C1512FE52
        for <linux-kernel@vger.kernel.org>; Tue, 21 Jun 2022 13:48:58 -0700 (PDT)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 25LJ29q4004726;
        Tue, 21 Jun 2022 20:47:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : subject :
 date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=TXVWoO1SZ/v3PZL9UZYg5bHwEDBBCCez0anHArsOszM=;
 b=i9lBr3FmMhOHcH7t4fbftgA34Xk/yz2ZAB+3k4PnmydDlhB0q7YHbuwgyVj+asDTAldV
 8r/3gyu6Ar20Nx+0E3KAfNb1xbvAJ9mdQqDm/FvoLfky3rOVaHCcaehedxFiQLyu4YrH
 JowEnfkVY+YMO2O01ID3MG3qr13V5Z+gW10x5aRLx+1ZuPGGaCY9B0bXRvTujID5db4U
 8PNAXZDLXACTHfgu8INa2Hw1mho4vH8rpNRv1kAaji/icRvbhPicHC6UsDfsOt3xXyuB
 CWo5mqCuTtJg95KnZKfxigppN/ODegsCdFPoBXY0i4sHl2aUnDeNdXaEdgc1IcH5pYey gQ== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3gs54cpnw6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 21 Jun 2022 20:47:15 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 25LKebw9031773;
        Tue, 21 Jun 2022 20:47:14 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2173.outbound.protection.outlook.com [104.47.55.173])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com with ESMTP id 3gtd9ujy2p-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 21 Jun 2022 20:47:14 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gAFx+wWo2KCuC6XU/ScrFnZL6yOtnhwUNR5/pKpL4ZmARTSKWxnz9jfoeFHsKN8YWe6IyZG3OCvX+ZW/588VxjSpNzeHR4+zSUYn1txMzpJOTmFgdwVGB4OVA4REmZqor7zH+pKmxSxjNi9AMm++5TUQXEPAfl73yYDMhopf4CrBbE5rjA1uY2s6As0Jyf44puSnS/qy0U3OXUpM1gMlTmC1rMy7jz3Ts4xLgBHvrIvqKTlEWIiHeDgj5LiRA3WBC6nD/PpRsx4wj03ZLuQGghnQ9dL6meMycynM1YnLH91HWPovYCc+UgLZGrDcFW3rvbX7s1YS4beftWy+nyB3wg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TXVWoO1SZ/v3PZL9UZYg5bHwEDBBCCez0anHArsOszM=;
 b=FJj9m7TlLzJa4QRLLj+7/7bKiPbcfulmnOgsSnO8z+jXW+wPxNMXwSps3ojvc+A7SfWB8cfDkRy4tz13VeOK8d/hnNXad6CFEGeoJ8ttruMv+yvyk2+lZ+EBl99kTpaHsHWPrzGSIAF3Hxpe28jUcEnrhJR2xh4D4eJQlTah7YLeOiP1iExhNPqT8Se1wjTbC+4RTMWfc5y4zy3jmMO+ZlkWErEMC1IV6SaoxFmGe+F5zBgja0W5rMUsV1WY9ZK8AnI+CppKfFRgz2k1rxTURONGmOZDxETHkABI7E1v4uUGHkErm2b5wUzC/Pbqe+/WyXAO3ATwbf8j0RxuvliFxQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TXVWoO1SZ/v3PZL9UZYg5bHwEDBBCCez0anHArsOszM=;
 b=tc+o4TN/GQ0IoSda/JvrascyFHU7yUoQXCZ2hQwWR35dH6OOfvo/k6rODi0emZgBzMMyPaA9kV0vgMPsmYEZSZLtJEQUQRVunHlCaU85e99uTxXpLpjO/L75vQjDZB47Br+tFSxRZHX5nJvhRsnDpCGG2TQ/CTfP8Twrj6c0CUI=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by DM6PR10MB4025.namprd10.prod.outlook.com (2603:10b6:5:1fe::32) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5353.15; Tue, 21 Jun
 2022 20:47:13 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::f59a:175d:d24:949c]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::f59a:175d:d24:949c%7]) with mapi id 15.20.5353.022; Tue, 21 Jun 2022
 20:47:13 +0000
From:   Liam Howlett <liam.howlett@oracle.com>
To:     "maple-tree@lists.infradead.org" <maple-tree@lists.infradead.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        "damon @ lists . linux . dev" <damon@lists.linux.dev>,
        SeongJae Park <sj@kernel.org>,
        David Hildenbrand <david@redhat.com>
Subject: [PATCH v10 29/69] mm/mmap: change do_brk_munmap() to use
 do_mas_align_munmap()
Thread-Topic: [PATCH v10 29/69] mm/mmap: change do_brk_munmap() to use
 do_mas_align_munmap()
Thread-Index: AQHYhbAP2LStW32dskeOGzGnIYRpEw==
Date:   Tue, 21 Jun 2022 20:47:02 +0000
Message-ID: <20220621204632.3370049-30-Liam.Howlett@oracle.com>
References: <20220621204632.3370049-1-Liam.Howlett@oracle.com>
In-Reply-To: <20220621204632.3370049-1-Liam.Howlett@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.35.1
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: afd6514b-6a75-4030-22e8-08da53c73812
x-ms-traffictypediagnostic: DM6PR10MB4025:EE_
x-microsoft-antispam-prvs: <DM6PR10MB402540C4BB823D52CC53B875FDB39@DM6PR10MB4025.namprd10.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: qXp+70gav/6Eo1/UOeGXpf0gQ5WZSAhJ77/OrHX4vnkHdQXtTQQiNl46kUigJymFDmBdlzVmJmhVmnanO3qLHMv8GVZwWAI/ySoJeGR/J7IbXbSv5UTDXt96/AUlEUdP6LBlsAIFR1i2qLcUm2ChKT8xsSBVGJqS3RYkD1Oihxu9Fro7d0/UDiNdE0/LEA5F1yUlw0glAL2hjNu/jcHW4FH6l9KPKyBm3B8uLkCle7Sf9whfoktKCpEgOHZOwPc8MhxyWuoSDkPGNjuz2XXuG7V0K6rcDzLIxdXMwaVPjbyJ3jJalWm2U1Fyhuo1PsYoJK+P+0BAJq/mNmWFnBVLVVzp6MxvWCoQq9fm1DA4HWuB9c7Hp6ZvqZuV1A3RhKpaokWJRDA76ZobsZe9z4dCmQST6N0AkEIsi+tzeyPJdIrQtKdLScMCIm/y2XLVyzWvh2lB9u1fIyUEOycf1zwR6QPbl1rGFRtPwURWoPyS5IGw0fLwFA2g1ULOHJ+PLNaQc4SRzJrgwbXO1Sxmk5SPbBrmZVeWim0BFlER37R3QnLLPDeK28AzthO6fFy8BbWtnkst7wwVhBxsSdQluOSHc5aLMOfPJBrJ6JYX+dJcR9sriKVA1rk9asowsuYrcOiICRrKWZNZWZG5JwpkXov0Bz80wmTWClSnxZXNmEnOzDoRbDI3jG2ZHfj9Qj2enLmQ3kIxzgaV1cSoET4OIvNU6/p6la8LtPwz6lQjIfM4qVTZOdNp/JhjCT20rmOsNeVCgfQbZTxdcXN+lV0yf+0cWh002YG66dxaSlWKStB4vn/hRN6U9jn16La+BsI1tS95VXI/9b5/8FlKZ9NVYddQow==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(39860400002)(136003)(346002)(366004)(376002)(396003)(6512007)(41300700001)(478600001)(122000001)(6486002)(966005)(110136005)(36756003)(8936002)(71200400001)(8676002)(26005)(6666004)(6506007)(83380400001)(2906002)(66446008)(316002)(86362001)(2616005)(91956017)(1076003)(66476007)(66556008)(5660300002)(38070700005)(64756008)(66946007)(44832011)(76116006)(186003)(38100700002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?aFhl3nFQowUycX1lds1dbqAqP2lj9W3Xh/uVJkqWTNnKb6UlfnhjtxQGia?=
 =?iso-8859-1?Q?gqo6Qp0c0YNB5Msrj9l+gmu9jH/wwkG3L3vsBJy5diEg9Uch+aQI4HtlAl?=
 =?iso-8859-1?Q?k+wdgz3U5xgPLqqxhHceJa7ha3tgxBbe8O/MB7bNZkpM5MGYNYDhudNrI4?=
 =?iso-8859-1?Q?0MoQ+3yuKoiEZB2QWfKPwqb2uMbQ/bEgia/fVA2Ptm46tH9n5eeX4tIQkZ?=
 =?iso-8859-1?Q?owwFkVDr7tTgErY18A6ZrKBwPvaC4NZtFu/P3QsGudTg1TpwgGoabHxXBF?=
 =?iso-8859-1?Q?qc0+lRhzAAHgq6Rga2inh/0DMPIoVXaXmUeIL6K2LNSu1L5bTW6CXv/76I?=
 =?iso-8859-1?Q?+8RWIWFbHnpOKp7n3IB8xXZJpvdvgz3ts/p5pR49Ih4byf/Xa/lQX9ZAF4?=
 =?iso-8859-1?Q?nCqKsxBiwylmnzCo/+X/bDlyclK7TsMfkrEmurnKLcHlk6b2GnrxZRdRUF?=
 =?iso-8859-1?Q?rKTmNH/BJYKO2egJjSLdbd1wpuyH4XL43oxF5PiPAzG/yJYWpxYUBXrv9v?=
 =?iso-8859-1?Q?YmNGOMJ0VOJq+1kDMvvMBVP8BC6yQuIJcYl+2jCKAIedCLziRqPtvZ+HY+?=
 =?iso-8859-1?Q?TJnHDx/DIJnQ3JcnOJfegljrCwRuMZTH9KI3PSKqfZAv6dnXJxG9mpHQ8e?=
 =?iso-8859-1?Q?T/xAiQguXbuQ1pcMIDxAMNOp6MBJT7BHeKTMKXkSQ9rC5h+9LqgdppyW5C?=
 =?iso-8859-1?Q?+SCXa+YiO2kJz82rZvYRyHr+zubu7NI1wCDwbyWTZ7YeYiu4eOZxK6tkEA?=
 =?iso-8859-1?Q?Su9qQrHk0SJio/WgmE5zUGfO8lTzGu+sJpVzrful+WRqP5C8BOwB/6I8bi?=
 =?iso-8859-1?Q?lOJ8FShYU46wseXPm4InwqN3IdhzgyqMYgwiCYVOqEKEY8sWMI4gvF2OFq?=
 =?iso-8859-1?Q?dbSGelRhyo4Nkv4Jea/l9g2kY+e9dda3kBP2K3eZrN49hNdcxib4vAny1G?=
 =?iso-8859-1?Q?oshi9nA6Kh+Am6kt4kvP0g26DlZ8ej9sD2uk2FqIQUaXsinuVSrM/KjXsA?=
 =?iso-8859-1?Q?h+IHihqDCdzamLIRFmucFSxjbijrkyUL8M0PhvpZgUSerB7H0x+ZCwL5AL?=
 =?iso-8859-1?Q?IlXdrZ0C420thY9EVV5mTSBPXeRn+bmlpg8k7ULCrIVXc6H44OGe7iYsAM?=
 =?iso-8859-1?Q?J7bQnSM8YvsU/GD01EO7cKMwaSXeMpiFQy+wbs1rWYSWiQo7NOEdAeRwKS?=
 =?iso-8859-1?Q?nmwZ8QS3vAC35x+SLGlgtV/VS6grYEwUUdwXv8LqLkrY4CbI8C6PITW7o4?=
 =?iso-8859-1?Q?xOtDJPfAw40e1DbZnQvONgDNvofejvRda6r1PiiLu7YpaWgiZZzOW13y+s?=
 =?iso-8859-1?Q?mCtgXW0JtuvFq0znZ8/SrlXJO69lpWX40TVKH3RN74vxurZmXiu0HQaijb?=
 =?iso-8859-1?Q?/QROZUV+jGM0EzkrlJbDGcggBJYYi+Hjs3kR7VV2rRTjfohgjbhawz1lc9?=
 =?iso-8859-1?Q?ft1tFh3C2b5MDJW0xZBO/9CAQWMGe8sPfyu8MBE7JEt4tYBKFBC1fKLr46?=
 =?iso-8859-1?Q?k6xt/bxYCU8CDZlL+fQsbXCi7iIXysMEuT8Q0cI3va5P1lbsHLPdDzHnc/?=
 =?iso-8859-1?Q?DoPkNJClJNgvliMFX0ERRgpjDXGnNDP9QS5/lql2tWrdY0rrzmhujeMJjk?=
 =?iso-8859-1?Q?dfdDxqbMQvh1gB4JfXr3naQlXDFO7dmo9wZR4Ng74iNLZGWQ4Li+QCBcC9?=
 =?iso-8859-1?Q?IaWRsXkXqzq0EXccj2Ri3yUokgWK+k53ipZtqHt9TJl8CwlWMV3T4OxkOJ?=
 =?iso-8859-1?Q?2WTXlX5WZ9Eo5lPJq3+eZXF5uL/bDZD5gHl4CqLeY2wiZhrEYM6z9C4qAd?=
 =?iso-8859-1?Q?D/jIHSxZVZZtb+I/pYyT3eyM4kuLt9c=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: afd6514b-6a75-4030-22e8-08da53c73812
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Jun 2022 20:47:02.1913
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: YqIhv2h5cCD19kpMx+lwvDH8J2GgnKrCft0eG62GVtGEWF1NdcDKhp5cDTvHBVwQ6YevrKANRZ/omoK03KcFaA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR10MB4025
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.517,18.0.883
 definitions=2022-06-21_09:2022-06-21,2022-06-21 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=952 suspectscore=0
 phishscore=0 malwarescore=0 mlxscore=0 spamscore=0 adultscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2204290000 definitions=main-2206210087
X-Proofpoint-GUID: EdiD1MKyXtF5eumzmWnBsQR25piLFBnM
X-Proofpoint-ORIG-GUID: EdiD1MKyXtF5eumzmWnBsQR25piLFBnM
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

do_brk_munmap() has already aligned the address and has a maple tree state
to be used.  Use the new do_mas_align_munmap() to avoid unnecessary
alignment and error checks.

Link: https://lkml.kernel.org/r/20220504011345.662299-14-Liam.Howlett@oracl=
e.com
Link: https://lkml.kernel.org/r/20220519150509.1290067-1-Liam.Howlett@oracl=
e.com
Signed-off-by: Liam R. Howlett <Liam.Howlett@Oracle.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: David Howells <dhowells@redhat.com>
Cc: "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc: SeongJae Park <sj@kernel.org>
Cc: Vlastimil Babka <vbabka@suse.cz>
Cc: Will Deacon <will@kernel.org>
Cc: Davidlohr Bueso <dave@stgolabs.net>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
---
 mm/mmap.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/mm/mmap.c b/mm/mmap.c
index 19d2ddbb9a97..6ae0a8cf9956 100644
--- a/mm/mmap.c
+++ b/mm/mmap.c
@@ -3072,14 +3072,14 @@ static int do_brk_munmap(struct ma_state *mas, stru=
ct vm_area_struct *vma,
 	struct mm_struct *mm =3D vma->vm_mm;
 	struct vm_area_struct unmap;
 	unsigned long unmap_pages;
-	int ret =3D 1;
+	int ret;
=20
 	arch_unmap(mm, newbrk, oldbrk);
=20
-	if (likely((vma->vm_end < oldbrk) ||
-		   ((vma->vm_start =3D=3D newbrk) && (vma->vm_end =3D=3D oldbrk)))) {
+	if (likely((vma->vm_end < oldbrk) || (vma->vm_start >=3D newbrk))) {
 		/* remove entire mapping(s) */
-		ret =3D do_mas_munmap(mas, mm, newbrk, oldbrk-newbrk, uf, true);
+		ret =3D do_mas_align_munmap(mas, vma, mm, newbrk, oldbrk, uf,
+					  true);
 		goto munmap_full_vma;
 	}
=20
--=20
2.35.1
