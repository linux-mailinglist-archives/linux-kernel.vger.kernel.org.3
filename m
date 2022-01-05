Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9F22E48527F
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jan 2022 13:33:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240043AbiAEMdx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Jan 2022 07:33:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231857AbiAEMdw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jan 2022 07:33:52 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37CB7C061761
        for <linux-kernel@vger.kernel.org>; Wed,  5 Jan 2022 04:33:52 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A31EB6170E
        for <linux-kernel@vger.kernel.org>; Wed,  5 Jan 2022 12:33:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7EFCDC36AEB;
        Wed,  5 Jan 2022 12:33:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1641386031;
        bh=ehS9Wp4klxNh6imSS80ubyOMxmVlzZk1ZeiNIm5nyzI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=nEVBmKp/xF2RVPedxZZvilxaYXiDqhT3DrhbW83UTQyahfZyJsZaN+lJM51WfrAk6
         j0PiHLXuJiAeyXdA0apXnG2LkU2s5cr6u4uKuWlrKCrtpULjI4k2xM57MPV+8dXxeq
         Zd20bPOyU6nd/wdgEhje87Elak00dlFhn8wA6kQ0=
Date:   Wed, 5 Jan 2022 13:33:48 +0100
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
Message-ID: <YdWQLOtV8Tz8ArrH@kroah.com>
References: <20220105034103.12484-1-fbl718@163.com>
 <s5ha6gak2qf.wl-tiwai@suse.de>
 <YdV5MNWOwgrtH2UC@kroah.com>
 <757a4402-1067-e3c8-8ca3-43ee62047ebe@163.com>
 <YdWElRjkZ0lybrMJ@kroah.com>
 <6bf35d26-73d4-ba14-f931-8d379c623482@163.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6bf35d26-73d4-ba14-f931-8d379c623482@163.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

A: http://en.wikipedia.org/wiki/Top_post
Q: Were do I find info about this thing called top-posting?
A: Because it messes up the order in which people normally read text.
Q: Why is top-posting such a bad thing?
A: Top-posting.
Q: What is the most annoying thing in e-mail?

A: No.
Q: Should I include quotations after my reply?

http://daringfireball.net/2007/07/on_top

On Wed, Jan 05, 2022 at 08:29:26PM +0800, Baole Fang wrote:
> Thank you for your explanation! I shouldn't have written that line and I
> supposed it can be ignored. Is there anything else I could do?

We can not just "ignore" it, you need to fix your change up and resend
it in a proper format so that it can be applied.

As-is, it is not acceptable, sorry.

thanks,

greg k-h
