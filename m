Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E996152769F
	for <lists+linux-kernel@lfdr.de>; Sun, 15 May 2022 11:39:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235707AbiEOJjM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 15 May 2022 05:39:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229800AbiEOJjH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 May 2022 05:39:07 -0400
Received: from mail-lj1-x233.google.com (mail-lj1-x233.google.com [IPv6:2a00:1450:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C294E167DA
        for <linux-kernel@vger.kernel.org>; Sun, 15 May 2022 02:39:05 -0700 (PDT)
Received: by mail-lj1-x233.google.com with SMTP id s27so14967479ljd.2
        for <linux-kernel@vger.kernel.org>; Sun, 15 May 2022 02:39:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :references:from:in-reply-to:content-transfer-encoding;
        bh=Yu4O7LagtKlxKt7NrmLqocjDNakJ5fWhw384x76bvFY=;
        b=j5hAylij16pQUUnT9WOaTb8Ww/4Hw9j0CSEdTqNrsBWh/N+N7+k4ROEomJRr/yycJ2
         IyBQsdHZt04OsCiExwtG6dQMu6L8ulaIErjWXAEnIVR0jP+wdfgVXRQUyX7S9WGskDAk
         E84Was24QN+czkYskakd96p3zQG63UQzhkxSCzjXM/hfLT1RwZgrn0HtCfqMC22x9OH1
         9RaDjFBMqWwhMCDdJ6lpY3RF9DIsMPunpgAgA4CLae8U8SIY3Z1Wg8sLC8rPrTGxjs0y
         jlmwGJH6H2K4Mymgcl4TxqPAycqBe4mbwrwdyMnyKGK7UvBnpTkMA91UKiILIpYK4ZOP
         7rgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:references:from:in-reply-to
         :content-transfer-encoding;
        bh=Yu4O7LagtKlxKt7NrmLqocjDNakJ5fWhw384x76bvFY=;
        b=O0ZOkzLt9mMsI2R5XbRWxF16XUw9ub7QytRaz0Q82iHs9aQxy4QNLxNEN/QGK9aVmJ
         v53TLCY1xj/2W/hao9tkRoj3Bi8C0FeFNK0T+mWlWtO0TWr0FRLYvOJPZ9wOaOyvV3rJ
         j1V7kpkzguSFLLa97QhQJOTRacYrD5O4h8QV8fSmQqsTJd4ejoZITl5fVQ62msRksEnB
         y3OeTShVaajmjsUrbhbaXy7IMbHc7gukzSfFcvKfWmKTc9u+8jjpHYk80+FNxIthhSPc
         kvQchBhR27G1TuOw+aGEuYBT9thrHuvI//TR9M+C28AtYlWVZmMGShSvFYVrp3mrxp05
         POCw==
X-Gm-Message-State: AOAM531169jrk4XUOFUbFkPKqbE1H7vqigcAhSf0DQBQRAY6Wudpzlx0
        UCWHY4KAM+fVzgNsl01HUkqTTQ==
X-Google-Smtp-Source: ABdhPJyIGsAf1NokiFpll09E/rE+AGFeWkwPoYBvHo4R36v8Eu4PtSNmQ+sgfHOXddu8560EQDwtbA==
X-Received: by 2002:a2e:b705:0:b0:250:808a:f7cc with SMTP id j5-20020a2eb705000000b00250808af7ccmr7637249ljo.455.1652607544107;
        Sun, 15 May 2022 02:39:04 -0700 (PDT)
Received: from [192.168.0.17] (78-11-189-27.static.ip.netia.com.pl. [78.11.189.27])
        by smtp.gmail.com with ESMTPSA id a10-20020ac25e6a000000b0047255d21165sm964964lfr.148.2022.05.15.02.39.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 15 May 2022 02:39:03 -0700 (PDT)
Message-ID: <666cfe69-f61a-b89f-b186-278150d0ab3b@linaro.org>
Date:   Sun, 15 May 2022 11:39:02 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [PATCHv2 1/6] thermal: exynos: Enable core tmu hardware clk flag
 on exynos platform
Content-Language: en-US
To:     Anand Moon <linux.amoon@gmail.com>,
        Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Amit Kucheria <amitk@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        linux-pm@vger.kernel.org, linux-samsung-soc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20220515064126.1424-1-linux.amoon@gmail.com>
 <20220515064126.1424-2-linux.amoon@gmail.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220515064126.1424-2-linux.amoon@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 15/05/2022 08:41, Anand Moon wrote:
> Use clk_prepare_enable api to enable tmu internal hardware clock
> flag on, use clk_disable_unprepare to disable the clock.

Please explain why this is needed. Each change needs explanation why you
are doing it.


Best regards,
Krzysztof
