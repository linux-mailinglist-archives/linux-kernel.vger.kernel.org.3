Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4180453B58A
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Jun 2022 10:59:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232618AbiFBI6U (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Jun 2022 04:58:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229777AbiFBI6R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Jun 2022 04:58:17 -0400
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 265341EA85A;
        Thu,  2 Jun 2022 01:58:15 -0700 (PDT)
X-UUID: 4fabf6b450964861924a05b0480082b3-20220602
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.5,REQID:3a21a843-f1c4-4fda-8198-a62bed9bacb1,OB:0,LO
        B:0,IP:0,URL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,RULE:Release_Ham,ACTI
        ON:release,TS:0
X-CID-META: VersionHash:2a19b09,CLOUDID:9407ac6e-b02c-4af4-b838-5c14aaa063c7,C
        OID:IGNORED,Recheck:0,SF:nil,TC:nil,Content:0,EDM:-3,IP:nil,URL:0,File:nil
        ,QS:0,BEC:nil
X-UUID: 4fabf6b450964861924a05b0480082b3-20220602
Received: from mtkmbs10n2.mediatek.inc [(172.21.101.183)] by mailgw02.mediatek.com
        (envelope-from <tinghan.shen@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 2001808159; Thu, 02 Jun 2022 16:58:09 +0800
Received: from mtkcas10.mediatek.inc (172.21.101.39) by
 mtkmbs11n1.mediatek.inc (172.21.101.185) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.2.792.3;
 Thu, 2 Jun 2022 16:58:07 +0800
Received: from mtksdccf07 (172.21.84.99) by mtkcas10.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Thu, 2 Jun 2022 16:58:07 +0800
Message-ID: <287d88a62fd13cd762b20faa3e9df826632fe1eb.camel@mediatek.com>
Subject: Re: [PATCH v1 01/15] dt-binding: remoteproc: mediatek: Support
 dual-core SCP
From:   Tinghan Shen <tinghan.shen@mediatek.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Lee Jones <lee.jones@linaro.org>,
        Benson Leung <bleung@chromium.org>,
        Guenter Roeck <groeck@chromium.org>,
        Daisuke Nojiri <dnojiri@chromium.org>,
        Sebastian Reichel <sebastian.reichel@collabora.com>,
        "Dustin L. Howett" <dustin@howett.net>,
        Tzung-Bi Shih <tzungbi@kernel.org>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        Prashant Malani <pmalani@chromium.org>,
        "Enric Balletbo i Serra" <enric.balletbo@collabora.com>,
        Brian Norris <briannorris@chromium.org>
CC:     <linux-remoteproc@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <chrome-platform@lists.linux.dev>,
        <Project_Global_Chrome_Upstream_Group@mediatek.com>,
        <weishunc@google.com>
Date:   Thu, 2 Jun 2022 16:58:07 +0800
In-Reply-To: <476baef8-0255-45ed-85f4-2b9d877c4af1@linaro.org>
References: <20220601112201.15510-1-tinghan.shen@mediatek.com>
         <20220601112201.15510-2-tinghan.shen@mediatek.com>
         <dd3ea397-fa21-abe5-85ad-b8a4818dc011@linaro.org>
         <3c837acfbefa5b7e23e1121678b5b878f08e4ef2.camel@mediatek.com>
         <476baef8-0255-45ed-85f4-2b9d877c4af1@linaro.org>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-MTK:  N
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Krzysztof,

On Thu, 2022-06-02 at 08:55 +0200, Krzysztof Kozlowski wrote:
> On 02/06/2022 07:21, Tinghan Shen wrote:
> > Hi Krzysztof,
> > 
> > On Wed, 2022-06-01 at 13:50 +0200, Krzysztof Kozlowski wrote:
> > > On 01/06/2022 13:21, Tinghan Shen wrote:
> > > > The SCP co-processor is a dual-core RISC-V MCU on MT8195.
> > > > 
> > > > Add a new property to identify each core and helps to find drivers
> > > > through device tree API to cooperate with each other, e.g. boot flow and
> > > > watchdog timeout flow.
> > > > 
> > > > Add a new compatile for the driver of SCP 2nd core.
> > > > 
> > > > Signed-off-by: Tinghan Shen <tinghan.shen@mediatek.com>
> > > > ---
> > > >  .../devicetree/bindings/remoteproc/mtk,scp.yaml      | 12 ++++++++++++
> > > >  1 file changed, 12 insertions(+)
> > > > 
> > > > diff --git a/Documentation/devicetree/bindings/remoteproc/mtk,scp.yaml
> > > > b/Documentation/devicetree/bindings/remoteproc/mtk,scp.yaml
> > > > index eec3b9c4c713..b181786d9575 100644
> > > > --- a/Documentation/devicetree/bindings/remoteproc/mtk,scp.yaml
> > > > +++ b/Documentation/devicetree/bindings/remoteproc/mtk,scp.yaml
> > > > @@ -20,6 +20,7 @@ properties:
> > > >        - mediatek,mt8186-scp
> > > >        - mediatek,mt8192-scp
> > > >        - mediatek,mt8195-scp
> > > > +      - mediatek,mt8195-scp-dual
> > > >  
> > > >    reg:
> > > >      description:
> > > > @@ -57,6 +58,16 @@ properties:
> > > >    memory-region:
> > > >      maxItems: 1
> > > >  
> > > > +  mediatek,scp-core:
> > > > +    $ref: /schemas/types.yaml#/definitions/uint32-array
> > > > +    description:
> > > > +      The property value is a list with 2 items, a core id and a phandle
> > > 
> > > uint32, not phandle.
> > > 
> > > > +      to the sibling SCP node. 
> > > 
> > > Skip this. First part is obvious from the schema, second part should be
> > > described via items.
> > > 
> > > The core id represents the id of the dts node contains
> > > > +      this property. The valid values of core id are 0 and 1 for dual-core SCP.
> > > > +      The phandle of sibling SCP node is used to find the register settings,
> > > > +      trigger core dependent callback, and invoke rproc API.
> > > 
> > > Entire description did not help me to understand what's this. So far it
> > > looks like it is not a hardware property but some programming help, so
> > > it does not look like properly described in bindings.
> > > 
> > > > +    maxItems: 1
> > > 
> > > In description you said - two items.
> > > 
> > > You need allOf:if:then disallowing this property for other variants.
> > > 
> > > > +
> > > >  required:
> > > >    - compatible
> > > >    - reg
> > > > @@ -115,6 +126,7 @@ examples:
> > > >          reg-names = "sram", "cfg", "l1tcm";
> > > >          clocks = <&infracfg CLK_INFRA_SCPSYS>;
> > > >          clock-names = "main";
> > > > +        mediatek,scp-core = <0 &scp_dual>;
> > > 
> > > This looks like phandle, so wrong type.
> > > >  
> > > >          cros_ec {
> > > >              mediatek,rpmsg-name = "cros-ec-rpmsg";
> > 
> > Thanks for your feedback.
> > After looking for a comparable uses case, I find out a different approach.
> > 
> >   mediatek,scp-core:
> >     $ref: "/schemas/types.yaml#/definitions/phandle-array"
> >     description:
> >       Enable the dual-core support in scp driver.
> 
> You describe desired functional behavior, not the hardware. What is the
> property about? If you just want to indicate this is two-core processor,
> then it could be:
> 	mediatek,cores = <2>; /* number of cores */
> 
> 
> However it seems you want to achieve here something different and as I
> raised last time - it does not look like DT property.
> 
> Or maybe this is for first core and you want to indicate the sibling?
> Something like that was mentioned in previous description.

This property is mainly added for scp 1st core driver 
and scp 2nd core driver to find each other via DT API.

After reconsidering the use of core id in the scp driver, it 
is not necessary in the control flow. I'll remove the core id 
at next version.

How about change the description as following,

  This property enables the dual-core support in scp driver.
  By providing the phandle of SCP 2nd core node, the 1st SCP node
  can control the SCP 2nd core as the subdevice of remoteproc framework.


Thanks,
Tinghan

> 
> 
> >     items:
> >       - items:
> >           - description: Assign a core id for current scp node.
> >             enum: [0, 1]
> >           - description:
> >               Phandle of another SCP node. This helps to find
> >               the scp driver of another core to trigger core
> >               dependent callback, invoke rproc subdevice API, etc.
> 
> Items should be rather reversed, as [0,1] being the argument to phandle
> for a provider (see examples with syscon)...
> 
> Best regards,
> Krzysztof

