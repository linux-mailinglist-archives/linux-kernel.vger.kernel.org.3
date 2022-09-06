Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 185475AF50A
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Sep 2022 21:55:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230327AbiIFTxF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Sep 2022 15:53:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229992AbiIFTuH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Sep 2022 15:50:07 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6BEFB7E336
        for <linux-kernel@vger.kernel.org>; Tue,  6 Sep 2022 12:49:58 -0700 (PDT)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 286IdJM9014146;
        Tue, 6 Sep 2022 19:49:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=6Bb3vXUfGuElfa0s1kV+YCDWx94O4XptzApp0oKpDkM=;
 b=E+0hrgUpQAO4resWrTI7ZyjHaZPSQwBsyuEyD9pEOn3tnsOPJvUnuHccX4DqboEy9ARQ
 VKOaGu2D57IkxrmkG8trHvFiK56/SwFSP/nDswnwTlderhtQWRjiXlylkJHAinvhBnKK
 FiBDJeIMURVRcT/hxrNtHva4BblK/gPw2a0YUeQ6/6wyu6S70dE17emruAP8O2tuZRGx
 5onyI8ls4snr+mDYca3uaAEQ+EacmajnNRIW9n+VQ0xFp1adgUwKI//8JiU8n4CzHG4O
 AKU0LybFjonsQ2E8kXNrvRY6hBBQh+xYEUakY/c+S2O6i0jOTeT7QoXrlDIU8tTEWaBW mQ== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3jbwq2eyp6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 06 Sep 2022 19:49:49 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 286HF67Q031251;
        Tue, 6 Sep 2022 19:49:48 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2173.outbound.protection.outlook.com [104.47.56.173])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3jbwc3ahkd-3
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 06 Sep 2022 19:49:48 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=e6+K3p9pK+TzAPbSGU2XfZRy+12cPzYQCsj8I43qfyhsW3bgq71n20MjfOQ6bg9psSuYRBcUxxKlSIHhRCr43ub0BsvN/rnUPl1Zcgm/vS7feMLnAtMP0kGVacTYCYvs2hpZ0tzJnkThFvWZeBeE/ZyBc2+WDY5jukOfWTc10v9hRA/7qkeHYlRI3WezB1zkzhC/+xrl4t088HF++iXvtrBoqvAz5L5tQ3+slgLG484q8xIQyVi5MWpGMDx6hhwfofMESmmKYopH5GR63ny8hRpx/u3SAc1uq+XQwchZIpyQAOsMHvCplft9En+nNeWRbmKYMYwBd3b8MHdoQ88fpg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6Bb3vXUfGuElfa0s1kV+YCDWx94O4XptzApp0oKpDkM=;
 b=U/YlKykN8rL02nJAlTHm0HQ3GcM0GKeZ6iXc2hpM4VJS654Jbd1Dyq+GtIfMkCfhsjdPcr8XoqJP2vTkv83hL2lEPrzkKGywfmzv21elcvKIh+s1iilmzC6apZqczUO1iuL5R8S0MaidjrgJCbq4bayb85Q/5wKhzFHd+IATqEvPMgI5PGitfmrhfY/xkkoGP02uhjUOapka4OAU1VliyjMRpDtwM0CTEETI62uB0X+jrpwZwu518b6+a6dleKQJrXpy3qDyjH5bBUms8GrzCtXzr/D0X+YZX3h/+CZ4jw883Qr262Ly9OJLmiW4ms/Ysj0e1QsiOqGwovBGSfbu8A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6Bb3vXUfGuElfa0s1kV+YCDWx94O4XptzApp0oKpDkM=;
 b=adscmzaOA1/gf1zhMFU1z25yDreUa2BPbvqynGWWxysJQXeTxz95V0/iDMQnN630nKRzMncO7dtrXpR78KGnjynDfpxEwdZiowW11wTgjJ2koBZ0HVbtpoklInCIZSE8vjXuEO8N8a4tKgwN9aMUzYy+HLq54oxrUvxR/2y5H70=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by CH0PR10MB4876.namprd10.prod.outlook.com (2603:10b6:610:c9::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5588.15; Tue, 6 Sep
 2022 19:49:46 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::a420:3107:436d:d223]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::a420:3107:436d:d223%5]) with mapi id 15.20.5588.018; Tue, 6 Sep 2022
 19:49:46 +0000
From:   Liam Howlett <liam.howlett@oracle.com>
To:     "maple-tree@lists.infradead.org" <maple-tree@lists.infradead.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
CC:     Liam Howlett <liam.howlett@oracle.com>,
        Davidlohr Bueso <dave@stgolabs.net>
Subject: [PATCH v14 51/70] mm/gup: use maple tree navigation instead of linked
 list
Thread-Topic: [PATCH v14 51/70] mm/gup: use maple tree navigation instead of
 linked list
Thread-Index: AQHYwim1ZIpLGQM1H0WSnqXuZ04+Hw==
Date:   Tue, 6 Sep 2022 19:49:00 +0000
Message-ID: <20220906194824.2110408-52-Liam.Howlett@oracle.com>
References: <20220906194824.2110408-1-Liam.Howlett@oracle.com>
In-Reply-To: <20220906194824.2110408-1-Liam.Howlett@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.35.1
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: a93dacc2-6c7c-4de9-9e33-08da9040f368
x-ms-traffictypediagnostic: CH0PR10MB4876:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: HfHxcGYsN9zx8jNcFHiqh4yM49tNyilzbZGJbjK9knWOOAkxG1ilKIKBC0EjPv1AkO6Q7wz4JjcHsBSHHo06P6le/sRn1xcy4wSQMqkVh0qd+zB1S/Sbpiq0uiglKyYr2Nq5lnUdTK5FiiA/ZV7mvJAKM9ubSCDGwGg4il2k6AtEkySTHOh+TBVUnXBmEnZcX0z6y3tK1o6eD8I3ma/FzMUJVmvQnvyCk4Vz9sKvu/nuN9Dk9Sqzv8ze4WoOsDHPPcBl4KDrk8FQaM3sbdIqq7rcK9Y6MNEOyjdcdZHV0JTi1ZVqbE7cxjaE/+nuqUMvc2ZywJ0ZVKvxElcZ30kFEUVHF7bBrHEDckvGpj8346Oilzs7P3wo9s1983XgnCJ0jDHMjbfhHw9Umz+Z9iLrmrPOURZLg6PvoIHfFekkBxW3CijHMfEbaBtwprtADVPkzEfuDRx+kLI/FcIL2gkwBZjC/uuijEbOE0v4s8GuPlpDF8dQ5pTa7f55loE8T5ZKk+XlGOpe2mCgj1GbGjnU1MDbENzeAhIhA3LgI0FQm4FcAV3tAA8YOVEMB5dZCxvClYZcLwZP0nEyecGFw+q4DqstErqoiXhGr1MH0Zs4zQaJYnEbalUCz3o/TQwspnzjnjS0JEjL5Vowo/tpeV51ufDkisHt/ek8/YAYTLUblE3NhCjTC+htQ/ImwBy74RwCPBCgLWO45qagzGJbP4K6rfwen6hG3EHzOFPqaLGIUMsKlhQZFyvA7ZAzhdBWjjkS9jsHSkgXj5Uhl+n9FouSFA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(39860400002)(136003)(366004)(376002)(396003)(346002)(8936002)(6486002)(8676002)(4326008)(91956017)(122000001)(66946007)(66446008)(186003)(66476007)(76116006)(64756008)(66556008)(2616005)(38100700002)(38070700005)(478600001)(83380400001)(36756003)(1076003)(5660300002)(4744005)(41300700001)(71200400001)(6666004)(44832011)(26005)(6506007)(54906003)(316002)(86362001)(2906002)(110136005)(6512007);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?riZh6kMctiKjXShxXQQnYQ/nnBvEkj9zWAdPwdBsk70s4Xx8+SDeoZl+qU?=
 =?iso-8859-1?Q?EOmn+Gpr4AEio07cPNyFW0QcwyMtJatusyUJd2+1z1Pbc4Ma0Q4iTd5ZOI?=
 =?iso-8859-1?Q?pAy0ehWBcndAwg74/WvmXKvddLjVKrYF325242LU0xV2dKJyVXrG/aCW9l?=
 =?iso-8859-1?Q?J7hNo9UnAygBb5uXKIjR40Fmu7mkSMLPE2mpc7JRPP27eUX8YMgFPI10In?=
 =?iso-8859-1?Q?+Q+3TogyIywR5tkb+KPwh3OxJg6/3rPCiptp5umLL2gSG1ATXF5oL2b9ei?=
 =?iso-8859-1?Q?DXdIdxenXw0Z/mF4ksl0Yzrq2d103xRatq2rqbPnOXgRSxnVkVyWsdECB7?=
 =?iso-8859-1?Q?FMpA58yi6vO4ddqfYeS3lmpRTApg0BfhRtkbQ4Ryo0LTseY4XOs01WpelG?=
 =?iso-8859-1?Q?kzJZj3L0UmQVO2FdGKbxhp393tPYR+PmkpI9ZQpMfXepJmK0Pc3+DRnHfg?=
 =?iso-8859-1?Q?Eoh9dMy+XesyJ3DsLnJtFzJcY89cPBZMx8sBbR5odwkP22dWqmWfkqxsex?=
 =?iso-8859-1?Q?CEwbR2bOaUTr+NkuEMkzVH5GW6DLxiVtR4VlSTGFz9uLDMn8vR046IAFkn?=
 =?iso-8859-1?Q?Wu343Qxk+1nQ4mku3yYOVf3lJbNloruoJTJIkcW1HryYleH5bC3ps796ck?=
 =?iso-8859-1?Q?1n3uSj0aiJzI5wgorGbVJqiYHbzojpWskw97KkRhn0eN1ixa50QzXTi7Pl?=
 =?iso-8859-1?Q?CwIIF4ii7XqfdJC/ZZq7QKkXO946/0ktZOseJyprpPlAQ9zRyr5/CKxbhw?=
 =?iso-8859-1?Q?g42eNFBNus72YsiUHZx4WeiIqnKqizmcegqainmnC5x/jIyW9RSfrX0XHq?=
 =?iso-8859-1?Q?XRVZOUGAKZp1t70pfa7wGCf2XMMv0pegd+JIkQbed0qXZzW7o4qgvxSwL5?=
 =?iso-8859-1?Q?Mn2Yjzhpb0iC+QvlvJeiSVH3G/dYQ8BQdl3eY5NjoI2caMP/6KVcZgYPNI?=
 =?iso-8859-1?Q?EOM+AwYonYUbJd/Hivrau4DNvH0KXbIvWOglfMDSVpjLYmtOwOe2gWp72K?=
 =?iso-8859-1?Q?QfgUf3QhvcIJGZ30Adt272N2oEuRXJo/oSvQyhZ138ZB3TGBZu2PkKDaE3?=
 =?iso-8859-1?Q?ida06PIjXR7nCCHboTxEx00qUlmOq6Gx7E5UTBzb8XJPsQcVJ6kswPwTyu?=
 =?iso-8859-1?Q?Cm+A2iIoXdiKeqMuVeXClINgpb+MALlsNLAgkmZfDI0A96uVTR34JPPVHb?=
 =?iso-8859-1?Q?DB+7AYhKyH4PwzXjRo2p4+2PgzsVDk0LsfCQfIkqX5OG0lWJLzw4WcYBy7?=
 =?iso-8859-1?Q?1pTziUa+i3yiXYlAv7rH46yjfCxLh135xgzs5x5aa1vWspbrhIIaF6KYGq?=
 =?iso-8859-1?Q?J6l8a5u31d5XGRBGymfWmsIZ+/BuEDWnlD+rBRFAAm8ieCmQDxkkQ4M29c?=
 =?iso-8859-1?Q?pQ9F9QaLr/V92FqOGBbtHsZibfFDdOKUEyKQ54RfF2AIugHbDljsyqhuJC?=
 =?iso-8859-1?Q?FgCdFy19PthKPczOK8jzMwO4SfNR2UPDw7AUJaAMDLYpXUsKVYbmoW8LyQ?=
 =?iso-8859-1?Q?fDNX8hWiyOA32hth3P28U+oE8/zbRSnxL72z+YSLrfpB6Zuzd3nlktwz49?=
 =?iso-8859-1?Q?+H7fDI6M1rU7uav/FTkC2CjNOgm6dFvKWQQm6tsPJF0peHzRRGETvRCZ4Y?=
 =?iso-8859-1?Q?ocUzzlVeTvH5F0RqyWNFszOFMUBkj06CHG7R683f7K8u+flqyy+wDDhA?=
 =?iso-8859-1?Q?=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a93dacc2-6c7c-4de9-9e33-08da9040f368
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Sep 2022 19:49:00.2560
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: xCVxbAohvl48igx8nnUKPXFw/MAFxSyN5bnWYlC0bKEsh+Qs5BMwqLYPEAe3/rCLlXHkiBSRjlLM8ezOW7guug==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR10MB4876
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.528,FMLib:17.11.122.1
 definitions=2022-09-06_09,2022-09-06_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 malwarescore=0 mlxscore=0
 suspectscore=0 mlxlogscore=999 phishscore=0 adultscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2207270000
 definitions=main-2209060091
X-Proofpoint-GUID: Gwqc6rHUsJFvG-NFJMcJ0Csk3gM1WcJx
X-Proofpoint-ORIG-GUID: Gwqc6rHUsJFvG-NFJMcJ0Csk3gM1WcJx
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
Reviewed-by: Davidlohr Bueso <dave@stgolabs.net>
---
 mm/gup.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/mm/gup.c b/mm/gup.c
index ae84989a7d60..3b656b7e8a3c 100644
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
