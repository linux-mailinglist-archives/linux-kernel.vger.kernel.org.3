Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D0D6F46283E
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Nov 2021 00:28:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230451AbhK2Xbx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Nov 2021 18:31:53 -0500
Received: from mail-db8eur05on2071.outbound.protection.outlook.com ([40.107.20.71]:39584
        "EHLO EUR05-DB8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229558AbhK2Xbs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Nov 2021 18:31:48 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=axiCyfR7ynh5pvwppmzTNvc4SOJxLxbbLtCsdkj+5pg7IQylDx3qO5bDr5c6oUiuLPBxD/6zvaaWocmNawz7dmuiZpLJc2uf4qF4h+DIxpLUeOXi0vt1xOM/DZ+x/6dUHfq7TjpArOgX9puv7xXzbgEIeKVzloZ1GawMFiZsvpAB6xLQIYSBBE5YykRVrtQchyI6p5QojGKEB44+QmYnIJdLIQSl+704BUfCfqSKt2s/6phekvTP3L/yVdGi1kVGRVhdVhleSJws2JdYzNGigXaHmA7ISk0eZeEJzrOSImvVS8tNiDWLKCUIINQp1rA3Q/r1XN9knCHIgumIRFplyw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=szeaF5C1IEXblw1y8NHpz21eGAwojgP6lzo9wFP7Ec8=;
 b=P5n+d11C3RXzPWqx+e9eiOwcCQ6K8yn6sVy0mlD5DyOsjFbMjx/B2jJ8TrPT6hZ994lDkdyCsX/DMOy1ecbraKDO1o6WrmqYKCsQQ9/oJ1H2WKLnG8G1b1YU7ywDuDyYZIFhmR4sHmkl0EhpwxDDj1Ni86PVjAo9EOHBv1Ka17t15CfobV+fnXOfkQKKQm3PCwM5kH1J3wCXigUnN78qyLvEbYwnqBsDTfONv/eqQ498MELen+loCVl2x0w/j+fFHQkr+d8/fuUQ1LxbcpZqEgPHcdGO3Q1nkzOE+664Y6RXynosv+6WRqti6uX6faL6YHx8ixD1I5pHpP1kr6Bf/Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=szeaF5C1IEXblw1y8NHpz21eGAwojgP6lzo9wFP7Ec8=;
 b=INLrGd3RdaVY4XXpqOjeXe0FKufunSdS80zF4dr8PQCIyjWjRBd95ZfOOf/SGsK/e+TekMPrWdUoH40Cfz3EGIiZdXpA3Q1TMeLPkU6dHDm9m0TvxEdvhlPKnV+hpx22NITxNgjD8X3fO+cOUdNBx8RDKDx4VFh6VfA7jJ7T+Hw=
Received: from AS8PR04MB8946.eurprd04.prod.outlook.com (2603:10a6:20b:42d::18)
 by AS8PR04MB8945.eurprd04.prod.outlook.com (2603:10a6:20b:42c::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4734.21; Mon, 29 Nov
 2021 23:28:28 +0000
Received: from AS8PR04MB8946.eurprd04.prod.outlook.com
 ([fe80::60be:d568:a436:894b]) by AS8PR04MB8946.eurprd04.prod.outlook.com
 ([fe80::60be:d568:a436:894b%6]) with mapi id 15.20.4734.024; Mon, 29 Nov 2021
 23:28:28 +0000
From:   Leo Li <leoyang.li@nxp.com>
To:     Rob Herring <robh@kernel.org>
CC:     Shawn Guo <shawnguo@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
Subject: RE: [PATCH 02/11] dt-bindings: fsl,layerscape-dcfg: add missing
 compatible for lx2160a
Thread-Topic: [PATCH 02/11] dt-bindings: fsl,layerscape-dcfg: add missing
 compatible for lx2160a
Thread-Index: AQHX1oF3mYCqvyMsK022bwSfKQvzYawbGV6AgAAqnQA=
Date:   Mon, 29 Nov 2021 23:28:28 +0000
Message-ID: <AS8PR04MB894647B096661C2030EB84F98F669@AS8PR04MB8946.eurprd04.prod.outlook.com>
References: <20211110222200.6780-1-leoyang.li@nxp.com>
 <20211110222200.6780-3-leoyang.li@nxp.com>
 <YaU91SxgAFXtDMyW@robh.at.kernel.org>
In-Reply-To: <YaU91SxgAFXtDMyW@robh.at.kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 84f37930-6e71-42a4-c96a-08d9b38ff2d4
x-ms-traffictypediagnostic: AS8PR04MB8945:
x-microsoft-antispam-prvs: <AS8PR04MB8945DBCF667CF74762F8CFA18F669@AS8PR04MB8945.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6430;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: tFyF5gdlIVLBfUkBHR0XjRhyxjKTnX+INcEEa4htPmwTNF+IPty9zwx0sUulY1vjLKXtav/yE/fmR+HnZjUUVpxIi0CH6qOkpEGP755netQ17uyezDyujzuQH+s3Pe2Bde7gY1zLS7lx9m3E9m7ddSZz2umjscRRGeR/HJzTEMJbgiEuODbFnQ1ZgsG3uo09WAW5EVSVYwywIRVzK8otZuw+qtJ7JHzoZRypY8PBGnih0PbtC+PKOEhFUD2avmV1IF+eFzubcbttRcz+E8VW0JY6pREZ9C9T64zugFL8PBdYk/uQHyzR+7OqHiTp1LLh/+d+auKBb0paW+0Of0MBUtetW/w7mj7zX89k5Vf0UIVEpIu+fJeJxntnPo7Y1M2Yy0wNN6frp+p8enNsnWTL54TrL9VZTYrBbygeWxgv1GWQDSOUpiFbQsoNwD/62C7PBGIhVrFsDLXPbfKW5lRFo9BKBZV/r3c/HUEuee2wZCfsRDcxhmYK9r+XweqnnH4oWz6DEeo63OiNzD2HX8xb/mABslyn3cfWg44qqYKZwmLNAsEgcO/9q8EJirHtWnm1wtjHKU/KEZjLyirOsJSMeuzYQwdst8VmEsrz5AC/FVcy4VTwdV7eu25O9IH2h33iav0GAqOvKVEnzbPBdvOxMOvk9xBu/WedgaZLHG4SCENrRr3zME8l/8hywn5eTvcbE18fR+iV4fmdztbnlN8Ibw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8946.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(4326008)(2906002)(55016003)(76116006)(186003)(316002)(9686003)(66446008)(6916009)(83380400001)(66476007)(64756008)(66556008)(66946007)(54906003)(4744005)(26005)(122000001)(52536014)(53546011)(86362001)(8936002)(7696005)(5660300002)(508600001)(38070700005)(8676002)(6506007)(33656002)(38100700002)(71200400001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?gXFBA7bqSJ/YStyKp5x5G6Lf2qhRhGVkMbB5vmC7mfOZBIDq9yZFYPlHjc5n?=
 =?us-ascii?Q?pbhnxWDNN6KtMDjaAI2hW0rXxFP1DE89t9idgU3M/SJPhKcpObaQHEg2OtCx?=
 =?us-ascii?Q?SidWW7feLPY4CpDuZFfsghEYxZ+ANNBYd4uhGNxCT2nS/dyLnJ90xNWftwkJ?=
 =?us-ascii?Q?VRWGD6M3dsaEHzVgFfGEbuz9dcnt0gcSF5JU8XJsVPMpMaP7liyZKX1wFmFZ?=
 =?us-ascii?Q?LlB5ASYJq2HTTB5xExiGrsURV5n9CTDTZXElOEryBBXBvsedkxl6QjXXKXc4?=
 =?us-ascii?Q?zW/H7FbAPCDDY0QEvs03jSEoXgZHCkCsY3Ddk6OsaGg21Z5355dWRgR/9dbV?=
 =?us-ascii?Q?3r8Cm8sPzIjdOoHWWxHiDRLP8l93vKzVW/41S5PKZfXRxk6MTxYrHJhuwqSe?=
 =?us-ascii?Q?bsqmI5PoN2Sr9qPzUaB35efWTmH6P7Vy2yYOqHy34kq4jhg/QE+m0rCvFoGc?=
 =?us-ascii?Q?I7g8dw8pRkm+Z745gc8+SHJKSUEGqb96cT4PZdb+BiWmUGP9gRSBDSVDQh2j?=
 =?us-ascii?Q?xsbsV48JJoi+/QauhpS1Tfwh5q7wPxof2EH3+G12anURU80rZ63GfZTynZmy?=
 =?us-ascii?Q?K8ET1+91jmemV9eWXUPgQfLAn0c/Bm6roRfw4Q2yLtdrXDlhGM1fefV/zEp/?=
 =?us-ascii?Q?kMZazi8EN25z+weoxwh8co/W0z1dT7Kefbkra/748SzO+UHfJpKW/02P/zv1?=
 =?us-ascii?Q?s6OC1sqXWi3wGeNpXrD1/H/gC0biZFrHFshtP8r1uDSOBxisoPHJT3fWUBf8?=
 =?us-ascii?Q?f+JqEqjbBJOao1sn0nwm+mWPBB9LSqlsJCnUs8bfSSxozz3xLd2KgNwjR7Fs?=
 =?us-ascii?Q?Os037eYJPz67tYFWts8OKjO28HZGPp5z0/xcxF3whApFCRfgJgQYzGj61otG?=
 =?us-ascii?Q?ep+UGlhRMBZ43+9DDs6qWhLanl7WMhd57hkUMkZULAXgmfd9ChqSO8tLH28o?=
 =?us-ascii?Q?llGsI0KXr3Eu0x5DywtcilGsbH9jBOwGNpeRLXjXrwJQMMwiEoo52r/Xgjgh?=
 =?us-ascii?Q?hIu+JQjgTgVSWFqa+ti6XerHBt7SUs8dPnf/owSCp0507ekpU3vwxEYMcK3D?=
 =?us-ascii?Q?y7DSzzKoSrOLFAWVDfoMbmnWk9d76ZvGsvjAlQqLDm+bFDaHbBCgbvwgIXHh?=
 =?us-ascii?Q?hRvEOu+5YzW3HZlCkfrNs4xjy5PCw8q16MckuK5Wb3suYAPT1RvxsLYO493b?=
 =?us-ascii?Q?ercEARh0a/VXWiUg6eHqSXgMTxr8+6OxCOzXVfrzFShE6GBVVYqdkJgkjiaX?=
 =?us-ascii?Q?A+aPLQ/KQhWxmPdypWFzD5/CsSQNJejebAxVfuXmQ9dCmsAKSBg46d8VHyF+?=
 =?us-ascii?Q?hMafOls6PGgbUgEeyu75QW3YwdAHLYCIFFH36Rtw1Yzs7hsCprar228pu3uJ?=
 =?us-ascii?Q?YUMSKPxBZu4oUy7/7Xkg/pc7goLNfF/ajdz21bSDhETnTd9J8aPxF/dZteff?=
 =?us-ascii?Q?/0QU5SnAGQVC9yqXAPgjEUk9IwCIR23Df7wFXhXUL9pyNCQUrL1gKqt/NDY0?=
 =?us-ascii?Q?5nsgfE5ekURwN00Hk8vY5fMpoXqb0KJuFRv7cvKdMBVPjC9iLjuac2wfxeQO?=
 =?us-ascii?Q?BAj9Ydw/4JmEkWLA2CjS1A4N8M7MVuW2fM48rcG0Z+80RPWIQXVNyNlvANo8?=
 =?us-ascii?Q?Hw=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8946.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 84f37930-6e71-42a4-c96a-08d9b38ff2d4
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Nov 2021 23:28:28.4098
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 3mbzuZLcZ6ITL5a30I94diOUBnuRf8inj7BpdVdlmJgZwqVEwwFvFXYONfH4aLtlMnRpnK7UYcMfuVqc4Bay/A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8945
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> -----Original Message-----
> From: Rob Herring <robh@kernel.org>
> Sent: Monday, November 29, 2021 2:54 PM
> To: Leo Li <leoyang.li@nxp.com>
> Cc: Shawn Guo <shawnguo@kernel.org>; Michael Turquette
> <mturquette@baylibre.com>; Stephen Boyd <sboyd@kernel.org>;
> devicetree@vger.kernel.org; linux-kernel@vger.kernel.org; linux-arm-
> kernel@lists.infradead.org
> Subject: Re: [PATCH 02/11] dt-bindings: fsl,layerscape-dcfg: add missing
> compatible for lx2160a
>=20
> On Wed, Nov 10, 2021 at 04:21:51PM -0600, Li Yang wrote:
> > The compatbile string is already in use, fix the chip list in binding t=
o
>=20
> same typo.
>=20
> > include it.
> >
> > Signed-off-by: Li Yang <leoyang.li@nxp.com>
> > ---
> >  .../devicetree/bindings/arm/freescale/fsl,layerscape-dcfg.txt   | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> Acked-by: Rob Herring <robh@kernel.org>

Thanks.  Both typo fixed and applied to fsl-soc tree.

Regards,
Leo
