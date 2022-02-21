Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DF1724BEBFE
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Feb 2022 21:41:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233890AbiBUUl6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Feb 2022 15:41:58 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:55620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229929AbiBUUl5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Feb 2022 15:41:57 -0500
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD447237E2;
        Mon, 21 Feb 2022 12:41:33 -0800 (PST)
Received: by mail-ej1-x630.google.com with SMTP id gb39so36273825ejc.1;
        Mon, 21 Feb 2022 12:41:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=kllIKaEP4ASYUGo7rizKiRa0ECvHNSY0zpurb7azwtM=;
        b=NTYNErI+B4N/iyG4EIeQ19fiwh6NFceTnj/4C7jF960lYdT+aWuyYAcybrIbaTVQoc
         W4AM/51UUt0adUcPS9ZNucs2ccZbxHIzx4zPS8RZbn2dzrW6oqMi7/vXAtkjPRj75SdN
         nE68D7M2oyUZDYfUFBxiyp6di4CAnG0305IAZMfn63aGszk+SShrsDxe5pSuOqGTCA/W
         TjIVQtuUTtKJ+wv/7QS6nF6VWGgSigguXpgIluAHfmR09DTQ2N9xJJqQjXq+8stH66/R
         30M8YqaIET4ml4FY94FD9HahCVfCj+9C2Ms5Ayu3pWrzzt9RNJtlX2LGMsJh9DSunlmd
         fiiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=kllIKaEP4ASYUGo7rizKiRa0ECvHNSY0zpurb7azwtM=;
        b=k1S7N/DIgIQaa6UpO/LSdS0zZYYZzwacyJn2YoddJqyFLyR1wC8G0lyRb/rVz/7Kbm
         N74E2TlRh8TkCQRvZB4+YMJGImkYnYY9Q0toszDGor3nR79j2xGJCXXlX2n4sZsBgTDD
         Bf9NkP3FO5KIYksViaKo/8OS4h1mT1l2wh2i2FMSTwrAM1fZkx7VxqCyl2uCeAaVKqmi
         KhgIWdoS0vJNTtuz7z/J8afxyXB/o1lAd1Ct8CInXK5fGWdGoJVKep/aIPWHEtkaItEE
         ILqVhhJd8Y47EpNPmpXBY5qVZElaziTF5CCj9XNS+SipZTSXJmc+4/RVjwHC9i0iXEUv
         MV0g==
X-Gm-Message-State: AOAM530BfUCrVlAdb68JrF1TYhHSnWEjdN7OTAM9ULXy7c0nvbTwSmlj
        HrAkD23OZBEHXRCQd+uFFiARH320Eh44IBRNJ8HNO4xCh7jjkQ==
X-Google-Smtp-Source: ABdhPJzmii9X8gVhdxnj0kbhKWqpf58dIwRlx7ia37K4HtzJf9O31hc3c62wowh2zdNGRdQeX7LzLv6GNbrR33fh5RQ=
X-Received: by 2002:a17:906:cc12:b0:6b5:ec8f:fdf2 with SMTP id
 ml18-20020a170906cc1200b006b5ec8ffdf2mr16739434ejb.579.1645476092274; Mon, 21
 Feb 2022 12:41:32 -0800 (PST)
MIME-Version: 1.0
References: <20220218042038.15176-1-jagathjog1996@gmail.com> <20220218042038.15176-4-jagathjog1996@gmail.com>
In-Reply-To: <20220218042038.15176-4-jagathjog1996@gmail.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Mon, 21 Feb 2022 21:40:56 +0100
Message-ID: <CAHp75VdFnkz4iL4BH1COdOxBGkaeAA58+A87KqnC6d-p+GfGbA@mail.gmail.com>
Subject: Re: [PATCH v3 3/6] iio: potentiometer: Add channel information in
 device data
To:     Jagath Jog J <jagathjog1996@gmail.com>
Cc:     jic23@kernel.org, lars@metafoo.de, sst@poczta.fm,
        robh+dt@kernel.org, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
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

On Fri, Feb 18, 2022 at 5:20 AM Jagath Jog J <jagathjog1996@gmail.com> wrote:
>
> Adding each device wiper count and channel information into
> device private data.
> Utilizing addr member of struct iio_chan_spec to get the
> wiper register address so that the value can be read or write
> to the same address.

Looks much better!

...

>  static const struct ds1803_cfg ds1803_cfg[] = {
> -       [DS1803_010] = { .avail = { 0, 1, 255 }, .kohms =  10, },
> -       [DS1803_050] = { .avail = { 0, 1, 255 }, .kohms =  50, },
> -       [DS1803_100] = { .avail = { 0, 1, 255 }, .kohms = 100, },
> +       [DS1803_010] = { .wipers = 2, .avail = { 0, 1, 255 }, .kohms =  10,
> +                        .channels = ds1803_channels,
> +                        .num_channels = ARRAY_SIZE(ds1803_channels) },
> +       [DS1803_050] = { .wipers = 2, .avail = { 0, 1, 255 }, .kohms =  50,
> +                        .channels = ds1803_channels,
> +                        .num_channels = ARRAY_SIZE(ds1803_channels) },
> +       [DS1803_100] = { .wipers = 2, .avail = { 0, 1, 255 }, .kohms = 100,
> +                        .channels = ds1803_channels,
> +                        .num_channels = ARRAY_SIZE(ds1803_channels) },
>  };

Now, you may see you touch still the lines that are not changed, so
consider in the _previous_ patch to define each entry like the
following:

  [DS1803_...] = {
    .avail = {...},
    .kohms = ...,
  },

-- 
With Best Regards,
Andy Shevchenko
