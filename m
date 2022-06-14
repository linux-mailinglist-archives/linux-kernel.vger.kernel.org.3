Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4BF5854B427
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Jun 2022 17:05:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245509AbiFNPDz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Jun 2022 11:03:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237229AbiFNPDx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jun 2022 11:03:53 -0400
Received: from mail-qk1-x734.google.com (mail-qk1-x734.google.com [IPv6:2607:f8b0:4864:20::734])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E41D63CFCE
        for <linux-kernel@vger.kernel.org>; Tue, 14 Jun 2022 08:03:50 -0700 (PDT)
Received: by mail-qk1-x734.google.com with SMTP id o73so6557260qke.7
        for <linux-kernel@vger.kernel.org>; Tue, 14 Jun 2022 08:03:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gooddata.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=/D+VzI7xfU5sKGtg6npf93vwANQDg/IMCYK5IbUP57A=;
        b=oI0CXaHRIrir258zHLNzjST3ocLkRw6+xDWF6FrunA8iY4VC2Tm5VdOcz/hYaQgUxB
         i+CVUmIdHlkRU/1GxgU50p3A+o9BD5hiBVcjS4Sgm3FsWMdz8HcpqLfW7t1+aS6vIW+t
         WUnoRHchj7VU1LeaV9PQoacFwBVv+r4x/fbF4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=/D+VzI7xfU5sKGtg6npf93vwANQDg/IMCYK5IbUP57A=;
        b=aRS/PHjg8yIjkmq9PkR/svcB89gqKPNBiRt6cBg6GWKYmUQCMxBWO+zHZdh+ZfRp98
         0udHoP4dOGK4H6trBAgSCm810yrBZ1PucJVNH4MpLsSERJN8xAki5kBmNkiVtslkz3Zn
         2cDHjCIrsI6WmZ1H7oCs0CEsaLj1svSlifZe8gyXxBGkzCij0KI/LPdcn1QMuYSjYFIO
         D6etg5ofdJ8oQcEfoPiyr9utIC+twJlD3Mv/uptyeDMv+rVMxWLUXVkXE8OvjbA59dkw
         s8sfZB21OI60oxDUPjKPcwQrdV3Q+AjXxphNU+PKKZIIxMPYUlSA/+KaUg4gLQh4sjjc
         cxig==
X-Gm-Message-State: AOAM531C+z7CNpC9PZ8cwymK/FamkjwXnpnhax8oMSacbOnNsdZp4Yp6
        u22e0WsKlilL8MgK59zbayo8tyG3ENzLTJmm/vM5iA==
X-Google-Smtp-Source: ABdhPJzOdxpWTmR8rFeC6EikGc/w3YwLvexSfZvReCsvxmrRA4JEXGmiRDAEH+od0juiqBSST2tOBt30JjjQ7e2IoCQ=
X-Received: by 2002:a05:620a:288a:b0:6a6:3da1:1a7a with SMTP id
 j10-20020a05620a288a00b006a63da11a7amr4261508qkp.235.1655219029739; Tue, 14
 Jun 2022 08:03:49 -0700 (PDT)
MIME-Version: 1.0
References: <20220613181233.078148768@linuxfoundation.org> <CAK8fFZ68+xZ2Z0vDWnihF8PeJKEmEwCyyF-8W9PCZJTd8zfp-A@mail.gmail.com>
 <YqgsDXdY3OttH8Mc@kroah.com> <CAK8fFZ5SP4zAra2X8B3Q9zkhQGMfif+y-oEvkpR4fDpL8_upKg@mail.gmail.com>
 <YqihnavPcyzMMw8l@kroah.com>
In-Reply-To: <YqihnavPcyzMMw8l@kroah.com>
From:   Jaroslav Pulchart <jaroslav.pulchart@gooddata.com>
Date:   Tue, 14 Jun 2022 17:03:23 +0200
Message-ID: <CAK8fFZ4JnhA3s8e4YDp_+GOq5+p4YzRtKdEFzjogtXc3EBttzw@mail.gmail.com>
Subject: Re: [PATCH 5.18 000/343] 5.18.4-rc2 review
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
        lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
        f.fainelli@gmail.com, sudipm.mukherjee@gmail.com,
        slade@sladewatkins.com
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

=C3=BAt 14. 6. 2022 v 16:56 odes=C3=ADlatel Greg Kroah-Hartman
<gregkh@linuxfoundation.org> napsal:
>
> On Tue, Jun 14, 2022 at 04:41:31PM +0200, Jaroslav Pulchart wrote:
> > =C3=BAt 14. 6. 2022 v 8:34 odes=C3=ADlatel Greg Kroah-Hartman
> > <gregkh@linuxfoundation.org> napsal:
> > >
> > > On Tue, Jun 14, 2022 at 07:56:36AM +0200, Jaroslav Pulchart wrote:
> > > > Hello,
> > > >
> > > > I would like to report that the ethernet ice driver is not capable =
of
> > > > setting promisc mode on at E810-XXV physical interface in the whole
> > > > 5.18.y kernel line.
> > > >
> > > > Reproducer:
> > > >    $ ip link set promisc on dev em1
> > > > Dmesg error message:
> > > >    Error setting promisc mode on VSI 6 (rc=3D-17)
> > > >
> > > > the problem was not observed with 5.17.y
> > >
> > > Any chance you can use 'git bisect' to track down the problem commit =
and
> > > let the developers of it know?
> > >
> > > thanks,
> >
> > I tried it, but it makes the system unbootable. I expect the reason is
> > that it happened somewhere between 5.17->5.18 so I'm using an
> > "unstable" kernel.
> >
> > Is there some way I could bisect just one driver, not a full kernel
> > between 5.17->5.18?
>
> How do you know it is just "one driver"?

Just a quess based on "git grep". The error message was introduced in
the driver in 5.18-rc*.

The idea is to try it per partes. The bisect of the whole kernel makes
stuff unbootable anyway.

>
> Anyway, yes, I think there are options to give to git bisect, you can
> feed it just the path to the driver as part of 'git bisect start' and I
> think that should work.  The man page for 'git bisect' shows this with
> the following example:
>          git bisect start -- arch/i386 include/asm-i386
> to just test changes for those directories.

Thanks for this hint! I'm going to try it.

>
> thanks,
>
> greg k-h

Jaroslav P.
