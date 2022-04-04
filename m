Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2C0F14F1E07
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Apr 2022 00:24:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379265AbiDDV6W (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Apr 2022 17:58:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378971AbiDDQNP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Apr 2022 12:13:15 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 347A22F007;
        Mon,  4 Apr 2022 09:11:19 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id E5981B816F4;
        Mon,  4 Apr 2022 16:11:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B083AC34114;
        Mon,  4 Apr 2022 16:11:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1649088676;
        bh=g1nATVvrfRA9UAWKcn8TEmGbzT1FkE4IRDRHu7qz7aY=;
        h=References:In-Reply-To:Reply-To:From:Date:Subject:To:Cc:From;
        b=VSwR8cvth3rhQoDHXpPFJOTOxqEMHXQlSUTLUXb6RU4wYcgV0/JdJTLvfUj+2GHvt
         DH9Z/OFmu4v3KNmFPlfRokAjww5feArkOCxkKzSAtIlwEdW/MPKcdUhxU5pC4f0WMR
         oDYrDEEzr6HfdW8z9VvnabvqiUuTBQqNyblE/ngmsW27V/1IfZPTW6V8gV5nNyY3vn
         2jl4u5TdOtN8U3UnSPCjJBl+8KZJ/izn2Yg6xTdxx7vorsB8uoS9taApuSBSjWpMHa
         kTxb3m+TgOLzQXTk7xka6axCXQRtEXwjdnxPtAHSfOB4c9S6rjWOKQeDZodyzVz9ys
         qiCFE3gOxbjNw==
Received: by mail-vk1-f178.google.com with SMTP id g41so5082020vkd.4;
        Mon, 04 Apr 2022 09:11:16 -0700 (PDT)
X-Gm-Message-State: AOAM5310VxWnTeTw8D4wTKZEJSAf1T+YA90tsWQ89pAg9dBu5ZBL+8EG
        4GdWFwGT0ltl05xL2HDrS1ZFPMVp7KAKhyCxuFQ=
X-Google-Smtp-Source: ABdhPJw9D7xPURqCUzoTlu6KIHOEiOsweC/UpZ/sYIxrlCQYGzUkCyEMyxVMLWLuRCg1LkZf9inwiirxn0cn5uiwIiU=
X-Received: by 2002:a1f:6a82:0:b0:33f:7eeb:5989 with SMTP id
 f124-20020a1f6a82000000b0033f7eeb5989mr276390vkc.29.1649088675514; Mon, 04
 Apr 2022 09:11:15 -0700 (PDT)
MIME-Version: 1.0
References: <20220330190846.13997-1-wens@kernel.org> <20220330190846.13997-3-wens@kernel.org>
 <CABxcv==csvqsxM46ce2LecDh4E-UxxD2DG+3E-hCFoyrdtRv7A@mail.gmail.com>
 <CAGb2v64VQPjan=EUkd8UhRZfV0g1GqBwPqhxQakS=7YhgvVDQA@mail.gmail.com> <92a46ea2-e23e-b7c8-ea5f-35d458ee1b76@redhat.com>
In-Reply-To: <92a46ea2-e23e-b7c8-ea5f-35d458ee1b76@redhat.com>
Reply-To: wens@kernel.org
From:   Chen-Yu Tsai <wens@kernel.org>
Date:   Tue, 5 Apr 2022 00:11:05 +0800
X-Gmail-Original-Message-ID: <CAGb2v66zj4x7zx4ht+6ojjKRxEe+M4bTc_mKRgf8wd_TK+Wf4g@mail.gmail.com>
Message-ID: <CAGb2v66zj4x7zx4ht+6ojjKRxEe+M4bTc_mKRgf8wd_TK+Wf4g@mail.gmail.com>
Subject: Re: [PATCH 2/4] dt-bindings: display: ssd1307fb: Add entry for SINO
 WEALTH SH1106
To:     Javier Martinez Canillas <javierm@redhat.com>
Cc:     Javier Martinez Canillas <javier@dowhile0.org>,
        Maxime Ripard <mripard@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        devicetree <devicetree@vger.kernel.org>,
        Linux Kernel <linux-kernel@vger.kernel.org>,
        dri-devel <dri-devel@lists.freedesktop.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 4, 2022 at 11:48 PM Javier Martinez Canillas
<javierm@redhat.com> wrote:
>
> Hello Chen-Yu,
>
> On 4/4/22 17:06, Chen-Yu Tsai wrote:
>
> [snip]
>
> >>>      enum:
> >>> +      - sinowealth,sh1106-i2c
> >>
> >> I like that you didn't include a "fb" suffix for this, the existing
> >> ones are cargo culting from the previous fbdev driver to make existing
> >> DTBs compatible with the DRM driver.
> >>
> >> I've been thinking if I should post a patch to compatible strings
> >> without the "fb" and mark the current ones as deprecated...
> >>
> >> Reviewed-by: Javier Martinez Canillas <javierm@redhat.com>
> >
> > I also thought about dropping the "-i2c" suffix, but then thought
> > there might be a case where someone wanted to search the device
> > tree specifically for an I2C connected node using said compatible
> > string.
> >
> > What do you think?
> >
> >
>
> tl; dr: unfortunately we can't do it due how SPI and I2C report module
> aliases. Otherwise module auto loading will not work. I wrote a much
> longer explanation with some details not so long ago:
>
> https://patchwork.kernel.org/project/dri-devel/patch/20220209091204.2513437-1-javierm@redhat.com/#24730793

Right. I think that crossed my mind at some point, but didn't stick.
Thanks for raising it again. :)

> BTW, I bought a SSD1306 SPI controller and go it working this weekend.
>
> I plan to post the patches once yours land, to avoid in-flight series
> that may conflict. And what I did is mark the -fb as deprecated, then
> added "ssd130x-i2c" and "ssd130x-spi" compatibles strings.
>
> The WIP patches can be found here in case you are interested:
>
> https://github.com/martinezjavier/linux/tree/drm-ssd130x-spi

I took a quick look and a couple things stood out:

1. Would 3-wire SPI ever be considered? If so, might want to
   rename some of variables/functions as *_spi_4wire_* to
   begin with.

2. Maybe we should move the ssd130x_deviceinfo stuff into the
   core module, and define an enum to use for matching compatible
   strings across the modules to their respective device info
   entries? FYI we are doing this in drivers/mfd/axp20x* .

I think a friend of mine has a SPI based SH1106 module that I
could borrow and test/work on, but that's a big if.


Regards
ChenYu
