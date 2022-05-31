Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9E0DE538FFB
	for <lists+linux-kernel@lfdr.de>; Tue, 31 May 2022 13:45:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343886AbiEaLpK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 May 2022 07:45:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343875AbiEaLpI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 May 2022 07:45:08 -0400
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2A60880EA
        for <linux-kernel@vger.kernel.org>; Tue, 31 May 2022 04:45:06 -0700 (PDT)
Received: by mail-ed1-x530.google.com with SMTP id n28so8311061edb.9
        for <linux-kernel@vger.kernel.org>; Tue, 31 May 2022 04:45:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=O6+wiVWCxeTjduCZyyUvzxpHHklmrln6oj83M02p3Zo=;
        b=j449XP+PpAVAn2lL+V33btwaHS45cc2ztlQWFJJCsGN2eqWpJXmxFPDwjyvo98lQEy
         16+XE2Mf5EDFL/saHl/GkMdWDiDU47tW4qqWezPmabvg7/dSrFJLea4/OA3Ill36D7kR
         PVPP89/ymNhLxib/FBTYso8mOJ7mtmNpcF8ino8Cok7sXq1ey6V7Mf3Qry7WLwlILl0c
         vdOQRhOs5ONx7yB0e1pCuUkF+cOi8+3yd02PWa4Rza7Pwbno3s4OyhqD1M01h062yo98
         KexKgRkGR+LBmldwl+ulQpoCTTinm50svbIZPrMBIhJ02bOJsEfL6ZfPCOTBwrDkndw5
         IwcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=O6+wiVWCxeTjduCZyyUvzxpHHklmrln6oj83M02p3Zo=;
        b=qCST8mOtaK1xFuyJxQlZNWL8dGoTMzg+kvfJbp+3Z9tri2FH5dHKnn/SiJlIy9zq86
         RWyirs7I1uGgZA4QbXnX/Oo3EwZL8aW5BV8Ek/zn8skg4frnOKWpsc3hEwD9YNbab2bk
         Ahu6ZqXCjN0KKmvuJ1wdogfuj+OUJCC6Pbelx1CeYhI/cJnQojRjj0ePJ4d96hpaxmuV
         7jVJexhdNCri6YTtaavsKQopWnMTcmpEWDnSq7mU8M/lB8mtpWcgDarZK5qQfTrrCdqV
         YKy4FccYINXfxUskolml9CkoH+iGdox3tHN8KXTs4uMnqbWWFtudy1hMngzAe2LR33cM
         vGrQ==
X-Gm-Message-State: AOAM530rwi/PY5ZDUeVVXfS+kH4YS8fPOJisLYytsMYIqYVaD19SwuAM
        6VMG4uIs3dV91EV8rCyzksLR9w==
X-Google-Smtp-Source: ABdhPJy3aYOT5Ob3M3AXU72KcizrvpfCWWtfDQyx0gYly5JJ58ILcHIiDAne39M+iV/eJ8Ifm5Hlbg==
X-Received: by 2002:a05:6402:354c:b0:42b:4e22:203b with SMTP id f12-20020a056402354c00b0042b4e22203bmr49232992edd.308.1653997505455;
        Tue, 31 May 2022 04:45:05 -0700 (PDT)
Received: from [192.168.0.179] (xdsl-188-155-176-92.adslplus.ch. [188.155.176.92])
        by smtp.gmail.com with ESMTPSA id y9-20020a056402270900b0042bca34bd15sm8359958edd.95.2022.05.31.04.45.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 31 May 2022 04:45:04 -0700 (PDT)
Message-ID: <ec0abd45-d122-2099-c06f-dbcfb01bbee9@linaro.org>
Date:   Tue, 31 May 2022 13:45:03 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH v2 1/2] dt-bindings: clock: mediatek: add bindings for
 MT8365 SoC
Content-Language: en-US
To:     Fabien Parent <fparent@baylibre.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Matthias Brugger <matthias.bgg@gmail.com>
Cc:     linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20220530214434.1012889-1-fparent@baylibre.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220530214434.1012889-1-fparent@baylibre.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 30/05/2022 23:44, Fabien Parent wrote:
> Add the clock bindings for the MediaTek MT8365 SoC.
> 
> Signed-off-by: Fabien Parent <fparent@baylibre.com>
> ---
> v2:
>  * Fix copy/paste: change maintainer
>  * Remove part of the descriptions. It was a copy/paste from other bindings.
>  * Add #clock-cells to list of required properties
>  * Only show one example per yaml file
>  * rename node name to clock-controller
>  * update copyright
>  * remove trailing new line at end of header file
>  * move yaml file to Documentation/devicetree/bindings/clock/
>  * rename header file to contain chip vendor
>  * fix dt_binding_check errors


Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>


Best regards,
Krzysztof
