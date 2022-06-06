Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6470B53E0C8
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Jun 2022 08:03:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229751AbiFFFtW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Jun 2022 01:49:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229703AbiFFFtN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jun 2022 01:49:13 -0400
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5FED2CE26;
        Sun,  5 Jun 2022 22:49:10 -0700 (PDT)
Received: by mail-lf1-x12f.google.com with SMTP id h23so21642415lfe.4;
        Sun, 05 Jun 2022 22:49:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:content-language:to:cc
         :references:from:subject:in-reply-to:content-transfer-encoding;
        bh=QsPSmnoDQSspdeB5NQpv+gur6fIi4kTRao6eLgRuaaM=;
        b=dn8k0YfOtWS3vkhH2Zz5wYis8IFRK0/6wNFKdBIVwfp6QGSMtlIqQVS+0FhLVWIJfs
         Eq3eiAtpYAgoH+mR0SyhC68qsuvZi7ISj+y9OfTY0dggQbdZCnHWSsf+859U31upP7sQ
         xifla9pTa6rrk4ALid/lUD4JvEREUODVnEG4soV82LuaDqt8wvicuTSYyoBhLzRTnZqS
         /AHvwaXRiFQr/zB+ngqYA75pXb9WGpAzTLpUfK092NpbvEOmYidFAQVjgFg9CjRrKjjf
         921v8M59wRVFfzaERjaMEMuVswVWqug4Q1gwL+GV6nQTSVd44jNRaO/w7jxctITj8WQT
         N69w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent
         :content-language:to:cc:references:from:subject:in-reply-to
         :content-transfer-encoding;
        bh=QsPSmnoDQSspdeB5NQpv+gur6fIi4kTRao6eLgRuaaM=;
        b=Bd8epFJe964FvrtN0z+hfF8pMq0oNr4VK29Ne+zmzEHO6+ED/SRIGdEVn2sf6QxF00
         4+m14LHHUc0okMwrzy98XARvKrRIPDCoWCe5R82U+Ti5aX2a5O0dOQxYMuU/Q+rY7zDb
         H3icW+PBUUhssu+8OhA0D8YOzzTqodwSmRPRdl2y8jyO5E4kkxmSZe+gGRfPITV0GDlu
         uH/8wodZsKtRxyVNdyQoxfw1xh9CBPV4vAoohSpD8Y/Fr33L20w/8EvIzYxjqOVQ/HWB
         cvKi5fjKorfCl+5gW6a1occw7k+JePN2l1yKI9ChuSiK6fizHn5RMqkXNsJaKk0N1V3O
         /HRA==
X-Gm-Message-State: AOAM532fJ/9D+JgH/HmP/nxwKDVZrtb0DoOzkA8+h4MQQ1b0aPIQAEAW
        QN2/cqMVJP6NFU6YdPzBx1w=
X-Google-Smtp-Source: ABdhPJzXPSXO1UB1Ofk63k65l3w0RiwRbD1x75/Fp4Lp9MKzCeFuUD3lINE4c84EolwoJo/MPhIpZg==
X-Received: by 2002:a05:6512:2242:b0:478:ee3a:460d with SMTP id i2-20020a056512224200b00478ee3a460dmr21937913lfu.493.1654494548633;
        Sun, 05 Jun 2022 22:49:08 -0700 (PDT)
Received: from ?IPV6:2001:14ba:16ee:fa00::1? (dc73szyyyyyyyyyyyyyyt-3.rev.dnainternet.fi. [2001:14ba:16ee:fa00::1])
        by smtp.gmail.com with ESMTPSA id v18-20020a05651203b200b0047255d211adsm2724456lfp.220.2022.06.05.22.49.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 05 Jun 2022 22:49:07 -0700 (PDT)
Message-ID: <96a66eab-cb20-71a4-baec-aff80f4cd93e@gmail.com>
Date:   Mon, 6 Jun 2022 08:49:05 +0300
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
        linux-amarula@amarulasolutions.com
References: <20220605165703.1565234-1-michael@amarulasolutions.com>
 <20220605165703.1565234-2-michael@amarulasolutions.com>
From:   Matti Vaittinen <mazziesaccount@gmail.com>
Subject: Re: [RFC PATCH 1/3] clk: bd718x7: Clean up the code, no functional
 changes
In-Reply-To: <20220605165703.1565234-2-michael@amarulasolutions.com>
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

On 6/5/22 19:57, Michael Trimarchi wrote:
> Signed-off-by: Michael Trimarchi <michael@amarulasolutions.com>
> ---
>   drivers/clk/clk-bd718x7.c | 19 ++++++++++---------
>   1 file changed, 10 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/clk/clk-bd718x7.c b/drivers/clk/clk-bd718x7.c
> index ac40b669d60b..04cc0beb67df 100644
> --- a/drivers/clk/clk-bd718x7.c
> +++ b/drivers/clk/clk-bd718x7.c
> @@ -81,27 +81,28 @@ static int bd71837_clk_probe(struct platform_device *pdev)
>   	struct bd718xx_clk *c;
>   	int rval = -ENOMEM;
>   	const char *parent_clk;
> +	struct device *dev = &pdev->dev;

I am not a fan of assigning pointers to struct members to local 
variables unless they're shortening lines to fit on one row instead of 
using two. Whenever we add such a variable we hide information. After 
that being said - in this particular case the device 'dev' points to is 
quite obvious so I am not completely against the change if other see the 
value.

>   	struct device *parent = pdev->dev.parent;
>   	struct clk_init_data init = {
>   		.name = "bd718xx-32k-out",
>   		.ops = &bd71837_clk_ops,
> +		.num_parents = 1,

I like this. Thanks.

>   	};

Reviewed-by: Matti Vaittinen <mazziesaccount@gmail.com>

Best Regards
	-- Matti

-- 
Matti Vaittinen
Linux kernel developer at ROHM Semiconductors
Oulu Finland

~~ When things go utterly wrong vim users can always type :help! ~~

Discuss - Estimate - Plan - Report and finally accomplish this:
void do_work(int time) __attribute__ ((const));
