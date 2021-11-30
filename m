Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E8D2D462ECF
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Nov 2021 09:47:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239753AbhK3IuT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Nov 2021 03:50:19 -0500
Received: from sin.source.kernel.org ([145.40.73.55]:55530 "EHLO
        sin.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234760AbhK3IuP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Nov 2021 03:50:15 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 3A616CE1804;
        Tue, 30 Nov 2021 08:46:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DF6EFC53FC7;
        Tue, 30 Nov 2021 08:46:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1638262013;
        bh=PE5PYrSpq4Ji8bD5ar5PBlir0GMFnFQe28x0DJzeWS0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=aSDVDHlYO40vIO6S+BlpF3DdFcwIFKelt7DE4IA8wcCvTrQPlkQ4uugPBqtxp7Mux
         bZReRfPot5NGgkDM3LL9l2dwik11mBIIJJGWHHjj/rA4s1huwTjXyKnH8lQ/HbWBnC
         juJ820YCVRtFY8FfYRoD3bjdA5s3yv5X5F79M3NE=
Date:   Tue, 30 Nov 2021 08:49:56 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Eric Biggers <ebiggers@kernel.org>
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-api@vger.kernel.org, linux-scsi@vger.kernel.org,
        linux-mmc@vger.kernel.org, Bart Van Assche <bvanassche@acm.org>
Subject: Re: [PATCH v2 3/3] blk-crypto: show crypto capabilities in sysfs
Message-ID: <YaXXpEAwVGTLjp1e@kroah.com>
References: <20211130040306.148925-1-ebiggers@kernel.org>
 <20211130040306.148925-4-ebiggers@kernel.org>
 <YaXPIYHg8Xnk1Lbh@kroah.com>
 <YaXTRJO9Wbsh8n05@sol.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YaXTRJO9Wbsh8n05@sol.localdomain>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 29, 2021 at 11:31:16PM -0800, Eric Biggers wrote:
> On Tue, Nov 30, 2021 at 08:13:37AM +0100, Greg Kroah-Hartman wrote:
> > >  Documentation/block/queue-sysfs.rst |  30 +++++
> > 
> > Same objection as before.  Please add these to Documentation/ABI/
> 
> As I said before, this is where all the blk-sysfs stuff is documented currently.
> If you consider this a hard requirement, then I'll get started on a patch that
> moves all of queue-sysfs.rst into Documentation/ABI/, as it's silly to change it
> for just this one and not the 23 other blk-sysfs attributes with exactly the
> same issue.

If I don't complain about it, nothing will ever change :)

> > otherwise when running 'scripts/get_abi undefined' will show these new
> > sysfs files you are adding as having no documentation :(
> 
> Perhaps this should be part of checkpatch?

It's hard as that requires the code that the patch is checking to be
running on the system you run checkpatch on.

thanks,

greg k-h
