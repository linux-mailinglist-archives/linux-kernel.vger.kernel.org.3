Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 362F45A7DC9
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Aug 2022 14:46:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231360AbiHaMqT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 Aug 2022 08:46:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231308AbiHaMqQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Aug 2022 08:46:16 -0400
Received: from mail-lj1-x22c.google.com (mail-lj1-x22c.google.com [IPv6:2a00:1450:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66E2374B8B
        for <linux-kernel@vger.kernel.org>; Wed, 31 Aug 2022 05:46:14 -0700 (PDT)
Received: by mail-lj1-x22c.google.com with SMTP id q16so14484544ljp.8
        for <linux-kernel@vger.kernel.org>; Wed, 31 Aug 2022 05:46:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc;
        bh=+CLgjZxE8tHjYWhVPhfdVFtaMLWoPZmYPr9BiNUoMTc=;
        b=j6+YWVG2F03XvhtGqLhDnHSfCs0oJO1Hv3UxC5lBz005WCdhBbEDMrIcWxMEJyCI4V
         Tib4dXq2B9JybqXVxjzEIalJFVYQN1S/t5UZen2lb+NpmVvZn25APIWlL2o9dAs2hoxq
         TLQ8qUntBZwXhfFzoDKXg7V6gwzMmFM3iX+/JQJ87OCiIT4MldPbyuPv3ue7zHokLC7o
         31wxykyplR+Rnb3QPnb6W5oEa9GgiDkHRL9c3a1DSyQRA7ThQTQQda5PCqChrPpldLjz
         l7uxk/5QWUCCrBQrQGICKM43stixR2K1YoKfSc8Rjs56bS/DYgZn7Dh3jx3eJ+8VYKFT
         h57A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc;
        bh=+CLgjZxE8tHjYWhVPhfdVFtaMLWoPZmYPr9BiNUoMTc=;
        b=41Td0hFfq94inuuURx6A0YS3Kf1qPnNuNYh4mZN3b68buyCaiP9ycfim7aO8hHSeRP
         wo8x26vRahJKLF4s4+QK9mMAAfrO5nynNroq4E1+7/zIs8x1wHaeSew825W0vX/+LVBR
         ylXJwGJKcFGGZqgbwD6HTSA8lKfDQTPbjGRoCAauPoXLBAWKU9mTwN/OqxKHRxPAcoQO
         ffyIKgaL5NciBxtZHhTyQMvyFgjbUlir6waOvO484xhJQlxWDdDI7Irlyo89zxQtld0n
         qd6Ip5dgu9ncnAH7AaL/f/K0RMuMQhdKNuP0VYPcwf8/CDGbZUjrjGU2SLQZQLF3ZHos
         fIzw==
X-Gm-Message-State: ACgBeo0S6Y1cQ4vBmDoaWEFO3IkhhdYuZmtp0JB+fK8+vezeEir4QrgR
        hGHz36taCRTjxge4YJQSi57DwA==
X-Google-Smtp-Source: AA6agR7qz93FvfBLU2m/px9PwOONGwi5VS+Fdh3rFNaW1+Us8K62n3SZ0jsus7AID61+yTHOgIxfMQ==
X-Received: by 2002:a05:651c:1a1e:b0:25f:e7bd:6a4e with SMTP id by30-20020a05651c1a1e00b0025fe7bd6a4emr9181877ljb.362.1661949972793;
        Wed, 31 Aug 2022 05:46:12 -0700 (PDT)
Received: from [192.168.28.124] (balticom-73-99-134.balticom.lv. [109.73.99.134])
        by smtp.gmail.com with ESMTPSA id c17-20020a05651200d100b00492ea54beeasm693118lfp.306.2022.08.31.05.46.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 31 Aug 2022 05:46:12 -0700 (PDT)
Message-ID: <b6475fa6-fd3f-55cd-1b4a-b3e871cced40@linaro.org>
Date:   Wed, 31 Aug 2022 15:46:11 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.0
Subject: Re: [PATCH v2 1/2] dt-bindings: arm: qcom: Document additional skus
 for sc7180 pazquel360
Content-Language: en-US
To:     Yunlong Jia <yunlong.jia@ecs.corp-partner.google.com>,
        LKML <linux-kernel@vger.kernel.org>
Cc:     Henry Sun <henrysun@google.com>,
        Bob Moragues <moragues@chromium.org>,
        Douglas Anderson <dianders@chromium.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-msm@vger.kernel.org
References: <20220831104220.v2.1.I11899dbd0476ffc83aaca07f8ca9b204ecd9a84c@changeid>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220831104220.v2.1.I11899dbd0476ffc83aaca07f8ca9b204ecd9a84c@changeid>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 31/08/2022 13:43, Yunlong Jia wrote:
> pazquel360 is an extension project based on pazquel.
> We create 3 sku on pazquel360:
>    sku 20 for LTE with physical SIM _and_ eSIM and WiFi
>    sku 21 for WiFi only
>    sku 22 for LTE with only a physical SIM
>  Both sku20 and sku22 are LTE SKUs.
>  One has the eSIM stuffed and one doesn't.
>  There is a single shared device tree for the two.
> 
> Signed-off-by: Yunlong Jia <yunlong.jia@ecs.corp-partner.google.com>
> Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> Reviewed-by: Douglas Anderson <dianders@chromium.org>
> 
> ---
> 
> (no changes since v1)

So this is like fifth version of v2? I asked you to read the docs...

Please version your patches and do not send different patches with same
versions.

Best regards,
Krzysztof
