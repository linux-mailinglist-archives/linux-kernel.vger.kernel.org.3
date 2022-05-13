Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 65047525D4D
	for <lists+linux-kernel@lfdr.de>; Fri, 13 May 2022 10:24:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378142AbiEMIRN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 May 2022 04:17:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378134AbiEMIRC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 May 2022 04:17:02 -0400
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A77563A1A1
        for <linux-kernel@vger.kernel.org>; Fri, 13 May 2022 01:17:00 -0700 (PDT)
Received: by mail-wr1-x432.google.com with SMTP id m1so10355249wrb.8
        for <linux-kernel@vger.kernel.org>; Fri, 13 May 2022 01:17:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=E7D8l5bVzLOBk8glw4ZVZyTSYXIEv02i6LMHubHx3+c=;
        b=BMpOYKIbjITGMPDLK4+XF/wtpBD5jNYwfjCRy8yHy1ozHKyeuJbU6kQvZAAKu6hj8z
         oMegYQIy+i7PSLhuuzBlE+38Gsw/tsu6NkGhyJI3s7Ye0V+5JeOZsr9rFylGqQsD1/ro
         lWuv+SjRLWQQvrMCMsD520k7jjNKqdAuzrhlYyGXDMLEZ9abzF8IL6IGLArUiarQBuSq
         dKQ797Q696/3udZ6UZnXmKBhwjzV3tO+n3LiT7MnHzp6HY+61h1nktKZ6V7Heq1H80xI
         hAmMMoB6QBLBzHh7QM4j9bUtFceOPR9O3mLB1Wmk+9VZEq85peGrrzc9lUEgec3TKFsO
         VbRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=E7D8l5bVzLOBk8glw4ZVZyTSYXIEv02i6LMHubHx3+c=;
        b=RDUO+NB6K4jUpmEIaV0IJR2D7TKVdeATarAsOPDfBtAU66w49E3B7rmYCCzYxfd60h
         fsE2RLrcvcm35VbDvUOLdmIIXzuGppRc83UatAQKWb+JWwBDp23gsp0qXtV5mwOLnhgg
         jtGUByhcGLg8PQiqVCoI8dinaB14fuyW4xGAVe0qzH1y8wasNADb26yI+nMFIuS/O5Kf
         GSLsJ0YyizHKEHmotx4QuysZfvk9ldlAtIEXAMIH3tRL4KEzvbsyWMhawcEP1pyU/RAO
         aDHY1URPNARgMCSACuRIcHaBAE3Xu/dXOUQSXT6WM2pVMAat4YmHsyAr7afVZBx6oT1Z
         Xemw==
X-Gm-Message-State: AOAM532SOc7vIXdyLqRtgxUeIx4r7BX5RjAdSpugeM4gjQYJahYiGTvH
        fb6oTPL/nkXHdAvJ84u4NUCjXK8Xfya9ELBA
X-Google-Smtp-Source: ABdhPJzRH+K5Zq0s4HK/uVoQ35ZSyLWacT5PSl/3qhGFUDklo2MdHx4nnrs5uXgifP6P4+MOjKc4ug==
X-Received: by 2002:a5d:45d0:0:b0:20c:b378:c492 with SMTP id b16-20020a5d45d0000000b0020cb378c492mr2960743wrs.188.1652429819296;
        Fri, 13 May 2022 01:16:59 -0700 (PDT)
Received: from [192.168.0.168] (xdsl-188-155-176-92.adslplus.ch. [188.155.176.92])
        by smtp.gmail.com with ESMTPSA id bh8-20020a05600c3d0800b003942a244f45sm5084637wmb.30.2022.05.13.01.16.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 13 May 2022 01:16:58 -0700 (PDT)
Message-ID: <dce77726-460d-1b85-0c96-e8148751e261@linaro.org>
Date:   Fri, 13 May 2022 10:16:57 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [PATCH v2 1/5] dt-bindings: proximity: vl53l0x: Document optional
 supply and GPIO properties
Content-Language: en-US
To:     Markuss Broks <markuss.broks@gmail.com>,
        linux-kernel@vger.kernel.org
Cc:     ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@somainline.org>,
        Song Qiang <songqiang1304521@gmail.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org
References: <20220511214718.50879-1-markuss.broks@gmail.com>
 <20220511214718.50879-2-markuss.broks@gmail.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220511214718.50879-2-markuss.broks@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/05/2022 23:47, Markuss Broks wrote:
> This patch adds the optional properties for the VL53L0X ToF sensor to the
> device-tree binding.

No "this patch":
https://elixir.bootlin.com/linux/v5.17.1/source/Documentation/process/submitting-patches.rst#L95

> 
> Signed-off-by: Markuss Broks <markuss.broks@gmail.com>
> ---
>  .../devicetree/bindings/iio/proximity/st,vl53l0x.yaml        | 5 +++++
>  1 file changed, 5 insertions(+)


Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof
