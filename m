Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 064B54EF7EE
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Apr 2022 18:29:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236548AbiDAQak (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Apr 2022 12:30:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350361AbiDAQ2q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Apr 2022 12:28:46 -0400
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1D3292D15
        for <linux-kernel@vger.kernel.org>; Fri,  1 Apr 2022 09:02:06 -0700 (PDT)
Received: by mail-ed1-x530.google.com with SMTP id y10so3475942edv.7
        for <linux-kernel@vger.kernel.org>; Fri, 01 Apr 2022 09:02:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=ExGJe5cWYQRnXJ1osjFcvPm+UZ2yv4UWoz5QaiWRplI=;
        b=uwpOMZKtLcWcwXl2V362svB7yw04DH35KzVh4W9E/jPqYvLuEwK20933Fn75hA5aAT
         U5N2goSzcbM3L4pFygI/ID3CJTgvYfhLEJ8pBnzFbPLkxFI+vpTzsjXr+MbIuporCZcf
         E66oZs9z8EkBW7qk6ixUMysKFIvMuayi88YL0lwomQ3uHUY6qyaXJxMqJmydZHqz9vio
         UIPsAAgaznXpVY5qnNqGkP4DTmJfb91+bDI3/nGS4nnf3VPPvdg8r3hspRNKugtz90xb
         eOU/k11RGFrJ/PgU11R49Njr1OTg8d3QKFHD9cJFQbXpnTvDoh0OEAw12HVrIoKfQ8nA
         R5mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=ExGJe5cWYQRnXJ1osjFcvPm+UZ2yv4UWoz5QaiWRplI=;
        b=Gwwl1uSwYX0p6LlzR1ECi5zFmwpR48TQnPciGnAGY/R7xLjlTeRuZdGvektTO7KDdh
         GlybChhg/vhcddNJji685wdzLPOXxvyYd16BsMG4cu3m27cZ9IuZZW6TKOpmqI2RoVeA
         oK+LP0TPmlU5PAOSlo8i54BFi0FKYFos7gS2z0UOjS3UdIFuYS8RPZvX0yeh3rMw8ZDV
         vFDN2p+IuVG2sKmNUzitNXun13Ga3py/pVnVoqgffnMSEPcApod36U5dCYym6DiCnfNj
         XlqQ0qJwP3Vz5O7UK0LpUaHMfkhQjMJr6pbVeLMLk6lp0ZB9MQJ7eOCNiV9OSEE+HzpN
         jtag==
X-Gm-Message-State: AOAM531LEWAy12lU4/VJsnPfjwMRYJvGzdTrwhnUw5uH1OREqTWu68aB
        Qi2ND5jSgIQW/2XhjXatyMBtnA==
X-Google-Smtp-Source: ABdhPJzFWUQNx1pWDoEZnKblaJ7Cspvi3M/M+Gk0b4Pyy+p35Cnf+/2U6e2eIE82vGbBpXCzstOGBw==
X-Received: by 2002:a05:6402:3489:b0:419:88f0:4bcd with SMTP id v9-20020a056402348900b0041988f04bcdmr21736645edc.401.1648828925441;
        Fri, 01 Apr 2022 09:02:05 -0700 (PDT)
Received: from [192.168.0.170] (xdsl-188-155-201-27.adslplus.ch. [188.155.201.27])
        by smtp.gmail.com with ESMTPSA id gb29-20020a170907961d00b006e00c7b0f5asm1144831ejc.0.2022.04.01.09.02.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 01 Apr 2022 09:02:04 -0700 (PDT)
Message-ID: <c4b1e34f-453c-11b6-c083-2e5a638e8db1@linaro.org>
Date:   Fri, 1 Apr 2022 18:02:03 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH] ASoC: samsung: Constify snd_soc_dapm_{route,widget}
 structs
Content-Language: en-US
To:     Rikard Falkeborn <rikard.falkeborn@gmail.com>,
        Sylwester Nawrocki <s.nawrocki@samsung.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>
Cc:     Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
        =?UTF-8?Q?Andreas_F=c3=a4rber?= <afaerber@suse.de>,
        Manivannan Sadhasivam <mani@kernel.org>,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-actions@lists.infradead.org,
        Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
References: <20220330204227.25081-1-rikard.falkeborn@gmail.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220330204227.25081-1-rikard.falkeborn@gmail.com>
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

On 30/03/2022 22:42, Rikard Falkeborn wrote:
> These structs only have their address assigned to the
> dapm_{routes,widget} fields in the snd_soc_card struct,
> both which are pointers to const data. Make them const to
> allow the compiler to put them in read-only memory.
> 
> Signed-off-by: Rikard Falkeborn <rikard.falkeborn@gmail.com>
> ---
>  sound/soc/samsung/bells.c      | 4 ++--
>  sound/soc/samsung/littlemill.c | 4 ++--
>  sound/soc/samsung/lowland.c    | 4 ++--
>  sound/soc/samsung/speyside.c   | 4 ++--
>  sound/soc/samsung/tobermory.c  | 4 ++--
>  5 files changed, 10 insertions(+), 10 deletions(-)
> 

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof
