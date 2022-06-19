Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9699A550C3C
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Jun 2022 19:01:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236370AbiFSRBB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 19 Jun 2022 13:01:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232771AbiFSRA7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Jun 2022 13:00:59 -0400
Received: from mail-qv1-xf2d.google.com (mail-qv1-xf2d.google.com [IPv6:2607:f8b0:4864:20::f2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6696CB854
        for <linux-kernel@vger.kernel.org>; Sun, 19 Jun 2022 10:00:58 -0700 (PDT)
Received: by mail-qv1-xf2d.google.com with SMTP id cs6so8646879qvb.6
        for <linux-kernel@vger.kernel.org>; Sun, 19 Jun 2022 10:00:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gooddata.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=P2Pzb/PaJ7Z+/ZicwcRN0lssuLoakMdj+znnhHREnpM=;
        b=I25eIhLsilWbc24M5LzyajgvEN8Sn9jgS4f3qZqIi52kOrXVJAVjoZ54iAUcrfzZUo
         CpT/X7RzR3brNxXXO9hmBWMDc5I/ZaR5dpfE+6ee2ebYKQXwlelu5N6C3MnOCVhY/QXn
         B9nLXoxcWOH3eAmY9ouaMyxn/CZv5WTz5rnes=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=P2Pzb/PaJ7Z+/ZicwcRN0lssuLoakMdj+znnhHREnpM=;
        b=f5/yLJLsibbqU+2Q75GJS1wjVYOHHVys/8DUPQV4HgsxByNeMAJgg93d99Thw3ODx/
         proKjduhxamhIhA4JE/uAenwZdthLngKYLAGtwNO/baC1Nifj/tSXsqPjxPdgIvsCd80
         m/kSDTFAZOJiI2Y1JYjxCvK6FZOL5irzlJW4TfavcnIKyKFXhLMEVzrKw4kdXjua/mmj
         rDuPB2/vhvy36CKpQ5XKEjSzGljHIEHr36NbyqeaoxkJGFgkgReHu4bS7yG1T+fThQNd
         BFhu/zMeh2kaytIiu8gmPNOx6QAGsoM5Gc6uXaESzu3yBTNw+KQad3nh0SSVbbrVqG/X
         RYng==
X-Gm-Message-State: AJIora+aYJMAAErx4RCpVdNfBfGEIvpf4jANutA7Yc1anJzJyiTEpm+d
        A4EV1zM1VRKL8i+Ck6XZADYdUXimN65aazgZtJe7HA==
X-Google-Smtp-Source: AGRyM1u9BpxR11DJpEOt1YEvxLdgRzei2TxuhlqZv4bFrv9cru4rmZePHEnZXLDUe7k+tLaV38XT+SyxVvcS2YiQbus=
X-Received: by 2002:a05:6214:5187:b0:46b:c045:1a2c with SMTP id
 kl7-20020a056214518700b0046bc0451a2cmr15945097qvb.33.1655658057453; Sun, 19
 Jun 2022 10:00:57 -0700 (PDT)
MIME-Version: 1.0
References: <CAK8fFZ7m-KR57M_rYX6xZN39K89O=LGooYkKsu6HKt0Bs+x6xQ@mail.gmail.com>
 <2596b2c6-71e4-543f-799f-b4b174c21f31@leemhuis.info>
In-Reply-To: <2596b2c6-71e4-543f-799f-b4b174c21f31@leemhuis.info>
From:   Jaroslav Pulchart <jaroslav.pulchart@gooddata.com>
Date:   Sun, 19 Jun 2022 19:00:31 +0200
Message-ID: <CAK8fFZ6hS69JMtnvFnLVt9aiWEivZ9-izNgMHtB+KeAWAfaXaQ@mail.gmail.com>
Subject: Re: [Intel-wired-lan] ice: Error setting promisc mode on VSI 6
 (rc=-17) @ 5.18.x
To:     Thorsten Leemhuis <regressions@leemhuis.info>
Cc:     intel-wired-lan@lists.osuosl.org,
        Jesse Brandeburg <jesse.brandeburg@intel.com>,
        Tony Nguyen <anthony.l.nguyen@intel.com>,
        LKML <linux-kernel@vger.kernel.org>,
        "regressions@lists.linux.dev" <regressions@lists.linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

yes, I revert that commit. Still the promiscs cannot be set and the dmesg
error message changed to:
---------------
$ ip link set em1 promisc on
$ dmesg
...
ice 0000:63:00.0 em1: Error setting Multicast promiscuous mode on VSI 6
...
---------------

Jaroslav P.

ne 19. 6. 2022 v 13:51 odes=C3=ADlatel Thorsten Leemhuis
<regressions@leemhuis.info> napsal:

>
> [TLDR: I'm adding this regression report to the list of tracked
> regressions; all text from me you find below is based on a few templates
> paragraphs you might have encountered already already in similar form.]
>
> Hi, this is your Linux kernel regression tracker.
>
> On 09.06.22 08:58, Jaroslav Pulchart wrote:
> >
> > I'm struggling with broken network connectivity at VMs using linux
> > bridge at host after update of kernel from 5.17.x to 5.18.x @ Dell
> > R750 server with E810-XXV NICs.
> >
> > I noticed the kernel reports "Error setting promisc mode" in dmesg.
> >
> > # dmesg  | grep 'Error setting promisc'
> > [   24.863557] ice 0000:31:00.0: Error setting promisc mode on VSI 6 (r=
c=3D-17)
> > [   24.878369] ice 0000:31:00.0: Error setting promisc mode on VSI 6 (r=
c=3D-17)
> > [   25.045834] ice 0000:31:00.0: Error setting promisc mode on VSI 6 (r=
c=3D-17)
> > [   25.129840] ice 0000:b1:00.0: Error setting promisc mode on VSI 6 (r=
c=3D-17)
> > [   25.144440] ice 0000:b1:00.0: Error setting promisc mode on VSI 6 (r=
c=3D-17)
> >
> > # lspci -s 0000:31:00.0
> > 31:00.0 Ethernet controller: Intel Corporation Ethernet Controller
> > E810-XXV for SFP (rev 02)
> > # lspci -s 0000:b1:00.0
> > b1:00.0 Ethernet controller: Intel Corporation Ethernet Controller
> > E810-XXV for SFP (rev 02)
> >
> > It is easy to reproduce by:
> >   # ip link set em1 promisc on
> >   # dmesg -T | tail -n 1
> >   [Thu Jun  9 08:48:19 2022] ice 0000:31:00.0: Error setting promisc
> > mode on VSI 6 (rc=3D-17)
> >
> > Could it be an 'ice' driver bug introduced in the 5.18 kernel?
>
> CCing the regression mailing list, as it should be in the loop for all
> regressions, as explained here:
> https://www.kernel.org/doc/html/latest/admin-guide/reporting-issues.html
>
> Jaroslav, did you try to revert the change that was suggested to you in
> https://lore.kernel.org/all/d993bbb6-e583-5d91-76c0-841cc5da86af@roeck-us=
.net/
> Did it help?
>
> Anyway: To be sure below issue doesn't fall through the cracks
> unnoticed, I'm adding it to regzbot, my Linux kernel regression tracking
> bot:
>
> #regzbot ^introduced v5.17 to v5.18
> #regzbot title net: ice: Error setting promisc mode on VSI 6 (rc=3D-17) @
> 5.18.x
> #regzbot monitor
> https://lore.kernel.org/all/CAK8fFZ68+xZ2Z0vDWnihF8PeJKEmEwCyyF-8W9PCZJTd=
8zfp-A@mail.gmail.com/
> #regzbot monitor
> https://lore.kernel.org/all/CAK8fFZ61mQ3AYpdWjWtyUXzrs-RVMW61mBLrjRDXBxB-=
F9GzbA@mail.gmail.com/
> #regzbot ignore-activity
>
> This isn't a regression? This issue or a fix for it are already
> discussed somewhere else? It was fixed already? You want to clarify when
> the regression started to happen? Or point out I got the title or
> something else totally wrong? Then just reply -- ideally with also
> telling regzbot about it, as explained here:
> https://linux-regtracking.leemhuis.info/tracked-regression/
>
> Reminder for developers: When fixing the issue, add 'Link:' tags
> pointing to the report (the mail this one replied to), as the kernel's
> documentation call for; above page explains why this is important for
> tracked regressions.
>
> Ciao, Thorsten (wearing his 'the Linux kernel's regression tracker' hat)
>
> P.S.: As the Linux kernel's regression tracker I deal with a lot of
> reports and sometimes miss something important when writing mails like
> this. If that's the case here, don't hesitate to tell me in a public
> reply, it's in everyone's interest to set the public record straight.
