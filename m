Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7958E49C94B
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jan 2022 13:09:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241087AbiAZMJF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jan 2022 07:09:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233821AbiAZMJE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jan 2022 07:09:04 -0500
Received: from mail-ua1-x92a.google.com (mail-ua1-x92a.google.com [IPv6:2607:f8b0:4864:20::92a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ECBCCC06161C;
        Wed, 26 Jan 2022 04:09:03 -0800 (PST)
Received: by mail-ua1-x92a.google.com with SMTP id 2so43004279uax.10;
        Wed, 26 Jan 2022 04:09:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=8lp2UnjEidvC243D8ySx2ayoKmQ8Mrm2ZTxLTvCR7T4=;
        b=Iih5iHto2nGi19mzdVfhLkdAH//FfLBE0LfaWypVqZ8rnVVTn5UkMnW+yEY1hlRCoY
         57YVnuHB98OcCsZN6rto5P5hiM3RxvODmPJ+B4PNG/bqg9p+hjvruiIOod/03X60bNmU
         OBmB0NXkYAXcA9AAabOulCawt3a38OFsjp3z2RpD5hYI9reZH9cgCPdJb4cTuYjMkhZW
         TS3l/G1UeMOjpztXO4INYU6T7H9655NjFnC62WiyZSqMMHTb+H9NvARU5pofuTSwO5d7
         tbGofO7cQ6qTcX9cYB0FgBYwyFJ++deONgDimQfPczKKiq/qA2lo2ys5A40RVyaK8WxC
         74xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=8lp2UnjEidvC243D8ySx2ayoKmQ8Mrm2ZTxLTvCR7T4=;
        b=uPdrADRi+9BRr142fEL2BoZVGbQiNj2jy/wYfNytTX4aLrqxeeqJ/O5ZPeAErzRADq
         NqvM8yrtqa4uPYDhsvAUuXQLiuQX8ZmZt4f2sxTnXX6J0T8ad3zor5Cb+s5NImrYNPbg
         4eTIJGNSRGnxDDR1OYw+FF0+viMU3XyetsOvQ0Bq7sYIrZprwoCLqjTwUq47N/RXzn6I
         HSYWrA13/P19OdfYAaOjPWlFz5WpBJoT4pkaOSJoEhaiLffj2pxwpKghZFFXB0+EsJUA
         KvbNPq+nCN+JH2kmUdfWSftm+5dVbrM1oIuipxVwc+RAC5PABfMRWdrS24AXxpVO+e45
         jZig==
X-Gm-Message-State: AOAM533VZViBVvRiW8zo2YMxSwKx/yFNLyYyj4OAlMLOC1xzZlJD6Kvu
        eQBg8vBGHEXIS+lpO57qp5v7mkfrJa3yBKWKoK0=
X-Google-Smtp-Source: ABdhPJz5i4SlUp/3c7rAKDRo5jIIwdmYK5W5no/4gweeJqRnjgqcHJFS7H28mZWz4UESnosZ9HFZzfeObxMSdz66cVw=
X-Received: by 2002:a05:6102:3f12:: with SMTP id k18mr9209036vsv.76.1643198943090;
 Wed, 26 Jan 2022 04:09:03 -0800 (PST)
MIME-Version: 1.0
References: <20220110114930.1406665-1-sergio.paracuellos@gmail.com> <YfE5MOkQRoHQV7Wf@kroah.com>
In-Reply-To: <YfE5MOkQRoHQV7Wf@kroah.com>
From:   Sergio Paracuellos <sergio.paracuellos@gmail.com>
Date:   Wed, 26 Jan 2022 13:08:52 +0100
Message-ID: <CAMhs-H8s0d=PswQDR86Tq-bQt634Z6rdFYHTE+DFepsthmKAYA@mail.gmail.com>
Subject: Re: [PATCH v8 0/4] clk: ralink: make system controller a reset provider
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     "open list:COMMON CLK FRAMEWORK" <linux-clk@vger.kernel.org>,
        John Crispin <john@phrozen.org>, linux-staging@lists.linux.dev,
        NeilBrown <neil@brown.name>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Stephen Boyd <sboyd@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 26, 2022 at 1:06 PM Greg KH <gregkh@linuxfoundation.org> wrote:
>
> On Mon, Jan 10, 2022 at 12:49:26PM +0100, Sergio Paracuellos wrote:
> > Hi all,
> >
> > This patch series add minimal change to provide mt7621 resets properly
> > defining them in the 'mediatek,mt7621-sysc' node which is the system
> > controller of the SoC and is already providing clocks to the rest of
> > the world.
> >
> > There is shared architecture code for all ralink platforms in 'reset.c'
> > file located in 'arch/mips/ralink' but the correct thing to do to align
> > hardware with software seems to define and add related reset code to the
> > already mainlined clock driver.
> >
> > After this changes, we can get rid of the useless reset controller node
> > in the device tree and use system controller node instead where the property
> > '#reset-cells' has been added. Binding documentation for this nodeq has
> > been updated with the new property accordly.
> >
> > This series also provide a bindings include header where all related
> > reset bits for the MT7621 SoC are defined.
> >
> > Also, please take a look to this review [0] to understand better motivation
> > for this series.
> >
> > Regarding the way of merging this:
> >  - I'd like patches 1 and 4 which are related going through staging tree.
>
> Patches 1 and 4 now in the staging tree, thanks.

Stephen wanted all to go through the CLK tree since PATCH 3 and 1 were
also a dependency... Can we get all of them through the same tree,
then? I am ok with both CLK or staging trees.

Thanks,
    Sergio Paracuellos
>
> greg k-h
>
