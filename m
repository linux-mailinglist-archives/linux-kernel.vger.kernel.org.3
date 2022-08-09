Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BC6E258DB6A
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Aug 2022 17:55:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243623AbiHIPzo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Aug 2022 11:55:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241197AbiHIPzh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Aug 2022 11:55:37 -0400
Received: from mail-lj1-x22a.google.com (mail-lj1-x22a.google.com [IPv6:2a00:1450:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A796910FB
        for <linux-kernel@vger.kernel.org>; Tue,  9 Aug 2022 08:55:35 -0700 (PDT)
Received: by mail-lj1-x22a.google.com with SMTP id y23so13389014ljh.12
        for <linux-kernel@vger.kernel.org>; Tue, 09 Aug 2022 08:55:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=knhcb7iVeCM7IT/bFale8KOMlb48oitRCQ5KBCVX1Yw=;
        b=eHxYQqWLDYxZlKnzuCCELTxRQzvGRkiHRDGuTSYqln/ksMEK7+rA/MEo4h29qI1nWn
         aaGpBP3r9DDB9RCVgc82GmZj+mGY6T3udoSr/7ouTAjE6GZ4iPoXL2LZPZgMeg7NOcrP
         AB6hyT4m6R3Io0U/U00s3J1bxoBh8wDgDMVfc9kyt7RzcgvPXYxzPc3TAFeOKran2DfJ
         Xh8B7hfaCsQjKww39hzLExjsOOMJGLCcTJWcrmr2e07Iv55To/CtFz5/CRdFLQEbTp/D
         LfYt7R2gN2wKAtmJTzF7RXztcUjirQ/BeAe0zuRL3CY9sDPAnldAG0gVf/ZtwLo8ykZ6
         NPBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=knhcb7iVeCM7IT/bFale8KOMlb48oitRCQ5KBCVX1Yw=;
        b=NsF1bP45TQSHXj25pN3qktSHCn4o0Yr/CyTT8WQGR39b1Gemh/ZuKt81RCKPYFV+OB
         n7w3//f26kUv6Y2qB6t/rGf3FsUx+q8ge0yKAnAC9mTyCmjWK0dGpt/Eo8ymI9UyGZVy
         cDcWHaesZvG4hc4Eu5WQUKU2HAkZfe2jU/8w4aBShPcYB1DC8yGOrRA6Cm+nGWxSGo8N
         Bec0UoKAi09oO5sSfRGRa8UKEWcgJsHlaWym2DO3KV3Ota+G+/DnrAl5mXZFJCwcU4LU
         AWEHFaZebQWoxkvsoVFcMc9oNaZKha+V4V0Atf0WiGygskp9TJgXOzIAZV3yzTbkOguz
         EIvw==
X-Gm-Message-State: ACgBeo21eKw5jZ6+R59c6T+rTsCjpXF1grMGsCRXaCY4ZxMIY2QNm6Lv
        fU4TkwLcdOa9u+i+kXp1itIVqA==
X-Google-Smtp-Source: AA6agR6cIZxpEfLo85HVRpPrgrUWM7psNWrJqgvgks9BbMXLBr6B3ckHPwUkPV+2wVdlSKmK6GGiTg==
X-Received: by 2002:a05:651c:91:b0:25e:4418:4c20 with SMTP id 17-20020a05651c009100b0025e44184c20mr7695001ljq.131.1660060533980;
        Tue, 09 Aug 2022 08:55:33 -0700 (PDT)
Received: from [192.168.1.39] ([83.146.140.105])
        by smtp.gmail.com with ESMTPSA id s20-20020a056512215400b0048aea84fa80sm17731lfr.87.2022.08.09.08.55.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 09 Aug 2022 08:55:32 -0700 (PDT)
Message-ID: <2ac37c3e-fcb1-2e48-bc7b-549d745be1d9@linaro.org>
Date:   Tue, 9 Aug 2022 18:55:31 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Subject: Re: [PATCH 1/4] dt-bindings: arm: fsl: imx6ul-kontron: Update
 bindings
Content-Language: en-US
To:     Frieder Schrempf <frieder@fris.de>, devicetree@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-kernel@vger.kernel.org, Li Yang <leoyang.li@nxp.com>,
        Rob Herring <robh+dt@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>
Cc:     Frieder Schrempf <frieder.schrempf@kontron.de>,
        Alexander Stein <alexander.stein@ew.tq-group.com>,
        Denys Drozdov <denys.drozdov@toradex.com>,
        Fabio Estevam <festevam@denx.de>,
        Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        Marek Vasut <marex@denx.de>,
        Matthias Schiffer <matthias.schiffer@tq-group.com>,
        Max Krummenacher <max.krummenacher@toradex.com>,
        Rob Herring <robh@kernel.org>,
        Tim Harvey <tharvey@gateworks.com>
References: <20220809152534.292034-1-frieder@fris.de>
 <20220809152534.292034-2-frieder@fris.de>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220809152534.292034-2-frieder@fris.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09/08/2022 18:25, Frieder Schrempf wrote:
> From: Frieder Schrempf <frieder.schrempf@kontron.de>
> 
> This updates the bindings in order to simplify the devicetree
> structure and to add names for the boards that follow the latest
> convention used by Kontron marketing.
> 
> Signed-off-by: Frieder Schrempf <frieder.schrempf@kontron.de>
> ---
>  .../devicetree/bindings/arm/fsl.yaml          | 31 +++++++------------
>  1 file changed, 12 insertions(+), 19 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/arm/fsl.yaml b/Documentation/devicetree/bindings/arm/fsl.yaml
> index ef524378d449..7c4c27d553ec 100644
> --- a/Documentation/devicetree/bindings/arm/fsl.yaml
> +++ b/Documentation/devicetree/bindings/arm/fsl.yaml
> @@ -553,8 +553,7 @@ properties:
>                - engicam,imx6ul-isiot      # Engicam Is.IoT MX6UL eMMC/NAND Starter kit
>                - fsl,imx6ul-14x14-evk      # i.MX6 UltraLite 14x14 EVK Board
>                - karo,imx6ul-tx6ul         # Ka-Ro electronics TXUL-0010 Module
> -              - kontron,imx6ul-n6310-som  # Kontron N6310 SOM
> -              - kontron,imx6ul-n6311-som  # Kontron N6311 SOM
> +              - kontron,imx6ul-n631x-som  # Kontron SL i.MX6UL (N631X SOM)

Although board-level compatibles are not that important, yet still they
follow the same rules as other DT bindings: no wildcards for compatibles.

Therefore the change is not correct, in my opinion.

Best regards,
Krzysztof
