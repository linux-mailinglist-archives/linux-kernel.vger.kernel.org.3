Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 425DE4B7DE0
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Feb 2022 03:51:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343759AbiBPCbv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Feb 2022 21:31:51 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:39070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236576AbiBPCbr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Feb 2022 21:31:47 -0500
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C6A5996BE
        for <linux-kernel@vger.kernel.org>; Tue, 15 Feb 2022 18:31:36 -0800 (PST)
Received: by mail-pl1-x62e.google.com with SMTP id w20so863103plq.12
        for <linux-kernel@vger.kernel.org>; Tue, 15 Feb 2022 18:31:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=tMSwIfjOv1Uyh0Rn8c3FPvnNt2awh1M6+sjpagFNNPs=;
        b=MrvjeIXCQ0Ol/ZNcfXLD9ryra3Lxo0LuahOeXNhhVa8XVLk1mUyCn13YOkRJMEu7rU
         /IiaUHNDr77cLli/X5P8Akq/dF6VCwimLY3cWD9peCVXcnFV56IY9C7gNqaju6Y/YLy3
         eWTGx5T7KUECG4JNaraqfYDi4uVSFg/kF5Iv+0n6BeHzpnTgQ2e9eIrsYZF3XfWZ3GhB
         WuEwHitGwU6yPS5Z7i9bu7dfGGKty0EU7dChAqeZ/QpqjScnH0TkUWB4Mm5UyxLYNufD
         qI3yU6sUDxkiD/3h9BfUlAfCRDkDWa7tEV0xEIg4ifAS6TMM+5ZGqlOi2GdVTXx1/dcO
         Nq9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=tMSwIfjOv1Uyh0Rn8c3FPvnNt2awh1M6+sjpagFNNPs=;
        b=KxVm97Gs7UDNlE9rEWhjjZJh7wgzL1qPM+rSTSC1DOjeVy786OB/QcH1rVMJ9cgraB
         G/Ecs0Q5K7JQa243Qr1I3VeySo3glVO9DJ6htqoh6+FGhbKWfRIdGoihNIhQSdkzOUYT
         Jx5IKMCACB7rRB3MKuVJGCUN17lbj8Zg3WiOPgtVEotE6ytxjkYQlTGajsyfi4RHpa9T
         QGeCfsvTgyzXuFfxPreJ4m6xbn8RNbLMis5OAOnEuJMHWbNnWrslN6DR1EopoX68WxDS
         xccqdDnN0hruq4fn6c0D2phxXU3uf3Rv31G6MQ8OU++nKBZMr79eKJ4y9Eiiy0tClNs/
         L+qA==
X-Gm-Message-State: AOAM532vZK6G/w67lgKuGP5jwnbC7znkg5HARqCxQfxjd/KlRRecDCii
        6DiTAg69ToitCREy02t6V4DHTw==
X-Google-Smtp-Source: ABdhPJyU2ukSn0pACLz1YQlEvjfxSBDTqZwAmjsrkqyhGVLNZmkSRDuKwLpWoQymGsMeVVJJ0nyyig==
X-Received: by 2002:a17:902:82c7:b0:14f:252d:67e7 with SMTP id u7-20020a17090282c700b0014f252d67e7mr777069plz.27.1644978695666;
        Tue, 15 Feb 2022 18:31:35 -0800 (PST)
Received: from google.com ([2401:fa00:1:10:adf7:46e7:cef5:ba49])
        by smtp.gmail.com with ESMTPSA id 7sm18442035pjo.45.2022.02.15.18.31.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Feb 2022 18:31:35 -0800 (PST)
Date:   Wed, 16 Feb 2022 10:31:32 +0800
From:   Tzung-Bi Shih <tzungbi@google.com>
To:     Prashant Malani <pmalani@chromium.org>
Cc:     bleung@chromium.org, groeck@chromium.org, robh+dt@kernel.org,
        chrome-platform@lists.linux.dev, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 4/5] platform/chrome: cros_kbd_led_backlight: support OF
 match
Message-ID: <YgxiBO7jDtyhWwlb@google.com>
References: <20220214053646.3088298-1-tzungbi@google.com>
 <20220214053646.3088298-5-tzungbi@google.com>
 <CACeCKac+b1Rp6bZFALn=sbh8gkJbWeKTC=8bdzp+-90pgq=wSw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CACeCKac+b1Rp6bZFALn=sbh8gkJbWeKTC=8bdzp+-90pgq=wSw@mail.gmail.com>
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 15, 2022 at 05:10:04PM -0800, Prashant Malani wrote:
> On Sun, Feb 13, 2022 at 9:37 PM Tzung-Bi Shih <tzungbi@google.com> wrote:
> > diff --git a/drivers/platform/chrome/cros_kbd_led_backlight.c b/drivers/platform/chrome/cros_kbd_led_backlight.c
> > index 814f2b74c602..ba853e55d29a 100644
> > --- a/drivers/platform/chrome/cros_kbd_led_backlight.c
> > +++ b/drivers/platform/chrome/cros_kbd_led_backlight.c
> > @@ -10,6 +10,7 @@
> >  #include <linux/kernel.h>
> >  #include <linux/leds.h>
> >  #include <linux/module.h>
> > +#include <linux/of_device.h>
> >  #include <linux/platform_device.h>
> >  #include <linux/slab.h>
> >
> > @@ -128,8 +129,11 @@ static int keyboard_led_probe(struct platform_device *pdev)
> >         int error;
> >
> >         drvdata = acpi_device_get_match_data(&pdev->dev);
> > -       if (!drvdata)
> > -               return -EINVAL;
> > +       if (!drvdata) {
> > +               drvdata = of_device_get_match_data(&pdev->dev);
> > +               if (!drvdata)
> > +                       return -EINVAL;
> > +       }
> 
> I'm not familiar with this driver, so can't do a full review, but
> shouldn't device_get_match_data()
> from property.h [1] be able to handle both DT and ACPI cases?
> 
> [1]: https://elixir.bootlin.com/linux/v5.17-rc4/source/include/linux/property.h

Yes, it does[2][3].  Thanks for the feedback, will fix it in next version.

[2]: https://elixir.bootlin.com/linux/v5.17-rc4/source/drivers/of/property.c#L1474
[3]: https://elixir.bootlin.com/linux/v5.17-rc4/source/drivers/acpi/property.c#L1386
