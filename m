Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 51E614D8B4A
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Mar 2022 19:04:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243582AbiCNSFU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Mar 2022 14:05:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242511AbiCNSFS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Mar 2022 14:05:18 -0400
Received: from mx0a-002e3701.pphosted.com (mx0a-002e3701.pphosted.com [148.163.147.86])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40B003466E;
        Mon, 14 Mar 2022 11:04:08 -0700 (PDT)
Received: from pps.filterd (m0134421.ppops.net [127.0.0.1])
        by mx0b-002e3701.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 22EG9cai000425;
        Mon, 14 Mar 2022 18:03:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hpe.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=pps0720;
 bh=8MfsgC35L05kMfAoBMYoODlejaCWxr5FxjjVrzqT0Es=;
 b=SEECGk4tUuCAGDUvP7d0vdooNLCLCbFSfWFl+upW/50jpm3SguY8+Fzg/QFlFSaiGfl5
 MvkJG2Y5g/5otUUTM7RxQKd3khJdZpOFogt4y1CWAVR640N34z0PKkZf0LjhdoJOqsVi
 XFyRBnKeU+UEo4equKttmn8dZtnJO1mf1BNb6aQmnf2U2x7wWjMXp/i+VnhS6YP8G0TH
 yJz5jdgBW2t88p/RiMDoKbs7JsROunFiIbi2bpFNL6PJsZpHoBZUM6Egq/AOPr2xrzio
 Jyua2jArv1VIyK6IhHZbh/9A6E+c7druxD9FD/zopgGDdhMyE+qqv/NUXpe1uBTCjtkR 8g== 
Received: from g4t3426.houston.hpe.com (g4t3426.houston.hpe.com [15.241.140.75])
        by mx0b-002e3701.pphosted.com (PPS) with ESMTPS id 3et8yvgy69-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 14 Mar 2022 18:03:53 +0000
Received: from G1W8106.americas.hpqcorp.net (g1w8106.austin.hp.com [16.193.72.61])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
        (No client certificate requested)
        by g4t3426.houston.hpe.com (Postfix) with ESMTPS id D4E8854;
        Mon, 14 Mar 2022 18:03:52 +0000 (UTC)
Received: from G4W9332.americas.hpqcorp.net (16.208.32.118) by
 G1W8106.americas.hpqcorp.net (16.193.72.61) with Microsoft SMTP Server (TLS)
 id 15.0.1497.23; Mon, 14 Mar 2022 18:03:52 +0000
Received: from G1W8106.americas.hpqcorp.net (16.193.72.61) by
 G4W9332.americas.hpqcorp.net (16.208.32.118) with Microsoft SMTP Server (TLS)
 id 15.0.1497.23; Mon, 14 Mar 2022 18:03:52 +0000
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (15.241.52.11) by
 G1W8106.americas.hpqcorp.net (16.193.72.61) with Microsoft SMTP Server (TLS)
 id 15.0.1497.23 via Frontend Transport; Mon, 14 Mar 2022 18:03:52 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=I/cjJiu2ECyt38Sh4pLQRo4pO5ZrDW1ucE0HyLuVKnGWIsVrw4C3C4ApC7+M5M8DsN7Yt2UsoeLChRW2G6/lJFL0gQ8ChRgJ0X3WqOoPdGRdnNWja27ga7wGOcjP+pDfngvns0jAuULeeEcY1Krz2FTYxNLBGDPB8qabeVBQielYFLKQCZ02+szcVlNeexu4gCmwnLxEMXLxD9rLoHJ8Gy6U09OePQn7MbCH8EM8LXj/sZOiv6O/EgXJCb9cpjeVV2/j2q3tBddbMLWlXE+fUrQoOENYSa0+qSf6M7IRUNrHLIg3aXh6FAZKG8kDDoCgtK/0NEtxPe9WNVKLbukIZg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8MfsgC35L05kMfAoBMYoODlejaCWxr5FxjjVrzqT0Es=;
 b=bHL6YeeOU8bAnq7Is4mWOEmKblEaEYA+Zoq+h/pRUNH0pLmR7TvOmwDn+YhmI74kz6aEe/5wE/iybI8I+Hrypn/fckq9QRLGalJ/slEFtb8/EwkXxRPLLyvvZXEb55M8GBlH/TVzK/Jqq+ufoyPRmn9/4u+T6tf6h67HmAc9Abm2b8WnVvxnHaHAW+0n/cUSVDwthZ2T+is6qdvOSL5y9jIWG6BkmUuBnqugXniXxUsAwV4PIj1FEk4M/umIrpZH3r0Md/f+JdtzbA2ag85eL7FAP+lVg7se0dzhvduA3/3Dw5+ABLUu8lauPQAmOPOZZ06dVcH/QjI56eCzvsqvNg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hpe.com; dmarc=pass action=none header.from=hpe.com; dkim=pass
 header.d=hpe.com; arc=none
Received: from SJ0PR84MB2109.NAMPRD84.PROD.OUTLOOK.COM (2603:10b6:a03:434::6)
 by MW4PR84MB3003.NAMPRD84.PROD.OUTLOOK.COM (2603:10b6:303:1ba::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5061.28; Mon, 14 Mar
 2022 18:03:50 +0000
Received: from SJ0PR84MB2109.NAMPRD84.PROD.OUTLOOK.COM
 ([fe80::ed85:f750:1776:51d]) by SJ0PR84MB2109.NAMPRD84.PROD.OUTLOOK.COM
 ([fe80::ed85:f750:1776:51d%3]) with mapi id 15.20.5061.028; Mon, 14 Mar 2022
 18:03:50 +0000
From:   "Ernst, Justin" <justin.ernst@hpe.com>
To:     Julia Lawall <Julia.Lawall@inria.fr>
CC:     "kernel-janitors@vger.kernel.org" <kernel-janitors@vger.kernel.org>,
        "Hans de Goede" <hdegoede@redhat.com>,
        Mark Gross <markgross@kernel.org>,
        "platform-driver-x86@vger.kernel.org" 
        <platform-driver-x86@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Ernst, Justin" <justin.ernst@hpe.com>
Subject: RE: [PATCH 05/30] x86/platform/uv: fix typos in comments
Thread-Topic: [PATCH 05/30] x86/platform/uv: fix typos in comments
Thread-Index: AQHYN5o3LA7nX0CQ3E284coAMhxxsay/KCMQ
Date:   Mon, 14 Mar 2022 18:03:50 +0000
Message-ID: <SJ0PR84MB21092D0F87B7C5D45DFC2AD0870F9@SJ0PR84MB2109.NAMPRD84.PROD.OUTLOOK.COM>
References: <20220314115354.144023-1-Julia.Lawall@inria.fr>
 <20220314115354.144023-6-Julia.Lawall@inria.fr>
In-Reply-To: <20220314115354.144023-6-Julia.Lawall@inria.fr>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 0ce8133e-1c30-42f1-3a12-08da05e4fea2
x-ms-traffictypediagnostic: MW4PR84MB3003:EE_
x-microsoft-antispam-prvs: <MW4PR84MB30038FC6EFC4E99673F63968870F9@MW4PR84MB3003.NAMPRD84.PROD.OUTLOOK.COM>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: STio5K04JJ9j7MkW5b9lVvSVkA8SeJOtdehnH/n29kn28y4jHd/u16cbfTYKZpDpWTH8TQ4YPqfAbTETLzziSZ4o4VYiwoV/oinuOGhFdVAJoqDUbLuUUmZidcKrYohk9aBFz8TssAq+zYFMVmd4cC0mT6cLb7wZHd1hNFFVEdYCofH9matU+UahGm3CyrKXJbDCZFb2jJizPleo951LYAMhu/Gv4RzNm82Wyqkl4WSSbrsDQKVV5YgCr0/mjYukPGjuMM2dx9HnFdV2KsLBPeCZHfpk2oCnTj1yCU8J9erL9IhL90NCJIcNySrhYODgooXR/jiyvkGz0aHuOYbaa1VWEgF/1BFBrX4sAlWNZW55WLjsd7ag8rohI7XdeiT4Tk3dyTT06EP8uIZgnqr+ffRr12Q+EK71I/jNp7sq9NRdEPUPqwFDbqLGBHXa+GtZPnD8t8jW46xm4ejxOonPocslBuT85w6KosuCp0blqxVziQKmRFxVmj+T3zJUf/YncCa2tmTdY87q6G1GTjMBkmgb7MUmGtYYwpboZJWgiGUysjWLLv6zpQ48YwhGlkfITb/s5ManQScguab4ngGndbLc2bnhy2nC5grUmFCGEwHfZfTx+jhJ/TSgP4XGE2fA0pCytbPkRAsXONFyvY7UO6Ymqmv5Bo/xGQIGKfzDqlYuTUO0W+3qDegp+2aAFq/vZp6659ylJGy8LHDdCmfEcYgHoiMdllpbAsExBbdg1mgThKGTJdHXu5AwPoU636qR
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR84MB2109.NAMPRD84.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230001)(366004)(26005)(76116006)(186003)(8676002)(66556008)(66476007)(4326008)(64756008)(82960400001)(52536014)(71200400001)(38100700002)(66946007)(53546011)(66446008)(8936002)(38070700005)(6916009)(508600001)(54906003)(86362001)(6506007)(7696005)(316002)(5660300002)(55016003)(9686003)(122000001)(33656002)(4744005)(83380400001)(2906002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?zKYSpHypXHin3BrcemCceEpyXQsnNG/B3mq1BVziSLoDQU/Ls27AHvtDnQui?=
 =?us-ascii?Q?yWCZ/N88SkHvHUQS4NjxG0KbrpW/31xf372wIqjQZ/tGQGSGXanpnjBE31KF?=
 =?us-ascii?Q?3f/sPkKmv1fjEAsCK1xb3LJPBMj+zlgvki7zOv06sYhp5eCK4MImKg2guT5H?=
 =?us-ascii?Q?IHBY3+IQQ1i8eMFAzN2uisYBkL6Ht6bH0xzMwBXcbQx3wiy+9WjZdvd6364q?=
 =?us-ascii?Q?JOtifh+65jDolrocMKkLvJoBj7tgUsb8Q0Jch7qe/UoXXmUYR1iZZZSCMyB/?=
 =?us-ascii?Q?zqVJAFp6/VuacmpDoQqby+8tZBnFB6qd2NXNOdjU1hGF9kTTvy9TawNSEsEf?=
 =?us-ascii?Q?77v1iCfWEl+L0wGSZRxwRhTZPCx12Z6d4brTaPjoi4ZqE2tpmQNL3VkfYiFg?=
 =?us-ascii?Q?A9ve/rwriLwW2h1Nryu6hmAJI+WgNF5EyQsSTeA+0MoW21V+zVtNX+nyhdDB?=
 =?us-ascii?Q?eLWuwxlXRkKJbPNn/72kWG0xeqS2jzypAz04JX+O852vldg4RuJR1IckXDi5?=
 =?us-ascii?Q?zyNCxTwHNzcXj1yDfM0m18dzhQj7C4fsmI78gUVv4aDoxs+p4G/b6tb8ivKU?=
 =?us-ascii?Q?T8Q6clmriMagrsw9N3QkWe8+kg1bmTzW72VzRLgxwFxcTzfvLFIpWpY8FIhI?=
 =?us-ascii?Q?zR+xDNFyTo5TTkRsJL8RjxEgfBGD1o2jdaLXxjdLyy5O40VAqUTPAUZdYwTp?=
 =?us-ascii?Q?0zPOb2UOjNZfGXAoDSJQnC21tlaA0x6gtpazjdsh6iwFzKmpUHtBcxTIoAyD?=
 =?us-ascii?Q?JT0YM7T9pSgbRCJi3ozA5Pukho21DuvzosAttwXIJsjBr2KgjxhOKzlcQQQ7?=
 =?us-ascii?Q?HGY8L9hluLFoExanPe0WwPNWzgQ8jasE01SvbT+Jvsw8EagS02j9G1ZUNWFN?=
 =?us-ascii?Q?wwAwXWR3IOtX1A67dSgQZV/5FOvlAprn8vNqmthTPWkLzL5bw1ULA0fPs0b4?=
 =?us-ascii?Q?wuU/0Xqsx2yt1gNXrFayAd6mrrDZKaBuW4sTOrPvh1z50IPBHkFUfH7NYE1i?=
 =?us-ascii?Q?fTkPFwysUUuM64VaDkxggSFbvYcfs66h07P3gFKUxBTRs5jb9nNzNpaAIIL0?=
 =?us-ascii?Q?N8cXE62dDEDeJCdIZWLuSyDBjrt5/6nAZcnPH7D5k25TzIndz4u3yBEQl6vb?=
 =?us-ascii?Q?fwkB8ysl1cOwt2fjyknx7A7h/KVH9XA9Sv8yYQkjPor72/cNhc78JHGJA7pm?=
 =?us-ascii?Q?wNKMXTtiWnWQXSK0kmvLCDjI/UCyLyEXqHy5dCVjcLRjZN3onyz+beM4tVOl?=
 =?us-ascii?Q?4wiEOXNPd/hYtLrfrqEPmWXJqqPJoDHxVf0lfXaDVWPvDw6Cf30S8SKpxfg9?=
 =?us-ascii?Q?7pns7WIGbJ2pTtmtjmVlah8mfrobUiriKGjPz+llkCrwNCk2GqnRLA4TeibL?=
 =?us-ascii?Q?khxJ0DBpbicNrVM8E15GGqytNskndMg5OatcSSUkeAXE+QxsQzCiXA4kVNgL?=
 =?us-ascii?Q?MeV8dvmFTyVG9/R7ynWIw45Da6lQsgG5?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR84MB2109.NAMPRD84.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 0ce8133e-1c30-42f1-3a12-08da05e4fea2
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Mar 2022 18:03:50.8448
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 105b2061-b669-4b31-92ac-24d304d195dc
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: aVh5FPZF6NyvRAnbBHu/O0JTkRHX7H+mXBcqLpPVpN3e1vnkjBI5gZtcNaxjaaGmtFBo3CNS9dNP2X5S4UzXxg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR84MB3003
X-OriginatorOrg: hpe.com
X-Proofpoint-GUID: G8xqPfDHpXsrfj5aImM6eF8a1N6t2AB7
X-Proofpoint-ORIG-GUID: G8xqPfDHpXsrfj5aImM6eF8a1N6t2AB7
X-HPE-SCL: -1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.850,Hydra:6.0.425,FMLib:17.11.64.514
 definitions=2022-03-14_13,2022-03-14_02,2022-02-23_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 bulkscore=0 phishscore=0 adultscore=0 mlxlogscore=999 malwarescore=0
 impostorscore=0 mlxscore=0 priorityscore=1501 spamscore=0 clxscore=1011
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2202240000 definitions=main-2203140109
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Julia,

Thanks for the patch. I appreciate the time spent finding this.

Reviewed-by: Justin Ernst <justin.ernst@hpe.com>

-Justin

On Monday, March 14, 2022 6:53 AM, Julia Lawall wrote:
> Various spelling mistakes in comments.
> Detected with the help of Coccinelle.
>=20
> Signed-off-by: Julia Lawall <Julia.Lawall@inria.fr>
>=20
> ---
>  drivers/platform/x86/uv_sysfs.c |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/drivers/platform/x86/uv_sysfs.c b/drivers/platform/x86/uv_sy=
sfs.c
> index 625b0b79d185..7c7c95c59908 100644
> --- a/drivers/platform/x86/uv_sysfs.c
> +++ b/drivers/platform/x86/uv_sysfs.c
> @@ -555,7 +555,7 @@ static int init_pci_top_obj(struct uv_pci_top_obj *to=
p_obj, char *line)
>  	 */
>  	line[6] =3D '_';
>=20
> -	/* Null terminate after the concatencated name tokens
> +	/* Null terminate after the concatenated name tokens
>  	 * to produce kobj name string.
>  	 */
>  	line[14] =3D '\0';

