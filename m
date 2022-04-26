Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E0CD151016B
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Apr 2022 17:09:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343749AbiDZPMF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Apr 2022 11:12:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352098AbiDZPKg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Apr 2022 11:10:36 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9BF29159482
        for <linux-kernel@vger.kernel.org>; Tue, 26 Apr 2022 08:07:28 -0700 (PDT)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 23QDT2PG015535;
        Tue, 26 Apr 2022 15:07:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : subject :
 date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=Ukqb2QQQRBNcHyQVxqkE6N3xK8UmeIbkvheRC3rRcP0=;
 b=Zu3RITuRWETll1T26iGhTGe0KMU+NL+t/4dGXufZ2BBZB0PBxSWEkipvOqpdxafBGDhc
 VQ6hbH/YMeTN3FONJSP7LOm4FQh5kYEf7f/rpEZi/mp0rUvxEHgaH0qAAkW51YI/NoYR
 0FKC3sFuHFwdF1ZE5V7D/oNC4ZQo+AtuS8WYHMpSiVut6army7DrnxYxK03B1UQfaHr8
 e9QakEH4zmzhR4aJcSLoN7KoQ3yVzimSrcpKFw12YR12l2Ai0gkjPMap86Ui5Iv8n//u
 AGqMCZBQP3cs8gMEUSAparsaW/Cyhr8H6+8tYyBm5YLJ4KaXCbX41J/VxleoxNfKOaxT NQ== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3fmb9apbq4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 26 Apr 2022 15:07:21 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 23QF6Uo4037883;
        Tue, 26 Apr 2022 15:07:19 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2177.outbound.protection.outlook.com [104.47.57.177])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com with ESMTP id 3fp5yjkugm-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 26 Apr 2022 15:07:19 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hn9ibmy5/K2+s4B1cpwBvEGE3V4OwZ3Cv831KfAB8mG1FTeNCqeKbpT/PjPmsaed8LTjaOFvK9fFK8AMTQgcyFTqRcQ+52ODQ6JK+pe9T1cdrwgeDruD/HksggtTgmQS+fQiXXShhHT0uzbnv5dUX6CK97f+XeZW0MJnuhoRNFAlWhRXqy2Of5tFIZcjjikWYCEAENLFouGcDHm1ci+TjTEbPpiTCVVrt3FF3ov2d/q/rByL1kUsnvibaDriBtWd4HI8U4zCP8ALiKmowvjvLdJkQsdiXWDDmAIH36UK2eoxHw4v9+nbfX/PoxY5HvKKOraVhTGyiMIcPjyAMrMfMA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ukqb2QQQRBNcHyQVxqkE6N3xK8UmeIbkvheRC3rRcP0=;
 b=YLzT11p3AAii+5v6A1jb5Irih/0SueaL3c2McEA/MqPp9C3Y5i41C9Z/WDlA425q4I4x81DZi4udKS17PbpUPCP4bT1FNIfG8lNO854Q5tTP2qpAwuXeQS3xbqub0SQM2wK3mebbk1onVLNMNHKDrEJ6hpa2qHGewk0/JVSkU9fLftRyJMCK7ihr/dK2qZhD29feyHMZMyOea+PyulSwF8g03RryBentEmVK/E3WWcKthUqU9EoOChlOr7Hn4I+Oi3AHLfEeuToBOkKUSL7PHA5Ayw2LnCYwON7igHCo9Ny0vC5rsJ3V7d/Iar6GGGCaZyUwVZMrHk3ax9qdcwagKA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ukqb2QQQRBNcHyQVxqkE6N3xK8UmeIbkvheRC3rRcP0=;
 b=R1p0RPoXM4W8Slefygdhxn+hUfLu+Sqodo1xmUoPyFXPlA+tPh8w7IV0TvQfYiNeAbDg6qMXRrm/QW/aWdkdKqs0kdA7J5pT47tBwfKv6shbY5TCI+BjH70SwYSr/fWY98U7GFya3Iqejxox842eMHAi8DCSM4nMnur97wYLYjM=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by BL0PR10MB2929.namprd10.prod.outlook.com (2603:10b6:208:7a::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.13; Tue, 26 Apr
 2022 15:07:17 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::318c:d02:2280:c2c]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::318c:d02:2280:c2c%7]) with mapi id 15.20.5186.021; Tue, 26 Apr 2022
 15:07:17 +0000
From:   Liam Howlett <liam.howlett@oracle.com>
To:     "maple-tree@lists.infradead.org" <maple-tree@lists.infradead.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Yu Zhao <yuzhao@google.com>
Subject: [PATCH v8 40/70] um: remove vma linked list walk
Thread-Topic: [PATCH v8 40/70] um: remove vma linked list walk
Thread-Index: AQHYWX89p10Gi6H2p0uBMzSjiyoziA==
Date:   Tue, 26 Apr 2022 15:06:42 +0000
Message-ID: <20220426150616.3937571-41-Liam.Howlett@oracle.com>
References: <20220426150616.3937571-1-Liam.Howlett@oracle.com>
In-Reply-To: <20220426150616.3937571-1-Liam.Howlett@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.35.1
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: b4eb3e5b-ea74-4196-f21a-08da2796740e
x-ms-traffictypediagnostic: BL0PR10MB2929:EE_
x-microsoft-antispam-prvs: <BL0PR10MB2929AD3C5ED64BBD9EF543C9FDFB9@BL0PR10MB2929.namprd10.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 2///ycA4qLKbHPkcv/73pwccXAGpBSvevx0kKsjD772lBhFix+vnWiAbeWin4yaRGLciiMuHWB9mQWkKDmbdCd13VLC8nSU8zfGVLPQFrgG2OASw4Q5uEc/7xeypzeJbJxAqOTL3sOn8AEyqiU6NoHJcnogudOGvjzLbiBjKrHkAPNprUoKABx3+cIiKSWCadd95MKDVxYp6/qM9m5OetlhJjqP4pBdSzzPvuGn8t1CaPEzJJmqB5fUxg6xNy6yWyRxHL8z5iItsBg9SqPaX09lx5iWx6A3hlV3AO//q0lqaWnXaE6iF25Gs0r8pUkUUUQ+9aHlLdEZX2g1AgxH5YlcPAbPXltEAbNL1BTTTga/FONKahzFzuZTrci4nEgQEN+MQPNbhxj/nPQOJdHidB1GeieQcny0ms29MjIi4ZNxxxOlM39LyqiYWKPm0tB/YC/vR8ReIof5dPgjcYUhEr7FL/wmkoCARGn/eh9MaO5dC4Wovr1P4HDlnGNFNMKfu3ql//fj+Mlk1vjuZqWLpZyMSQOyHD8FLyYT66TQpAHuTToEG3wpNxPyxP0K7ZpFIVzwo0FteTkTScX3/08Ezfcj8WXqCWWD5TKZXWLn7EQ3hrt8KhX9r3cW4tW22pM9IbnDQIU+XY66jT01IzZmWpKM18Wr50LdWLo6lwRzZlSpEWnGYvai0gHzQf50yQa5fVIiE5HWFjmYBospZykOFHg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(6506007)(86362001)(44832011)(6666004)(6512007)(2616005)(5660300002)(38070700005)(2906002)(122000001)(38100700002)(83380400001)(76116006)(91956017)(1076003)(110136005)(316002)(26005)(186003)(8936002)(64756008)(66556008)(66446008)(8676002)(66946007)(66476007)(6486002)(508600001)(36756003)(71200400001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?Beo7SrydM78kDzZVO9aOIB1egSoww/Nhc2S3PsF0rWGtBHROPfHH8vJUtd?=
 =?iso-8859-1?Q?flODuQbIswXM0dfG8l7kfTQ9Cshh+c9Wqv3qvji6dfrB2K39bIA5JRvDBJ?=
 =?iso-8859-1?Q?UH1LQOTU6OtK6/CyiJ8/S8TOjDEB7ThfuvsLWM9n17Lg89G5WvDcvXXSFy?=
 =?iso-8859-1?Q?5y1N85czODDGjeyQ7rMz4nL9nR6LDzcVTz0s7OCosdHrUct7fxnNz0X6yP?=
 =?iso-8859-1?Q?yzZ15ogpcDdF7+jRNg6vczXwU10KtpN7LColvuzIfCwFog5DC11sZCX8P9?=
 =?iso-8859-1?Q?oyPAg6TxsRS17gFTjRTfizePfre7WNyCtN8fQ+RdRgB/dRaKmbvlbTdTEi?=
 =?iso-8859-1?Q?hvS2aFDgq+tVRGdI0Ue/6ZJ/InLPpROvyg5G2mgZvwx+iOYXNZxi9NfoYl?=
 =?iso-8859-1?Q?tTuJAbqOxPRq1k1AC4HYcGS0O0+i7G7mUGIuoAhYtaG3kZqNhFNRVrS4in?=
 =?iso-8859-1?Q?MiNsub/sVDu18x3mk5xd1l7d6LVWijRUYMFPkxqy0O5jEHxKNa5FT2KyKD?=
 =?iso-8859-1?Q?1rO84ke5Mai0YJFACMma/B940C8q5tiVtnW3yOXbIAytVx0A0srBHHkq0m?=
 =?iso-8859-1?Q?+yQp1VFmsb+7ayuqWi+vQPEX8pKvFzH9m482kQ+pSn0F32x28RFiaRqsod?=
 =?iso-8859-1?Q?phyTYHpazMW+4CMT1oE46sa+6xe6TqJOrk5FIPtLk/w3jRnSu2KpQM+UJO?=
 =?iso-8859-1?Q?NERj6BisnnnsTPtovOirWXwS7t397PXOXeRPSgyL1u+mk7W+JpufiKeSzu?=
 =?iso-8859-1?Q?UIvb8Jw8GfHcn/2NjkHzOYZnfmqzgfqo8aNVKzyWq3U4d9XaKy5PV7hZ/W?=
 =?iso-8859-1?Q?TQ/GEQk3oZ034xQLRt73Qv/BQ8s1PWscpUCXq7HGL/cJAZGTjQnIVWsaYd?=
 =?iso-8859-1?Q?ETejYYYyV8EeZvggLGtU6sQQY84NKg0AWZSnFTS8rKYPs92ABb7acE9KeY?=
 =?iso-8859-1?Q?ppylHMtWEkdPXDjYc5LzTa7jMH9TMfrJIymRYwG2D8ZIEY0DN4FlnW8zEO?=
 =?iso-8859-1?Q?byJY8ZMMb0ynelOxSkxEXBXPVYDkqpqjIKw5+iGfLN9EGTgDp7NpLyLihO?=
 =?iso-8859-1?Q?MrEtn6os+gyd89IzNnKnKfKis7HUp2pA8Ht2NL04D7ukT5fx1NQY25ip8T?=
 =?iso-8859-1?Q?mgCRkgcOScKHmR0/Mot9d9/tBjntHyEIeuMfTEoU4JLYYrfakvNz0kwV/D?=
 =?iso-8859-1?Q?WJtAYz76AF9t7gULlgRcRwARKNf42P+rXUj7c0db58r1sv72qWHvhoNzr4?=
 =?iso-8859-1?Q?flioIMtxsdG9yTFalyNUEg1MtWCILEstX00u2QrmnvevBzCYFv6MRBO5il?=
 =?iso-8859-1?Q?bEWMWHpJ7kZmzgTHveFbDIxzTqvxBUVgs8oOi7lkTvWXPAEOBS2k6oWmhx?=
 =?iso-8859-1?Q?rtNe+TmChgNSNKlBSL9r4pekcSMtQ0FcS+OghZZvgUIDuqqkvJJtTscoTZ?=
 =?iso-8859-1?Q?bR6LG//jU2KTEAfUsjYLYVC4n7nO5hk8FI4TARe0t9VUQ4zm7/fIRbzyjR?=
 =?iso-8859-1?Q?DHL2MrbDIfjjed/MOC5UhTWVMt2722fN+76iuzqxhPurRNuU887Du0Jm2R?=
 =?iso-8859-1?Q?BLKucP9qk5mfaPmc/q3tD1z4EOCWM/47o4e93uvqwNTySFuJ0VmqRfuWrf?=
 =?iso-8859-1?Q?T5e0/n13kKhK+Z/G140H3ZSyYmSrwukqS4MJbY8mjs+DbpVQAksRh8LXrc?=
 =?iso-8859-1?Q?BQUrX7aw81IRhxFPkfzaOAmKSANFdZ4MASMnpaVNYTjnBO2z8W2gz8v1tn?=
 =?iso-8859-1?Q?KEoO1mkeKcvhdDyx49jWPS/s4yUa2aWALN9SJmTWCkfUa8lmwDU7WOCMRY?=
 =?iso-8859-1?Q?AWNa8GhtEJ4n3lYmo+lfZR4YgdCdHEI=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b4eb3e5b-ea74-4196-f21a-08da2796740e
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Apr 2022 15:06:42.6927
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: PEUKiywr4ql2lxvoYD1RdKfMatLwFfJP7BXgabu6afyeK3grnHQ1vWTvOI4YLUUyQ33e8i4NO6lM5wBkkn1IMA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR10MB2929
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.486,18.0.858
 definitions=2022-04-26_04:2022-04-26,2022-04-26 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 mlxlogscore=999 mlxscore=0
 suspectscore=0 malwarescore=0 spamscore=0 adultscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2202240000
 definitions=main-2204260096
X-Proofpoint-ORIG-GUID: kpO9wFrr-wySUV667-stgAWXbUODJslN
X-Proofpoint-GUID: kpO9wFrr-wySUV667-stgAWXbUODJslN
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Matthew Wilcox (Oracle)" <willy@infradead.org>

Use the VMA iterator instead.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
Signed-off-by: Liam R. Howlett <Liam.Howlett@Oracle.com>
---
 arch/um/kernel/tlb.c | 14 ++++++--------
 1 file changed, 6 insertions(+), 8 deletions(-)

diff --git a/arch/um/kernel/tlb.c b/arch/um/kernel/tlb.c
index bc38f79ca3a3..ad449173a1a1 100644
--- a/arch/um/kernel/tlb.c
+++ b/arch/um/kernel/tlb.c
@@ -584,21 +584,19 @@ void flush_tlb_mm_range(struct mm_struct *mm, unsigne=
d long start,
=20
 void flush_tlb_mm(struct mm_struct *mm)
 {
-	struct vm_area_struct *vma =3D mm->mmap;
+	struct vm_area_struct *vma;
+	VMA_ITERATOR(vmi, mm, 0);
=20
-	while (vma !=3D NULL) {
+	for_each_vma(vmi, vma)
 		fix_range(mm, vma->vm_start, vma->vm_end, 0);
-		vma =3D vma->vm_next;
-	}
 }
=20
 void force_flush_all(void)
 {
 	struct mm_struct *mm =3D current->mm;
-	struct vm_area_struct *vma =3D mm->mmap;
+	struct vm_area_struct *vma;
+	VMA_ITERATOR(vmi, mm, 0);
=20
-	while (vma !=3D NULL) {
+	for_each_vma(vmi, vma)
 		fix_range(mm, vma->vm_start, vma->vm_end, 1);
-		vma =3D vma->vm_next;
-	}
 }
--=20
2.35.1
