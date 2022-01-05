Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 69CB94851F9
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jan 2022 12:44:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239766AbiAELo1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Jan 2022 06:44:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229622AbiAELoY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jan 2022 06:44:24 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5325C061761
        for <linux-kernel@vger.kernel.org>; Wed,  5 Jan 2022 03:44:24 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5F7836170E
        for <linux-kernel@vger.kernel.org>; Wed,  5 Jan 2022 11:44:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 210AEC36AEB;
        Wed,  5 Jan 2022 11:44:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1641383063;
        bh=jMfT9xPIsqEfxt0aSl5f1zq4xF1hcR4BpRNAog5nMW4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=jq8/KP/p2TuxJ+h96v8nf2Iy2zKsb/RmESIKkjqMYzBO9W+sy0CbQotgMRBHu6oFv
         +qBOjFWxhF/7yCmduYEyFvFaF6hoRp4X22U8KPbCpR7+1zDggUESvJSMj5vl3Wy8mQ
         Lqe9/lYRpsSSym8eGXoIumcaxyBBLt1f5SFHK7gw=
Date:   Wed, 5 Jan 2022 12:44:21 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Baole Fang <fbl718@163.com>
Cc:     Takashi Iwai <tiwai@suse.de>, Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Jeremy Szu <jeremy.szu@canonical.com>,
        Werner Sembach <wse@tuxedocomputers.com>,
        Hui Wang <hui.wang@canonical.com>,
        Cameron Berkenpas <cam@neo-zeon.de>,
        Kailang Yang <kailang@realtek.com>, Sami Loone <sami@loone.fi>,
        Elia Devito <eliadevito@gmail.com>,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ALSA: hda/realtek: Add quirk for Legion Y9000X 2020
Message-ID: <YdWElRjkZ0lybrMJ@kroah.com>
References: <20220105034103.12484-1-fbl718@163.com>
 <s5ha6gak2qf.wl-tiwai@suse.de>
 <YdV5MNWOwgrtH2UC@kroah.com>
 <757a4402-1067-e3c8-8ca3-43ee62047ebe@163.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <757a4402-1067-e3c8-8ca3-43ee62047ebe@163.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 05, 2022 at 07:39:33PM +0800, Baole Fang wrote:
> Sorry, this is my first time to submit patch to Linux, so I'm not quite
> familiar with the convention. Since I was changing based on v5.15.12 and I
> saw others mentioning their upstream commit, I included the that commit id.

Those commits were coming from the stable backports only, they were not
done by the original author.

> Please forgive me and tell me what is supposed to be done if possible. I
> still have a lot to learn.

Please take a look at the "first kernel patch" tutorial on the
kernelnewbies.org site for a good example of how to do all of this.

Also the Documentation/SubmittingPatches file in the kernel source tree
should help out.

thanks,

greg k-h
