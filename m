Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 46D184B7A20
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Feb 2022 23:00:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232373AbiBOWBD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Feb 2022 17:01:03 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:56626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243036AbiBOWAs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Feb 2022 17:00:48 -0500
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E9207679;
        Tue, 15 Feb 2022 14:00:37 -0800 (PST)
Received: by mail-lf1-x133.google.com with SMTP id d23so156794lfv.13;
        Tue, 15 Feb 2022 14:00:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language
         :from:cc:references:to:in-reply-to:content-transfer-encoding;
        bh=DVulEGE2JpmKCAwv+Z9nIfk2u5ZwvRtSEnvF0++tohE=;
        b=eAbTUd8SWrkduWMDvYSL9PCIMvTyx1/PDNq+g34U5a6HTO/JfyDazuc/276Sm7ld7f
         RQAUjz9KnJpaex/eozKDcsnVqqRwA5Fj5CSlNJHiQfzBkJVLCc7y3vw02lxihPY3TExU
         lYcUYoYFkQWAG/XD2qnNsvTl5P4zqH6pcaasqRB1LojAt2IN4Q9BVX82FHrNStE8wYB4
         mmhCvKeDI7YjVSy4dXfgCBsx8WWHAoaLNoouUIXdBuim6buHAqSq3/5veKqw8hxrEwEf
         aYlaoKh86/GFDdT8ghhsvoX3tr735feUL8boUX68tZ9vbfpFMdKPrE/wFw8zC0NNEmPZ
         ssKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:from:cc:references:to:in-reply-to
         :content-transfer-encoding;
        bh=DVulEGE2JpmKCAwv+Z9nIfk2u5ZwvRtSEnvF0++tohE=;
        b=wTomICDpoIwEpCbz/72bMDFaEmVWU7jQc/NuRAsg5bofzOt+vrWhjPQ2iKSRqFWatq
         2nn/6InANIri5CuyLP57qbEDM9mNc+5oZNOvgWA5aUbfkk3r9wDjbUSkFFER2DeqtH/a
         bADUAVck22cpEUHFrfulL2xsLu64LIqrFQ+00XUn0A7FBhLtpL22/xqTllsHNe4eEPm7
         g1Fru5sO0wB860IhOJJiDRGaDBtpzxBNQqYE73Et7s+bciz4Ih7cIC4g6X8+IJ3dqZ+K
         17whSiQLXyb07yrqfCubnrkgnA7Ks4PppPUCaKBYPiXtyTFtzwoLKHoc68JFMAcjRFuF
         yOWA==
X-Gm-Message-State: AOAM531oZB9VDs53ngcnjqCct//CiNbyr8ZzJgloNmrvVFVlHGjuR1ts
        zMznJoIsXh+/1v7IepFIBTg=
X-Google-Smtp-Source: ABdhPJyJtWqeT1e2wzvijosINOm/qc6wwzWUL/FDa9uqhHR32CJOoO1KF1UaVLhHtHEQQhQBEaQuLQ==
X-Received: by 2002:a05:6512:96d:: with SMTP id v13mr790998lft.343.1644962435902;
        Tue, 15 Feb 2022 14:00:35 -0800 (PST)
Received: from [192.168.2.145] (109-252-138-165.dynamic.spd-mgts.ru. [109.252.138.165])
        by smtp.googlemail.com with ESMTPSA id k3sm66075lfo.10.2022.02.15.14.00.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 15 Feb 2022 14:00:35 -0800 (PST)
Message-ID: <635e8121-fca4-580c-6af5-d9317a2eee1b@gmail.com>
Date:   Wed, 16 Feb 2022 01:00:33 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH v6 00/21] Introduce power-off+restart call chain API
Content-Language: en-US
From:   Dmitry Osipenko <digetx@gmail.com>
Cc:     linux-kernel@vger.kernel.org, linux-csky@vger.kernel.org,
        linux-ia64@vger.kernel.org, linux-m68k@lists.linux-m68k.org,
        linux-mips@vger.kernel.org, linux-parisc@vger.kernel.org,
        linux-riscv@lists.infradead.org, linux-sh@vger.kernel.org,
        xen-devel@lists.xenproject.org, linux-acpi@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-tegra@vger.kernel.org,
        Thierry Reding <thierry.reding@gmail.com>,
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
        "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>,
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
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
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
        =?UTF-8?B?TWljaGHFgiBNaXJvc8WCYXc=?= <mirq-linux@rere.qmqm.pl>
References: <20220130233718.21544-1-digetx@gmail.com>
To:     "Rafael J. Wysocki" <rafael@kernel.org>
In-Reply-To: <20220130233718.21544-1-digetx@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

31.01.2022 02:36, Dmitry Osipenko пишет:
> Problem
> -------
> 
> SoC devices require power-off call chaining functionality from kernel.
> We have a widely used restart chaining provided by restart notifier API,
> but nothing for power-off.
> 
> Solution
> --------
> 
> Introduce new API that provides both restart and power-off call chains.
> 
> Why combine restart with power-off? Because drivers often do both.
> More practical to have API that provides both under the same roof.
> 
> The new API is designed with simplicity and extensibility in mind.
> It's built upon the existing restart and reboot APIs. The simplicity
> is in new helper functions that are convenient for drivers. The
> extensibility is in the design that doesn't hardcode callback
> arguments, making easy to add new parameters and remove old.
> 
> This is a third attempt to introduce the new API. First was made by
> Guenter Roeck back in 2014, second was made by Thierry Reding in 2017.
> In fact the work didn't stop and recently arm_pm_restart() was removed
> from v5.14 kernel, which was a part of preparatory work started by
> Guenter Roeck. I took into account experience and ideas from the
> previous attempts, extended and polished them.


Rafael and all, do you see anything critical that needs to be improved
in this v6?

Will be great if you could take this patchset via the power tree if it
looks okay, or give an ack.
