Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0F0C650C8F9
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Apr 2022 12:06:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234814AbiDWKHC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 23 Apr 2022 06:07:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234824AbiDWKG7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Apr 2022 06:06:59 -0400
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8ABC019980B
        for <linux-kernel@vger.kernel.org>; Sat, 23 Apr 2022 03:03:48 -0700 (PDT)
Received: by mail-ej1-x62f.google.com with SMTP id r13so20712339ejd.5
        for <linux-kernel@vger.kernel.org>; Sat, 23 Apr 2022 03:03:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=0Icd0QAbAtveEL91sUdo5gIKdYCb50RUGDVuACnzMBA=;
        b=y0U6kKeTSJrRSx3RwWcQ0eQL1CpI9mjhmBG/0ir83Tb/3Sauck6I4DwtmPT3GdkTEM
         TEff/fbyESPUovuRvnrVa21nS49D6kctnFlvdJtJ/UA+aLOez9oCL7OQCK4jKpCmSQj3
         v6qTIkhxDTPoWAXQUOxfzHkr6Kj6vVHIMZYE7404AUgjroqkDNZhtwGmp06SGYIEVp0a
         Nj37KgaVzGivlCYYk3c8mq0mdDvBxGMKordQJoxkFliqPA2+TVFfPxmzf0AfcPOY8b3R
         edjDlnq0ZusqEQfdvu9VCC0Zbx7uoTPRUEKJQ3xKbOypA6S02LhE2Na9Z66E0Aibb8Ta
         1Otg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=0Icd0QAbAtveEL91sUdo5gIKdYCb50RUGDVuACnzMBA=;
        b=vVkOtP8CizN28IIu6UaOLzVB3I0s6UwAZ65cps1IvHr5jIlyESKslXk+GhMlGFqwar
         TL08LSHB7Oooq8KQxaUPPb2ujZaHfz7GlOtBIe1icOzf92zV4h5BY7EOfm2x/3kZXhA6
         5yiGJF1EoCeDI+56Qn3ddw2qLId3k15gZVy87DkcGn+OyXdscvdLHpr67rPBaiagZA+U
         rldTdOYZmXmdaCrQ01WOUcPSgKs3qKksLZIUg6Z9Z+0uAgkML0yUGYcOZZIRKgHTNAF6
         iahzpzbOp91isLxSB/F9bco45RHk3mrtc2/cbyqK5gI3TyvPBZbc6w8bk9ZvNmW5CxMz
         77lQ==
X-Gm-Message-State: AOAM533ctdVXx9xFWvjXs+Rydux1m9m2/eJlQOaM+o25o2W8hYliKRHT
        h7RK2kEF0QiPWcH6+3RHjyr8Qg==
X-Google-Smtp-Source: ABdhPJwwvzUM3czsC7y+DnJmlUATBP02rRRtHr6o+QLgSRIt2B1L09BhY9Em2/0XG1XFFaH+X/rp5A==
X-Received: by 2002:a17:907:168a:b0:6da:9177:9fdd with SMTP id hc10-20020a170907168a00b006da91779fddmr7833441ejc.757.1650708227007;
        Sat, 23 Apr 2022 03:03:47 -0700 (PDT)
Received: from [192.168.0.234] (xdsl-188-155-176-92.adslplus.ch. [188.155.176.92])
        by smtp.gmail.com with ESMTPSA id g3-20020a1709063b0300b006e8872f6585sm1564265ejf.175.2022.04.23.03.03.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 23 Apr 2022 03:03:46 -0700 (PDT)
Message-ID: <2e2f5a33-0286-7a89-3842-10d8cd3fdc65@linaro.org>
Date:   Sat, 23 Apr 2022 12:03:45 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCHv1 16/19] dt-bindings: soc: rockchip: add initial rk3588
 syscon compatibles
Content-Language: en-US
To:     Sebastian Reichel <sebastian.reichel@collabora.com>,
        Heiko Stuebner <heiko@sntech.de>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, linux-clk@vger.kernel.org,
        linux-mmc@vger.kernel.org, linux-gpio@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel@lists.collabora.co.uk,
        kernel@collabora.com
References: <20220422170920.401914-1-sebastian.reichel@collabora.com>
 <20220422170920.401914-17-sebastian.reichel@collabora.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220422170920.401914-17-sebastian.reichel@collabora.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 22/04/2022 19:09, Sebastian Reichel wrote:
> Add IOC and PHP GRF syscon compatibles for RK3588.
> 
> Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.com>
> ---

You don't need to adjust anything in allOf:if:then: parts?

Best regards,
Krzysztof
