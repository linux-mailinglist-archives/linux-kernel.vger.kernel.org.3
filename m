Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 52F3B50C926
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Apr 2022 12:21:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234888AbiDWKXd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 23 Apr 2022 06:23:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233592AbiDWKX1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Apr 2022 06:23:27 -0400
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15C291B89D9
        for <linux-kernel@vger.kernel.org>; Sat, 23 Apr 2022 03:20:29 -0700 (PDT)
Received: by mail-ej1-x62b.google.com with SMTP id bv19so20741863ejb.6
        for <linux-kernel@vger.kernel.org>; Sat, 23 Apr 2022 03:20:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=wFau58/3dbFFXW5s/rSRyjR0Vv6vq15uvojLlFyaWYw=;
        b=VdBeLuXQeTfZ0WLS8qcex/zqFzDuiG8Txkpzd9okBbMJ4TgfIsIFJmbW7Tf99SDUoQ
         jDozl0XWC7OEZ6qTd1JLMPr6dl6mvilBQdyKEKzH8OW9agDsvPmBN5W6j283532gx1nQ
         MKdbMzmYHmf9+1S/2AXVdz8polAsDE+i7Og35b7TDRH84FLh0oABC4bn10uokB4GMmXr
         RJ9baprrI9l2mL35Yor4CqdnWDHYtm78mZu5PaX7vEJexhH80EuAKtL1Vrnb0VpEpI1d
         C61sPiiOwt1ZnMr75JCXwE6BBhUAsRrwaaW2u+lfmaMFzb7HvaMkm468iZIi0KV+yeZW
         ryyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=wFau58/3dbFFXW5s/rSRyjR0Vv6vq15uvojLlFyaWYw=;
        b=2obR/UTfNMmGTU0T3nIAkfBYmo0x8HPT78UzSehMY45AXaY7bnoVwwwqtfzi1ayMm2
         HlU2ftazQyzSjTTOUz/ymDeaX1msnj2grBr/SMuYGy0+2oBAip4BrOJOsImJz+uxINmO
         ZTZWFR26bGuk0JlxULMO4cXuLUuo5idTjD4YV3uYjvp4neBcRks1Dk9/ALoAOHXPNbGP
         fVak55AksdGa6QPMIL0S/Tcq9m4ySi9uwqzeoN4gIf57NU5kJPdIkz+Qwj+DQZXDaMTP
         e7lrGckkstVriE3NHITXdWI4iLO5G2N+jGYpnwGKgFVCfNnbu+s+QgYJU/oGSGqcYre3
         LcUw==
X-Gm-Message-State: AOAM5307MbLFI5DR7ZIdrNk8UBzT1+gtGQupGx0cND/qMxgiwvNh4igE
        4c+JSCxsSUNsF217/UTpFKO+YQ==
X-Google-Smtp-Source: ABdhPJyHlCCVCTAtns0efc4iZ7S75fDASI52u/P1Kc0Vy4D6sBJpiZ7iYAysEriC5MzcgajCOpK+XA==
X-Received: by 2002:a17:907:9721:b0:6f3:806c:b9f4 with SMTP id jg33-20020a170907972100b006f3806cb9f4mr119631ejc.462.1650709227598;
        Sat, 23 Apr 2022 03:20:27 -0700 (PDT)
Received: from [192.168.0.234] (xdsl-188-155-176-92.adslplus.ch. [188.155.176.92])
        by smtp.gmail.com with ESMTPSA id g9-20020aa7c849000000b00412fc6bf26dsm2063437edt.80.2022.04.23.03.20.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 23 Apr 2022 03:20:27 -0700 (PDT)
Message-ID: <ad62836d-b66f-8423-8c9a-c3b9f90e0add@linaro.org>
Date:   Sat, 23 Apr 2022 12:20:26 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH] dt-bindings: fsl: convert fsl,layerscape-dcfg to YAML
Content-Language: en-US
To:     Michael Walle <michael@walle.cc>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     Li Yang <leoyang.li@nxp.com>, Shawn Guo <shawnguo@kernel.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20220421153044.3496643-1-michael@walle.cc>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220421153044.3496643-1-michael@walle.cc>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 21/04/2022 17:30, Michael Walle wrote:
> Convert the fsl,layerscape-dcfg binding to the new YAML format.
> 
> One thing added here, compared to the original binding, is the clock
> controller subnode of the LS1028A SoC and its "simple-mfd" compatible as
> used in arch/arm64/boot/dts/freescale/fsl-ls1028a.dtsi as well as the
> little-endian and big-endian properties.
> 
> Signed-off-by: Michael Walle <michael@walle.cc>
> ---
>  .../arm/freescale/fsl,layerscape-dcfg.txt     | 19 ------
>  .../arm/freescale/fsl,layerscape-dcfg.yaml    | 68 +++++++++++++++++++
>  2 files changed, 68 insertions(+), 19 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/arm/freescale/fsl,layerscape-dcfg.txt
>  create mode 100644 Documentation/devicetree/bindings/arm/freescale/fsl,layerscape-dcfg.yaml

Same comments as for scfg (move to soc, generic node name, reference
clock controller schema, mention adding syscon in commit msg).

Best regards,
Krzysztof
