Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EB9F94635F0
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Nov 2021 14:57:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241888AbhK3OBD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Nov 2021 09:01:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234896AbhK3OAx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Nov 2021 09:00:53 -0500
Received: from mail-yb1-xb2e.google.com (mail-yb1-xb2e.google.com [IPv6:2607:f8b0:4864:20::b2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9854C06174A
        for <linux-kernel@vger.kernel.org>; Tue, 30 Nov 2021 05:57:32 -0800 (PST)
Received: by mail-yb1-xb2e.google.com with SMTP id j2so52761036ybg.9
        for <linux-kernel@vger.kernel.org>; Tue, 30 Nov 2021 05:57:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=anyfinetworks-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=i8mC6OqW0NDo60h/ey+ips1XwWpcV67dhd9iu/BhDz0=;
        b=WRlEVbKlNULbDO6M6gbl896ndTKr+un9IDkTKhxYx3kDhMjanE6bsjMsPGAzq97Hs9
         crYTXwAvhcyMq0NWjblhRU+XgfOOV8KfhaRjJK5IdAOTnu2vDmQtmO7FOn8mSBDsKa4m
         YW5rnK8qkBbukBswLIUOA56UjHBAV5lJj+siep6KiR6wcCMAEFsdlxJxGMWoJ0cU2ZeO
         EpGx1VdKsIXJbD+GHuwD4rtflOshZHkR4BLyyawq8g2S9UDZi/AWRB+14W+nxsqaUXTR
         /EoGaAHK0pdgbtQ6FUYKHkvKvtWBroMuvCqWmhqPx5vLQF26e030cQ3Su0fjv+eMkVZZ
         jovQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=i8mC6OqW0NDo60h/ey+ips1XwWpcV67dhd9iu/BhDz0=;
        b=RhdNfLz9SXGT5LLan/kZVHEdkorTseLF6Gv+O+maoPlqJHrdpGMJpf9S4eYGhovPgs
         Gk83DnRnp+bjBqAwJmxEIAyREc7S4wlW9lOPkUfatBso/xpk/itvofErSTjk3QtYNA3c
         Q45IgfFI1cVgltA/5bFKfm29Ua/05njAw7lsXXMvFVm8QnfTmZcbdPdabN0F4hlA2tzy
         tm6H847rlekuHg+iAb06C+qZeHvfzw+Tq/zbs3vC7tIMmyvVQvAuFaFawn9YEzHnPJQd
         mn534eNUXij/VlwzT2j87lU1JPpKeLn/E+c6wz+p3sraU+kVfsB+tS8DBsQzT1NStF3t
         5ikw==
X-Gm-Message-State: AOAM532p45crdVQfnnVDgSTF0XabbeVLSTQsB30VE+j3bzXGtEeedeXT
        EvWBuRzP4kV+loMqu6ChjYatkNbJAEj53dO+zclseA==
X-Google-Smtp-Source: ABdhPJy/BtczKyJzappms/4cO8+1NIBYpHuseK0gvuukRHbl9fVIpSbl33dqQ/eIMS4vDHBMIe0jGEVN1VclOswS83I=
X-Received: by 2002:a25:94d:: with SMTP id u13mr14311330ybm.723.1638280651971;
 Tue, 30 Nov 2021 05:57:31 -0800 (PST)
MIME-Version: 1.0
References: <CAKXUXMyEqSsA1Xez+6nbdQTqbKJZFUVGtzG6Xb2aDDcTHCe8sg@mail.gmail.com>
In-Reply-To: <CAKXUXMyEqSsA1Xez+6nbdQTqbKJZFUVGtzG6Xb2aDDcTHCe8sg@mail.gmail.com>
From:   Johan Almbladh <johan.almbladh@anyfinetworks.com>
Date:   Tue, 30 Nov 2021 14:57:21 +0100
Message-ID: <CAM1=_QQBfO_RQuYFrhdvZeM+KbY+5w=YVHTfb-zZQsN4fiBMcw@mail.gmail.com>
Subject: Re: Reference to non-existing symbol WAR_R10000 in arch/mips/net/bpf_jit_comp.h
To:     Lukas Bulwahn <lukas.bulwahn@gmail.com>
Cc:     Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Paul Burton <paulburton@kernel.org>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Netdev <netdev@vger.kernel.org>, bpf <bpf@vger.kernel.org>,
        "open list:BROADCOM NVRAM DRIVER" <linux-mips@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Lukas,

On Mon, Nov 29, 2021 at 7:39 AM Lukas Bulwahn <lukas.bulwahn@gmail.com> wrote:
>
> Dear Johan,
>
> In arch/mips/net/bpf_jit_comp.h and introduced with commit commit
> 72570224bb8f ("mips, bpf: Add JIT workarounds for CPU errata"), there
> is an ifdef that refers to a non-existing symbol WAR_R10000. Did you
> intend to refer to WAR_R10000_LLSC instead?

You are right, that is a typo. I will prepare a patch with a fix.

Thanks for catching!
Johan

>
> This issue was identified with the script ./scripts/checkkconfigsymbols.py.
>
> Best regards,
>> Lukas
