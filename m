Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 97E1A5933C7
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Aug 2022 19:03:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231990AbiHORDC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Aug 2022 13:03:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229701AbiHORDA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Aug 2022 13:03:00 -0400
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0DCFB1EC69;
        Mon, 15 Aug 2022 10:02:59 -0700 (PDT)
Received: from ip5b412258.dynamic.kabel-deutschland.de ([91.65.34.88] helo=diego.localnet)
        by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <heiko@sntech.de>)
        id 1oNdUI-00056T-HF; Mon, 15 Aug 2022 19:02:50 +0200
From:   Heiko =?ISO-8859-1?Q?St=FCbner?= <heiko@sntech.de>
To:     Samuel Holland <samuel@sholland.org>,
        linux-arm-kernel@lists.infradead.org
Cc:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>, linux-kernel@vger.kernel.org,
        Chen-Yu Tsai <wens@csie.org>, devicetree@vger.kernel.org,
        Maxime Ripard <mripard@kernel.org>,
        Rob Herring <robh@kernel.org>
Subject: Re: [PATCH v3 3/4] dt-bindings: sram: sunxi-sram: Add optional regulators child
Date:   Mon, 15 Aug 2022 19:02:49 +0200
Message-ID: <12394338.VsHLxoZxqI@diego>
In-Reply-To: <1660572107.469120.1103613.nullmailer@robh.at.kernel.org>
References: <20220815043436.20170-1-samuel@sholland.org> <20220815043436.20170-4-samuel@sholland.org> <1660572107.469120.1103613.nullmailer@robh.at.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,T_SPF_HELO_TEMPERROR autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am Montag, 15. August 2022, 16:01:47 CEST schrieb Rob Herring:
> On Sun, 14 Aug 2022 23:34:34 -0500, Samuel Holland wrote:
> > Some sunxi SoCs have in-package regulators controlled by a register in
> > the system control MMIO block. Allow a child node for these regulators
> > in addition to SRAM child nodes.
> > 
> > Signed-off-by: Samuel Holland <samuel@sholland.org>
> > ---
> > 
> > Changes in v3:
> >  - Require the regulators node to have a unit address
> >  - Reference the regulator schema from the SRAM controller schema
> >  - Move the system LDOs example to the SRAM controller schema
> >  - Reorder the patches so the example passes validation
> > 
> > Changes in v2:
> >  - New patch for v2
> > 
> >  .../allwinner,sun4i-a10-system-control.yaml   | 29 +++++++++++++++++++
> >  1 file changed, 29 insertions(+)
> > 
> 
> My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
> on your patch (DT_CHECKER_FLAGS is new in v5.13):
> 
> yamllint warnings/errors:
> 
> dtschema/dtc warnings/errors:
> Documentation/devicetree/bindings/sram/allwinner,sun4i-a10-system-control.example.dtb:0:0: /example-1/syscon@3000000: failed to match any schema with compatible: ['allwinner,sun20i-d1-system-control']

This got added in
	"dt-bindings: sram: sunxi-sram: Add D1 compatible string"

( https://lore.kernel.org/r/20220815041248.53268-3-samuel@sholland.org )

> 
> doc reference errors (make refcheckdocs):
> 
> See https://patchwork.ozlabs.org/patch/
> 
> This check can fail if there are any dependencies. The base for a patch
> series is generally the most recent rc1.
> 
> If you already ran 'make dt_binding_check' and didn't see the above
> error(s), then make sure 'yamllint' is installed and dt-schema is up to
> date:
> 
> pip3 install dtschema --upgrade
> 
> Please check and re-submit.
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
> 




