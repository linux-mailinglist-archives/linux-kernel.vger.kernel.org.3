Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C2A7F486C0B
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jan 2022 22:42:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244366AbiAFVmJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Jan 2022 16:42:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244330AbiAFVmC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jan 2022 16:42:02 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71981C061245;
        Thu,  6 Jan 2022 13:42:01 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id BE289B82436;
        Thu,  6 Jan 2022 21:41:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 537ADC36AE3;
        Thu,  6 Jan 2022 21:41:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1641505318;
        bh=cidqH6XbnKiV6LK8kzCyBqLMG5qV1IbZVq3gWyCa/Gc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=RDk+a37Bpl5DLv9vRcXj7UYKcFCou6wAizwQocEPougcoNeFnwCoJocwodXlBW1MD
         LfctZXNpiRWaL9K53KihcXAUxJZqUOEVSCLZrgOy50DMUBx1lqkYtPo5RUxqjIHQ90
         DwNZAxSUlqPJIZcjUzQZpC2A9aMKIIHrhmbdwYcmIdkhjFmi7nOoTKvEd9s47B/E/8
         yqkwQrlS3FUTakczE/Umzh/Us+Xr0sV9ESc8kGMSLxz9dX2qPR91JgKRnoXfN7HlRd
         87hzo8+DYMuIE5Mv4fOaRZILjJ+ZZneZGe6G251pLY0ca+VT1HpD8mzw/IRCpKuMdL
         r8/xgsCMSObdQ==
Date:   Thu, 6 Jan 2022 13:41:56 -0800
From:   Eric Biggers <ebiggers@kernel.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, linux-doc@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 0/8] docs: consolidate sysfs-block into
 Documentation/ABI/
Message-ID: <YddiJFr+ba7Veh82@sol.localdomain>
References: <20211209003833.6396-1-ebiggers@kernel.org>
 <YcH1uxfdTRHIwl7Y@quark>
 <YdMQ6rfSZWSOLptA@quark>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YdMQ6rfSZWSOLptA@quark>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 03, 2022 at 09:06:18AM -0600, Eric Biggers wrote:
> On Tue, Dec 21, 2021 at 09:41:47AM -0600, Eric Biggers wrote:
> > On Wed, Dec 08, 2021 at 04:38:25PM -0800, Eric Biggers wrote:
> > > This series consolidates the documentation for /sys/block/<disk>/queue/
> > > into Documentation/ABI/, where it is supposed to go (as per Greg KH:
> > > https://lore.kernel.org/r/YaXXpEAwVGTLjp1e@kroah.com).
> > > 
> > > This series also updates MAINTAINERS to associate the block
> > > documentation with the block layer.
> > > 
> > > This series applies to linux-block/for-next.
> > > 
> > > Changed v2 => v3:
> > >    - Improved documentation for stable_writes and virt_boundary_mask.
> > >    - Added more Reviewed-by tags.
> > > 
> > > Changed v1 => v2:
> > >    - Added patch which moves the documentation to the stable directory.
> > >    - Added Reviewed-by tags.
> > 
> > Jens, any interest in applying this series?
> > 
> > - Eric
> 
> Ping.

Jens, any reason you haven't applied this series yet?  It looks like you've been
applying other patches.  To be clear, I've been expecting that this would go in
through the block tree, rather than the docs tree.

- Eric
