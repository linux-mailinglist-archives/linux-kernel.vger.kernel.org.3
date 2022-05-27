Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 548FC536753
	for <lists+linux-kernel@lfdr.de>; Fri, 27 May 2022 21:06:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354562AbiE0TFx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 May 2022 15:05:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240401AbiE0TFu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 May 2022 15:05:50 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [46.235.227.227])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EDACB5C76E;
        Fri, 27 May 2022 12:05:49 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: nfraprado)
        with ESMTPSA id 6F81D1F464B2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1653678348;
        bh=xy2v0UW9OxkQlEpRbg1MC88ziJi3bs138+XfVpOrkC8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=mmjaRwBZTXfnPJGc8bg4toaoo7Nyy0vzqi4EoQOeXyw9L35qvzztiaTKc8D+3NEUo
         kayJ4EY33oK3oAtrBrOS3xa++5ygl8StkJe0nOsqV/dlMCv6kE7PzCWHRFLNnJzgso
         8GoqNYPkUfFT7ERTn3CO/vwimAsB3k6g/JBpKfALGev0HUY3dP3wUid8ss7xdZvham
         py+/vV1fyzp7V/dx21pD7ADBHmbgZdS05Ve6cgbkDn8SLaeo+rWBgX7DaMKlyNsj4q
         Vii7d9CB0XHlSckHEZBCSUBzrJfH82zot9PVCF+ZLll5iy2uzMFYbHnI0hxOQ4YXXX
         nsKgtruVhfFNg==
Date:   Fri, 27 May 2022 15:05:42 -0400
From:   =?utf-8?B?TsOtY29sYXMgRi4gUi4gQS4=?= Prado 
        <nfraprado@collabora.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Mark Brown <broonie@kernel.org>, kernel@collabora.com,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Jiaxin Yu <jiaxin.yu@mediatek.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Shane Chien <shane.chien@mediatek.com>,
        alsa-devel@alsa-project.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-mediatek@lists.infradead.org
Subject: Re: [PATCH v2] ASoC: dt-bindings: mediatek: mt8192: Add i2s-share
 properties
Message-ID: <20220527190542.4jckyflvtkq4n7ie@notapiano>
References: <20220509205847.607076-1-nfraprado@collabora.com>
 <e8d854c0-e2a5-2382-4b54-c5e879170324@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <e8d854c0-e2a5-2382-4b54-c5e879170324@linaro.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 26, 2022 at 08:49:39AM +0200, Krzysztof Kozlowski wrote:
> On 09/05/2022 22:58, Nícolas F. R. A. Prado wrote:
> > The Mediatek AFE PCM controller for MT8192 allows two I2S interfaces to
> > share the same clock and act as a single interface with both input and
> > output. Add patterns for these properties in the dt-binding. The
> > property is split into two patterns in order to allow all valid
> > interface pairings.
> > 
> > Signed-off-by: Nícolas F. R. A. Prado <nfraprado@collabora.com>
> > 
> > ---
> > The series from v1 of this patch was merged although some changes were
> > still needed in this patch, so the v1 of this patch was reverted [1] and
> > this standalone commit addresses the feedback from v1 and readds the
> > property.
> > 
> > [1] https://lore.kernel.org/all/20220509185625.580811-1-nfraprado@collabora.com
> > 
> > v1: https://lore.kernel.org/all/20220429203039.2207848-2-nfraprado@collabora.com/
> > 
> > Changes in v2:
> > - Added "mediatek," prefix to property
> > - Rewrote and added more information to property description
> > - Split into two patterns to validate that output-input pairings are
> >   done
> > 
> >  .../bindings/sound/mt8192-afe-pcm.yaml           | 16 ++++++++++++++++
> >  1 file changed, 16 insertions(+)
> > 
> > diff --git a/Documentation/devicetree/bindings/sound/mt8192-afe-pcm.yaml b/Documentation/devicetree/bindings/sound/mt8192-afe-pcm.yaml
> > index 7a25bc9b8060..2abf43c6c2c3 100644
> > --- a/Documentation/devicetree/bindings/sound/mt8192-afe-pcm.yaml
> > +++ b/Documentation/devicetree/bindings/sound/mt8192-afe-pcm.yaml
> > @@ -54,6 +54,22 @@ properties:
> >        - const: aud_infra_clk
> >        - const: aud_infra_26m_clk
> >  
> > +patternProperties:
> > +  "^mediatek,i2s[13579]-share$":
> > +    description:
> > +      Each I2S interface has a single data line, input if its index is even or
> > +      output if the index is odd. An input and an output I2S interface can be
> > +      used together as if they were a single I2S interface with both input and
> > +      output data lines by sharing the same clock. This property represents this
> > +      pairing. The value should be the name of the interface whose clock is
> > +      used, and the property name the other interface that depends on this
> > +      clock.
> > +    pattern: "^I2S[0268]$"
> > +
> > +  "^mediatek,i2s[0268]-share$":
> > +    description: Same as above.
> > +    pattern: "^I2S[13579]$"
> 
> Rob's question is still valid - why these are not phandles?

So, instead of having

	i2s9-share = "I2S8";

on the DT, you want us to have something like this:

        afe_i2s8: mediatek,i2s8 { };

        mediatek,i2s9 {
          mediatek,share-clock = <&afe_i2s8>;
        };

Or do you mean something else?

It seems like a lot more syntax to express the same thing (and the empty node
seems awkward), but if that's the DT way, I can change it no problem.

> 
> In any case you miss $ref.

Indeed, sorry, I'll add it in next version.

Thanks,
Nícolas
