Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3FD05554698
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Jun 2022 14:11:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355353AbiFVIlf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Jun 2022 04:41:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355299AbiFVIlc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jun 2022 04:41:32 -0400
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00BDA387BF
        for <linux-kernel@vger.kernel.org>; Wed, 22 Jun 2022 01:41:30 -0700 (PDT)
Received: by mail-wr1-x433.google.com with SMTP id o8so22353821wro.3
        for <linux-kernel@vger.kernel.org>; Wed, 22 Jun 2022 01:41:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=sz6VlNHiVjHixKsssl+TJXLUZqbxz+oP9ZVl9b0X04Q=;
        b=zI2iX2goiGZ0Gj7PoNgF/dAyAFJPQV7L/o29pytA7SjhrmeMSqjizHh9LM7RA3nLpL
         phtstWK4Oide9ApB3GfvIL1BjbjBb5QFYOe003kH4eGPP3ey8gmLgO64/tp4OhFnuEbF
         yHWLYcwWDFgNg3VWdRH0e7MMFQzrjGNaGHS4lZt754GjBg7TK7Y6JgjsQ6YfZ61G08KB
         gyrveMFT9VKbbqvhzlr3LuqmUqvUuQ76g0HidfhCn5r4nz5BGR6iQO4lUQ7lwDXQlh+B
         bAo7bi8LH9Bbin0bi6s4MMtMeykr+R3L245W1VXlBDdHzR2C/Igp0ZApE+VdhHXUHWKt
         /9YQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=sz6VlNHiVjHixKsssl+TJXLUZqbxz+oP9ZVl9b0X04Q=;
        b=mVBB4kZtRKtuMWIJcEhd3RsP0wuYJrKZxcAK0OpHcb2CIGamA4dY8VDwgZCDIxIdKK
         uRGMEGC7vTPtzu4szHd2xuIRq8gicdLnsHfISwovLO2dXggAmZqw3ZGDsllCl3jRnCjt
         IdGg5gp3BoWMC2zvFxAdG9ZzOMi4IG9u77cNY258kpX3J9fcHGKXo/knkUS1regDwOQz
         HWvURXkz9q6/iYwnICtBd8C4bIwBObjzqKojBntY3L/6GXsoz26S3ZPkfNQpRr3mZPoL
         wasvnPiWFpaVHHQAyftXTWcg8wrl772Np02BfJ3wKGU6JyaIW3ki5WFPZ+s4AODn7gzT
         h7Ig==
X-Gm-Message-State: AJIora/vqsS5jVIq6wIv/WR9mEC847AxWUvaoJlFyM9G1lufXvmsw51y
        f4g2cEeSmu9e3K1PpgB9tOJqow==
X-Google-Smtp-Source: AGRyM1vN/2Yn5VoH1r/7PIIbeU5gLOIa16fFrvWUQSeTlBzbJrJqfD1H73MWRPrmSyRCWvuLBq1gaQ==
X-Received: by 2002:a5d:5231:0:b0:21b:838e:65ba with SMTP id i17-20020a5d5231000000b0021b838e65bamr2099102wra.412.1655887289619;
        Wed, 22 Jun 2022 01:41:29 -0700 (PDT)
Received: from [192.168.0.223] (xdsl-188-155-176-92.adslplus.ch. [188.155.176.92])
        by smtp.gmail.com with ESMTPSA id a17-20020adffad1000000b0021b8749728dsm12525434wrs.73.2022.06.22.01.41.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 22 Jun 2022 01:41:29 -0700 (PDT)
Message-ID: <2f3e843e-b72b-ee71-7465-b2b6c8d51b0d@linaro.org>
Date:   Wed, 22 Jun 2022 10:41:28 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH] memory/tegra: Add missing of_node_get() in
 tegra_emc_find_node_by_ram_code
Content-Language: en-US
To:     Liang He <windhl@126.com>, thierry.reding@gmail.com,
        jonathanh@nvidia.com
Cc:     linux-kernel@vger.kernel.org, linux-tegra@vger.kernel.org
References: <20220622042824.4094625-1-windhl@126.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220622042824.4094625-1-windhl@126.com>
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

On 22/06/2022 06:28, Liang He wrote:
> of_find_node_by_name() will decrease the refcount of its first arg and
> we need to add a of_node_put() to keep refcount balance.
> 
> Besides, during the 'for' loop execution, the refcount of 'np' will be
> automatically increased and decreased. There is no need to call
> of_node_put() again.
> 
> Signed-off-by: Liang He <windhl@126.com>
> ---
>  drivers/memory/tegra/tegra20-emc.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 

The patch was not even compiled... I consider it harmful approach. NAK.
See: https://lwn.net/Articles/854645/

Best regards,
Krzysztof
