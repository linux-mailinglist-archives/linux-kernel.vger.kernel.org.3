Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0A7E34833E5
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jan 2022 16:06:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233739AbiACPG0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Jan 2022 10:06:26 -0500
Received: from sin.source.kernel.org ([145.40.73.55]:56990 "EHLO
        sin.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231166AbiACPGZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jan 2022 10:06:25 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 851D6CE1106;
        Mon,  3 Jan 2022 15:06:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4926FC36AED;
        Mon,  3 Jan 2022 15:06:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1641222381;
        bh=N11Fuq6Xju1Dn7isiVwslSPqUV/iaaLmrQuO9d6hYsU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=QyrA+hHEdpnbO4JaJdwYOfpYeA+cKOK7kczxXZQ5cT1sNF2uIoWpgjKH6MYsxxBgU
         lIkWw+t1td2qa7lU1+Tg+etopa9Lo/zIsDvoJ4f4hocKyRRHCsmlkqFVFCIqSpQ04S
         gvYbK3rWWJmUPN5XOE0cGxal8EtrXj6hBKG7ilKV4cD8yLxWMGkC9lL+7gemo0GCHT
         9XONVjgDS0Thygf4dqfVKzlVt39AUGJLb0F/YQ7+volMTLX3R3CetCF1CZ6SA7cBwx
         257HwSYHl1nvqcG1Jvr/f+aMMCWnmoMAAcU1UR83r/Ze/bxtXcsdz5TsQGrDcpTlbm
         M4sFta14LM06A==
Date:   Mon, 3 Jan 2022 09:06:18 -0600
From:   Eric Biggers <ebiggers@kernel.org>
To:     linux-block@vger.kernel.org, Jens Axboe <axboe@kernel.dk>
Cc:     linux-doc@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 0/8] docs: consolidate sysfs-block into
 Documentation/ABI/
Message-ID: <YdMQ6rfSZWSOLptA@quark>
References: <20211209003833.6396-1-ebiggers@kernel.org>
 <YcH1uxfdTRHIwl7Y@quark>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YcH1uxfdTRHIwl7Y@quark>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 21, 2021 at 09:41:47AM -0600, Eric Biggers wrote:
> On Wed, Dec 08, 2021 at 04:38:25PM -0800, Eric Biggers wrote:
> > This series consolidates the documentation for /sys/block/<disk>/queue/
> > into Documentation/ABI/, where it is supposed to go (as per Greg KH:
> > https://lore.kernel.org/r/YaXXpEAwVGTLjp1e@kroah.com).
> > 
> > This series also updates MAINTAINERS to associate the block
> > documentation with the block layer.
> > 
> > This series applies to linux-block/for-next.
> > 
> > Changed v2 => v3:
> >    - Improved documentation for stable_writes and virt_boundary_mask.
> >    - Added more Reviewed-by tags.
> > 
> > Changed v1 => v2:
> >    - Added patch which moves the documentation to the stable directory.
> >    - Added Reviewed-by tags.
> 
> Jens, any interest in applying this series?
> 
> - Eric

Ping.
