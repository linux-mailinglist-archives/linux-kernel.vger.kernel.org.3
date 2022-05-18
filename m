Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 114BE52B314
	for <lists+linux-kernel@lfdr.de>; Wed, 18 May 2022 09:11:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231935AbiERHKv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 May 2022 03:10:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231897AbiERHKn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 May 2022 03:10:43 -0400
Received: from mail-lj1-x22a.google.com (mail-lj1-x22a.google.com [IPv6:2a00:1450:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 743F6127
        for <linux-kernel@vger.kernel.org>; Wed, 18 May 2022 00:10:40 -0700 (PDT)
Received: by mail-lj1-x22a.google.com with SMTP id o22so1410409ljp.8
        for <linux-kernel@vger.kernel.org>; Wed, 18 May 2022 00:10:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :references:from:in-reply-to:content-transfer-encoding;
        bh=3Y8OJ4m37PdLh73LbFGI/TuzXq1G8Ucqe1McDv0L7Qw=;
        b=JlRL3HITVZDBdmopILmaqrXqcydYXnTFfA0RbaXJbD2R6mI4kpyWHi65gSQko9aprB
         P9nxJK3bJt+ZO8+d4WtIfXXIvuo4d7cWHXS7ZUi/Rn0pSKMQm/z49nWk2Z1p2kpDWzeb
         eY6Rt7EVpZNbMZMl1UWOZY4k5Fdck5a9n+YZLC/hj39z9iA6iFsnWAgP0Mn0KI2uyBH0
         HFeAnEI3f5QaXorFlyvUUbGWWeuJFgoNVWPl+YQr2P1ANzlOfIWnXpLpXO7JiT+lmDMW
         i7e0reIrs4BWnUZgPOdTN/uRTK+JG6M0PcTz0DGkyfyByHp17nbfFEFUdRrjlmFdwwHW
         Gmmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:references:from:in-reply-to
         :content-transfer-encoding;
        bh=3Y8OJ4m37PdLh73LbFGI/TuzXq1G8Ucqe1McDv0L7Qw=;
        b=YRGmXNsrxcfQU8t/M9W/aN++4pY62Wfo20HgjBNm8AaKHwBTXlKOlTpENhAuSzCgVf
         xEIeb8ArizkwTpBXS2KUErDgcIne9jWSUtZpdbzUEK07by/rK15PIQdVxbEhqBvKsS2S
         p7AFuM6OWw1bpvWBglyHRkUNPN2iLtdmJfxst/UghLcyHTZXj3Mprqp83eN3zelvEykF
         +6j00XBzuwku/roV2cZBROuq2WDV5SVNBisuQmdVxkJHuW/96Cs3EEO3zOtcYdRlaw5m
         lfBrx37dySW2gCSZ9R1OXpoIlG4gpFGNp4JNH1jL2yyDONn10o3CSLfcQ5j+whIWSG16
         WAuw==
X-Gm-Message-State: AOAM532efKoil3HvnF6Y77j64ZaEb51rRRbBBf/0Nn7uhK8pNPSG3Nbl
        /CGpBp7zTMwhOGuqE6y+FdHwnejmMJZA7iLo
X-Google-Smtp-Source: ABdhPJzj42Ts+E0zWJxIYpaHRi4UHdNOsl6Cqe1/VeyvP4ZMGYSeJJ1PRrAkfVQTPLuuDvkN9oZcOQ==
X-Received: by 2002:a05:651c:a11:b0:250:5da4:e7b1 with SMTP id k17-20020a05651c0a1100b002505da4e7b1mr16453099ljq.268.1652857838821;
        Wed, 18 May 2022 00:10:38 -0700 (PDT)
Received: from [192.168.0.17] (78-11-189-27.static.ip.netia.com.pl. [78.11.189.27])
        by smtp.gmail.com with ESMTPSA id a12-20020a056512020c00b0047255d2115asm118471lfo.137.2022.05.18.00.10.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 18 May 2022 00:10:38 -0700 (PDT)
Message-ID: <47f84a32-18e1-5612-b95c-607e2f19f9d8@linaro.org>
Date:   Wed, 18 May 2022 09:10:37 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [PATCH 2/4] dmaengine: sprd-dma: Remove unneeded ERROR check
 before clk_disable_unprepare
Content-Language: en-US
To:     Jiabing Wan <wanjiabing@vivo.com>, Vinod Koul <vkoul@kernel.org>,
        Orson Zhai <orsonzhai@gmail.com>,
        Baolin Wang <baolin.wang7@gmail.com>,
        Chunyan Zhang <zhang.lyra@gmail.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
References: <20220516084139.8864-1-wanjiabing@vivo.com>
 <20220516084139.8864-3-wanjiabing@vivo.com>
 <214de163-d576-d9be-76f2-3b70eefd6e68@linaro.org>
 <b0438374-ff82-e74f-0b83-e0f2b4a99e36@vivo.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <b0438374-ff82-e74f-0b83-e0f2b4a99e36@vivo.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 18/05/2022 04:44, Jiabing Wan wrote:
> Hi,
> 
> On 2022/5/17 23:13, Krzysztof Kozlowski wrote:
>> On 16/05/2022 10:41, Wan Jiabing wrote:
>>> clk_disable_unprepare() already checks ERROR by using IS_ERR_OR_NULL.
>> Hmm, maybe I am looking at different sources, but which commit
>> introduced IS_ERR_OR_NULL() check? Where is it in the sources?
>>
> In commit 4dff95dc9477a, IS_ERR_OR_NULL check is added in clk_disable() 
> and clk_unprepare().
> And clk_disable_unprepare() just calls clk_disable() and clk_unprepare():

Thank you, indeed, I was mislead a bit by clk_prepare() which is not
symmetric.



Best regards,
Krzysztof
