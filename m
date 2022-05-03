Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 24703517C1D
	for <lists+linux-kernel@lfdr.de>; Tue,  3 May 2022 04:58:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230225AbiECC6f (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 May 2022 22:58:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229660AbiECC6c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 May 2022 22:58:32 -0400
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11CF137ABD;
        Mon,  2 May 2022 19:55:00 -0700 (PDT)
X-UUID: 3613982ef258474698a54f63ce922854-20220503
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.4,REQID:a0288b3c-070a-43b7-a047-b4dfd53461f1,OB:0,LO
        B:0,IP:0,URL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,RULE:Release_Ham,ACTI
        ON:release,TS:0
X-CID-META: VersionHash:faefae9,CLOUDID:c7ea792f-6199-437e-8ab4-9920b4bc5b76,C
        OID:IGNORED,Recheck:0,SF:nil,TC:nil,Content:0,EDM:-3,File:nil,QS:0,BEC:nil
X-UUID: 3613982ef258474698a54f63ce922854-20220503
Received: from mtkexhb02.mediatek.inc [(172.21.101.103)] by mailgw02.mediatek.com
        (envelope-from <rex-bc.chen@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 1168897835; Tue, 03 May 2022 10:54:15 +0800
Received: from mtkcas10.mediatek.inc (172.21.101.39) by
 mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.2.792.3;
 Tue, 3 May 2022 10:54:13 +0800
Received: from mtksdccf07 (172.21.84.99) by mtkcas10.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Tue, 3 May 2022 10:54:13 +0800
Message-ID: <bb99742f40762d18baa342e7f5ee697fe5a86c09.camel@mediatek.com>
Subject: Re: [PATCH V5 12/16] dt-bindings: reset: mediatek: Add infra_ao
 reset bit for MT8195
From:   Rex-BC Chen <rex-bc.chen@mediatek.com>
To:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        "mturquette@baylibre.com" <mturquette@baylibre.com>,
        "sboyd@kernel.org" <sboyd@kernel.org>,
        "matthias.bgg@gmail.com" <matthias.bgg@gmail.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "krzysztof.kozlowski+dt@linaro.org" 
        <krzysztof.kozlowski+dt@linaro.org>
CC:     "p.zabel@pengutronix.de" <p.zabel@pengutronix.de>,
        Chun-Jie Chen =?UTF-8?Q?=28=E9=99=B3=E6=B5=9A=E6=A1=80=29?= 
        <Chun-Jie.Chen@mediatek.com>,
        "wenst@chromium.org" <wenst@chromium.org>,
        Runyang Chen =?UTF-8?Q?=28=E9=99=88=E6=B6=A6=E6=B4=8B=29?= 
        <Runyang.Chen@mediatek.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-mediatek@lists.infradead.org" 
        <linux-mediatek@lists.infradead.org>,
        Project_Global_Chrome_Upstream_Group 
        <Project_Global_Chrome_Upstream_Group@mediatek.com>
Date:   Tue, 3 May 2022 10:54:09 +0800
In-Reply-To: <c56464d3-d33d-1797-2c98-67bec34df756@collabora.com>
References: <20220428115620.13512-1-rex-bc.chen@mediatek.com>
         <20220428115620.13512-13-rex-bc.chen@mediatek.com>
         <839978c5-c337-7784-a04f-26b9883c703b@linaro.org>
         <c56464d3-d33d-1797-2c98-67bec34df756@collabora.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-MTK:  N
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,RDNS_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2022-05-02 at 16:54 +0800, AngeloGioacchino Del Regno wrote:
> Il 29/04/22 23:13, Krzysztof Kozlowski ha scritto:
> > On 28/04/2022 13:56, Rex-BC Chen wrote:
> > > To support reset of infra_ao, add the bit definitions for MT8195.
> > > The infra_ao reset includes 5 banks and 32 bits for each bank.
> > > 
> > > Signed-off-by: Rex-BC Chen <rex-bc.chen@mediatek.com>
> > > ---
> > >   include/dt-bindings/reset/mt8195-resets.h | 170
> > > ++++++++++++++++++++++
> > >   1 file changed, 170 insertions(+)
> > > 
> > > diff --git a/include/dt-bindings/reset/mt8195-resets.h
> > > b/include/dt-bindings/reset/mt8195-resets.h
> > > index a26bccc8b957..463114014483 100644
> > > --- a/include/dt-bindings/reset/mt8195-resets.h
> > > +++ b/include/dt-bindings/reset/mt8195-resets.h
> > > @@ -7,6 +7,7 @@
> > >   #ifndef _DT_BINDINGS_RESET_CONTROLLER_MT8195
> > >   #define _DT_BINDINGS_RESET_CONTROLLER_MT8195
> > >   
> > > +/* TOPRGU resets */
> > >   #define MT8195_TOPRGU_CONN_MCU_SW_RST          0
> > >   #define MT8195_TOPRGU_INFRA_GRST_SW_RST        1
> > >   #define MT8195_TOPRGU_APU_SW_RST               2
> > > @@ -26,4 +27,173 @@
> > >   
> > >   #define MT8195_TOPRGU_SW_RST_NUM               16
> > >   
> > > +/* INFRA RST0 */
> > > +#define MT8195_INFRA_RST0_THERM_CTRL_SWRST	0
> > > +#define MT8195_INFRA_RST0_RSV0			1
> > > +#define MT8195_INFRA_RST0_DISP_PWM1_SWRST	2
> > > +#define MT8195_INFRA_RST0_RSV1			3
> > > +#define MT8195_INFRA_RST0_MSDC3_SWRST		4
> > > +#define MT8195_INFRA_RST0_MSDC2_SWRST		5
> > > +#define MT8195_INFRA_RST0_MSDC1_SWRST		6
> > > +#define MT8195_INFRA_RST0_MSDC0_SWRST		7
> > > +#define MT8195_INFRA_RST0_RSV2			8
> > > +#define MT8195_INFRA_RST0_AP_DMA_SWRST		9
> > > +#define MT8195_INFRA_RST0_MIPI_D_SWRST		10
> > > +#define MT8195_INFRA_RST0_RSV3			11
> > > +#define MT8195_INFRA_RST0_RSV4			12
> > > +#define MT8195_INFRA_RST0_SSUSB_TOP_SWRST	13
> > > +#define MT8195_INFRA_RST0_DISP_PWM_SWRST	14
> > > +#define MT8195_INFRA_RST0_AUXADC_SWRST		15
> > > +#define MT8195_INFRA_RST0_RSV5			16
> > > +#define MT8195_INFRA_RST0_RSV6			17
> > > +#define MT8195_INFRA_RST0_RSV7			18
> > > +#define MT8195_INFRA_RST0_RSV8			19
> > > +#define MT8195_INFRA_RST0_RSV9			20
> > > +#define MT8195_INFRA_RST0_RSV10			21
> > > +#define MT8195_INFRA_RST0_RSV11			22
> > > +#define MT8195_INFRA_RST0_RSV12			23
> > > +#define MT8195_INFRA_RST0_RSV13			24
> > > +#define MT8195_INFRA_RST0_RSV14			25
> > > +#define MT8195_INFRA_RST0_RSV15			26
> > > +#define MT8195_INFRA_RST0_RSV16			27
> > > +#define MT8195_INFRA_RST0_RSV17			28
> > > +#define MT8195_INFRA_RST0_RSV18			29
> > > +#define MT8195_INFRA_RST0_RSV19			30
> > > +#define MT8195_INFRA_RST0_RSV20			31
> > 
> > These are not proper IDs... don't work-around usage of bits with
> > fake
> > reserved IDs...
> 
> Hello Krzysztof,
> 
> Actually, I get that it may seem that Rex is trying to cheat with
> fake
> reserved numbers... but it's really how the registers are laid out:
> there
> really are reserved bits in between used reset bits.
> 
> I don't think that the reserved bits are doing anything though, so
> the
> best way to proceed is to just remove them and map the dt-bindings
> IDs to
> the HW register's bits in the driver instead.
> Even though the current approach is very simplistic, I agree that
> this is
> not how it's supposed to be done (and I'm sort-of sad about that).
> 
> Rex, please map these values in the reset driver so that, in this
> header,
> you'll get something like:
> 
> #define MT8195_INFRA_RST0_THERM_CTRL_SWRST	0
> #define MT8195_INFRA_RST0_DISP_PWM1_SWRST	1
> #define MT8195_INFRA_RST0_MSDC3_SWRST		2
> #define .... (etc)
> 
> Cheers,
> Angelo
> 
> > 
> > Best regards,
> > Krzysztof
> 
> 

Hello Krzysztof and Angelo,

Thanks for your advice and review.
I will modify my driver using index and I will just add some reset we
curreently use.

reset.h will list like this:

#define MT8195_INFRA_RST0_THERM_CTRL_SWRST	0
#define MT8195_INFRA_RST3_THERM_CTRL_PTP_SWRST	1
#define MT8195_INFRA_RST4_THERM_CTRL_MCU_SWRST	2

For this, I will add a new mode for input argument because we alos need
to be compatible with previous reset drivers.
For input argument with different mode: 
enum MTK_RST_CTRL_MODE {
	MTK_RST_CTRL_BIT_MODE = 0,
	MTK_RST_CTRL_INDEX_MODE,
};

If register MTK_RST_CTRL_INDEX_MODE for reset controller, I will
implent new xlate function to transfer the index to offsets.

BRs,
Rex

