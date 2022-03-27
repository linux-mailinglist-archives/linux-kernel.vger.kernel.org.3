Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5F8604E89CD
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Mar 2022 21:44:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236543AbiC0TqK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 27 Mar 2022 15:46:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229610AbiC0TqJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Mar 2022 15:46:09 -0400
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC72323170;
        Sun, 27 Mar 2022 12:44:29 -0700 (PDT)
Received: by mail-ej1-x62a.google.com with SMTP id bq8so10698120ejb.10;
        Sun, 27 Mar 2022 12:44:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=zhuTAmcQh3Mb70VN1/m7Yr+YC3+zWm/ZD73wfJzKq4M=;
        b=KWGeQUYdepismIBtbV4K53pjda/yCcMevRiaEUJFHHjLrtMhLz2ug+ORzUMsGEr1Py
         6tZz1crUTmiOIf1hd3wjE66w0Q6SlfEg7X8Tox8P+tqHNQhTQEtTUb2u3fRGscurm54C
         RH3QaZG/CLxEATYV5HMwnb3eiN/ccpRVgbGUHq8nCrbRifQEjKK31nvN1j6VsOVG9+Il
         8yvA5gMZ+dQT/QRD0/jjOIfdpO/lI1s4DlgLfE2fTZEi5rIm5Ci01uX/UICziVxE/g1X
         fVKQrAOTnxu9hfBrEsn8Fe2EkdE9JwIP/j+5Qs1V5aKKg9VbVsv+z+aAPGixbRZTw/iV
         rsuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=zhuTAmcQh3Mb70VN1/m7Yr+YC3+zWm/ZD73wfJzKq4M=;
        b=I/fimX/Ltit7dQIJyc0Nf0P/CXV+68lbfy7qxpsskrB+eW74QoLH+H3kFieZZhY+Yl
         BJzC7VV+4D56HR+38g0xoAxa0GPAQtq/29WEWiOShTFKgnlcjD/3MgdrUnz48TX5iL/k
         MdP+CYySfb43utKaoOH/B+OihJa90ZJq0iwxbu/aWHXJ35i8632ecrRmxpmDOPsC++S+
         Cm8KIWQRROYNuB7FY65Fg5wGw9ocgufJ0eoTyqdK/UgTwkmSAaXmnElf3JTBNlziIwjc
         JLvRObz70+EpFGFlPsrxOb+8jSCbAlKjOsKcguoWMFkhUZhBfDQcyUE5jZ+GS8aBXN0s
         qKvQ==
X-Gm-Message-State: AOAM530Syz83op43/rjcookwCsVzW+i6i9E5/eApqxMYmmfK6jCDpsk7
        ANiv5ZIbr9w0CIyXEE/GWIMrpdlz6S5Qvqgqjs0EOaCh2b8=
X-Google-Smtp-Source: ABdhPJyA69v6Xkdfk38D6uzZ+kwWKDom6mn/SgOuTd6Vd3JgOBkEXRG4+s5c2O+31Awz20dWxM7bZrP6n+ViIANlBto=
X-Received: by 2002:a17:907:160b:b0:6e1:116e:7a59 with SMTP id
 hb11-20020a170907160b00b006e1116e7a59mr1033373ejc.579.1648410268546; Sun, 27
 Mar 2022 12:44:28 -0700 (PDT)
MIME-Version: 1.0
References: <20220326194146.15549-1-jagathjog1996@gmail.com> <20220326194146.15549-5-jagathjog1996@gmail.com>
In-Reply-To: <20220326194146.15549-5-jagathjog1996@gmail.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Sun, 27 Mar 2022 22:43:52 +0300
Message-ID: <CAHp75Ve+PZcerhBX6-sjHJKOwF1b1n0gtNPA4aPRs1+ffvTVVA@mail.gmail.com>
Subject: Re: [PATCH v2 4/5] iio: accel: bma400: Add separate channel for step counter
To:     Jagath Jog J <jagathjog1996@gmail.com>
Cc:     Dan Robertson <dan@dlrobertson.com>,
        Jonathan Cameron <jic23@kernel.org>,
        linux-iio <linux-iio@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Mar 26, 2022 at 9:41 PM Jagath Jog J <jagathjog1996@gmail.com> wrote:
>
> Added channel for step counter which can be enable or disable
> through the sysfs interface.

...

>  #include <linux/mutex.h>
>  #include <linux/regmap.h>
>  #include <linux/regulator/consumer.h>

Since it will be a new version of the series, please add a blank line here.

> +#include <asm/unaligned.h>

-- 
With Best Regards,
Andy Shevchenko
