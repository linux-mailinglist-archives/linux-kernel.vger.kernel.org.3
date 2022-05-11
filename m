Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A2D4B5235F0
	for <lists+linux-kernel@lfdr.de>; Wed, 11 May 2022 16:43:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244957AbiEKOno (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 May 2022 10:43:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244937AbiEKOnc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 May 2022 10:43:32 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC823AAE02
        for <linux-kernel@vger.kernel.org>; Wed, 11 May 2022 07:43:31 -0700 (PDT)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 24BEWdpR010445;
        Wed, 11 May 2022 14:43:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : subject :
 date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=cNyWDGnZqiOLtZ0FIW1DUYFNTmYLcD+DP6zSVg9GmME=;
 b=nZJIZK4LteSTBtJXol8FFYPi2WMJAV764NimVXcmILXnf1popaeubxkX0WyODKqn3xHx
 6Q4S/pF+YdkVEVeAwgDE9TqdCtkOq8y6/SepJGalBRfQcdeT3U+U4C7dgb8PtKk5gJlL
 cEhblBFMdJvHLjZTqVMsSjnaxr/HEjPHlyAN+Qu0RCW9swj/9uGccQ2QA76prLLEG0XN
 dArTZ2ardQfp1NDEjmRlU+uGLFyMDg8+6wi+LhaPWprrmlbP/+npQjLyGtMTmG8i1bAA
 kY0BGlt5kvyO4srNRIVRMhqZ9eZefaTsvVe3Mr18PTas+vag2WnK0+0Rfb/kBWhTa83u cw== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3fwf6c9skv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 11 May 2022 14:43:18 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 24BEgCmO008591;
        Wed, 11 May 2022 14:43:17 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2102.outbound.protection.outlook.com [104.47.55.102])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com with ESMTP id 3fyg6evaen-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 11 May 2022 14:43:17 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GDf6h8Hu7zGx9Y8BcXFyT1neHXQ/c5KkB7OP+aQkRCtb1i4TLc0CDBsS9oQe7bB4r3STv+BMmlfNmPxw1Dt07HD1BAiIYqjRwYkb9MVbqCzgm42Oldu/7q9Z3sofNRpujuVGf41v/M9W2K8Yj0nobNYOsdKncRA9WJVlvJSiHjiZVukYHFobzbblYstvxBtbeKTPybLUVHOquVxDhXckuY3w23E7RyNI//+ekz6Id5cxBl5l0gSOdBDytgLzhb93rSkVH5AEUXwvAGbhhEy2byqrTx0avusoUNNNDAlkUubmQ15+iwv9VbA9d5yL/xxomqCj3fCYxyjEfOW0Dg6NyA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cNyWDGnZqiOLtZ0FIW1DUYFNTmYLcD+DP6zSVg9GmME=;
 b=SJ00Rs1rnCMJ0CZc1PKwi2ZcWa1CryEguLvboe9Y0YxMtbRiXPI8Ken9xdBiKu0/Pr3KZvz3BHiCUM3zXpYKQt7lx5RM4uLrcJ+OaLKFad0xOvmvfUokBzGBTQW4fc0qB+67MWNl0xqbPcac1rrkpUdlSsvjgXR+3Qun3mvOV2/b5KHFtkMPlVC83BkCxRVWQKueWltcA/5zSQJJqExgJ4mTFrNrVGg9huKAcHVmx6FoCIn9T6gG/GKKdu1P3rrtZybjjyci3bx3hX4T9vro83OV9O6dtvlitHVddM0YCitxWdIgWfX7lVdzoq7PS6PXwx6i9g3k8d1kh8kH8JQyJA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cNyWDGnZqiOLtZ0FIW1DUYFNTmYLcD+DP6zSVg9GmME=;
 b=AyhwOMxVGDGUJxq/UjZVaPTzKA9DVwbjYIAQ1Y+FdWEsernLT5g/ddTWoIV+WAVTLvmYriDSVpMliymJZT7jr0NpS1U3XEp0lKK0QzK3xX1uCAUs96678itctdwN7Og1Q4X2qQQRdNWib+lQTLzPSP3lxu5abK7jOnZrN+UMAis=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by SN6PR10MB2605.namprd10.prod.outlook.com (2603:10b6:805:3f::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5227.21; Wed, 11 May
 2022 14:43:15 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::318c:d02:2280:c2c]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::318c:d02:2280:c2c%7]) with mapi id 15.20.5227.023; Wed, 11 May 2022
 14:43:15 +0000
From:   Liam Howlett <liam.howlett@oracle.com>
To:     "maple-tree@lists.infradead.org" <maple-tree@lists.infradead.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH Fix 2/2] test_maple_tree: Add null expansion tests
Thread-Topic: [PATCH Fix 2/2] test_maple_tree: Add null expansion tests
Thread-Index: AQHYZUVyOPanb44qd0GwyyP7QVMhmA==
Date:   Wed, 11 May 2022 14:43:15 +0000
Message-ID: <20220511144304.1430851-3-Liam.Howlett@oracle.com>
References: <20220511144304.1430851-1-Liam.Howlett@oracle.com>
In-Reply-To: <20220511144304.1430851-1-Liam.Howlett@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.35.1
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: aa0b5357-8ee5-45d7-f34d-08da335c94ed
x-ms-traffictypediagnostic: SN6PR10MB2605:EE_
x-microsoft-antispam-prvs: <SN6PR10MB2605800F5248F48F34D499A3FDC89@SN6PR10MB2605.namprd10.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: PL9VB6i9j52nH/0ZCtdUwZ2dJ3J7awr90xS05cfsCtMqk+Hzxi83s0aXvUZct+woGb3QtCJ1MkOhCKqh/LqeW0Wsl+1XBh574SMDpMhxvNK5wWAP3biAvbnwXj1054ehZNmw0no160EP2JWrZ3P3WjuTgPK5atDXmN17kxguxNuZlngN202896WJmnzhGxeGIlel7FkkK0oOtAUgQ0Ar7g34CEmf31XsgUnUXkpYQjbLAkTAzmgUBFKgLl3aIhqEioZkHZolewIb3iLH6Pc1Acq2DxpG0l1TkSXGzXT+qVyfar9ufOby2iEM8Hix0i7gm59GCNKnmPpa8u5vA2XX6VgTL/qzqvKuH+bVSdWWzHb+LK/EgkwjuXnI8ldyCPVFGU2P86n4/dpKQZaCiNXNfLNvgb2TubTxkk0ca6+aYUUnranzHvZIjcxP/EnVDsTC7fTxMTOzcdS8eSivJZdTmEY3NDDOXaN9Ngt1owk+nqW0z/GLDXVhbDZO3GhI/8USLQpYdgvrI3t1iTKs8tYr2nGSNTC4f9zCsSTvwA4HQonkaw87TRTbc8jWjhC+566cHFh/HSAnsi4AwCjaaauuxie4p/QegRYa/vYSkqv5ZP80/aKRcrXhGi//yGhbqsFgKdtX+xg1q6i3NO3ehctilukjRPXPxyMx20X/gW9kEJUklR6OY6uMu8HY3e1ERCzig0bh36AkAleO5zzYpfoaTQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(36756003)(316002)(6506007)(2906002)(186003)(26005)(2616005)(1076003)(110136005)(6486002)(122000001)(86362001)(91956017)(5660300002)(76116006)(66946007)(8936002)(64756008)(508600001)(66556008)(66476007)(66446008)(8676002)(38070700005)(38100700002)(83380400001)(6512007)(71200400001)(44832011);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?l2uZWNOeG9JBFw5n5wEy1n2MDSw3O3tR8bs3MFwDLDMGQV2qhTVbKBW94A?=
 =?iso-8859-1?Q?PfSeqLJ62UNb4M1j6Q56BY7nFgA2NLXaZwZBkjedeu5sinDuf7yBELxA1m?=
 =?iso-8859-1?Q?p5pF/4WI8EAQMccD7pzcUaNDC3WvN41RE/eAI/dl1FGJeCnJJsE+DoTzQE?=
 =?iso-8859-1?Q?H69G6+A4MEjtEhAiPFthbpjOsApczVO4aqYqCpbk/pSDAy8wSJ1MZfkRnt?=
 =?iso-8859-1?Q?9wPQL336ATvpqikFqx+TVzeoZiIRK61qAM2JfE6M7jXymgA9gYojzv6Erg?=
 =?iso-8859-1?Q?bQZC//PPApxutNGokTRWcr54XGZDA/WxY7L+iX+ipnKabfOJpzBroI0vz7?=
 =?iso-8859-1?Q?4O1+uKeo7S0Hamb/rakoFsLgnv+jXndykp2Lc+UD0SVAIVUrz9sXr+ZlIU?=
 =?iso-8859-1?Q?vR2l3K9qC+rBR1ah2yPf4rY85sCL28tzuhrBVDhs+bOGqj6+YsY3eMF2E4?=
 =?iso-8859-1?Q?vPgEYXIfUANHw/PJT56ZVzirLkZhu8RZ3NMZTPw3tb24Nhxubsse7u851q?=
 =?iso-8859-1?Q?LLdmvPZJYgTG5GGqTGssyLeD5/8HEzELtjUuG3YmwMehEbTUlJq6tk0Pzr?=
 =?iso-8859-1?Q?05ICCO/8jAgquR38irCuSbVIEJBZAThm0ilDjVc0imVip6coKPnjhk6jka?=
 =?iso-8859-1?Q?xLz9vvDECq/T6stPRebStsq9ziWc69IVxGGe/SDyAG1MksXAbz2kWcwEqt?=
 =?iso-8859-1?Q?fnRy2cLFqApweJypm85Ljo2NwErEB6wdIw56/xO1QGX/bldzCK6JRI+XwV?=
 =?iso-8859-1?Q?XP5kQAnMUVfe8AGOfgKdtJ41497qb1nfWjIABWPwjnvBZOo+NkkVKAPRNX?=
 =?iso-8859-1?Q?8eL6wSXIWEHQFn0zkjp5gjbK38xAgmjpCA+uTxZi14cjcMrjA9aKIktVng?=
 =?iso-8859-1?Q?B6kgYoGJiMThproGtdvEYjlrQ89r+5Kmz/Iq1Lv2bK0Y/sbVqPPt1xoHdH?=
 =?iso-8859-1?Q?BQo8zlYrVeY9aWiJPl/bf06TpOg/AcCVVyGmtk/9iDTn3NilW7bmfZMXM4?=
 =?iso-8859-1?Q?X7j69WWlix2RIbZiPil3j/0Xapl4NiTSNQVprjpG0ZcSuoews6CibbO2Ed?=
 =?iso-8859-1?Q?ickq+//JtNIOgm+4GMdKX/NEpgit2rojfLgFlmKUcZ0Ogsmc2t3jZWE0AR?=
 =?iso-8859-1?Q?5jqqfM1KfeTHxVFMDw1+asUIRUrO86M6oRAzvrRTVHOJAhBvcCaahe3d0D?=
 =?iso-8859-1?Q?+uNWMM0kuH1u/bskbei1Pz5NfPsLLHn+m3QY5rl84IxDyagYi80eBeYXLN?=
 =?iso-8859-1?Q?9lMoqZmLekzrYWga45w+uWIa5uomChjY76rP+Z9tq5+/e6YYP+69UffHeq?=
 =?iso-8859-1?Q?Z8EDYwwrbFha8uaXGz6OpXRF2lSVkF31IimsfR19k3N2JoyCfGvkI8TAqK?=
 =?iso-8859-1?Q?SNMFwfXrNwu5VlOOzgPh1fIiL3o/we3dHDo8gb8i9+TWA1HU0OajiaeR0l?=
 =?iso-8859-1?Q?ifev9x3PIOvaHrajSttH4mz5lstzrFfkS4RFoUrFY1iGqNg9Bit0CfV82m?=
 =?iso-8859-1?Q?oJAEpPw3YPyus9cbVwfth/imZELQHAcDs7eHV0EwWPT5i1wn4nX1fb0RTK?=
 =?iso-8859-1?Q?jJF0WLKMroipn/GFNnhA6dqpt+wH1ftpKll40LyPIUM6ap1+C5vRy43S+z?=
 =?iso-8859-1?Q?aH6ExLeoB+ym3QNx8eQaPfAGFugMNj1bBA65FYgeV3ohKGiPuyM8CJROuV?=
 =?iso-8859-1?Q?pgTWOWmQiBG6Spv82fTnvyWrFCB1MbKoasR7cWJywVtyyyymjw18fjqFTi?=
 =?iso-8859-1?Q?jj35DJPZED5Y5eLXBjcpfCZ+uTC5U8wgLwFizNusP+D/I5g/NDqe32GEHR?=
 =?iso-8859-1?Q?VrgaOp+7tFb0NXAeCZcQ4vMM7WrV1zA=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: aa0b5357-8ee5-45d7-f34d-08da335c94ed
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 May 2022 14:43:15.1695
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ZpkN/9RuKYhDXYzaO39HPcEJ03n7YpA7iBJWHNHhLoglJlix3N2Sd3nL2uJYbc6SPyTtG9hSnz4tLhPOWrfTcA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR10MB2605
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.486,18.0.858
 definitions=2022-05-11_07:2022-05-11,2022-05-11 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 malwarescore=0
 mlxscore=0 phishscore=0 spamscore=0 bulkscore=0 adultscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2202240000 definitions=main-2205110069
X-Proofpoint-ORIG-GUID: 3TIWhdZU6LOSjZGv4N2yyPHUaY-Sw_c8
X-Proofpoint-GUID: 3TIWhdZU6LOSjZGv4N2yyPHUaY-Sw_c8
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Liam R. Howlett <Liam.Howlett@oracle.com>
---
 lib/test_maple_tree.c | 55 +++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 55 insertions(+)

diff --git a/lib/test_maple_tree.c b/lib/test_maple_tree.c
index 7c377b6e0905..8277464e182c 100644
--- a/lib/test_maple_tree.c
+++ b/lib/test_maple_tree.c
@@ -35537,6 +35537,57 @@ static noinline void check_root_expand(struct mapl=
e_tree *mt)
 	mas_unlock(&mas);
 }
=20
+static noinline void check_null_expand(struct maple_tree *mt)
+{
+	unsigned long i, max =3D 100;
+	unsigned char data_end;
+	MA_STATE(mas, mt, 959, 959);
+
+	for (i =3D 0; i <=3D max; i++)
+		mtree_test_store_range(mt, i * 10, i * 10 + 5, &i);
+	/* Test expanding null at start. */
+	mas_walk(&mas);
+	data_end =3D mas_data_end(&mas);
+	mas_set_range(&mas, 959, 963);
+	mas_store_gfp(&mas, NULL, GFP_KERNEL);
+	MT_BUG_ON(mt, mtree_load(mt, 963) !=3D NULL);
+	MT_BUG_ON(mt, data_end !=3D mas_data_end(&mas));
+
+	/* Test expanding null at end. */
+	mas_set(&mas, 880);
+	mas_walk(&mas);
+	data_end =3D mas_data_end(&mas);
+	mas_set_range(&mas, 884, 887);
+	mas_store_gfp(&mas, NULL, GFP_KERNEL);
+	MT_BUG_ON(mt, mtree_load(mt, 884) !=3D NULL);
+	MT_BUG_ON(mt, mtree_load(mt, 889) !=3D NULL);
+	MT_BUG_ON(mt, data_end !=3D mas_data_end(&mas));
+
+	/* Test expanding null at start and end. */
+	mas_set(&mas, 890);
+	mas_walk(&mas);
+	data_end =3D mas_data_end(&mas);
+	mas_set_range(&mas, 900, 905);
+	mas_store_gfp(&mas, NULL, GFP_KERNEL);
+	MT_BUG_ON(mt, mtree_load(mt, 899) !=3D NULL);
+	MT_BUG_ON(mt, mtree_load(mt, 900) !=3D NULL);
+	MT_BUG_ON(mt, mtree_load(mt, 905) !=3D NULL);
+	MT_BUG_ON(mt, mtree_load(mt, 906) !=3D NULL);
+	MT_BUG_ON(mt, data_end - 2 !=3D mas_data_end(&mas));
+
+	/* Test expanding null across multiple slots. */
+	mas_set(&mas, 800);
+	mas_walk(&mas);
+	data_end =3D mas_data_end(&mas);
+	mas_set_range(&mas, 810, 825);
+	mas_store_gfp(&mas, NULL, GFP_KERNEL);
+	MT_BUG_ON(mt, mtree_load(mt, 809) !=3D NULL);
+	MT_BUG_ON(mt, mtree_load(mt, 810) !=3D NULL);
+	MT_BUG_ON(mt, mtree_load(mt, 825) !=3D NULL);
+	MT_BUG_ON(mt, mtree_load(mt, 826) !=3D NULL);
+	MT_BUG_ON(mt, data_end - 4 !=3D mas_data_end(&mas));
+}
+
 static noinline void check_gap_combining(struct maple_tree *mt)
 {
 	struct maple_enode *mn1, *mn2;
@@ -37627,6 +37678,10 @@ static int maple_tree_seed(void)
 	check_new_node(&tree);
 	mtree_destroy(&tree);
=20
+	mt_init_flags(&tree, MT_FLAGS_ALLOC_RANGE);
+	check_null_expand(&tree);
+	mtree_destroy(&tree);
+
 	mt_init_flags(&tree, 0);
 	check_dfs_preorder(&tree);
 	mtree_destroy(&tree);
--=20
2.35.1
