Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5398E4CBA9C
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Mar 2022 10:46:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232133AbiCCJrE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Mar 2022 04:47:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229867AbiCCJrD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Mar 2022 04:47:03 -0500
Received: from mail-qt1-x834.google.com (mail-qt1-x834.google.com [IPv6:2607:f8b0:4864:20::834])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 426D81786AA;
        Thu,  3 Mar 2022 01:46:18 -0800 (PST)
Received: by mail-qt1-x834.google.com with SMTP id 11so4075431qtt.9;
        Thu, 03 Mar 2022 01:46:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=jms.id.au; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=LMZQi2xzeU3h2pCJDHHTKDS07JmqkzeuK2Xphn/0q4s=;
        b=JEz78kVVUxsYmb6tvePiirvEGHHnenhfOKK1CJ6j85tk/7vLhY1TvEheln+pm2DLOw
         jbGSbYijJgMdiqsSc5h7DJIEd+335ScrrRLKtDtpo1qcvyM3rm4uibPytsh++XHlDJ5x
         85NiNiOaod/m39eGdQEiE26F7CR0wJF+4AL0g=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=LMZQi2xzeU3h2pCJDHHTKDS07JmqkzeuK2Xphn/0q4s=;
        b=YbJoyK/1u7Yl9wy/YH40n6WAram1DDCcX5COxVH0FF2OdE2dTB0+kkoYKbYeA3bfB+
         PzxlpqXXkxba7wNfyIut62zkwKJ5q6emSs5Jy7vzkPQ9AanODmHMWfgIWDq2VsmL8NZr
         xgszElFMmwzBhPIP/HV4hTEGfG2qrtp+ynyKo5Lej2tySelisfrUXsMjlctpwm89/bmP
         CZrhIAn7fBRL6NkGqhvr22p9mr96J1+dCDCxQMO8pWbn4fi4WQ1n6d6JlSzUaPkgHffu
         fDKRVD1yhqUuMiKiWtUW2Zk97mO1wn1+6c4gnhw3e2V7vmrHIwaVpzn6tyJuh9yP4goN
         w89g==
X-Gm-Message-State: AOAM532eTMkGmMDVRovP495s2l07Tx8mwpfO1lykFMY/TCFF3Uh8pxEi
        8yVnjmf22My/inPEEvembE7wV/ViGG66Vn53op1MiVih8Zc=
X-Google-Smtp-Source: ABdhPJzCe8MO5Vn2NmLLnZMkE/G+5dZMnyl3jsiAcWRzQ1+USzlWF64lSx7pYXvZcvipEgNrp82f+yHHPZe4IG2OVf4=
X-Received: by 2002:a05:622a:111:b0:2dd:dc84:4d42 with SMTP id
 u17-20020a05622a011100b002dddc844d42mr26585703qtw.494.1646300777339; Thu, 03
 Mar 2022 01:46:17 -0800 (PST)
MIME-Version: 1.0
References: <20220301224446.21236-1-eajames@linux.ibm.com> <YiB7gz0GJ1Uz0mE2@hovoldconsulting.com>
 <CACPK8XfoCXisL=udkuO-x4LZ3r-9iKA2d7oLb7KmXs3+LkQgnQ@mail.gmail.com>
 <YiCHPuNkMuO4uARu@hovoldconsulting.com> <CACPK8XfUCyVgwVYLt_99CgQWuoFTw7O9d2NiuzMzGPa1VFVUyg@mail.gmail.com>
 <YiCN+x2XPiawaweY@hovoldconsulting.com>
In-Reply-To: <YiCN+x2XPiawaweY@hovoldconsulting.com>
From:   Joel Stanley <joel@jms.id.au>
Date:   Thu, 3 Mar 2022 09:46:05 +0000
Message-ID: <CACPK8Xc9MnM9_jr7NrNLtqBrN_t8D7G-scQvk51vbpOU6LWeuw@mail.gmail.com>
Subject: Re: [PATCH v2] USB: serial: pl2303: Add IBM device IDs
To:     Johan Hovold <johan@kernel.org>
Cc:     Eddie James <eajames@linux.ibm.com>, linux-usb@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Greg KH <gregkh@linuxfoundation.org>
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

On Thu, 3 Mar 2022 at 09:44, Johan Hovold <johan@kernel.org> wrote:
>
> On Thu, Mar 03, 2022 at 09:24:51AM +0000, Joel Stanley wrote:
> > On Thu, 3 Mar 2022 at 09:15, Johan Hovold <johan@kernel.org> wrote:
> > >
> > > On Thu, Mar 03, 2022 at 08:52:29AM +0000, Joel Stanley wrote:
> > > > On Thu, 3 Mar 2022 at 08:25, Johan Hovold <johan@kernel.org> wrote:
> > > > >
> > > > > On Tue, Mar 01, 2022 at 04:44:46PM -0600, Eddie James wrote:
> > > > > > IBM manufactures a PL2303 device for UPS communications. Add the vendor
> > > > > > and product IDs so that the PL2303 driver binds to the device.
> > > > > >
> > > > > > Signed-off-by: Joel Stanley <joel@jms.id.au>
> > > > > > Signed-off-by: Eddie James <eajames@linux.ibm.com>
> > > > > > ---
> > > > > > Changes since v1:
> > > > > >  - Fix commit message Signed-off-by ordering.
> > > > >
> > > > > Almost there. You're still missing a Co-developed-by tag, a From line,
> > > > > or both.
> > > >
> > > > It's neither. This patch was applied to a tree by myself, and I asked
> > > > Eddie to send it to mainline for merging.
> > >
> > > Then you are missing a From line. As the patch looks like know, Eddie is
> > > considered the author and not you.
> >
> > You are incorrect. Eddie is the author.
>
> Then what is your SoB doing there in the first place? If Eddie is the
> sole author as well as the submitter, and you didn't touch the patch in
> between, then your SoB does not belong in the chain.
>
> If you applied Eddie's patch to your shared tree and Eddie generated a
> patch from there, then the chain should be:
>
>         SoB: E
>         SoB: J
>         SoB: E
>
> but this is starting to look a bit ridiculous.

I agree. I would appreciate it if you applied the patch, with or
without my sob in whatever order you deem fit.
