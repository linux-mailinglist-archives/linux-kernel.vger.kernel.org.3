Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9E2A44957ED
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jan 2022 02:48:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378093AbiAUBsM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Jan 2022 20:48:12 -0500
Received: from mail-eopbgr20080.outbound.protection.outlook.com ([40.107.2.80]:33691
        "EHLO EUR02-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1348338AbiAUBsI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jan 2022 20:48:08 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jGs9Jkgww4rIGg2gXzYnyTwvWdetleqzvocAsBVY2WgO4QXzt03DmFCJiPtv+SFpF+SddfONCziY07NvqfAyVDiB35X/eM+9PnYzovjE08+Ods1lOaoAUUiChSS+C6kP4PLVxTh6+ifePlMJt6vFAYkddpNBc5qHJw933kwW05B1tTHN3HY2GquWA+7+aKRP82BqwQpVT3aOgdT8G/til9NMv3rXrfQKZzJrxIfDGu2/xtugP/n4J5FQaYpTLPXw9pJrP8URupnYTihFcS+6D8CCBnJx4qrie1hS3ldIlQxDy/03/kHPf4D5n9rtuB1wws40oTDsnvq1k8MjqyuRdg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bSaLxdIIqsgc2xq8oHc5OBGg9/nZspLJCLjQWcBStvU=;
 b=FwIIWBbeXopV7xnA/MwrRXDlPWoOHGX/F0xoZ2wgZbbzUCU+TsjfHm7FvOs1lAKOsTl0dleCYAmw/ZqHoqPEebGdTBXXb+xs8wb7RHmGUS8Y/Auh2J4AjxvN2r+JQ5A31ZiBYkeHkUWbJMzkl1wbykcFw8nW1HhKIuvanf7vKBipcKvJKMvelf6VAQ/S/OOAsGXb+6albDIsYMlLOQKtwBKmbJm7bkRItGMz/2UvPV6rYqxU8sQ2OQv9kctac6ykBz1h+g1kGTbhDwh9brAbSrgPj76MVc8JIL7eBFoRtgYkumfi9FRnZ/GpeV+eHJVjsh2TVj9HXydIQcC4dEC89g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bSaLxdIIqsgc2xq8oHc5OBGg9/nZspLJCLjQWcBStvU=;
 b=RXLLg5mUh+42H79m9WcV71wO2zLOjDyqiJW/0Z2PWN9gTNzxW3C6sQ86H2yjzrkf4rr7F608fllUs+mgGaCrqnvNOYdBcHyIbrpa5KX363V9UQPHgSR46q4iNa6ZHHH4BkiVVX5qQI7acA6x2dE7QtCG1jKfYGfkZ0iKsBvhOqg=
Received: from AM6PR04MB6341.eurprd04.prod.outlook.com (2603:10a6:20b:d8::14)
 by DBAPR04MB7446.eurprd04.prod.outlook.com (2603:10a6:10:1aa::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4909.8; Fri, 21 Jan
 2022 01:48:05 +0000
Received: from AM6PR04MB6341.eurprd04.prod.outlook.com
 ([fe80::b9f1:7371:3484:95b2]) by AM6PR04MB6341.eurprd04.prod.outlook.com
 ([fe80::b9f1:7371:3484:95b2%4]) with mapi id 15.20.4909.010; Fri, 21 Jan 2022
 01:48:05 +0000
From:   Ming Qian <ming.qian@nxp.com>
To:     Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        "mchehab@kernel.org" <mchehab@kernel.org>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>
CC:     "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        dl-linux-imx <linux-imx@nxp.com>,
        Aisheng Dong <aisheng.dong@nxp.com>,
        "linux-media@vger.kernel.org" <linux-media@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
Subject: RE: [EXT] Re: [PATCH v14 00/13] amphion video decoder/encoder driver
Thread-Topic: [EXT] Re: [PATCH v14 00/13] amphion video decoder/encoder driver
Thread-Index: AQHX60MTPTpbZul+JUu6kVDQyXot1qxsQesAgAC4XvA=
Date:   Fri, 21 Jan 2022 01:48:05 +0000
Message-ID: <AM6PR04MB6341CA0D4EF44B279C5FD89EE75B9@AM6PR04MB6341.eurprd04.prod.outlook.com>
References: <cover.1638865027.git.ming.qian@nxp.com>
 <d0540f65-ccc8-cfc8-d5c6-8dc40603b18d@xs4all.nl>
In-Reply-To: <d0540f65-ccc8-cfc8-d5c6-8dc40603b18d@xs4all.nl>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 6abbeeae-f002-4870-d288-08d9dc80113b
x-ms-traffictypediagnostic: DBAPR04MB7446:EE_
x-microsoft-antispam-prvs: <DBAPR04MB74468DF88B4BAEA58AEA5969E75B9@DBAPR04MB7446.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: eluVmaPi2ETZXvX00kDuN+T3voUlUebCld3z5aAzYb4nCimYfjjwFSyRngk1CKRavsYq1jzL758uIHqMmilBXQy/32tgQ+za8dVx7sLJZhdISycpwgl5ZGOL/bZEIelU5qZBAlJvooRwasupNKgLxsrNpw2E3jCreBll8kPPVO+zmVlyAhbRZ+YKJTHJHe8dfWhauVW8DLFy21xNVOrHxLeXhaHhcqAp4jfOy6xuDbXq5HX3IY8Yk5RCEDPEjbigmqOxnkNEpyyjFNYW8p2+zhMaVQuBqfzoH1ixbnbAaIG/Wr52AmNuUF4Ytn/AHW7n4ErMPefUz6H6xd44Q9gJgLOyIuMAk2Z8VsHpp9T86CWcXwbGAy7LaJchSofBXTUK78yh8J2Q3a82PWhhCwDGF7/gl+f+FT/7/Q9yRDCtumkUGX9FOfnJyrVLdQJPALEuGxt45j3gANN1hlr04FQdd6Yxp7c+hfWoO2OGnAYrrn/q7GC+yMd0K+mjzwdvyW9vAwrYYMdZ07jmxaa3hkf9oLktRcUyluXiFty1d7snQns0We1CyLUUXTTdm7K6UfHCTN4LcqDzKTCXaHmq6itwx1xKXloZweQuNuBVlw1RdvH5lGx+q1CprFWg3ccbaIRIbkKK/UBptJRIQgXOza61h53ocNDPQbvV+PXgG7fERbo6pu0vUG8jlVLB1aHAhEn4ytA0BKvIimYfiLgLIL3KKzGMCNJDgRIftX6ebh/83oOC+8oX00dcY8LL3eJlZu572df3kpVUsLJYo0YGk6saVmgqyz/q7r3VqmEPnsrOlQNq6cX5uawoT2aaRHgXpPYjyK7POgpMixPgNF4baanb8Q==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB6341.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(71200400001)(4326008)(508600001)(316002)(8936002)(83380400001)(45080400002)(54906003)(7416002)(66556008)(66476007)(66946007)(76116006)(8676002)(186003)(26005)(110136005)(33656002)(38070700005)(2906002)(6506007)(38100700002)(44832011)(53546011)(7696005)(55016003)(122000001)(86362001)(30864003)(9686003)(66446008)(966005)(64756008)(52536014)(5660300002)(579004);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?gyfAFXUyPTpGIY44flfFdEB1vqCtb3o9YdgCKJKhT+Ti2iBehzBq/VHKmAgk?=
 =?us-ascii?Q?qbZuoWEKs1diof/7IAWj35GHfbv2PS5n/OqQV2iX3N4Mr85Wtj9C6WVglW8u?=
 =?us-ascii?Q?kfAYrGw07iJ0buuf52LYLkeMiQHq4Ii6X6nUsJt0CpkBIT/Zdceichmea4Nv?=
 =?us-ascii?Q?7drCJmNfG4BwdxGQXvOyyrWe6sfg2Sd/TKBk4zmFGUbmu8x0y4Q4HhD0bAHu?=
 =?us-ascii?Q?D3dqN78DJo5C15xzF/1y5EzwJO/K8/qMxljTfCnZY+UyuM4V6wu64TFivj0K?=
 =?us-ascii?Q?5hdLU6/0ahGT02LiLw1H7sza5aCgYb+k+7ySM6VBKqD1o44QpEFisKMsCHv/?=
 =?us-ascii?Q?PORUfFgMQIXdpHRKUTe5hZG138m3a+1iY8Fc6L04RJX+Au3YOALLHX7kbEx8?=
 =?us-ascii?Q?UYR6+SlrvAPT+fko7ND9R10aNbY53cOAMnAjuDBFbS8eUBbGKmwHtGqNZPOr?=
 =?us-ascii?Q?j9AIm49gpPF65Ippad5H+eXrP9AuXcQWIZUXb9J7exbXuEqbl1LgrhGE/0iT?=
 =?us-ascii?Q?YMrIqG1Es1IAXXjy9cPPPdyv1U9OO1RPOEtW5CKZAkKaq4MUY1D8SNa+Zqic?=
 =?us-ascii?Q?NRQbbwTECdkEDuofWpXDLnTSqCRwJYCFqP88gSUxGm803IWP4KKAls6uuES5?=
 =?us-ascii?Q?D4KdVPjWnGP8/NE9UTL3wausJhW5S1+N/OCVTWoNpYSg1Pfyz7d/bY/JP1z9?=
 =?us-ascii?Q?jZ6Ltem7E4voY2MKqTQJSICZcCBocNegTTKhCRXg6ogHyJKczf1YV1c+siZ/?=
 =?us-ascii?Q?ethZ6wRtLdcifICZzHzzZWE3AjVtu/wd0x26PL2oRnjZ+9BBSRpM62Hq7f1B?=
 =?us-ascii?Q?jpQzE3TVEO5PtNrRmIEDlpkmG3CAQtsAsrbkD1TxPj3Sxv8qvbOtbfyLGkRs?=
 =?us-ascii?Q?KMDj2gEtGgO6qryfxf2w+PiB1usuLHSQDZD+Gk35aqSVjvEbQL6Ol+71S4/d?=
 =?us-ascii?Q?7E4dVDhj4uOP+FNKaMEP+ryPWUx7aGajnNgMWcLqi12hxGfpzDtOzHP4Kxdc?=
 =?us-ascii?Q?082H5AeU/x40oZOSk/N1/SMNfYjgKwEXzjt4nfD8TiT22UdSrG6aPwVKqB8o?=
 =?us-ascii?Q?idFx/Mfr3Hj1ociDGeG8AL1EKmYGCmtEw/mGHt3e7fMHJozf0YQmllKUJPnv?=
 =?us-ascii?Q?5p2UfBUnv5CHhzynNj/Swn9w+kpPM9W9ZWCJMdD7zukQ05XNDbKxFYc6R10W?=
 =?us-ascii?Q?MSHudK0ZF8Z+qrV13aS+1SHgIavgM82ppDe7MUV5O87ZhD1thhwDeINtRsiE?=
 =?us-ascii?Q?unQkyp853ghZtqBSrHndQi+rLQjdTyFTN/JOeSL3WspYOatjFJaOSCyyGTF/?=
 =?us-ascii?Q?gUpr9ohLGVphhaWuZgQdsmRbmQdmkwF8IEHPpwrGP/roEzLlKoKje+2b5O/D?=
 =?us-ascii?Q?/oPp+gGEvqaEfBs0UNM7QmCEW0FbuLHB9c3KugoK2FGKUtANigiHXFFSNA6s?=
 =?us-ascii?Q?ktv23EEYtkM8xUkiNgnA5Yus9bpyipgkPwk8E7XmroqEB9SGg8kR5qk187WM?=
 =?us-ascii?Q?k5zNzeJwkz6w9SX47Kw0Kg9nM0rjr4cDUS/3CY9nCcWxqT0SF/bTfncbT+sZ?=
 =?us-ascii?Q?qGYkkGiZpsU6wy5mHe63XmZsXUaNxYSSsgcUMlbezDnnrXNApvIriRYLz5oZ?=
 =?us-ascii?Q?Xg=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB6341.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6abbeeae-f002-4870-d288-08d9dc80113b
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Jan 2022 01:48:05.1287
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ftojqYFT3vfy/od1jb8L0npxLV+4uzMlgOsmRvmpwGaqcvNh+zjsU43HWH1ixYWCeultR4vcX2xAjgikxzvNww==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBAPR04MB7446
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> -----Original Message-----
> From: Hans Verkuil [mailto:hverkuil-cisco@xs4all.nl]
> Sent: Thursday, January 20, 2022 10:44 PM
> To: Ming Qian <ming.qian@nxp.com>; mchehab@kernel.org;
> shawnguo@kernel.org; robh+dt@kernel.org; s.hauer@pengutronix.de
> Cc: kernel@pengutronix.de; festevam@gmail.com; dl-linux-imx
> <linux-imx@nxp.com>; Aisheng Dong <aisheng.dong@nxp.com>;
> linux-media@vger.kernel.org; linux-kernel@vger.kernel.org;
> devicetree@vger.kernel.org; linux-arm-kernel@lists.infradead.org
> Subject: [EXT] Re: [PATCH v14 00/13] amphion video decoder/encoder driver
>=20
> Caution: EXT Email
>=20
> Hi Ming,
>=20
> Running 'scripts/checkpatch.pl --strict' over the patches gives me lots o=
f issues,
> most of them easily fixed.
>=20
> As always with checkpatch, use common sense since not everything can be
> fixed.
>=20
> You probably ran checkpatch.pl without the --strict option, but in the me=
dia
> subsystem we use that option.
>=20
> Note that sparse and smatch are happy, so it is just the checkpatch issue=
s that
> need to be improved.

Yes, I just run checkpatch.pl without the --strict option,
I'll fix the issues in v15.

>=20
> On 12/7/21 09:24, Ming Qian wrote:
> > Hi all,
> >
> > This patch series adds support for
> > the amphion video encoder and decoder
> > via the VPU block present in imx8q platforms.
> > Currently, support for IMX8QXP and IMX8QM is included.
> >
> > It features decoding for the following formats:
> > - H.264
> > - HEVC
> > - MPEG4
> > - MPEG2
> > - VC1
> > - VP8
> >
> > It features encoding for the following formats:
> > - H.264
> >
> > The driver creates a separate device node for the encoder and decoder.
> >
> > This driver is dependent on vpu firmwares.
> > The firmwares have been submitted to linux-firmware.
> > The firmware patch is since commit
> > b563148fd28623f6b6ce68bb06c3dd3bd138b058:
> > linux-firmware: Update firmware file for Intel Bluetooth 9462 (Fri Oct
> > 8 16:30:14 2021 +0530)
> >
> > and it's available in the git repository at:
> >
> > https://eur01.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Fgit=
h
> >
> ub.com%2Fmingqian-0%2Flinux-firmware.git&amp;data=3D04%7C01%7Cming.qi
> an%
> >
> 40nxp.com%7Ce806f02c9c204fab735408d9dc235f55%7C686ea1d3bc2b4c6fa
> 92cd99
> >
> c5c301635%7C0%7C1%7C637782866747675249%7CUnknown%7CTWFpbGZ
> sb3d8eyJWIjo
> >
> iMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C300
> 0&amp
> > ;sdata=3DtGdn4wXog4281rkjx%2FkS5Yu995uf1dKk%2B%2Fw7g%2B4hiCc%3D
> &amp;rese
> > rved=3D0
> >
> > for you to fetch changes up to
> bb3eee4f99589d4910dee4c053a3a685546b5dbb:
> > amphion: add VPU firmwares for NXP i.MX8Q SoCs (Tue Oct 12 15:09:57
> > 2021 +0800)
> >
> > encoder is tested with gstreamer
> > decoder is tested with gstreamer, but the following patches are require=
d:
> > https://eur01.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Fgit=
l
> >
> ab.freedesktop.org%2Fgstreamer%2Fgstreamer%2F-%2Fmerge_requests%2F1
> 379
> >
> &amp;data=3D04%7C01%7Cming.qian%40nxp.com%7Ce806f02c9c204fab73540
> 8d9dc23
> >
> 5f55%7C686ea1d3bc2b4c6fa92cd99c5c301635%7C0%7C1%7C63778286674
> 7675249%7
> >
> CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBT
> iI6Ik1
> >
> haWwiLCJXVCI6Mn0%3D%7C3000&amp;sdata=3DZ%2B28N2DXrRHm1PFwWrpk
> 0koOSTVdqrm
> > qqY6fKbJuh34%3D&amp;reserved=3D0
> > https://eur01.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Fgit=
l
> >
> ab.freedesktop.org%2Fgstreamer%2Fgstreamer%2F-%2Fmerge_requests%2F1
> 381
> >
> &amp;data=3D04%7C01%7Cming.qian%40nxp.com%7Ce806f02c9c204fab73540
> 8d9dc23
> >
> 5f55%7C686ea1d3bc2b4c6fa92cd99c5c301635%7C0%7C1%7C63778286674
> 7675249%7
> >
> CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBT
> iI6Ik1
> >
> haWwiLCJXVCI6Mn0%3D%7C3000&amp;sdata=3Djitq4XO15%2BMux3jyVYGs0fp
> Lwxr7hbv
> > WAZad9TEGyso%3D&amp;reserved=3D0
> >
> >
> > Tested-by: Nicolas Dufresne <nicolas.dufresne@collabora.com>
>=20
> For v15 please add this tag from Nicolas to the patch(es) that it applies=
 to.
> Tags in the cover letter are ignored.cd=20
>=20
> Regarding patch 12/13 (firmware patch): who will take that? I think it sh=
ould
> go through Shawn Guo, or if he can Ack it, then I can take it with the re=
st of
> the series as well.
>=20
> Regards,
>=20
>         Hans
>=20
> >
> >
> > Changelog:
> >
> > v14
> > - fix some errors according to Hans's comments
> >
> > v13
> > - make a workaround that avoid firmware entering wfi wrongly
> >
> > v12
> > - support reset decoder when starting a new stream
> > - don't append an empty last buffer, set last_buffer_dequeued
> > - improve the resolution change flow
> > - return all buffers if start_streaming fail
> > - fill encoder capture buffer's filed to none
> > - fix a bug in calculating bytesperline
> >
> > v11
> > - fix dt_binding_check error after upgrade dtschema
> > - remove "default y"
> > - add media device
> >
> > v10
> > - refine vpu log, remove custom logging infrastructure
> > - support non contiguous planes format nv12m instead of nv12
> > - rename V4L2_PIX_FMT_NV12_8L128 to V4L2_PIX_FMT_NV12MT_8L128
> > - rename V4L2_PIX_FMT_NV12_10BE_8L128 to
> > V4L2_PIX_FMT_NV12MT_10BE_8L128
> > - merge two module into one
> > - fix kernel panic in rmmod
> >
> > v9
> > - drop V4L2_BUF_FLAG_CODECCONFIG
> > - drop V4L2_EVENT_CODEC_ERROR
> > - drop V4L2_EVENT_SKIP - use the v4l2_buffer.sequence counter
> > - fix some build warnings with W=3D1 reported by kernel test robot
> >
> > v8
> > - move driver from driver/media/platform/imx/vpu-8q to
> >   driver/media/platform/amphion
> > - rename driver name to amphion
> > - remove imx_vpu.h
> > - move the definition of V4L2_EVENT_CODEC_ERROR to videodev2.h
> > - move the definition of V4L2_EVENT_SKIP to videodev2.h
> >
> > v7
> > - fix build warnings with W=3D1 reported by kernel test robot
> >
> > v6:
> > - rename V4L2_PIX_FMT_NT8 to V4L2_PIX_FMT_NV12_8L128
> > - rename V4L2_PIX_FMT_NT10 to V4L2_PIX_FMT_NV12_10BE_8L128
> >
> > v5:
> > - move some definition from imx_vph.h to videodev2.h
> > - remove some unnecessary content
> > - add some documentation descriptions
> > - pass the lateset v4l2-compliance test
> >
> > v4:
> > - redefine the memory-region in devicetree bindings documentation
> > - use v4l2's mechanism to implement synchronize queuing ioctl
> > - remove the unnecessary mutex ioctl_sync
> > - don't notify source change event if the parameters are same as
> > previously established
> > - add flag V4L2_FMT_FLAG_DYN_RESOLUTION to decoder's capture format
> >
> > v3:
> > - don't make vpu device node a simple-bus
> > - trigger probing vpu core in the driver
> > - remove unnecessary vpu core index property
> >
> > v2:
> > - fix dt bindings build error
> > - split driver patch into several parts to avoid exceeding bytes limit
> >
> > Compliance
> > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > # v4l2-compliance -d /dev/video0
> > v4l2-compliance 1.21.0-4859, 64 bits, 64-bit time_t v4l2-compliance
> > SHA: 493af03f3c57 2021-10-08 17:23:11
> >
> > Compliance test for amphion-vpu device /dev/video0:
> >
> > Driver Info:
> >       Driver name      : amphion-vpu
> >       Card type        : amphion vpu decoder
> >       Bus info         : platform: amphion-vpu
> >       Driver version   : 5.15.0
> >       Capabilities     : 0x84204000
> >               Video Memory-to-Memory Multiplanar
> >               Streaming
> >               Extended Pix Format
> >               Device Capabilities
> >       Device Caps      : 0x04204000
> >               Video Memory-to-Memory Multiplanar
> >               Streaming
> >               Extended Pix Format
> >       Detected Stateful Decoder
> > Media Driver Info:
> >       Driver name      : amphion-vpu
> >       Model            : amphion-vpu
> >       Serial           :
> >       Bus info         : platform: amphion-vpu
> >       Media version    : 5.15.0
> >       Hardware revision: 0x00000000 (0)
> >       Driver version   : 5.15.0
> > Interface Info:
> >       ID               : 0x0300000c
> >       Type             : V4L Video
> > Entity Info:
> >       ID               : 0x00000001 (1)
> >       Name             : amphion-vpu-decoder-source
> >       Function         : V4L2 I/O
> >       Pad 0x01000002   : 0: Source
> >         Link 0x02000008: to remote pad 0x1000004 of entity
> > 'amphion-vpu-decoder-proc' (Video Decoder): Data, Enabled, Immutable
> >
> > Required ioctls:
> >       test MC information (see 'Media Driver Info' above): OK
> >       test VIDIOC_QUERYCAP: OK
> >       test invalid ioctls: OK
> >
> > Allow for multiple opens:
> >       test second /dev/video0 open: OK
> >       test VIDIOC_QUERYCAP: OK
> >       test VIDIOC_G/S_PRIORITY: OK
> >       test for unlimited opens: OK
> >
> > Debug ioctls:
> >       test VIDIOC_DBG_G/S_REGISTER: OK (Not Supported)
> >       test VIDIOC_LOG_STATUS: OK (Not Supported)
> >
> > Input ioctls:
> >       test VIDIOC_G/S_TUNER/ENUM_FREQ_BANDS: OK (Not Supported)
> >       test VIDIOC_G/S_FREQUENCY: OK (Not Supported)
> >       test VIDIOC_S_HW_FREQ_SEEK: OK (Not Supported)
> >       test VIDIOC_ENUMAUDIO: OK (Not Supported)
> >       test VIDIOC_G/S/ENUMINPUT: OK (Not Supported)
> >       test VIDIOC_G/S_AUDIO: OK (Not Supported)
> >       Inputs: 0 Audio Inputs: 0 Tuners: 0
> >
> > Output ioctls:
> >       test VIDIOC_G/S_MODULATOR: OK (Not Supported)
> >       test VIDIOC_G/S_FREQUENCY: OK (Not Supported)
> >       test VIDIOC_ENUMAUDOUT: OK (Not Supported)
> >       test VIDIOC_G/S/ENUMOUTPUT: OK (Not Supported)
> >       test VIDIOC_G/S_AUDOUT: OK (Not Supported)
> >       Outputs: 0 Audio Outputs: 0 Modulators: 0
> >
> > Input/Output configuration ioctls:
> >       test VIDIOC_ENUM/G/S/QUERY_STD: OK (Not Supported)
> >       test VIDIOC_ENUM/G/S/QUERY_DV_TIMINGS: OK (Not Supported)
> >       test VIDIOC_DV_TIMINGS_CAP: OK (Not Supported)
> >       test VIDIOC_G/S_EDID: OK (Not Supported)
> >
> > Control ioctls:
> >       test VIDIOC_QUERY_EXT_CTRL/QUERYMENU: OK
> >       test VIDIOC_QUERYCTRL: OK
> >       test VIDIOC_G/S_CTRL: OK
> >       test VIDIOC_G/S/TRY_EXT_CTRLS: OK
> >       test VIDIOC_(UN)SUBSCRIBE_EVENT/DQEVENT: OK
> >       test VIDIOC_G/S_JPEGCOMP: OK (Not Supported)
> >       Standard Controls: 3 Private Controls: 0
> >
> > Format ioctls:
> >       test VIDIOC_ENUM_FMT/FRAMESIZES/FRAMEINTERVALS: OK
> >       test VIDIOC_G/S_PARM: OK (Not Supported)
> >       test VIDIOC_G_FBUF: OK (Not Supported)
> >       test VIDIOC_G_FMT: OK
> >       test VIDIOC_TRY_FMT: OK
> >       test VIDIOC_S_FMT: OK
> >       test VIDIOC_G_SLICED_VBI_CAP: OK (Not Supported)
> >       test Cropping: OK (Not Supported)
> >       test Composing: OK
> >       test Scaling: OK (Not Supported)
> >
> > Codec ioctls:
> >       test VIDIOC_(TRY_)ENCODER_CMD: OK (Not Supported)
> >       test VIDIOC_G_ENC_INDEX: OK (Not Supported)
> >       test VIDIOC_(TRY_)DECODER_CMD: OK
> >
> > Buffer ioctls:
> >       test VIDIOC_REQBUFS/CREATE_BUFS/QUERYBUF: OK
> >       test VIDIOC_EXPBUF: OK
> >       test Requests: OK (Not Supported)
> >
> > Total for amphion-vpu device /dev/video0: 46, Succeeded: 46, Failed:
> > 0, Warnings: 0
> >
> > # v4l2-compliance -d /dev/video1
> > v4l2-compliance 1.21.0-4859, 64 bits, 64-bit time_t v4l2-compliance
> > SHA: 493af03f3c57 2021-10-08 17:23:11
> >
> > Compliance test for amphion-vpu device /dev/video1:
> >
> > Driver Info:
> >       Driver name      : amphion-vpu
> >       Card type        : amphion vpu encoder
> >       Bus info         : platform: amphion-vpu
> >       Driver version   : 5.15.0
> >       Capabilities     : 0x84204000
> >               Video Memory-to-Memory Multiplanar
> >               Streaming
> >               Extended Pix Format
> >               Device Capabilities
> >       Device Caps      : 0x04204000
> >               Video Memory-to-Memory Multiplanar
> >               Streaming
> >               Extended Pix Format
> >       Detected Stateful Encoder
> > Media Driver Info:
> >       Driver name      : amphion-vpu
> >       Model            : amphion-vpu
> >       Serial           :
> >       Bus info         : platform: amphion-vpu
> >       Media version    : 5.15.0
> >       Hardware revision: 0x00000000 (0)
> >       Driver version   : 5.15.0
> > Interface Info:
> >       ID               : 0x0300001a
> >       Type             : V4L Video
> > Entity Info:
> >       ID               : 0x0000000f (15)
> >       Name             : amphion-vpu-encoder-source
> >       Function         : V4L2 I/O
> >       Pad 0x01000010   : 0: Source
> >         Link 0x02000016: to remote pad 0x1000012 of entity
> > 'amphion-vpu-encoder-proc' (Video Encoder): Data, Enabled, Immutable
> >
> > Required ioctls:
> >       test MC information (see 'Media Driver Info' above): OK
> >       test VIDIOC_QUERYCAP: OK
> >       test invalid ioctls: OK
> >
> > Allow for multiple opens:
> >       test second /dev/video1 open: OK
> >       test VIDIOC_QUERYCAP: OK
> >       test VIDIOC_G/S_PRIORITY: OK
> >       test for unlimited opens: OK
> >
> > Debug ioctls:
> >       test VIDIOC_DBG_G/S_REGISTER: OK (Not Supported)
> >       test VIDIOC_LOG_STATUS: OK (Not Supported)
> >
> > Input ioctls:
> >       test VIDIOC_G/S_TUNER/ENUM_FREQ_BANDS: OK (Not Supported)
> >       test VIDIOC_G/S_FREQUENCY: OK (Not Supported)
> >       test VIDIOC_S_HW_FREQ_SEEK: OK (Not Supported)
> >       test VIDIOC_ENUMAUDIO: OK (Not Supported)
> >       test VIDIOC_G/S/ENUMINPUT: OK (Not Supported)
> >       test VIDIOC_G/S_AUDIO: OK (Not Supported)
> >       Inputs: 0 Audio Inputs: 0 Tuners: 0
> >
> > Output ioctls:
> >       test VIDIOC_G/S_MODULATOR: OK (Not Supported)
> >       test VIDIOC_G/S_FREQUENCY: OK (Not Supported)
> >       test VIDIOC_ENUMAUDOUT: OK (Not Supported)
> >       test VIDIOC_G/S/ENUMOUTPUT: OK (Not Supported)
> >       test VIDIOC_G/S_AUDOUT: OK (Not Supported)
> >       Outputs: 0 Audio Outputs: 0 Modulators: 0
> >
> > Input/Output configuration ioctls:
> >       test VIDIOC_ENUM/G/S/QUERY_STD: OK (Not Supported)
> >       test VIDIOC_ENUM/G/S/QUERY_DV_TIMINGS: OK (Not Supported)
> >       test VIDIOC_DV_TIMINGS_CAP: OK (Not Supported)
> >       test VIDIOC_G/S_EDID: OK (Not Supported)
> >
> > Control ioctls:
> >       test VIDIOC_QUERY_EXT_CTRL/QUERYMENU: OK
> >       test VIDIOC_QUERYCTRL: OK
> >       test VIDIOC_G/S_CTRL: OK
> >       test VIDIOC_G/S/TRY_EXT_CTRLS: OK
> >       test VIDIOC_(UN)SUBSCRIBE_EVENT/DQEVENT: OK
> >       test VIDIOC_G/S_JPEGCOMP: OK (Not Supported)
> >       Standard Controls: 20 Private Controls: 0
> >
> > Format ioctls:
> >       test VIDIOC_ENUM_FMT/FRAMESIZES/FRAMEINTERVALS: OK
> >       test VIDIOC_G/S_PARM: OK
> >       test VIDIOC_G_FBUF: OK (Not Supported)
> >       test VIDIOC_G_FMT: OK
> >       test VIDIOC_TRY_FMT: OK
> >       test VIDIOC_S_FMT: OK
> >       test VIDIOC_G_SLICED_VBI_CAP: OK (Not Supported)
> >       test Cropping: OK
> >       test Composing: OK (Not Supported)
> >       test Scaling: OK (Not Supported)
> >
> > Codec ioctls:
> >       test VIDIOC_(TRY_)ENCODER_CMD: OK
> >       test VIDIOC_G_ENC_INDEX: OK (Not Supported)
> >       test VIDIOC_(TRY_)DECODER_CMD: OK (Not Supported)
> >
> > Buffer ioctls:
> >       test VIDIOC_REQBUFS/CREATE_BUFS/QUERYBUF: OK
> >       test VIDIOC_EXPBUF: OK
> >       test Requests: OK (Not Supported)
> >
> > Total for amphion-vpu device /dev/video1: 46, Succeeded: 46, Failed:
> > 0, Warnings: 0
> >
> > # v4l2-compliance -d /dev/media0
> > v4l2-compliance 1.21.0-4859, 64 bits, 64-bit time_t v4l2-compliance
> > SHA: 493af03f3c57 2021-10-08 17:23:11
> >
> > Compliance test for amphion-vpu device /dev/media0:
> >
> > Media Driver Info:
> >       Driver name      : amphion-vpu
> >       Model            : amphion-vpu
> >       Serial           :
> >       Bus info         : platform: amphion-vpu
> >       Media version    : 5.15.0
> >       Hardware revision: 0x00000000 (0)
> >       Driver version   : 5.15.0
> >
> > Required ioctls:
> >       test MEDIA_IOC_DEVICE_INFO: OK
> >       test invalid ioctls: OK
> >
> > Allow for multiple opens:
> >       test second /dev/media0 open: OK
> >       test MEDIA_IOC_DEVICE_INFO: OK
> >       test for unlimited opens: OK
> >
> > Media Controller ioctls:
> >       test MEDIA_IOC_G_TOPOLOGY: OK
> >       Entities: 6 Interfaces: 2 Pads: 8 Links: 8
> >       test MEDIA_IOC_ENUM_ENTITIES/LINKS: OK
> >       test MEDIA_IOC_SETUP_LINK: OK
> >
> > Total for amphion-vpu device /dev/media0: 8, Succeeded: 8, Failed: 0,
> > Warnings: 0
> >
> > Ming Qian (13):
> >   dt-bindings: media: amphion: add amphion video codec bindings
> >   media: add nv12m_8l128 and nv12m_10be_8l128 video format.
> >   media: amphion: add amphion vpu device driver
> >   media: amphion: add vpu core driver
> >   media: amphion: implement vpu core communication based on mailbox
> >   media: amphion: add vpu v4l2 m2m support
> >   media: amphion: add v4l2 m2m vpu encoder stateful driver
> >   media: amphion: add v4l2 m2m vpu decoder stateful driver
> >   media: amphion: implement windsor encoder rpc interface
> >   media: amphion: implement malone decoder rpc interface
> >   ARM64: dts: freescale: imx8q: add imx vpu codec entries
> >   firmware: imx: scu-pd: imx8q: add vpu mu resources
> >   MAINTAINERS: add AMPHION VPU CODEC V4L2 driver entry
> >
> >  .../bindings/media/amphion,vpu.yaml           |  180 ++
> >  .../media/v4l/pixfmt-yuv-planar.rst           |   28 +-
> >  MAINTAINERS                                   |    9 +
> >  .../arm64/boot/dts/freescale/imx8-ss-vpu.dtsi |   72 +
> >  arch/arm64/boot/dts/freescale/imx8qxp-mek.dts |   17 +
> >  arch/arm64/boot/dts/freescale/imx8qxp.dtsi    |   24 +
> >  arch/arm64/configs/defconfig                  |    1 +
> >  drivers/firmware/imx/scu-pd.c                 |    4 +
> >  drivers/media/platform/Kconfig                |   19 +
> >  drivers/media/platform/Makefile               |    2 +
> >  drivers/media/platform/amphion/Makefile       |   20 +
> >  drivers/media/platform/amphion/vdec.c         | 1692
> +++++++++++++++++
> >  drivers/media/platform/amphion/venc.c         | 1354 +++++++++++++
> >  drivers/media/platform/amphion/vpu.h          |  356 ++++
> >  drivers/media/platform/amphion/vpu_cmds.c     |  437 +++++
> >  drivers/media/platform/amphion/vpu_cmds.h     |   25 +
> >  drivers/media/platform/amphion/vpu_codec.h    |   67 +
> >  drivers/media/platform/amphion/vpu_color.c    |  186 ++
> >  drivers/media/platform/amphion/vpu_core.c     |  872 +++++++++
> >  drivers/media/platform/amphion/vpu_core.h     |   15 +
> >  drivers/media/platform/amphion/vpu_dbg.c      |  497 +++++
> >  drivers/media/platform/amphion/vpu_defs.h     |  186 ++
> >  drivers/media/platform/amphion/vpu_drv.c      |  260 +++
> >  drivers/media/platform/amphion/vpu_helpers.c  |  416 ++++
> >  drivers/media/platform/amphion/vpu_helpers.h  |   70 +
> >  drivers/media/platform/amphion/vpu_imx8q.c    |  271 +++
> >  drivers/media/platform/amphion/vpu_imx8q.h    |  116 ++
> >  drivers/media/platform/amphion/vpu_malone.c   | 1630
> ++++++++++++++++
> >  drivers/media/platform/amphion/vpu_malone.h   |   42 +
> >  drivers/media/platform/amphion/vpu_mbox.c     |  118 ++
> >  drivers/media/platform/amphion/vpu_mbox.h     |   16 +
> >  drivers/media/platform/amphion/vpu_msgs.c     |  388 ++++
> >  drivers/media/platform/amphion/vpu_msgs.h     |   14 +
> >  drivers/media/platform/amphion/vpu_rpc.c      |  265 +++
> >  drivers/media/platform/amphion/vpu_rpc.h      |  453 +++++
> >  drivers/media/platform/amphion/vpu_v4l2.c     |  733 +++++++
> >  drivers/media/platform/amphion/vpu_v4l2.h     |   56 +
> >  drivers/media/platform/amphion/vpu_windsor.c  | 1207 ++++++++++++
> >  drivers/media/platform/amphion/vpu_windsor.h  |   39 +
> >  drivers/media/v4l2-core/v4l2-ioctl.c          |    2 +
> >  include/uapi/linux/videodev2.h                |    2 +
> >  41 files changed, 12158 insertions(+), 3 deletions(-)  create mode
> > 100644 Documentation/devicetree/bindings/media/amphion,vpu.yaml
> >  create mode 100644 arch/arm64/boot/dts/freescale/imx8-ss-vpu.dtsi
> >  create mode 100644 drivers/media/platform/amphion/Makefile
> >  create mode 100644 drivers/media/platform/amphion/vdec.c
> >  create mode 100644 drivers/media/platform/amphion/venc.c
> >  create mode 100644 drivers/media/platform/amphion/vpu.h
> >  create mode 100644 drivers/media/platform/amphion/vpu_cmds.c
> >  create mode 100644 drivers/media/platform/amphion/vpu_cmds.h
> >  create mode 100644 drivers/media/platform/amphion/vpu_codec.h
> >  create mode 100644 drivers/media/platform/amphion/vpu_color.c
> >  create mode 100644 drivers/media/platform/amphion/vpu_core.c
> >  create mode 100644 drivers/media/platform/amphion/vpu_core.h
> >  create mode 100644 drivers/media/platform/amphion/vpu_dbg.c
> >  create mode 100644 drivers/media/platform/amphion/vpu_defs.h
> >  create mode 100644 drivers/media/platform/amphion/vpu_drv.c
> >  create mode 100644 drivers/media/platform/amphion/vpu_helpers.c
> >  create mode 100644 drivers/media/platform/amphion/vpu_helpers.h
> >  create mode 100644 drivers/media/platform/amphion/vpu_imx8q.c
> >  create mode 100644 drivers/media/platform/amphion/vpu_imx8q.h
> >  create mode 100644 drivers/media/platform/amphion/vpu_malone.c
> >  create mode 100644 drivers/media/platform/amphion/vpu_malone.h
> >  create mode 100644 drivers/media/platform/amphion/vpu_mbox.c
> >  create mode 100644 drivers/media/platform/amphion/vpu_mbox.h
> >  create mode 100644 drivers/media/platform/amphion/vpu_msgs.c
> >  create mode 100644 drivers/media/platform/amphion/vpu_msgs.h
> >  create mode 100644 drivers/media/platform/amphion/vpu_rpc.c
> >  create mode 100644 drivers/media/platform/amphion/vpu_rpc.h
> >  create mode 100644 drivers/media/platform/amphion/vpu_v4l2.c
> >  create mode 100644 drivers/media/platform/amphion/vpu_v4l2.h
> >  create mode 100644 drivers/media/platform/amphion/vpu_windsor.c
> >  create mode 100644 drivers/media/platform/amphion/vpu_windsor.h
> >
> >
> > base-commit: 1f1517fafda598839a02e39968c5063ddcfa51fc
