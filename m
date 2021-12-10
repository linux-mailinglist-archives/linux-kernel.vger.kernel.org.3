Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 16B6E470854
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Dec 2021 19:16:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241830AbhLJSTj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Dec 2021 13:19:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236984AbhLJSTh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Dec 2021 13:19:37 -0500
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B752C061746;
        Fri, 10 Dec 2021 10:16:01 -0800 (PST)
Received: by mail-lf1-x135.google.com with SMTP id k37so19614350lfv.3;
        Fri, 10 Dec 2021 10:16:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=bcvtGiLbR5hJWeiVCch89vaOnPBEjfgkGhnDVgGToIE=;
        b=G0qTQ3KGFrwps8qADsCL0qK6agYLp7ivalOB/mF7ukTMqKqODRUNPClBA+tjj958iZ
         zDP5ALcBXKrVg0xx9H2ws3hyb3r6CIVdqsbS/GVCsvrWbnNO0HGlLBE864udH5VLQpzA
         E4ZCGQvWrQ3sm3YxkToWB7AGuZSE/qHZ86M8KsEpcZTMCU4IFoRlulk9U2f7fjt0DgcE
         dievaYp3/3GIUU6nMVScS6FhLqdlOsaTCJ8+eRNM/gp2aIGsGid35kag1Oq9XwyLJEZe
         Lsdj6NoONSIfbrp21Zrfz1ZI08pSDTMKtV8ZG3ySXOqe/j3lBC+KMsiD//GTJ5tyuvfx
         eTTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=bcvtGiLbR5hJWeiVCch89vaOnPBEjfgkGhnDVgGToIE=;
        b=B2YaX8YchuIOTbrMehsC8kvH1WDukRXWmKM/NjZzZf2bG7U0CtW8eQFXVK3/7uvgWg
         qEK8RGw3yDV9SJkp4TD/joABG62bY9gzvjgblarNqYbYPpegazx1kOGEwa7JVaz2IiuY
         1wirpF5/gH91VKw9uV4CL/uPMdEHMHESfu7gGipU7nvJQiP5FJJ0+EroS3DV1ssYZ39f
         dFA9XuSPZcHi3+mfLPEN1zbcTIwhZtzmxhYPKCX4JWjMAO7C9PcpdR5LPg2PFB9QxRqE
         B36HdnvymmZbyyJb3v3ALJbLqWkUj2OB9XQgF/DIp0WL0PdojBU/J44dGQ60VHrWKo/C
         aKUg==
X-Gm-Message-State: AOAM530/TtTLYYq0CMMDvbzTaHhY/owTeaOZ3C4fSWYH8NVm6WlU3wFH
        /SB/CiCM6eA1+sFTwcXXVAZZZCYDAHg=
X-Google-Smtp-Source: ABdhPJwR/4XeF0n78EyaU8daj5gqPU1YI5WhyixXiCZ/1XxnYO6fYoSxPShwkvEp5UZp5BYd303wDQ==
X-Received: by 2002:a05:6512:40b:: with SMTP id u11mr13847699lfk.377.1639160159550;
        Fri, 10 Dec 2021 10:15:59 -0800 (PST)
Received: from [192.168.2.145] (94-29-46-111.dynamic.spd-mgts.ru. [94.29.46.111])
        by smtp.googlemail.com with ESMTPSA id q15sm379095lfp.32.2021.12.10.10.15.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 10 Dec 2021 10:15:59 -0800 (PST)
Subject: Re: [PATCH v4 07/25] reboot: Remove extern annotation from function
 prototypes
To:     "Rafael J. Wysocki" <rafael@kernel.org>
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
        the arch/x86 maintainers <x86@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Juergen Gross <jgross@suse.com>,
        Stefano Stabellini <sstabellini@kernel.org>,
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
References: <20211126180101.27818-1-digetx@gmail.com>
 <20211126180101.27818-8-digetx@gmail.com>
 <CAJZ5v0i=zgubEtF5-Wnaqa5FMnfVUdSnEmD11-LAuYCH8ZCwrA@mail.gmail.com>
From:   Dmitry Osipenko <digetx@gmail.com>
Message-ID: <acf8289e-6ab8-6eda-ec06-e9044ddd9a92@gmail.com>
Date:   Fri, 10 Dec 2021 21:15:57 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <CAJZ5v0i=zgubEtF5-Wnaqa5FMnfVUdSnEmD11-LAuYCH8ZCwrA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

10.12.2021 21:09, Rafael J. Wysocki пишет:
> On Fri, Nov 26, 2021 at 7:02 PM Dmitry Osipenko <digetx@gmail.com> wrote:
>>
>> There is no need to annotate function prototypes with 'extern', it makes
>> code less readable. Remove unnecessary annotations from <reboot.h>.
>>
>> Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
> 
> I'm not sure that this is really useful.
> 
> Personally, I tend to respect the existing conventions like this.
> 
> Surely, this change is not required for the rest of the series to work.

Problem that such things start to spread all over the kernel with a
copy-paste approach if there is nobody to clean up the code.

This is not a common convention and sometimes it's getting corrected [1].

[1] https://git.kernel.org/linus/6d7434931
