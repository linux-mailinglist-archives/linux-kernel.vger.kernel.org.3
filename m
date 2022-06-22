Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B4B9A554901
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Jun 2022 14:16:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355937AbiFVJYm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Jun 2022 05:24:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355742AbiFVJYd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jun 2022 05:24:33 -0400
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05ECD1D306;
        Wed, 22 Jun 2022 02:24:32 -0700 (PDT)
Received: by mail-lf1-x133.google.com with SMTP id g4so14361476lfv.9;
        Wed, 22 Jun 2022 02:24:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=uaGqsIAVK/Y6QMkYgSeQeOIt515yuh9DZLLAg7SS5yo=;
        b=PEEDW3PEbiOVp2rhhFH7B5LzwxWeSRypB7JPckeuMO+Y5IpemCgsYh2TlyEIxZ3nyT
         MJhHOQqnpMlrI4I0y1SjgCz10df4S0itoblimU2QyetZSORThjyc1vidin4V3rBWF486
         TttEYo3iU2ZJAmr8TUIXU6/psrIXthaZAMf2CMPxv/xM8Xp8Y0EqW8lNrj3wH9ma0VYH
         fk5skjkihVK3RsHAy30mXAxzQrPtN+WAhES1uMJjwADqxm9O8d9EAQmK/+N7tpfa0c5h
         oZSztY1slzj5w5ZpoMPlb8wSa8H4P2PlwVouljLrwaON43c5QgjtErJLWL743LbWWXVL
         p8qQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=uaGqsIAVK/Y6QMkYgSeQeOIt515yuh9DZLLAg7SS5yo=;
        b=FSr7RXRu1r8XpdYOPzXIdbW5QE0ZVfRifSBLU+VH0YLz5gbX2UQPJs1tp0f9cT9q7A
         Sy7ZRqVljFnFXp/MrEfdZ9utPdM4N+IhjfuoX2ttys9NTcCNITgOiyTiR/UkICxZdnaX
         fLVM3GQDlXXoSM1/+44nIeGtmursWYNpZp8mzKaFVtB2Bwt6WxWo09mTlrV0/Fd4dlQy
         xHfDdmLQrvHp6cC2Lo6FP8U06ARtJkGjUm4ml1svJOinyz9M3pXLc5Jj+/2HMuZrIHXa
         58iAlXnLCDDcyUu3l8aVmDG6SFAlq3adjMR1RjkhYDw1ZRh1DVRe3XT3cphjK8c4P8GU
         vPtw==
X-Gm-Message-State: AJIora8zg1YJm+XBfuB89XwrsX4ZXc7hGJWzPGlBzjbj2q88cE19MhIT
        9AIAlEuYey9U5gNDU09OsLg=
X-Google-Smtp-Source: AGRyM1tfVZVPK9juz6WOEYgWMiPkzGihB52MeoevwiSd8IY5PYwjUe/eyNKEIOTNQXbfuqQW5ex5Sg==
X-Received: by 2002:a05:6512:3593:b0:47f:879a:56d1 with SMTP id m19-20020a056512359300b0047f879a56d1mr1640367lfr.36.1655889870180;
        Wed, 22 Jun 2022 02:24:30 -0700 (PDT)
Received: from [192.168.1.103] ([31.173.85.229])
        by smtp.gmail.com with ESMTPSA id k4-20020a2e92c4000000b00258f1e0fb32sm2360394ljh.23.2022.06.22.02.24.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 22 Jun 2022 02:24:29 -0700 (PDT)
Subject: Re: [PATCH] MIPS: Fix 2 typos
To:     Zhang Jiaming <jiaming@nfschina.com>, tsbogend@alpha.franken.de
Cc:     rdunlap@infradead.org, linux-mips@vger.kernel.org,
        linux-kernel@vger.kernel.org, liqiong@nfschina.com,
        renyu@nfschina.com
References: <20220622090713.24370-1-jiaming@nfschina.com>
From:   Sergei Shtylyov <sergei.shtylyov@gmail.com>
Message-ID: <0da1b208-b769-3026-be04-668354f8f845@gmail.com>
Date:   Wed, 22 Jun 2022 12:24:28 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <20220622090713.24370-1-jiaming@nfschina.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
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

Hello!

On 6/22/22 12:07 PM, Zhang Jiaming wrote:

> Change 'modifed' to 'modified'.
> Change 'relys' to 'relays'.

   I think it should be 'relies', not 'relays'.

> Signed-off-by: Zhang Jiaming <jiaming@nfschina.com>
> ---
>  arch/mips/cavium-octeon/executive/cvmx-helper-board.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/mips/cavium-octeon/executive/cvmx-helper-board.c b/arch/mips/cavium-octeon/executive/cvmx-helper-board.c
> index 1daa0c6b6f4e..82c51f015ea3 100644
> --- a/arch/mips/cavium-octeon/executive/cvmx-helper-board.c
> +++ b/arch/mips/cavium-octeon/executive/cvmx-helper-board.c
> @@ -282,9 +282,9 @@ union cvmx_helper_link_info __cvmx_helper_board_link_get(int ipd_port)
>   * support and should return the number of actual ports on the
>   * board.
>   *
> - * This function must be modifed for every new Octeon board.
> + * This function must be modified for every new Octeon board.
>   * Internally it uses switch statements based on the cvmx_sysinfo
> - * data to determine board types and revisions. It relys on the
> + * data to determine board types and revisions. It relays on the
>   * fact that every Octeon board receives a unique board type
>   * enumeration from the bootloader.
>   *

MBR, Sergey
