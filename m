Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BFB9957BC61
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Jul 2022 19:11:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234325AbiGTRLf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Jul 2022 13:11:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229552AbiGTRLd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jul 2022 13:11:33 -0400
Received: from mail-lj1-x232.google.com (mail-lj1-x232.google.com [IPv6:2a00:1450:4864:20::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 854954B4AA
        for <linux-kernel@vger.kernel.org>; Wed, 20 Jul 2022 10:11:32 -0700 (PDT)
Received: by mail-lj1-x232.google.com with SMTP id u14so13876642lju.0
        for <linux-kernel@vger.kernel.org>; Wed, 20 Jul 2022 10:11:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=5lmHob9Luoc/cXzJquW++NsCeK2hCMlRzDN8YwkRgeA=;
        b=jvZ+h4TFU0W3bVQR1pDxqWqH0Bb9eP0bFR84YBTzcgHM411q2Q0eY0vXWSmgaxIh1F
         Ex8m4hTCbcxMROxTnPOjyDHd4KbBTiIPzR9O8Di4XP1renI38WiJ/dcFCnlI3R0VmiCH
         G4yVm2XHQr1ZkferHjxGFFy0F+7iezeUOtFsRh7WPHfvhJYlTEY274+1dV195qrtIbuP
         i/U4gK0oM9dky2zuAAMG73TWaQFF6y6HNevjzOhjMDCs25dthUnac13z9lHcwuIzRYel
         6VLy70TlqpYOosA2Wj5FMWxWq5w+4jrTgEJx+myBDVyK6YUN2vsQzDaRX9cq89AgiCPB
         n/dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=5lmHob9Luoc/cXzJquW++NsCeK2hCMlRzDN8YwkRgeA=;
        b=yqCrPJGB8H9CsyflrQTB3hLhbSdz89xvhn/g7uKlEw71g2ilrnqh7d9lLpZ4idRsis
         8dOfskQybn0ZlZZOZjwKz0uyd6HTBc8m+q2K+8dL7kihDgN/eA8B6JPgl/ZUYTo5t5Cd
         Y/YlfS7y6n0QyMJeoxANU9ieL4wWV7tVtSs+mwvtOm9373FFddzezYlvTUSliUDhBKdI
         cTaLkBMUDgPSfnSeL5aKnIS++95UKSzdBj/+Ki3dhW4VErtr84+tJVmfSvFO0Bmg0niJ
         /JtBUyeNqs6YdF+iN8QKg/5UdLUf0b+Kjs7XHbWIvuDE+Tk6lgWs26bc58WJwqnsyHlE
         FecA==
X-Gm-Message-State: AJIora+CEy7NS0hdzfgpUzVFNs/zusbTUMsamXv5NvyFTawXWDSnf8Gb
        sYmfi2FWyNGPJ3ZI/leV7gPIXQ==
X-Google-Smtp-Source: AGRyM1vm+804neFdMYoD9qGgWYMR4sru/4qnJWGHt6k7KPSzC5ItpHv15kOlKjl3to+hIqfJXh4kKQ==
X-Received: by 2002:a05:651c:b11:b0:25d:6a40:4ad3 with SMTP id b17-20020a05651c0b1100b0025d6a404ad3mr16839579ljr.349.1658337090842;
        Wed, 20 Jul 2022 10:11:30 -0700 (PDT)
Received: from [192.168.115.193] (89-162-31-138.fiber.signal.no. [89.162.31.138])
        by smtp.gmail.com with ESMTPSA id q7-20020a056512210700b00489dfb5d622sm1031425lfr.257.2022.07.20.10.11.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 20 Jul 2022 10:11:30 -0700 (PDT)
Message-ID: <8bc1d085-eb81-c50c-ec66-3f0a621a9a9c@linaro.org>
Date:   Wed, 20 Jul 2022 19:11:29 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v2 3/3] arm64: dts: sm2s-imx8mp: Add device trees for MSC
 SM2S-IMX8PLUS SoM and carrier board
Content-Language: en-US
To:     Martyn Welch <martyn.welch@collabora.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>
Cc:     kernel@collabora.com, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
References: <20220720150007.2168051-1-martyn.welch@collabora.com>
 <20220720150007.2168051-3-martyn.welch@collabora.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220720150007.2168051-3-martyn.welch@collabora.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 20/07/2022 17:00, Martyn Welch wrote:
> Add device trees for one of a number of MSCs variants of the SM2S-IMX8PLUS
> system on module along with the compatible SM2S-SK-AL-EP1 carrier board.
> As the name suggests, this family of SoMs use the NXP i.MX8MP SoC and
> provide the SMARC module interface.
> 
> Signed-off-by: Martyn Welch <martyn.welch@collabora.com>> ---
> 
> Changes in v2
>   - Added compatibles
>   - Removed underscores from node names
>   - Make node names more generic
>   - Reorder properties
>   - Fix issues found by dtbs_check in these files
> 
>  arch/arm64/boot/dts/freescale/Makefile        |   1 +
>  .../freescale/imx8mp-msc-sm2s-14N0600E.dts    |  72 ++
>  .../dts/freescale/imx8mp-msc-sm2s-ep1.dts     |  52 ++

Subject prefix is somehow reversed. sm2s is not a SoC.

arm64: dts: imx8mp-msc-sm2s:

Rest looks ok, except the discussion about actual company prefix.

Best regards,
Krzysztof
