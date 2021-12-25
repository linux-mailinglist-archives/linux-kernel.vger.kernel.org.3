Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B775D47F36D
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Dec 2021 15:38:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231887AbhLYOi2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 25 Dec 2021 09:38:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229884AbhLYOi0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Dec 2021 09:38:26 -0500
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 880F0C061401;
        Sat, 25 Dec 2021 06:38:26 -0800 (PST)
Received: by mail-ed1-x534.google.com with SMTP id bm14so43530300edb.5;
        Sat, 25 Dec 2021 06:38:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=gas+mk5kz+G9ppn3h9f4J9RG3FbqVjPn47iE2ucU3uM=;
        b=GZ8kWjlQv2WIzY4/QVYQvmAC72HIdFbUVf1v4gHjfuAgzPWH1ZsWJY0VvvhQQh1AR2
         sWZCz1tS6ShMWGoyb1xptq9wY+l71yzJGo49J/Bk7BH4RUcepqxQXn4IktlwM//kKve8
         kjkiA0wqWezkdWf8iR+P4qLBeHFWoSFG7pGWxmu6SUo3kctR3rWcmZ27ukTBqgVvzi/J
         p5gWUiNWusIcLPbSgcX6ti57pZa+twD+HUt7TqT4/1xvoJzxWVsL4AsNqKKuWBu1pB5d
         dlDjcfTJjhRsf/TZQK7uQKxBNcYjoixY8NGJ1Dfyz5nVARgknDCknWFqJbuBxUnQzgAj
         wuLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=gas+mk5kz+G9ppn3h9f4J9RG3FbqVjPn47iE2ucU3uM=;
        b=3bstskPBW9KGMlSvkeWzXvkrh1x6hK82PLs/thqLqZI2WErKd5KfA50Vn+CyXL+Qt5
         hVaPez3w9Z9ggA2fj7h5j43BoxF5t1gTxLuj5LcyGUsi0JNeQfVqEbUvihRJf+eBkVS7
         mFxjBe6X4h6j2B6fyPgzlTKVM5ilak90VYMXDfGa3KSwPrm7iZSUBpLx4d35/dT3fdhS
         KeOspIGwKNzQUXPxnUu/X9obdbdzA6fv1i6VQCisRFLig/KR/uCXsIJy2dHcIQKuaHos
         qVups7xjD1Drg5ypIPSyVx1v8OiliVy0XD6pI0ndsHntaac4jPK5qtYUi9V1/z3+TRI7
         32gQ==
X-Gm-Message-State: AOAM530Lt08TXz545wyLQFuZSViuTBEOFA2RF2N/yIuIWOVdy8wL0rIO
        M16jDUSdOD8vgpHgtv30I9RLj25IlbwVroz/vKA=
X-Google-Smtp-Source: ABdhPJyV2PHq40cZgaaY8zOtwav5vxdN7skSQ7I26dj8dXbcg3zUG6c6La7nxslPmVHXxWijbQHoBUfp/nR64K8XlVo=
X-Received: by 2002:a17:906:c450:: with SMTP id ck16mr8054007ejb.579.1640443104924;
 Sat, 25 Dec 2021 06:38:24 -0800 (PST)
MIME-Version: 1.0
References: <20211225115509.94891-1-hdegoede@redhat.com> <20211225115509.94891-5-hdegoede@redhat.com>
In-Reply-To: <20211225115509.94891-5-hdegoede@redhat.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Sat, 25 Dec 2021 16:37:48 +0200
Message-ID: <CAHp75VcnPJvprayX+B_nHEahbrSyvAORyD9dAuMJ9zEP+Jq3hw@mail.gmail.com>
Subject: Re: [PATCH 4/4] platform/x86: Add crystal_cove_charger driver
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     Mark Gross <markgross@kernel.org>,
        Andy Shevchenko <andy@infradead.org>,
        Lee Jones <lee.jones@linaro.org>,
        Stephan Gerhold <stephan@gerhold.net>,
        Platform Driver <platform-driver-x86@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Dec 25, 2021 at 1:55 PM Hans de Goede <hdegoede@redhat.com> wrote:
>
> Driver for the external-charger IRQ pass-through function of the
> Bay Trail Crystal Cove PMIC.

Intel Bay Trail (same in the code)

> Note this is NOT a power_supply class driver, it just deals with IRQ
> pass-through, this requires this separate driver because the PMIC's
> level 2 interrupt for this must be explicitly acked.
>
> This new driver gets enabled by the existing X86_ANDROID_TABLETS Kconfig
> option because the x86-android-tablets module is the only user of the
> exported external-charger IRQ.

...

>  drivers/platform/x86/crystal_cove_charger.c | 153 ++++++++++++++++++++

I'm wondering why it's not under the intel/ subfolder. Do we expect to
have the same PMIC used on other x86 vendors?

...

> +static int crystal_cove_charger_probe(struct platform_device *pdev)
> +{

Adding

  struct device *dev = &pdev->dev;

may increase readability a bit and perhaps reduce the amount of LOCs.

-- 
With Best Regards,
Andy Shevchenko
