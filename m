Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9AB21516B68
	for <lists+linux-kernel@lfdr.de>; Mon,  2 May 2022 09:48:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1383596AbiEBHvz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 May 2022 03:51:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1358886AbiEBHvw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 May 2022 03:51:52 -0400
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB1E929CB4;
        Mon,  2 May 2022 00:48:24 -0700 (PDT)
Received: by mail-ej1-x62f.google.com with SMTP id k23so26274619ejd.3;
        Mon, 02 May 2022 00:48:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=4+JqnNYbdTySkdzdeBZlUTvL7wp3wUNy6SficKihTqg=;
        b=k71jvTwvwxhCF1t5yCzU3c6CVQHWEYDRt92r23U7g6cIpffTYeyn//gYFW+9GFTYfQ
         Uza9PAjMloyWu3rKMbW9CIDtiqrnPb9m9w89RVipPDXTtJ51XYm+AsjQxs9V8vwqlYhV
         D7+rPI9NV8lb6jii11rr6h/GIWBffU+KhkVis4Uhvyoo3zZGAmlOMIp/3H2WAAQs7BNU
         NpmLNKt/OgyJZkPEsbeDfpU3QqfRLp5VPR9nz3o/RzjkrJkLx9ODdvfY+EX8UGnXUTdm
         oe3+auK49L9NH1zJgOlffeC7+F/rLu7ZBDftUCLEkRK5yuSECdFg3JIKylQqk0FlQwY3
         Zu6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=4+JqnNYbdTySkdzdeBZlUTvL7wp3wUNy6SficKihTqg=;
        b=QyyOhUjDt1ezC9x6Gu/BSmwC8UDzif+FBj1WOhIEKwNbxsaYwPF0pzZtSTSkubcBg2
         CbIw5TteAp2pbd9dfdRKEjk4IO2hwHqBNsmY66SAeD4HCUacsYwcVqDpWoS22Hl/YowV
         ZAWBa9amFDlm/I3ZNBkbl6jxKfBFGZCcugb9sbLLhbdlPsX0W3NymyrZmzh9YCe0Z9dh
         mGohVwk05QiU4FxMEZ1ntDQj3wZILbhEbksYgqhq8SyluYajAhQJDdDnydVjH6j2geiS
         ZvHpZTtZEcolQMdtTh4Yl1PuRERuOdkZ9JcjtqlE4IXnXU5tQ5Wp00l43dCrJHWMz1eh
         QhdA==
X-Gm-Message-State: AOAM530DYCQOoCYwtH5/ILxO2JbGfbDGzdCzFSLl/yLfaGxQMPWOJzut
        AkTTJYmH9TpuaHGFOwsLTPMaE6JIGiIGWHW06AmaGY2fGHjjWnwjoUg=
X-Google-Smtp-Source: ABdhPJyCbMB0QY8x2hEMvHq3vBYbFBHiGsfnRV8eiD/ogddy1MPWorEINB00yiTM0C0wnrJBluH2fqYpZLLK+oA0BvY=
X-Received: by 2002:a17:906:1cd1:b0:6ec:c59:6a1d with SMTP id
 i17-20020a1709061cd100b006ec0c596a1dmr10373516ejh.77.1651477703282; Mon, 02
 May 2022 00:48:23 -0700 (PDT)
MIME-Version: 1.0
References: <20220426131102.23966-1-andrea.merello@gmail.com>
 <CAHp75VcoXu=0yvxmTwGAzexV_MgACXg-Cufkigt_kCEvbnwq_Q@mail.gmail.com>
 <20220501180303.75a0d0a5@jic23-huawei> <CAN8YU5PYkQhqrGP8qUK6BgVWVWWECQvYGrSiREU7P5r4kFxVjA@mail.gmail.com>
In-Reply-To: <CAN8YU5PYkQhqrGP8qUK6BgVWVWWECQvYGrSiREU7P5r4kFxVjA@mail.gmail.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Mon, 2 May 2022 09:47:47 +0200
Message-ID: <CAHp75VcFZYyU0ap8WSBCTTpsUtDmC6TqURLOpAOKxYNtbLHAOg@mail.gmail.com>
Subject: Re: [v5 00/14] Add support for Bosch BNO055 IMU
To:     Andrea Merello <andrea.merello@gmail.com>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        linux-iio <linux-iio@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Rob Herring <robh+dt@kernel.org>,
        Matt Ranostay <matt.ranostay@konsulko.com>,
        Alexandru Ardelean <ardeleanalex@gmail.com>,
        jmondi <jacopo@jmondi.org>,
        Andrea Merello <andrea.merello@iit.it>
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

On Mon, May 2, 2022 at 8:33 AM Andrea Merello <andrea.merello@gmail.com> wrote:
> Il giorno dom 1 mag 2022 alle ore 18:54 Jonathan Cameron
> <jic23@kernel.org> ha scritto:
> > On Wed, 27 Apr 2022 15:42:49 +0200
> > Andy Shevchenko <andy.shevchenko@gmail.com> wrote:
> > > On Tue, Apr 26, 2022 at 3:11 PM Andrea Merello <andrea.merello@gmail.com> wrote:

...

> > > FWIW,
> > > Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
> > > for non-commented patches (12 out of 14 AFAICS).
> > >
> > FWIW I'm fine with the series once you've tidied up the stuff Andy picked up
> > on.
> >
> > Thanks Andy for the detailed reviewing btw.

You/re welcome!

> I'm very grateful to both of you and to everyone who commented on
> those patches. Thanks :). Beside the "Reviewed-by" tags where
> appropriate, is it usual/appropriate to put some tag like "Thanks-to
> .. [for comments]" ?

Nope, just mention that in the cover letter.

> BTW I have also gone through some kernel-robot reports; they also
> state "If you fix the issue, kindly add following tag as appropriate
> Reported-by: kernel test robot <lkp@intel.com>". I'd say that it would
> be OK to add this tag to a patch that just fixes what is reported, but
> I'm unsure whether it is appropriate to add this tag to the patches in
> my series, because they add the code and the fix at once. Any advice
> here?

For this we specifically amended the kernel documentation recently.
https://www.kernel.org/doc/html/latest/process/submitting-patches.html#using-reported-by-tested-by-reviewed-by-suggested-by-and-fixes

"The tag is intended for bugs; please do not use it to credit feature requests."

-- 
With Best Regards,
Andy Shevchenko
