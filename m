Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1C7DB55FCC3
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Jun 2022 12:01:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233214AbiF2KAM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Jun 2022 06:00:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229498AbiF2KAJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Jun 2022 06:00:09 -0400
Received: from mail-yw1-x1136.google.com (mail-yw1-x1136.google.com [IPv6:2607:f8b0:4864:20::1136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32BA42A25A;
        Wed, 29 Jun 2022 03:00:09 -0700 (PDT)
Received: by mail-yw1-x1136.google.com with SMTP id 00721157ae682-2ef5380669cso142807747b3.9;
        Wed, 29 Jun 2022 03:00:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=AmZBKNDZ9JJEaxR069F4ngBsnqm8GnGKSa6kFbcgKU0=;
        b=OTxyGnRPmX7vF8pfWyCAt8Gtds1qpvGFodDQnpkhk3fHeGdqCgbxeT4k9p/gP2AVth
         bLtmqnJJctspJZc+SnILEEOaLxl5U/ztH8c2yGM/rNbKBC0D0HX8vRZIfW2yXPUBHwZ/
         lBHt7b1M9VSLAZWfKPgDUzg9MDDvNSe2QA5swis/cgpQBeZuZutrAQNlRiWb6+VvmY8t
         b8cD1+LftTTdKf3kTg0iZOl2dibDe9ig70G3t0aO5T4MIgHNxLKys6t7GbpwOZFBLuBY
         N/oRybanAGp64Bna1/J2FjH0nI+q7UbXcMPsTXzoMwQWE2O+XdHS6h9Ip0MFfLN5Cjfm
         ZNcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=AmZBKNDZ9JJEaxR069F4ngBsnqm8GnGKSa6kFbcgKU0=;
        b=UbDMyzLaJd9VjyQuZPCaV/3hVATItr5zfHpyzJBOBXo9e64xYZAcf9MpWiUn0+Q6o4
         w+bY+4nHHvTG92zRxD3GP+EURTCo1XFBZLgAqiSzypROU7V7SMjKKPzJrGD2NcBmtYLZ
         wca+pGnOml1B1Ycsz7C/kp/s0XVzRpaMUk4RYjZ9/1LsKJg6ctCvoTpbeAUK224gE4Mg
         UFomczKuQteFYL4Hzo6H43vT6xDosY2qG4RXBGQT6Tc4HBBF1dl+S/EKHUwi4zEi1Uau
         oE+9mV0PkbIclNjnmpt0MOmYXmmDH5tIzMbYyjozPLK0fHicO3Cy5X+DfwmAsyzszWQ5
         V6sQ==
X-Gm-Message-State: AJIora8ti21OxH4NLJ5/nvqsurZCz/I2/DnvJPEZTey+CvUAsFRTFAE6
        ybHpv7D57wr8+EJbY7KzXn+4XDDkNttSBbCkp4aIETjUDiV6ww==
X-Google-Smtp-Source: AGRyM1tf+2+EhQVgTlB/QDVjwv1da1m24pj6iYh67kgkDXlV34Btf5jNG6mUUwM12HX09XIXFMcmSXubquTK2QZmaDY=
X-Received: by 2002:a81:2386:0:b0:317:6586:8901 with SMTP id
 j128-20020a812386000000b0031765868901mr2840596ywj.195.1656496808406; Wed, 29
 Jun 2022 03:00:08 -0700 (PDT)
MIME-Version: 1.0
References: <20220628193906.36350-1-andriy.shevchenko@linux.intel.com>
 <20220628193906.36350-3-andriy.shevchenko@linux.intel.com> <SJ0PR03MB6253C3D92FFF37717D48C7618EBB9@SJ0PR03MB6253.namprd03.prod.outlook.com>
In-Reply-To: <SJ0PR03MB6253C3D92FFF37717D48C7618EBB9@SJ0PR03MB6253.namprd03.prod.outlook.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Wed, 29 Jun 2022 11:59:31 +0200
Message-ID: <CAHp75VfR6XwW1HZDKoxhxs0i9R6s=uim1-dTtwJeXrA9AGWGQA@mail.gmail.com>
Subject: Re: [PATCH v1 3/3] gpio: adp5588: sort header inclusion alphabetically
To:     "Hennerich, Michael" <Michael.Hennerich@analog.com>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Sa, Nuno" <Nuno.Sa@analog.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>
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

On Wed, Jun 29, 2022 at 10:50 AM Hennerich, Michael
<Michael.Hennerich@analog.com> wrote:
>
>
>
> > -----Original Message-----
> > From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> > Sent: Dienstag, 28. Juni 2022 21:39
> > To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>; linux-
> > gpio@vger.kernel.org; linux-kernel@vger.kernel.org
> > Cc: Hennerich, Michael <Michael.Hennerich@analog.com>; Linus Walleij
> > <linus.walleij@linaro.org>; Bartosz Golaszewski <brgl@bgdev.pl>
> > Subject: [PATCH v1 3/3] gpio: adp5588: sort header inclusion alphabetically
> >
> > Sort header inclusion alphabetically.
>
> Thanks for the patches, they look good.
> However, Nuno is currently working on getting the irqchip support into the
> adp5588 input driver. In his patch series this driver is going away.
>
> https://lore.kernel.org/linux-input/YpMCh1Xje+jsny8j@google.com/

While that work is ongoing, and most likely won't make v5.20-rc1, for
the v5.20-rc1 I think my patches are good to go to avoid a bad (or
rather very old) example on how to do GPIO drivers. What do you think?

-- 
With Best Regards,
Andy Shevchenko
