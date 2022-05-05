Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3DBF051C2FB
	for <lists+linux-kernel@lfdr.de>; Thu,  5 May 2022 16:51:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1380817AbiEEOyr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 May 2022 10:54:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240860AbiEEOyo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 May 2022 10:54:44 -0400
Received: from mail-yb1-xb36.google.com (mail-yb1-xb36.google.com [IPv6:2607:f8b0:4864:20::b36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 073AC2EA
        for <linux-kernel@vger.kernel.org>; Thu,  5 May 2022 07:51:05 -0700 (PDT)
Received: by mail-yb1-xb36.google.com with SMTP id m128so8028394ybm.5
        for <linux-kernel@vger.kernel.org>; Thu, 05 May 2022 07:51:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=NqjwoR4LlPEXRPjbSlmaKFR3JQ3ccpO0IwpzOZEqSNc=;
        b=B6x3nqirj4jKgqwkXJ65eiR28GcKrtSEJZH9DLcTY7++7qa9LC/aG4yVzZ+rRcylJP
         v62bGcO2lD2VyMZYvfCW5WeXr+/jXBH0cZT9vavqV9RhuW7wDQlRMoXk6YxXXGWQPUUU
         baqR18caYVdlkM+npbZkkZCBidc7sXGmS9b8krjkLU0M/xYnShGIOZzvX5t24Iuh4uVI
         F1s84M0OigPNk03gZmGW7QOzuTCf0x64m3PmmztfwLuc9Y0xlxXQwNk7lhHMNi3qaKqM
         klihp8hNbJgYsU7dDD2l1IGBmwImn3GpTEzlWQREmo36WU6+k6sAOtzkCc+QyZH557e1
         DEXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=NqjwoR4LlPEXRPjbSlmaKFR3JQ3ccpO0IwpzOZEqSNc=;
        b=wEY0fjKV4E9FV6tFn6sBQMPL291HUpQnYITVC4M37X/pBBCE1DTSEXI/K22GZdkI7p
         Bt5d2lZUFIpG0clvdfFGZS4YlnbJoGqvttorpADP1VHK2vCzJxvcbNGSDEdAZbL+BwXf
         OisYMLOF+xUITvJ8y+kOAaK+0U7RDoy1thCyYNOBAtN4yqX+3kCOHp0R9/XgvcpqNwqZ
         hEBC4GuNYDLA0VO+RsH1NlsAz+lKeUhwwHsx2qcLWtaaCdW7QSXIinXxkNrPMEA+N33C
         Q7dQ/lEmBl74418e5K0/4tk1Xg3cRYaYV0f0rtoi/HnVb6O4aVqICBUmnLkUBAceEK9w
         glFw==
X-Gm-Message-State: AOAM531Dm3/EofExmbpCs7Zer5yxYo6Pu62ePjhFzyZwlYU0FOL5Dh22
        +vIEfSdnGz39UHZL4a67Fic699UvsTYehcyGjgOoFg==
X-Google-Smtp-Source: ABdhPJzZtXGIA9v0MMiWZ4u+vtplZESU8b+FGk7W8udNaOea1IQGb1mGALrc3XNrMX6cmsg6QqM6DjwL3LWS1FGLXNM=
X-Received: by 2002:a25:2905:0:b0:649:7a2b:ca72 with SMTP id
 p5-20020a252905000000b006497a2bca72mr15732697ybp.492.1651762264271; Thu, 05
 May 2022 07:51:04 -0700 (PDT)
MIME-Version: 1.0
References: <20220419141846.598305-1-maz@kernel.org> <CACRpkda3L_itpqcnPq6xDoJtNHt8NuvE1MZk1bCNR+u2KKUpBA@mail.gmail.com>
 <874k2kccse.wl-maz@kernel.org> <CACRpkdb32NuJ8jdsk6ox7ViVjK=9WWWavS=aYcoWTCbaO3WkTg@mail.gmail.com>
 <CAMRc=MdwbzkpL5Vm2aEXVPKzj78GsFStk+3uZexyrJMB468U4g@mail.gmail.com>
In-Reply-To: <CAMRc=MdwbzkpL5Vm2aEXVPKzj78GsFStk+3uZexyrJMB468U4g@mail.gmail.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Thu, 5 May 2022 16:50:52 +0200
Message-ID: <CACRpkda3jPMj5ZgyXsaq34sW9E9n-t8A_BHUZbVsfxc7E=j3Aw@mail.gmail.com>
Subject: Re: [PATCH v3 00/10] gpiolib: Handle immutable irq_chip structures
To:     Bartosz Golaszewski <brgl@bgdev.pl>
Cc:     Marc Zyngier <maz@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Joey Gouly <joey.gouly@arm.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Hector Martin <marcan@marcan.st>,
        Sven Peter <sven@svenpeter.dev>,
        Alyssa Rosenzweig <alyssa@rosenzweig.io>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Jeffrey Hugo <jeffrey.l.hugo@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Basavaraj Natikar <Basavaraj.Natikar@amd.com>,
        Shyam Sundar S K <Shyam-sundar.S-k@amd.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        linux-tegra@vger.kernel.org,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        linux-arm-msm@vger.kernel.org, kernel-team@android.com
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

On Thu, May 5, 2022 at 2:58 PM Bartosz Golaszewski <brgl@bgdev.pl> wrote:
> On Wed, May 4, 2022 at 11:22 PM Linus Walleij <linus.walleij@linaro.org> wrote:
> >
> > On Sat, Apr 23, 2022 at 12:30 PM Marc Zyngier <maz@kernel.org> wrote:
> >
> > > > Bartosz: if you're happy with this can you apply it to an immutable branch
> > > > from v5.18-rc1 and merge that into the GPIO for-next and then I can also
> > > > pull that into pinctrl?
> > >
> > > For what it is worth, I've pushed this branch into irqchip-next.
> > >
> > > You can pick it up from:
> > >
> > > https://git.kernel.org/pub/scm/linux/kernel/git/maz/arm-platforms.git/log/?h=irq/gpio-immutable
> >
> > Bartosz are you pulling this? Most of the changes are in GPIO.
> > Patches have started to arrive that go on top of these changes
> > so would be nice to have it in both GPIO and pin control as a
> > baseline.
> >
> > Yours,
> > Linus Walleij
>
> Yes! Sorry for the delay. Pulling now.

Excellent, pulled it into pincontrol as well.

Yours,
Linus Walleij
