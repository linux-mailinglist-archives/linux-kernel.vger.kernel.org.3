Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1647458CB86
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Aug 2022 17:47:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243743AbiHHPrI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Aug 2022 11:47:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237683AbiHHPrC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Aug 2022 11:47:02 -0400
Received: from mail-pg1-x534.google.com (mail-pg1-x534.google.com [IPv6:2607:f8b0:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10ABD140FE;
        Mon,  8 Aug 2022 08:47:02 -0700 (PDT)
Received: by mail-pg1-x534.google.com with SMTP id c24so4058697pgg.11;
        Mon, 08 Aug 2022 08:47:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :sender:from:to:cc;
        bh=I9RsP4RERwhkNze0cvOQGFIhN+oAZ4sozbdRxsU3efA=;
        b=qZGDyyQB13EmQyQ6Qrjrj5BL1MNynyZ0/EngmSfTE+LyItb8PdyRpRgyiJgzjV3DCB
         ahTf2nAW3Pq9P10kSSw69ZLnZMdi4MZWLsRMFIkg3Bgd2AYLvw1dnmIc7BG0Nf6ssuVp
         FZedcmsTIDqPll5hPHMC2kBvji8acZO8Z/8VxQQlRZNeeJipoMPrtYVzMxZaNDBd6Jrd
         J0r1PQIi92W3vKUKve3R772kFeyXEm5SuIz4BR0tCnZu9lGeJYkS7AZTNML9Er82ROo2
         E6Dwin/WWBH+8v6Q+Ot3EA0mL6q4LG+/LSbqNhhlvfC/NfJjTa9uMXlM5DmPKCb+nkpT
         eW5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :sender:x-gm-message-state:from:to:cc;
        bh=I9RsP4RERwhkNze0cvOQGFIhN+oAZ4sozbdRxsU3efA=;
        b=Q75VAETDatj/c4g1VTU2XgUdPECYvTpxV9ehumA2w8KjdDzN7Y5tihS2AXFys3qKiJ
         NRaikAWbqmYieyMSVadlXKAiD1KChFy4Osay3s3UOVA9FxgmimvoH60YMtciH/omByOk
         gMyLSpqrz3lPHI3LSTbclITxMpepuhzgo957q4Q1K0ROjxcejxB3M/nQOh2+8oFF+Mbs
         Uj+p0AwVqqj4bHwmZ4KqFBOAFAkG7o7MMOomZ3+5criudRQfAGJKBqWKWzHABX4ouy1G
         km3zZlprWIb7e575Y27CYv3ANHrl1RPxteLvJyio2gpwXkcNCFTDCauqgNj4Z78MPQmb
         wr4Q==
X-Gm-Message-State: ACgBeo10FBbeiFBkacQbyU5nFS7+8/xO3x0/qJ/aRbzGwNbzt5nzboc8
        LF1yFLP28TRhfoFcEh4Va3nj6RgzihI=
X-Google-Smtp-Source: AA6agR7kHSeE4WMFw7zPvjI6O7O/xyPNhFIYU+A5gb/QJGghATGASx+Hws56BxI8f+A3uccVFNFRJA==
X-Received: by 2002:a05:6a00:1ac6:b0:52f:55f8:c3d3 with SMTP id f6-20020a056a001ac600b0052f55f8c3d3mr5019710pfv.76.1659973621477;
        Mon, 08 Aug 2022 08:47:01 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id mw9-20020a17090b4d0900b001f2ef2f9c6fsm8433752pjb.56.2022.08.08.08.46.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 08 Aug 2022 08:47:00 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <9147ec6a-5ecc-4577-af48-e8813f2bb231@roeck-us.net>
Date:   Mon, 8 Aug 2022 08:46:58 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH] watchdog: w83627hf_wdt: add boostatus support
Content-Language: en-US
To:     Henning Schild <henning.schild@siemens.com>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        linux-watchdog@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20220808151247.14893-1-henning.schild@siemens.com>
From:   Guenter Roeck <linux@roeck-us.net>
In-Reply-To: <20220808151247.14893-1-henning.schild@siemens.com>
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

On 8/8/22 08:12, Henning Schild wrote:
> The status bit in the status and control register can tell us whether
> the last reboot was caused by the watchdog. Make sure to take that into
> the bootstatus before clearing it.
> 
> Signed-off-by: Henning Schild <henning.schild@siemens.com>\
Reviewed-by: Guenter Roeck <linux@roeck-us.net>

> ---
>   drivers/watchdog/w83627hf_wdt.c | 12 ++++++++++--
>   1 file changed, 10 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/watchdog/w83627hf_wdt.c b/drivers/watchdog/w83627hf_wdt.c
> index 56a4a4030ca9..bc33b63c5a5d 100644
> --- a/drivers/watchdog/w83627hf_wdt.c
> +++ b/drivers/watchdog/w83627hf_wdt.c
> @@ -113,6 +113,10 @@ MODULE_PARM_DESC(early_disable, "Disable watchdog at boot time (default=0)");
>   #define W836X7HF_WDT_CSR	0xf7
>   #define NCT6102D_WDT_CSR	0xf2
>   
> +#define WDT_CSR_STATUS		0x10
> +#define WDT_CSR_KBD		0x40
> +#define WDT_CSR_MOUSE		0x80
> +
>   static void superio_outb(int reg, int val)
>   {
>   	outb(reg, WDT_EFER);
> @@ -244,8 +248,12 @@ static int w83627hf_init(struct watchdog_device *wdog, enum chips chip)
>   	t = superio_inb(cr_wdt_control) & ~0x0C;
>   	superio_outb(cr_wdt_control, t);
>   
> -	/* reset trigger, disable keyboard & mouse turning off watchdog */
> -	t = superio_inb(cr_wdt_csr) & ~0xD0;
> +	t = superio_inb(cr_wdt_csr);
> +	if (t & WDT_CSR_STATUS)
> +		wdog->bootstatus |= WDIOF_CARDRESET;
> +
> +	/* reset status, disable keyboard & mouse turning off watchdog */
> +	t &= ~(WDT_CSR_STATUS | WDT_CSR_KBD | WDT_CSR_MOUSE);
>   	superio_outb(cr_wdt_csr, t);
>   
>   	superio_exit();

