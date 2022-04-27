Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 60001511E22
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Apr 2022 20:37:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240110AbiD0Pqy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Apr 2022 11:46:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240311AbiD0Pqt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Apr 2022 11:46:49 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00BE53B2B1
        for <linux-kernel@vger.kernel.org>; Wed, 27 Apr 2022 08:43:27 -0700 (PDT)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 23RF6baB018590;
        Wed, 27 Apr 2022 15:43:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : subject :
 date : message-id : references : in-reply-to : content-type :
 mime-version; s=corp-2021-07-09;
 bh=e4aKGYxNYi3LcNwpg96vLcqZxou2GvJeeof/neH+NGI=;
 b=IdMQjEl2mfoXpo28DEns6rOkIWlLVw8wAlSgZOjy0xkltXlbXSb1pBUh1oOVAnc6PKkK
 tVSnVnENI9OjDwUAdyPJQkgRmWPyjLLz2vFY1dl6OH4ofdQjhriixldF2j9vCR+odhj0
 9I1WeHU9lav8ARKaF8zLAmZlFIv5DpOcyYAu/Pxu0NTt33HIfKpeW7PHslvpV9SJPgip
 Gb8HAm+pOqRk8JfvJfW+1lDmB9AgJvvs4pKIO4os1Ef+vIkQrVdy+IQeVxrQXSAVnO/X
 saZXw+Fjzvi6iMswVo+cdiU77Q7Mms5Ua1xv+UbRBDU/4NamD75w1QvDfkDBCzmrvTOg fw== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3fmb5k1fy1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 27 Apr 2022 15:43:21 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 23RFQZj5007706;
        Wed, 27 Apr 2022 15:43:20 GMT
Received: from nam04-dm6-obe.outbound.protection.outlook.com (mail-dm6nam08lp2044.outbound.protection.outlook.com [104.47.73.44])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com with ESMTP id 3fp5ym4mc4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 27 Apr 2022 15:43:20 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=krU8K0eEB94pZt25TVV8+sMHWMdi6ykXeWybj7J9YTUCjM36S0odgiYehW7WcnQUY04sg5+uoD0FogfrXkgEmhliSGzt++YRK1BdSAwOG/8FPYj4txFSLvNoIe37YH3dOlAwii+U9CY6/MqivRdweste4606/6O3Xj2WXgjGkEMRrnxCIJYy7mmFowhWoBRFHZuN+nabHJ4ibjlYsupFEXU8FFH5SYD2PBGv9rwrc0R1NzeIOcI6j2N34dagUBmJBMhAori7M1xJGPyVFRHVEoAb5xGkQN/psQS0gYo0BtHmknTtGffQMcikIs56LEjWzHZ84b/8xHr17QDZIod0oQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=e4aKGYxNYi3LcNwpg96vLcqZxou2GvJeeof/neH+NGI=;
 b=f4y6iOIbqlhZIDtoihw/UROrqHwdKTo8IguJfVDPRsXtV+LiZbS4C5b+YjkH0o1Tw1sZPJCCMuUh3crhLAyGxzUadoo7zjXyC+ZuUSGHWsRJv7gv5csTE3iDnGPhoB+g9OI8Hf6iHZyv2futAutT1TSz13rVeHS+HtDTUIIB4qBnF92KHm6aygwhfhD/XQVDdn2+ztmGJSCPLwow3npcbn4yArf9/Ntbok9pIhVmBTufnDUOK884kiVNVX29mPrF+QM10Q7TeNkwqEJQxK03VaZSM0IJnicNo3RR2vJdtMw3EQFLH6+ZcN+wXXHxvB8dRNk/1Z6JKLwUt91nf/veHw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=e4aKGYxNYi3LcNwpg96vLcqZxou2GvJeeof/neH+NGI=;
 b=Fv4ZGMn5nhFqUt12KaUJevZYWXOuy/XdyxqRxxLGodpusa3J3r3xobw8KnsQTdKH7U+Hwa8GNnMaGK3/wg3P8kG7DMboz5EcSFg0VNMlbIFAGL0b9cL5WQA6v6xvgp1ZP1jAuGQpAbIkIeKtyYzxhkvMaYmTxNduk7tgt97OJ2o=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by MN2PR10MB4096.namprd10.prod.outlook.com (2603:10b6:208:115::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.15; Wed, 27 Apr
 2022 15:43:18 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::318c:d02:2280:c2c]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::318c:d02:2280:c2c%7]) with mapi id 15.20.5186.021; Wed, 27 Apr 2022
 15:43:17 +0000
From:   Liam Howlett <liam.howlett@oracle.com>
To:     "maple-tree@lists.infradead.org" <maple-tree@lists.infradead.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Yu Zhao <yuzhao@google.com>
Subject: Re: [PATCH v8 45/70] userfaultfd: use maple tree iterator to iterate
 VMAs
Thread-Topic: [PATCH v8 45/70] userfaultfd: use maple tree iterator to iterate
 VMAs
Thread-Index: AQHYWX8+aWf9Pkxxbk2ykOig5YRJUK0D6AQA
Date:   Wed, 27 Apr 2022 15:43:17 +0000
Message-ID: <20220427154314.2o32gn46323hllnb@revolver>
References: <20220426150616.3937571-1-Liam.Howlett@oracle.com>
 <20220426150616.3937571-46-Liam.Howlett@oracle.com>
In-Reply-To: <20220426150616.3937571-46-Liam.Howlett@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: yes
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 142f0d2e-4ef7-473d-7613-08da2864a650
x-ms-traffictypediagnostic: MN2PR10MB4096:EE_
x-microsoft-antispam-prvs: <MN2PR10MB4096B1BCFB0905424E8ED35DFDFA9@MN2PR10MB4096.namprd10.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: EquvC2nWPivMfaGdEp7shMGNbdYq5mMNthkEEbc8RzjVdhGHX4CoMk9+L1Ztiw50Dgh7+cm5vGdR6GO/Lh2SDY4JeAxoVDhjmbNCuQsGTnFAgH+JpRACmPNz9LrGh/NijdlIRuNtlMNO+Ub5m7L7RvK3bj7seog3SG7FomysY9i8RyelJIwpFF80TRhuSGVB/0eoRGM+ZMAcDiH88meJbE1PHFo8Qgq7pda5ToCaDbFeLYgDNHnWx7YdWq8ei/xt5qzyFiO1W+9y+tCnXwjGzcWV35WiFhWH9zW7wildXolxP26JKvtamI3O0g6zuDFoR/96sWp6YJADkzNEVi6t22cCZBBe9tPsxVTQZQxoFT5FSLTFsUKvB1nzyi7iJQKB3YUpsDyI6IFielmDauMLD4CV5o9xbPfGKxn+6/HRGFnREcUQppZSOkNhPWybXHmXQbuVaUprUvzxWeRTWDlp3U92Oe+J0bfH1TGnnF0J5g4aM7bcCkGR1zm7QSB5brGVqg5qCcaMMNDv4qfrKiL0dQVhIwl8YJAZAez0XWcEWFPstMCEr9/JpeDN5rQzO40RAGeev4lEETSLELBrQuJoDuyryxDXkmcuRrTp9PuXoZpJ5rnwKiEGfy+hiHIgtHNWU1Iu2c08tmVtZyNXLd/fkBEt9meaDrzTckUry0LjZvncm9a6z0F217LCMQkQup+MHsy1n47P424fGRdkARrd9w==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(7916004)(366004)(44832011)(86362001)(8676002)(5660300002)(508600001)(8936002)(2906002)(19618925003)(316002)(76116006)(66446008)(66946007)(110136005)(91956017)(38100700002)(38070700005)(33716001)(122000001)(99936003)(558084003)(64756008)(66476007)(66556008)(1076003)(186003)(26005)(6486002)(6506007)(6512007)(71200400001)(4270600006)(9686003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?3akkxhJsURMKKKuckP2su0zYeI1tAbEyWC9nMzLnEha2iVIxXg9peW14e2jh?=
 =?us-ascii?Q?KSELR/OOhj1Jezs/2uaJwP00YuYl1EOUuYoXVmMsoLFn6bTNcPTMWQxzmCBs?=
 =?us-ascii?Q?Z7wIxEsh9P3iwhjfsxk9Y/UjjFVJOEwbqQh2+ye+vjxvGBRjcjFH+BlWLuXj?=
 =?us-ascii?Q?1n1ngnqs1zF2oKsTtVjIZFS+FwJ/0ejVVX0tqRjylJa19aJZpX42fdA1Y7rz?=
 =?us-ascii?Q?f2O8ETlqjxq+GuaaqyuKFwtOdgMNngvsOmXjUJCIw8cctKhfFDmnizpZ9aSC?=
 =?us-ascii?Q?3Rd1Q1bRqpEuFOkWS0VG2sZLnqC3Hh5oMG4fs701AEFJ1TH2WKyAlp5L/Nsq?=
 =?us-ascii?Q?MTaGD1hq3Htq/v31vXVOXygmQ35ZIJxaWCq2SIhDKV7MzfD3Zv1utHklbBf5?=
 =?us-ascii?Q?HXa5LKhV8SIG9Iqqb/cxZTYv1tEpcuBVLeJWnIOiL3rANNSCXF0usohYz1aI?=
 =?us-ascii?Q?OXnX1/MABr3kjyRZt46VForg3QJqjbMJK+U0exPWHm8ez2Oc27YRcNaNwi1f?=
 =?us-ascii?Q?VHmHY/pXRWUXswF8CfquXU8KiuZVR9RbaX8ncGql9saw5n4Oi7EMXlFlhyDT?=
 =?us-ascii?Q?HphcTvhuX7osVpso5C6N3NP4Yk72p3Qw+27lkJv9Fbadg2pkDqlgNc5lESCL?=
 =?us-ascii?Q?S7m3z0/o5IGNl3XRBoxHgnmaKjtn23ONVWg3g3P2WP1B9X7ppy9Zx7FRXWNU?=
 =?us-ascii?Q?v7z7fPWdj80xoyZsiJ+2gCGW9Yvvu+SOqwqV7XOLT5t1IsuUHCsQ9+SSR5AC?=
 =?us-ascii?Q?YdHLFDuV0lSFtSVO+2W6zds06hAwqar+3bcfNBHo9lCZiKtVlhN95K89HRH3?=
 =?us-ascii?Q?VnCpWombRNpkMcoliAr1lRyeG3xh/J1FcviSYpyOTYOYrXT+Dxaf8Hf71bNC?=
 =?us-ascii?Q?zHc1lQvQMpvAvwi46gJ0LEp1BkxxXLI6MzPmagEH5CROTL3mC0Q5DOUsB9Tl?=
 =?us-ascii?Q?WaNQMGdcK/EiWOrvD54yYWNIMBZyqD3ypR4dmUiD9gYN+78ennhZU8s+q8lS?=
 =?us-ascii?Q?47Q9qdIfdQfm3Rop1e67i4D3SWcPqIDZdmykeEkv9dLJ+URxZkWjyHu8237x?=
 =?us-ascii?Q?HwiMj3lnqG4uGh26o3Rmwumi3nbxl9OLlFq1LSbuSYkNgVVRcaGzP0awQKpl?=
 =?us-ascii?Q?ytF2b/QWnbrQnRFsSmhJV8CVO4dbmGtsxdXjssb9fdi5XW9FDC1h3FoRCHFE?=
 =?us-ascii?Q?h4g3AI6r2oDl3Aym6MJvaIqlHJpgMwZsN2Po16+fB0MD8cyzuqfhFXRXLWg8?=
 =?us-ascii?Q?7beXsY+btD5qzhZGqZAlCSE41YtM9Goemnm4Zga2YC/b44aRUE0kEY1sUFdg?=
 =?us-ascii?Q?tsTcl78MN/6FypljhL2loBAk/zoljMHqWg96OycezCBry+RPA741i+GSjXOj?=
 =?us-ascii?Q?BmPW2HHTJtHc2otWxuhn5fBlWpu9QK7GG+46mHUAj7RyAy1WxBDTDYRDo6Uk?=
 =?us-ascii?Q?FDSPhhDeW0GpG94UwVHZWrQR1cjOoSUOPXM1PfonRTcNRqCqT/Vq7W+fFkAh?=
 =?us-ascii?Q?Le5/c1/tpgyGZyTYatzj2z0ohfe08teLgrnGOyVS/lMwHIhBotAkGA1wB+s+?=
 =?us-ascii?Q?uzaZ/NSBrqqRFdSkd/XKL//OQ7jx75cwQl1DacajEK/vtZB2M8yez7ooeviU?=
 =?us-ascii?Q?atmD9lQr63KJnxF9LI/cLckkqwUbmo84KR3S2msl4GIfZ0m2OLQUjgAHvpQV?=
 =?us-ascii?Q?SG8X9diqKSldqbchCkG6ema/Q2JexNlJTXPHcowpQs7EFXjDQ0RZuAlFMa/P?=
 =?us-ascii?Q?nGMF3fHH8Wc55a0aOx9zPwh+ascg1c0=3D?=
Content-Type: multipart/mixed;
        boundary="_002_202204271543142o32gn46323hllnbrevolver_"
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 142f0d2e-4ef7-473d-7613-08da2864a650
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Apr 2022 15:43:17.8165
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Hf3O5aLBosOqGQj1tI45Bs7KMMivC8k6M5CHzfIOiOQ24HgIfjrq+hT7zg5YnY/WTFZf9TXvrkz+G1IQweq30A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR10MB4096
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.486,18.0.858
 definitions=2022-04-27_04:2022-04-27,2022-04-27 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 mlxlogscore=999 mlxscore=0
 suspectscore=0 malwarescore=0 spamscore=0 adultscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2202240000
 definitions=main-2204270098
X-Proofpoint-GUID: QRFle6sq9pYDX1LPMUV28LzZ8ZHcase9
X-Proofpoint-ORIG-GUID: QRFle6sq9pYDX1LPMUV28LzZ8ZHcase9
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--_002_202204271543142o32gn46323hllnbrevolver_
Content-Type: text/plain; charset="us-ascii"
Content-ID: <1A8BF0F9A20C3C408A90382F3252A20A@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable

Andrew,

Please add this fix to your branch.

Thanks,
Liam

--_002_202204271543142o32gn46323hllnbrevolver_
Content-Type: text/x-diff;
	name="0001-fs-userfaultfd-Fix-maple-state-in-userfaultfd_regist.patch"
Content-Description: 
 0001-fs-userfaultfd-Fix-maple-state-in-userfaultfd_regist.patch
Content-Disposition: attachment;
	filename="0001-fs-userfaultfd-Fix-maple-state-in-userfaultfd_regist.patch";
	size=1331; creation-date="Wed, 27 Apr 2022 15:43:16 GMT";
	modification-date="Wed, 27 Apr 2022 15:43:16 GMT"
Content-ID: <84D646A2C03CDA4695D0728B59A04B64@namprd10.prod.outlook.com>
Content-Transfer-Encoding: base64

RnJvbSA5ZWQ4NThlNDdjMzkzOGZkZmY4YzIyZmIzODZiZGMzMzY2NzczMDkzIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQ0KRnJvbTogIkxpYW0gUi4gSG93bGV0dCIgPExpYW0uSG93bGV0dEBvcmFj
bGUuY29tPg0KRGF0ZTogV2VkLCAyNyBBcHIgMjAyMiAxMToxMzowMyAtMDQwMA0KU3ViamVjdDog
W1BBVENIXSBmcy91c2VyZmF1bHRmZDogRml4IG1hcGxlIHN0YXRlIGluIHVzZXJmYXVsdGZkX3Jl
Z2lzdGVyKCkNCg0KV2hlbiBWTUFzIGFyZSBzcGxpdC9tZXJnZWQsIHRoZSBtYXBsZSB0cmVlIG5v
ZGUgbWF5IGJlIHJlcGxhY2VkLg0KUmUtd2FsayB0aGUgdHJlZSBpbiBzdWNoIGNhc2VzIGJ5IGNh
bGxpbmcgbWFzX3BhdXNlKCkuDQoNClNpZ25lZC1vZmYtYnk6IExpYW0gUi4gSG93bGV0dCA8TGlh
bS5Ib3dsZXR0QG9yYWNsZS5jb20+DQotLS0NCiBmcy91c2VyZmF1bHRmZC5jIHwgNiArKysrKysN
CiAxIGZpbGUgY2hhbmdlZCwgNiBpbnNlcnRpb25zKCspDQoNCmRpZmYgLS1naXQgYS9mcy91c2Vy
ZmF1bHRmZC5jIGIvZnMvdXNlcmZhdWx0ZmQuYw0KaW5kZXggYmI3MzM4MzkxYjJjLi45NzRlMDRj
NTE5NTQgMTAwNjQ0DQotLS0gYS9mcy91c2VyZmF1bHRmZC5jDQorKysgYi9mcy91c2VyZmF1bHRm
ZC5jDQpAQCAtMTQzNyw2ICsxNDM3LDggQEAgc3RhdGljIGludCB1c2VyZmF1bHRmZF9yZWdpc3Rl
cihzdHJ1Y3QgdXNlcmZhdWx0ZmRfY3R4ICpjdHgsDQogCQkJCSAoKHN0cnVjdCB2bV91c2VyZmF1
bHRmZF9jdHgpeyBjdHggfSksDQogCQkJCSBhbm9uX3ZtYV9uYW1lKHZtYSkpOw0KIAkJaWYgKHBy
ZXYpIHsNCisJCQkvKiB2bWFfbWVyZ2UoKSBpbnZhbGlkYXRlZCB0aGUgbWFzICovDQorCQkJbWFz
X3BhdXNlKCZtYXMpOw0KIAkJCXZtYSA9IHByZXY7DQogCQkJZ290byBuZXh0Ow0KIAkJfQ0KQEAg
LTE0NDQsMTEgKzE0NDYsMTUgQEAgc3RhdGljIGludCB1c2VyZmF1bHRmZF9yZWdpc3RlcihzdHJ1
Y3QgdXNlcmZhdWx0ZmRfY3R4ICpjdHgsDQogCQkJcmV0ID0gc3BsaXRfdm1hKG1tLCB2bWEsIHN0
YXJ0LCAxKTsNCiAJCQlpZiAocmV0KQ0KIAkJCQlicmVhazsNCisJCQkvKiBzcGxpdF92bWEoKSBp
bnZhbGlkYXRlZCB0aGUgbWFzICovDQorCQkJbWFzX3BhdXNlKCZtYXMpOw0KIAkJfQ0KIAkJaWYg
KHZtYS0+dm1fZW5kID4gZW5kKSB7DQogCQkJcmV0ID0gc3BsaXRfdm1hKG1tLCB2bWEsIGVuZCwg
MCk7DQogCQkJaWYgKHJldCkNCiAJCQkJYnJlYWs7DQorCQkJLyogc3BsaXRfdm1hKCkgaW52YWxp
ZGF0ZWQgdGhlIG1hcyAqLw0KKwkJCW1hc19wYXVzZSgmbWFzKTsNCiAJCX0NCiAJbmV4dDoNCiAJ
CS8qDQotLSANCjIuMzUuMQ0KDQo=

--_002_202204271543142o32gn46323hllnbrevolver_--
