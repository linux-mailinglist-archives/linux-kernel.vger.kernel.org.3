Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 629F559C8F7
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Aug 2022 21:33:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238084AbiHVTcJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Aug 2022 15:32:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238911AbiHVTai (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Aug 2022 15:30:38 -0400
Received: from mail-oa1-f51.google.com (mail-oa1-f51.google.com [209.85.160.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CFB8758DD1;
        Mon, 22 Aug 2022 12:25:10 -0700 (PDT)
Received: by mail-oa1-f51.google.com with SMTP id 586e51a60fabf-11ba6e79dd1so14089985fac.12;
        Mon, 22 Aug 2022 12:25:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc;
        bh=aqQ8EKilZNTR/MiCMHbW5S0C4/ZNQc/wn/QhlT3yNkA=;
        b=HHRrQqJTaYyqhm5SEDs341jEyGlML3vtqXjVKpOHBTjv3ttwjL7OnxgK+nqeSnVKXi
         y70iz9zINragPQhuSlP19IB523DCRvy4flbU6uJ+oG+PV31js8BC6KmxdRwBxlxxSPf/
         ncsowbC9REklUj8jL6A6/Lkep0G6YZlLqOsvFoeQ3yurUczS4ZKwflENkTPPN06oifRO
         kVLEmzWsJI9USHdpOhFuM1jIirrpmYCBNV3kdqWrY6DpSI0Vv+d8qUT1B36xGnRYmp4M
         AB0+L6iA6vI58ueiI3r858qCjB57/r9kV/tAZDgRBwR95AWNmaPhHsyPN7TV1gSOvSNh
         5msw==
X-Gm-Message-State: ACgBeo34NZ9N8dkHsIfOXRxkeiRqnZkOfbDohAY8H+KWo/kxEoNbQLlT
        tkLBPs2xxzaziB04DHja4A==
X-Google-Smtp-Source: AA6agR6WVI+/ceHbcBFR3xERiwrg/JO0+C7B4r7ga9Jn2f2JU+p2NFgk5jKwJ+rdMDIxRELPayZTxg==
X-Received: by 2002:a05:6870:5591:b0:10e:20d0:b2cb with SMTP id n17-20020a056870559100b0010e20d0b2cbmr13027000oao.12.1661196292263;
        Mon, 22 Aug 2022 12:24:52 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id w9-20020a0568080d4900b00334c2e81dfbsm2802210oik.0.2022.08.22.12.24.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Aug 2022 12:24:51 -0700 (PDT)
Received: (nullmailer pid 306067 invoked by uid 1000);
        Mon, 22 Aug 2022 19:24:50 -0000
Date:   Mon, 22 Aug 2022 14:24:50 -0500
From:   Rob Herring <robh@kernel.org>
To:     Mithil Bavishi <bavishimithil@gmail.com>
Cc:     linux-input@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        dmitry.torokhov@gmail.com, krzysztof.kozlowski+dt@linaro.org,
        lee@kernel.org, sre@kernel.org, tony@atomide.com,
        linux@armlinux.org.uk, contact@paulk.fr
Subject: Re: [PATCH 05/10] dt-bindings: power: reset: Add bindings for
 twl6030-power
Message-ID: <20220822192450.GA297299-robh@kernel.org>
References: <20220820071659.1215-1-bavishimithil@gmail.com>
 <20220820071659.1215-6-bavishimithil@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220820071659.1215-6-bavishimithil@gmail.com>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Aug 20, 2022 at 12:46:55PM +0530, Mithil Bavishi wrote:
> Adds documentation for the twl6030 power driver.
> 
> Signed-off-by: Paul Kocialkowski <contact@paulk.fr>
> Signed-off-by: Mithil Bavishi <bavishimithil@gmail.com>
> ---
>  .../bindings/power/reset/twl6030-power.txt    | 31 +++++++++++++++++++

New bindings must be DT schema format.

>  1 file changed, 31 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/power/reset/twl6030-power.txt
> 
> diff --git a/Documentation/devicetree/bindings/power/reset/twl6030-power.txt b/Documentation/devicetree/bindings/power/reset/twl6030-power.txt
> new file mode 100644
> index 000000000..946bb3d9f
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/power/reset/twl6030-power.txt
> @@ -0,0 +1,31 @@
> +Texas Instruments TWL family (twl6030) reset and power management module
> +
> +For now, the binding only supports the complete shutdown of the system after
> +poweroff.
> +
> +Required properties:
> +- compatible : must be
> +       "ti,twl6030-power"
> +
> +Optional properties:
> +
> +- ti,system-power-controller: This indicates that TWL6030 is the

We have a generic property for this.

> +  power supply master of the system. With this flag, the chip will
> +  initiate an ACTIVE-to-OFF or SLEEP-to-OFF transition when the
> +  system poweroffs.
> +
> +Example:
> +&i2c1 {
> +       clock-frequency = <2600000>;
> +
> +       twl: twl@48 {
> +               reg = <0x48>;
> +               interrupts = <7>; /* SYS_NIRQ cascaded to intc */
> +               interrupt-parent = <&intc>;
> +
> +               twl_power: power {
> +                       compatible = "ti,twl6030-power";
> +                       ti,system-power-controller;

Why do you need a child node here? There aren't any resources for the 
sub-block.

Rob
