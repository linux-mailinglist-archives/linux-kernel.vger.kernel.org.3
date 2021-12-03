Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 16F10467A64
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Dec 2021 16:37:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1381836AbhLCPlS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Dec 2021 10:41:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1381746AbhLCPlR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Dec 2021 10:41:17 -0500
Received: from mail-ua1-x930.google.com (mail-ua1-x930.google.com [IPv6:2607:f8b0:4864:20::930])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9EB49C061751;
        Fri,  3 Dec 2021 07:37:53 -0800 (PST)
Received: by mail-ua1-x930.google.com with SMTP id n6so6275375uak.1;
        Fri, 03 Dec 2021 07:37:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=+HrQ3J/HeO/GYMnMzsFEsM1o2YndrW9CPhQv68AS01E=;
        b=qAsjyc6ITBdQPfIq07bY2cHfZBHlABg0T9Oy5G6Hmgw4mQ7mMnmnHpKUQ73hjAjTiW
         W4ymDk7FJU2c31gTdxEAnlj2HVNHyTOo69S0k0CrV5Mg15UbW7lSyrpKkBcj3AYYLOiD
         X6Xi+kD3WgK7l4snPMkiGWu1/FHtllcd8ITjTdBw/VhYPjg85JN/2RnsBf40eVr457CG
         4NOv3fS9w98Gq6y0pxtfco5d3VL9fLRkMQL386dl2kX3CSPXDOVAjFWnM4z8c6UEPj5G
         AIN4b8k+aUZMRHcVr5KzvJA3DXwBsH37hjlhBVVwoTldNNhd/ktgMTqnh12FoL9qEF+e
         8m2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=+HrQ3J/HeO/GYMnMzsFEsM1o2YndrW9CPhQv68AS01E=;
        b=SBijK11PWJku+Ii8KoaBSbLFHedrJW57prs5N8Lh8hVar89g57tq/xFpDY4fLf4JOQ
         +06P1bazc13+4utYO9ypOxUgxVZFIeHtFGyNc06PdZPYPK4VnXXj12Q5bsqY935f1De6
         sP5FIuF6FTl7lVaPed6BnAfJoPbqOUD9XYvK2a60QkBQQ4QipnkhrXnnZdDNTyI6IJTN
         ADWetDOgImIQhmee3RggMOMe1FwNtAmlpG3ybRYpT2sgLWhxPe/CRlzaXNvkkfFN8t5X
         nKPejIa1i5t5tX30vnVCRxQAOaDp9KbL4OdbGbRNJpnIFQR316pVMcG7lSaQRO+xUjeq
         5S4g==
X-Gm-Message-State: AOAM5310kQPGWV/fi6ei/9EPEm4sqgR/Hs1FxZCRZiRWe58H4XALUEtR
        b7kpBUMmkYPu2hcRHI3a1+rBN4eYCB4yzVOdMdo=
X-Google-Smtp-Source: ABdhPJySDfWB5ZvpJndLFL0F219WJXO9O/8gTVzkZsiqUOsl9LpvktP7BU7fXuzHctYTF/4gCGoGdAo+70uHuCwcACw=
X-Received: by 2002:a05:6102:2835:: with SMTP id ba21mr21178749vsb.76.1638545872863;
 Fri, 03 Dec 2021 07:37:52 -0800 (PST)
MIME-Version: 1.0
References: <20211107074200.18911-1-sergio.paracuellos@gmail.com>
 <20211107074200.18911-5-sergio.paracuellos@gmail.com> <YaokmRHYsazdMByi@kroah.com>
In-Reply-To: <YaokmRHYsazdMByi@kroah.com>
From:   Sergio Paracuellos <sergio.paracuellos@gmail.com>
Date:   Fri, 3 Dec 2021 16:37:41 +0100
Message-ID: <CAMhs-H81bbmncXcV2-HMLh-gLBCUshO18y6E=XsyVgST9Hj5xg@mail.gmail.com>
Subject: Re: [PATCH v5 4/4] staging: mt7621-dts: align resets with binding documentation
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     "open list:COMMON CLK FRAMEWORK" <linux-clk@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Stephen Boyd <sboyd@kernel.org>,
        John Crispin <john@phrozen.org>, linux-staging@lists.linux.dev,
        NeilBrown <neil@brown.name>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 3, 2021 at 3:07 PM Greg KH <gregkh@linuxfoundation.org> wrote:
>
> On Sun, Nov 07, 2021 at 08:42:00AM +0100, Sergio Paracuellos wrote:
> > Binding documentation for compatible 'mediatek,mt7621-sysc' has been updated
> > to be used as a reset provider. Align reset related bits and system controller
> > node with binding documentation along the dtsi file.
> >
> > Signed-off-by: Sergio Paracuellos <sergio.paracuellos@gmail.com>
> > ---
> >  drivers/staging/mt7621-dts/mt7621.dtsi | 25 +++++++++++--------------
> >  1 file changed, 11 insertions(+), 14 deletions(-)
>
> This patch does not apply to my tree :(

This needs to be added when the changes in mt7621-clk driver (the
other patches in the series) are applied. Let me resend this properly
rebased to get a clean apply in your tree when Stephen applies the
others in the clk tree.

Thanks,
    Sergio Paracuellos
>
> thanks,
>
> greg k-h
