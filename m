Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4DCA2474606
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Dec 2021 16:07:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232849AbhLNPHx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Dec 2021 10:07:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231281AbhLNPHw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Dec 2021 10:07:52 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE8A0C061574;
        Tue, 14 Dec 2021 07:07:51 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 83D31B81A26;
        Tue, 14 Dec 2021 15:07:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 39B77C34608;
        Tue, 14 Dec 2021 15:07:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1639494469;
        bh=rPVk2jDfAiR4nn6IGpYxU9DbCVEZmbX3NRqFQoR/jQs=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=n1a/Auo5GPfrYAN6BIrPFlMr16f70/duhx+xBXAmDtvldmoUfa1QwqdjTpNRonDpk
         1NqP9cw8wUbGCyaH9EluR7qtxbvyP+pZE1MnP2C5tEBoMVMIdrc2V4ScPnf9cGqvwH
         x0OLd8CUlhkfeQqj+oXHwDgRvcyR9OGyQwgBvlHUNv9Zd0oKYawKSxFmwLLyZn61Ge
         4MXLmhNrzDuzec3RJd+/iccHwz2kpNBbxxRtjRYKEaPxZx0utFHiynKNZ0R1q4SzeH
         lQgW6MUsLYDZzpzyecpyohd1DWFSrq+lruclmWBccK/wucP0SRKTBTRwnnm43hE7Rb
         jUf5oXYiW5zeg==
Received: by mail-ed1-f44.google.com with SMTP id r11so63319103edd.9;
        Tue, 14 Dec 2021 07:07:49 -0800 (PST)
X-Gm-Message-State: AOAM530goB/LFR0w9RAxU8tIZlGg/aTjCtj4hqjRzINAo0n9lnP2+8HU
        EO0Kn7WOF31F5NeB72FO3l2CdsS27xvSv1MJKA==
X-Google-Smtp-Source: ABdhPJxf5YHSaPknEFNU2A9Af9vjayodsoldMQfptOk8XsIiNGL8Y+79xGZquCFPYdXox6JhXgRtWzFzb7ICr0iQ9pE=
X-Received: by 2002:a17:906:229b:: with SMTP id p27mr6246957eja.264.1639494466650;
 Tue, 14 Dec 2021 07:07:46 -0800 (PST)
MIME-Version: 1.0
References: <20211214013800.2703568-1-vladimir.oltean@nxp.com> <20211214013800.2703568-2-vladimir.oltean@nxp.com>
In-Reply-To: <20211214013800.2703568-2-vladimir.oltean@nxp.com>
From:   Rob Herring <robh+dt@kernel.org>
Date:   Tue, 14 Dec 2021 09:07:33 -0600
X-Gmail-Original-Message-ID: <CAL_JsqK2Shj6smam7HgNAmy3UG+vVQPkU3Q0OjyEHOEJB45n0A@mail.gmail.com>
Message-ID: <CAL_JsqK2Shj6smam7HgNAmy3UG+vVQPkU3Q0OjyEHOEJB45n0A@mail.gmail.com>
Subject: Re: [RFC PATCH devicetree 01/10] irqchip/ls-extirq: rename
 "interrupt-map" OF property to "fsl,extirq-map"
To:     Vladimir Oltean <vladimir.oltean@nxp.com>
Cc:     devicetree@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Marc Zyngier <maz@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
        Li Yang <leoyang.li@nxp.com>, Biwen Li <biwen.li@nxp.com>,
        Zhiqiang Hou <Zhiqiang.Hou@nxp.com>,
        Kurt Kanzenbach <kurt@linutronix.de>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 13, 2021 at 7:38 PM Vladimir Oltean <vladimir.oltean@nxp.com> wrote:
>
> This OF property was supposed to be named "fsl,extirq-map" since the
> first patch submissions, but at Rob Herring's suggestion it was named
> "interrupt-map":
> https://lore.kernel.org/lkml/20190927161118.GA19333@bogus/

I'm still not okay with a custom property. The fact that multiple
platforms need the same thing is an indication this should be common.
Other cases are being fixed by using 'interrupts', but that's going to
take some cleanups[1].

> At that time, the "interrupt-map" was ignored by the core for OF nodes
> that also had an "interrupt-controller" property, but that changed with
> commit 041284181226 ("of/irq: Allow matching of an interrupt-map local
> to an interrupt controller"), which made the consumer drivers of the
> ls-extirq break. To work around this breakage, the OF bindings for IRQs
> have introduced a table of "OF IRQ interrupt-map abusers".
> This can be seen in commit de4adddcbcc2 ("of/irq: Add a quirk for
> controllers with their own definition of interrupt-map").
>
> To stop being abusers, let's go back to the original form of these
> bindings, before Rob's review. Compatibility will be kept with the
> current abusive bindings for a few more kernel cycles, to give people
> some time to update. But to also give them an incentive, print a warning
> that the support for "interrupt-map" will be removed. This will be seen
> when running a new kernel with an old device tree.
>
> While the breakage was introduced relatively recently, the device tree
> changes are intended to backport stable kernels for quicker conversion
> to an acceptable set of bindings, and this driver will need to support
> the updated stable bindings.

Using 'interrupts' is not going to work backporting to stable, but I
don't think trying to switch this is worth it.

Rob

[1] https://lore.kernel.org/all/CAL_Jsq+jyqbhA1jpgZ+yTwWGvCMRu9VmgoDq8MDM9SMqJ-XSBw@mail.gmail.com/
