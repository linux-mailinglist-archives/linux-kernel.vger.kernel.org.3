Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 05BC249FA53
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jan 2022 14:07:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241370AbiA1NHF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jan 2022 08:07:05 -0500
Received: from mail-bmxind01olkn2015.outbound.protection.outlook.com ([40.92.103.15]:39397
        "EHLO IND01-BMX-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S241271AbiA1NHB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jan 2022 08:07:01 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Z4FQmP2iYMfmj1yPuYKbKkxocykd3k97tH4tB1cjaWGnOZiQBCg787+k1sOORXKao9pSOpf9oP3MPKoNRbMy0MRAW16WCcAja+I2HS0Ou9MYaFRoooG2AjzxpU5x1lKOPd5kzmm0ZgCpnd8+zP7wvhH311iWZPI3jlynttSaVLds3Uw1wz9W2t9Gj7Rn2oi4p9fwGJAVwDwz9LxQBdnrCico8DxYg/1QGJ3FOc1lOvR8h8patoVjWIWLBCwOteVGy/dIXst3qccfu+Y9YE0TC4C4sYhkyr1xHkWnVA6gxQQjKqPm98Rvj9gYuHLnz8FhZHpsIE5cWioySo8neWio+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=A2ZExjoW34sgF/TwvBqBC44+D3GoC6RmkMLsG70b6gI=;
 b=CUgEC9qxcLT1Ifbj3n1XA4cOi/h5wRtVeR+Q6RWWS0A88i7aw0UToZwf5hGazcAwWBXs1GSW+FcpnGNfU08EWW1lhwxiCUJwtoZvoxLHMjgZb1P+eowbKhscjmnB27Fe8rfCzzvLAG1+FUl536eBM7lwCOWGuXI110FOHgTVyo7NGkt86AFhBO3udqkTX8fWrWlOzKwdVkXySf1CLbYsSXZ1EEZCXPleEWQalSFtWeLvN5KTnEQtUYAbl571WNSRDX5u7pit71CP2w7e3oZ8HE/wkPskxqHN7L8rGIjtqpk2E8+j/IljebQZs1t696kOqr9moPIbouC7NUaklGUmVw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=live.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=A2ZExjoW34sgF/TwvBqBC44+D3GoC6RmkMLsG70b6gI=;
 b=mrYIxsyJRN9M7IiKf3gbZwEQuo65VnR0TDpuN0tgx/4yTUa/jKsXLDAo4+kjlEU3yOfClRhc/Qw9JzcyK7iCQcxA+j4p2vs3JDXftPBaPJKveXtguMe2rvEeoeKNfjPILldxDHRlX2DdAdf/Zt758nq+f3eEOF31TvHVYatIZ7pO7SVWW57fsIi6SCC388dsvXdj4EctBenTng6dQOfdrEJbe/JUrVYOUcwG7bTmxbbbkt5IZPTYN1e4AW7A6+MO6/PACeVG9SJw6YRAWvFIqQEgMMEa7se/JsjNwHuh7EfgDbP04WvK1ul+7uUbkPci9Rnl09TDORVqBAVtejQIKg==
Received: from PNZPR01MB4415.INDPRD01.PROD.OUTLOOK.COM (2603:1096:c01:1b::13)
 by MA1PR01MB0922.INDPRD01.PROD.OUTLOOK.COM (2603:1096:a00:4::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4930.17; Fri, 28 Jan
 2022 13:06:53 +0000
Received: from PNZPR01MB4415.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::d19b:7cd1:3760:b055]) by PNZPR01MB4415.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::d19b:7cd1:3760:b055%9]) with mapi id 15.20.4930.018; Fri, 28 Jan 2022
 13:06:53 +0000
From:   Aditya Garg <gargaditya08@live.com>
To:     Alex Deucher <alexdeucher@gmail.com>
CC:     "harry.wentland@amd.com" <harry.wentland@amd.com>,
        "sunpeng.li@amd.com" <sunpeng.li@amd.com>,
        "Rodrigo.Siqueira@amd.com" <Rodrigo.Siqueira@amd.com>,
        "alexander.deucher@amd.com" <alexander.deucher@amd.com>,
        "christian.koenig@amd.com" <christian.koenig@amd.com>,
        "Xinhui.Pan@amd.com" <Xinhui.Pan@amd.com>,
        "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "Felix.Kuehling@amd.com" <Felix.Kuehling@amd.com>,
        "evan.quan@amd.com" <evan.quan@amd.com>,
        "stylon.wang@amd.com" <stylon.wang@amd.com>,
        "wesley.chalmers@amd.com" <wesley.chalmers@amd.com>,
        "qingqing.zhuo@amd.com" <qingqing.zhuo@amd.com>,
        "George.Shen@amd.com" <George.Shen@amd.com>,
        "roman.li@amd.com" <roman.li@amd.com>,
        "solomon.chiu@amd.com" <solomon.chiu@amd.com>,
        "Aurabindo.Pillai@amd.com" <Aurabindo.Pillai@amd.com>,
        "wayne.lin@amd.com" <wayne.lin@amd.com>,
        "mikita.lipski@amd.com" <mikita.lipski@amd.com>,
        "Bhawanpreet.Lakha@amd.com" <Bhawanpreet.Lakha@amd.com>,
        "agustin.gutierrez@amd.com" <agustin.gutierrez@amd.com>,
        "pavle.kotarac@amd.com" <pavle.kotarac@amd.com>,
        Aun-Ali Zaidi <admin@kodeit.net>,
        Orlando Chamberlain <redecorating@protonmail.com>
Subject: Re: [PATCH RESEND] drm/amd/display: Force link_rate as LINK_RATE_RBR2
 for 2018 15" Apple Retina panels
Thread-Topic: [PATCH RESEND] drm/amd/display: Force link_rate as
 LINK_RATE_RBR2 for 2018 15" Apple Retina panels
Thread-Index: AQHYEqhR1816ln+3EEa6OAaxWUF3K6x3I2yAgAFHGAA=
Date:   Fri, 28 Jan 2022 13:06:52 +0000
Message-ID: <58B7B0D4-BA3B-43EA-9F54-06CCEB7EF833@live.com>
References: <139A7689-463E-4AD9-A2D1-A9969C3958D0@live.com>
 <CADnq5_OLpgEJjpN5y9b3gNwCmvdfNTA=puUv8UjOCDH96JgvOQ@mail.gmail.com>
In-Reply-To: <CADnq5_OLpgEJjpN5y9b3gNwCmvdfNTA=puUv8UjOCDH96JgvOQ@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-messagesentrepresentingtype: 1
x-tmn:  [eidEl9RmdL3hF4WaWmS5ZbBbI6BJsScK1fPFEI3gPFZumzP9MSFT70y+cB2vipVPPWHxl++SRzo=]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 44ddf1d0-f382-4aee-ed9c-08d9e25f0de0
x-ms-traffictypediagnostic: MA1PR01MB0922:EE_
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: zSnDS0aYGFfuawS+aNDo3MFcEsfQrrsGRu5ZO3ndrYJVYGux2EndxcCGo5uBt0iOP4my38VWfYq94YvqhjAwe8a+P73KcfK+aleevQNh0F54HKcVpD75qHzfUcTdnN6tEF3AhY2CP4z7TQK6XMH74g+iLrWTwO4n8vkSvaG5pOFnzGIm5/UwpOdEYeZaqMC4Hd67OpU/fcrtlPqgHiWk0CaQy7wCQ0O9dUS4LkVBCIUO4oFfZSI7qNLX8QPXbC1TBFR/ZPqt0Y+HHk2snFoJfhA58HfIRVbWcWVr6/ufMHG0HQcR0klj9Ky8NFsD0vtqFowZqKK8twwxO1a0+7JaQdLqRtR8Xq7GDhccYdpn6D+35PMuRBgP+Hw8KFFxNx0k93LouH9vqnGjtPHiDzqfupzcT3ZRQ1aMFTNRIFpwVaXbupGEmDkfJ081itrCLi0PKsEnbO0xFaSd1EbbcAMcByNhWq+oWBgB+Cm1nDzXWu3NkYMWLEj5bsdZ5K4UcId05umIaR+h9YQKlj5Hyr+f/7WENwK8Djfa5pW8NkkLW+9YgYU7txnpUzMMLhC6Gc9MWcvVP2FhojOaDqC9DIbNEQ==
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?wklw1xV6g/pJ/4sw27E5i/OBESb1TVqI7c30C/ETRZfXWOjWh2C2U3imCbXa?=
 =?us-ascii?Q?jS92etS7L2NGc6r4PamXpTxT6eMgzTNEsu2O2D2nhZ1ify9cTphEyzcGTv8/?=
 =?us-ascii?Q?j7gZRqRSMTHwFGQaS/Om7ze7fdOgprdyPm6Gt9Xlt3lj/ifIE06hksBmOANn?=
 =?us-ascii?Q?NTvGHnUd3MXuO26rKCC7PNoI8eS+lLc1XsF2GY5Mm8dqeqO4AqOdANiYPcES?=
 =?us-ascii?Q?BYn1DJepIcjM+Amz5VOnvlApMml8POnj1F2inmFWt/31cP71f6OwFCa/arQN?=
 =?us-ascii?Q?yFwuHUFaGs4adaRy4fuWM3crn417wCSNINrRJXePQZZyZYu92fv+JhrR5Og6?=
 =?us-ascii?Q?M3P4voiAIScMB6lCqX4G7Y4JQAJGJi1AhcUlXCZKT8Vo4We1VFAh/6e9Mwgb?=
 =?us-ascii?Q?R+k1cyE8gvZPfL14PFhi2447ouVvAGDJbv8P8/34L4De5nogGVVo15VE+DT8?=
 =?us-ascii?Q?PdM4fFFg/exOgmhajPzksbtnvQqdlikpiu+wPCrfCmiG/ulUgzOyW5cjNRKU?=
 =?us-ascii?Q?FIz+m/aivQAjyuUfB5R2Fk07a2V/IY7KW33qBAR89rIB8qzhsbFvTlFyGqXk?=
 =?us-ascii?Q?++oaUwIXe+bM9UUpkxSMowCoAugJHaODfp+9KrtViTFFSgwwWDy5mPVpwnC1?=
 =?us-ascii?Q?JwswC7KqpVoxPnYND58tVHZxvafNpyEmjOmnRgn6gWEkWcZgPtEoOwF0loBD?=
 =?us-ascii?Q?VNbeoJhPj18GWC1+MJP2pA+u8rY7wOXaQA/Py7ygdJqbDw2R0RNFiZbBPHrp?=
 =?us-ascii?Q?dO/RdTa4jQQBi4M0FE523q43SXZYE6cP04EVyuRZx/yypbhVxhUTsOxmX87R?=
 =?us-ascii?Q?/x7W5EqECaYwdOkPm1LHv8hRK6mbMaoFFX1fQn+41vMMiwJKC+lDutTi9INN?=
 =?us-ascii?Q?VNfXUVEGNAn0nH4QMbykF0TvRLJrKXQcKHR2Sr0Li8i6lkKeHR+PCSzEzvg6?=
 =?us-ascii?Q?4/K6ivo8gp9wVrHWHHW78ieeFy3sjSudinTHggyReQwBJHtubb9l1uNvJ1fA?=
 =?us-ascii?Q?sRvAthKQkZlGK2GOQA2aVscm/g2ZdH9U6IKOlPmDsq8GZdU=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <80DD295AF16D9242B3A66CE4F8990ABC@INDPRD01.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: sct-15-20-4755-11-msonline-outlook-42ed3.templateTenant
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PNZPR01MB4415.INDPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-Network-Message-Id: 44ddf1d0-f382-4aee-ed9c-08d9e25f0de0
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Jan 2022 13:06:52.8345
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MA1PR01MB0922
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Hi Alex

> On 27-Jan-2022, at 11:06 PM, Alex Deucher <alexdeucher@gmail.com> wrote:
>=20
> C style comments please.
Shall be fixed in v2
>  I'll let one of the display guys comment on
> the rest of the patch.  Seems reasonable, we have a similar quirk for
> the Apple MBP 2017 15" Retina panel later in this function.  Could you
> move this next to the other quirk?
I guess moving it next to the other quirk may break the functionality of th=
is quirk, cause the MBP 2018 one involves stuff regarding firmware revision=
 as well. The original patch applies the quirk after the following lines of=
 the code :-

=09
	core_link_read_dpcd(
		link,
		DP_SINK_HW_REVISION_START,
		(uint8_t *)&dp_hw_fw_revision,
		sizeof(dp_hw_fw_revision));

	link->dpcd_caps.sink_hw_revision =3D
		dp_hw_fw_revision.ieee_hw_rev;

	memmove(
		link->dpcd_caps.sink_fw_revision,
		dp_hw_fw_revision.ieee_fw_rev,
		sizeof(dp_hw_fw_revision.ieee_fw_rev));

Which seem to related to the firmware stuff. Moving it along with the 2017 =
quirk doesn't sound right to me, as this shall move the quirk BEFORE these =
lines of code instead. Maybe the author also knowingly added the quirk afte=
r these lines of code?

As a workaround, could we move the 2017 quirk later, instead of moving the =
2018 quirk before? This sounds more logical to me.

Regards
Aditya
