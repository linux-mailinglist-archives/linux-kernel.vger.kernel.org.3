Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9E6C648315D
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jan 2022 14:28:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232994AbiACN2q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Jan 2022 08:28:46 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:50710 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230230AbiACN2p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jan 2022 08:28:45 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id BC1FEB80EC8
        for <linux-kernel@vger.kernel.org>; Mon,  3 Jan 2022 13:28:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1A458C36AEB;
        Mon,  3 Jan 2022 13:28:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1641216523;
        bh=wwnv/IukshN2lvxyx33nMlELVbHp8RH5n+SQ/wKsvis=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=rwsSTV/cEOhq975eTrSwbzpMSL+zLBhQzd+3bPjWG8soNBSO29dg/OjvYHWXjzO2y
         qyG2Ja0S5bbb7pN3Wt990i0NLdN5XBddO2BEvB9gHJs0z4AvL7IgQy0V68PTDaeJrj
         J8icXNusu0Ocd11aghNJLl5jFd1anRQ31BbQHbnA=
Date:   Mon, 3 Jan 2022 14:28:40 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Abdun Nihaal <abdun.nihaal@gmail.com>
Cc:     Larry.Finger@lwfinger.net, phil@philpotter.co.uk,
        straube.linux@gmail.com, martin@kaiser.cx,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: r8188eu: remove unneeded ret variables
Message-ID: <YdL6CE3+CaU6xVvD@kroah.com>
References: <20211231172527.184788-1-abdun.nihaal@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211231172527.184788-1-abdun.nihaal@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 31, 2021 at 10:55:27PM +0530, Abdun Nihaal wrote:
> Remove unneeded return variables in ioctl_linux.c that are initialized
> to 0 and are not assigned after. Instead, return 0 directly.

Almost all of these should not be returning a value at all, if they can
not fail and no one checks the values, right?

Please fix this up to be functions that return void, as that's the
correct thing to do here.

thanks,

greg k-h
