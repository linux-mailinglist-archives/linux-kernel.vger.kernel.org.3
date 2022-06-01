Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B232353A44C
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Jun 2022 13:46:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352812AbiFALqy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Jun 2022 07:46:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229979AbiFALqv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Jun 2022 07:46:51 -0400
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC06F12635
        for <linux-kernel@vger.kernel.org>; Wed,  1 Jun 2022 04:46:49 -0700 (PDT)
Received: by mail-ed1-x529.google.com with SMTP id v19so1804210edd.4
        for <linux-kernel@vger.kernel.org>; Wed, 01 Jun 2022 04:46:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=xS22Lp44Ny9t4COxTYX6v7RHBsJp3R38gvuPhap8Xxk=;
        b=Vdn/A8bcMrep9u5fPo6z2dUQv9j2g8Y38q6W24RAuco0o8ZmtR2X4HrXfSeipCInZv
         GziXgtzzhIdD+Rffxs0dfyLMnzEJhQKfHlTJNQ5UkuAHUkHvSNhjaoQ+iZZcHaafXISs
         Q/GdYLaAe/LhlPRYcssTLh1kLuDiSDNCxT7Xm5/dLvfpxKA4m7kTnhyMla688A8TpSyd
         ETjc2aA53R15ujLw0V8qqlgQ5jN3uzrjWwzdiawaqw3UdOtPRRBlvikMEm7umlEe54Os
         eEl7yci3R24UScUi7upYPMNosnbr2K9WuZ84XcTBqmo4FQYneoj+dexSxQoVQL50ccjB
         /Iqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=xS22Lp44Ny9t4COxTYX6v7RHBsJp3R38gvuPhap8Xxk=;
        b=Hv4VVSzugFYU+8YYR4BGdnIYTE4TLwbeWLRw7wGP8wUp4wcnt1rcYyi2HoN01POLNB
         E1fKaGUsgN9Xbo9YDE6kW4pRE7quZaZ5+n+SBCxKWy67lY4KdlaKJP1Jk2ighY4Ro7y1
         6TD7NMjhuPuaXC1izMHDFK9dTS4Fr0+UOOZB34uu7iUj9ic0S3Rujx8Anv50B/nSMIsI
         lM/DhkN8O0ZyxumaMrnIUYrGeWg8Jn/GdPqYry4lM2LKxEetix4dnjL/zOQcaylnH7N9
         UBtdVjYwvWGgbUnbw0MawyOwVK7Nju84UtqLl3H9ARfcrnk9YnX4FFzyfOKlAhUJlXRO
         U6yw==
X-Gm-Message-State: AOAM531jTCsVpIinV3onnLph6rF/gDnoxhtqo/BfTjTMYhdDxMZy+BUp
        YuuQ2g06kSZp5jOpa2ZTckYN4Q==
X-Google-Smtp-Source: ABdhPJz7sWA7VmvSrlhCTYtzkutCkqbYbNVnexW8hgWLjCkRZAmC5rj1rW2ZtfehuZ38O0Py78VTtA==
X-Received: by 2002:aa7:d59a:0:b0:42d:d14e:598 with SMTP id r26-20020aa7d59a000000b0042dd14e0598mr16574106edq.215.1654084008362;
        Wed, 01 Jun 2022 04:46:48 -0700 (PDT)
Received: from [192.168.0.179] (xdsl-188-155-176-92.adslplus.ch. [188.155.176.92])
        by smtp.gmail.com with ESMTPSA id f11-20020a056402004b00b0042dbc55f6e4sm881774edu.7.2022.06.01.04.46.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 01 Jun 2022 04:46:46 -0700 (PDT)
Message-ID: <919ca8ee-4b01-e601-714c-26098647d5c7@linaro.org>
Date:   Wed, 1 Jun 2022 13:46:45 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH v1 00/15] Add support for MT8195 SCP 2nd core
Content-Language: en-US
To:     Tinghan Shen <tinghan.shen@mediatek.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Lee Jones <lee.jones@linaro.org>,
        Benson Leung <bleung@chromium.org>,
        Guenter Roeck <groeck@chromium.org>,
        Daisuke Nojiri <dnojiri@chromium.org>,
        Sebastian Reichel <sebastian.reichel@collabora.com>,
        "Dustin L. Howett" <dustin@howett.net>,
        Tzung-Bi Shih <tzungbi@kernel.org>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        Prashant Malani <pmalani@chromium.org>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Brian Norris <briannorris@chromium.org>
Cc:     linux-remoteproc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        chrome-platform@lists.linux.dev,
        Project_Global_Chrome_Upstream_Group@mediatek.com,
        weishunc@google.com
References: <20220601112201.15510-1-tinghan.shen@mediatek.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220601112201.15510-1-tinghan.shen@mediatek.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 01/06/2022 13:21, Tinghan Shen wrote:
> The MT8195 System Companion Processor(SCP) is a dual-core RISC-V MCU.
> Current mediatek remoteproc driver only supports bring-up single core 
> SCP or the 1st core of a dual-core SCP. This series support to bring-up 
      ^^ this or is confusing a bit.

Does this mean that MT8195 has three RISC-V MCUs?

> the 2nd core of a dual-core SCP.



Best regards,
Krzysztof
