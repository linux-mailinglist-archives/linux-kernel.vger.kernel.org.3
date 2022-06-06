Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0F6ED53E0D3
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Jun 2022 08:03:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229650AbiFFF3p (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Jun 2022 01:29:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230021AbiFFF2k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jun 2022 01:28:40 -0400
Received: from mail-lj1-x233.google.com (mail-lj1-x233.google.com [IPv6:2a00:1450:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 348FB15894B;
        Sun,  5 Jun 2022 22:26:04 -0700 (PDT)
Received: by mail-lj1-x233.google.com with SMTP id m25so11289048lji.11;
        Sun, 05 Jun 2022 22:26:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:content-language:to:cc
         :references:from:subject:in-reply-to:content-transfer-encoding;
        bh=zc/BM4GS1deZPOseA9eQ1lDUVrP10O3L44lbLiYjtN4=;
        b=WfMUkiB++a8lTicSUCIf6khGYZnXKmpITWncoBuKUvCNDiDR4bNDkMOHWeBp69Xht4
         6ergkuIGvga7ERsmBmLbvp7OwbeWIrj5MQL+5l7qwUQXjGHhbv/Q6EPndg/H40Q84HtQ
         wpkUGlwxhC05PnMoJ8KQrUouNIYHo5q2PUmlYq7Gz2xsV9EbymrNtcYm4fU1rpTEDzQ1
         BP8lKRj960a8H+1bCFyymYtEqZOqXEuv7dusbLDdFRtLZOqahhFJc52csPKNbHT8xBao
         MD61EqRE/0HqhQ/gPbEoj2tLjJiuR53F9ae58C4xgkbCwXcwuPzjzP1IFIQQeTig490s
         ibkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent
         :content-language:to:cc:references:from:subject:in-reply-to
         :content-transfer-encoding;
        bh=zc/BM4GS1deZPOseA9eQ1lDUVrP10O3L44lbLiYjtN4=;
        b=Gb6DHOr92v2uOhLhMV8yu5cVXIvtN8KFLVsiDXAR57qZ751mj8EDx8WKk1OjH3Y1Rv
         nB/6opsxvcH5Klq4qrbihFMQOt8wuVCASYt4Ce2zuD9wJYyP49WA72hZBAQjeGP+hbti
         jmIAp7Ek/8oocRLqsjuaH8/uLwZ70lY8/rLgyVwvbFAitzcFZWXkNHV0RbjZNU58uGCx
         4hFw7R9SAEoleCBWapDFbURCBrVu6s6a4tQpK1kwBJ41Iup88r5vPdUZNvx5kFmjM/KF
         CzRmxtrg4/i//ssL8ABsQ+kyxAAZerqfUOyB8uztZ8tXpqmYaRlw1j2TmaWX+jiRHZ5e
         dvXw==
X-Gm-Message-State: AOAM530ENXbImK6hw6s25/X9B45lVIm9SzYZixWRjrDO1QsFxFdlU9MD
        JxYzBYYThUE2CG3bQImJ1MhrDb2lTI4=
X-Google-Smtp-Source: ABdhPJwOcEoJ5m94o5VmovTTeks+T0EJ/vH213RpahokS5OtgCLMD9LmeICRSw3AEr3Jd5A24Kn1cg==
X-Received: by 2002:a2e:8752:0:b0:255:6df7:7ad5 with SMTP id q18-20020a2e8752000000b002556df77ad5mr13523255ljj.73.1654493162053;
        Sun, 05 Jun 2022 22:26:02 -0700 (PDT)
Received: from ?IPV6:2001:14ba:16ee:fa00::1? (dc73szyyyyyyyyyyyyyyt-3.rev.dnainternet.fi. [2001:14ba:16ee:fa00::1])
        by smtp.gmail.com with ESMTPSA id x2-20020a05651c024200b002556fd0c336sm2164571ljn.78.2022.06.05.22.26.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 05 Jun 2022 22:26:00 -0700 (PDT)
Message-ID: <5f34b6d6-c2dd-44f9-c1bc-fe1deb336334@gmail.com>
Date:   Mon, 6 Jun 2022 08:25:58 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Content-Language: en-US
To:     Michael Trimarchi <michael@amarulasolutions.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        "open list:COMMON CLK FRAMEWORK" <linux-clk@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
Cc:     Dario Binacchi <dario.binacchi@amarulasolutions.com>,
        linux-amarula@amarulasolutions.com, Marek Vasut <marex@denx.de>
References: <20220605165703.1565234-1-michael@amarulasolutions.com>
 <20220605165703.1565234-3-michael@amarulasolutions.com>
From:   Matti Vaittinen <mazziesaccount@gmail.com>
Subject: Re: [RFC PATCH 2/3] clk: bd718x7: Enable the possibility to mark the
 clock as critical
In-Reply-To: <20220605165703.1565234-3-michael@amarulasolutions.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Michael,

On 6/5/22 19:57, Michael Trimarchi wrote:
> If the clock is used to generate the osc_32k, we need to mark
> as critical. clock-critical has no binding description at the moment
> but it's defined in linux kernel
> 
> bd71847: pmic@4b {
> ...
> 	rohm,reset-snvs-powered;
> 
> 	#clock-cells = <0>;
> 	clock-critical = <1>;
> 	clocks = <&osc_32k 0>;
> 	clock-output-names = "clk-32k-out";
> ...
> }
> 
> Signed-off-by: Michael Trimarchi <michael@amarulasolutions.com>
> ---
>   drivers/clk/clk-bd718x7.c | 4 ++++

//snip

> @@ -100,6 +101,9 @@ static int bd71837_clk_probe(struct platform_device *pdev)
>   
>   	parent_clk = of_clk_get_parent_name(parent->of_node, 0);
>   
> +	of_clk_detect_critical(dev->of_node, 0, &flags);

Purely judging the kerneldoc for of_clk_detect_critical - you may have 
hard time getting this accepted.

I think you're working on a very valid problem though. Maybe you could 
see if you could align your effort with Marek?

https://lore.kernel.org/all/20220517235919.200375-1-marex@denx.de/T/#m52d6d0831bf43d5f293e35cb27f3021f278d0564

Best Regards
	-- Matti

-- 
Matti Vaittinen
Linux kernel developer at ROHM Semiconductors
Oulu Finland

~~ When things go utterly wrong vim users can always type :help! ~~

Discuss - Estimate - Plan - Report and finally accomplish this:
void do_work(int time) __attribute__ ((const));
