Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CEEFF59C259
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Aug 2022 17:14:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236076AbiHVPLr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Aug 2022 11:11:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236253AbiHVPKS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Aug 2022 11:10:18 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F5B23F1F2
        for <linux-kernel@vger.kernel.org>; Mon, 22 Aug 2022 08:07:34 -0700 (PDT)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 27MEirpo017910;
        Mon, 22 Aug 2022 15:06:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=51bOF0H0omk12xzhHKd2hBuuK2pQkqf49Qxa+Cr1r/Q=;
 b=v0lkgjC2Pp5nNkW9Y9KmGJlBT62f1eiCsPV6YrmIHpSucVCzQwEnCkhSdkXf48uWHbWo
 2bEU8/bPqlFYxup6VXAJig1knPwx7KVlWNB/bluIpDGqW9mW6duMu9XvRmyfKS2bAIW2
 JN8ZVLe84NIVmg/idGkFz8/X7ccM11nWCf9oVUf2fQXDctFWKEl10Fjlvnx7DIzHu+bZ
 Q9V3Fzb3UsD4iVfENsipW7v9Rnu/rXqFMAxf7lPhzL36qZR7amvnPotFj96GXbF++LXs
 Q+VqQnix00uHARMUysTcXSx14DMFYBvBNXS3iWYwXCO9ZPws8SQI0Z1k5H9E8hufvxGv kA== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3j4bkt04a0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 22 Aug 2022 15:06:34 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 27ME4Nak031868;
        Mon, 22 Aug 2022 15:06:33 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2168.outbound.protection.outlook.com [104.47.55.168])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3j3mjd3986-9
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 22 Aug 2022 15:06:33 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lD0eRzd48EcXXRUZGxnkHEPmrT5AOhncu8t12L3k7is0Nwq+LrnyaWxOqE+QvnBpOBP0hHkCbBZheQTyPLGdI5RSRZzj42lVy30DnQHzg5Oin99FNXEEbDL2ZxPYZyFOspXChidg8YbO638Y3QYoZgDb8nuRBKICrDxIGzEq7EkP4acc8IWvG/C/80dflTdpq71OgnR2eWhHFzbBwYM6czkO0yYO90qmYOcny1wxLF6V7ZPClu6iTM4wMAAQ2gS7uO9KhW94eRXMwS8rOCZdu8aG0t/tmcapZwBseXPbc3D36FX5SDWDp8L+tWSv/ZHfYlp4kYGdFNcKApmy7dywgg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=51bOF0H0omk12xzhHKd2hBuuK2pQkqf49Qxa+Cr1r/Q=;
 b=Pw8KZJ19LOfV1S8H/W9bv3xROpj76CCQBonaftwy2+kCOykvAhL3YbF7HgrIu8QMkOwNy+KXKU1zHEmfeEBbMYIui2fuenX8obfKizHB0oFMi4xcZqg8rNOUuxxjufv+22VRhUZ1cTNO8ruxxbjXOCjR0niTbHiLYr8wQyJhvVouy2Mw5zFJqpIHW4ndCUY/nYxq5/uFaVYqgd9IvQoZJDDQED6zUdtqQt27CVfIDEdmmO0nuvnZ7g9cjYTKx/1IAHbZZxEQTtXQPVOEDY6IHeQrGyI56yBorjb8HmTP/y8LTIqwQOAlj/SasrNVge7/n9ff+4h8084JTKl73SMefw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=51bOF0H0omk12xzhHKd2hBuuK2pQkqf49Qxa+Cr1r/Q=;
 b=d9Sm3/HBMbXqpUXBcubikYl2Z+D29Dc78oVUfTXgJkbuWeF6Dz36kq5cO3E2hS2fkaT8qNHutfNSppbvVx1mcrOAgYt7VDwyDJhWUPJKBUCKFdHTMTNX9xgFXkDhoHtvpTDpWgaqL9zYBugwxlyOoOgTfwHzq5ZesXahNte+2y4=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by DM5PR10MB1433.namprd10.prod.outlook.com (2603:10b6:3:e::22) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5546.21; Mon, 22 Aug 2022 15:06:31 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::3d34:ebb5:d9df:98b3]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::3d34:ebb5:d9df:98b3%5]) with mapi id 15.20.5546.023; Mon, 22 Aug 2022
 15:06:31 +0000
From:   Liam Howlett <liam.howlett@oracle.com>
To:     "maple-tree@lists.infradead.org" <maple-tree@lists.infradead.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
CC:     Liam Howlett <liam.howlett@oracle.com>
Subject: [PATCH v13 51/70] mm/gup: use maple tree navigation instead of linked
 list
Thread-Topic: [PATCH v13 51/70] mm/gup: use maple tree navigation instead of
 linked list
Thread-Index: AQHYtjjBgeO6aHSwrUOQ0SBhHzGDeg==
Date:   Mon, 22 Aug 2022 15:06:28 +0000
Message-ID: <20220822150128.1562046-52-Liam.Howlett@oracle.com>
References: <20220822150128.1562046-1-Liam.Howlett@oracle.com>
In-Reply-To: <20220822150128.1562046-1-Liam.Howlett@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.35.1
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: df9a859a-9fdd-40a4-4034-08da844fe586
x-ms-traffictypediagnostic: DM5PR10MB1433:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: QsU+PFxTrzTgi9yacDNVkIu+VsK1b676TRr/KMiESh0GfXiFw8qNgK4YUQZxoAXj6vn0CS22v8ezG9Ev+uIaNi/r+4LAHc9aTHcoC/vi0O2dr4eNJj/BuaiJg8Erl25Qhj3dRS5BjPWgBI52/wONpEZmm5bPKsq5Coh4kU7DLkN/z1dwcJ0NIxBP27rz9VmCHgjHU0zXxB0748VVpkWV3bmHRwYt2uHworcRBUbdr7Su0tFr1NwipVjRUj6mMSgmzzLtzhvws9PfoZVJRsWw/JYkln6yzB9rlKCC6NTFinTtq+Gvpiz5owvl1ePEXHSarTIWTNyIWmZ3YEwXoz/yZFxCq917UETWur0ACgAoXckseo08teggBa2PQv8UiWjkeGeADzzuM+Woa6JsE5z+pj5ZnzXEKwiUP5f5O7tjB5ZhIesY6BSVqL//tP/wO0gHqn6rip+Ixh4cJNCfTeZZPkbjRQXcCNDqt+SPKKMGsi0p8a7b96gfe4Zs3nPYq9aXFTzMUSLLZRlnT93CKJooYvoYpcr3Gi7ph58aOxFpORkNzTmBAHdBZzPqcx7Bu+LnJJibhXm150ywvTOTs18QcbywYOEwvqyF67pJMIUTLC5KIcPFwFkAt09elRrr+1nqpQnIRSbA7lOJCZZhXhRyYJScv9lM0vnYxKOPPZ4+4tzgnYE0WQGonB2AXlK7N8RcO4BIkNuorKEVOm3Nf2rtVMvDU4GM/WVzWjwzo04LJy9bRlU8Avs/BbDYfxkzOGIM0OAG0l1Sq0Bi4QcukKTnxg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(346002)(376002)(396003)(136003)(39860400002)(366004)(5660300002)(4744005)(8936002)(38100700002)(122000001)(36756003)(41300700001)(44832011)(6486002)(6666004)(316002)(71200400001)(76116006)(91956017)(110136005)(8676002)(4326008)(64756008)(66446008)(66476007)(66556008)(66946007)(478600001)(186003)(1076003)(107886003)(6512007)(26005)(83380400001)(2616005)(6506007)(2906002)(38070700005)(86362001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?6c1zbKNB4zyc6IGVUDnUwNcqByJBB6M19UDQGJJ5VPz1uUxGd4HrAvnXBN?=
 =?iso-8859-1?Q?J6AYof1YvqE1G4IqeVQ19m+pn32a/ZR6u4PSgeN6IouJlsXpVYSrZj0cko?=
 =?iso-8859-1?Q?MBPYtvptFeS/1LKwci6n17JB6Qq5NgUMm8J8ghBKN1eyiz81Ictv6cMM/y?=
 =?iso-8859-1?Q?b7ocnmzijvXVDYmcPpn3rj2eoqm8uEmbSTVaG1yeUUheHa4kpGL9F3FaWN?=
 =?iso-8859-1?Q?QsF41BsrRWxTlKXyVbbC7kzleXZA/ikTivVPGbFrh440u0/CgAu8WkxUmF?=
 =?iso-8859-1?Q?Q3+tnLUr3qZTYJRnJXtfAD1AOi+fOfeL33nBNNQsD1ph71cFZHRfrcOIs/?=
 =?iso-8859-1?Q?akzuteXY0sD77o+mKhyeDAR2//28I7ODiJCSKXbiWtdapEPYBxkyfylHU/?=
 =?iso-8859-1?Q?ey4T7ux6EJFZXs8V/nqQLgXtWCxkxql/gncOIhAlFRCtGejt1FEqNAWa1p?=
 =?iso-8859-1?Q?OUBRk+DRtBdS9za89+8KwieSD/hSECvDaWEZ1Eg7opRiTyNku1D34yKr3I?=
 =?iso-8859-1?Q?I44arA5jnIZpF3VLq3g5K1ehjj/EOs8nbsUQpySMs2yPIYiJK+ke0YKblr?=
 =?iso-8859-1?Q?zYnIhs/SH26C6wWxvcJf5qD6Lku1M2qfqh2PZyXiia68W1QjN7ZMVWJNrM?=
 =?iso-8859-1?Q?QC8Uo5ChKPrMcvE5s0dkXPpe8vptW8iFbN3mU4UYVGHO77X0w7acUcs+UW?=
 =?iso-8859-1?Q?zyCK8B1KYU1uGkjY5Eo/W2VZ0ub2iZ2eugDYaJpu1acm6s50WLsSG+ifFF?=
 =?iso-8859-1?Q?qh/NihAI2/dyN0xuchmPiTGUWW7jj5IGGbxJZLAvJekiMg6PZcJtlXgwrb?=
 =?iso-8859-1?Q?jHnL8+L5+U3fBwpRZNvToujm8o7YQPLJResvY63SxXfts3P5UlHTWd643B?=
 =?iso-8859-1?Q?thVtbGdRQYSY70ZO+VfUeOBz3LLDGtw/7m3V5w7jVY+iFpqlL9me8NRfpF?=
 =?iso-8859-1?Q?46IMcDh/B7GlJse67bHbifiUBSbNFQ/vhJUt/q4DrgIuKrw43iD+SgkQoI?=
 =?iso-8859-1?Q?31bTzig6QcU9MDCwJ5+dttZbZHCW8etNJjMMuGoJ43ZGd8SgZ3CGus4Qq1?=
 =?iso-8859-1?Q?iaVbhQEmAg+88IkCEyd5IKg7Tvo4PYJjO4fgEL+FzPQjtAgNp5+5KH0zcW?=
 =?iso-8859-1?Q?6uHdB/XWB6AJBtoSewur6OvVHa4Ks37ma5kSsQv+NiIWV++4MXFrtPrNaj?=
 =?iso-8859-1?Q?m/4jLl7/C1+XtXSz36H3AJzWtIC4lmjhlbJlpkrkR1V2JCf2z6n0RfT84+?=
 =?iso-8859-1?Q?TLwQGcCRATlmNm5ON14hfxAJyUelCMXLJ8/GJ9Di6zMuOVN0o1+ottATTE?=
 =?iso-8859-1?Q?K05uxaMDIT4AfhvqCbKG0l00MNhX0P0kwUaMnQn3FcNxCdrpteQXrw3Ujq?=
 =?iso-8859-1?Q?H4ys3cGvvY6QuStjGe+RoIed7pzz0VBx6YR7tMBs9DU6L4WCzxfVF28u4d?=
 =?iso-8859-1?Q?LbEXrFCpzYtm6dXaMuoUgVV5inFvf9VUZLosWzUotZ29yseWDKkExtupXz?=
 =?iso-8859-1?Q?EipVCI2m6rGuohRKXtc2Ovzyfpg79ZDOqUB+lCj89XznVA8K3ENGZTJs3a?=
 =?iso-8859-1?Q?PnLexczsz0jc5Y/vh8CzlrIPu/DsXpMUkRTB1NlUT45gSY7/VHp7Vqm5KG?=
 =?iso-8859-1?Q?/G9hHqD+g1EO7kl+ceFF9ami0TOPwss/Qh1JLSUIPS4aPR8lCuoF9DVQ?=
 =?iso-8859-1?Q?=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: df9a859a-9fdd-40a4-4034-08da844fe586
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Aug 2022 15:06:28.4411
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 59ITobtNMatdaXRbnk18rp2Ocfy7YZrJo278G0BfxERKN9mktxm9GMx3wAE8xXjgo9mtJepSVRcOfJANLyeiLw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR10MB1433
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-08-22_09,2022-08-22_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 mlxlogscore=999 adultscore=0
 spamscore=0 phishscore=0 malwarescore=0 bulkscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2207270000
 definitions=main-2208220065
X-Proofpoint-ORIG-GUID: xcvuXO5PMptS_ls0HvEiiMrFKivI5Cjc
X-Proofpoint-GUID: xcvuXO5PMptS_ls0HvEiiMrFKivI5Cjc
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

Use find_vma_intersection() to locate the VMAs in __mm_populate() instead
of using find_vma() and the linked list.

Signed-off-by: Liam R. Howlett <Liam.Howlett@Oracle.com>
---
 mm/gup.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/mm/gup.c b/mm/gup.c
index 5aa7531a703b..d54676448470 100644
--- a/mm/gup.c
+++ b/mm/gup.c
@@ -1667,10 +1667,11 @@ int __mm_populate(unsigned long start, unsigned lon=
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
