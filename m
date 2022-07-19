Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F1C11579301
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Jul 2022 08:10:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237004AbiGSGKb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Jul 2022 02:10:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236994AbiGSGK3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jul 2022 02:10:29 -0400
Received: from mailrelay3-1.pub.mailoutpod1-cph3.one.com (mailrelay3-1.pub.mailoutpod1-cph3.one.com [46.30.210.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A561823BCA
        for <linux-kernel@vger.kernel.org>; Mon, 18 Jul 2022 23:10:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ravnborg.org; s=rsa1;
        h=in-reply-to:content-type:mime-version:references:message-id:subject:cc:to:
         from:date:from;
        bh=jp83ii8nZk7L/6Omf0n4BRcep5/FTl5AylCpqXcA8og=;
        b=WnjNN/cAU+L0AjpbfV8SjfuiKoLjdeDZqGz+PxitCRZ1XVRYf08GY9tcYp6pcSMwWOz01FOUu2N6h
         b96epudXPxMrdn3oOuZvULn5w08GnIHia3PNr3J0iMnYnP+DGObCDAEZ+yUhMNw73DwXj8t5l2NbzX
         TNCOBIOBDjvDlzv2OaRWj7D/zReTsza3mksZ226C2QrIu7B80YE9RTBMO1G0YSzRnWu9EdbRG2qVej
         m5LWI96tW5sMTAzvA1QrVBwfqeqIntlgtCkw1KcgGLxl4JWNustLmc549k/6Y56Qru6Zvd+P+j8ucQ
         aGezmh3MifN9kjtJ4V+o9fGwSFDN//Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed;
        d=ravnborg.org; s=ed1;
        h=in-reply-to:content-type:mime-version:references:message-id:subject:cc:to:
         from:date:from;
        bh=jp83ii8nZk7L/6Omf0n4BRcep5/FTl5AylCpqXcA8og=;
        b=bbfXWbrl67vsOQUfGcA821e626nY1xPLige86Rb5YRxklcAmCxPAEeNf+NykN7CJ+C2b6Hl2uiMa6
         HtfSmzkDQ==
X-HalOne-Cookie: b83d0abb0da0665d4cfe7193d5f7c0eba89b2d78
X-HalOne-ID: 77b15885-0729-11ed-be7f-d0431ea8bb03
Received: from mailproxy2.cst.dirpod3-cph3.one.com (2-105-2-98-cable.dk.customer.tdc.net [2.105.2.98])
        by mailrelay3.pub.mailoutpod1-cph3.one.com (Halon) with ESMTPSA
        id 77b15885-0729-11ed-be7f-d0431ea8bb03;
        Tue, 19 Jul 2022 06:10:20 +0000 (UTC)
Date:   Tue, 19 Jul 2022 08:10:18 +0200
From:   Sam Ravnborg <sam@ravnborg.org>
To:     Caleb Connolly <caleb@connolly.tech>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        phone-devel@vger.kernel.org, ~postmarketos/upstreaming@lists.sr.ht,
        Vinod Koul <vkoul@kernel.org>
Subject: Re: [PATCH 3/4] dt-bindings: panel: Add LG SW43408 MIPI-DSI panel
Message-ID: <YtZKylMu4jEa/oDp@ravnborg.org>
References: <20220718213051.1475108-1-caleb@connolly.tech>
 <20220718213051.1475108-4-caleb@connolly.tech>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220718213051.1475108-4-caleb@connolly.tech>
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,RCVD_IN_DNSWL_NONE,SPF_HELO_PASS,SPF_NONE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Caleb,

On Mon, Jul 18, 2022 at 10:30:50PM +0100, Caleb Connolly wrote:
> From: Sumit Semwal <sumit.semwal@linaro.org>
> 
> LG SW43408 is 1080x2160, 4-lane MIPI-DSI panel.
A few things to improve to this binding.

	Sam
> 
> Signed-off-by: Vinod Koul <vkoul@kernel.org>
> Signed-off-by: Sumit Semwal <sumit.semwal@linaro.org>
> [caleb: convert to yaml]
> Signed-off-by: Caleb Connolly <caleb@connolly.tech>
> ---
>  .../bindings/display/panel/lg,43408.yaml      | 41 +++++++++++++++++++
>  .../display/panel/panel-simple-dsi.yaml       |  2 +
>  2 files changed, 43 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/display/panel/lg,43408.yaml
> 
> diff --git a/Documentation/devicetree/bindings/display/panel/lg,43408.yaml b/Documentation/devicetree/bindings/display/panel/lg,43408.yaml
> new file mode 100644
> index 000000000000..0529a3aa2692
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/display/panel/lg,43408.yaml
> @@ -0,0 +1,41 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/display/panel/panel-lvds.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: LG SW43408 1080x2160 DSI panel
> +
> +maintainers:
> +  - Caleb Connolly <caleb@connolly.tech>
> +
> +description: |
> +  This panel is used on the Pixel 3, it is a 60hz OLED panel which
> +  required DSC (Display Stream Compression) and has rounded corners.
> +
> +allOf:
> +  - $ref: panel-common.yaml#
> +
> +properties:
> +  compatible:
> +    items:
> +      - const: lg,sw43408
> +
> +  vddi-supply: true
> +  vpnl-supply: true
> +  reset-gpios: true
> +
> +  backlight: false
> +  power-supply: false
No need to say anything is false, this is covered by the statement below.
Also, the driver uses backlight, so it should be true?
> +
> +additionalProperties: false
> +
> +required:
> +  - compatible
> +  - data-mapping
> +  - width-mm
> +  - height-mm
> +  - panel-timing
> +  - port
> +
> +...
> diff --git a/Documentation/devicetree/bindings/display/panel/panel-simple-dsi.yaml b/Documentation/devicetree/bindings/display/panel/panel-simple-dsi.yaml
> index 2c00813f5d20..4498078cb1ee 100644
> --- a/Documentation/devicetree/bindings/display/panel/panel-simple-dsi.yaml
> +++ b/Documentation/devicetree/bindings/display/panel/panel-simple-dsi.yaml
> @@ -45,6 +45,8 @@ properties:
>        - lg,acx467akm-7
>          # LG Corporation 7" WXGA TFT LCD panel
>        - lg,ld070wx3-sl01
> +        # LG Corporation sw43408 1080x2160 OLED
> +      - lg,sw43408
The panel uses three power-supplies, so it is not a "panel-simple"
binding. And we cannot have the same compatible twice, so this must be
dropped.

	Sam
