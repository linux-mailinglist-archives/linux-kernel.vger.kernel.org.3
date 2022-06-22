Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 64FFD5548CD
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Jun 2022 14:16:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353738AbiFVIeO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Jun 2022 04:34:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350684AbiFVIeM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jun 2022 04:34:12 -0400
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC4D036E02
        for <linux-kernel@vger.kernel.org>; Wed, 22 Jun 2022 01:34:11 -0700 (PDT)
Received: by mail-ej1-x62b.google.com with SMTP id lw20so10266376ejb.4
        for <linux-kernel@vger.kernel.org>; Wed, 22 Jun 2022 01:34:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :references:from:in-reply-to:content-transfer-encoding;
        bh=R4vnmBvyTgB7VQL9L4DU93Y2xJoD4qlt6c7m9FRyXPk=;
        b=caR2ZF88qlkUmI4v1K+MclQl1/pHAU7wiNKGA/LNsnrgGRCC2kOUVhSYvi3yZ5NQyP
         fWKooHD2934ov3/ibtMvscDHBKdY3k+smTlOA7lJX2t+Q0pOWgy39MJhY/NI+DMYXmAw
         0v2qd5M9VX6/a2CzHsyYqsZU+r0ZdLFiqbvSnWVm+/QXm88TtyxSLvHYLBmjxMOMZ08C
         W79o0ntOhC+mdTK3Wr8VaSPMnF+xIsmqMXvovNSmiNvTYOnXJl1+htsMstWDqe4ff9LR
         XRiws1J3h+Q3mZOFBGH5vbKAeS343RUCuxZuT5mFQPX1paC3Ath2gO0yjE/lcOgLlk6T
         lYKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:references:from:in-reply-to
         :content-transfer-encoding;
        bh=R4vnmBvyTgB7VQL9L4DU93Y2xJoD4qlt6c7m9FRyXPk=;
        b=B55qwOXLf3JGpy4qOqrqDJYkBNUQ1oERbaB4+GRiGrECd6g3b1UZ/hBv1dlSs6nzFB
         1/5dJ76lbo1f8yRWzxaEuZKD5WSnHNkGGqcCJqWn0nf0Q7C7hmlFpURWKVIplsWbAMsv
         OSadFnSYN9WWW+W5dUU7gKg/zoG0I1PStSQ6N6VlKJOP+LzUYNPXwVJVCkUJmU3loIIe
         +pJP/32wdfj3egEse5jcnzIb6OBZvmarcUHcFh87hisncqJFiBFo9pFGPyVvoapj6+lf
         EnAajYzv7+EsZcQmmvwUH3MwFfNWdc+3644VzhZSwGyIYNG8L2StzXO3o0LDYElx0eB8
         BlZw==
X-Gm-Message-State: AJIora9SVqJlkxyo1vwmnyRENwJ+9Ki/yTUjy425Ro7KEvbujTomORb+
        S9REJnGY8nXOjfnsYAGfvcf7SQ==
X-Google-Smtp-Source: AGRyM1uLZ9XyaZBzuTPCedQ4tW57nGzMUgHyHNrqdKha/oPbwDycCtpdirMnJIx8fCOMyRMPoAspxw==
X-Received: by 2002:a17:906:7292:b0:712:3880:3e7b with SMTP id b18-20020a170906729200b0071238803e7bmr1984178ejl.118.1655886850491;
        Wed, 22 Jun 2022 01:34:10 -0700 (PDT)
Received: from [192.168.0.223] (xdsl-188-155-176-92.adslplus.ch. [188.155.176.92])
        by smtp.gmail.com with ESMTPSA id m13-20020a056402510d00b0042ddd08d5f8sm14817652edd.2.2022.06.22.01.34.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 22 Jun 2022 01:34:09 -0700 (PDT)
Message-ID: <ca7f343f-fec0-a365-9263-06354c920b01@linaro.org>
Date:   Wed, 22 Jun 2022 10:34:08 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH v3 26/40] arm64: dts: rockchip: align gpio-key node names
 with dtschema
Content-Language: en-US
To:     arm@kernel.org, soc@kernel.org, Arnd Bergmann <arnd@arndb.de>,
        Olof Johansson <olof@lixom.net>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Heiko Stuebner <heiko@sntech.de>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20220616005224.18391-1-krzysztof.kozlowski@linaro.org>
 <20220616005333.18491-26-krzysztof.kozlowski@linaro.org>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220616005333.18491-26-krzysztof.kozlowski@linaro.org>
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

On 16/06/2022 02:53, Krzysztof Kozlowski wrote:
> The node names should be generic and DT schema expects certain pattern
> (e.g. with key/button/switch).
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> 
> ---
> 
> Changes since v2:
> 1. rk3308-evb.dts, rk3326-odroid-go2.dts: different names according to
>    discussion.
> ---

Heiko,

Any comments on Rockchip parts? Can you pick them or shall I grab them
with rest of cleanups?

Best regards,
Krzysztof
