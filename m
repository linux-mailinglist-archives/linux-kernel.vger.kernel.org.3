Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B6A3C53ABA7
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Jun 2022 19:17:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356276AbiFARRi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Jun 2022 13:17:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1356271AbiFARRf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Jun 2022 13:17:35 -0400
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8CFFD3CFDC
        for <linux-kernel@vger.kernel.org>; Wed,  1 Jun 2022 10:17:33 -0700 (PDT)
Received: by mail-ej1-x632.google.com with SMTP id n10so5139821ejk.5
        for <linux-kernel@vger.kernel.org>; Wed, 01 Jun 2022 10:17:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=eEvKI9LRLl6FpvqTZkyNXfQLv3DW+kcvWzRVQVXmZgA=;
        b=M/iee+vWOFJKRVAwFjjHYd8VjJ35MBnhmrSM+WlUGGoIJjOBra/VxR/aVCdwICnVuH
         l161nsL6sXwb3Y9pPTuGHP4zqiPzRUdfKKx54HEXn3Ftx4hRPpBDiEJt+UO08Gl9/Gn1
         J6RdtMRLbUDRSz7I2YBsIuPUHn+ft+Duy2rOJIUdzoouF3mUOwablP7hEUOvdfZzk8+A
         afwlhMCnBZU2tl6/mXyo+itZpAYbQcKWKol419S86Lstm7ZBL4ZfT2B+/kUgIu4kCBrj
         4h9sRsCBO57lf9F8KY3b216XaLj+xgeNFfUPUyaIuZM9uqbMueyqJSzzpzA2Rvm4+xYb
         WAMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=eEvKI9LRLl6FpvqTZkyNXfQLv3DW+kcvWzRVQVXmZgA=;
        b=TIa6cOXJ9izUtG8l/yQgajb6HQpVQzwiCG5O1u5NUcxhe8pDSlpCqjHTbnUEBOGm/p
         PHTFflEJ8SwWY/d1SSaYzD0Sasd13t+VmK8rtJ1AZRBG6qc2g+buLiCn9ULQnpNKu7Kh
         x0GMwmeAf7/Lv9iZ3TF7wr9ial0tr9eza/ReqzDtksH8tzERgB44wUXNyZEDBL9pzguq
         xTJuQTMtQFZvVd/+cnWh52bfVLZEkMlGkdN3cTEoXyPEZI1rebq40KHQE0vTCny1I6l+
         n4jXbI3exqX6fFeMuHrEkQnf/wu7THIIshVAdmQU8aG1S2sTEbrO/6z3kzMVlNmqOt3k
         0Ywg==
X-Gm-Message-State: AOAM5318anxPBfca7PsEuUrhFdkf0vCfsy7kY2N22HKn6Ya9tsdRe4NO
        FYcni5u0fAvf5QhQ5s+Z7YRRXH1rXYCD9fOiHCp5TA==
X-Google-Smtp-Source: ABdhPJzduNIr383tA6iutFh5LIcNleLCLxPfH8NaZe3yjuI5rgyu7WLoAOoju1TkTr00R1DV9+yipWElOEaHIwmLEkg=
X-Received: by 2002:a17:907:6e04:b0:6f4:d6f3:c72a with SMTP id
 sd4-20020a1709076e0400b006f4d6f3c72amr527663ejc.636.1654103852114; Wed, 01
 Jun 2022 10:17:32 -0700 (PDT)
MIME-Version: 1.0
References: <20220530115653.70423-1-andriy.shevchenko@linux.intel.com>
In-Reply-To: <20220530115653.70423-1-andriy.shevchenko@linux.intel.com>
From:   Bartosz Golaszewski <brgl@bgdev.pl>
Date:   Wed, 1 Jun 2022 19:17:21 +0200
Message-ID: <CAMRc=Mcwf1zVnGH4wM_Fzb68Ko2CviJJGdrxx60RKvU+RnK_ww@mail.gmail.com>
Subject: Re: [PATCH v1 1/1] MAINTAINERS: Update GPIO ACPI library to Supported
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        dave.hansen@linux.intel.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 30, 2022 at 1:57 PM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
>
> The actual status of the code is Supported.
>
> Reported-by: dave.hansen@linux.intel.com
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---
>  MAINTAINERS | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/MAINTAINERS b/MAINTAINERS
> index fd768d43e048..629ddf493555 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -8343,7 +8343,7 @@ M:        Mika Westerberg <mika.westerberg@linux.intel.com>
>  M:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
>  L:     linux-gpio@vger.kernel.org
>  L:     linux-acpi@vger.kernel.org
> -S:     Maintained
> +S:     Supported
>  T:     git git://git.kernel.org/pub/scm/linux/kernel/git/andy/linux-gpio-intel.git
>  F:     Documentation/firmware-guide/acpi/gpio-properties.rst
>  F:     drivers/gpio/gpiolib-acpi.c
> --
> 2.35.1
>

Applied, thanks!

Bart
