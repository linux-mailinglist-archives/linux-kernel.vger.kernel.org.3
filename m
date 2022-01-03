Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5B8E6483111
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jan 2022 13:37:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231851AbiACMh3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Jan 2022 07:37:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229596AbiACMh2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jan 2022 07:37:28 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C4C8C061761
        for <linux-kernel@vger.kernel.org>; Mon,  3 Jan 2022 04:37:28 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C26CD6101A
        for <linux-kernel@vger.kernel.org>; Mon,  3 Jan 2022 12:37:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 98A61C36AED;
        Mon,  3 Jan 2022 12:37:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1641213447;
        bh=LBLiu4N+doRci3guL1TOsL4GKEag2oFH1fZP2LDSNZ8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Ww3ShMRZom04wjM5MsU3X9kpJXeO0HKlgZsOtR5WRYAu9MHn1dbnZX4HDS04fHUs1
         WHHGSb2/Kh62cZlPJQTS87P7sK1xJg7XRwQ84BDbXBmIMw8KALF68hD5C0NjwZW5+I
         B/dMQOSVkSsynmsSCQP1NDoWxK0C+QXjuWT9GOLY=
Date:   Mon, 3 Jan 2022 13:37:24 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Peter Rosin <peda@axentia.se>
Cc:     Aswath Govindraju <a-govindraju@ti.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 5/6] mux: fix grammar, missing "is".
Message-ID: <YdLuBM77Ygg05qzm@kroah.com>
References: <94ab71e1-2e68-def2-95b8-33162172f65c@axentia.se>
 <9f501a7c-47b4-783a-5519-75440fe488b0@axentia.se>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9f501a7c-47b4-783a-5519-75440fe488b0@axentia.se>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jan 02, 2022 at 11:38:45PM +0100, Peter Rosin wrote:
> 
> Signed-off-by: Peter Rosin <peda@axentia.se>
> ---
>  drivers/mux/core.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

I really do not like to take changes with no changelog text at all :(

thanks,

greg k-h
