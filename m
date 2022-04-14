Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E1272500DA9
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Apr 2022 14:34:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243414AbiDNMgj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Apr 2022 08:36:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229724AbiDNMge (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Apr 2022 08:36:34 -0400
Received: from mail-oa1-f43.google.com (mail-oa1-f43.google.com [209.85.160.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F8238D6BC;
        Thu, 14 Apr 2022 05:34:09 -0700 (PDT)
Received: by mail-oa1-f43.google.com with SMTP id 586e51a60fabf-df02f7e2c9so5060814fac.10;
        Thu, 14 Apr 2022 05:34:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=wSmoTWodn7aS0tZVtzjoVxm1uv6qw8b918ASqLWo9Rw=;
        b=QdkesTyymgRZG8tV5sZOPcBFSCNUx2DmH+fnvkgw4cjxdHsOhKqSIm3jRYVku9RuE+
         UXw6rB/RHbdrV/YAh8ms+li9war+R/ZvTj30Jfn+WieY1obZo97yNYhOGBvs/cjLrcL3
         P50XTNv5SoxrbVDAyXewnQc2gCVhqJna+QtK4HP85eRzptOZmAWSQkst1JxuvLydzFqX
         OLvaEY8BHE6KpHdbzVcKRIfmUjXi0iSxdSpYN62zcz7JuXEHFJlJUt8JsQC6AVbC3iwL
         A6hufSl9KWhlOE5R+EjcF225JmItUOAPluXr5jjvjv8C9MFAs8wD6o6aeevOCZtE5Nyf
         oHGQ==
X-Gm-Message-State: AOAM533HENGllIYv71Du6Iwop1EQUX9m33MOwj4AK5eIzlg7OLsquPnT
        UC3HqXnUlf9F7fiA2jJAww==
X-Google-Smtp-Source: ABdhPJy0Y8ecV9BloZAgC9qU45xacd7ZCLN5xS54a/Y5FW9BvYKie04QQ0w+v5BrZuEYk2a5wXn2mQ==
X-Received: by 2002:a05:6871:10d:b0:e2:9e1d:9b8 with SMTP id y13-20020a056871010d00b000e29e1d09b8mr1147162oab.293.1649939648639;
        Thu, 14 Apr 2022 05:34:08 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id y13-20020a4a650d000000b00329a5250c77sm616167ooc.6.2022.04.14.05.34.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Apr 2022 05:34:08 -0700 (PDT)
Received: (nullmailer pid 1718363 invoked by uid 1000);
        Thu, 14 Apr 2022 12:34:07 -0000
Date:   Thu, 14 Apr 2022 07:34:07 -0500
From:   Rob Herring <robh@kernel.org>
To:     Drew Fustini <dfustini@baylibre.com>
Cc:     Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Dave Gerlach <d-gerlach@ti.com>,
        Tony Lindgren <tony@atomide.com>, Nishanth Menon <nm@ti.com>,
        Santosh Shilimkar <ssantosh@kernel.org>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] dt-bindings: wkup-m3-ipc: Add ti,io-isolation
 property
Message-ID: <YlgUv2szqjes9arm@robh.at.kernel.org>
References: <20220413020641.2789408-1-dfustini@baylibre.com>
 <20220413020641.2789408-2-dfustini@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220413020641.2789408-2-dfustini@baylibre.com>
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

On Tue, Apr 12, 2022 at 07:06:40PM -0700, Drew Fustini wrote:
> Add documentation for the ti,io-isolation DT property on the wkup_m3_ipc
> node which tells the wkup_m3_ipc driver to use the wkup_m3 to enable
> IO Isolation during low power mode transitions on am43xx platforms.
> 
> Signed-off-by: Dave Gerlach <d-gerlach@ti.com>
> [dfustini: convert to YAML, make DTS example that passes check]
> Signed-off-by: Drew Fustini <dfustini@baylibre.com>
> ---
>  .../bindings/soc/ti/wkup-m3-ipc.yaml          | 68 +++++++++++++++++--
>  1 file changed, 63 insertions(+), 5 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/soc/ti/wkup-m3-ipc.yaml b/Documentation/devicetree/bindings/soc/ti/wkup-m3-ipc.yaml
> index 7f4a75c5fcaa..30a65b75c024 100644
> --- a/Documentation/devicetree/bindings/soc/ti/wkup-m3-ipc.yaml
> +++ b/Documentation/devicetree/bindings/soc/ti/wkup-m3-ipc.yaml
> @@ -24,14 +24,22 @@ description: |+
>    A wkup_m3_ipc device node is used to represent the IPC registers within an
>    SoC.
>  
> -  Support for VTT Toggle
> -  ==================================
> +  Support for VTT Toggle with GPIO pin
> +  ====================================
>    On some boards like the AM335x EVM-SK and the AM437x GP EVM, a GPIO pin is
>    connected to the enable pin on the DDR VTT regulator. This allows the
>    regulator to be disabled upon suspend and enabled upon resume. Please note
>    that the GPIO pin must be part of the GPIO0 module as only this GPIO module
>    is in the wakeup power domain.
>  
> +  Support for IO Isolation
> +  ========================
> +  On AM437x SoCs, certain pins can be forced into an alternate state when IO
> +  isolation is activated. Those pins have pad control registers prefixed by
> +  'CTRL_CONF_' that contain DS0 (e.g. deep sleep) configuration bits that can
> +  override the pin's existing bias (pull-up/pull-down) and value (high/low) when
> +  IO isolation is active.

Can't this feature be implied from the compatible string?

> +
>  properties:
>    compatible:
>      enum:
> @@ -63,6 +71,14 @@ properties:
>      $ref: /schemas/types.yaml#/definitions/uint32
>      description: GPIO pin connected to enable pin on VTT regulator
>  
> +  ti,set-io-isolation:
> +    type: boolean
> +    description:
> +      If this property is present, then the wkup_m3_ipc driver will instruct
> +      the CM3 firmware to activate IO isolation when suspending to deep sleep.
> +      This can be leveraged by a board design to put other devices on the board
> +      into a low power state.
> +
>  required:
>    - compatible
>    - reg
> @@ -74,21 +90,63 @@ additionalProperties: false
>  
>  examples:
>    - |
> +    /* Example for AM335x SoC */
>      soc {
>          #address-cells = <1>;
>          #size-cells = <1>;
>  
> -        mailbox: mailbox {
> +        am335x_mailbox: mailbox {
>              #mbox-cells = <1>;
>          };
>  
> -        wkup_m3_ipc: wkup_m3_ipc@1324 {
> +        wkup_m3_ipc@1324 {
>             compatible = "ti,am3352-wkup-m3-ipc";
>             reg = <0x1324 0x24>;
>             interrupts = <78>;
>             ti,rproc = <&wkup_m3>;
> -           mboxes = <&mailbox &mbox_wkupm3>;
> +           mboxes = <&am335x_mailbox &mbox_wkupm3>;
>             ti,vtt-gpio-pin = <7>;
>          };
>      };
> +
> +  - |
> +    /*
> +     * Example for AM473x SoC:
> +     * On the AM437x-GP-EVM board, gpio5_7 is wired to enable pin of the DDR VTT
> +     * regulator. The 'ddr_vtt_toggle_default' pinmux node configures gpio5_7
> +     * for pull-up during normal system operation. However, the DS0 (deep sleep)
> +     * state of the pin is configured for pull-down and thus the VTT regulator
> +     * will be disabled to save power when IO isolation is active. Note that
> +     * this method is an alternative to using the 'ti,vtt-gpio-pin' property.
> +     */
> +    #include <dt-bindings/pinctrl/am43xx.h>
> +    soc {
> +        #address-cells = <1>;
> +        #size-cells = <1>;
> +
> +        am437x_mailbox: mailbox {
> +            #mbox-cells = <1>;
> +        };
> +
> +        am43xx_pinmux {
> +            pinctrl-names = "default";
> +            pinctrl-0 = <&ddr3_vtt_toggle_default>;
> +
> +            ddr3_vtt_toggle_default: ddr_vtt_toggle_default {
> +                 pinctrl-single,pins = <
> +                    0x25C (DS0_PULL_UP_DOWN_EN | PIN_OUTPUT_PULLUP | DS0_FORCE_OFF_MODE | MUX_MODE7)
> +                 >;
> +            };
> +        };
> +
> +        wkup_m3_ipc@1324 {
> +           compatible = "ti,am4372-wkup-m3-ipc";
> +           reg = <0x1324 0x24>;
> +           interrupts = <78>;
> +           ti,rproc = <&wkup_m3>;
> +           mboxes = <&am437x_mailbox &mbox_wkupm3>;
> +           ti,set-io-isolation;
> +        };
> +    };
> +
>  ...
> -- 
> 2.32.0
> 
> 
