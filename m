Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 34BF947098D
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Dec 2021 19:56:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245688AbhLJTAM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Dec 2021 14:00:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241978AbhLJTAL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Dec 2021 14:00:11 -0500
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF957C0617A1;
        Fri, 10 Dec 2021 10:56:35 -0800 (PST)
Received: by mail-lf1-x134.google.com with SMTP id l22so19685256lfg.7;
        Fri, 10 Dec 2021 10:56:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=OLTFQmX2Kf2e3cZmLG4jxsS1bq2aSoDXpxl5QnKq9FU=;
        b=lRJVrFA11Fu94g9aC4quIzKTIJBQHb56jvC3UHQRYxQnYMhhiqHXe+HNIaU6izZboH
         h0BDFCIwI4bVAz64DQVVsH0MSKsIo5r3rhYcpSgEs+F8SRLOvGUk6MezYqtprOuHSHY+
         xZjhnDgdSP0x9ihrSMtshGYvbNVvxVMeCabfWJNzXp5+bcL+U+5yCBZgtjUoQy5c5Srk
         XvThuXHF65j6/Qpyivd03hsOvMnXYmDchKWNvnb9km4xj+cql2CnI3JZSdhbiWgBDsX+
         pJV/q1mj1vSBgnFw5Nf3SQ1PcuWrLHkWB0ABMsx7hJcTqhLbY3gqIMN0WZdDvJ/sUnhK
         zo7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=OLTFQmX2Kf2e3cZmLG4jxsS1bq2aSoDXpxl5QnKq9FU=;
        b=Q1GLxFfAUEPBIIhuM8TEPDqE2XBQpUMpmIIlurLGQNZaJ93U8VmIIhzpfFXcIrR+vg
         5daJGT8PnPDcFEBr897JOQ+U8X3Th2t6utx1WH8NiV6H6/yxeNeXnvys/R5MJmulgM2A
         3FsGM2Qsf0AowfljlHMUkMFvQQk91Qi9Gryj6gL0vM5TXHlUbULgeVeNbSROwrRtYgsj
         X3oi3BmGRBzFvLAbbkt1oqV7y34lsDtEIL2XDUQMr2Re9RyIXV5gImGpEGpVHMIsgQSG
         tgPURlArPITBdm89JnMD8Rc4GDaSCSAvlZgPyk6xtlADPpE5BoM6zspzlkqecY3DUBbo
         jD4g==
X-Gm-Message-State: AOAM530IgeiafV2hhU29QZNMQqpQy75i4GFqaB4j2Emiiz3EmlVoYj4C
        5fRrBZCZCG8b6JOcH7h4YkkHzRvIjfk=
X-Google-Smtp-Source: ABdhPJx4BKlEbZ+Eghk+XJYmXdOJaHtYRLuIKsc/RB19AF8hnZocVzO0VkIjSpmfvEqny0BWm7yDgw==
X-Received: by 2002:ac2:5101:: with SMTP id q1mr8849810lfb.319.1639162594092;
        Fri, 10 Dec 2021 10:56:34 -0800 (PST)
Received: from [192.168.2.145] (94-29-46-111.dynamic.spd-mgts.ru. [94.29.46.111])
        by smtp.googlemail.com with ESMTPSA id b10sm416126lfj.230.2021.12.10.10.56.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 10 Dec 2021 10:56:33 -0800 (PST)
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
 <acf8289e-6ab8-6eda-ec06-e9044ddd9a92@gmail.com>
 <CAJZ5v0gvuteY4EtXWTKmh4-Wt-Z_dPcqfDLwc-ja1uovbV3rpw@mail.gmail.com>
From:   Dmitry Osipenko <digetx@gmail.com>
Message-ID: <bafcaa92-5bd1-874c-c5ff-a72ebc98945d@gmail.com>
Date:   Fri, 10 Dec 2021 21:56:31 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <CAJZ5v0gvuteY4EtXWTKmh4-Wt-Z_dPcqfDLwc-ja1uovbV3rpw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

10.12.2021 21:35, Rafael J. Wysocki пишет:
> On Fri, Dec 10, 2021 at 7:16 PM Dmitry Osipenko <digetx@gmail.com> wrote:
>>
>> 10.12.2021 21:09, Rafael J. Wysocki пишет:
>>> On Fri, Nov 26, 2021 at 7:02 PM Dmitry Osipenko <digetx@gmail.com> wrote:
>>>>
>>>> There is no need to annotate function prototypes with 'extern', it makes
>>>> code less readable. Remove unnecessary annotations from <reboot.h>.
>>>>
>>>> Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
>>>
>>> I'm not sure that this is really useful.
>>>
>>> Personally, I tend to respect the existing conventions like this.
>>>
>>> Surely, this change is not required for the rest of the series to work.
>>
>> Problem that such things start to spread all over the kernel with a
>> copy-paste approach if there is nobody to clean up the code.
>>
>> This is not a common convention and sometimes it's getting corrected [1].
>>
>> [1] https://git.kernel.org/linus/6d7434931
> 
> In separate patches outside of series adding new features, if one is
> so inclined.
> 

Alright, I'll drop this patch then because it can't be done in parallel
without creating the merge conflict. I'll try not to forget to come back
to this later on.
