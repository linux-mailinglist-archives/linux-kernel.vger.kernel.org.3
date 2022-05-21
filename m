Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BACA252FD77
	for <lists+linux-kernel@lfdr.de>; Sat, 21 May 2022 16:54:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345139AbiEUOy3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 21 May 2022 10:54:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232481AbiEUOyX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 21 May 2022 10:54:23 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55C8C7A455
        for <linux-kernel@vger.kernel.org>; Sat, 21 May 2022 07:54:22 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 12401B80683
        for <linux-kernel@vger.kernel.org>; Sat, 21 May 2022 14:54:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AB2B4C385A5
        for <linux-kernel@vger.kernel.org>; Sat, 21 May 2022 14:54:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1653144859;
        bh=gv7t7TTtEHrRh7da0HaHqbPXtO5YjTQx94ikD0+n5BE=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=YPbByDfqNTtFCE4jZGJULFRlUAZuYkS/A5+sNrqpl/QJKzMOEoZJ/iCEBkDBV+Z5/
         M0d2cn0pUI8pJrL3w+R8Y2UsrO4gKuEjvNvL+fbs3d0o7rHU3Nlwb1NeHvSWL9p+Gm
         ZWbFwT+BXeQYRaF5/ot0v81gTG0/0O5Ni2BcysINj8W9aTu/dF9IcixAepjSj80sDh
         twmvOzYpVaEoYUbbWpJeyUQLJDT+I9KQOQPGnQhto9u17rcq3Qx/20E+J6oKJMtDp7
         PLPTB1WQeLhgN8kZhL+feMyVS5IyZf3gp4LwYBFHL422DB9AGt2dlSttR4jQVHvN0q
         wMLmGeqrNoupw==
Received: by mail-yb1-f177.google.com with SMTP id i187so16277442ybg.6
        for <linux-kernel@vger.kernel.org>; Sat, 21 May 2022 07:54:19 -0700 (PDT)
X-Gm-Message-State: AOAM530jl9H+FiOu0MuK+0goHSH7Pg0D6bpHNo9BbztN20R+LJOEVBX+
        NUew818XCI4KG8pp4KM3UFfX+KZbO4id573oOOg=
X-Google-Smtp-Source: ABdhPJzyXNj4iV1kuQnAFrITCGznl5ncK397C6nMfoeX7UkT1/NeifkUJRDkKmqTDOTZlZEjIffL5ucWrl7+CsotXys=
X-Received: by 2002:a25:838e:0:b0:64d:d090:1783 with SMTP id
 t14-20020a25838e000000b0064dd0901783mr13442383ybk.242.1653144858705; Sat, 21
 May 2022 07:54:18 -0700 (PDT)
MIME-Version: 1.0
References: <20220521115325.GA1965670@ogabbay-vm-u20.habana-labs.com> <Yojnof1ekJg3yjwu@kroah.com>
In-Reply-To: <Yojnof1ekJg3yjwu@kroah.com>
From:   Oded Gabbay <ogabbay@kernel.org>
Date:   Sat, 21 May 2022 17:53:52 +0300
X-Gmail-Original-Message-ID: <CAFCwf13w+-nORUKePUbJJXPkgW+Pn+83BZMvAEonp185KxeJkw@mail.gmail.com>
Message-ID: <CAFCwf13w+-nORUKePUbJJXPkgW+Pn+83BZMvAEonp185KxeJkw@mail.gmail.com>
Subject: Re: [git pull] habanalabs pull request for kernel 5.19
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     "Linux-Kernel@Vger. Kernel. Org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, May 21, 2022 at 4:22 PM Greg KH <gregkh@linuxfoundation.org> wrote:
>
> On Sat, May 21, 2022 at 02:53:25PM +0300, Oded Gabbay wrote:
> > Hi Greg,
> >
> > This is habanalabs pull request for the merge window of kernel 5.19.
> > We added a few minor features, such as support eventfd registration
> > for device events, and the ability to scrub the device memory
> > through debugfs.
> >
> > We did some refactoring such as adding a centralized memory
> > manager inside the driver for allocating mmapable memory and tracking
> > it, so we can remove different code paths that basically duplicated
> > that functionality.
> >
> > And, as usual, there are multiple bug fixes.
> >
> > Full details are in the tag.
> >
> > Thanks,
> > Oded
> >
> > The following changes since commit cafada1fe932ce761d6c0bc1d56967e27abe4cff:
> >
> >   Revert "speakup: Generate speakupmap.h automatically" (2022-05-20 21:07:05 +0200)
> >
> > are available in the Git repository at:
> >
> >   https://git.kernel.org/pub/scm/linux/kernel/git/ogabbay/linux.git tags/misc-habanalabs-next-2022-05-21
> >
> > for you to fetch changes up to 93f742b13260b070a695f44d6b6ff696cb5cbcd8:
> >
> >   habanalabs: use separate structure info for each error collect data (2022-05-21 14:42:17 +0300)
>
> Has this been in linux-next already?  It's _really_ late to be adding
> new commits to my trees as 5.17 is about to come out in a few hours :(
>
> greg k-h

Yeah, sorry about that, I got to a computer only yesterday as my wife
and I had a new baby boy last week :)

To your question, no, my branch isn't taken to linux-next. Our driver
commits are added to linux-next only through your -next.

Thanks,
Oded
