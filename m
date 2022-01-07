Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7C84D487A55
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jan 2022 17:28:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348261AbiAGQ2l (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Jan 2022 11:28:41 -0500
Received: from dfw.source.kernel.org ([139.178.84.217]:50484 "EHLO
        dfw.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239960AbiAGQ2j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jan 2022 11:28:39 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7402F611F9;
        Fri,  7 Jan 2022 16:28:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4D96DC36AE0;
        Fri,  7 Jan 2022 16:28:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1641572918;
        bh=O7GVv9TCvTOEnZXB0zu68wx7KxRZ3e86I7G552kyMiE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=mGD0zNm46gvEqdY8RPEaVergHfJWrHy52ju6wMFl/W45ewHvn5P4Q3XVQufRMar1d
         d8U76avrN7Uh/I71Ihy4tZ9D1yi2/7TCOTKVX5gAdRdHdRjkp6NjSmZEWjybrzYZEe
         A/ysI0HpVRdTWw/iBJT394HBzB2kj0zZwgJdub64=
Date:   Fri, 7 Jan 2022 17:28:36 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Thorsten Leemhuis <linux@leemhuis.info>
Cc:     linux-doc@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        workflows@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Randy Dunlap <rdunlap@infradead.org>,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>
Subject: Re: [RFC PATCH v2 0/2] docs: add a text about regressions to the
 Linux kernel's documentation
Message-ID: <YdhqNHI/f2B/SlcE@kroah.com>
References: <cover.1641565030.git.linux@leemhuis.info>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1641565030.git.linux@leemhuis.info>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 07, 2022 at 03:21:00PM +0100, Thorsten Leemhuis wrote:
> 'We don't cause regressions' might be the first rule of Linux kernel
> development, but it and other aspects of regressions nevertheless are hardly
> described in the Linux kernel's documentation. The following two patches change
> this by creating a document dedicated to the topic.
> 
> The second patch could easily be folded into the first one, but was kept
> separate, as it might be a bit controversial. This also allows the patch
> description to explain some backgrounds for this part of the document.
> Additionally, ACKs and Reviewed-by tags can be collected separately this way.
> 
> v2/RFC:
> - a lot of small fixes, most are for spelling mistakes and grammar
>   errors/problems pointed out in the review feedback I got so far
> - add ACK for the series from Greg

My ack seems not to be here :(

Also, this is a "real" series, no need for a RFC anymore, right?

thanks,

greg k-h
