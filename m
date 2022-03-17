Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B7F684DC3DD
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Mar 2022 11:19:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232538AbiCQKUg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Mar 2022 06:20:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231810AbiCQKUe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Mar 2022 06:20:34 -0400
Received: from mail-io1-xd32.google.com (mail-io1-xd32.google.com [IPv6:2607:f8b0:4864:20::d32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CAA62CA0F5
        for <linux-kernel@vger.kernel.org>; Thu, 17 Mar 2022 03:19:17 -0700 (PDT)
Received: by mail-io1-xd32.google.com with SMTP id e22so5282834ioe.11
        for <linux-kernel@vger.kernel.org>; Thu, 17 Mar 2022 03:19:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sartura-hr.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=n6iauwsK21Ks+eaRsgF1KeKTsBm/xpjROn2Egsfn7rk=;
        b=BtkGQvlL8IiX7Af3L9wZ73uGGfUoeWkZqZLD/lucGZokmkXOOy8OjDYxOLE4psUs9O
         T1MtVaDxvBGzA3zrwBhgIGXnwvyftGG3IvQB/r6blP7uCGzhKoM7CinSpkVyi18E7lx6
         PJO+fu8JJnL7VLKIO7ZzZdD9ZHmK0lcIAwfhmE2EoFbGLYfVAVMOHyJEjAoS4/OnCgSO
         quL1+ycGUxzCrr9M3ZBiPsx3glvBTJDaL39xvFsTjZZxFJlrTL0L9BFLIwH3vblEbx2L
         yHsqkAE+PAyUj24GdsV2gkmgOpnVwGUfpQGgrBPKxpMuQgp4KazHDnNupD5OAf1C4IdH
         kumA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=n6iauwsK21Ks+eaRsgF1KeKTsBm/xpjROn2Egsfn7rk=;
        b=g2VLaGeibv4IKYWX7Awj2WRpLBTvU0Ga0sKrzA/fJ7ZxrAtrhxJWqN/7ZBQZXuVOut
         MKxm8FmpL4Dp1qA8UKkY/nKObWQfyicQ0k357KauSWSeY+TJfoUaViQre8PQBCK6fl73
         w/oaoi7K9aHs9F5nL7edyhxAAKxsBwCgUr6c+YIhwLL68ZhcF23gPAxnAxqeo9ymRlXj
         pfmS+yxf/hrHYlK+hBOE3NTAwYuFSn/wtHQKi2Zx8/24oTc9QztkT46QLP6tssRtE0Kp
         SgmtIG66RXQo/m3qRJnD8h8q+LSnu8HobWz36sP57CKZ4OYpya47S9DGiJz45crD3DhK
         XWoA==
X-Gm-Message-State: AOAM531toggZOYbYhMN+X2cry/6L33yzKKDXLV6lWriFsDFlosKhnQjb
        jYSaSMfcsAwUFhzovxewcYazdNO0Qfu0THYkFSkj7g==
X-Google-Smtp-Source: ABdhPJwQ2P9JinBva619F3p7zagggJVYhqCv0EesuF+pPCUxY163Xe5b0no+EBuFuKNrGdTuZaE7Z702loWBZ6Jd3bc=
X-Received: by 2002:a02:6383:0:b0:314:d9da:13b2 with SMTP id
 j125-20020a026383000000b00314d9da13b2mr1598984jac.99.1647512357201; Thu, 17
 Mar 2022 03:19:17 -0700 (PDT)
MIME-Version: 1.0
References: <20220131133049.77780-1-robert.marko@sartura.hr>
 <20220131133049.77780-6-robert.marko@sartura.hr> <Yh8vJNc4D6rA68au@google.com>
 <Yh/kFzNuvbwA2qeE@robh.at.kernel.org> <CA+HBbNHComN9kgFp1Xr4mdedwYjDMbSUkw+6_KAe8+O4hrtvKQ@mail.gmail.com>
 <YiKI5LDWaxvlc9m5@robh.at.kernel.org>
In-Reply-To: <YiKI5LDWaxvlc9m5@robh.at.kernel.org>
From:   Robert Marko <robert.marko@sartura.hr>
Date:   Thu, 17 Mar 2022 11:19:06 +0100
Message-ID: <CA+HBbNG4KfoO8wyQghubjqVvL5ocyxqa+CKjqkn0iXfA9duY_w@mail.gmail.com>
Subject: Re: [PATCH v10 5/6] dt-bindings: mfd: Add Delta TN48M CPLD drivers bindings
To:     Rob Herring <robh@kernel.org>
Cc:     Lee Jones <lee.jones@linaro.org>,
        Linus Walleij <linus.walleij@linaro.org>, brgl@bgdev.pl,
        Philipp Zabel <p.zabel@pengutronix.de>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        skhan@linuxfoundation.org, Luka Perkov <luka.perkov@sartura.hr>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 4, 2022 at 10:47 PM Rob Herring <robh@kernel.org> wrote:
>
> On Thu, Mar 03, 2022 at 01:41:13PM +0100, Robert Marko wrote:
> > On Wed, Mar 2, 2022 at 10:39 PM Rob Herring <robh@kernel.org> wrote:
> > >
> > > On Wed, Mar 02, 2022 at 08:47:32AM +0000, Lee Jones wrote:
> > > > On Mon, 31 Jan 2022, Robert Marko wrote:
> > > >
> > > > > Add binding documents for the Delta TN48M CPLD drivers.
> > > > >
> > > > > Signed-off-by: Robert Marko <robert.marko@sartura.hr>
> > > >
> > > > This is missing a DT review.
> > >
> > > How about this one[1]?
> > >
> > > Rob
> > >
> > > [1] https://lore.kernel.org/all/20210719225906.GA2769608@robh.at.kernel.org/
> >
> > Hi Rob,
> > Thanks for reaching out.
> >
> > As you can see the bindings have evolved since v6,
> > GPIO driver now only uses 2 distinct compatibles.
>
> Fundamentally, it hasn't really changed.
>
> There's 2 main issues. First, I don't see the need for any child nodes.
> This would be sufficient:
>
> cpld@41 {
>     compatible = "delta,tn48m-cpld";
>     reg = <0x41>;
>     #reset-cells = <1>;
>     #gpio-cells = <2>;
>     gpio-controller;
> };
>
> You only need child nodes if the sub-blocks have their own resources or
> are widely reused in different configurations.
>
> The 2nd issue is whether GPIOs are even GPIOs at all. I don't recall
> that Linus ever agreed.
>
> Both issues kind of boil down to is there even more that 1 variation of
> this h/w where you have differing connections? AFAICT, Delta tn48m is a
> pretty specific device and I would guess something implemented in a CPLD
> is likely to change on every board design. At least that's my experience
> with 'board level logic'.

Hi Rob, sorry for the late reply.

Having one node was the route I went in v1, but that was rejected as
it would mean
having an MFD driver that just registers the sub-drivers.
That is what the simple-mfd-i2c driver was designed to get rid of and
inherit the regmap
from the parent.
For this to work, subnodes are required as we need to match on compatibles.

Using subnodes for GPIO-s also gets rid of hardcoding the register
layout in the driver per board,
as Delta chose to use a weird register layout in which the GPIO
registers have completely random offsets.
The layout is even weirder in the TN4810M which uses the same CPLD but
expanded and is easily
supportable in the same driver in the current form.
My goal and the requirement from the community was to make the GPIO
driver as simple as possible
and extendable so that boards like TN4810M can be easily added.

Also, the Kontron SL28CPLD does pretty much the same in regards to DT
as well as other things.
https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/tree/Documentation/devicetree/bindings/mfd/kontron,sl28cpld.yaml?h=v5.16.15

It uses the same logic with different compatibles for GPIO to be able
to inform the kernel of the certain
bank capabilities.
I mean, using one compatible would be possible by using a boolean
property for example that tells you
that its output capable as well.

Regards,
Robert

>
> Rob



-- 
Robert Marko
Staff Embedded Linux Engineer
Sartura Ltd.
Lendavska ulica 16a
10000 Zagreb, Croatia
Email: robert.marko@sartura.hr
Web: www.sartura.hr
