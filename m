Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A20B95192E0
	for <lists+linux-kernel@lfdr.de>; Wed,  4 May 2022 02:37:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244719AbiEDAlT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 May 2022 20:41:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240868AbiEDAlQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 May 2022 20:41:16 -0400
Received: from mail-yw1-x1131.google.com (mail-yw1-x1131.google.com [IPv6:2607:f8b0:4864:20::1131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DCBA837A06
        for <linux-kernel@vger.kernel.org>; Tue,  3 May 2022 17:37:42 -0700 (PDT)
Received: by mail-yw1-x1131.google.com with SMTP id 00721157ae682-2f7c424c66cso652797b3.1
        for <linux-kernel@vger.kernel.org>; Tue, 03 May 2022 17:37:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=nathanrossi.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=4MZ00p5oL0T/K1d5Kz56mw9WiTdPcYhxPhDPq7hOSPI=;
        b=HewJg9ub8AsshDtfE7sNka5iXKv6qInu887BoaVtnsWkooWEr1IyNyFlJAxSEgnh3i
         GD9Brf/yYzmSx2+XSJRnd3LjDnReqRG66AEoSVchueR5SkbOsIcfazGWC5FAtiIXoYaL
         N6mNgkzDBkd9ensViQ+bzdZqYRvoGSa7/0DhUJdsGuo0mdS9TuL+JRUZo6aIpS5Gs2UZ
         5EP2u+b6JimCVBREJSk+oDdA5GjPJlJal0IQrVdqzznDorfA+3xCqgOxyrEQ3kWDTYj/
         /nSmRPysx+fPK8mYhtJh/j2W6BLvBbiJ4lgggYnY+NqdywXGa1y7C1A9lN97yctBL2n+
         xVKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=4MZ00p5oL0T/K1d5Kz56mw9WiTdPcYhxPhDPq7hOSPI=;
        b=GkGa0TW6eFwxQRQUzWXsWoeyFjJ3hISfe3mKcVVAaoWGtmoU2kqqUeJrZm1JMlvFQu
         EegSqgoK8M+R9sR8pKmqc1n5d1cQsgfm6vpB0btS/pyonlORMVKsDlImS/HQDnn3MJYM
         sfqb0H55/ZBuv5VDDY/HZYUtfF+fLUwPxwajboe1Z2DJXTIDzmqKTbPMl7qQUR5UoxQ8
         B4jGxvWtqrJk3WZ7DGGj9K2H5womb/i+b1yNGkrZ/mp2i+kIickUeLYGfG1w3WNK6cOt
         8t5IZLM6QA9wP5xFQ99LgudvzIGOYJOh4liwrt/hdGcq2miJitx3f+zv52labekR+hL9
         T2gQ==
X-Gm-Message-State: AOAM530JVZAiecZbZtOvyJuBu8HYeuClnf2WKgLKHMOSxOgBUDqIthc/
        adU6V5nXuAcG2hL5nSy5zIYBWvF6k7Px4USaFPubKQ==
X-Google-Smtp-Source: ABdhPJxyD276MXH4iz3SViKgmmCN3bDHobUxJ1F7r0v6lFm7XsUy1EqfvZf8C7I2ACtcT9TNmQ4tSBmAtyC/t3i0JEU=
X-Received: by 2002:a81:9d5:0:b0:2f4:dd93:4513 with SMTP id
 204-20020a8109d5000000b002f4dd934513mr17021843ywj.54.1651624662078; Tue, 03
 May 2022 17:37:42 -0700 (PDT)
MIME-Version: 1.0
References: <20220421015728.86912-1-nathan@nathanrossi.com>
 <87mtgfgx7d.wl-maz@kernel.org> <CA+aJhH026fR5p6-JBaoQikZwC1F-iLBQWrqAvagauKjQoOqykQ@mail.gmail.com>
 <87fsm6ahnh.wl-maz@kernel.org> <YmFJ4zKn/9MpjhOh@lunn.ch> <CA+aJhH1uRWrW1+WJiWoH7pge49gc=SvWQ1L+UpLk+Hin5eo4uQ@mail.gmail.com>
 <YmKdajB8ufVz5meG@lunn.ch> <CA+aJhH27-TkorTqKVYBvHLz-8-0Pkbmjvx+aekb-24N75OAAKg@mail.gmail.com>
 <YmQnoQhrcbEzst/J@lunn.ch>
In-Reply-To: <YmQnoQhrcbEzst/J@lunn.ch>
From:   Nathan Rossi <nathan@nathanrossi.com>
Date:   Wed, 4 May 2022 10:37:30 +1000
Message-ID: <CA+aJhH3jd=K3W4VEjzgroY1Du5kQ7n4+bDbJj-mwkRKmJ7tcyw@mail.gmail.com>
Subject: Re: [PATCH] irqchip/armada-370-xp: Enable MSI affinity configuration
To:     Andrew Lunn <andrew@lunn.ch>
Cc:     Marc Zyngier <maz@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Nathan Rossi <nathan.rossi@digi.com>,
        Gregory Clement <gregory.clement@bootlin.com>,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 24 Apr 2022 at 02:21, Andrew Lunn <andrew@lunn.ch> wrote:
>
> On Fri, Apr 22, 2022 at 10:58:23PM +1000, Nathan Rossi wrote:
> > On Fri, 22 Apr 2022 at 22:19, Andrew Lunn <andrew@lunn.ch> wrote:
> > >
> > > > If you have a PCIe device that you can use with the 370 rd.
> > >
> > > Sorry, nothing on its bus.
> > >
> > > The only device i have which might make sense testing is a
> > > WRT1900ac. That has an Armada XP dual core. I could try building a UP
> > > kernel for it, but i guess you have tried that already with your
> > > machine in order to test a UP setup?
> >
> > I have tested with SMP=n on a Armada 385 without any issues. So no
> > need to do that on the Armada XP.
> >
> > There is still value in testing on the WRT1900ac device since so far I
> > have only tested on a Armada 385. The Armada XP does have
> > registers/etc. of the MPIC very similar to the 370, compared to the
> > 385 having some significant differences. So if it is not too
> > problematic to test on (it appears to have its wifi attached via
> > PCIe?) please do.
>
> Hi Nathan
>
> Turns out the WiFi drivers are in a sorry state. There is no mainline
> driver. There is an OpenWRT driver, but it has not been updated for a
> few years, tries to use get_fs() set_fs() pci_map_single() etc.
>
> I've mostly used this platform for Ethernet switch development, so
> i've never tried the WiFi before. I had no idea it was so broken...
>
> So sorry, i cannot test this.

Thanks for giving it a try.

I managed to source an existing one of our products that uses an
Armada 370 with a PCIe device attached. Took me a bit to get a recent
kernel booting on it, however I was able to confirm that this MSI
affinity change works correctly on the 370 SoC (with and without
CONFIG_SMP).

Regards,
Nathan
