Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4D2845A08D0
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Aug 2022 08:26:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235189AbiHYG0E (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Aug 2022 02:26:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235394AbiHYG0B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Aug 2022 02:26:01 -0400
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B69A9E696
        for <linux-kernel@vger.kernel.org>; Wed, 24 Aug 2022 23:26:00 -0700 (PDT)
Received: by mail-lf1-x136.google.com with SMTP id z25so26944658lfr.2
        for <linux-kernel@vger.kernel.org>; Wed, 24 Aug 2022 23:26:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc;
        bh=Z1nM8n9D4cKIWi39fJN2NwqcjbnvD6EFp1Fh0bxjzc4=;
        b=hNvYAqJ2fMgVfTRnyfDWcky5oQJfdfYi+EdOJEgIcIKlbFGnhD+xji0eDdp3G4FiBV
         li/WRRGtpXvSBfIY9h+kEDodO0Nuvnsjqolc9rmpHT2pT5w7CV9jO4mANXyYd0sYkCMQ
         AGax0m2WPRn9KJ4tHlBY3rtMYpNYPldGdFTzojUDma+OXFM3bpp2NbA68S8BEAS+F/kT
         ASp1W/5Zgtuwd4GTAfSf3p/ectWSNTqB40+jWtcZCdXqIryvnbDUl6KMNxc/CAzpWtKm
         39qMJo5w6+kedsFKna1EV8Dwoa9fnBx8gkQljEdnVZpYy4fkw4qH5vur4bjXS26Uasr5
         qGpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc;
        bh=Z1nM8n9D4cKIWi39fJN2NwqcjbnvD6EFp1Fh0bxjzc4=;
        b=fpwqrfxGtwfH6Fb6EPOf72Zq65/L21TfyPxIp4EeaGoM4/eyNTGv2FUoDTmezdJgs7
         KoDQFR1pjv2JDtIQWwuHBpkzJtopA9dAyDGpy86TZEz6MPbDI7AQYD1xL/T8qDUoJspW
         Lf/SWc4qPcd52JwcTafYOD7LfDlHDqhq1XrNyzIQTINYvZZjLegWQs1YeZu6b8l0nquG
         4VMlRZhPpsYI50eNk8etDdlOtDK/MbPcXnSi/bxlsdRSBGaTLHoPOafGo3pN01WtALfk
         AelIzBRmkNmMAboRPxgLffz07cie09JbecDRBI6oy58rvK+Z1B/SWWm5n5tyPp/K+B4j
         JKzA==
X-Gm-Message-State: ACgBeo37u3Az9cKWM3Q9guEwJh7jrgo5el0FB10GPebg5RPa7d9Zn6eG
        qOihdxLiVeXa3ElSwJoOobFYag==
X-Google-Smtp-Source: AA6agR7dN0Oeo86So9OoOfr2zzWDWG3FwxukDfc3LUcA3VWZLlGdSlmuXbMu+QCVHLh7M7V+OcogvQ==
X-Received: by 2002:a05:6512:a8e:b0:492:b3e5:adcd with SMTP id m14-20020a0565120a8e00b00492b3e5adcdmr674979lfu.374.1661408758612;
        Wed, 24 Aug 2022 23:25:58 -0700 (PDT)
Received: from [192.168.0.71] (82.131.98.15.cable.starman.ee. [82.131.98.15])
        by smtp.gmail.com with ESMTPSA id s28-20020a056512203c00b0048a91266268sm311509lfs.232.2022.08.24.23.25.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 24 Aug 2022 23:25:58 -0700 (PDT)
Message-ID: <84caccd4-1e28-b344-8e7d-67a6d5c974f2@linaro.org>
Date:   Thu, 25 Aug 2022 09:25:57 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Subject: Re: [PATCH] dt-bindings: display: Add missing
 (unevaluated|additional)Properties on child nodes
Content-Language: en-US
To:     Rob Herring <robh@kernel.org>,
        "James (Qian) Wang" <james.qian.wang@arm.com>,
        Liviu Dudau <liviu.dudau@arm.com>,
        Mihail Atanassov <mihail.atanassov@arm.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Andrzej Hajda <andrzej.hajda@intel.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Robert Foss <robert.foss@linaro.org>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Rob Clark <robdclark@gmail.com>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Sean Paul <sean@poorly.run>, Inki Dae <inki.dae@samsung.com>,
        Seung-Woo Kim <sw0312.kim@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Andre Przywara <andre.przywara@arm.com>
Cc:     Krzysztof Kozlowski <krzk@kernel.org>,
        dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        freedreno@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org
References: <20220823145649.3118479-11-robh@kernel.org>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220823145649.3118479-11-robh@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 23/08/2022 17:56, Rob Herring wrote:
> In order to ensure only documented properties are present, node schemas
> must have unevaluatedProperties or additionalProperties set to false
> (typically).
> 
> Signed-off-by: Rob Herring <robh@kernel.org>


Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>


Best regards,
Krzysztof
