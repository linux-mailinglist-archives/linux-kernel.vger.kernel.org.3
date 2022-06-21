Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 10AC7553C28
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Jun 2022 22:56:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354588AbiFUUt1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Jun 2022 16:49:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354559AbiFUUsX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jun 2022 16:48:23 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 548CE5F9D
        for <linux-kernel@vger.kernel.org>; Tue, 21 Jun 2022 13:48:00 -0700 (PDT)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 25LJLc3R012614;
        Tue, 21 Jun 2022 20:47:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : subject :
 date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=0WZ6yr5sEyXQuG0dhI3NdhL7SGlPFeb4e4fzZdEquu8=;
 b=GC7O7eAwMEV0zHhTL1D5qPeb7AzDtBVTm2p3ZslGamGz6t69FEBXn/G/y178lB2gmvTj
 99RyYOVsMRnmM29saw4f5C23xSZp2IW0j2TFEpns2WYJEeDt9fhEqWlolN++JCPWXahQ
 TkXsgBaPtqSXA7SffKfikV/NK76ecU8VxEGDkQG3OOui4idMPZ/n6tzhbf+0kJFwXPTw
 yuqKyk/2eOhSTiCBBw6ue3fFzg1YmFGbE+JSqoxYjcjrdHf3jJX1WEDeI19usbB0mvMX
 fBssoK8UKJAxo5nAwLgRW7PsQSMBTmDE6Z2Y4tWkRmiaDqGAZOLrPs9lz3tu1L13OCt9 PQ== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3gs6kf6khk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 21 Jun 2022 20:47:48 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 25LKeUht027847;
        Tue, 21 Jun 2022 20:47:47 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2177.outbound.protection.outlook.com [104.47.55.177])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com with ESMTP id 3gth8wspfd-5
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 21 Jun 2022 20:47:47 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WHLbliLp4AnJBh8Y1m0rTYc9BzfEmanMskstM7r43InsC56iV8UpABc7wmm4cqp5dwvDOC+UXAgscLBIgJeYXBYxCp3xlGTwgPykAdWTjFLKB3tUUjqPvif8jm5BuBRsJA9Arw7i2V6Oc5xLpLo3Mg3xoX7yYj9wsCTayhJFWiCt7bPtd6rf9sOY0pxrNfzzGchc/aRDjxHIisZSk4J/XWDTgw8Nhv+wB+1zGdrouZ9Q+q9XLYu0oteM5ujlfTdXkEvgM91CRKOEym9ef7o9fah+ULDg38MzzLxbc7cazNRvRNk6cE2b7nlzO+w5xvV4KlmLLuNFzAAVB35YzlCKAw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0WZ6yr5sEyXQuG0dhI3NdhL7SGlPFeb4e4fzZdEquu8=;
 b=IOEX4OOQs7kcGsmo2iomzZH/2x2JjSjXS10BwkCktQ1bqdzJSQ/0nE/OMa+OcvPsXYBiEr/DY61m58l1/g1g61++JZcyr2n6jfEsohNqb03zUstMh/c4bFVXnsLlLuDX0q5D1Mzq0DROpSBk1ITg+Be8Hnf3Tijh9I7C9KV2czp+BI3WUn6hsbsXUZeYGs7RDhpRY8YDsEPTC28MYdLapQw+zDd6EqXq+SBeSacPc0vFdw9ZpYPHax/TCV9mTizFrFHABnguKRaGTQH1rPJOTJ5kjVrr8b633G9t5dGNLf2fyA7nOJoo+9KrevQ8wEkjnS1P+3WBXXQ5cvQLXyd2Vw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0WZ6yr5sEyXQuG0dhI3NdhL7SGlPFeb4e4fzZdEquu8=;
 b=TOKbSzC+Z0CvG0TWuIXJKoX8Irx4wFwbHAyiCHwqkdBcEkxjAM2YAuwBM8HNngNKIRZ3QlLRWOygbQsQAjyB1nIkpN1HR90UnuIGV7f5JLAM7VVO3HHXyKoiNz+Vb7Uw7dYYzo8yPwTp/W7V5e1GzFYvO2aA1NC76swJRU7PuT8=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by DM6PR10MB4025.namprd10.prod.outlook.com (2603:10b6:5:1fe::32) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5353.15; Tue, 21 Jun
 2022 20:47:45 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::f59a:175d:d24:949c]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::f59a:175d:d24:949c%7]) with mapi id 15.20.5353.022; Tue, 21 Jun 2022
 20:47:45 +0000
From:   Liam Howlett <liam.howlett@oracle.com>
To:     "maple-tree@lists.infradead.org" <maple-tree@lists.infradead.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        "damon @ lists . linux . dev" <damon@lists.linux.dev>,
        SeongJae Park <sj@kernel.org>,
        David Hildenbrand <david@redhat.com>
Subject: [PATCH v10 34/69] s390: remove vma linked list walks
Thread-Topic: [PATCH v10 34/69] s390: remove vma linked list walks
Thread-Index: AQHYhbAPY9O3PShH/UyyCFI5QqJPzA==
Date:   Tue, 21 Jun 2022 20:47:03 +0000
Message-ID: <20220621204632.3370049-35-Liam.Howlett@oracle.com>
References: <20220621204632.3370049-1-Liam.Howlett@oracle.com>
In-Reply-To: <20220621204632.3370049-1-Liam.Howlett@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.35.1
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: d7a06f72-fe21-4491-d695-08da53c74b5d
x-ms-traffictypediagnostic: DM6PR10MB4025:EE_
x-microsoft-antispam-prvs: <DM6PR10MB40253463CC7A1179A85F4AABFDB39@DM6PR10MB4025.namprd10.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: kpBofJyGsCWGlRzPqbXk3GwrFriS9SuoZxfIwZDD76pUvcol250ILp4tRS2matNL1GjGKGxTICjRQ283ISl7CiNCGUVejx2S46A/jCw78fBXWkx+woVKH8VYcsEqryDt29a1DU63ikCx8VGCvCFQMB67upTyb+vRM9ne6SRsu3VFUH2PXCtSYv6xeINMkK3dpC6f3Bn8HX3kUtmxAkyx5N4djHgl9TsrOZK6j0/o+ArgI7UVOjEXkwkV/irDcAZgIqUfNXIzJe72deB1xQkvyyquD3jMyKKbZmGUHNdYT1NS+fM+IkPRKuU5E9m0oZCrcoibh3SEGGtO6uPKiWBAkFPpackML4zwkt8KqMoSEKJrVLsWiHtTgd7UWBPR0ZM4k9BIoEhbZvbwBtKPt3aETOWi97y1XWr5u5iRjxRcrz4m6y+mfpe4wfpoDS+dZ3Y/w8RHWzNUJQMjxBprc9i9Xiqt8XtQ4KXRkCK2HraKSqNGwLPmcrYGxf3Dx2BY46MmcvigqLNJcK9fCv7quXKazH5AoNv0ZgLQV6jvD6Zcf0hAOHqj+78dgidVU9rGdQ7bCizPPCgRq9PgOxpeGb4nn0P/quCTidGXRkwpVkNsnovfLpQYeaH2u52e71000gxrET78q8LHs0K2AHNHMUhZqVlnJqmUBgDT6xlNCB5WY4mL4juI0uwKYBt+UyaxIvSr5Ne0HPHi+SwiW/NgZDDTlCZaPjvFoZPOnTfdCodUxWIwiMfzBM7QKbhqJEbJbcmbwikCNCTtZmNqzlqgRgwenApIDMwzVXIXlP5wDpwMDrQ=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(39860400002)(136003)(346002)(366004)(376002)(396003)(6512007)(41300700001)(478600001)(122000001)(6486002)(966005)(110136005)(36756003)(8936002)(71200400001)(8676002)(26005)(6666004)(6506007)(83380400001)(2906002)(66446008)(316002)(86362001)(2616005)(91956017)(1076003)(66476007)(66556008)(5660300002)(38070700005)(64756008)(66946007)(44832011)(76116006)(186003)(38100700002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?HhxuvxR0XS3SqECwwelWqH2feFIYsAEE3VLR6HTum3QMt8mDAgik56U80U?=
 =?iso-8859-1?Q?GWYuZ80Z0QLwppVegG1AEf4S2Y/+1RfVlaOWyh9ZfFQYuHPg46DDTmCWJb?=
 =?iso-8859-1?Q?XdImR36pME7DGgRwhs5kLPTEX8pPddDrZq/wzMNuNLWkQXMxLZO6Sql3T6?=
 =?iso-8859-1?Q?9Bu8XOWxNxcIg3ucGDFZfwwcc2gX3WVnpo27a4iHKwmODQ6G33UxafXbgK?=
 =?iso-8859-1?Q?bctyZUJplH1M8sjowBVc6zcQGBc9cJKLO/af2STrkMK/QTbK1C3fraQq4n?=
 =?iso-8859-1?Q?FNhEeWhHxOioowZkRsxvLOy7M7U+zNKdPsYhh4KDEChW8gFv34dAoGT6WJ?=
 =?iso-8859-1?Q?cu0TrqFvM9EHXBv5moQkRWgiDtguiUk7Ym1+YBooxYTt+p/XU/dDiTdkYN?=
 =?iso-8859-1?Q?/bt6LFiXFVw8CVvUjgK2pf7GEe0RNaqUwkaQ7r2gHKqr2TzNQP+LKrMn/t?=
 =?iso-8859-1?Q?56Vfv6I+YiKXBRbJADFm26wDGiV4LM7whrrNICzQDCYyNSEyGIf5kEVWye?=
 =?iso-8859-1?Q?OuXHlI6gOmFoMiyxwF4xugFk7/Zq/LxYYaF7Ffy8T0GdrBf4PQoY+hJtBg?=
 =?iso-8859-1?Q?mCevGBfFDIkGvKFLhMai6m8jALPfU/HiKZS1/mrgZD+5ffOFCRwP/hSHuR?=
 =?iso-8859-1?Q?S4bRHWYhYsPXW6nOd4egjeP/qIbYBxkRpLv7w5o18GCzBelQuacTqYJIv6?=
 =?iso-8859-1?Q?/Z5qGAH4Jmkj0JmwczCfFgFw5yRcxWVuj9pTOKu5JW/LB4vpLN6to85snG?=
 =?iso-8859-1?Q?9CUPGJBPuUsVWNQrCvlnCzdWjd0zjP458SkQDHbR+00kgV209EijB04CFo?=
 =?iso-8859-1?Q?+/EjOgJErBjhYNI9aeaMWC0E8ed9UYgYsQQnXqNfuKWE9o1AheTpKEoOzW?=
 =?iso-8859-1?Q?Y0OGS+Y31zyN8+23IgMQKJOuA6+h2Xpzf8nMQvJ4T74KBq7kWyqlMlh3OR?=
 =?iso-8859-1?Q?7lRHwgClvF85c6MKNNy0lY7GwnRu9e0pzwzF6Q6LRxcD7LwyO/QRN2vl/N?=
 =?iso-8859-1?Q?eH156lKal+yAzZtr87yp4GoV2RIAOW9XLUEuTR1MuVwpnuYLNNG/WOdJ+T?=
 =?iso-8859-1?Q?NX1q0C9w9+R7FD1ZNjN6QgLchvO68SGoeefXl/GHUYm1w8U2iiTY98Q89Z?=
 =?iso-8859-1?Q?ex4yMuZUeRLLvM2bk1KnYqyhyrcOxUmWEQFvz251EWjSCETyEwc350vUZ/?=
 =?iso-8859-1?Q?hkAza2Jn+TjSex3vTzxQowylBEeOseIhUuzmjNnItxGIfdGg4dlYKPY4Ba?=
 =?iso-8859-1?Q?O21kwY+/g5TRz728J2OyrQAqhrlECSCblYMX/pXNSCS6PlMDXYRkcpKUSA?=
 =?iso-8859-1?Q?1pWGSX6uDAn61//p3l5S2zoKS5QuNztG8ADsBuD5a8araN+v1Ua6hDJFQA?=
 =?iso-8859-1?Q?ORfu6h8lPnqPqcL6qaoicdnA1HRtspBWZZkmH+9Bk2eReWaV/jTJUsmv5t?=
 =?iso-8859-1?Q?6P6VqEsYtEAUtemcb9a7y2bwVhHIhVj+gvOtF6keR4aXgROMDm6Qw9Xzxz?=
 =?iso-8859-1?Q?EfvE6q/+wWWia1zesusaQ8EnoTPlPv+Wq7RWhe37SG3RW2yCAKdjX7QiDR?=
 =?iso-8859-1?Q?ITMq5OS6tXg4AgOpGUrWFHrS3QvU8myuUJIM3Xo8/3nrdrrAQd7Rr/c8cF?=
 =?iso-8859-1?Q?p+0JjCBmZr0D5Sd50m+GEs0vLt3QtdCEicMJhjE5rluIpnDCT4Jx/2dMAo?=
 =?iso-8859-1?Q?zeMCdMR9qIWivykhiDm+vScFmkavuMBwKsiZT/DNq97Ozf1vpChNid+Sy2?=
 =?iso-8859-1?Q?lq5uPGj50ENjrMepBuRcfeofYZexjZ9teV2T3anYU6GElh+6GT05ClV1mw?=
 =?iso-8859-1?Q?s7ZZCC/gWMfWIHzlRI8v0zknRjcuWoc=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d7a06f72-fe21-4491-d695-08da53c74b5d
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Jun 2022 20:47:03.6444
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: EnQ5xIpGA//qqoyXGF5wb7spLLvRyVIcHLKaaGbA1s6uQkLwfONBdDFhC6MonGa62eyLqD9WH933gK/16G1L8g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR10MB4025
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.517,18.0.883
 definitions=2022-06-21_09:2022-06-21,2022-06-21 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 malwarescore=0 mlxscore=0
 phishscore=0 adultscore=0 suspectscore=0 mlxlogscore=999 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2204290000
 definitions=main-2206210087
X-Proofpoint-ORIG-GUID: EKnozj_dWYlkLixcigTd-uT9s9HwIkZ4
X-Proofpoint-GUID: EKnozj_dWYlkLixcigTd-uT9s9HwIkZ4
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

Use the VMA iterator instead.

Link: https://lkml.kernel.org/r/20220504011345.662299-19-Liam.Howlett@oracl=
e.com
Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
Signed-off-by: Liam R. Howlett <Liam.Howlett@Oracle.com>
Acked-by: Vlastimil Babka <vbabka@suse.cz>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: David Howells <dhowells@redhat.com>
Cc: SeongJae Park <sj@kernel.org>
Cc: Will Deacon <will@kernel.org>
Cc: Davidlohr Bueso <dave@stgolabs.net>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
---
 arch/s390/kernel/vdso.c | 3 ++-
 arch/s390/mm/gmap.c     | 6 ++++--
 2 files changed, 6 insertions(+), 3 deletions(-)

diff --git a/arch/s390/kernel/vdso.c b/arch/s390/kernel/vdso.c
index 5075cde77b29..535099f2736d 100644
--- a/arch/s390/kernel/vdso.c
+++ b/arch/s390/kernel/vdso.c
@@ -69,10 +69,11 @@ static struct page *find_timens_vvar_page(struct vm_are=
a_struct *vma)
 int vdso_join_timens(struct task_struct *task, struct time_namespace *ns)
 {
 	struct mm_struct *mm =3D task->mm;
+	VMA_ITERATOR(vmi, mm, 0);
 	struct vm_area_struct *vma;
=20
 	mmap_read_lock(mm);
-	for (vma =3D mm->mmap; vma; vma =3D vma->vm_next) {
+	for_each_vma(vmi, vma) {
 		unsigned long size =3D vma->vm_end - vma->vm_start;
=20
 		if (!vma_is_special_mapping(vma, &vvar_mapping))
diff --git a/arch/s390/mm/gmap.c b/arch/s390/mm/gmap.c
index b8ae4a4aa2ba..6e24f337eac0 100644
--- a/arch/s390/mm/gmap.c
+++ b/arch/s390/mm/gmap.c
@@ -2515,8 +2515,9 @@ static const struct mm_walk_ops thp_split_walk_ops =
=3D {
 static inline void thp_split_mm(struct mm_struct *mm)
 {
 	struct vm_area_struct *vma;
+	VMA_ITERATOR(vmi, mm, 0);
=20
-	for (vma =3D mm->mmap; vma !=3D NULL; vma =3D vma->vm_next) {
+	for_each_vma(vmi, vma) {
 		vma->vm_flags &=3D ~VM_HUGEPAGE;
 		vma->vm_flags |=3D VM_NOHUGEPAGE;
 		walk_page_vma(vma, &thp_split_walk_ops, NULL);
@@ -2584,8 +2585,9 @@ int gmap_mark_unmergeable(void)
 	struct mm_struct *mm =3D current->mm;
 	struct vm_area_struct *vma;
 	int ret;
+	VMA_ITERATOR(vmi, mm, 0);
=20
-	for (vma =3D mm->mmap; vma; vma =3D vma->vm_next) {
+	for_each_vma(vmi, vma) {
 		ret =3D ksm_madvise(vma, vma->vm_start, vma->vm_end,
 				  MADV_UNMERGEABLE, &vma->vm_flags);
 		if (ret)
--=20
2.35.1
