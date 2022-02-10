Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3CE5A4B0683
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Feb 2022 07:44:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235432AbiBJGor (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Feb 2022 01:44:47 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:51336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231362AbiBJGon (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Feb 2022 01:44:43 -0500
Received: from mail-vk1-xa32.google.com (mail-vk1-xa32.google.com [IPv6:2607:f8b0:4864:20::a32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75BFED6D;
        Wed,  9 Feb 2022 22:44:45 -0800 (PST)
Received: by mail-vk1-xa32.google.com with SMTP id l14so2480701vko.12;
        Wed, 09 Feb 2022 22:44:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=vATQV96HIV875DpM2fnnEa+rKLHrA6ZG+qfAprHu1e8=;
        b=DCGcZiebBFSTnkF9RGqM9hnYnWCcnAxcDZSEpbKWKeQs1KM3bM00eS9vRY+lkpxjD0
         GJoLV0IkKyT6IE1DPL0KegouXUMN33zgsVDuDCJ9JSSaoKUNqPsoO+uZmNBpwf3aoZfg
         Knoa4fPaLPMLT838YRhdjoDyRSH+9CAsKxF9FolpTEOLrM1z5L3VXHROzC1ZtHqrGxJK
         lRr2MiDnRrx6oaYralUySq+SzFeGN7DMSAUI00EyRefKX6bh3Jfy/13oOneZysryApyp
         Q0KbB5DIV+5rt8E2mutj+QMH7Z4uistgIpvFzqesllNC7vq+lm8hBVEqKKtyBt7XsVCp
         XzoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=vATQV96HIV875DpM2fnnEa+rKLHrA6ZG+qfAprHu1e8=;
        b=frq8udFHGQvomKBGUP8xJp3jy1OBx1vMr4HWs9Ttjs9XixnMycjLzjO8lY9AqaI5Yq
         m8qer7Vb5NmwaUHh7N4DO9mdME0FEWJfzOGg/nF/AYw2NXcjl+ozzIfUn9MmaoPNzfoS
         MzHNL1JA/qNvH2KOUXGCqD23yU6RQkVys3AF3jmEV9riiQAhdZ4BXR8rBKUyxrAmTm3F
         crPF2BnzPY0jxrBuhZB4t7p8yYtK5Pf8n/Nx66Afxl+VFmNvngJq+kBh1/OCu2XVNoyh
         Q/SJ8ChqiylS4kmoOC6Wj2ZgHOiFu+Cp0/wSRpR1S3sjtP40pT2PyVfLLwWXMSiHCq4k
         QceA==
X-Gm-Message-State: AOAM532m2PkZF/KOCbSCXtq0IH5XeEwf4uvdYjKF3aqU9qBGfY2LmwEX
        FYiQH0SZZEW4DqCLkH8qJgk3fXQDJR5vrfNPDLk=
X-Google-Smtp-Source: ABdhPJy4f9xIFUUmiX+BmjO+7FRRofRm71wdEsoGHAiePfWX1OQdeIlGzUShnt/VNT67jJifn+eRplmpDmZ6oamSjDc=
X-Received: by 2002:a05:6122:17a9:: with SMTP id o41mr2314279vkf.1.1644475484513;
 Wed, 09 Feb 2022 22:44:44 -0800 (PST)
MIME-Version: 1.0
References: <20220110114930.1406665-1-sergio.paracuellos@gmail.com>
 <YfE5MOkQRoHQV7Wf@kroah.com> <CAMhs-H8s0d=PswQDR86Tq-bQt634Z6rdFYHTE+DFepsthmKAYA@mail.gmail.com>
 <YfE7LNFuf79i3oAQ@kroah.com> <CAMhs-H9c8zF=v2tu5Y1OsFRP6esOi5zrUceqS_OUiJ=MSfCvRQ@mail.gmail.com>
 <20220205025548.AA1BBC004E1@smtp.kernel.org> <CAMhs-H82J5DC+m0V==tQKKYyqsu30kGLkdUbMRU+nsyLb8sL3Q@mail.gmail.com>
In-Reply-To: <CAMhs-H82J5DC+m0V==tQKKYyqsu30kGLkdUbMRU+nsyLb8sL3Q@mail.gmail.com>
From:   Sergio Paracuellos <sergio.paracuellos@gmail.com>
Date:   Thu, 10 Feb 2022 07:44:33 +0100
Message-ID: <CAMhs-H9RSjgW1-dafqDqbfBaQ4iH6NFDLoRHqjt=f41zAEcC-g@mail.gmail.com>
Subject: Re: [PATCH v8 0/4] clk: ralink: make system controller a reset provider
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     "open list:COMMON CLK FRAMEWORK" <linux-clk@vger.kernel.org>,
        John Crispin <john@phrozen.org>, linux-staging@lists.linux.dev,
        NeilBrown <neil@brown.name>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Stephen Boyd <sboyd@kernel.org>
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

Hi Greg,

On Sat, Feb 5, 2022 at 8:31 AM Sergio Paracuellos
<sergio.paracuellos@gmail.com> wrote:
>
> On Sat, Feb 5, 2022 at 3:55 AM Stephen Boyd <sboyd@kernel.org> wrote:
> >
> > Quoting Sergio Paracuellos (2022-01-26 04:45:31)
> > > On Wed, Jan 26, 2022 at 1:14 PM Greg KH <gregkh@linuxfoundation.org> wrote:
> > > >
> > > > On Wed, Jan 26, 2022 at 01:08:52PM +0100, Sergio Paracuellos wrote:
> > > > > On Wed, Jan 26, 2022 at 1:06 PM Greg KH <gregkh@linuxfoundation.org> wrote:
> > > > > >
> > > > > > On Mon, Jan 10, 2022 at 12:49:26PM +0100, Sergio Paracuellos wrote:
> > > > > > > Hi all,
> > > > > > >
> > > > > > > This patch series add minimal change to provide mt7621 resets properly
> > > > > > > defining them in the 'mediatek,mt7621-sysc' node which is the system
> > > > > > > controller of the SoC and is already providing clocks to the rest of
> > > > > > > the world.
> > > > > > >
> > > > > > > There is shared architecture code for all ralink platforms in 'reset.c'
> > > > > > > file located in 'arch/mips/ralink' but the correct thing to do to align
> > > > > > > hardware with software seems to define and add related reset code to the
> > > > > > > already mainlined clock driver.
> > > > > > >
> > > > > > > After this changes, we can get rid of the useless reset controller node
> > > > > > > in the device tree and use system controller node instead where the property
> > > > > > > '#reset-cells' has been added. Binding documentation for this nodeq has
> > > > > > > been updated with the new property accordly.
> > > > > > >
> > > > > > > This series also provide a bindings include header where all related
> > > > > > > reset bits for the MT7621 SoC are defined.
> > > > > > >
> > > > > > > Also, please take a look to this review [0] to understand better motivation
> > > > > > > for this series.
> > > > > > >
> > > > > > > Regarding the way of merging this:
> > > > > > >  - I'd like patches 1 and 4 which are related going through staging tree.
> > > > > >
> > > > > > Patches 1 and 4 now in the staging tree, thanks.
> > > > >
> > > > > Stephen wanted all to go through the CLK tree since PATCH 3 and 1 were
> > > > > also a dependency... Can we get all of them through the same tree,
> > > > > then? I am ok with both CLK or staging trees.
> > > >
> > > > That's fine with me if they all go through the CLK tree, but there will
> > > > be a merge issue that I already fixed up in my tree.  If you want me to
> > > > drop them, just let me know.
> > >
> > > Stephen, what do you prefer? Is it better all going through staging-tree then?
> > >
> >
> > Sure take them through staging tree.
> >
> > Acked-by: Stephen Boyd <sboyd@kernel.org>
>
> Thanks, Stephen.
>
> Greg, can you please take remaining patches 2 and 3 through your tree, then?
>
> Thanks in advance for your time.

Please, let me know if you prefer me to resend the remaining two
patches with tags added to make this easier for you.

Best regards,
    Sergio Paracuellos

>
> Best regards,
>     Sergio Paracuellos
