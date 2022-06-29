Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B29ED560140
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Jun 2022 15:29:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233430AbiF2N2r (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Jun 2022 09:28:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231313AbiF2N2p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Jun 2022 09:28:45 -0400
Received: from mail-pf1-x436.google.com (mail-pf1-x436.google.com [IPv6:2607:f8b0:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE5831FCD1;
        Wed, 29 Jun 2022 06:28:44 -0700 (PDT)
Received: by mail-pf1-x436.google.com with SMTP id a15so15077582pfv.13;
        Wed, 29 Jun 2022 06:28:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=/qMI0y+VkqTg4CcHe9CEfDzbipiQSK7u2XbEDh7whKk=;
        b=LKl0RmIM8vcjtONWN66zRXjH4wKn71YWuXYzKTv0/DHmXOlOby9JkSZGFruXUlPL9+
         aCuj4+X657c+K7lfahe1tpx+ibXh9prYuGoliThEMhtuWzQ91TQ5ngO+PvJFLNXi411u
         bzaoQ6FuPEuU8yZNBPtDGHbinAtvQLXs+ne6eiC+U8CQop8d6cIZiTDh2SioaHifivdR
         bURzNdBmXBbqB8gqSdReC3zMspkAwAh5Xr7+cfvvjUCxOkrMXRm+XUa6vhWYZEficZR3
         zBOtXbSP37ViMZcJ/VCkbgafxt4bjYdgC6IHnwVZW7wsv/mLsovInkV+XfiaHNenxbug
         8r8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:message-id:date:mime-version:user-agent
         :subject:content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=/qMI0y+VkqTg4CcHe9CEfDzbipiQSK7u2XbEDh7whKk=;
        b=38i7fNgPDJXqGShlZCdD7MbI9Vgos8uRUssvRNRM2bqa2SwsWn/PvTkbFJxDhCCGoz
         3CSaWPPBtFbepqcpnXQdpNm5nvwtuvpx1YPfqBikRJmuCXJZvOlQHETOUGiX66o1fzVC
         mGFdAEO/UpWtCkQLfXthVD5VSPDSkyuUl1XiQqUkonB9DHDe58QXV6OFCq2Rli7yvoFH
         CIRHWMNco85wc9fwSnsaZpxtav5fIeLvWLio1J+AcTXO8CynFK9wxOYS67sUsuf4g1jA
         YPDEVYa7orRqxBs4PqWdJLoT/ERPtRWh8HrjLwgng19O3KGr07wwpqP+JIxeY8QXgMg3
         mBhQ==
X-Gm-Message-State: AJIora/6fmf6GRyqOfYHhTmoVumn9gX+767ahIRZ969310ZgOsRQJGUL
        IhKeiidA403KybrxTUb8YNg=
X-Google-Smtp-Source: AGRyM1uTRbMaiZAPHFK4cu1xqeLoHadX+m+OI4JqJulddMJ06DtszEI1qvEm+6e7dbDSogK60p2xhQ==
X-Received: by 2002:a63:9752:0:b0:3c6:5a7a:5bd6 with SMTP id d18-20020a639752000000b003c65a7a5bd6mr3061316pgo.390.1656509324228;
        Wed, 29 Jun 2022 06:28:44 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id z1-20020a170902d54100b0016b85cdf8d3sm5287088plf.72.2022.06.29.06.28.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 29 Jun 2022 06:28:43 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <8ee01d6e-8697-1449-c2a4-ac6c63c58f05@roeck-us.net>
Date:   Wed, 29 Jun 2022 06:28:41 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH 2/2] watchdog: realtek-otto: add RTL9310 support
Content-Language: en-US
To:     Sander Vanheule <sander@svanheule.net>,
        linux-watchdog@vger.kernel.org, devicetree@vger.kernel.org
Cc:     Wim Van Sebroeck <wim@linux-watchdog.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-kernel@vger.kernel.org
References: <84d873d7dd375cd2392f89fa6bd9e0fe5dda4e1c.1656356377.git.sander@svanheule.net>
 <629e95e16c8dc812dc5a4ea34a2e2e1ff2faf88c.1656356377.git.sander@svanheule.net>
From:   Guenter Roeck <linux@roeck-us.net>
In-Reply-To: <629e95e16c8dc812dc5a4ea34a2e2e1ff2faf88c.1656356377.git.sander@svanheule.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/27/22 12:00, Sander Vanheule wrote:
> The RTL9310 SoC series has a watchdog timer identical to the already
> supported SoCs. The peripheral is memory mapped at 0x18003260 and driven
> by the Lexra bus clock.
> 
> Signed-off-by: Sander Vanheule <sander@svanheule.net>

Reviewed-by: Guenter Roeck <linux@roeck-us.net>

> ---
>   drivers/watchdog/realtek_otto_wdt.c | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/watchdog/realtek_otto_wdt.c b/drivers/watchdog/realtek_otto_wdt.c
> index 60058a0c3ec4..2a5298c5e8e4 100644
> --- a/drivers/watchdog/realtek_otto_wdt.c
> +++ b/drivers/watchdog/realtek_otto_wdt.c
> @@ -366,6 +366,7 @@ static const struct of_device_id otto_wdt_ids[] = {
>   	{ .compatible = "realtek,rtl8380-wdt" },
>   	{ .compatible = "realtek,rtl8390-wdt" },
>   	{ .compatible = "realtek,rtl9300-wdt" },
> +	{ .compatible = "realtek,rtl9310-wdt" },
>   	{ }
>   };
>   MODULE_DEVICE_TABLE(of, otto_wdt_ids);

