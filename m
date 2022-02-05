Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 295D44AA8AA
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Feb 2022 13:17:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379841AbiBEMRR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 5 Feb 2022 07:17:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348925AbiBEMRP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 Feb 2022 07:17:15 -0500
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14658C061346;
        Sat,  5 Feb 2022 04:17:15 -0800 (PST)
Received: by mail-pj1-x1030.google.com with SMTP id my12-20020a17090b4c8c00b001b528ba1cd7so8699238pjb.1;
        Sat, 05 Feb 2022 04:17:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=uqGnPKycliIrfQeJhWM/nWoXkY9Kuok+TUu6COA/cjQ=;
        b=gxLi54I26BgtahUJQEkgF9JqusmDqrlAc13CmdieV7SiDJH3DcqP0z2LhBxVg3Iq1A
         lD/p06xRzuAt9Pw31JxTtXh1AEGg3EPAMfKWScbtAmdH3RXhddHlb8dteRl9jcq9O4Y5
         +4jiSzjbisMuFsMq1WD+4490KodpBRR82P12S+fSwXRRI5stCqR3F3crzNdDGYSvfnUk
         sPZEQU4CvqW/k/e2jpAx6T7j+K1kFFOv35R6vUBgnQChaJJkuH/pS6wlJmPF1IYLlqh4
         xpCZN3hAy4AAY7Tr1xYlCLQKHXqAVhhcYl+IZgWCFw+D79ZLuJpnb+F+M5lPjZTDapOk
         rxPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:message-id:date:mime-version:user-agent
         :subject:content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=uqGnPKycliIrfQeJhWM/nWoXkY9Kuok+TUu6COA/cjQ=;
        b=7NVBhc8+sUvfq3bvrjBvFKuLNE82V/hP6+aMbGYrw9tF9HnKYVz129lWEDL9F5skMW
         yZ36TMZYSB8fiAvdpwcQGO8GA5W0P/ScqMexxOHm/IPY2ed6I0XckGI2JRi8l5XWkWsE
         8cf2Cg6RTY3V8As2JeFCLn9jFLnvvOxqwAEiVCPJ3esx7CPVibzADObSS5AIPYGHz6/+
         D+NF9+7hjhvnO5E6XOmyHPtUvJBX76ha136LAcvPHns/7SB4Y5os2Dbicyz2/xyeLDee
         1K1HjPf9vpjVgix/Y2i4O1RYhggnmUYLC95klnxhhkNNzwDDBtEqY24FCeWZ28d4j6ix
         bRpg==
X-Gm-Message-State: AOAM531/0rjztXhQT70igL8DFd3kz9jejN9ga1SlMjLlxAnZylqrtoeh
        Y5D94tUUJEvoxaEoPkbdVE0=
X-Google-Smtp-Source: ABdhPJw0Sz2DUXfgdU65gdyvhLEyFIAQkBjm1zUqJayPu4sxNQo7PaZgd0aK7QrbqQN5iAVH9IzuCA==
X-Received: by 2002:a17:902:c9c2:: with SMTP id q2mr8055131pld.18.1644063434622;
        Sat, 05 Feb 2022 04:17:14 -0800 (PST)
Received: from [192.168.1.33] (154.red-83-50-83.dynamicip.rima-tde.net. [83.50.83.154])
        by smtp.gmail.com with ESMTPSA id lr7sm5716192pjb.42.2022.02.05.04.17.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 05 Feb 2022 04:17:14 -0800 (PST)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= 
        <philippe.mathieu.daude@gmail.com>
Message-ID: <1415e1d2-eca4-aa36-6ef0-708b8290089d@amsat.org>
Date:   Sat, 5 Feb 2022 13:17:10 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.5.1
Subject: Re: [PATCH v3 2/4] clk: loongson1: Terminate clk_div_table with
 sentinel element
Content-Language: en-US
To:     =?UTF-8?Q?Jonathan_Neusch=c3=a4fer?= <j.neuschaefer@gmx.net>,
        linux-clk@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mips@vger.kernel.org,
        Keguang Zhang <keguang.zhang@gmail.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, Yang Ling <gnaygnil@gmail.com>
References: <20220205005232.772726-1-j.neuschaefer@gmx.net>
 <20220205005232.772726-3-j.neuschaefer@gmx.net>
From:   =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
In-Reply-To: <20220205005232.772726-3-j.neuschaefer@gmx.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/2/22 01:52, Jonathan Neuschäfer wrote:
> In order that the end of a clk_div_table can be detected, it must be
> terminated with a sentinel element (.div = 0).
> 
> Fixes: b4626a7f4892 ("CLK: Add Loongson1C clock support")
> Signed-off-by: Jonathan Neuschäfer <j.neuschaefer@gmx.net>
> Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
> ---
> 
> v3:
> - no changes
> 
> v2:
> - Add Fixes and R-b tags
> ---
>   drivers/clk/loongson1/clk-loongson1c.c | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/clk/loongson1/clk-loongson1c.c b/drivers/clk/loongson1/clk-loongson1c.c
> index 703f87622cf5f..a6f9f20fc8b99 100644
> --- a/drivers/clk/loongson1/clk-loongson1c.c
> +++ b/drivers/clk/loongson1/clk-loongson1c.c
> @@ -37,6 +37,7 @@ static const struct clk_div_table ahb_div_table[] = {
>   	[1] = { .val = 1, .div = 4 },
>   	[2] = { .val = 2, .div = 3 },
>   	[3] = { .val = 3, .div = 3 },
> +	[4] = { /* sentinel */ },

Sorry for being nitpicky here, but we don't need the trailing comma,
since this is the last entry.

>   };
> 
>   void __init ls1x_clk_init(void)
> --
> 2.34.1
> 

