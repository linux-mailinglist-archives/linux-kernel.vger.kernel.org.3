Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 345C6553C0C
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Jun 2022 22:55:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354776AbiFUUup (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Jun 2022 16:50:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354639AbiFUUs0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jun 2022 16:48:26 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4076114006
        for <linux-kernel@vger.kernel.org>; Tue, 21 Jun 2022 13:48:05 -0700 (PDT)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 25LJBvfl009754;
        Tue, 21 Jun 2022 20:47:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : subject :
 date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=6NVvga5U5c25OQFQAh0ddFL8hSk9Lgz2wHz2Nz0SkNg=;
 b=C0HeQ7oUK7+8zfPbWW1hL6inZZAcxwn/jKkhWULIgwdUaHNfYJOgJ26vc0gO5es706ZW
 Bw3GtbeW1JWFaFb9britD9nsiESv8j2z/efE2C5GbmVE+cVe+emjcM8KtwKluDincO1x
 yuGDT3Vi5UlGxOhWaw/e8L028QXFwtKB+DXrzpKh6DEn2ORkwyZS2V9bkPeC6mTaJI0z
 o7gnKmhUOjkVORgfZgCvDLEghytoCCN2QteOYRIKU+GvyeB4HZsfzl9b7btUtLmnnvE/
 dDTeFETZWc3Bo68NYppume7FZWYYbIsqAv1iJsGvh9jZJa04IkPFBiKqdBW0WB6PiWlV gg== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3gs78txpdt-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 21 Jun 2022 20:47:55 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 25LKeiYK001682;
        Tue, 21 Jun 2022 20:47:54 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2107.outbound.protection.outlook.com [104.47.70.107])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com with ESMTP id 3gtf5cutt1-6
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 21 Jun 2022 20:47:54 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gidJZ5JES6Xo0GRkYxlBjIFp1Qn0xn6ngrgCUMCHwgujoZPGP5b30y8M5sc9clQYxiL9CErH0rubXLkUTQcwmGZN4Sk4X9b2FXXC5doSob8m5lj9LXtPcLQoxKRdmSH+U6nuINTRARywkLHDShD588GZMVV6g54vBSPNc/jfaLNKXPpfEYXzX/K3Xpw7qRwwTPXpWyB2+cpG+xLLu3oCKzLHTM0LQvGzl90P79/XwxJEuR03q4IuOMkea+kyys2Ml3LXfjSe5U5UcDJWSwEUiLuk7+ZXOmrwC3CyhaJ8K2c24zFdqfOTyRSX2eBXeuSnbcQfq1ln3a72lJ0yfhP4UA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6NVvga5U5c25OQFQAh0ddFL8hSk9Lgz2wHz2Nz0SkNg=;
 b=P8zd6qc0C0Es+kZ+DWYemZbUOzHPOCNBc6Na1ahGUQSBeon1og9iWSsJGhlWJkqeErDDbgflzrXV8lrl3dyfQp3Iz/SwJxecVjAqZEXR6h5jtxEHdIroQrmHcYtsx430+g1+HtuRxlBLpbuiXOcGT8cWfSH9R/75Q7lm4lYb9C+IvTxENmMiKJYgdUjAMiLHZ0CcXomXdoDE6kh2hywbEpbWDMGj53gR3b8khh7Dz6bUvaCwye0lkyBF9Trop9mo61LkqywU/ebw8NvlfJPGMeF3AFIPS0n8e0JD+uvysqE/aPvAsUMsQNSIqKR8pzjHzCnqNiWWB+LomeodsDmzHQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6NVvga5U5c25OQFQAh0ddFL8hSk9Lgz2wHz2Nz0SkNg=;
 b=JyhZH70yv/YZ3oBIC+rdVqTAgma55g1O2c3qrQDSfGrApMBN5mHI1q53+tuBlMBKF027nvsxTDehlrjVhZnXrk3/3eLK9F3AjfBcPFZSxVGtgyNMeA1fcvo/dLTW9gDnfcZmG0P0xlRyphetU3qqfmTV6P8KwDJBnJeXCxMaPRo=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by DS7PR10MB5392.namprd10.prod.outlook.com (2603:10b6:5:297::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5353.14; Tue, 21 Jun
 2022 20:47:52 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::f59a:175d:d24:949c]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::f59a:175d:d24:949c%7]) with mapi id 15.20.5353.022; Tue, 21 Jun 2022
 20:47:52 +0000
From:   Liam Howlett <liam.howlett@oracle.com>
To:     "maple-tree@lists.infradead.org" <maple-tree@lists.infradead.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        "damon @ lists . linux . dev" <damon@lists.linux.dev>,
        SeongJae Park <sj@kernel.org>,
        David Hildenbrand <david@redhat.com>
Subject: [PATCH v10 48/69] sched: use maple tree iterator to walk VMAs
Thread-Topic: [PATCH v10 48/69] sched: use maple tree iterator to walk VMAs
Thread-Index: AQHYhbATzEXEl/cPtUe4x8gRgck6wQ==
Date:   Tue, 21 Jun 2022 20:47:08 +0000
Message-ID: <20220621204632.3370049-49-Liam.Howlett@oracle.com>
References: <20220621204632.3370049-1-Liam.Howlett@oracle.com>
In-Reply-To: <20220621204632.3370049-1-Liam.Howlett@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.35.1
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 69aea58a-8cae-4ee7-5c72-08da53c74f42
x-ms-traffictypediagnostic: DS7PR10MB5392:EE_
x-microsoft-antispam-prvs: <DS7PR10MB53920FA8250A0510E530E548FDB39@DS7PR10MB5392.namprd10.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: dlvPxCEz7bkCY5EAJT/F1yPbocRNHUPaUmy3fz+sz6j0UhmVX3HrGHZp7+oVJ1AO2vfyyePAeqQ08GVEpF/S6wNp8om/87a5DinKASBusijw8NVV/hh+QQLs7TuADHtHiwpCKtpKKSperX82IeyTSMCfdgqqpjduKzR5gSQH9nwbURUX95cO/QXIEuqpzMwfYVX9OobPo8YHZOXjMSrM8V+ZZB5O4MLZm4AndoqrKGVgrooGM7m+r4/7s6O28gUxyn1fKsRG34jzyFuOLT++CqrZoHhVW2n4yhMV6ci/uU9zNHATJrhyyqDyGLgIR9f6ncZp92pVIWOKiSP/0zKNqkjKiR2CbWLcIjOlRf3Q+8P50yc6xTKBvul7LwzknbLpm0yGEF/7AN3tfv5g6BQuCi2JdgV32Ygi0RDdJCsByWsLat+ghQ9lvIA96UWLM+LIWMtVsv5j90VgalWIgE0uYra2IDpC92FWxCQIK3ZJ10w2gkNE3BUedBtTO88LPxp7Jtz2BnZ3TPtbKhkb7inKzy9oM5eJcFipJBWsqPnp/zVaNjghDGsaaULnIkVq5jS28H8SajDBeMADhU1K/AUyKLz8Sf2YRd5G+BAFPXgDbBJ8xYInQtBmjg/VPOKtB0Xw2hrAfo8K/cwuwQEs7l0tunJ/NGnvriwemu6SDxxacCaV1vTPfumktN3FL06XDCaLHXah/mCKWGiCf0O3y26616i7FLEq4puDQZ1Gr8zwSXG5sK/4Aaz/8P0/EamZcVjD35+Y9V5cn6HV5KwpmB8U25UGP0f5Bd3oKzZ4rtNbaxQ=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(39860400002)(396003)(366004)(376002)(346002)(136003)(41300700001)(6486002)(38070700005)(2616005)(186003)(86362001)(26005)(6512007)(38100700002)(122000001)(36756003)(1076003)(83380400001)(316002)(66446008)(66946007)(2906002)(64756008)(44832011)(6666004)(6506007)(8936002)(66556008)(76116006)(66476007)(966005)(478600001)(8676002)(91956017)(71200400001)(110136005)(5660300002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?Rtru8zwgaOuQ7IoDPa9oWOOZopZORBTk+gLljLb9wws3CXO7AKN9H23mKN?=
 =?iso-8859-1?Q?IqEu/gHEeIIPm7PFo+tNafKUG1b0sESiCp0UYZaWi4gDzLev1mBLFNsMyE?=
 =?iso-8859-1?Q?dRcYYsqLYN6oIoH4/leUHvtbOlPn85/LfzsHw5dqG9AHVDI/dU+dko8UGw?=
 =?iso-8859-1?Q?yKgqBIfjCY6c19X/KZQG6UzYyK21AaENpBQUHfaThFwN2xvqjlAspP5iDe?=
 =?iso-8859-1?Q?o53iwBJaXLHxCLHvcxlXUJS8lrseP17XrzyrilMFifC2OFAZR6JmPGDmMj?=
 =?iso-8859-1?Q?ZYOCGFeIySLyZKa36u+UL0wt4PRULQKGQ2HZDtiHGMMPx06wEYu6iqQoqC?=
 =?iso-8859-1?Q?FwOxkKsTI0ewOMNDQ3qurg0mmP1hSZNjc+ko/nLNst6sxip36d23Z9lzqf?=
 =?iso-8859-1?Q?/SwtmsRUivBz4PuOYf4Y7oFrrhNpwZxToQic/fTemDfKLNY0sx9hvJ2JLt?=
 =?iso-8859-1?Q?tyrz8oSBnPKyi0/prOoom+Ro4Ts/1fkK0VVt33EO2L5eU5OksK0e+ZVL7e?=
 =?iso-8859-1?Q?YEiwCLSs/TS9yidNfKyEhl03fzhrZFN78tYIuBoOAamW8YPLBeA+SMjzfo?=
 =?iso-8859-1?Q?pECpJ886DRbo7dXQtOQMf2zENfgxfaojZkxLk2esCeSPd2NnVKRSazDkLC?=
 =?iso-8859-1?Q?DIzb3KI9AR5B6zh6QE8X3FjD5Bq3oS0tPuX7qAjOatVNTDNZwmLDuWwPvK?=
 =?iso-8859-1?Q?Xh24N3fhUQA88j46dQ4l8tt/aA00gD3i+GzdUi5YFTU0ZoqtpOHxoTLeBE?=
 =?iso-8859-1?Q?8nuKQPH9KnNxsch5aQrv7FD3gxV86sWyzvZtjR0PnDqxB502/isWLoqa+R?=
 =?iso-8859-1?Q?rfGbeq2hpcolOHYt2YTxczldMPVTTvf/QAJpLf3PGmKkFtwVo7qyjEbm+k?=
 =?iso-8859-1?Q?XLMUQUehO/as/GmTc7R/cf0JYIJl92Vd2aeNvsOPN4ZtnS+HblHtTOMQ7V?=
 =?iso-8859-1?Q?78AdP2suynrmrYOlFjIGSZAAt1L5l9E9xeVV+pK3sNRgO6uAwjXG8P5wUN?=
 =?iso-8859-1?Q?wgPnpQSZSyH4IfEhs2nrU5t87mJlIMrvmpIOEpTwU9vJK2uJKT6N9RRf+G?=
 =?iso-8859-1?Q?hXSL/ZCGgaynTYb8il2AYPIhRDg3ZYqtwuSacE+cPTooXcRvRYaWl0Dt47?=
 =?iso-8859-1?Q?0qDeGd43bI+P/fNXOo+2w0U/wB+8NHvW10gEyBJhFOWJen7XRX8BRtdIQj?=
 =?iso-8859-1?Q?U37nQ2cL86UdSPoKI0Nuj+Lq66LwDlZwS39xS85Wwz1p+RrApueJIWM96k?=
 =?iso-8859-1?Q?w8Qr9nwoQ4z+x7Ps+TGKEGh39MtjDA7GfUELMbaCVQYUCDTuZylGnMHboG?=
 =?iso-8859-1?Q?mmN5MHWzrjESPSPPG5MJAwc9deUFvn+bawYvt68xAEi/4BtE060A/zET9J?=
 =?iso-8859-1?Q?WJv0BuFBO7PTLIyPhybAp7c7+3akj6C8CeWbgViLsSr/v4VN79x0K/1Zj+?=
 =?iso-8859-1?Q?Io3YO40eUCmh59kJpCVVKmT4/+QDzbwP7g+0oNuVtwRWq9EqWoIUVfz6hs?=
 =?iso-8859-1?Q?QWCvXX9+3jwa+r0WH3DMvxJGuZ726xBg+P3LjwKWWR4lBnoA/CM99U7tFw?=
 =?iso-8859-1?Q?QsMcmwbflw2rpX0hT0tk3JzyTaBV7uSS5G2dNIijZOuLdk+8ejiWcOCT8o?=
 =?iso-8859-1?Q?s8U5Tm8LICFdARrOi94Sk7kAK2KumDQKzyuRed9hYm6PIgJfXJ2FHZEUS6?=
 =?iso-8859-1?Q?PIaGpaD1zUQT/l/SWpeYZRn6jVYAUAWKK8d+KmEZe7CUL+q9J1zYI4Itvk?=
 =?iso-8859-1?Q?+55mrzhkPyhLVm0bPsECDFSR/OQSP8jfgUoMmbVQdz+MQ8otJvSU+P/yek?=
 =?iso-8859-1?Q?E8as4tBKkg/fw2zyGCjc65JdCqzAJFU=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 69aea58a-8cae-4ee7-5c72-08da53c74f42
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Jun 2022 20:47:08.7534
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: perqVOj57LoD6XBbWOWVgsQK7B+HQXJBQcQOEvDlk/gfkwMWdQOwt4YrE2MKHz6UvwmQWbvbjEXf9J/7K6wpBw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR10MB5392
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.517,18.0.883
 definitions=2022-06-21_09:2022-06-21,2022-06-21 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 bulkscore=0 phishscore=0
 mlxlogscore=999 mlxscore=0 suspectscore=0 spamscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2204290000
 definitions=main-2206210087
X-Proofpoint-GUID: pJYpqZcwzk09xajCKn0opxO8szlzcLtJ
X-Proofpoint-ORIG-GUID: pJYpqZcwzk09xajCKn0opxO8szlzcLtJ
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

The linked list is slower than walking the VMAs using the maple tree.  We
can't use the VMA iterator here because it doesn't support moving to an
earlier position.

Link: https://lkml.kernel.org/r/20220504011345.662299-33-Liam.Howlett@oracl=
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
 kernel/sched/fair.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 77b2048a9326..e8202b5cd3d5 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -2734,6 +2734,7 @@ static void task_numa_work(struct callback_head *work=
)
 	struct task_struct *p =3D current;
 	struct mm_struct *mm =3D p->mm;
 	u64 runtime =3D p->se.sum_exec_runtime;
+	MA_STATE(mas, &mm->mm_mt, 0, 0);
 	struct vm_area_struct *vma;
 	unsigned long start, end;
 	unsigned long nr_pte_updates =3D 0;
@@ -2790,13 +2791,16 @@ static void task_numa_work(struct callback_head *wo=
rk)
=20
 	if (!mmap_read_trylock(mm))
 		return;
-	vma =3D find_vma(mm, start);
+	mas_set(&mas, start);
+	vma =3D mas_find(&mas, ULONG_MAX);
 	if (!vma) {
 		reset_ptenuma_scan(p);
 		start =3D 0;
-		vma =3D mm->mmap;
+		mas_set(&mas, start);
+		vma =3D mas_find(&mas, ULONG_MAX);
 	}
-	for (; vma; vma =3D vma->vm_next) {
+
+	for (; vma; vma =3D mas_find(&mas, ULONG_MAX)) {
 		if (!vma_migratable(vma) || !vma_policy_mof(vma) ||
 			is_vm_hugetlb_page(vma) || (vma->vm_flags & VM_MIXEDMAP)) {
 			continue;
--=20
2.35.1
