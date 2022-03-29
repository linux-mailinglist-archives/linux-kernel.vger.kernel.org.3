Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 826984EB0A6
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Mar 2022 17:30:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238741AbiC2Pbw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Mar 2022 11:31:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238662AbiC2PbU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Mar 2022 11:31:20 -0400
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 617151081A6
        for <linux-kernel@vger.kernel.org>; Tue, 29 Mar 2022 08:29:27 -0700 (PDT)
Received: by mail-ed1-x52b.google.com with SMTP id b24so21112709edu.10
        for <linux-kernel@vger.kernel.org>; Tue, 29 Mar 2022 08:29:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=IUZG8nVH/wwzYSRFhBM6Bw4xy9hGVC/KLREG9NrMP4M=;
        b=cjr33Kje+O/AXpHjsptuzskdm1/lrSk4O8oxogTwxmCCnv3srHLJbgdFoAdFwcrvfg
         +CBRCdDzPr6JsMufOO3PDmQ2Jmr2VCABDSyBC6z4jxSgjCXWTZoWnzT0Y+g8GCvMqG2M
         LQtwPKK67c/vQy0lL5B+Kq47R2uDWSXb1+PhtaSRsSggZ9aDqX8QE9x2SmgBqS7SJCSq
         3UFjnhuhd1POy4590PYxAq6ML3PPZeoUjCio3Zb7oynhuk7WNWCSniyExEVjWXRMTh69
         u8nVnY3OBbyl46z6Oqa2A7SuRZqf6KkMJ8ADI+sTaCzaNrhhjHedvL/lv43jnxrjuvxW
         JdAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=IUZG8nVH/wwzYSRFhBM6Bw4xy9hGVC/KLREG9NrMP4M=;
        b=ii/D8Wv7+50JPwDvfTjaQnLqYdAczSeENHyYTkIXTwnWnEjOeXqXN5ITgWKDLqMaew
         hlUqxDzGtjuoN6LHyEc7NWMzjcTGe4fVoEts/pC+f7yVAs99Wf+vP15f8HjqrW13FqzN
         +h71fpQpaMAh6It7XzjQy4ELa9gsvFYRDp7T6Rqx59IszgbTlNArcjCIe+VavJepjPlM
         P0QW2S/uU6Fjv3f/nTG1W2tpa41p9Sq0wZSE9MfaidJrfF9i4t6pALnD71D/0PJZ5F8B
         9731KuaA/x4HPC16v1A3OBAt+apWs1jCI2xIxkO/w53fdBDCr/to5uSGvFDpvhJk5VRD
         2Mig==
X-Gm-Message-State: AOAM533GGBYDV4UWG9BOZjqcwvYRW0FW/KiVcedozs2BJA2+ihHWRQfF
        cCMao6zt1D2+AReoa0ajQUEIrA==
X-Google-Smtp-Source: ABdhPJywjEH0hsTU2NFaukN9gPTvHZyJD2A7VAfgfWBig+OglKPC+QC42f4rDU+hm0oRiKkJ9d+IWg==
X-Received: by 2002:a50:c307:0:b0:418:ec3b:2242 with SMTP id a7-20020a50c307000000b00418ec3b2242mr5095016edb.229.1648567765601;
        Tue, 29 Mar 2022 08:29:25 -0700 (PDT)
Received: from [192.168.0.162] (xdsl-188-155-201-27.adslplus.ch. [188.155.201.27])
        by smtp.gmail.com with ESMTPSA id l9-20020a1709060cc900b006ce04bb8668sm7138848ejh.184.2022.03.29.08.29.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 29 Mar 2022 08:29:25 -0700 (PDT)
Message-ID: <c3e9fae5-8e18-a272-8a0e-9022f23903e3@linaro.org>
Date:   Tue, 29 Mar 2022 17:29:24 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH v2 3/6] dt-bindings: clock: use generic node name for
 pmucru example in rockchip, rk3399-cru.yaml
Content-Language: en-US
To:     Johan Jonker <jbx6244@gmail.com>, heiko@sntech.de,
        zhangqing@rock-chips.com
Cc:     robh+dt@kernel.org, krzk+dt@kernel.org, mturquette@baylibre.com,
        sboyd@kernel.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20220329150742.22093-1-jbx6244@gmail.com>
 <20220329150742.22093-3-jbx6244@gmail.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220329150742.22093-3-jbx6244@gmail.com>
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

On 29/03/2022 17:07, Johan Jonker wrote:
> The node names should be generic, so fix this for the pmucru node example
> in the rockchip,rk3399-cru.yaml file and rename it to "clock-controller".
> 
> Signed-off-by: Johan Jonker <jbx6244@gmail.com>
> ---
>  .../devicetree/bindings/clock/rockchip,rk3399-cru.yaml          | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/Documentation/devicetree/bindings/clock/rockchip,rk3399-cru.yaml b/Documentation/devicetree/bindings/clock/rockchip,rk3399-cru.yaml
> index 3cc8398fd..18a009311 100644
> --- a/Documentation/devicetree/bindings/clock/rockchip,rk3399-cru.yaml
> +++ b/Documentation/devicetree/bindings/clock/rockchip,rk3399-cru.yaml
> @@ -77,7 +77,7 @@ additionalProperties: false
>  


Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>


Best regards,
Krzysztof
