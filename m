Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9A0DC55A594
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Jun 2022 02:39:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231834AbiFYAjR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Jun 2022 20:39:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229530AbiFYAjP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jun 2022 20:39:15 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27505766BE
        for <linux-kernel@vger.kernel.org>; Fri, 24 Jun 2022 17:39:15 -0700 (PDT)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 25ON4xdW004505;
        Sat, 25 Jun 2022 00:39:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : subject :
 date : message-id : content-type : content-transfer-encoding :
 mime-version; s=corp-2021-07-09;
 bh=DDOifp1Io3xbIeHCXuzeVIZ0sTdlkpYQGQ5UMLm3bNI=;
 b=AkTMafS+nwopQjaurlUcImQSSS3tDB5IFG8Yvzdlr8kSN7Spydkgm+MjxJ3tyv0g7ml5
 KoY3EoAtwRZ2wD49ZntMTH73v184ArWNeqJb139/jleepaA+PmytETwy1NwfE04XgmET
 udnyvGzgjJ1Yl5YccQ2pV7Iv/jwK6fG1zeK8KWD2La6BvuSWuevaTfT32N0HglwBXJ0e
 nO75QoduZLrYjOjMw63yhhPhto9VHCFb1xPpytzJJCWFAxpR0C1Rft61YC/9sVzf4rHq
 kZs1D0csRSWfPTzgE67f3m1y1PuojqYvRaSYGv93Jfk4I7h3LT5DeLIiCe9DimZsFEM/ +g== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3gs5g2743t-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 25 Jun 2022 00:39:09 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 25P0a8O2008165;
        Sat, 25 Jun 2022 00:39:08 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2173.outbound.protection.outlook.com [104.47.59.173])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com with ESMTP id 3gtkfxy1py-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 25 Jun 2022 00:39:08 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=afmOdmeHeRc9W7yI5ciLH4p8QnglrUZmNYFt6zqbzboAeaNfXRa7jzss+T6ItyeHaM5TacAhivKmY/LL+OlxXcHgNfNvzNY6MHHXbg0vCcmYT+F21NTHCv122Dfi6Dor0bEijJwt5RWKtNEiFIapLNO0ZOELnlLvabLrPbTYiSG08+hAQ+s5sBtUVy/9gID15wcAHwQ8weHV+p35N8nMmJng8Aj4JnCEZANebsLKWIKtkYetYJq0J8zO/O8ngdXm5MiY8R67+49+PnNph57akpPaKzZ+CUNe+cT/PEPuIGd+mKCxElnBe29xvRUAtS9FWreJ7LKQ6AG3mzRfmYo5Vg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DDOifp1Io3xbIeHCXuzeVIZ0sTdlkpYQGQ5UMLm3bNI=;
 b=igM5UyoLOqJ6OCO5A9bUaHMb27WszRls2hwsXga4ybzySHfu3v74lpN77deFTqWPeHzSuCvdE/H1zNekfBxvWO4LXvv2CJ2d42hQRUav0st7ROsJ2ZL/tPdDk6o19EMoBkF7XQDISVDuufyfPAwkM+UJYxjfDZqyHpeZQKC3Kh0s8btzvdWEJnjHyL3Jd410biXRAa+EyK+yrbiIJ7rsNsEzoP7+2i829o/31mAqMG7DbaMLO/KofvRgrHxioxarqf9KimGUU515NasTLiozzKSqAzfoWAmQhyORMOYhC3zaa7Q5peOoJhLqtNl1iz7idVmbQsqj7x1T1SvvFE4agA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DDOifp1Io3xbIeHCXuzeVIZ0sTdlkpYQGQ5UMLm3bNI=;
 b=rhkR1kvndDVgLkdnGR7nZy5RXHxAaU9cckaJp4NY13jfdAr/JdrY8ME9TTm0oKz/laziXAgIJggnupNkXiBkSdp6CXAhGz1sXgJCCNoEzLh8BPs5xSK80A1SJ/bbRPCsymaj4IWklfxjnf5HU6Gg6FOXsIyJi13wdYTMF2sbbBU=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by SJ0PR10MB5648.namprd10.prod.outlook.com (2603:10b6:a03:3e0::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5353.15; Sat, 25 Jun
 2022 00:39:06 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::f59a:175d:d24:949c]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::f59a:175d:d24:949c%7]) with mapi id 15.20.5373.016; Sat, 25 Jun 2022
 00:39:06 +0000
From:   Liam Howlett <liam.howlett@oracle.com>
To:     "maple-tree@lists.infradead.org" <maple-tree@lists.infradead.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Yu Zhao <yuzhao@google.com>
Subject: [PATCH Fix 0/2] Underflow in  mas_spanning_rebalance() and test
Thread-Topic: [PATCH Fix 0/2] Underflow in  mas_spanning_rebalance() and test
Thread-Index: AQHYiCv5fO/H86RVQEWXQp93u/so/A==
Date:   Sat, 25 Jun 2022 00:39:06 +0000
Message-ID: <20220625003854.1230114-1-Liam.Howlett@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.35.1
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: c0f3d13e-6290-4052-aadc-08da56431c46
x-ms-traffictypediagnostic: SJ0PR10MB5648:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: WSSgDZcx0BjGYJDOP+Vd3asfZRL5AwGt+OUcZDxaMwQ0IxudtPq3MWrh9G0bmnHaDPmcrGgLdGG0drvt+Ca3JbJjYb01hICEbAcS090I9FINqnJCYLkyBi97efptXn1NuVqbvcyxx8WA21E0QW2f6mf+vRUXR1opmVxDffeOUGaJTZV9rgHQG6RexUEw7h+FNan36LfRRg8nU30U1gLVW0QkagAX4whJ/wmlVISU8BjbLuOfTKmCPP8Cn/SsIR+2HPvkzy6AKPHgZHCx5sSiCsjqhPBUjRu0TACOD++fWDG+jtYoUq2cqZxs0I1xZe2M/6zJLaWg4YqAUUmNAZQGqdWHJK4ykfh9B/TtVKjldh5kQAnuNXeqycllSwz8Rb/a2JAuvi+RU4aMAqRWhIZCkdIJbHRMtJ/vKbYaF2bRwzzL8UEMmBslyHFQUCmbGIQ/2sHBpHwfBKSoHmR5s9PFadEuXDAAP0Li7QZ2kgEvTQ0NwGk4sK4EMbcKwRLDMYZB3IaiU0+2PeWS/S4u67RTB/UhZTz+FDTJ9bt7DP3iVzcrPt0TAn/00GwlH8G45vBMgTwhuFdgQEkvo9wftJOUhL40rkAdEE3nfsN58ZOe3C6R4HbBh0nk3la8Bg+mx2zw1VbEP1In1cM9xX6fJsL0n6eQwefW0YuUM03yW3snPIpmHBGe405wCPyOJpEjZn9q9BKXxMUo1tCs0KTtRKKbzKPkfbmzz/gHhlT7l5QgcjK7YMLqLP7AyT3E524STDjlbTEvtXuhdb7Qxc0o8Eu85TahIah45j/RKtZscp89ROM=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(136003)(396003)(366004)(39860400002)(376002)(346002)(186003)(4744005)(8676002)(6486002)(38070700005)(478600001)(71200400001)(1076003)(6506007)(66476007)(66946007)(5660300002)(91956017)(66556008)(2616005)(26005)(66446008)(6512007)(110136005)(8936002)(44832011)(38100700002)(41300700001)(83380400001)(36756003)(316002)(76116006)(64756008)(2906002)(122000001)(86362001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?WG8gi6VUOQfTKW83/fWYn3XQsIDW71iFadgzc+22vDJu6yPwBBzg40T8Gz?=
 =?iso-8859-1?Q?83x//y87DixqOVzSdbpCKhT1pw+Ot63iD595a03pwaMhk/prBDLL4NC0St?=
 =?iso-8859-1?Q?D8WW2KaGRnRJr+kaFxYFIBWtaXQ6rR30lAtqYOxq2JzZ+JDjrC6UWatPQI?=
 =?iso-8859-1?Q?0bLMEiGvlE+qw3qH51g02j4mYNNhCdUWIyIjhc+jeRCBpVc8+D1knuXw9W?=
 =?iso-8859-1?Q?3vy+a1M8/3Bvv6W/X9vO+EMZhU0+RMOInoV68Xjh3P6ZfFce696Oezmg9u?=
 =?iso-8859-1?Q?U2i8W73g1JAF0fk+CqH3wJPKD9xGut5hzDnJ9WIdgW1fYU0ibWCCJY0lB2?=
 =?iso-8859-1?Q?PD8WdF/uFBDgacWSwKSzrMlxc70VaEY51aIJwBAvadFTtcLADDuoOiW0Do?=
 =?iso-8859-1?Q?nwj+gavfXkZrkm3WeVCkrCELglGCNqr2TXmClOgAVono2idiqpF8OoeWMx?=
 =?iso-8859-1?Q?iKdFrO4zCpxOyxMTc3eCKPIsKrmLMn7ZM/LpkUDEPG+PdlRFQJrmN8fJJC?=
 =?iso-8859-1?Q?/UfTectjb8ktp9L4jAccP2yoZuyu/I5E5lmhh9WDtKcT2oSNvDs8K0eHQW?=
 =?iso-8859-1?Q?4iTqw3SyFCvuDhpBhfGi7VrZ5P+VeznBFukUfWjXpTqXTAKb4spjvDYulA?=
 =?iso-8859-1?Q?wcFvukd0pgXtg1fU+O+ymjac1H+oOEwRO4nOy+2ZDmcvTdhoIFpo5KreZq?=
 =?iso-8859-1?Q?QJ5HsUm0fP0I4+9brMHObJ9g27ZMwS/PbNykM1sOhuq1VfZobfLi52V4PT?=
 =?iso-8859-1?Q?dRBMtNGPHmyMAOIZnevPlnwT4RGsp1HkfrmuOf5Y/OsNUkKXqW1ysUeqwQ?=
 =?iso-8859-1?Q?CHZrjCMOgW9bYm3oe47esGz+LHB2W6IOeGYa+0ebQ6rfNIjAhLqQSYVzl4?=
 =?iso-8859-1?Q?txXsj/0y7ECdNVnSLRGZVV4JwwitxPH/nTYptlBQSioGAriM+n1uAZmVyl?=
 =?iso-8859-1?Q?VAksKPsJRCoa9+H2uLeDDaIk1Su10ydgpksuP//b2xp6wCEu4gjKq4Zhkk?=
 =?iso-8859-1?Q?+933cRc7vjdTJz1X7EkHmYXBD68y4LyrM6MlJAUvPGeCfZvSXP1j+S3mNA?=
 =?iso-8859-1?Q?f3b8GCnQ/NJGn3Gur+7oEJ6CVCrxwMlzpppGJhJXmNiuZy7stbgk0c7TVo?=
 =?iso-8859-1?Q?EdkS8yfkbsWVYTL/SWnCuusLuvikH6avGTOcGS+CLootYuTGs0iQ0KQV2M?=
 =?iso-8859-1?Q?RAY6fqI39UfIac55cKHBTPxBuA1JhM/EXBy5E7fbbF+g3Qz5zJCoTpGVMv?=
 =?iso-8859-1?Q?a/dIKGFit7tZd1re2OK1HCGf9uku2L1TnZdKlWMa8+0r6X+P/oDWgFnF65?=
 =?iso-8859-1?Q?9hqJ5yDgQ6gI8HMx7eZ0KnFa0gtDwKlrkKfu/cl/MhcOYpWXRC043EEHd8?=
 =?iso-8859-1?Q?XEYEY1JxPRLTl5OkWwrK6DW5GgrdWAqrzkC0Fvbxhx6LRE5Pb4Qam1kuYI?=
 =?iso-8859-1?Q?t3nezZidJSG/RABuZtAzRL+hqdjxkuKktjkezTboW0XQKFGvVGO0pPxxPP?=
 =?iso-8859-1?Q?RfYlVYYoyVcwRldUt8RUpluktGS3iiWT8ztdbg4fbKpkWHn/uiZfrmVpPu?=
 =?iso-8859-1?Q?0C1RcTysS4sGicp4dWMaY5m0NaMPy9QqiFjxo8SV5einQqYE1R8PvNjS77?=
 =?iso-8859-1?Q?hqbLj0eXkQ4Vd59+wL2iFm4fq66HSn+j8ViEzGOHguyTfwyv39DbJQHw?=
 =?iso-8859-1?Q?=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c0f3d13e-6290-4052-aadc-08da56431c46
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Jun 2022 00:39:06.3381
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: wR9vbrDC0Jz0zRnJIB1lJEX5f0yNRSO0refYjwc9mLn3rHPRyKFMvothWbTDNZ+O3PGulaH/8/tb7tUQSc+uAg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB5648
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.517,18.0.883
 definitions=2022-06-24_10:2022-06-24,2022-06-24 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 malwarescore=0
 mlxlogscore=767 suspectscore=0 adultscore=0 phishscore=0 bulkscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2204290000 definitions=main-2206250000
X-Proofpoint-GUID: ZN1eCgTySa1Zmkvs_I1k1K6ic4nYT_k6
X-Proofpoint-ORIG-GUID: ZN1eCgTySa1Zmkvs_I1k1K6ic4nYT_k6
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes the bug found by Yu Zhao running stress-ng on a large system
(512gb of ram).

Patches against mm-unstable.

Liam R. Howlett (2):
  maple_tree: Fix underflow in mas_spanning_rebalance()
  test_maple_tree: Add test for spanning store of entire range.

 lib/maple_tree.c      |  6 ++++--
 lib/test_maple_tree.c | 13 +++++++++++++
 2 files changed, 17 insertions(+), 2 deletions(-)

--=20
2.35.1
