Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F13EC5AF58F
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Sep 2022 22:14:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229534AbiIFUNF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Sep 2022 16:13:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231168AbiIFUMm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Sep 2022 16:12:42 -0400
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79028C1669
        for <linux-kernel@vger.kernel.org>; Tue,  6 Sep 2022 13:07:46 -0700 (PDT)
Received: by mail-lf1-x134.google.com with SMTP id x14so3678221lfu.10
        for <linux-kernel@vger.kernel.org>; Tue, 06 Sep 2022 13:07:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date;
        bh=jlk/vGfL0620uYm2jvAFDojNbY/2LlfVLCVU2MfVkts=;
        b=Q3zg+rarqpQ/dPeMMusQwddYRb/ONxWnf0m22xCbxkHfkRe+WQeG4iUoAocN5ClZIP
         t8YYM//5ChXirNxvNDxVsixPwJAjkaFczlRD6fsHdtXgHrzJOPBlrx7xJ+f61PDRpx2G
         l9tFiMt/3B+ra6wvv2N1LYWzUQKJ4R6YpK67PEa/VJA5C17puj7IyHdxS1OixxhVrHPz
         XebYrG5mDphqHYCTZ0uq/zdG+RaOp0xxPZRfUGJ+nGAflpZww8QcDPE7SPF8ET04MZTi
         oGCyeNZH0GJutCsJARGIDTVMJ8qvouyGKXLmV9WBTpfehMWWP28W/Ts5bwB9azxFUNLf
         XTNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=jlk/vGfL0620uYm2jvAFDojNbY/2LlfVLCVU2MfVkts=;
        b=g8Z12CCdcxTH4MNYReMQGJnQviiMAWcBVVsbcd2KYTtrijDWu5+a0drxhVYzMEge5K
         XjaVTnwAlu0PxSeoEFQye+WZVMvywEcpvBnvUsx1hiy8Ox4jZKhZ/IbTKYD3wlr3zCNb
         Cc9AblHMF6++f2fPUVsPDDuKDA4WPMd/mdLVJLi8PdBuy/Lv2sYJq5Ddxa5+TcP89NvU
         eTBWlYPEY5Z7v/8nrGzekw+9Aec42A/SsJtL8hDlbshCiQgZNl5v96PbXjhizRCJ8Uaz
         71vyjFxZleKXIqHQ9ftOBOLt3Xc9uzvajEgWuoJJ1SLiHoKJ5VUyhNBZ+hdkEe4+KiWo
         /qjw==
X-Gm-Message-State: ACgBeo2m9fwmSbbjVZVhARYDrt/YQku8f/BjnIjtRdRS61X5j1L/mKbW
        /K1kWhs4GAH8Rkz0C6ndm5YeXamgsEI=
X-Google-Smtp-Source: AA6agR52ssBCBvBtxcO/C72Q/WFBGfDsaeblNWY5fGz/a7WsHwixmrenK2AknmpO/epUgXRkMa0zAw==
X-Received: by 2002:a05:6512:3d10:b0:494:7952:7d99 with SMTP id d16-20020a0565123d1000b0049479527d99mr17306lfv.59.1662494857041;
        Tue, 06 Sep 2022 13:07:37 -0700 (PDT)
Received: from [192.168.2.145] (109-252-119-13.nat.spd-mgts.ru. [109.252.119.13])
        by smtp.googlemail.com with ESMTPSA id f28-20020a2eb5bc000000b00264a3a31357sm2044364ljn.61.2022.09.06.13.07.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 06 Sep 2022 13:07:36 -0700 (PDT)
Message-ID: <526160bf-f0f8-a861-55d4-1ed5437c9009@gmail.com>
Date:   Tue, 6 Sep 2022 23:07:35 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Subject: Re: [PATCH v2] PM: ACPI: reboot: Reinstate S5 for reboot
Content-Language: en-US
To:     Kai-Heng Feng <kai.heng.feng@canonical.com>,
        rafael.j.wysocki@intel.com
Cc:     Josef Bacik <josef@toxicpanda.com>,
        Dmitry Osipenko <dmitry.osipenko@collabora.com>,
        Petr Mladek <pmladek@suse.com>,
        Luis Chamberlain <mcgrof@kernel.org>,
        tangmeng <tangmeng@uniontech.com>,
        YueHaibing <yuehaibing@huawei.com>, linux-kernel@vger.kernel.org
References: <20220906143108.1749183-1-kai.heng.feng@canonical.com>
From:   Dmitry Osipenko <digetx@gmail.com>
In-Reply-To: <20220906143108.1749183-1-kai.heng.feng@canonical.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

06.09.2022 17:31, Kai-Heng Feng пишет:
> Commit d60cd06331a3 ("PM: ACPI: reboot: Use S5 for reboot") caused Dell
> PowerEdge r440 hangs at boot.
> 
> The issue is fixed by commit 2ca1c94ce0b6 ("tg3: Disable tg3 device on
> system reboot to avoid triggering AER"), so reinstate the patch again.
> 
> Cc: Josef Bacik <josef@toxicpanda.com>
> Signed-off-by: Kai-Heng Feng <kai.heng.feng@canonical.com>
> ---
> v2:
>  - Use do_kernel_power_off_prepare() instead.
> 
>  kernel/reboot.c | 55 +++++++++++++++++++++++++------------------------
>  1 file changed, 28 insertions(+), 27 deletions(-)
> 
> diff --git a/kernel/reboot.c b/kernel/reboot.c
> index 3c35445bf5ad3..39cbb45afc54a 100644
> --- a/kernel/reboot.c
> +++ b/kernel/reboot.c
> @@ -243,28 +243,6 @@ void migrate_to_reboot_cpu(void)
>  	set_cpus_allowed_ptr(current, cpumask_of(cpu));
>  }
>  
> -/**
> - *	kernel_restart - reboot the system
> - *	@cmd: pointer to buffer containing command to execute for restart
> - *		or %NULL
> - *
> - *	Shutdown everything and perform a clean reboot.
> - *	This is not safe to call in interrupt context.
> - */
> -void kernel_restart(char *cmd)
> -{
> -	kernel_restart_prepare(cmd);
> -	migrate_to_reboot_cpu();
> -	syscore_shutdown();
> -	if (!cmd)
> -		pr_emerg("Restarting system\n");
> -	else
> -		pr_emerg("Restarting system with command '%s'\n", cmd);
> -	kmsg_dump(KMSG_DUMP_SHUTDOWN);
> -	machine_restart(cmd);
> -}
> -EXPORT_SYMBOL_GPL(kernel_restart);
> -
>  static void kernel_shutdown_prepare(enum system_states state)
>  {
>  	blocking_notifier_call_chain(&reboot_notifier_list,
> @@ -301,6 +279,34 @@ static BLOCKING_NOTIFIER_HEAD(power_off_prep_handler_list);
>   */
>  static ATOMIC_NOTIFIER_HEAD(power_off_handler_list);
>  
> +static void do_kernel_power_off_prepare(void)
> +{
> +	blocking_notifier_call_chain(&power_off_prep_handler_list, 0, NULL);
> +}
> +
> +/**
> + *	kernel_restart - reboot the system
> + *	@cmd: pointer to buffer containing command to execute for restart
> + *		or %NULL
> + *
> + *	Shutdown everything and perform a clean reboot.
> + *	This is not safe to call in interrupt context.
> + */
> +void kernel_restart(char *cmd)
> +{
> +	kernel_restart_prepare(cmd);
> +	do_kernel_power_off_prepare();

Looks like an abuse to me. Adding new SYS_OFF_MODE_RESTART_PREPARE and
updating acpi_sleep_init() to use it should be a better solution.
