Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BD6954C694F
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Feb 2022 12:03:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234916AbiB1LEe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Feb 2022 06:04:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234784AbiB1LEd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Feb 2022 06:04:33 -0500
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2154C24598;
        Mon, 28 Feb 2022 03:03:55 -0800 (PST)
Received: by mail-wm1-x32e.google.com with SMTP id o62-20020a1ca541000000b00380e3cc26b7so5797163wme.0;
        Mon, 28 Feb 2022 03:03:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=HvlBrGZe3k30BhTU3ooPh1DKTxRvIE/QsqhoPXiARb8=;
        b=YZDzVUA06hC7fLLgFFGDrJUe/L/Jhq8JcpzlSH+Tgsd8NHfbVCW0npEiPlXkWZsjbw
         cpkqPoYNF0qz47H7UqE6lglNuuW1aleetoteSyZHHtJS61PD8QeEjmcPgO7Kkofbe+7o
         D8lVZQOcqgUhG1AVNJtjxpIcRhsJB2yS5VFEuOMjsHTqlxI9kFGvaU4Sl1CPWoT1LEPT
         N67gzU9S4QkkTuFLT3KKeWwa6ATJObC3K7geSv6b03W/FOv+95S8lJCgjq7H583TsltU
         8s3X8yEvQsC63IVY5rT2yq3Gq/ws3Jb5Xz+BAvW+wojNJ8iuivq7kBAWJODQZFHL+mA+
         qWBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=HvlBrGZe3k30BhTU3ooPh1DKTxRvIE/QsqhoPXiARb8=;
        b=ZEIdvOyVjDPIk+J2U3VZpS2GPROqwieflmv4s9KIrB9zs3fbFYz0Tx1YT8S/TiLQUq
         /DpkSvEUNZ3fNNhBACZSwPga7AdTG0ZoLdfAxfU7SPe45f8JQQJsEvtttm7KktPeTMfw
         cz8GUQIWDo2ZMfmEQYpZl9M/U7TNK9qJUDsyTgMm8y66osAI51kHwKNTHWTT1MYom1/5
         mB/9pLsRyK6nvV+8xjGbJsQ4mZbBwDdPoDU/NyMFJW4K1i+cTJSVHWKKnV4d9ofdKvz0
         HoINPzCmNY2mMawWRhm73b8HiM79KgrO8+Q3iejl/XnmtAEfyzGQ5NBoCTx7SJQHYP79
         ftDg==
X-Gm-Message-State: AOAM532JidNLeVU7gdfJRpuVznJicKjxJk18DzM34SeleQVr+kWkoRd4
        dZ40njiMXmwtWBcG93lD6lE=
X-Google-Smtp-Source: ABdhPJxw/8fh3j3lFYsbND79fHSYnmbZI1uniemUFfXnBo3sWPkcxqViNkBdJYKkKImNjmciYhDIaA==
X-Received: by 2002:a7b:c057:0:b0:37b:ebad:c9c8 with SMTP id u23-20020a7bc057000000b0037bebadc9c8mr12989438wmc.61.1646046233624;
        Mon, 28 Feb 2022 03:03:53 -0800 (PST)
Received: from [192.168.0.14] (static-63-182-85-188.ipcom.comunitel.net. [188.85.182.63])
        by smtp.gmail.com with ESMTPSA id 10-20020adf808a000000b001edd413a952sm10342670wrl.95.2022.02.28.03.03.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 28 Feb 2022 03:03:53 -0800 (PST)
Message-ID: <1b0ad14d-5843-b8f8-ad6b-d3366a611dde@gmail.com>
Date:   Mon, 28 Feb 2022 12:03:52 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [v2 0/2] Mediatek MT8186 power domain support
Content-Language: en-US
To:     Chun-Jie Chen <chun-jie.chen@mediatek.com>,
        Enric Balletbo Serra <eballetbo@gmail.com>,
        Nicolas Boichat <drinkcat@chromium.org>,
        Rob Herring <robh+dt@kernel.org>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-mediatek@lists.infradead.org,
        srv_heupstream@mediatek.com,
        Project_Global_Chrome_Upstream_Group@mediatek.com
References: <20220215104917.5726-1-chun-jie.chen@mediatek.com>
From:   Matthias Brugger <matthias.bgg@gmail.com>
In-Reply-To: <20220215104917.5726-1-chun-jie.chen@mediatek.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 15/02/2022 11:49, Chun-Jie Chen wrote:
> This patch series adds power domain support for MT8186
> and depends on [1] based on 5.17-rc1.
>
Whole series applied,

Thanks.

Matthias



> change since v1:
> - change to dual license in dt-binding
> 
> [1] https://patchwork.kernel.org/project/linux-mediatek/list/?series=609799
> 
> Chun-Jie Chen (2):
>    dt-bindings: power: Add MT8186 power domains
>    soc: mediatek: pm-domains: Add support for mt8186
> 
>   .../power/mediatek,power-controller.yaml      |   1 +
>   drivers/soc/mediatek/mt8186-pm-domains.h      | 344 ++++++++++++++++++
>   drivers/soc/mediatek/mtk-pm-domains.c         |   5 +
>   include/dt-bindings/power/mt8186-power.h      |  32 ++
>   include/linux/soc/mediatek/infracfg.h         |  48 +++
>   5 files changed, 430 insertions(+)
>   create mode 100644 drivers/soc/mediatek/mt8186-pm-domains.h
>   create mode 100644 include/dt-bindings/power/mt8186-power.h
> 
> --
> 2.18.0
> 
