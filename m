Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 344FF48517E
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jan 2022 11:55:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239549AbiAEKzs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Jan 2022 05:55:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232847AbiAEKzr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jan 2022 05:55:47 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BDE7BC061761
        for <linux-kernel@vger.kernel.org>; Wed,  5 Jan 2022 02:55:47 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 681F0616B8
        for <linux-kernel@vger.kernel.org>; Wed,  5 Jan 2022 10:55:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 44491C36AE9;
        Wed,  5 Jan 2022 10:55:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1641380146;
        bh=uLT/4ZmZ4gCruF3sfsgP2zbntUDWjS4C+YlQN7+XDZk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=RVveCEnsIo/WopjVWPTZVf98pVF4/mTZDkQ8XXdRbSr1qtmxQe+pbTD/nsLJuLFqn
         ttUwVFG7SusGF7/0u4/we2M+8Xb50pWoXzSCY85HX2154gvSDZTfLoTgjmGtHt52pV
         RS76wcNUoWSIoykRb0kxqfpdZPeHoJNkTChrdDLw=
Date:   Wed, 5 Jan 2022 11:55:44 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Takashi Iwai <tiwai@suse.de>
Cc:     Baole Fang <fbl718@163.com>, Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Jeremy Szu <jeremy.szu@canonical.com>,
        Werner Sembach <wse@tuxedocomputers.com>,
        Hui Wang <hui.wang@canonical.com>,
        Cameron Berkenpas <cam@neo-zeon.de>,
        Kailang Yang <kailang@realtek.com>, Sami Loone <sami@loone.fi>,
        Elia Devito <eliadevito@gmail.com>,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ALSA: hda/realtek: Add quirk for Legion Y9000X 2020
Message-ID: <YdV5MNWOwgrtH2UC@kroah.com>
References: <20220105034103.12484-1-fbl718@163.com>
 <s5ha6gak2qf.wl-tiwai@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <s5ha6gak2qf.wl-tiwai@suse.de>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 05, 2022 at 09:26:16AM +0100, Takashi Iwai wrote:
> On Wed, 05 Jan 2022 04:41:01 +0100,
> Baole Fang wrote:
> > 
> > commit 25960cafa06e6fcd830e6c792e6a7de68c1e25ed upstream.
> 
> I couldn't find this commit.  Is this a bogus information?
> 
> > Legion Y9000X 2020 has a speaker, but the speaker doesn't work.
> > This can be fixed by applying alc285_fixup_ideapad_s740_coef
> >  to fix the speaker's coefficients.
> > Besides, to support the transition between the speaker and the headphone,
> > alc287_fixup_legion_15imhg05_speakers needs to be run.
> > 
> > Signed-off-by: Baole Fang <fbl718@163.com>
> 
> The code change itself looks fine, so I'd apply it if the line above
> can be omitted.

That commit id comes from 5.15.12, and it is the commit id of the
release commit:
	25960cafa06e ("Linux 5.15.12")
which makes no sense at all.

Baole, why did you add this line?

confused,

greg k-h
