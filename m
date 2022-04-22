Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 643BD50C2BC
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Apr 2022 01:09:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233302AbiDVWhH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Apr 2022 18:37:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233252AbiDVWgn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Apr 2022 18:36:43 -0400
Received: from mail-yw1-x112e.google.com (mail-yw1-x112e.google.com [IPv6:2607:f8b0:4864:20::112e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4CB130851B
        for <linux-kernel@vger.kernel.org>; Fri, 22 Apr 2022 14:51:03 -0700 (PDT)
Received: by mail-yw1-x112e.google.com with SMTP id 00721157ae682-2eba37104a2so99294547b3.0
        for <linux-kernel@vger.kernel.org>; Fri, 22 Apr 2022 14:51:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=I6IucAW2vKmMlZoXu5E0+/gmEChaQTXcva9X1hww8Y4=;
        b=SGmEdvPf+mBAPoT9mdL6g4e+foKc3ZF0arakcfTnLOFRfmr9f+Mvu1BE/2iclcIlFc
         OXlCjRiiYgeivc6aYfz8pF50HM04OOwjOBMmqArl9wtTwzQ1L9mURCWZIw+Bb/Y7B1HP
         mtiI8WM2tM2hlMMnEoLRVQsVqsCT5YLY53HAKikQ11NiQ3Uz3dv+pUxQRnByLKmQ+wMQ
         q4/0IL8asW9p44fpkXSpm2x/c7a0B3a17mQLQHx4Ws74JuEJqASLf+D7YJlXQTlIr38g
         FbkdvszCD3YRDBn+bnTj9Fei8itEt3HdcH94tj/R6pn6zH+33Z+KfOHHwbjFdjqJ/sa5
         e44w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=I6IucAW2vKmMlZoXu5E0+/gmEChaQTXcva9X1hww8Y4=;
        b=cVzZi2U/E7cllsLy5QRh/iziYQokdgE24zbDa7x0UoZRsaIL5aLCGd0O6/t61BSLD5
         0p7o+NNDQftPojKAd7w0pSH40NeQuiadxVHfdNriZe/u9cHoOb3Ws9UKj7GCJidy6PWg
         XOm/ZzckSRIkpMi6WMbih+PZfEdRJEDzcV/DXIbAdAT7Myeeb5tiF8U/e59sq2pkyRa9
         rYBLErSLWky8Gh7O7DON316hqOEQw2Om/q5SsTf3WJ8UnQlgLzerPTzCsC48mpsk95iY
         h2uGUdSRAWpSnao1h/Nh2tC5K7qhf3fg9eUGj6XvlM6dUmu82sMKqhMxB05yCG16sGRY
         fuTw==
X-Gm-Message-State: AOAM532sk9baRzyw3/9YtnrJVDybb557pUPMC64lqQMk7VSPyZX/vFJ2
        Bf1Tup5pWAEOdASgyyEuaKtrFcyGewSiFOo0y18mHA==
X-Google-Smtp-Source: ABdhPJylKvNNvBwB+dFLvzQwhIDFpcwup6UmBKab4gJdVcRTbFZkzvRJostPnnffKRpr78h+kGA1q6K6XyEYwMdnxww=
X-Received: by 2002:a0d:c4c2:0:b0:2f1:6c00:9eb4 with SMTP id
 g185-20020a0dc4c2000000b002f16c009eb4mr7127206ywd.448.1650664263007; Fri, 22
 Apr 2022 14:51:03 -0700 (PDT)
MIME-Version: 1.0
References: <20220414214337.311880-1-linus.walleij@linaro.org> <f4deb182-ec18-6744-2c4c-adaed4ef7a33@collabora.com>
In-Reply-To: <f4deb182-ec18-6744-2c4c-adaed4ef7a33@collabora.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Fri, 22 Apr 2022 23:50:51 +0200
Message-ID: <CACRpkdbZnWJgkS2a0xXs_WG40jz6+aTSPt743Zigd0KZ8R=yww@mail.gmail.com>
Subject: Re: [PATCH] dt-bindings: gnss: Add Broacom BCM4751 family bindings
To:     Dmitry Osipenko <dmitry.osipenko@collabora.com>
Cc:     Johan Hovold <johan@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        David Heidelberg <david.heidelberg@collabora.com>,
        Svyatoslav Ryhel <clamor95@gmail.com>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 18, 2022 at 1:19 PM Dmitry Osipenko
<dmitry.osipenko@collabora.com> wrote:

> What are the chances of seeing the kernel driver for BCM4751+?

The kernel does not normally drive the GPS. The kernel has a small driver
dealing with hardware power on/off of the GPS and exposing
/dev/gnss0 to userspace.

See Johans lecture at:
https://events19.linuxfoundation.org/wp-content/uploads/2017/12/The-GNSS-Subsystem-Johan-Hovold-Hovold-Consulting-AB.pdf

>  There are
> myriads of Android devices using that GPS chip. Previously the
> proprietary firmware interface of BCM4751 was an obstacle for addition
> of the driver to upstream kernel, did anything change?

Actually there is nothing stopping us from anyway merging device tree
bindings, even if no driver is on the horizon for Linux. The DT bindings
are not a Linux kernel thing. Actually we merged bindings like that in
the past. It makes it possible to create complete device trees, which
is nice. A driver for Linux can be slotted in at a later point.

Anyway, that is the boring answer.

Many if not all GPS:es (as all Wireless chips) have proprietary firmware
interfaces. This is normal. GPS:es are special since by tradition the
stack using them is in userspace. There exist free software userspace
stacks for misc GPS:es.

gpsd is the most common userspace daemon for GPS.
gpsd will then talk to /dev/gnss0 as any other TTY IIUC.

Replicant has a free implementation of the "MEIF" API for this GPS,
I think what is needed is really for someone to pick up, polish and
contribute that to gpsd
https://git.replicant.us/contrib/PaulK/bcm4751/

Yours,
Linus Walleij
