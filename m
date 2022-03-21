Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B3F9C4E1F77
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Mar 2022 05:16:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243688AbiCUERX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Mar 2022 00:17:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239857AbiCUERR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Mar 2022 00:17:17 -0400
Received: from JPN01-OS0-obe.outbound.protection.outlook.com (mail-os0jpn01olkn2027.outbound.protection.outlook.com [40.92.98.27])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB3EC102416;
        Sun, 20 Mar 2022 21:15:51 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QU+rb5ZEeU1dMTr3XL6YNFOIvjONUojPOl9N1UNob27eksihgTIyISQR2G5JZlG8uRzYIcP825BiBbzBUPEB6VvKw5TParPKy5o7RO/UjWjAS9D6ENdQr3nwgBwx/Pzkb4Xr9Qo7YJwhn8CY9WWV6VYXjJeP3wB+Ym/T1UJ55o/mAKzvB73Du8FSCUogT8FPThQY4Gv1CgSZwS0Af+wJP4Qbg0IaUSDDDNE0yXyFDp75Z5ieLkKYT9P1U4i8DIsTR5GcMlgYF7KGy863IoTIVDMumyXDlz8OlzQEz91N1d64bxODQbtLvSkgJRdI/GsCc4j4nDD16O0he3Co+3fyWg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=k5l76nAuFm+Ypk70E+YCnCSU7oIMrBUyr1KZw2NresA=;
 b=aDKIY5P33fnhB5Q078/0b50qlqYGIdKUUsgSqmwC5dglKSVtlt2m2poimeAI4k8SC9ScaghRCBynYYMEsYil7l7qM+pzbw2A7HKEJaD1Z1LQQ26HpInlC2Z4k2hrLjnKU9KqMVkhk1gkQKSsouBY88wekTqdtvACWuBe0DPxQOnTVZY21F3wNBSiwLIIxlWstDAHyEHLYcgnisROo64JsPIWLbUKMYXdDcDO3D6iNHUG7O55jLl1ox5KahDfrhSoaEJb5jqRnDprigRgyoVV/5V/03f/cEnWsXO3Hn5BiboXul67TdLhzMzS5GilQSIAJONEXlRB27a/yI71CQiXAg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=k5l76nAuFm+Ypk70E+YCnCSU7oIMrBUyr1KZw2NresA=;
 b=XMw6Sq/0MarshdgNxdDS0jnEXCO8kxHee6mP8ygDAnpEdjcxf1DuaYy4mj8SOAflCk+P73YLVsZjmk6tn3tVQpRX9KJWNjiwkYvzsXAB/PaGKqoq8yYx1z31m4BcD2rN8OfzLHCA5gTyv6bX3ySXC0zi4INbivHSUTb2R+ULOmg8fQpcxkDOcD8AlvfPIADKlkAIf+mui4girmeXs26lZuzhcFoS8G2Mm6sg17XDhcgvoC5zM//2wyAxPK/EqVJX2f/OIb9rNf+fZakJJL3pzL8NZNMMhvxsE91BdUmASQ3abCzuZNMUOcUMMOdTSd2T6bhvDBGsKBDmMjJf8f9D9w==
Received: from OSZP286MB2078.JPNP286.PROD.OUTLOOK.COM (2603:1096:604:16f::10)
 by OS3P286MB0994.JPNP286.PROD.OUTLOOK.COM (2603:1096:604:10c::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5081.14; Mon, 21 Mar
 2022 04:15:50 +0000
Received: from OSZP286MB2078.JPNP286.PROD.OUTLOOK.COM
 ([fe80::e505:230d:4122:cd2a]) by OSZP286MB2078.JPNP286.PROD.OUTLOOK.COM
 ([fe80::e505:230d:4122:cd2a%7]) with mapi id 15.20.5081.022; Mon, 21 Mar 2022
 04:15:49 +0000
From:   Cui Alan <AlanCui4080@outlook.com>
To:     Alexander Vorwerk <alexander.vorwerk@stud.uni-goettingen.de>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "workflows@vger.kernel.org" <workflows@vger.kernel.org>
Subject: Re: How can I post my patch to others
Thread-Topic: How can I post my patch to others
Thread-Index: Adg82g4vkTHUiCNeSf2xczPQN8Mk9w==
Date:   Mon, 21 Mar 2022 04:15:49 +0000
Message-ID: <OSZP286MB207805CBE394520BE6A0ED52AD169@OSZP286MB2078.JPNP286.PROD.OUTLOOK.COM>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-tmn:  [69K44bYDEWsMlH1B2WARQ7XTiLm0YN8dfuTiqRcYnx75ldfytKfKFPxtZpGfnZ4zY6XEPafLKY8=]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: cd60d685-e586-46b9-a1f7-08da0af17b31
x-ms-traffictypediagnostic: OS3P286MB0994:EE_
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Uss4ZEbVSaKUYlTuqzjdtzklZpbKUvRxzLnrOZDxOfNcis1hmclnUH53vKorRQsdyJ9oY5WiyrAiMiz44kIjSEmWnA894+13ZoN1dAkw1u+ZB6qyYqntP88sg5KnLxgt6Xm5ALmhM2ULOVzWS66QA1xaLt6bVzniNMcuNdqWOv43XsUXU8YsWaDEDg6j80gt9b+cZjT+F5G1gQ6ZWQaxPZ9ifqGCUjajDWl/12Kf/+wAnVvI8PHm/Dpz1XIlWfFQUNcV4tBiPzM1lRH/sPHv+WhzxvCGLnqYPM2m5/2o4umspwIHHkubnMkQcLYU8ZFAHpevzyOSR3YnCRWn3xnT/QHEHS4dors6smf85oM3hXrya/8KBaa5aQZkagjqHa6uhNbhqT55ZNrVmH1x+SUPXZKnALApRBQANpkJzdlNQx9zh6N5UFww/CvBPUz6kxSKkrt5cs61JSxt4N4LSNxxvwoU4T9i9KZ1jDL4SquHUhpCus7Caf0bg7mmv9Eouv+zf9JEpqmQWwZ8qKIpoHxuySpZZDZR2HZNB3HLeyknGmYi40KrAtwE+H9tXngxWRbcrz60KMLK55hPvrlBP/eUyA==
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?QjgQsqWtM1Br6JUNS9xqKU/ONpHx8YBpWPQXb05M9kqh1PDBbn4ffH+6hY/e?=
 =?us-ascii?Q?HARS74h1/jjCwqo7I1rXL84OKAhs/g4zb8btC5hoXWWVEoNRV6crgwOCdEa6?=
 =?us-ascii?Q?t8uiirFWH9cbs6JV0lOviSdO1/Qvots5YWWWesmxZfmqhmWqidZVVC7grRAZ?=
 =?us-ascii?Q?/XJz0IT0hUKApSHMv8ZvMu64V+rRH1ECxhpKeGPPOAROofMfE+rxQLcF0kin?=
 =?us-ascii?Q?81QDutCGLAUKjhcLJWr9XS3xi4bRD+QHpaiMvigpJOHiZ7flU5aRk0dJHKdx?=
 =?us-ascii?Q?PEIm5kMX7IxB6RtQmhHYEi45HI0pgCoazwMP6aC7mlgNnMUpmel/wbI9k9RW?=
 =?us-ascii?Q?le6z9zvfTpcwHDqowc1waGNhYdA3HnRWfAyxQ3ULK3r0oGX5q8ZkjJdci8mf?=
 =?us-ascii?Q?zGhR982col1r1R2a7aAkQjBIrCktgLKiterlVolCZ6aLxQbEn6bXPtbBMwH/?=
 =?us-ascii?Q?1G07q38k+qqc+0ff6jwzoUDf0N56MPs/RKG8/rwvqasBnvHTb4XTV34EfPki?=
 =?us-ascii?Q?SSUnPg4w2hZhLz7RVVaC1896wA2b3hT5Zi3EB+w2ATGOccJXFGnyvRU806GZ?=
 =?us-ascii?Q?NQUX5I4BkQ0k/j4h5DYttK0CW7CXkWJjCCplvj2TgMnqzIckhNhTemMHrBHL?=
 =?us-ascii?Q?Gkd3tqIO24CBeUxWygvUcsOUhZP2cvp4vFnc1kA+S6CT8j3Izpb6j+WL3K9y?=
 =?us-ascii?Q?7AAX03jrYtCk8Ugtsb2mupLbeLAQla4BlQCKk1Or3QvYPsK/F1xuNfv9cRYR?=
 =?us-ascii?Q?hF+g1SoWq+uu5e+FcXNNAnYIyOG07gmocSffr/G6JXYIsS0xY0t8zCzmfZRd?=
 =?us-ascii?Q?sc5Y+ncSrI7raOJRpbcqXz9/9VYQOrdZcu/DkqNWUIJ2X0hCmA7SpBvTbdf2?=
 =?us-ascii?Q?RPeoc/a2Cbmh9U8T2RYCkuFqKnjEhsldELERiKkl3oUQjhyON43P9mYpAUWf?=
 =?us-ascii?Q?QdSLKgtCa1xbBVOWhqvBAwjfT8Fc1z9h3xM40JWpAmbWOP/HzqNG5wb0XUdx?=
 =?us-ascii?Q?0MmYuwO+in4YTOj4zv/U5O8NV8moV2iswo8+qjFn6J3UdHJMWE4XRJhjJ7lo?=
 =?us-ascii?Q?67gb1TeNNFWchjm09YZPXS5GveQaS6HRAtsKBWRsYX3QpdXVpmaJFD/eAMTY?=
 =?us-ascii?Q?29XSmp5mcI9ZMYXIE6CvlNF/aiDKj5imZnBfiq/OLcwEArSQvNE9dN+R4BDn?=
 =?us-ascii?Q?nomG9FtqG6/bxd6U8btsAjUvw0df+P7yTMkQIQ=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OSZP286MB2078.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-Network-Message-Id: cd60d685-e586-46b9-a1f7-08da0af17b31
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Mar 2022 04:15:49.5811
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS3P286MB0994
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Cui Alan <AlanCui4080@outlook.com>=20
At 2022/3/21 9:55 GMT+0800
> Collaborators:
> I'm going to post a patch, but I still don't know whatever can I simply p=
ost the PATCH to
> others in the "linux-kernel" mailing list. It's said that I can do that t=
o make PATCH examined by
> others. I don't want to pollute the main list.

>Sincerely,
>a.

Thanks.
a.
