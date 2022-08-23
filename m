Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 55FCC59CCB1
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Aug 2022 02:02:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238733AbiHWABu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Aug 2022 20:01:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238567AbiHWABr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Aug 2022 20:01:47 -0400
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39C5156BBD;
        Mon, 22 Aug 2022 17:01:46 -0700 (PDT)
Received: by mail-wr1-x429.google.com with SMTP id h24so15069120wrb.8;
        Mon, 22 Aug 2022 17:01:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=jms.id.au; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=3umAISoMC9J1t3BQnQeJGoOxGoRbwjWe7DCguBppyoc=;
        b=Zeg6Kz2RJM9iX7KdwqBfkrJ5XtKSu2WYnnXIK1wVEw6q5cJlmZRYnZmGaxQoQolmB1
         WFEmQxnNAd5pgsCMkCvaA19L2kXw/pcag7CNE0jvQnuEcl0/ariluL27G0EGMk9xndBK
         E7Ugqd9OhUioYRXzvSqZhJ1KVGA6xhDo+Cy/Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=3umAISoMC9J1t3BQnQeJGoOxGoRbwjWe7DCguBppyoc=;
        b=GHVXXX+LTl6fU+iWKyfXN7O/72TFmDNuk4hnJ+TMwUlSZb4hf+LkBCMyxs61tCnqXT
         sJ+7xeuhkgIwtARlG07xz+s049m8DsocdnTR3mBgKbhXAfSf4pOI1yLO9OJoKcOux/fF
         1sBBxYswbGRBy6mb9+rDmYoP3C/2WWrKzPHgO1Dxu6az22h7nwHa6koADqo+vfYppEu4
         ElocdalDxFkltB3XQzBx79rM1wGi3yrNzRB7QSzRKB5xjjwbvqjsP2KBTznmprWTyYwM
         Jxdn+FLTMLJRCZBOPxgMDi5XhaftQkz3z4D+8B6KQWcGMcgZ85wJHydK+6pTyrL6ePI8
         wLdw==
X-Gm-Message-State: ACgBeo06pLVVwqcT60TEUOW33ewYLTX42JqKpgDb0ifdQx7LPbgxD1Jb
        H7fXNnh3ilAp2rHsyafTsMn/qaJB2d0skusMqgoEFWLY
X-Google-Smtp-Source: AA6agR6mr3WZ/vgmSGJDMvRNbfbSeY+27SFUtG2f01EaGpn62xeLlnirjZG+tWS0fwnTFBEaCEPEd5gkEGvVWU+bFfc=
X-Received: by 2002:a05:6000:1c0c:b0:225:569c:dd2c with SMTP id
 ba12-20020a0560001c0c00b00225569cdd2cmr4445061wrb.628.1661212904633; Mon, 22
 Aug 2022 17:01:44 -0700 (PDT)
MIME-Version: 1.0
References: <20220822070204.GA6110@hcl-ThinkPad-T495>
In-Reply-To: <20220822070204.GA6110@hcl-ThinkPad-T495>
From:   Joel Stanley <joel@jms.id.au>
Date:   Tue, 23 Aug 2022 00:01:32 +0000
Message-ID: <CACPK8XfgYma8=qV0kKOKSSpXprC1sBZgKuaGsAhD1ifYG4KgTw@mail.gmail.com>
Subject: Re: [PATCH v1] ARM: dts: aspeed: Update for Facebook Yosemite V2 BMC
To:     Karthikeyan Pasupathi <pkarthikeyan1509@gmail.com>
Cc:     Rob Herring <robh+dt@kernel.org>, Andrew Jeffery <andrew@aj.id.au>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        openbmc@lists.ozlabs.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,WEIRD_QUOTING autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 22 Aug 2022 at 07:02, Karthikeyan Pasupathi
<pkarthikeyan1509@gmail.com> wrote:
>
> This patch includes the following updates for Yosemite V2
> BMC.
>
> 1) Updated GPIO configuration for power control.

Please take a look the openbmc naming conventions for the GPIOs. If
you are not going to follow them, please explain why in your commit
message.


> 2) Added IPMB-13 channel for Debug Card communication.
> 3) Removed EEPROM driver IPMB-12 channel and keeping it as
>    "status ok".

If you find yourself writing a commit log that contains 1), 2), 3)
then there's a fair chance you could have sent three separate patches.
Consider this for next time.

>
> Signed-off-by: Karthikeyan Pasupathi <pkarthikeyan1509@gmail.com>
> ---
>  .../dts/aspeed-bmc-facebook-yosemitev2.dts    | 49 +++++++++++++++++--
>  1 file changed, 44 insertions(+), 5 deletions(-)
>
> diff --git a/arch/arm/boot/dts/aspeed-bmc-facebook-yosemitev2.dts b/arch/arm/boot/dts/aspeed-bmc-facebook-yosemitev2.dts
> index 8864e9c312a8..4d2ff7eb6740 100644
> --- a/arch/arm/boot/dts/aspeed-bmc-facebook-yosemitev2.dts
> +++ b/arch/arm/boot/dts/aspeed-bmc-facebook-yosemitev2.dts
> @@ -119,6 +119,40 @@
>                         &pinctrl_adc15_default>;
>  };
>
> +&gpio {
> +       status = "okay";
> +       gpio-line-names =
> +       /*A0-A7*/   "","","","","","","","",
> +       /*B0-B7*/   "","","","","","","","",
> +       /*C0-C7*/   "","","","","","","","",
> +       /*D0-D7*/   "POWER_BUTTON","POWER_OUT1","","POWER_OUT2","","POWER_OUT3","","POWER_OUT4",
> +       /*E0-E7*/   "DEBUG_UART_SEL0","DEBUG_UART_SEL1","DEBUG_UART_SEL2","DEBUG_UART_RX_SEL_N","","","","",
> +       /*F0-F7*/   "","","","","","","","",
> +       /*G0-G7*/   "LED_POST_CODE_0","LED_POST_CODE_1","LED_POST_CODE_2","LED_POST_CODE_3","","","","",
> +       /*H0-H7*/   "","","","","","","","",
> +       /*I0-I7*/   "SLOT1_POWER_OK","SLOT2_POWER_OK","SLOT3_POWER_OK","SLOT4_POWER_OK","","","","",
> +       /*J0-J7*/   "","","","","","","","",
> +       /*K0-K7*/   "","","","","","","","",
> +       /*L0-L7*/   "","","","","","","","",
> +       /*M0-M7*/   "","","","","","","","",
> +       /*N0-N7*/   "","","I2C_SLOT1","I2C_SLOT2","I2C_SLOT3","I2C_SLOT4","","",
> +       /*O0-O7*/   "","","","SELECTOR_BUTTON","SLOT1_POWER","SLOT2_POWER","SLOT3_POWER","SLOT4_POWER",
> +       /*P0-P7*/   "","","","","LED_POST_CODE_4","LED_POST_CODE_5","LED_POST_CODE_6","LED_POST_CODE_7",
> +       /*Q0-Q7*/   "","","","","","","","",
> +       /*R0-R7*/   "","","","GPIO_DBG_CARD_PRSNT","","","","",
> +       /*S0-S7*/   "RESET_OUT1","RESET_OUT2","RESET_OUT3","RESET_OUT4","","","","",
> +       /*T0-T7*/   "","","","","","","","",
> +       /*U0-U7*/   "","","","","","","","",
> +       /*V0-V7*/   "","","","","","","","",
> +       /*W0-W7*/   "","","","","","","","",
> +       /*X0-X7*/   "","","","","","","","",
> +       /*Y0-Y7*/   "","","","","","","","",
> +       /*Z0-Z7*/   "POST_COMPLETE","POST_COMPLETE2","POST_COMPLETE3","POST_COMPLETE4","","","","",
> +       /*AA0-AA7*/ "","","","","HAND_SW1","HAND_SW2","HAND_SW3","HAND_SW4",
> +       /*AB0-AB7*/ "RESET_BUTTON","","","","","","","",
> +               /*AC0-AC7*/ "","","","","","","","";
> +};
> +
>  &i2c1 {
>         //Host1 IPMB bus
>         status = "okay";
> @@ -207,11 +241,16 @@
>
>  &i2c12 {
>         status = "okay";
> -       //MEZZ_FRU
> -       eeprom@51 {
> -               compatible = "atmel,24c64";
> -               reg = <0x51>;
> -               pagesize = <32>;
> +};
> +
> +&i2c13 {
> +       status = "okay";
> +       // Debug Card
> +       multi-master;
> +       ipmb13@10 {
> +               compatible = "ipmb-dev";
> +               reg = <(0x10 | I2C_OWN_SLAVE_ADDRESS)>;
> +               i2c-protocol;
>         };
>  };
>
> --
> 2.17.1
>
