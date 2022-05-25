Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4067D534683
	for <lists+linux-kernel@lfdr.de>; Thu, 26 May 2022 00:34:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344440AbiEYWeb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 May 2022 18:34:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244460AbiEYWe1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 May 2022 18:34:27 -0400
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33304FD0F;
        Wed, 25 May 2022 15:34:26 -0700 (PDT)
Received: from pendragon.ideasonboard.com (ip-109-40-242-63.web.vodafone.de [109.40.242.63])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id 8B09C563;
        Thu, 26 May 2022 00:34:23 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1653518063;
        bh=SEgBW7SHEvO9WqxRVFG1Zg8n5BFJC+ASS7wS2330RpQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=K1mboHc48vmbNTO50G6n+zn3SoJnydnuIxaUVlTQIkB34RM85zmmQ39/6Jt7fqfhZ
         L45dnG4X6HlTI2Xj1IHPy6lvGm6lDQKgnz0L07hpvXknhrBb5zXkaNwOakaVtrHzDi
         5EEti13iHMTR+YeWbLGOwdazoUBi9f/wtZr2mQOU=
Date:   Thu, 26 May 2022 01:34:18 +0300
From:   Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To:     Rob Herring <robh@kernel.org>
Cc:     Andrzej Hajda <andrzej.hajda@intel.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Robert Foss <robert.foss@linaro.org>,
        Jonas Karlman <jonas@kwiboo.se>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        "H. Nikolaus Schaller" <hns@goldelico.com>,
        dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: display: ingenic,jz4780-hdmi: Drop
 undocumented 'ddc-i2c-bus'
Message-ID: <Yo6u6jcVSsTQvRiU@pendragon.ideasonboard.com>
References: <20220525205626.2482584-1-robh@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220525205626.2482584-1-robh@kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Rob,

Thank you for the patch.

On Wed, May 25, 2022 at 03:56:26PM -0500, Rob Herring wrote:
> While 'ddc-i2c-bus' is a common property, it should be in a connector
> node rather than the HDMI bridge node as the I2C bus goes to a
> connector and not the HDMI block. Drop it from the example.
>
> Signed-off-by: Rob Herring <robh@kernel.org>

Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>

> ---
>  .../devicetree/bindings/display/bridge/ingenic,jz4780-hdmi.yaml  | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/Documentation/devicetree/bindings/display/bridge/ingenic,jz4780-hdmi.yaml b/Documentation/devicetree/bindings/display/bridge/ingenic,jz4780-hdmi.yaml
> index b8219eab4475..89490fdffeb0 100644
> --- a/Documentation/devicetree/bindings/display/bridge/ingenic,jz4780-hdmi.yaml
> +++ b/Documentation/devicetree/bindings/display/bridge/ingenic,jz4780-hdmi.yaml
> @@ -55,7 +55,6 @@ examples:
>          compatible = "ingenic,jz4780-dw-hdmi";
>          reg = <0x10180000 0x8000>;
>          reg-io-width = <4>;
> -        ddc-i2c-bus = <&i2c4>;
>          interrupt-parent = <&intc>;
>          interrupts = <3>;
>          clocks = <&cgu JZ4780_CLK_AHB0>, <&cgu JZ4780_CLK_HDMI>;

-- 
Regards,

Laurent Pinchart
