Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 670BA5A9CD3
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Sep 2022 18:16:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234996AbiIAQOv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Sep 2022 12:14:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235000AbiIAQOj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Sep 2022 12:14:39 -0400
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com [IPv6:2a00:1450:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E39EE93510
        for <linux-kernel@vger.kernel.org>; Thu,  1 Sep 2022 09:14:37 -0700 (PDT)
Received: by mail-lf1-x130.google.com with SMTP id p16so7132759lfd.6
        for <linux-kernel@vger.kernel.org>; Thu, 01 Sep 2022 09:14:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc;
        bh=oM5Ezf93shH3kTZ/vWZom8C9aO4D37NWLp1m2av/9KE=;
        b=weJDobI4VZLlQOv2NmBusEwHliBx35A0mbIaFjUlAYWNEroUGOQ8uthHHliuu7BU8p
         b+KkC1eXTODjP+yuFhR/dK5ZRTcFfygCZR1bMaH8t9B7bCXYJUsBhtAdMNY8OQXzZLqr
         yOqF000XGvlGs2gwcW1w8bEFYaE7b033v7/966gK1virFXNzIp7cdlwLUysFMGdPpqH0
         yloNo0s3Q4YiKAeTShZ8bszaujCDsORpn8fMuagniFsviVOlkajOSHZo02qFPvynefB9
         BbgW9UAL4Ccn4FZRR6LQYxUzNiE0P802zOAWfiUztoFcBaktOnN9aJ4sq6SvhnJtCe9l
         /ykw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc;
        bh=oM5Ezf93shH3kTZ/vWZom8C9aO4D37NWLp1m2av/9KE=;
        b=2nJ1VT1JcWUy5y8WGLJli2+n9vgjo4+kI8DeKY6BBT2+QIQ9W+MNycKJCZ/VNcXH03
         5DtO6icT6V781K374k/kUUlv7NgHaDxZCaBcFHuYeR813YG74GuiSZr6oWzzQ5oZMCp0
         mkuZt/L9ft/V5SXP8/aiYb1aY27KMcsla0BxUI1a8M2+h5SZ/frH2l7ubYueyAtHUw2p
         Fv3zXBqAZsARlB/N+GeYexOBJLy77Ul8/zHtS0xLt54xQ2n8tWgQD/A3N5hK1noSrt6K
         aOC6W8E1FZOrZuhrbDdiSepnpV+oHyHNygB4Czz5uwEWd6HTAHtQI66P34SbEhuvvOw2
         Ateg==
X-Gm-Message-State: ACgBeo1iFEFdTHJ3TUw5OktA5le2upSQn7NhSde4mO80ItQqkQp09YSR
        70hACrn+0rMpovW1vzFpFSJoDg==
X-Google-Smtp-Source: AA6agR7mFWuOJgz07cAbY8XAhBR6s/+8zDbJ48LhLiRZk/NLUAK+9mIF34+dj5dbwMX4aTNNI+016w==
X-Received: by 2002:a05:6512:3b23:b0:492:b36c:acab with SMTP id f35-20020a0565123b2300b00492b36cacabmr11580881lfv.157.1662048876214;
        Thu, 01 Sep 2022 09:14:36 -0700 (PDT)
Received: from [192.168.28.124] (balticom-73-99-134.balticom.lv. [109.73.99.134])
        by smtp.gmail.com with ESMTPSA id t24-20020a056512209800b0049490b3bb46sm78580lfr.36.2022.09.01.09.14.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 01 Sep 2022 09:14:35 -0700 (PDT)
Message-ID: <df07db67-e710-389a-ba9a-903c6855397b@linaro.org>
Date:   Thu, 1 Sep 2022 19:14:34 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.0
Subject: Re: [PATCH 11/14] dt-bindings: arm: cpus: Add kryo240 compatible
Content-Language: en-US
To:     Iskren Chernev <iskren.chernev@gmail.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>
Cc:     phone-devel@vger.kernel.org, ~postmarketos/upstreaming@lists.sr.ht,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Vinod Koul <vkoul@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Stephan Gerhold <stephan.gerhold@kernkonzept.com>,
        Luca Weiss <luca@z3ntu.xyz>, Maxime Ripard <maxime@cerno.tech>,
        Bartosz Dudziak <bartosz.dudziak@snejp.pl>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        linux-kernel@vger.kernel.org
References: <20220901072414.1923075-1-iskren.chernev@gmail.com>
 <20220901072414.1923075-12-iskren.chernev@gmail.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220901072414.1923075-12-iskren.chernev@gmail.com>
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

On 01/09/2022 10:24, Iskren Chernev wrote:
> Kryo240 is found in SM4250, the slower sibling of the SM6115.
> 
> Signed-off-by: Iskren Chernev <iskren.chernev@gmail.com>
> ---
>  Documentation/devicetree/bindings/arm/cpus.yaml | 1 +


Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>


Best regards,
Krzysztof
