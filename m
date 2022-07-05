Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5C3B4566F1F
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Jul 2022 15:23:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232676AbiGENW1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Jul 2022 09:22:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229710AbiGENWO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jul 2022 09:22:14 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8ED8D3DA79;
        Tue,  5 Jul 2022 05:43:04 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id BBE8BB8170A;
        Tue,  5 Jul 2022 12:43:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 750D3C341C7;
        Tue,  5 Jul 2022 12:43:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1657024981;
        bh=R3LFkiD0sDZpLAm8EjSt1H2PdJiaXoZldhKa+Ii5tH0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=fi5Wu9DOGA5Elh+LCgd1aNY4sGDvKNuJ439ZQ04PvCl9vmypJwPyle3JeU3Jekrws
         S0NOSKH783XgjHTfmwltbMHqZC/Zw7NxqH8CSWlseTp5eiHrtoUGvic3L1aLYV+yJE
         jvBDZ92N8QklsbqKEaqeEpOEKvais/o6HS9z/nafKhqRDDLwk99ITE9DdGd8+92W3l
         FGng+cdGGRFuJDP75YlyWDnTrFGaUheX3qJx5XYPMBH65r+Qh1CZjIhYdWSH1wZrNj
         KWDakkfHyZE3y+LVkFtgvXhoGKXXHt2Iz4X+d9Znt5/ToSMhYio5bkQyts7eORuEXS
         jBYXGhwsT+dzg==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan@kernel.org>)
        id 1o8htN-0006q0-GA; Tue, 05 Jul 2022 14:43:02 +0200
Date:   Tue, 5 Jul 2022 14:43:01 +0200
From:   Johan Hovold <johan@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Johan Hovold <johan+linaro@kernel.org>,
        Vinod Koul <vkoul@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 16/43] dt-bindings: phy: qcom,qmp-pcie: drop unused
 vddp-ref-clk supply
Message-ID: <YsQx1SMEsMnmoQ2d@hovoldconsulting.com>
References: <20220705094239.17174-1-johan+linaro@kernel.org>
 <20220705094239.17174-17-johan+linaro@kernel.org>
 <d3a49c05-0fd0-920e-bd0a-f821e8e27b8b@linaro.org>
 <YsQkmUVla9+CDYly@hovoldconsulting.com>
 <8d739c84-ba61-a030-ea8a-63a3f45c642c@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8d739c84-ba61-a030-ea8a-63a3f45c642c@linaro.org>
X-Spam-Status: No, score=-7.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 05, 2022 at 01:59:26PM +0200, Krzysztof Kozlowski wrote:
> On 05/07/2022 13:46, Johan Hovold wrote:
> >> It's okay to copy existing bindings which are applicable and then in
> >> separate patch deprecate things or remove pieces which are not correct.
> >> But all this in assumption that the first copy already selected only
> >> applicable parts.
> > 
> > But how would you be able to tell what parts I left out from the
> > original copy 
> 
> They are obvious and immediately visible. I see old bindings and new
> bindings - no troubles to compare. I review new bindings - everything in
> place.

Heh, with all these conditionals in place that may be harder than it
sounds.

> I don't want to review old code, inapplicable code. The patch I am
> reviewing (the one doing the split) must bring correct bindings, except
> these few differences like deprecated stuff.

Sure, I get that. But this very patch is an example of why I tried to
remove things explicitly instead folding this into the original patch
and risking it not being noticed.

It's not always obvious what is applicable and what is not, especially
when the old schema is in the state it is.

> > unless I first do the split and then explicitly remove
> > things that were presumably *never* applicable and just happened to be
> > added because all bindings where combined in one large mess of a schema?

So you suggest we keep this regulator for all PHY variants even though
it was probably only needed for UFS on some older SoCs?

Johan
