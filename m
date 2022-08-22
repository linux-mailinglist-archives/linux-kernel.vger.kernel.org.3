Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C29F659C14F
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Aug 2022 16:06:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235285AbiHVOGD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Aug 2022 10:06:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234215AbiHVOGA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Aug 2022 10:06:00 -0400
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6025A248E2;
        Mon, 22 Aug 2022 07:05:59 -0700 (PDT)
Received: by mail-pj1-x1030.google.com with SMTP id s36-20020a17090a69a700b001faad0a7a34so14084725pjj.4;
        Mon, 22 Aug 2022 07:05:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc;
        bh=gYfyihwhJ3o5urXEJEnsgfF4nBOcxPU7rhTPgn7BKMQ=;
        b=n/rI8Qd/BQGjxqZruGN4IvF4EGBeSPm6QRSB4Na2K1FtSgsPK06t7tSa6P1gh/R1lq
         IU57U9j7pgRQeeHZQP20iKTwiGrYMwYFR2NFsoXW9h1QNCxz8W06qW/mBFrjcZZc7rQ7
         JBYG9gctLFvs4Jnb23MhYjty152TxUshk4+0l1BUp4fpgBIM9GpQU/yvn3WP7oJ5Xp3C
         pqMtWr/JLB6X+JOQqFnyVtihKpYmApSZ/ie3UNFJPAtmhsk7K/HuL9yN3RxQRB6tIjNJ
         7SDrAb4u50baGrRYj5byyWk3YY8KfG3EU6JT/EVNVnIF4Dvo9LEbJ8WXY6Pwj1tRME6B
         nZRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc;
        bh=gYfyihwhJ3o5urXEJEnsgfF4nBOcxPU7rhTPgn7BKMQ=;
        b=LmlMWBiZ2iAWtrGNhpceDr2JEqZfL6oW3AbQ3JfKAfDfrqgeO2x0yEH1jD8sIE92qt
         gjASaYVzOs5QsVx1eajwdmgvtfudfUYtZWvbkUKMZrj73NxkFkcFh2273XOzk7s2K6ms
         hSFyD5pUy+MEAJbUwajtF0JYgSVRHcpLLvmVp2FqHs9SYZqq/CTvrccOieufqD4mxKbQ
         V7vAoJSTjXBTa8P8tEQLn5IsV7S0wF2yKhhoqet6NhcgaxPyEBw9ytMBHpPQQo/kwRff
         4hvFyK092jN1jqcI4+wKSd7wuQq4AGnxBAhrmVBbepPuDTLBaeyyY44h6g4YXKM8KH2k
         ocXw==
X-Gm-Message-State: ACgBeo12Us4VUtbGWERrXtY+r6TlyFi43xxcI2TpxdLJzR2Y8vEc30hU
        AGIg2zMBHCHc2TszPKRzYq8=
X-Google-Smtp-Source: AA6agR7O+eMFWRPNet2+2grmnOa3R45vZEA0cG6lXamUBAGdz9DCNQmtYIP2738B0zMHpnWz5m/UiA==
X-Received: by 2002:a17:903:4c9:b0:172:f376:e9f1 with SMTP id jm9-20020a17090304c900b00172f376e9f1mr2973764plb.68.1661177158800;
        Mon, 22 Aug 2022 07:05:58 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id ij19-20020a170902ab5300b0016c50179b1esm8444208plb.152.2022.08.22.07.05.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Aug 2022 07:05:58 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Mon, 22 Aug 2022 07:05:57 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     "Alice Guo (OSS)" <alice.guo@oss.nxp.com>
Cc:     wim@linux-watchdog.org, shawnguo@kernel.org,
        s.hauer@pengutronix.de, festevam@gmail.com, kernel@pengutronix.de,
        linux-imx@nxp.com, linux-watchdog@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/7] watchdog: imx7ulp_wdt: Check CMD32EN in wdog init
Message-ID: <20220822140557.GB4087281@roeck-us.net>
References: <20220816043643.26569-1-alice.guo@oss.nxp.com>
 <20220816043643.26569-4-alice.guo@oss.nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220816043643.26569-4-alice.guo@oss.nxp.com>
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 16, 2022 at 12:36:39PM +0800, Alice Guo (OSS) wrote:
> From: Ye Li <ye.li@nxp.com>
> 
> When bootloader has enabled the CMD32EN bit, switch to use 32bits
> unlock command to unlock the CS register. Using 32bits command will
> help on avoiding 16 bus cycle window violation for two 16 bits
> commands.
> 
> Signed-off-by: Ye Li <ye.li@nxp.com>
> Signed-off-by: Alice Guo <alice.guo@nxp.com>
> Reviewed-by: Jacky Bai <ping.bai@nxp.com>
> Acked-by: Jason Liu <jason.hui.liu@nxp.com>
> ---
>  drivers/watchdog/imx7ulp_wdt.c | 15 ++++++++++-----
>  1 file changed, 10 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/watchdog/imx7ulp_wdt.c b/drivers/watchdog/imx7ulp_wdt.c
> index b8ac0cb04d2f..a0f6b8cea78f 100644
> --- a/drivers/watchdog/imx7ulp_wdt.c
> +++ b/drivers/watchdog/imx7ulp_wdt.c
> @@ -180,11 +180,16 @@ static int imx7ulp_wdt_init(void __iomem *base, unsigned int timeout)
>  
>  	local_irq_disable();
>  
> -	mb();
> -	/* unlock the wdog for reconfiguration */
> -	writel_relaxed(UNLOCK_SEQ0, base + WDOG_CNT);
> -	writel_relaxed(UNLOCK_SEQ1, base + WDOG_CNT);
> -	mb();
> +	val = readl(base + WDOG_CS);
> +	if (val & WDOG_CS_CMD32EN) {
> +		writel(UNLOCK, base + WDOG_CNT);
> +	} else {
> +		mb();
> +		/* unlock the wdog for reconfiguration */
> +		writel_relaxed(UNLOCK_SEQ0, base + WDOG_CNT);
> +		writel_relaxed(UNLOCK_SEQ1, base + WDOG_CNT);
> +		mb();

Now this is intermixing writel() with writel_relaxed(), making
the code all but impossible to understand.

Guenter

> +	}
>  
>  	ret = imx7ulp_wdt_wait(base, WDOG_CS_ULK);
>  	if (ret)
> -- 
> 2.17.1
> 
