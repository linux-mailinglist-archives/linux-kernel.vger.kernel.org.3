Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ABE94483121
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jan 2022 13:46:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231924AbiACMql (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Jan 2022 07:46:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229514AbiACMqk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jan 2022 07:46:40 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F96EC061761
        for <linux-kernel@vger.kernel.org>; Mon,  3 Jan 2022 04:46:40 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id EFA1CB80EA9
        for <linux-kernel@vger.kernel.org>; Mon,  3 Jan 2022 12:46:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CB2A6C36AED;
        Mon,  3 Jan 2022 12:46:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1641213997;
        bh=CGvn79ZkDcvPxOZWiXROS4Ze1GHzxqDuSnGemc1SEHY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=hY1nIUyZy3jwZNhX/TDC+i3Xxa3PAqPV4hoeSR4LegJ8s+j0sie0iFmOqah/7FnuJ
         VNOnAO60sgK6upXzJzRV9CfDsnCJ5xQS4uUNaPbzVPxCs74lXcZde7xqGKKVjH4lbX
         oFFfNsCfMhzwkcni+VdyaqHIn9jzu7koEgrzF8o4=
Date:   Mon, 3 Jan 2022 13:46:34 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Peter Rosin <peda@axentia.se>
Cc:     Aswath Govindraju <a-govindraju@ti.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: mux for 5.17-rc1
Message-ID: <YdLwKqM7PjaF28uA@kroah.com>
References: <94ab71e1-2e68-def2-95b8-33162172f65c@axentia.se>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <94ab71e1-2e68-def2-95b8-33162172f65c@axentia.se>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jan 02, 2022 at 11:34:12PM +0100, Peter Rosin wrote:
> Hi Greg,
> 
> These have been in -next since around x-mas, and hopefully it's not too
> late to push them for the upcoming window.
> 
> Patch 5/6 fails check-patch due to lacking a message body, because I
> forgot to actually check that and now I can't find it in me to re-spin
> for that seemingly insignificant issue. If it really is a no-no, then
> please just drop that patch.

It's a no-go, please take a break and find it in you for the next time
you resend this series :)

I'll take patches 1 and 2, the rest need work.

thanks,

greg k-h
