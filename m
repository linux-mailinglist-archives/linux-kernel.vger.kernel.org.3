Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8B6B04B0A01
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Feb 2022 10:53:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239171AbiBJJxF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Feb 2022 04:53:05 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:40504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232590AbiBJJxD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Feb 2022 04:53:03 -0500
Received: from mail-vs1-xe34.google.com (mail-vs1-xe34.google.com [IPv6:2607:f8b0:4864:20::e34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92BDE128;
        Thu, 10 Feb 2022 01:53:04 -0800 (PST)
Received: by mail-vs1-xe34.google.com with SMTP id j5so2434371vsm.5;
        Thu, 10 Feb 2022 01:53:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=N/o/oEDK6yNA6KzQQ36RhfRwk2uRGWwiWLSILhdKP7k=;
        b=kqbXjTNyeNaOJPTbZTaTkpLJJbJdJN35K23eEWCPQYQWK5f9EUQMZt1qygDTuXHANb
         eKBBIx0YJ89trZZabVjK9YltMrTqVuvyv1Ylp3PodeckaKNlcTOeSL9yXkFxFSzGTgAh
         H8pBwAUYO9ZtYNl+cDM+hoQF5+e7qPVCrP9m+ypCU6QSaM6aJhPPTbvI+q5VexvO8JB9
         Zxcz/WkbFtMgjuFqe/fJ0OCRz/drMA/0I1Y1siddfF8ocT82IBe1+T2T5mAu60IRbBnc
         O3Ga+/BrmxDaITxMs1ASPhH9RWURXvloUTyHTxHYO499G+vWQRQwR6pNpWfXdwBztLlZ
         6VTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=N/o/oEDK6yNA6KzQQ36RhfRwk2uRGWwiWLSILhdKP7k=;
        b=FZ6oaTRlIztaRPzTFBl5zzecNEmgGiuFyzEYj6oRgs/Tn0G0jC7X7Rg1m8n+m25xQ8
         1dzgMcD+7kiaQgLgQGJAsjih5AlBd088OCBgYAlEU/8YT9QmR65GDqEvYYgbkS0ZPgQN
         ZAwZ8NoSIQtFDpoCUBog5LOSmhj4Xc/xRmkWpz3i4IXgQqx6a3m9s7E9wORWMDgEhvdu
         YrIQhh3CVmyQJ8oCrG1rjwXfRHLwetcEawms3U9FMgwWQBh2i8R/KOVfjm9S36vd3cJ5
         AJ/+J8R4M4v3UM0vMh0sJNMX/Yt2mr3+ghrsyrJTV90nyUJe8IJZRG25h5D7qP7emsx1
         Y6aA==
X-Gm-Message-State: AOAM532q/02EAeCEWDHZgDzH+yIebV+zRvUWmU30fJTBA6KkFb3sy7fh
        6FGUC+gEeuZwj6vIsDhYfjIwmIgU1B7IPVqisos=
X-Google-Smtp-Source: ABdhPJy3BmfjGBsQ/1m6jTaEjOrRuG/WxuKfSjaUqL39oOImZUuIRENvrfMRIIwP14Pwy6n28CGijThXnVMbZNnA5hE=
X-Received: by 2002:a67:f890:: with SMTP id h16mr2554081vso.43.1644486783621;
 Thu, 10 Feb 2022 01:53:03 -0800 (PST)
MIME-Version: 1.0
References: <20220110114930.1406665-1-sergio.paracuellos@gmail.com>
 <YfE5MOkQRoHQV7Wf@kroah.com> <CAMhs-H8s0d=PswQDR86Tq-bQt634Z6rdFYHTE+DFepsthmKAYA@mail.gmail.com>
 <YfE7LNFuf79i3oAQ@kroah.com> <CAMhs-H9c8zF=v2tu5Y1OsFRP6esOi5zrUceqS_OUiJ=MSfCvRQ@mail.gmail.com>
 <20220205025548.AA1BBC004E1@smtp.kernel.org> <CAMhs-H82J5DC+m0V==tQKKYyqsu30kGLkdUbMRU+nsyLb8sL3Q@mail.gmail.com>
 <CAMhs-H9RSjgW1-dafqDqbfBaQ4iH6NFDLoRHqjt=f41zAEcC-g@mail.gmail.com> <YgS26WAtSkQbZam4@kroah.com>
In-Reply-To: <YgS26WAtSkQbZam4@kroah.com>
From:   Sergio Paracuellos <sergio.paracuellos@gmail.com>
Date:   Thu, 10 Feb 2022 10:52:52 +0100
Message-ID: <CAMhs-H_x0My6ZfnZkyyEiSd+vT66ijf-fPzxxHohD_Yzko4h-Q@mail.gmail.com>
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

On Thu, Feb 10, 2022 at 7:55 AM Greg KH <gregkh@linuxfoundation.org> wrote:
>
> On Thu, Feb 10, 2022 at 07:44:33AM +0100, Sergio Paracuellos wrote:
> > Hi Greg,
> >
> > On Sat, Feb 5, 2022 at 8:31 AM Sergio Paracuellos
> > <sergio.paracuellos@gmail.com> wrote:
> > >
> > > On Sat, Feb 5, 2022 at 3:55 AM Stephen Boyd <sboyd@kernel.org> wrote:
> > > >
> > > > Quoting Sergio Paracuellos (2022-01-26 04:45:31)
> > > > > On Wed, Jan 26, 2022 at 1:14 PM Greg KH <gregkh@linuxfoundation.org> wrote:
> > > > > >
> > > > > > On Wed, Jan 26, 2022 at 01:08:52PM +0100, Sergio Paracuellos wrote:
> > > > > > > On Wed, Jan 26, 2022 at 1:06 PM Greg KH <gregkh@linuxfoundation.org> wrote:
> > > > > > > >
> > > > > > > > On Mon, Jan 10, 2022 at 12:49:26PM +0100, Sergio Paracuellos wrote:
> > > > > > > > > Hi all,
> > > > > > > > >
> > > > > > > > > This patch series add minimal change to provide mt7621 resets properly
> > > > > > > > > defining them in the 'mediatek,mt7621-sysc' node which is the system
> > > > > > > > > controller of the SoC and is already providing clocks to the rest of
> > > > > > > > > the world.
> > > > > > > > >
> > > > > > > > > There is shared architecture code for all ralink platforms in 'reset.c'
> > > > > > > > > file located in 'arch/mips/ralink' but the correct thing to do to align
> > > > > > > > > hardware with software seems to define and add related reset code to the
> > > > > > > > > already mainlined clock driver.
> > > > > > > > >
> > > > > > > > > After this changes, we can get rid of the useless reset controller node
> > > > > > > > > in the device tree and use system controller node instead where the property
> > > > > > > > > '#reset-cells' has been added. Binding documentation for this nodeq has
> > > > > > > > > been updated with the new property accordly.
> > > > > > > > >
> > > > > > > > > This series also provide a bindings include header where all related
> > > > > > > > > reset bits for the MT7621 SoC are defined.
> > > > > > > > >
> > > > > > > > > Also, please take a look to this review [0] to understand better motivation
> > > > > > > > > for this series.
> > > > > > > > >
> > > > > > > > > Regarding the way of merging this:
> > > > > > > > >  - I'd like patches 1 and 4 which are related going through staging tree.
> > > > > > > >
> > > > > > > > Patches 1 and 4 now in the staging tree, thanks.
> > > > > > >
> > > > > > > Stephen wanted all to go through the CLK tree since PATCH 3 and 1 were
> > > > > > > also a dependency... Can we get all of them through the same tree,
> > > > > > > then? I am ok with both CLK or staging trees.
> > > > > >
> > > > > > That's fine with me if they all go through the CLK tree, but there will
> > > > > > be a merge issue that I already fixed up in my tree.  If you want me to
> > > > > > drop them, just let me know.
> > > > >
> > > > > Stephen, what do you prefer? Is it better all going through staging-tree then?
> > > > >
> > > >
> > > > Sure take them through staging tree.
> > > >
> > > > Acked-by: Stephen Boyd <sboyd@kernel.org>
> > >
> > > Thanks, Stephen.
> > >
> > > Greg, can you please take remaining patches 2 and 3 through your tree, then?
> > >
> > > Thanks in advance for your time.
> >
> > Please, let me know if you prefer me to resend the remaining two
> > patches with tags added to make this easier for you.
>
> Please do so, as I can't seem to dig up the remaining ones...

Ok, done. Please check:
https://lore.kernel.org/linux-staging/20220210094859.927868-1-sergio.paracuellos@gmail.com/T/#t

Best regards,
    Sergio Paracuellos

>
> thanks,
>
> greg k-h
