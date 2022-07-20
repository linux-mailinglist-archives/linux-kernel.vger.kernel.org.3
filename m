Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 26A4757ADE1
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Jul 2022 04:28:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241191AbiGTCWA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Jul 2022 22:22:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241108AbiGTCVJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jul 2022 22:21:09 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF75B6C133
        for <linux-kernel@vger.kernel.org>; Tue, 19 Jul 2022 19:18:40 -0700 (PDT)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 26K1Ktu4002392;
        Wed, 20 Jul 2022 02:18:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=SRA/1SZj6DZmRnf4xBZCV+CzOr6m1eQvusd8VlWkgRg=;
 b=gQdhVsA/us1Pu8tIB4LaDD/LLVNxX8gxL2cUTOmUbw4t61Dm0I5drMMDpS441r7YIvQM
 ePdB82/B2ZEqU6xhYxH4qAOV13/AJo4fviJ+Se88Auu9Ya9ybVsvyd1cogkAVbuhFEj4
 mfGPb/UT0C4Bs/m2IH39iJ3AgNMM0K41ClEtYqVpOLOYgLpFgaQ36W5iu3HBlbwZa4vu
 IaXoXl/+CelTrlAtc43qDmy2gp0SstH3/X1GIi/q5H2pCcI9mnkLwYcYDeRwEvzEsagt
 bB+zTe/a7XdzrAO2XhF6Komon6Drh431svljyJnNIBVNOkrGGXzDBd78KnxUCPfGzVbc dw== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3hbn7a81n4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 20 Jul 2022 02:18:33 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 26K1UAlf002689;
        Wed, 20 Jul 2022 02:18:32 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2101.outbound.protection.outlook.com [104.47.70.101])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3hc1mbnuv5-5
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 20 Jul 2022 02:18:32 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MYS61g0gCu1kiUn39QoxI4HJO4C7sFX0LA0ERxgnk6DJx+juK0erVccvtSvA90fBmd7SSEKJXDHCTcgj8O6Q6EH6E8Gx6lzZDElYtsntNe9l5GfZ+57gGmgVNlZsw5z1iZ/Scm6vwZtX3PNyWYd78xUVwqLifZE0tuY+qReVucjoBdVwFW8243CuCv2Ac2UldTqb4Tdkl3InjIofcwqXVj6K2gnxzFBTivHS5Vq3jrdCN3A4S+f0WMy/hJV+1IP+p8uIpQHyNe2FHT9LztJZuq485/PPqQ2rGTRoJnm6ttAKkw4SbXoy5Kp/WIqbb7wtXFmptlecc3hXBVoIEqaZrg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SRA/1SZj6DZmRnf4xBZCV+CzOr6m1eQvusd8VlWkgRg=;
 b=NK+sOQHuP5v9fAD0ddMWPICX4dViviYJO1oZgw3zNhJlb9cRfTuL4QTiPkRNnIdt6RTf3fCw+QBQMh0lPtlRjASzeGR/T8khgv2QprIlF0IywwX9ehDZBWoAb//KVR0/pQLtvXM5vdECG9fkToCSXc2ype+uwQGCCWM8JVsBJKDPpJ1/iR2KYPaOorYcHc6dxwYyK2Kbgr1qynqrnb4+pIlQMyRnqkUreEs6xe0u/YOrnKucjsJugN7rKMbJUGtjFgeOatXvg7Vwbw7Ba9rPYiA5SzXnu/7wd46/Hux37+jQxXA57kWKFb4x2xYC42z3WTfKQB4pwdx+/3xqGEBEUg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SRA/1SZj6DZmRnf4xBZCV+CzOr6m1eQvusd8VlWkgRg=;
 b=vN9e3V4P/AJuxmmkLX6XeyyjStdzfcttYbE71ZW0hhiVMj6H/R8ZTk8ZVpjs4QuLUT3FH1HgRQxQspGq3f4w+v/2FlQGXMyVogp0YRH50sTyYT6sDryc1H5nWtRJXeuOvtWpmpBJRfPGdaiRWLTM+lWWQRbYZrFV+KI9NX+NQ/s=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by PH8PR10MB6316.namprd10.prod.outlook.com (2603:10b6:510:1cf::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5438.22; Wed, 20 Jul
 2022 02:18:31 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::c4d1:edc3:7d21:7c68]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::c4d1:edc3:7d21:7c68%6]) with mapi id 15.20.5438.024; Wed, 20 Jul 2022
 02:18:31 +0000
From:   Liam Howlett <liam.howlett@oracle.com>
To:     "maple-tree@lists.infradead.org" <maple-tree@lists.infradead.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Hugh Dickins <hughd@google.com>
CC:     Yu Zhao <yuzhao@google.com>
Subject: [PATCH v12 34/69] s390: remove vma linked list walks
Thread-Topic: [PATCH v12 34/69] s390: remove vma linked list walks
Thread-Index: AQHYm97r4IGQ2SbvmU+y8eCn3GKPYA==
Date:   Wed, 20 Jul 2022 02:17:55 +0000
Message-ID: <20220720021727.17018-35-Liam.Howlett@oracle.com>
References: <20220720021727.17018-1-Liam.Howlett@oracle.com>
In-Reply-To: <20220720021727.17018-1-Liam.Howlett@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.35.1
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 17726c53-8268-4657-a954-08da69f623cd
x-ms-traffictypediagnostic: PH8PR10MB6316:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: mem96KwL6CfZIO/V3ln+lgO/III3gf2r4fW5gkod0Ah1GES3qDvy1i9QZgABN3DiN2wdfharD6j+MhN+o/LuTWd+8jAvUdvtFR7Ikao8bOxIlhXVTyFjBQ9z4OOGUBM8x9wGTyorGOXgULsMSCfNW+FCiOGPxSapCoOaVXLvHj/Biwwoiqy2gZWfBy+f6vsNKAE8tC2865f6PbKeurepdwkX82pPmU5/Jkp/lXIrRFypi1lNe8CbFru1H7TH8M0Ti/F93t7OB8LqkYrZhDpgSY8tGvqzsXkyEwXV4nuKF7Fq/EsrIqxR4+XjxrGSze7n+tncvSOaqJVzndDdhnPX6K+IbRAcA8cIM2xHbW6sxKQrNqCr0iKa6zX5ViA5uYmCqsL4WVqBHUJNWVUfEy57XyhupuWWl8UxyRDD3kxo5S5jvoXhw3VlQbBi31Hz3mpuaHnOc0p5Ycnqp4KWLRI1huJY7xa994QLwTGgXZQSKhVNOIoUUjlaijvrNguCeOID5OrzOFLvzv3sCe58wiKkPit1w2WNef2znqNuSqZAn4TCeKoqytIBBVTEq4Nv5e54UECxnHYxpkYzZtTSMQHeG2wAnyBjaFoLfUcXiZqEzTaVAetskajG6DAcN7NosiDRiHfNx2kfzkvslRqbJDWFPOnTATYw8C/wJmUni42lv1sn8HR0SITgeie9aZqTmnXok1KDEtDFouFB1LE/vzaUyN3lm7rf6tAcsWAL0D/eYWxxlk/MULggjGceNcOA6b+id1GIZTNBVIF6id/AU9gtf21GQJ4j/VPVHgquBzXrgBzMuWS0Ok+pgO0uBsKpY4z6OkjHyNVqYSd10t4jAvu3v6k9RN7mdwrxzb7xJde5f+Z0/fyMuqeOi6DNLXPP4Ato
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(346002)(396003)(39860400002)(366004)(376002)(136003)(76116006)(122000001)(44832011)(8936002)(5660300002)(186003)(1076003)(83380400001)(2616005)(4326008)(66446008)(64756008)(36756003)(66946007)(2906002)(8676002)(91956017)(66556008)(316002)(26005)(41300700001)(966005)(66476007)(86362001)(38070700005)(478600001)(6506007)(6486002)(6666004)(71200400001)(110136005)(38100700002)(6512007);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?fByo0Gu3XH/VW9HwxqqWtTxWOXIjW6P+amGbML0y8vbU9Jpv8Zs1zN25XC?=
 =?iso-8859-1?Q?nTjbDpMUhAwmyO6VARWU+oH/RTlNxYxd4P5Hxg97sfijfbBGz+Kljf9iiL?=
 =?iso-8859-1?Q?On+YjYwCHj37VOl4UPb02bW+SG6SfwWAP8uLyLuZGmkqfhX8sOJu2gE6oA?=
 =?iso-8859-1?Q?G5ffmCnRwu72y9Dx3Zt++xJPPQ1E2DDJU54WlQnxbBKCKcg2bLyHMTHU6a?=
 =?iso-8859-1?Q?0yKCjfWC5vD+J/Z4CP5VZj3ZnEu1DA0GvVLp5YzfXpFQj56DovrjpJ4Fn3?=
 =?iso-8859-1?Q?ZyzISY1wd03EnhiDHeLQdX9mcDJX2hmvbix6W4eot12l19D9NVwabu+WEi?=
 =?iso-8859-1?Q?s3xtts+W1+l6e3QiHTj1gq462bqm/7q+4aHLYKintdlFl99fSALKFfkK6X?=
 =?iso-8859-1?Q?jrX0n2GWdsF0EgMeGTFHqwmIiVU7DNIu+50GiU1OcDXUStkKvR3U9ggald?=
 =?iso-8859-1?Q?rbvQoG9zP7IcHlhnVY0z4Mo5IxjtjxHyA9yVJHl22dquCy16/RmVMqnEN8?=
 =?iso-8859-1?Q?JFz5LJ5ImMhhgzPQznOH4Km75HW+vPIbkBnZ/Npv+vwMKrCjK3THEBY/br?=
 =?iso-8859-1?Q?JDJutf97GNM6cNp8Ch4IgyWt3wWyQCE61MDgfsmfQIJyz2QYA9j+dLoCHA?=
 =?iso-8859-1?Q?AOHLnYXbEz7Hrld5ZP4wRNJPh6OKVmtzR2h1djGr6DvhtHMWIuJSN4Qni0?=
 =?iso-8859-1?Q?hKrdG17hKlTZhAEhtBMsnKo2n0P7GIZkDXRl16eNXW6apLZEk9G7oYfLPe?=
 =?iso-8859-1?Q?in3jIbUYEPFLEG2Ijhl2sBb8xh3QMGuxH0CVEWw/ZgFiaN7Sya/94SyOQy?=
 =?iso-8859-1?Q?1iZsURvfm9ZBsU+ObcdABuv4IzOYS+blYlIMAP3yA4MQO+SwUyJ9bHc2sF?=
 =?iso-8859-1?Q?Y5FNwTfnwf4r/ZrkgXthFxw4qX4dPEVhGep+lnHbiA5Q3l2Uzl9YGJzrDk?=
 =?iso-8859-1?Q?YZtqtIE2WA7ayBkDxwiHp+bO+sFN6RhcF85CTAlixC6RXcmWElMwAkGgk3?=
 =?iso-8859-1?Q?aM7002OO4+n9mesY4azffCR8+vBysrwwWcL8OVDpF9s10KLZ73SQQuTGfC?=
 =?iso-8859-1?Q?Bmg4BROnsrlsECZelYvyKRxn8431jYzhWrxoSnHF7nOBvZqm2U6zGZObrQ?=
 =?iso-8859-1?Q?sz1hkPiKVY5UKUvbuF9RavFOD1KmTiW5dxBgF5oVXvDXvpsFROAPccKOhb?=
 =?iso-8859-1?Q?q1MQcLK7WPIyKUfvqUD+UxDmZWR8lvjCWdcaxQMc3C4b8VUgUL1K1Z2iuJ?=
 =?iso-8859-1?Q?ZnnaER8Gz2jvLwAtgaWyhSKf18lc11X8I4wr3Lv0m5LH8bZwXIjfWMHoc0?=
 =?iso-8859-1?Q?gfO6bxFkm9AvDgiqB1yiO6K9D+e3gzNqxzCpQBqGEmQ7+X8PHYXjtuM71j?=
 =?iso-8859-1?Q?J3aPmbpPqY8wIEf0selOGfR/qgBkMHQOceFIoou2YW41Z/xQzYSAyk6xTg?=
 =?iso-8859-1?Q?83Z0ICnw8eASmGv/A9eTjLQ+FaWWGXGJvrxJDJD1fRq2uNNfUDNukoxnAX?=
 =?iso-8859-1?Q?iKj656DTRhbj5CFpANmSN/wjDoFBcwgui2AEDWnZGKz0QUVRf8dh6xLZxp?=
 =?iso-8859-1?Q?zJkwEn8FhgjogLsrMvxPOpPc4aA5btvH7i9Gd23xa9/nXQZFxTA6WAjnVK?=
 =?iso-8859-1?Q?lFR5OVB2XuWk2WlZKCneyitNe0/NeeQrSPvY5rmQdjdDaeUVIfIs68Gw?=
 =?iso-8859-1?Q?=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 17726c53-8268-4657-a954-08da69f623cd
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Jul 2022 02:17:55.1806
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: dJ1+/fv4AkQctc8hHjE/V56Y6ZBJ97JH2ytYRJpzDs6graOnzBp3e+N8Vz9NJRcFFD3n/az6MHPmnhjTg94VRQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR10MB6316
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-07-19_10,2022-07-19_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 bulkscore=0 phishscore=0
 suspectscore=0 mlxlogscore=999 adultscore=0 spamscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2206140000
 definitions=main-2207200008
X-Proofpoint-ORIG-GUID: JuSTWROBpsBxcrHzEAxbi2bUntoBiy2e
X-Proofpoint-GUID: JuSTWROBpsBxcrHzEAxbi2bUntoBiy2e
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Matthew Wilcox (Oracle)" <willy@infradead.org>

Use the VMA iterator instead.

Link: https://lkml.kernel.org/r/20220504011345.662299-19-Liam.Howlett@oracl=
e.com
Link: https://lkml.kernel.org/r/20220621204632.3370049-35-Liam.Howlett@orac=
le.com
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
