Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E37BD519371
	for <lists+linux-kernel@lfdr.de>; Wed,  4 May 2022 03:23:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245190AbiEDBWs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 May 2022 21:22:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245161AbiEDBSR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 May 2022 21:18:17 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B783043489
        for <linux-kernel@vger.kernel.org>; Tue,  3 May 2022 18:14:43 -0700 (PDT)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 243KvDsd027626;
        Wed, 4 May 2022 01:14:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : subject :
 date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=JDvlL1KeBiorNzZwj5NzYRbgwcuQezTZc6jTGkCSRz8=;
 b=KuQ34eSm+SkCkVl6kVrEmUauEnH9Ey3c5Jgc7fdGe2PwJ5NvkyfUcsJZpm5dWfZ2eKJa
 kEAWGVLFhyyYzHhowq8QhW3oF2C5T+yzkkWmOcGhzp6+SZZ+E2HVoxh8aYXXkkbQTAB2
 Su+zAsh+AIW3cgWiyl6DaGzMFueLSn9fOySvG7ngrDU4NKsBmyDmzPORy5OddEMK1fz6
 f1vLzO5RUCXGI46dcgVMMmopRiH6hmkqEShZfi3mbSHD8I1KD+Ya/sqlELGnDdNofYp9
 dpn94FFW+G1mAis9sIqyJ0Gw3aITVG55GdTwY+3dzBfS8URIYAQO8qgbK3Q+D33k89Vq iw== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3fruw2f6c7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 04 May 2022 01:14:40 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 2441BXQu013207;
        Wed, 4 May 2022 01:14:39 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2049.outbound.protection.outlook.com [104.47.66.49])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com with ESMTP id 3fsvbmv41r-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 04 May 2022 01:14:39 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oF1lzDbgJjhZ/fu339kJZa7ic1cpgfOtf2axR+savGyfEsHSzXJKP1Aqfd4dRXlu6PW2XBVtys4UuV99jNi4QN47nMSjhq4qNopsu8ScP9GatC4TeIuHavyhb8wmJx7SdIhBtRLHceUA4bQ/QIjsErKR3ZbG+N5nxjZosahRDgwRzrItvndjwFXbj+R98mtpit92o88/gMpgS1MUGCKahZogwqv1Fd6SIgUdlJz72KoX1njzI5qc+/pqyAaH/NM+hxLu6b2UdTEY4LGSzhdPviDLiW8IY1wnZSGN/8p3i+l6MZwLdvc/hScXRl+IZU248bdspKvkR3xSwwf7r3tWsQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JDvlL1KeBiorNzZwj5NzYRbgwcuQezTZc6jTGkCSRz8=;
 b=folUdWGj9GixeKLptR3ZeZrfS9FaqXxO8C7Mtk6xu0bxVJ0bngcEVIjU8R410qcxPtBYGeYIOfiVTScXaZH0PcopYvsess9Ehv9JsBt3p1QK6hWC/4rL2hu8cy+VlsLuFRKDg7ig8z7aSCLGkyEeOdLPZpYPfMSb+/3OqScMCoyidkX1hbFS4r6fr5+H+lkXXpdKOpD7fTE023dHkzvFYuNqP8WJFCX2G9rQB7RGPN6psdJcq0ziuAwFT5Xa9n6On/hHOnh4AU1K8Gnv8DkwzNWMol5iJhrqZqZz7ZtHsAmFIxAVYOhW37tlk2ZHAGKb3sYeInaJgck3dt4et8oAkw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JDvlL1KeBiorNzZwj5NzYRbgwcuQezTZc6jTGkCSRz8=;
 b=n5mezdLyAElZh3WXfzgM8yNX1NQNmoRpbRnPtkhIwQoOu+oJ26q2+PK08cQ1E1SJy/Xyn8FPEH15AqtjYKKXj76/TuJw/Aew/SpMTlzUDVTukcF4JezazhK80UE45k3/mCnSjNrm44frpvQb8pNPwUFyPf33V3GvIG1+yRyO2f0=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by SN6PR10MB2688.namprd10.prod.outlook.com (2603:10b6:805:4e::31) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5206.13; Wed, 4 May
 2022 01:14:37 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::318c:d02:2280:c2c]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::318c:d02:2280:c2c%7]) with mapi id 15.20.5206.024; Wed, 4 May 2022
 01:14:37 +0000
From:   Liam Howlett <liam.howlett@oracle.com>
To:     "maple-tree@lists.infradead.org" <maple-tree@lists.infradead.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH v9 51/69] mm/gup: use maple tree navigation instead of linked
 list
Thread-Topic: [PATCH v9 51/69] mm/gup: use maple tree navigation instead of
 linked list
Thread-Index: AQHYX1Q9GShE2LuTbUu/7nXZYdTL3A==
Date:   Wed, 4 May 2022 01:14:02 +0000
Message-ID: <20220504011345.662299-36-Liam.Howlett@oracle.com>
References: <20220504002554.654642-1-Liam.Howlett@oracle.com>
 <20220504011345.662299-1-Liam.Howlett@oracle.com>
In-Reply-To: <20220504011345.662299-1-Liam.Howlett@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.35.1
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 377454c7-f4e1-47d2-f04b-08da2d6b74fd
x-ms-traffictypediagnostic: SN6PR10MB2688:EE_
x-microsoft-antispam-prvs: <SN6PR10MB268878B384EC8BEE17BB86D5FDC39@SN6PR10MB2688.namprd10.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: keamf5EEYGGCN5bce+0EcnHFDCubTYIoqI9Rc2+4MdVGz3ogP35I0/B7ULontZUau6TDXapOxZ5GttHsqBcrCGac4MWLCU6hW2mAv62Q5g14ZGTuQRft/Bba0aHY7h58+dPl3g2HJttISn8Az5XuNlFr1fM6+hn+mWYHYGt9k8MLaXlUPh/AUrATHkvqQwigb63uvTuArwSDlR8p5u88kEXiQTixKkMSTYc2/JJD0mXlEvlhxr4QDtUGcMNox0DqX3DZjbQA0gJxbvJM/S3ea7cFX0SKObxadN5mIdNvUfLQgHEIVytz9pM4XGJXzw0wjv7LqHUeyC4s/Lg4t4EKspK29C50kmWEGqANNHPYgSw1lwQioh3UIHMfKzBLGejSun2R1dThMnkbpb2fQ6mCpu1evtogE4Ki44pzwmJrmk53HgQOhbqi5eASxQAmdELNOvknZz+X/xVnWNTdTypHbzjoh3JJ7bGCzbVane7a1Y+3aO1mU5xiPjSjDrqljmBz5VRdZ3se5+v82KT9TYY2cakDcZ4ONZFWsv8SD9cFTac0o+l9rbVEY4IPH4cv8HwGCSGghuhgR3YasspilVIwzd4JPEXq+O69032F8i8B6li0Ok+g/S4E8A2xdS/qCKvdOadtBEELWnlrU2u0Viw3VlMJkyUx2K0tIbv83WHG/jAdlB6QANhbVDTs/ACaNNX4wXsUlJWJK1r1bR3o8THXmg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(186003)(122000001)(1076003)(2616005)(66476007)(8676002)(66446008)(64756008)(38070700005)(36756003)(316002)(38100700002)(66556008)(66946007)(76116006)(91956017)(110136005)(26005)(6512007)(71200400001)(8936002)(6666004)(6506007)(2906002)(4744005)(86362001)(5660300002)(6486002)(508600001)(83380400001)(44832011);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?Y/EVMV8ELGKWLxiSzL1uPNcR7VClo+ZT9osjPlAkupnW6n7qkVDryDH11j?=
 =?iso-8859-1?Q?Z6pqanEn11N3/41yoXarlxswFEfzf1uk0b5K3Ue96UAdrCcjSd39hQNN7j?=
 =?iso-8859-1?Q?to6IVYlwMZZbz3dqGuXlf7lVQMVXj949o6Ax1YIne6q8rRflpGoqhY0ztU?=
 =?iso-8859-1?Q?4N0KVTHjjJwvEmJRUpcf61eByBnpN9D8C9Sk/dZVYlqhtiE28MGBnqyswM?=
 =?iso-8859-1?Q?21M7dXo1bZDpRYKNEjo9Z9Bcui+/B0W3vsyeBbI9MGq41mEtBqNsTIm0c0?=
 =?iso-8859-1?Q?TyIznIIg9HHhAdWp9Ymys9k8NuQaxpwWi2PQJ+76AZoz+Ck5IPppHJduu1?=
 =?iso-8859-1?Q?skiX2gX+rtqEC9Gqpy3ixs4m+DdP63tlUqWSxCDHSssNXfoyP0N6LzeKzM?=
 =?iso-8859-1?Q?13RsVNE6yOmJcshuOCGf0tX3yKvRVq5R8+GhQ9kJmuHcAW2XlEOVSh8d6T?=
 =?iso-8859-1?Q?CvKqLY9qWzxsVUYLFhQOtHdc6Qqv7rGoNcTC2OvbmUPalTmRnDmL7O0lpd?=
 =?iso-8859-1?Q?lbkrYbwhB4y+3qOh51Rf4nBSlQO69zbk6QZ7YLEycKGC0H/LPWrB+G/VEM?=
 =?iso-8859-1?Q?XdzBAMgMxDKyj4HD3rpzw2BL3p+DfWuUVpexGgDJNFusK9N3ZbZYl/y4NC?=
 =?iso-8859-1?Q?3YMYJ3rbW1cDQ3Ibgwy7g83GLVBWM0vhVaDG20HTukAh0ZRsQiTlqWwJmR?=
 =?iso-8859-1?Q?ODg15O6W2QQhwvf7Gmv3ay/rmENE+sChtHWHHcOcdM18RLY0Vft8dvv3qE?=
 =?iso-8859-1?Q?cguhZ+uzRYnaVNcrssg1YgZ5pBm+9TGF0eInH1TCZdi2vzehJbYd7gwn8X?=
 =?iso-8859-1?Q?slS8r/+iHtvmMI3FjP9kZ7Lcmth05kqrGQdW1uasY9DmX5/RNzA3/QpOJp?=
 =?iso-8859-1?Q?5x85jimtkru2wEDyIOKMI3qN45yS/65kZMKMYxget56qgnaOZKD5S59Bna?=
 =?iso-8859-1?Q?aC4cSD8cvZX1v8b6wYHjgq6sB809jYdHh/jqiGN32YcNQfpOSe9kRPp211?=
 =?iso-8859-1?Q?PjFQbm7vQJtxuA6GT06A9kPlCQ31u+7cAP74rNtk1U9pHKlJF5VIQgYjBG?=
 =?iso-8859-1?Q?Dir9KnR0M41CDiPbwGU8qhek4LJcu7OeVYtKgJ3eBS4JPlrFt6YfAvZiGK?=
 =?iso-8859-1?Q?EtMrcwmRlvkfJfeKNxlA8uVJhJ2uizFdJ2AwJh4HVGgQjRLxRwTv1Oo40d?=
 =?iso-8859-1?Q?+j7pCLW7wTxS+WukIrHQSkT6rYo+MpjURBb8Kap6qO0mDEqK0HTykc5d0o?=
 =?iso-8859-1?Q?oqfaYl4nD/cEaxG8t65hUvnlkpWiPKuQSX4hJ670chSzEJATZiPnCsuTY1?=
 =?iso-8859-1?Q?gBdn3ptMPezQTxmUxvDzA3uXqQppXwXIWzlVs3qdDPNDdAxaLBotTIO2ku?=
 =?iso-8859-1?Q?UMEPA1GZdKrq3ZJ+vfOLU+CaHJMDHhkABFZ5/nLDU65jQWHFkZ/Htiir02?=
 =?iso-8859-1?Q?cRAtfcDpKYkpTdtm0TiVcMV+swDy5Z9cmo4gdKgoXDgAfH68BbZVk9ZmdB?=
 =?iso-8859-1?Q?H4NSC1JjEMPEy9s//3xHGrWN76mfjpTD56gUobBTiB673825/zbQ4bdPcH?=
 =?iso-8859-1?Q?w/cskMTbMKnfpdb2/9vpp5nUUo02aOyHGxmkLYGstxb8+IYgrc/xzAMmMM?=
 =?iso-8859-1?Q?/RK+Hb4RvTyx0NhgXUx7u+g9qzwJ5rEtvJTs3MnfoMKU/SGviFKimLgBGx?=
 =?iso-8859-1?Q?Ae3EBIBRQR9I0WQ6U5qkdyA34EySwn9EuvXYTWHrjRbrm0HwxVP+KRKr11?=
 =?iso-8859-1?Q?bOqU/ikUJF2Xm4mvJHFmA/Zjm407jfv8vvF4wugRPsBfjx2dBUTEyPP8H/?=
 =?iso-8859-1?Q?sVoe2Cm53yt71xKNv9v0WC3I7f2Q9SQ=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 377454c7-f4e1-47d2-f04b-08da2d6b74fd
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 May 2022 01:14:02.0638
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 9OUaiHgQayK8Mhw/rK5LJ/qRSseOmWpgS6ddk2t15d0rJB3SpLUJJLURrjXAnAG6z1SPZ8yB5YduNxxxdvRLdg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR10MB2688
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.486,18.0.858
 definitions=2022-05-03_10:2022-05-02,2022-05-03 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 bulkscore=0 spamscore=0
 malwarescore=0 adultscore=0 suspectscore=0 mlxscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2202240000
 definitions=main-2205040006
X-Proofpoint-GUID: NcbFA4Ua76qIaOzXKzuwxdZbGcTns_lm
X-Proofpoint-ORIG-GUID: NcbFA4Ua76qIaOzXKzuwxdZbGcTns_lm
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

Use find_vma_intersection() to locate the VMAs in __mm_populate() instead
of using find_vma() and the linked list.

Signed-off-by: Liam R. Howlett <Liam.Howlett@Oracle.com>
---
 mm/gup.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/mm/gup.c b/mm/gup.c
index f598a037eb04..28fd5d5aa557 100644
--- a/mm/gup.c
+++ b/mm/gup.c
@@ -1533,10 +1533,11 @@ int __mm_populate(unsigned long start, unsigned lon=
g len, int ignore_errors)
 		if (!locked) {
 			locked =3D 1;
 			mmap_read_lock(mm);
-			vma =3D find_vma(mm, nstart);
+			vma =3D find_vma_intersection(mm, nstart, end);
 		} else if (nstart >=3D vma->vm_end)
-			vma =3D vma->vm_next;
-		if (!vma || vma->vm_start >=3D end)
+			vma =3D find_vma_intersection(mm, vma->vm_end, end);
+
+		if (!vma)
 			break;
 		/*
 		 * Set [nstart; nend) to intersection of desired address
--=20
2.35.1
