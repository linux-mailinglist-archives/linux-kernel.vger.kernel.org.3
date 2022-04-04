Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EA2A34F1176
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Apr 2022 10:56:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245160AbiDDI6p (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Apr 2022 04:58:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345085AbiDDI5z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Apr 2022 04:57:55 -0400
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56BFC3BA58
        for <linux-kernel@vger.kernel.org>; Mon,  4 Apr 2022 01:55:59 -0700 (PDT)
Received: by mail-wr1-x435.google.com with SMTP id u3so13398177wrg.3
        for <linux-kernel@vger.kernel.org>; Mon, 04 Apr 2022 01:55:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=faLsoLtHlkBu3pNNbIthqX5/njZ9MiXmJRjYICVNcY0=;
        b=ndfQUGIXhKO9kp5VAuPx7fPIl4GIfF+kUupydTzcCgbIwOr+JD3/rxRA8abqvv7Gky
         xmEI2Re3fZECC4rfFp1YDJI8hlFcgUkXMaxbNqakdyXetEJAaD3Jt/wHUjUeLtZsIl2c
         zIM7jDG8YzXJPTlz1rcL36QxuNjl5PsGsWdpO2sy8R6HfllMBBpPASFgZZdbd6PQjf2U
         L1b7WFu2XL548B98enndlyto5g9urgPt8nT/F1i8oyqiX1Y/L+42t4H6ClKp8yOH1waf
         Yoh+S0LXMCeUHxSOQlzQplE5STogmL1EqXmp499bssV5EsXEMmuKr5Rm77hbOdkNvn+D
         Uh+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=faLsoLtHlkBu3pNNbIthqX5/njZ9MiXmJRjYICVNcY0=;
        b=AEPD0ZUnyttfJ0QG/WgLedLjsR9wZ+ufW0EYlnHKT7ntK39MwGpkcKcbCp7kk0U+zz
         3geIXwujLUn3tUOWrEICJP6ETXO0xL0xot136Jz6wJ3pTNKAYk2p5Cvq8J+HlYCTnUqE
         YStrn4GeyVtSuDJaQYcB6T5iI3vnRsOFY0fSgSPRaiudFqEAQhSjLojU4GL/l50QssYN
         4kv/SRrGgv85uxKZTcaXWX0E7WQlVD6qeb+520mYWF4IbnNIVvIjaaEndFlFOhIMSSso
         G6unjcU8fUVaRe29MFAQ2qiKMf7sxtDdRrbBU6iOMt26aaLjZrNUMRV8VetiSukZA/us
         ktEw==
X-Gm-Message-State: AOAM530vZ/4K/FFpB9AD55TByFs/cbFf3JV75RlWG8D9MijiwRb+FcmD
        1Ckq8LK6KyZ3SVBoI6sDi/4ggQ==
X-Google-Smtp-Source: ABdhPJxBnQzLI9AcBq3qkiePfZ/KkRX2Yyx/9vt6YR9cK1gSqXlBy6BgfvSxUTrpxmja0DsUSw5Kiw==
X-Received: by 2002:a05:6000:1c6:b0:206:12be:840f with SMTP id t6-20020a05600001c600b0020612be840fmr2416238wrx.98.1649062557991;
        Mon, 04 Apr 2022 01:55:57 -0700 (PDT)
Received: from [192.168.0.173] (xdsl-188-155-201-27.adslplus.ch. [188.155.201.27])
        by smtp.gmail.com with ESMTPSA id q17-20020adff951000000b00205c1b97ac4sm8724650wrr.20.2022.04.04.01.55.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 04 Apr 2022 01:55:57 -0700 (PDT)
Message-ID: <79a6d4a4-f018-b85e-6385-1432dc23324c@linaro.org>
Date:   Mon, 4 Apr 2022 10:55:56 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH v2 2/2] dt-bindings: mfd: syscon: Add support for regmap
 fast-io
Content-Language: en-US
To:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>, lee.jones@linaro.org
Cc:     robh+dt@kernel.org, krzk+dt@kernel.org, arnd@arndb.de,
        matthias.bgg@gmail.com, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, nfraprado@collabora.com,
        kernel@collabora.com
References: <20220404084732.14096-1-angelogioacchino.delregno@collabora.com>
 <20220404084732.14096-3-angelogioacchino.delregno@collabora.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220404084732.14096-3-angelogioacchino.delregno@collabora.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04/04/2022 10:47, AngeloGioacchino Del Regno wrote:
> The syscon driver now enables the .fast_io regmap configuration when
> the 'fast-io' property is found in a syscon node.
> 
> Keeping in mind that, in regmap, fast_io is checked only if we are
> not using hardware spinlocks, allow the fast-io property only if
> there is no hwlocks reference (and vice-versa).
> 

Please do not send a v2 yet, because we did not finish the discussion
from v1.

Best regards,
Krzysztof
