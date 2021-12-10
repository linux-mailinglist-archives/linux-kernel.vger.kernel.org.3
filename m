Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3DE80470821
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Dec 2021 19:09:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241854AbhLJSNI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Dec 2021 13:13:08 -0500
Received: from mail-oo1-f45.google.com ([209.85.161.45]:44884 "EHLO
        mail-oo1-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230284AbhLJSNI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Dec 2021 13:13:08 -0500
Received: by mail-oo1-f45.google.com with SMTP id t9-20020a4a8589000000b002c5c4d19723so2576190ooh.11;
        Fri, 10 Dec 2021 10:09:32 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=bnSiIIEAxVbWb5ME0b4EjQTIeMlzMMlMKVBEVEKFmvo=;
        b=YI1kQA1tXM8B0BX24su8AbH2RzLXy9vgc9pDId6WATq1J6nWZdFuqMyXfmiybyrhgS
         T/9Bx98nvJDR2c/KIDCHqf7gLnpfT7gxpQhAnZf6X6aPLiUpN+zVNupoefmXZjjYCP4c
         k8K5tTzJGsrknUJQ6DYoKi2wVL/5VHLSSBDqNPj/BuQmcE7vL39ESatxNbsddEcxWmdL
         BOWdBHckq54xn28VHK5H2N6FwUCrHm4eYMQ4HMlF5dNZv2RDcSle1EBlXYXuEe0BNCkz
         iULn2CYkGgAGFaLJ8BcZ1P2ZFkbyPJz6FnAa/OQn/eKOSqVVGqFCQm/MbA3j9YBVYlvp
         iz/Q==
X-Gm-Message-State: AOAM530zi3fsHOqr0XImH1ZyQnV63iw1997YtO2H/W5mTSb8hBbmGG8Z
        a/lwzK/qXhnTGZMXWUm06pAMQEvRoXx3B0dDAYc=
X-Google-Smtp-Source: ABdhPJylQaHxxBjvxLDdejK26dmax8gF5GO2emXKWarqrtdmHFUWV4Injg4wQQswc1tWUgMSYyPwJPfech+QMe2lThI=
X-Received: by 2002:a05:6820:388:: with SMTP id r8mr9365162ooj.0.1639159771506;
 Fri, 10 Dec 2021 10:09:31 -0800 (PST)
MIME-Version: 1.0
References: <20211126180101.27818-1-digetx@gmail.com> <20211126180101.27818-8-digetx@gmail.com>
In-Reply-To: <20211126180101.27818-8-digetx@gmail.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Fri, 10 Dec 2021 19:09:20 +0100
Message-ID: <CAJZ5v0i=zgubEtF5-Wnaqa5FMnfVUdSnEmD11-LAuYCH8ZCwrA@mail.gmail.com>
Subject: Re: [PATCH v4 07/25] reboot: Remove extern annotation from function prototypes
To:     Dmitry Osipenko <digetx@gmail.com>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Russell King <linux@armlinux.org.uk>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Guo Ren <guoren@kernel.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Greg Ungerer <gerg@linux-m68k.org>,
        Joshua Thompson <funaho@jurai.org>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Sebastian Reichel <sre@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Greentime Hu <green.hu@gmail.com>,
        Vincent Chen <deanbo422@gmail.com>,
        "James E.J. Bottomley" <James.Bottomley@hansenpartnership.com>,
        Helge Deller <deller@gmx.de>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        Rich Felker <dalias@libc.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Juergen Gross <jgross@suse.com>,
        Stefano Stabellini <sstabellini@kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Len Brown <lenb@kernel.org>,
        Santosh Shilimkar <ssantosh@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>, Pavel Machek <pavel@ucw.cz>,
        Lee Jones <lee.jones@linaro.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Ulf Hansson <ulf.hansson@linaro.org>, alankao@andestech.com,
        "K . C . Kuen-Chern Lin" <kclin@andestech.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-csky@vger.kernel.org, linux-ia64@vger.kernel.org,
        linux-m68k@lists.linux-m68k.org, linux-mips@vger.kernel.org,
        linux-parisc@vger.kernel.org,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        linux-riscv@lists.infradead.org,
        Linux-sh list <linux-sh@vger.kernel.org>,
        xen-devel@lists.xenproject.org,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        linux-tegra <linux-tegra@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 26, 2021 at 7:02 PM Dmitry Osipenko <digetx@gmail.com> wrote:
>
> There is no need to annotate function prototypes with 'extern', it makes
> code less readable. Remove unnecessary annotations from <reboot.h>.
>
> Signed-off-by: Dmitry Osipenko <digetx@gmail.com>

I'm not sure that this is really useful.

Personally, I tend to respect the existing conventions like this.

Surely, this change is not required for the rest of the series to work.

> ---
>  include/linux/reboot.h | 38 +++++++++++++++++++-------------------
>  1 file changed, 19 insertions(+), 19 deletions(-)
>
> diff --git a/include/linux/reboot.h b/include/linux/reboot.h
> index 7c288013a3ca..b7fa25726323 100644
> --- a/include/linux/reboot.h
> +++ b/include/linux/reboot.h
> @@ -40,36 +40,36 @@ extern int reboot_cpu;
>  extern int reboot_force;
>
>
> -extern int register_reboot_notifier(struct notifier_block *);
> -extern int unregister_reboot_notifier(struct notifier_block *);
> +int register_reboot_notifier(struct notifier_block *);
> +int unregister_reboot_notifier(struct notifier_block *);
>
> -extern int devm_register_reboot_notifier(struct device *, struct notifier_block *);
> +int devm_register_reboot_notifier(struct device *, struct notifier_block *);
>
> -extern int register_restart_handler(struct notifier_block *);
> -extern int unregister_restart_handler(struct notifier_block *);
> -extern void do_kernel_restart(char *cmd);
> +int register_restart_handler(struct notifier_block *);
> +int unregister_restart_handler(struct notifier_block *);
> +void do_kernel_restart(char *cmd);
>
>  /*
>   * Architecture-specific implementations of sys_reboot commands.
>   */
>
> -extern void migrate_to_reboot_cpu(void);
> -extern void machine_restart(char *cmd);
> -extern void machine_halt(void);
> -extern void machine_power_off(void);
> +void migrate_to_reboot_cpu(void);
> +void machine_restart(char *cmd);
> +void machine_halt(void);
> +void machine_power_off(void);
>
> -extern void machine_shutdown(void);
> +void machine_shutdown(void);
>  struct pt_regs;
> -extern void machine_crash_shutdown(struct pt_regs *);
> +void machine_crash_shutdown(struct pt_regs *);
>
>  /*
>   * Architecture independent implementations of sys_reboot commands.
>   */
>
> -extern void kernel_restart_prepare(char *cmd);
> -extern void kernel_restart(char *cmd);
> -extern void kernel_halt(void);
> -extern void kernel_power_off(void);
> +void kernel_restart_prepare(char *cmd);
> +void kernel_restart(char *cmd);
> +void kernel_halt(void);
> +void kernel_power_off(void);
>
>  extern int C_A_D; /* for sysctl */
>  void ctrl_alt_del(void);
> @@ -77,15 +77,15 @@ void ctrl_alt_del(void);
>  #define POWEROFF_CMD_PATH_LEN  256
>  extern char poweroff_cmd[POWEROFF_CMD_PATH_LEN];
>
> -extern void orderly_poweroff(bool force);
> -extern void orderly_reboot(void);
> +void orderly_poweroff(bool force);
> +void orderly_reboot(void);
>  void hw_protection_shutdown(const char *reason, int ms_until_forced);
>
>  /*
>   * Emergency restart, callable from an interrupt handler.
>   */
>
> -extern void emergency_restart(void);
> +void emergency_restart(void);
>  #include <asm/emergency-restart.h>
>
>  #endif /* _LINUX_REBOOT_H */
> --
> 2.33.1
>
