Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C87E64C98D6
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Mar 2022 00:09:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236210AbiCAXKb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Mar 2022 18:10:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235300AbiCAXKa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Mar 2022 18:10:30 -0500
Received: from mail-io1-xd2c.google.com (mail-io1-xd2c.google.com [IPv6:2607:f8b0:4864:20::d2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7EBE0BCA6
        for <linux-kernel@vger.kernel.org>; Tue,  1 Mar 2022 15:09:48 -0800 (PST)
Received: by mail-io1-xd2c.google.com with SMTP id c14so20260065ioa.12
        for <linux-kernel@vger.kernel.org>; Tue, 01 Mar 2022 15:09:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sartura-hr.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=Y8RDk06dMtqt5Vc0Z3JX9uAw5ZRfhyFUAMgbkcYcBz8=;
        b=YcVqUtD6HgXzkV0tWm1n0cAKwLfj5cwKwSMSgZcvGVqzEoSKYf4RoDovFp1AOaI8Ra
         HydFb/Vwnt4VEwxtoNxp67ITHrgB6DHoQ8ZmD6EvLwAqgaEerh5EQ1KVudjqrWAezPbl
         j5EKdxRCVQDbrp9ZUz6UHxGwviVneyrc5EJ0n1ew1+fAdjtW/YIeBbEP+5ZxLq0iST5D
         3R3P4ZjV3ErWC2zj7hjgKAetPOEesYSIzbdwoaiUXUZW480Ae9ieltZWKC5ADIdRCPyW
         Af9Hl+Jb+xywqWCOsRhY+WnJFpmcsUSuMsewxbiur/60KtWGZN4Mi42VZxnUhnPgePsd
         3RQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=Y8RDk06dMtqt5Vc0Z3JX9uAw5ZRfhyFUAMgbkcYcBz8=;
        b=UxLmjQAh5ULeso/PdGcfHwfIa00/N+lyuoa+PWquNKyQufcLlzM4okaweCi7UZJcR7
         37BnKBlIiAprgEzBJ4PDweXQ347soVHFOQiehx4hUA9oYGVbxNMYB03g7vDkbhxk47Ik
         /B0XfMHEslsYR1Xyc/bo7OETYIeND9uxBwt3ZEH/wjc4XQryrLHAxsgprVvcUDckmilB
         91Rb35NcMjA3tvi5xgNqmvDGGbkUTYQ6xHnYBwFnsEEztUeSuD6tK0LoC904WaZLC+65
         Xjb9ZeISZ+onSCr2gQjv2u3sW7EUHtaueQGaRjJ4lULo+Gg4mc6YW2L+4uMnnmVtqtQ/
         z4+A==
X-Gm-Message-State: AOAM530CyuB3svEwI7J70kOsqH7RQR+vH0Gv5kXs4KBHHzS1LOSL7ICE
        RVPbzYFn6xHhixWxLpdUNFt9U/+C5V2bD3TqvqF6gg==
X-Google-Smtp-Source: ABdhPJxm9iap8trMn5QrNdom9Tnebv2vnXpm6120kMDo+ky58M1hnvyfjtI5XBsce7XsvA2LdYzVxvvR2rryTv3V8hA=
X-Received: by 2002:a05:6602:2b13:b0:602:ccc:86ba with SMTP id
 p19-20020a0566022b1300b006020ccc86bamr20697481iov.176.1646176187862; Tue, 01
 Mar 2022 15:09:47 -0800 (PST)
MIME-Version: 1.0
References: <20220228193928.3ec6ee98@canb.auug.org.au> <YhyPfcjJtIKNQtF8@google.com>
 <Yhyn72NO/roH1gA8@kroah.com> <YhzENKPtY+WOp566@google.com>
 <Yh09/r/nT2LeE82n@kroah.com> <Yh3pZXQPP9kmcSSx@google.com>
 <Yh325S5PyPiJf4F5@kroah.com> <Yh37gTCPaESkgNzV@google.com>
In-Reply-To: <Yh37gTCPaESkgNzV@google.com>
From:   Robert Marko <robert.marko@sartura.hr>
Date:   Wed, 2 Mar 2022 00:09:36 +0100
Message-ID: <CA+HBbNF1Am7k9M7Mf_9+TRmQ6CtFkF5MSQ4LU79svvSxPUBPiw@mail.gmail.com>
Subject: Re: linux-next: manual merge of the char-misc tree with the mfd tree
To:     Lee Jones <lee.jones@linaro.org>
Cc:     Greg KH <greg@kroah.com>, Stephen Rothwell <sfr@canb.auug.org.au>,
        Arnd Bergmann <arnd@arndb.de>,
        Alistair Francis <alistair@alistair23.me>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 1, 2022 at 11:54 AM Lee Jones <lee.jones@linaro.org> wrote:
>
> On Tue, 01 Mar 2022, Greg KH wrote:
>
> > On Tue, Mar 01, 2022 at 09:37:41AM +0000, Lee Jones wrote:
> > > On Mon, 28 Feb 2022, Greg KH wrote:
> > >
> > > > On Mon, Feb 28, 2022 at 12:46:44PM +0000, Lee Jones wrote:
> > > > > On Mon, 28 Feb 2022, Greg KH wrote:
> > > > >
> > > > > > On Mon, Feb 28, 2022 at 09:01:49AM +0000, Lee Jones wrote:
> > > > > > > On Mon, 28 Feb 2022, Stephen Rothwell wrote:
> > > > > > >
> > > > > > > > Hi all,
> > > > > > > >
> > > > > > > > Today's linux-next merge of the char-misc tree got a confli=
ct in:
> > > > > > >
> > > > > > > I did ask for this *not* to be merged when it was in -testing=
.
> > > > > >
> > > > > > Sorry, I missed that, I saw your ack on the patch so that's why=
 I took
> > > > > > it.
> > > > > >
> > > > > > > I'll follow-up with Greg.
> > > > > >
> > > > > > Should I revert this from my tree?
> > > > >
> > > > > I did try to catch it before a revert would have been required.
> > > >
> > > > My fault.
> > > >
> > > > > But yes, please revert it.
> > > >
> > > > Will go do so now.
> > >
> > > Thank you.
> > >
> > > > > The Ack is not standard and should not be merged.
> > > >
> > > > I do not understand this, what went wrong here?
> > >
> > > The "Ack" you saw was just a placeholder.
> > >
> > > When I provided it, I would have done so like this:
> > >
> > >     "For my own reference (apply this as-is to your sign-off block):
> > >
> > >      Acked-for-MFD-by: Lee Jones <lee.jones@linaro.org>"
> > >
> > > REF: https://lore.kernel.org/all/YQ0fYe531yCyP4pf@google.com/
> > >
> > > The majority of maintainers I regularly work with know this to mean
> > > that the set is due to be routed via MFD (with a subsequent
> > > pull-request to an immutable branch to follow), since MFD is often
> > > the centre piece (parent) of the patch-sets I deal with.
> > >
> > > I appreciate that this could cause confusion, but I'm not sure of a
> > > better way to convey this information such that it survives through
> > > various submission iterations.
> >
> > But what else is another maintainer supposed to think if they see that
> > ack on the patch?  Ignore it?  I took that to mean "this is good from a
> > mfd-point-of-view" which meant it can go through whatever tree it is
> > supposed to.
> >
> > Are you wanting this individual patch to go through your tree now only?
> > If so, you should say that by NOT acking it :)
>
> It's not quite as easy as that.
>
> It wouldn't be fair to the contributor to start reviews once all the
> other patches in the set are ready to be merged.  So how would I
> indicate that the MFD part is ready, fully expecting some of the other
> patches in the set to be reworked and subsequent revisions are to be
> submitted?
>
> This method actually works really well the majority of the time, and
> has done for a number of years.  However, I am always willing to
> improve on my processes given the opportunity.
>
> > How do you want to see this merged?
>
> The plan is for the whole set to be merged together via MFD.
>
> All of the other maintainers have now Acked, so it's ready to go:
>
>   https://lore.kernel.org/all/20220131133049.77780-1-robert.marko@sartura=
.hr/

Hi Lee, as far as I understand you will now take this series up via
your MFD tree?

Regards,
Robert
>
> Looking at the diff, I'm not entirely sure why you took it in the
> first place?
>
> --
> Lee Jones [=E6=9D=8E=E7=90=BC=E6=96=AF]
> Principal Technical Lead - Developer Services
> Linaro.org =E2=94=82 Open source software for Arm SoCs
> Follow Linaro: Facebook | Twitter | Blog



--=20
Robert Marko
Staff Embedded Linux Engineer
Sartura Ltd.
Lendavska ulica 16a
10000 Zagreb, Croatia
Email: robert.marko@sartura.hr
Web: www.sartura.hr
