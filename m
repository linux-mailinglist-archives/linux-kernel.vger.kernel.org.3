Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 207FB47F5C4
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Dec 2021 09:08:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231596AbhLZII1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 26 Dec 2021 03:08:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231472AbhLZII0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Dec 2021 03:08:26 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F28CC06173E;
        Sun, 26 Dec 2021 00:08:26 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id CC26F60DB6;
        Sun, 26 Dec 2021 08:08:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9A821C36AE9;
        Sun, 26 Dec 2021 08:08:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1640506105;
        bh=YV2p9sKA+D5K8Qe1NnthUg/OzRcqtigFUjBRuoBejUw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=pz68rqPx8Fg9DV+4u7lLXVjOMNEF/zliSOHH2MfPFJLZlrEcqeP2WMHHU4oWrLHkB
         fzwFMievihfgDkYKMrRvpEpAlBAsQlGOALDOVAXOC382EZBOJzBOZB/oqvyQ+5yoCu
         ZzYqBSHWwrS7xPIl2LiezH5jQdXMGFFOlT5PNUP0=
Date:   Sun, 26 Dec 2021 09:08:12 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     andrey.konovalov@linux.dev
Cc:     Andrey Konovalov <andreyknvl@gmail.com>,
        Felipe Balbi <balbi@kernel.org>, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] usb: raw-gadget: upgrade license identifier
Message-ID: <Ycgi7GiU2udbjF2f@kroah.com>
References: <f55721ade28b2715eaf54b28a1bbfaad7b5adc0d.1640471342.git.andreyknvl@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f55721ade28b2715eaf54b28a1bbfaad7b5adc0d.1640471342.git.andreyknvl@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Dec 25, 2021 at 11:32:36PM +0100, andrey.konovalov@linux.dev wrote:
> From: Andrey Konovalov <andreyknvl@gmail.com>
> 
> Most of the USB gadget modules are licensed as GPL-2.0+. There is no
> reason not to allow using Raw Gadget code under a newer GPL version.
> 
> Change SPDX identifier from GPL-2.0 to GPL-2.0+.
> 
> Signed-off-by: Andrey Konovalov <andreyknvl@gmail.com>
> 
> ---
> 
> I don't know whether such license change is possible and what it
> requires.

It requires the copyright holder to agree to change the license, as well
as anyone who as contributed to it.  If you so desire to do this, please
work with them and get the lawyers for those entities to sign off on the
patch and I will be glad to take it.

thanks,

greg k-h
