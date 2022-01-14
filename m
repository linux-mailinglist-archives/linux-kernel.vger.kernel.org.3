Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F34D348ED24
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jan 2022 16:30:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242757AbiANPaC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Jan 2022 10:30:02 -0500
Received: from mail-db8eur05on2062.outbound.protection.outlook.com ([40.107.20.62]:36928
        "EHLO EUR05-DB8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S230420AbiANPaA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jan 2022 10:30:00 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iUFYdpzJ8kChaKRV5k8ZeFCTVjDaOj1zyF8dUOcObE9cbxPihNIJkR0dkce8b5sBgOkT4D/Q3YIt/ZZXbjLVFRzDWKomBcK50jxUybwzWPz9Eoj0ZSlU1xaPe+mriZg5tJddgTkCHZArUt/LPZQ46mu8dH/ugD3uJLO3obiwd0QmwD8oBWWqqNtXsz3E3snb+P0nQ16ZHYJ6zXXfjEvID86ywxFkemYE+hvWGuP0hgPwJkr9YdlDNF+n1TwHlrsJ6naD80CsIoe6o0SClZ721sCaJ/0aJsqM7QnK4M0ImIoSJPcJDen8/W5B0t13oZvrRsSz9+FLzzx56k+R+YIyVA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IxpRH1cSKTOc25DkcXp4pOlY+pEJv31IT4FqEbjiVYE=;
 b=V6S3y/YetSLaWUBsvsx48BuGfEsTCipM9f/8I3mnR/t5f7r6S5wuHJtK7VXxXI9rEqg7MmPBSUi6uLBEc7PA10EmgtwDbLNxe8K6N/mYqZHJnUIrXWd+WwnLGFHP72hHGNLfmto8xMf7IURP6Gm0yRcskBzDWyh9e22i7BmIcA5N67YD/CBD5RVhGQiTr4eddLxEtpbFG5jVdd1Lp9CyTIME48/1csMtmeTrigu0dhBRa7pA0RJbUHfurrOWVscIJsjCrJmbaSD/xWa18YGAJtUJ3Pe3/kiam3RanmatXhj4eS+EcNRBpgnUvTXynW9CpcbB2eWrhYWEBjy0rgFCYg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IxpRH1cSKTOc25DkcXp4pOlY+pEJv31IT4FqEbjiVYE=;
 b=Q0xvEVDTEOLwdi2NAls8OyS5Ya7IzanzVs9lFtW3JVaxW+vqbITLs7KtgJgk2fKaHEPP4Y01DmLl6ZG+lskwdB2f+KHrLI8gyQOrp0uG/wExOQPFWPPpyKv50aglkfEduXgA0UfFL1bvyu9MskVHMLJYVdZmoDTHQmKIWZOE16k=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from VI1PR04MB4688.eurprd04.prod.outlook.com (2603:10a6:803:6a::30)
 by VI1PR0402MB3840.eurprd04.prod.outlook.com (2603:10a6:803:22::31) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4888.9; Fri, 14 Jan
 2022 15:29:54 +0000
Received: from VI1PR04MB4688.eurprd04.prod.outlook.com
 ([fe80::f853:4e9a:7ab6:dbf7]) by VI1PR04MB4688.eurprd04.prod.outlook.com
 ([fe80::f853:4e9a:7ab6:dbf7%5]) with mapi id 15.20.4867.011; Fri, 14 Jan 2022
 15:29:54 +0000
Date:   Fri, 14 Jan 2022 17:29:52 +0200
From:   Abel Vesa <abel.vesa@nxp.com>
To:     Rob Herring <robh@kernel.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Mark Rutland <mark.rutland@arm.com>,
        "open list:SERIAL DRIVERS" <linux-serial@vger.kernel.org>,
        devicetree@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [RESEND] dt-bindings: serial: fsl-lpuart: Add i.MX8DXL compatible
Message-ID: <YeGW8IgkxFN/r7WR@abelvesa>
References: <1640085372-1972-1-git-send-email-abel.vesa@nxp.com>
 <CAL_Jsq+XNNVbUiJeqPvDrz_oZoV1PTxRcE9O5ovEAHQZ37cn9g@mail.gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAL_Jsq+XNNVbUiJeqPvDrz_oZoV1PTxRcE9O5ovEAHQZ37cn9g@mail.gmail.com>
X-ClientProxiedBy: VI1PR08CA0156.eurprd08.prod.outlook.com
 (2603:10a6:800:d5::34) To VI1PR04MB4688.eurprd04.prod.outlook.com
 (2603:10a6:803:6a::30)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 8803e6d8-5384-42f0-87bd-08d9d772b6c5
X-MS-TrafficTypeDiagnostic: VI1PR0402MB3840:EE_
X-Microsoft-Antispam-PRVS: <VI1PR0402MB384032F7718071D0DC88D014F6549@VI1PR0402MB3840.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:534;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: YOXhg9JGeMF+LI8GJj64riYuk/BXOz+G+PQi10ytS5uUa5TvJSTov6+9+GhRobd7leeFOWUW4qEtx4fiuj/CytBqn0U4xzN1PSNKQcB+smLzVIIbAhM0FhwhA8nAoVphS60qMTR8aGtFhqGV2dAXJqPKt1ZcKchc7riWGe1Tzk1bq5uczYgNxE3Xc3vZPjqlw1Dg8Mitg01Dleqjrt9VZiPvDbKOULqsw0yJ/pESNZMQ6iQmMdLsqJhbUfj4iQ753ZsrQUngzGRmeGDxb+9bUrYM3BrbbaRgLu0xn/BGhDBdmL7Gcsu4fOfzgzZLQvebpoOl8UzDLUO9NQoNKGoGekvgbWydvVV1AvIajaBwCV46GuWUhivcEtJE3JRrNbUlpd5bTTkbhXb3MygydhlhlzDhYTHkMSsmkunIztgiE4pz0hVdoIDqtYMgEraj4XkJCx75RsZ/szmw7dMRX8xHLEOdakRxiyYzfK1foF9WGPYcUsFFPSHgHfN6BjE6+wWJT6zrfxyNjGUpV+ezdICz9D+cp47BbJt+7ifz1c6k22opgTyMeecUWimvFwQNKb69jmMYAcDtRNcJLzsN0+rs7ssDtCxhjJwJiP4VKJdXiS7KJbWBCsg1i/s/Fv/CYtrpyvBjxZfjeKGJ7VZB2cGxtE27tD6w16jinQse5clfQC85C/f9g5CiMXyElSyWOxyHTMkW9ZSF24Suv/KJxkurRUoDpdoi1G3IU63xGg4TMqI7PUJAHfOrfQFopui7MHTNhWFCDgiBdtUm3p6swcbnogDuewFurs9baNSDJQQo8iA=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR04MB4688.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(7916004)(366004)(2906002)(6486002)(6916009)(508600001)(8936002)(38350700002)(38100700002)(33716001)(6506007)(66946007)(66556008)(66476007)(86362001)(966005)(8676002)(44832011)(5660300002)(52116002)(4326008)(186003)(316002)(54906003)(26005)(6512007)(53546011)(9686003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?rxZUj00yWmWMyZt9rTqTqKkclMpg3guLwacO11OFL5uX7bU3c8fZMTXHBiY7?=
 =?us-ascii?Q?FCRuRirs7g+fCH6OJ8MQtiJwSPzevKS2rA6R6IXTAeT9PDluBW7rEK1bNE6T?=
 =?us-ascii?Q?VF9XKkQl5UYKnzdZjI+YKMOJPP71tkjOqTCyqDbwLlD0Tz90d3SbvROSM3gE?=
 =?us-ascii?Q?cBMv5hJAdhzWZRkuh2Cup7AzeTNUmSFcY0s8cNyT0JIZ8/HnuPo44dt9MKZX?=
 =?us-ascii?Q?qgacyCx9dQ8RAXpwQ7A7dVG5on6VHKI3GHTU2RPj1HMUv+EX7p1f/Zsvi1ac?=
 =?us-ascii?Q?XLEhLhTJjdeLO7uB+PTTmvF0iNB8BTp85s1KObSSY/dBQmP8Zv9xdZApSemY?=
 =?us-ascii?Q?HOXX0gqPYEwI0bstWvdNMc5O4ePBraqtetT7fHNWs8yYsg+E5UbrTLpElZV9?=
 =?us-ascii?Q?/4pYFGQP7s+wsWWOuk0vq9ijom3BwA5AqtExq9En63H/nZ2ULuSQ3sIMvh+H?=
 =?us-ascii?Q?TeGXDwiPPnC/uz59Np9HeTuzAIsiLc/S6BvuaZsoHzPCxFfes2NcnuWT4pRZ?=
 =?us-ascii?Q?/biBwljsS0qLXY/SXNyx8GNXRodzL33cNlmEasHliWJBp7b5gBrgw/kbGhVk?=
 =?us-ascii?Q?HZTqb4n5+0+y0IEEtQQZfGxOjrnh6hyDSsLpDtUUbveu2lU3pFQ44pZSbsRQ?=
 =?us-ascii?Q?3yYeNtoh3s0EhSma/FWJoV6HLciDxrzxaY4DRZKov9YT3riCwqt3uM7peyr9?=
 =?us-ascii?Q?wsVrRPI0JRWfSZiGobQnUM5Pzp/d3U9SyWWnEUPCBihUYNvSeY8Gqf41sUhZ?=
 =?us-ascii?Q?Xy/KFzwpMHQLMu+D6dQaKEwthzTxJJLN7Hzj31yAO3zk1AufuG40mtqyd54w?=
 =?us-ascii?Q?OUrS8vF2/J30lXIGCmoCnZ5SSkMM+w+KFwjpUCi3CdHVIrYdKy5kFe94KXTQ?=
 =?us-ascii?Q?PGClAhyPOdazMVR3lDIObW/hfIoiQODmjXpqxL6DJKcbC7s7UeLECc+jJ805?=
 =?us-ascii?Q?Csk4oLoYIaQdPrv3mfCJzKHtxlfFkBtNz54h8PmEGrqsfM+XAY0Pawdorqy1?=
 =?us-ascii?Q?/qI9XhjS3xQ7cOSHXlxhIqOnJo5x0ZT0hPslbYcn5Y2fN/CktaTN0LVfdlpL?=
 =?us-ascii?Q?SPoUBSANhpZaRwVVktBI5Y1q98jcW9c7ELbN26qMF9OiLR3Heaz7ZPrlJYx+?=
 =?us-ascii?Q?/VWW3qc/59Eqw1Ke5WfXcNGT6dm9rzwejXIzYg8BNOHwy57tgQMuzD2eBwbR?=
 =?us-ascii?Q?Uogo/4W2su5VeMmjNSxXc1JDQo6pkwW5kHsXwH1aqU4ev1LLVi70VgjIbFkk?=
 =?us-ascii?Q?pk3OaVxasxz931TbCaolUKCypSa6DYhskgITBASApcc9gFfHGVMERkBrUa+Y?=
 =?us-ascii?Q?mBzp/Bu4MtWmgymiV55tZiBBa/cUhD76UFknf6NYIDkRrqa+ZcCz7ceqqONJ?=
 =?us-ascii?Q?HPgD5ji7te+GqEqpMh1ssTqj9yI9MchzWNAh4WoTrJ5/CUhjXvGG2ipbveF0?=
 =?us-ascii?Q?28mBfZwXWks7cnqVek0hNxLhcnKDc5kK5F+figosOAQHu1ysP+zze5aqH6Vu?=
 =?us-ascii?Q?p3t/TK6KKE+Tl0WPFHoa1OPMMQgrDPBLM6GEBye6AKvnCeIVB5uzB4yGhVwI?=
 =?us-ascii?Q?a2PMEd+jDU8R6fCwdxvAWx8H3qN5xBUiV+tRXfH7+BI5KwnP0cnfxUBjZB4C?=
 =?us-ascii?Q?AEJ2gwNbSpZgFp56MSVdX6I=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8803e6d8-5384-42f0-87bd-08d9d772b6c5
X-MS-Exchange-CrossTenant-AuthSource: VI1PR04MB4688.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jan 2022 15:29:54.4152
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1VgPjcECD2CbLpyYswApm+ZSgClFwQmGoK+wZr7C2/6JLJ0SCildjeXAJiOIG0plIOmkvvxSQS+VGBvhZH11sA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0402MB3840
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 21-12-21 09:43:39, Rob Herring wrote:
> On Tue, Dec 21, 2021 at 7:16 AM Abel Vesa <abel.vesa@nxp.com> wrote:
> >
> > Add i.MX8DXL lpuart compatible to the bindings documentation.
> >
> > Signed-off-by: Abel Vesa <abel.vesa@nxp.com>
> > ---
> >
> > This is a resend of the following, but as a separate patch.
> >
> > https://lore.kernel.org/linux-arm-kernel/YcCisM3BqM984k%2F1@kroah.com/
> >
> >  Documentation/devicetree/bindings/serial/fsl-lpuart.yaml | 4 ++++
> >  1 file changed, 4 insertions(+)
> >
> > diff --git a/Documentation/devicetree/bindings/serial/fsl-lpuart.yaml b/Documentation/devicetree/bindings/serial/fsl-lpuart.yaml
> > index 6e04e3848261..1f482e166467 100644
> > --- a/Documentation/devicetree/bindings/serial/fsl-lpuart.yaml
> > +++ b/Documentation/devicetree/bindings/serial/fsl-lpuart.yaml
> > @@ -30,6 +30,10 @@ properties:
> >        - items:
> >            - const: fsl,imx8qm-lpuart
> >            - const: fsl,imx8qxp-lpuart
> > +      - items:
> > +          - const: fsl,imx8dxl-lpuart
> > +          - const: fsl,imx8qxp-lpuart
> > +          - const: fsl,imx7ulp-lpuart
> 
> It doesn't really make sense that imx8qm and imx8dxl are backwards
> compatible with imx8qxp, but only imx8qm is backwards compatible to
> imx7ulp. Ir only makes sense if some feature/quirk specific to
> fsl,imx7ulp-lpuart is gone in imx8qm.
> 

Actually, I'll just drop the imx7ulp from the imx8dxl dts nodes and then
from this patch.

The imx7ulp compatible is not needed anymore because the following
commit:

b4b844930f27bf7019 ("tty: serial: fsl_lpuart: drop earlycon entry for i.MX8QXP"

got reverted by:

4e9679738a918d8a48 ('Revert "tty: serial: fsl_lpuart: drop earlycon entry for i.MX8QXP"')

Will resend with proper changes.

> Rob
