Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 347A0566E04
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Jul 2022 14:31:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238570AbiGEM3S (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Jul 2022 08:29:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237522AbiGEMTS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jul 2022 08:19:18 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6BF591D301;
        Tue,  5 Jul 2022 05:14:57 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 08AB3619A6;
        Tue,  5 Jul 2022 12:14:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 67EB3C341C7;
        Tue,  5 Jul 2022 12:14:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1657023296;
        bh=aLQZfrDM31ozGifv0mYlP/DyenjNLWBGnOgZJDGlVT8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=he/uxbDIQ6fWWKA1hja3r9GYlQ3Lq1c2ri8Pu6het+AFtdNo2nMZol5QV0wTjX9eW
         flevcHdytpywKNMHJ4F7wkq6+8Bx3rhmd37lmXUnvmZtXC3y1ycBFjlnKK6tkmNho4
         awonQ27J4vOs34K6Xk7W3kFLifXba6wMif6pdQ5Ew9uWcciUzUUQiIsyyE+gOnecu9
         VgnOPoXUlmC3YpPnjvxDhsFhONtcxi1ZJS9khqUHhhnGv93Y9rMTw0CFAXn2wNr/Fj
         y0jigs/3kyAZocJWcgJJIgvDmRDT6jahb/MTt3a0KMB/WQtyDJiHAFUTP+gruO8Yut
         G98uwK0Uo5o2w==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan@kernel.org>)
        id 1o8hSD-0006Dv-Dm; Tue, 05 Jul 2022 14:14:57 +0200
Date:   Tue, 5 Jul 2022 14:14:57 +0200
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
Subject: Re: [PATCH 11/43] dt-bindings: phy: qcom,msm8996-qmp-pcie: deprecate
 reset names
Message-ID: <YsQrQfvxauIGy6Ug@hovoldconsulting.com>
References: <20220705094239.17174-1-johan+linaro@kernel.org>
 <20220705094239.17174-12-johan+linaro@kernel.org>
 <2a5fec43-352c-b304-e0c9-761e1d2b67ec@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2a5fec43-352c-b304-e0c9-761e1d2b67ec@linaro.org>
X-Spam-Status: No, score=-7.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 05, 2022 at 12:12:25PM +0200, Krzysztof Kozlowski wrote:
> On 05/07/2022 11:42, Johan Hovold wrote:
> > Drop the unnecessary "lane" suffix from the PHY reset names and mark the
> > old names as deprecated.
> > 
> > Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
> > ---
> >  .../phy/qcom,msm8996-qmp-pcie-phy.yaml        | 20 +++++++++++--------
> >  1 file changed, 12 insertions(+), 8 deletions(-)
> > 
> > diff --git a/Documentation/devicetree/bindings/phy/qcom,msm8996-qmp-pcie-phy.yaml b/Documentation/devicetree/bindings/phy/qcom,msm8996-qmp-pcie-phy.yaml
> > index 7931b1fd1476..0bea8270b37e 100644
> > --- a/Documentation/devicetree/bindings/phy/qcom,msm8996-qmp-pcie-phy.yaml
> > +++ b/Documentation/devicetree/bindings/phy/qcom,msm8996-qmp-pcie-phy.yaml
> > @@ -94,11 +94,15 @@ patternProperties:
> >            - description: PHY (lane) reset
> >  
> >        reset-names:
> > -        items:
> > -          - enum:
> > -              - lane0
> > -              - lane1
> > -              - lane2
> > +        oneOf:
> > +          - items:
> > +              - const: lane
> > +          - items:
> > +              - enum:
> > +                  - lane0
> > +                  - lane1
> > +                  - lane2
> > +            deprecated: true
> >  
> 
> How about just dropping reset-names entirely? Marking entire field
> deprecated and removing from DTS? The same in the previous patch.
> 
> Usually one-item xxx-names do not bring any useful information.

Yeah, I agree, that's better.

Johan
