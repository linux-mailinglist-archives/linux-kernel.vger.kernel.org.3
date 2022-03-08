Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CF78B4D1B18
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Mar 2022 15:58:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347681AbiCHO65 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Mar 2022 09:58:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347606AbiCHO64 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Mar 2022 09:58:56 -0500
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95F701A816
        for <linux-kernel@vger.kernel.org>; Tue,  8 Mar 2022 06:57:59 -0800 (PST)
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com [209.85.208.69])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id CA7113F79B
        for <linux-kernel@vger.kernel.org>; Tue,  8 Mar 2022 14:57:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1646751477;
        bh=M+eTcz2ZJB0TWZjmJsyZ2iJjNCL5gmxwdz8k344Fvsc=;
        h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
         In-Reply-To:Content-Type;
        b=WezBv0fU4KJz4CL/iY4A/wqgoLPXKZqt6P2oWAOXyaHEGly9SFE2T3OcT7uhwpB0a
         ne0lXfkkGnsFFSwxYNgN2/40nujdfa0diW+QPh1xJ/wiYqjklAxRxGmB5L+Zv1/Yib
         WRaKhXafOlG0vLwxcHxGq8+chtOfiB+M45xO4dvPC5YLdNAe8iOBqnYCrBeGz+NExz
         haxDzS15U8ySU5gHT4YLX/PtZhpaqcgN3ZNRv6ZcA2Cg7LpfhUp3fea2NjhqtoMEjH
         yyEBnyFHDhmC2NwQMQ4vx50XqGbnIINFjsa8duBOkfLiKDZ5TkGjc3AcL3VFDlEabH
         Nk+assVmoBwAA==
Received: by mail-ed1-f69.google.com with SMTP id o20-20020aa7dd54000000b00413bc19ad08so10767925edw.7
        for <linux-kernel@vger.kernel.org>; Tue, 08 Mar 2022 06:57:57 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=M+eTcz2ZJB0TWZjmJsyZ2iJjNCL5gmxwdz8k344Fvsc=;
        b=rYK0VLg8lYUgPv0vxGxy6e8jTXx66uXLXkV5a7+/ntIGoxwV3K8zCFFdIvFR7mIr9U
         7prs9ah7XwT10Oc1j150HE3BYzZR3x0CfIZkJLEancz7wLAMg+Cm6GXIRAcuWj6Gzisq
         VN1UNfdRjo9wjIixj4zHK/gWre3epwoSvZAF8aHXnxH906kOxukUpsruOls745X6JCrr
         ib6GY4RQ0cvcwTFKRaatGsJVWA7t5RYc5KwmGFNefuJLsUIsr5at7O4N8o4mPMnAj4JC
         QRBRlzsex25GY/uUxarqj6jL83AB06fauDB6JEYeWrcZP7hBY1K1DkC23sGvKrmlBQjN
         3l+g==
X-Gm-Message-State: AOAM533l3tRRfQ1Vv1kggSPNQornlv3yKoEwyj+/wjZBN+XDILOGArZ9
        EDkIqRkcZgqT94CKSFOK0RY8BIcPLBIi479Pwgq14xhaq/QeS3Pp5NU6dGxBqHQutL3OY+FqfOW
        N3ritJU5reHYnUtCkS8BUDzuAZP4gaE8TIovPmBD+lQ==
X-Received: by 2002:a05:6402:4396:b0:412:b131:fca6 with SMTP id o22-20020a056402439600b00412b131fca6mr16313389edc.133.1646751477453;
        Tue, 08 Mar 2022 06:57:57 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwW3LeLqYr6ohDHFWba3PRj6ALdZOOjvivTY4gXILqMMuwH12l+7+o10CTTALaZRhZm/QtJpg==
X-Received: by 2002:a05:6402:4396:b0:412:b131:fca6 with SMTP id o22-20020a056402439600b00412b131fca6mr16313376edc.133.1646751477274;
        Tue, 08 Mar 2022 06:57:57 -0800 (PST)
Received: from [192.168.0.143] (xdsl-188-155-174-239.adslplus.ch. [188.155.174.239])
        by smtp.gmail.com with ESMTPSA id w19-20020a17090633d300b006ce3d425b22sm5950808eja.1.2022.03.08.06.57.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 08 Mar 2022 06:57:56 -0800 (PST)
Message-ID: <226dcb1b-d141-f0d3-68c4-11d2466ca571@canonical.com>
Date:   Tue, 8 Mar 2022 15:57:55 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH v2 3/4] clocksource/drivers/exynos_mct: Support
 local-timer-index property
Content-Language: en-US
To:     Vincent Whitchurch <vincent.whitchurch@axis.com>,
        tglx@linutronix.de, daniel.lezcano@linaro.org
Cc:     kernel@axis.com, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, devicetree@vger.kernel.org,
        alim.akhtar@samsung.com, robh+dt@kernel.org
References: <20220308142410.3193729-1-vincent.whitchurch@axis.com>
 <20220308142410.3193729-4-vincent.whitchurch@axis.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
In-Reply-To: <20220308142410.3193729-4-vincent.whitchurch@axis.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08/03/2022 15:24, Vincent Whitchurch wrote:
> Support the documented semantics of the local-timer-index property: Use
> it as the first index of the local timer, ensure that global timer clock
> events device is not registered, and don't write to the global FRC if it
> is already started.
> 
> Signed-off-by: Vincent Whitchurch <vincent.whitchurch@axis.com>
> ---
> 
> Notes:
>     v2: Use devicetree property instead of module parameter.
> 
>  drivers/clocksource/exynos_mct.c | 25 ++++++++++++++++++++-----
>  1 file changed, 20 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/clocksource/exynos_mct.c b/drivers/clocksource/exynos_mct.c
> index f29c812b70c9..5f8b516614eb 100644
> --- a/drivers/clocksource/exynos_mct.c
> +++ b/drivers/clocksource/exynos_mct.c
> @@ -33,7 +33,7 @@
>  #define EXYNOS4_MCT_G_INT_ENB		EXYNOS4_MCTREG(0x248)
>  #define EXYNOS4_MCT_G_WSTAT		EXYNOS4_MCTREG(0x24C)
>  #define _EXYNOS4_MCT_L_BASE		EXYNOS4_MCTREG(0x300)
> -#define EXYNOS4_MCT_L_BASE(x)		(_EXYNOS4_MCT_L_BASE + (0x100 * x))
> +#define EXYNOS4_MCT_L_BASE(x)		(_EXYNOS4_MCT_L_BASE + (0x100 * (x)))
>  #define EXYNOS4_MCT_L_MASK		(0xffffff00)
>  
>  #define MCT_L_TCNTB_OFFSET		(0x00)
> @@ -75,6 +75,7 @@ enum {
>  static void __iomem *reg_base;
>  static unsigned long clk_rate;
>  static unsigned int mct_int_type;
> +static unsigned int mct_local_idx;

No more static variables. This was wrong design, happens, but let's not
grow the list.

I propose to conditionally (depending on property samsung,frc-shared)
assign .resume callback to NULL or exynos4_frc_resume. The init can
receive an argument whether to call frc_start().


>  static int mct_irqs[MCT_NR_IRQS];
>  
>  struct mct_clock_event_device {
> @@ -157,6 +158,17 @@ static void exynos4_mct_frc_start(void)
>  	u32 reg;
>  
>  	reg = readl_relaxed(reg_base + EXYNOS4_MCT_G_TCON);
> +
> +	/*
> +	 * If the FRC is already running, we don't need to start it again.  We
> +	 * could probably just do this on all systems, but, to avoid any risk
> +	 * for regressions, we only do it on systems where it's absolutely
> +	 * necessary (i.e., on systems where writes to the global registers
> +	 * need to be avoided).
> +	 */
> +	if (mct_local_idx && (reg & MCT_G_TCON_START))

This contradicts your intentions in commit #2 msg, where you described
that A53 will be started first.

1. If A53 is always started first, is it possible to be here from A5?
2. If above is possible, how do you handle locking? For example:
a. A53 started with some delay, entered exynos4_mct_frc_start() pass
this check;
b. A5 gets to exynos4_mct_frc_start(), check is still false, so A5
enables the FRC,
c. A53 also enables the FRC.

Having here relaxed reads and writes makes it even worse, unfortunately.

Best regards,
Krzysztof
