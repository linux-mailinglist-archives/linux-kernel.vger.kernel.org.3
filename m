Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CB7234B682C
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Feb 2022 10:50:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236078AbiBOJua (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Feb 2022 04:50:30 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:38752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231504AbiBOJu3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Feb 2022 04:50:29 -0500
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05EE0101F16;
        Tue, 15 Feb 2022 01:50:18 -0800 (PST)
X-UUID: db98b7930426490f84c54f08a312bf6d-20220215
X-UUID: db98b7930426490f84c54f08a312bf6d-20220215
Received: from mtkcas10.mediatek.inc [(172.21.101.39)] by mailgw02.mediatek.com
        (envelope-from <chun-jie.chen@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 1960818138; Tue, 15 Feb 2022 17:50:13 +0800
Received: from mtkcas11.mediatek.inc (172.21.101.40) by
 mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.2.792.3;
 Tue, 15 Feb 2022 17:50:12 +0800
Received: from mtksdccf07 (172.21.84.99) by mtkcas11.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Tue, 15 Feb 2022 17:50:12 +0800
Message-ID: <d958cc9ab31e387d06bc50a6c7a953e716d53899.camel@mediatek.com>
Subject: Re: [v2 2/3] dt-bindings: ARM: Mediatek: Remove vppsys in MT8195
 clock document
From:   Chun-Jie Chen <chun-jie.chen@mediatek.com>
To:     Rob Herring <robh@kernel.org>
CC:     Matthias Brugger <matthias.bgg@gmail.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Nicolas Boichat <drinkcat@chromium.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>, <linux-clk@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <srv_heupstream@mediatek.com>,
        <Project_Global_Chrome_Upstream_Group@mediatek.com>
Date:   Tue, 15 Feb 2022 17:50:11 +0800
In-Reply-To: <YetDNPs8Xo/Alndj@robh.at.kernel.org>
References: <20220110005902.27148-1-chun-jie.chen@mediatek.com>
         <20220110005902.27148-3-chun-jie.chen@mediatek.com>
         <YetDNPs8Xo/Alndj@robh.at.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-MTK:  N
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2022-01-21 at 17:35 -0600, Rob Herring wrote:
> On Mon, Jan 10, 2022 at 08:59:01AM +0800, Chun-Jie Chen wrote:
> > vppsys0 and vppsys1 sub-system are both integrated with mmsys
> > driver,
> > should be describe in mediatek,mmsys.yaml
> 
> Driver partitioning is not a reason to change the DT. This needs a 
> better description answering why you are doing this and what are the 
> implications (is this breaking the ABI?).


Due to the change in [1], vppsys0/vppsys1 are not only clock providers
and support mm system control. It's better to be described in
"mediatek,mmsys.yaml" [2] because they are not pure clock providers.

[1] 
https://patchwork.kernel.org/project/linux-mediatek/patch/20220117055254.9777-4-roy-cw.yeh@mediatek.com/
[2] 
https://patchwork.kernel.org/project/linux-mediatek/patch/20220117055254.9777-15-roy-cw.yeh@mediatek.com/

Thanks!
Best Regards,
Chun-Jie
> > 
> > Signed-off-by: Chun-Jie Chen <chun-jie.chen@mediatek.com>
> > ---
> >  .../arm/mediatek/mediatek,mt8195-clock.yaml      | 16 ------------
> > ----
> >  1 file changed, 16 deletions(-)
> > 
> > diff --git
> > a/Documentation/devicetree/bindings/arm/mediatek/mediatek,mt8195-
> > clock.yaml
> > b/Documentation/devicetree/bindings/arm/mediatek/mediatek,mt8195-
> > clock.yaml
> > index 17fcbb45d121..d62d60181147 100644
> > ---
> > a/Documentation/devicetree/bindings/arm/mediatek/mediatek,mt8195-
> > clock.yaml
> > +++
> > b/Documentation/devicetree/bindings/arm/mediatek/mediatek,mt8195-
> > clock.yaml
> > @@ -28,11 +28,9 @@ properties:
> >            - mediatek,mt8195-imp_iic_wrap_s
> >            - mediatek,mt8195-imp_iic_wrap_w
> >            - mediatek,mt8195-mfgcfg
> > -          - mediatek,mt8195-vppsys0
> >            - mediatek,mt8195-wpesys
> >            - mediatek,mt8195-wpesys_vpp0
> >            - mediatek,mt8195-wpesys_vpp1
> > -          - mediatek,mt8195-vppsys1
> >            - mediatek,mt8195-imgsys
> >            - mediatek,mt8195-imgsys1_dip_top
> >            - mediatek,mt8195-imgsys1_dip_nr
> > @@ -92,13 +90,6 @@ examples:
> >          #clock-cells = <1>;
> >      };
> >  
> > -  - |
> > -    vppsys0: clock-controller@14000000 {
> > -        compatible = "mediatek,mt8195-vppsys0";
> > -        reg = <0x14000000 0x1000>;
> > -        #clock-cells = <1>;
> > -    };
> > -
> >    - |
> >      wpesys: clock-controller@14e00000 {
> >          compatible = "mediatek,mt8195-wpesys";
> > @@ -120,13 +111,6 @@ examples:
> >          #clock-cells = <1>;
> >      };
> >  
> > -  - |
> > -    vppsys1: clock-controller@14f00000 {
> > -        compatible = "mediatek,mt8195-vppsys1";
> > -        reg = <0x14f00000 0x1000>;
> > -        #clock-cells = <1>;
> > -    };
> > -
> >    - |
> >      imgsys: clock-controller@15000000 {
> >          compatible = "mediatek,mt8195-imgsys";
> > -- 
> > 2.18.0
> > 
> > 

