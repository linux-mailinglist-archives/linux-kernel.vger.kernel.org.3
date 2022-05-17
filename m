Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6C57D52A9C3
	for <lists+linux-kernel@lfdr.de>; Tue, 17 May 2022 20:00:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351690AbiEQSAF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 May 2022 14:00:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351684AbiEQSAC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 May 2022 14:00:02 -0400
Received: from mail-oi1-f180.google.com (mail-oi1-f180.google.com [209.85.167.180])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A6665006C;
        Tue, 17 May 2022 11:00:01 -0700 (PDT)
Received: by mail-oi1-f180.google.com with SMTP id r1so23236483oie.4;
        Tue, 17 May 2022 11:00:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=l7jwPeZVluBx37sWW9p9486vXPERkHZmYslmM7IERC4=;
        b=43XkGRcVuTTh230Pv5bQyUCpPPNsX2IgRO3LJuMOiWh9q6wY9fxPfzNMPtM21RkokF
         K5eI3N+KQX9yIsdsWr7fGwfI5fnDTyf8WLuzCy8Lp88VcLytOiVjJRi45iIpu52Q6uaP
         fhdp0oPniDCmw/OQPJsJPZWLA4MwKmZKR8jZ4MitHdLiRtBbD/sAdFomnaeOWmeTPe4l
         CUNgvBuMVrPctwIeTPXzi25YaBS+jHQe1sPLQ0HzaRdD8BLbF5mdJnbsUqsfgFNJ+0lS
         LYanbBz/OmJLSY1Z4baOGyNIZiUUXgJglbkkqZ1cTZXRm3ikskFrMMw9B6KA1pLskq0U
         j2aA==
X-Gm-Message-State: AOAM530pZo3eyg2AW9O0gF9DUk4dtwKpCcUbPCzGrHcQYQy9Vn13K6qK
        SD2vCAmdSitv9b+Vanuncw==
X-Google-Smtp-Source: ABdhPJx4RCb0btBoBhki2+B8BgBEyjjkwfHWi2cScgsuArwHCQwCh02D1YsNTXiRT5shZKje2MpLpA==
X-Received: by 2002:aca:1108:0:b0:328:ef13:311c with SMTP id 8-20020aca1108000000b00328ef13311cmr6474612oir.220.1652810400759;
        Tue, 17 May 2022 11:00:00 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id i204-20020acab8d5000000b00326414c1bb7sm63836oif.35.2022.05.17.10.59.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 May 2022 11:00:00 -0700 (PDT)
Received: (nullmailer pid 1327168 invoked by uid 1000);
        Tue, 17 May 2022 17:59:58 -0000
Date:   Tue, 17 May 2022 12:59:58 -0500
From:   Rob Herring <robh@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Alexandre Bailon <abailon@baylibre.com>, krzk+dt@kernel.org,
        matthias.bgg@gmail.com, p.zabel@pengutronix.de, rafael@kernel.org,
        daniel.lezcano@linaro.org, amitk@kernel.org, rui.zhang@intel.com,
        michael.kao@mediatek.com, ben.tseng@mediatek.com,
        ethan.chang@mediatek.com, frank-w@public-files.de,
        linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, khilman@baylibre.com
Subject: Re: [PATCH v6 2/7] dt-bindings: thermal: Add binding document for
 mt6873 thermal controller
Message-ID: <20220517175958.GA1321687-robh@kernel.org>
References: <20220512122433.1399802-1-abailon@baylibre.com>
 <20220512122433.1399802-3-abailon@baylibre.com>
 <546ddbd4-927d-2e28-6e82-a67b4584a17f@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <546ddbd4-927d-2e28-6e82-a67b4584a17f@linaro.org>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 12, 2022 at 04:25:51PM +0200, Krzysztof Kozlowski wrote:
> On 12/05/2022 14:24, Alexandre Bailon wrote:
> > From: Michael Kao <michael.kao@mediatek.com>
> > 
> > This patch adds binding document for mt6873 thermal controller.
> 
> Thank you for your patch. There is something to discuss/improve.
> 
> > 
> > Signed-off-by: Michael Kao <michael.kao@mediatek.com>
> > Signed-off-by: Ben Tseng <ben.tseng@mediatek.com>
> > ---
> >  .../thermal/mediatek-thermal-lvts.yaml        | 81 +++++++++++++++++++
> >  1 file changed, 81 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/thermal/mediatek-thermal-lvts.yaml
> > 
> > diff --git a/Documentation/devicetree/bindings/thermal/mediatek-thermal-lvts.yaml b/Documentation/devicetree/bindings/thermal/mediatek-thermal-lvts.yaml
> > new file mode 100644
> > index 000000000000..69ffe7b14c21
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/thermal/mediatek-thermal-lvts.yaml
> 
> filename: vendor,device
> so something like mediatek,mt6873-lvts.yaml or
> mediatek,mt6873-lvts-thermal.yaml
> 
> > @@ -0,0 +1,81 @@
> > +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> > +%YAML 1.2
> > +---
> > +$id: http://devicetree.org/schemas/thermal/mediatek-thermal-lvts.yaml#
> > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > +
> > +title: Mediatek SoC LVTS thermal controller (DTS) binding
> 
> s/(DTS) binding//
> (unless DTS means something related to hardware)
> 
> > +
> > +maintainers:
> > +  - Yu-Chia Chang <ethan.chang@mediatek.com>
> > +  - Ben Tseng <ben.tseng@mediatek.com>
> > +
> > +properties:
> > +  compatible:
> > +    const: mediatek,mt6873-lvts
> > +
> > +  reg:
> > +    maxItems: 1
> > +
> > +  interrupts:
> > +    maxItems: 1
> > +
> > +  clocks:
> > +    maxItems: 1
> > +
> > +  clock-names:
> > +    items:
> > +      - const: lvts_clk
> 
> Skip "_clk" suffix, so just lvts.

Or drop altogether. There's generally no good name when there's only one 
entry so folks just make up 'clk', 'phy', 'rst', etc. or $block for the 
name.

Rob
