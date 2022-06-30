Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4C7445612DA
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Jun 2022 09:00:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232335AbiF3HAX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Jun 2022 03:00:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229924AbiF3HAU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Jun 2022 03:00:20 -0400
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AECBA3614E
        for <linux-kernel@vger.kernel.org>; Thu, 30 Jun 2022 00:00:17 -0700 (PDT)
Received: by mail-ej1-x632.google.com with SMTP id lw20so37145914ejb.4
        for <linux-kernel@vger.kernel.org>; Thu, 30 Jun 2022 00:00:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=r6uCmFRitcAcRJI/H5P66MBQjDkhl2NiZLnGLT9y1H8=;
        b=v0EeWU8EO4ppWz/+OhslLQimyA4SEA+VJEVL1kvXnbFjSvW8mo31GHtcxqoF4OEYSC
         Qf3kZOohwoCkTOSjzNiBJCXCZPCGuDJOlW4GdDLGFgPbBlUcGDGpbOYkITuSQ01PuoF4
         k3CR5TP3TVBZI3Pz0jABdIBbRuKH0JZnVIWPN3/Adh1m+VGPvohIUDh/epdfTjrXDtC6
         mKJz4kpAetfqgmU4FmU3HaVZjbitYNsWFVfhmBGtL9ZmcHjzumR/BAHOVq4R8/iYF82d
         c5s2piBZ0PJ62vIlDi7F/gh8IZJ452kthNPFVlgSgJqsZ4H1ICe1iYyULPslGEfprzDe
         gJ0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=r6uCmFRitcAcRJI/H5P66MBQjDkhl2NiZLnGLT9y1H8=;
        b=CpeDgGsZ6xOTYspRUgpnLL+X7xdEoGwC0qkcdUBQgLIvXDYOO/eDCSAMzvukryJNJ+
         NacFgPsG9UamA8GS+/imHpIHCSpGzFcFT061NwgLe9A+Hgmy815WKpMe8CuKpM2feRCz
         Wj8NoY5+w0sfyNpjfYNecG3J63p6RqeOFGpVL5tk7laU13v2Jds6I/6TpnRj9YW8Ouj6
         YwGu1A6k0rnqXOMt9LkC/i6wuCzCK/v4yCySINrsjQ+uv4G8sMXCkWb7q6az8NfNcbC6
         AFmVv+SzK4P9185NI85ecD+bvRuzwQseBHZG2GyoFwHo8RMHiXQsrCKtIZgNzAlP1NCh
         Xm+Q==
X-Gm-Message-State: AJIora+mWsBo2rJ64P6OUrfZ7Dvv8dsaPmSZogtCoH0EO5R+7EIC8tXo
        0+s163TiwpSOOXsi5chpn1Ye7Q==
X-Google-Smtp-Source: AGRyM1tDY2nkZypAnZWoTW20KgzJCRPt2W3F9vTeZn7uUeKvjjX9GMEPJDY9RlYCs4qwnDq5NL4NzQ==
X-Received: by 2002:a17:907:1c09:b0:726:b834:1a21 with SMTP id nc9-20020a1709071c0900b00726b8341a21mr7356139ejc.518.1656572416273;
        Thu, 30 Jun 2022 00:00:16 -0700 (PDT)
Received: from [192.168.0.187] (xdsl-188-155-176-92.adslplus.ch. [188.155.176.92])
        by smtp.gmail.com with ESMTPSA id v26-20020a170906489a00b00705f6dab05bsm8676238ejq.183.2022.06.30.00.00.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 30 Jun 2022 00:00:15 -0700 (PDT)
Message-ID: <63d495de-588b-0568-a4d6-31e24ef50377@linaro.org>
Date:   Thu, 30 Jun 2022 09:00:14 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH] ASoC: samsung: change neo1973_audio from a global to
 static
Content-Language: en-US
To:     Tom Rix <trix@redhat.com>, s.nawrocki@samsung.com,
        lgirdwood@gmail.com, broonie@kernel.org, perex@perex.cz,
        tiwai@suse.com, arnd@arndb.de
Cc:     alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
References: <20220629201811.2537853-1-trix@redhat.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220629201811.2537853-1-trix@redhat.com>
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

On 29/06/2022 22:18, Tom Rix wrote:
> sparse reports
> sound/soc/samsung/neo1973_wm8753.c:347:24: warning: symbol 'neo1973_audio' was not declared. Should it be static?
> 
> neo1973_audio is only used in neo1973_wm8753.c, so it's
> storage class specifier should be static.
> 
> Fixes: e26a2abcc246 ("ASoC: samsung: neo1973: turn into platform driver")
> Signed-off-by: Tom Rix <trix@redhat.com>
> ---

Compile testing works!

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>


Best regards,
Krzysztof
