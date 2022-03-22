Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7B4924E44AB
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Mar 2022 18:06:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239343AbiCVRHg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Mar 2022 13:07:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231186AbiCVRHc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Mar 2022 13:07:32 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01A8762C2;
        Tue, 22 Mar 2022 10:06:03 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id A85F5B81CED;
        Tue, 22 Mar 2022 17:06:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 66269C340F5;
        Tue, 22 Mar 2022 17:06:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1647968761;
        bh=I90Q1yL3ZsVCkc/hXJ77PW/IOeESv0+uLIFtxRhG+QY=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=YlaG1a4Lcc3Io4HDmK/3kzGApE6DcetS4vE2nVLUCgETwMvmhKIXPBkcnJjgt7mR0
         IW8J3qN50G/8aFySTRxsQ2uWrrf48HrJIlWJCJLS26Wv8VDJNhhYj6mQfOkC1ji2KG
         vw01y/iSI5Gpo6zYlZi7wtBiR2g0P0b7jLOawTdG7TGEocJ9pmkRJNR1M4hf6u/i4x
         vRoOLK38oPwQMjckVOqqnvS+M3cJ2Ns26jh94Dk/MkouZs+jhD/Bg6c3EBy/2G4fQo
         +Vt26MsjuZuq4ALOMB6W3DaDzfK9c0c9g+IB+GBy8iB7sPZfzidxiNLyOU0JDWenD2
         tLiYcVOlhnkIQ==
Received: by mail-pj1-f48.google.com with SMTP id mz9-20020a17090b378900b001c657559290so3560000pjb.2;
        Tue, 22 Mar 2022 10:06:01 -0700 (PDT)
X-Gm-Message-State: AOAM532AqKhYHACNRU1DCkeqgAMxQm9EzR6LeCwNKAzTIpmQN+Ob4VdI
        U7cSMLo6FCJa0f4rkj05ukKLSL6sB0aLjLkPplE=
X-Google-Smtp-Source: ABdhPJycCT1LkvZga/e0W6zDH8tC9vsexe7bu7jZnKVb+DPob7Sqf3iYqLKdXUYGmNT216Iji86Xg+la6oaCr9tqOGY=
X-Received: by 2002:a17:90a:3181:b0:1c7:6d18:391a with SMTP id
 j1-20020a17090a318100b001c76d18391amr2895779pjb.30.1647968760887; Tue, 22 Mar
 2022 10:06:00 -0700 (PDT)
MIME-Version: 1.0
References: <CGME20220321090202epcas2p1bfa78db059c1f6f6acbbb015e4bf991c@epcas2p1.samsung.com>
 <1647853194-62147-1-git-send-email-dh10.jung@samsung.com> <YjhB7+AaEXvuUmdi@kroah.com>
 <20220321092409.GA62265@ubuntu> <YjhGKVKuPsKG80wZ@kroah.com>
 <20220321100631.GB62265@ubuntu> <YjhQg4I7eYWXIfgr@kroah.com>
In-Reply-To: <YjhQg4I7eYWXIfgr@kroah.com>
From:   Krzysztof Kozlowski <krzk@kernel.org>
Date:   Tue, 22 Mar 2022 18:05:49 +0100
X-Gmail-Original-Message-ID: <CAJKOXPdmSUqs+d3CuJ9px=vWPPdgP0scAZvKJkKDrs5O+sw6yA@mail.gmail.com>
Message-ID: <CAJKOXPdmSUqs+d3CuJ9px=vWPPdgP0scAZvKJkKDrs5O+sw6yA@mail.gmail.com>
Subject: Re: [PATCH v3 0/4] support USB offload feature
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Jung Daehwan <dh10.jung@samsung.com>,
        Mathias Nyman <mathias.nyman@intel.com>,
        "open list:USB XHCI DRIVER" <linux-usb@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        Howard Yen <howardyen@google.com>,
        Jack Pham <jackp@codeaurora.org>,
        Puma Hsu <pumahsu@google.com>,
        "J . Avila" <elavila@google.com>, sc.suh@samsung.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 21 Mar 2022 at 11:16, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
> >
> > [v3, 0/4] add xhci-exynos driver
> >
> > This patchset is for support xhci-exynos driver....
> > ....
> >
> >   usb: host: export symbols for xhci-exynos to use xhci hooks
> >   usb: host: add xhci hooks for xhci-exynos
> >   usb: host: add some to xhci overrides for xhci-exynos
> >   usb: host: add xhci-exynos driver
>
> Yes, that makes much more sense.  What would you want to see if you had
> to review such a series?

Unfortunately it might not make more sense, because last time
xhci-exynos driver was a fake driver, not for submission. It did not
compile, it did not work in mainline.

That driver was not even sent to proper mailing lists, as pointed out
by get_maintainers.pl, maybe because it was not developed on the
mainline kernel, so there is no MAINTAINERS file?


Best regards,
Krzysztof
