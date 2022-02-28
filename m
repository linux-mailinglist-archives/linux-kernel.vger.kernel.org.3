Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 266294C624B
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Feb 2022 06:00:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233065AbiB1FBN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Feb 2022 00:01:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233064AbiB1FBL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Feb 2022 00:01:11 -0500
Received: from mail-qk1-x72d.google.com (mail-qk1-x72d.google.com [IPv6:2607:f8b0:4864:20::72d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52A5166FB7;
        Sun, 27 Feb 2022 21:00:30 -0800 (PST)
Received: by mail-qk1-x72d.google.com with SMTP id b13so9480676qkj.12;
        Sun, 27 Feb 2022 21:00:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=jms.id.au; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=dl5bImTp8P/vXmU2+b7NmzpeCyOGUJ3zCffquEOpd18=;
        b=AEGH3S6nmgJiVduVsFiCTpBweUwAf7F44ifshZVPRWwe4Qv6YFIYoFJbINshT644jX
         oYCZ9rXlkl7Z+fa4VZFs1j46PDj8ZYQlGehSOH7UuIfpnHf/Mabqno5Y/s3aOw5YzvIo
         q4X3Zd0Yl5/tylayQOeuPJDtyFSxIzToeJA3o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=dl5bImTp8P/vXmU2+b7NmzpeCyOGUJ3zCffquEOpd18=;
        b=pMtSzqz+wY4UeVqjZfg8vSBXmV6cnJhMLDZgLOs5OUwy0Ns9X3H45Ku4bQ2dibswIB
         AfS6F5kl/ndgPTQ7F2qqIeYuxlNW5Pa0ftOcBvyqnN5QHsDMfuB43H2wHy6cmmIJ7FZh
         uy1hh6ZB/ZwnlBSz0ZmLxx3f0bCMAHZhAygpxC1RLoVxe3r2aPcYL8UWDXPI/dnYcbEh
         adJk1tFD67zxJBuHr25w2A5DxPtwzZs68LJH8luvwDY5f3LCRdepPKWv/NORzYxqLZUG
         UiN8oPAw2CA0zsvMQ4D7NSIk5J0N1nZODnqfdjOSB39EXPpQ3BZBqIEPTLpaeAEZ4EtV
         FM1g==
X-Gm-Message-State: AOAM533iEt65g/Cyh5nTGtdoj/XZfdiCOFiOt28PUDGskpTwSxjfs8up
        urrbNShBvv44fVdS9+uPpuXbmBOWXOc7bP4FPM8=
X-Google-Smtp-Source: ABdhPJzD+ossvHaHQAKihwxTjH9fBc3NI+O+eeyw7Gb76LJbM2mhqZQ5/unoVcahDCD9C38J+XgCe0KCu1NuXULkWUg=
X-Received: by 2002:a37:f903:0:b0:648:ca74:b7dc with SMTP id
 l3-20020a37f903000000b00648ca74b7dcmr10150792qkj.666.1646024429883; Sun, 27
 Feb 2022 21:00:29 -0800 (PST)
MIME-Version: 1.0
References: <20220105101719.7093-1-zev@bewilderbeest.net> <CACPK8XeHyoo0D1vQm=L8m284kC5n-O+FEMp1HN+ROWJfx7qjhQ@mail.gmail.com>
 <Yd4rfi/iICQ5EjGh@hatter.bewilderbeest.net>
In-Reply-To: <Yd4rfi/iICQ5EjGh@hatter.bewilderbeest.net>
From:   Joel Stanley <joel@jms.id.au>
Date:   Mon, 28 Feb 2022 05:00:17 +0000
Message-ID: <CACPK8XfGdTvznj90C7XFJ04QVU96NdwfXQX_Rj+bkCnov1Urpg@mail.gmail.com>
Subject: Re: [PATCH] ARM: dts: aspeed: Add ASRock ROMED8HM3 BMC
To:     Zev Weiss <zev@bewilderbeest.net>
Cc:     Linux ARM <linux-arm-kernel@lists.infradead.org>,
        linux-aspeed <linux-aspeed@lists.ozlabs.org>,
        OpenBMC Maillist <openbmc@lists.ozlabs.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>,
        Rob Herring <robh+dt@kernel.org>,
        Andrew Jeffery <andrew@aj.id.au>,
        Neil Horman <neil.horman@privafy.com>,
        Anthony Jenkins <anthony.jenkins@privafy.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 12 Jan 2022 at 01:14, Zev Weiss <zev@bewilderbeest.net> wrote:
>
> On Tue, Jan 11, 2022 at 02:59:28AM PST, Joel Stanley wrote:
> >On Wed, 5 Jan 2022 at 23:10, Zev Weiss <zev@bewilderbeest.net> wrote:
> >>
> >> This is a half-width, single-socket Epyc server board with an AST2500
> >> BMC.  This device tree is sufficient for basic OpenBMC functionality,
> >> but we'll need to add a few more devices (as driver support becomes
> >> available) before it's fully usable.
> >>
> >> Signed-off-by: Zev Weiss <zev@bewilderbeest.net>
> >
> >Reviewed-by: Joel Stanley <joel@jms.id.au>
> >
>
> Thanks!

I've merged this for v5.18.

>
> >Have you considered using the openbmc gpio naming scheme for the
> >gpio-line-names?
> >
>
> I looked at it, but decided not to for a few reasons:
>
>   - For systems that are in the early stages of a porting effort (like
>     this one currently is), I'm still referring to hardware schematics
>     fairly often, and using the same identifiers in software that are
>     used in the schematics simplifies things by avoiding an extra
>     translation step between the two.
>
>   - Most of the GPIO-related userspace components (that I'm dealing with
>     anyway, e.g. x86-power-control and host-error-monitor) already have
>     their own GPIO line-name configuration/remapping mechanisms that need
>     to be set up anyway.
>
>   - There's a solid mix of GPIOs that would be covered by the naming
>     guidelines and others that aren't; having a mix of the two styles
>     seems a bit awkward to me.
>
> That said, I sympathize with the motivation behind it and I'm not
> vehemently opposed on the whole, so if there's a strong preference to
> follow that scheme I could probably be talked into changing it.
>
>
> Zev
>
