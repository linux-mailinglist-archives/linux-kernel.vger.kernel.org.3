Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CD8C15680D6
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Jul 2022 10:12:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230362AbiGFILe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Jul 2022 04:11:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230320AbiGFILa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jul 2022 04:11:30 -0400
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4CCB1A826
        for <linux-kernel@vger.kernel.org>; Wed,  6 Jul 2022 01:11:29 -0700 (PDT)
Received: by mail-lf1-x136.google.com with SMTP id f14so1853628lfl.11
        for <linux-kernel@vger.kernel.org>; Wed, 06 Jul 2022 01:11:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :references:from:in-reply-to:content-transfer-encoding;
        bh=//Wve8Vbl5PTf5tJRIXO2kzf8wNGcoLhwVulheQXyOU=;
        b=LNcEnNeMNFE/LDH8MFtmsbHTyPjOWyDKysEJ5isHf11XzkfopkPZwNMpVpOFs6Zioj
         2PBGWNAd198pY1N8bzEy4Nmv71YjxQlvwhhYLEVqqORvz+43tikd+QwTpe7YL8+sc4sa
         z06SwSAn7vU0jmnGgucCGNFgA/Hj1ih5Ri5DL+Svf/kItjsxPaQWSS6UtQl0dyLLOd7+
         NkjlLSWEWErtKl5PPnGqVvbGMtM7HFTfOna7zL1wO69hrGtTvGEMFdzl9CeokamcryzO
         iKqth/yOw8DTF50nuvw44cOcF/uG57YOSjoT/dGy/HI8yU5cPW4o0XGUIQxHozXXLQx1
         cMvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:references:from:in-reply-to
         :content-transfer-encoding;
        bh=//Wve8Vbl5PTf5tJRIXO2kzf8wNGcoLhwVulheQXyOU=;
        b=wVgDxXZ6DNPgQ2wSONPEZRpyHjcaP8j+blvoN+V7TbPhbrYb9aGzGc2zmgQQL5Ha/T
         9Rkm7MWuiKizCcC2gJMg0aOxwQIO5PsAZoCg3teNSnPgEAljk0oZLOo9OSSJ/R5OGNbq
         eky/cpldFfXHDOarY6nRYTZ6l3HhduGs9gbUx+wMf1cRrJkFh8NICA/8sRpTM6PJ7+0Z
         70PwcdHgaHsCCuHtaVoOmAv+U3G/B50WuTRh0ICU2lLF5fc+lmihjXCuAzbA+qFaxC4D
         9rm62rkH7K/eyMTm3w576uAdU0kZNwM75sBbv4qm7UQQUfnVEUvSaInsZrC/hYrCXz4L
         665Q==
X-Gm-Message-State: AJIora92lyQ1j+dBbT57j4epprSKdkrPyRHgi1fvoGOeU3uQY4LGF5RQ
        VuYw7jjuEQXx/VT4e2Ys4cGV6g==
X-Google-Smtp-Source: AGRyM1teb0Jwpi+7mcfImlBcAtTZe/ejOFebacBhbJe0cSZGeSZfTCzb0oH3T2scWxSORC2CWsdAZw==
X-Received: by 2002:a05:6512:2813:b0:47f:bdd9:b207 with SMTP id cf19-20020a056512281300b0047fbdd9b207mr25560090lfb.679.1657095087974;
        Wed, 06 Jul 2022 01:11:27 -0700 (PDT)
Received: from [192.168.1.52] ([84.20.121.239])
        by smtp.gmail.com with ESMTPSA id u16-20020a05651220d000b00478ea0e4f66sm6146625lfr.169.2022.07.06.01.11.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 06 Jul 2022 01:11:27 -0700 (PDT)
Message-ID: <86ce5523-ca63-73e5-33a3-a2d7fb9d407e@linaro.org>
Date:   Wed, 6 Jul 2022 10:11:26 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v6 01/12] dt-bindings: mfd: qcom-spmi-pmic: add support
 for PMP8074
Content-Language: en-US
To:     Robert Marko <robimarko@gmail.com>, agross@kernel.org,
        bjorn.andersson@linaro.org, konrad.dybcio@somainline.org,
        lee.jones@linaro.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, linus.walleij@linaro.org,
        lgirdwood@gmail.com, broonie@kernel.org, jic23@kernel.org,
        lars@metafoo.de, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-gpio@vger.kernel.org, linux-iio@vger.kernel.org
References: <20220704212402.1715182-1-robimarko@gmail.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220704212402.1715182-1-robimarko@gmail.com>
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

On 04/07/2022 23:23, Robert Marko wrote:
> Document compatible for the PMP8074 PMIC.
> 
> I planned to convert the bindings to dtschema, but there is already a
> patch to do so [1].
> I will make a patch to add the compatible to dtschema once it gets
> accepted.
> 
> [1] https://lore.kernel.org/linux-arm-msm/20220626191630.176835-1-david@ixit.cz/

These explanations should go after '---', there is no need to store it
in commit log.

With the change:

Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>


Best regards,
Krzysztof
