Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C65E047C334
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Dec 2021 16:41:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236231AbhLUPlz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Dec 2021 10:41:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234903AbhLUPlx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Dec 2021 10:41:53 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD68DC061574;
        Tue, 21 Dec 2021 07:41:53 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 675C66165B;
        Tue, 21 Dec 2021 15:41:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 774B7C36AE9;
        Tue, 21 Dec 2021 15:41:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1640101311;
        bh=2yY7BcdUJNA534m7FVOTXVI6m2bGZl/R7BXTgcDlCkk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=VS1LzvCAS641eFn9AmbzbuYM8ST03U8Z5bPYDcFGrrhzWrZehYLMEw4n0Mv8PVgsv
         6NYEnY4gIhSqKi1lH6/aQ+AurOVt4UTg0Qg0T2R6PkaB6MmgBgl0CeaVYteWwsGPrl
         oxiNY+tfAfqY1uh3I3xGpmKcJt9pJd0nnQRuirGDd0nu+Cme30muYRQIfmc9vSROBS
         EvgdlGUkcIsG6x0eCOrzxEMxHfeEJYIRYlrti9DSFxx5ma8ZQTn2VQj5CEbtwji6xB
         ZfudwEGxc2I3HFfWGX7kPrdIKMi94/aukgQrPBwiJPUZHiBnvmYXGc43qqzW/nBnmq
         9RNp9EsuoJgcQ==
Date:   Tue, 21 Dec 2021 09:41:47 -0600
From:   Eric Biggers <ebiggers@kernel.org>
To:     linux-block@vger.kernel.org, Jens Axboe <axboe@kernel.dk>
Cc:     linux-doc@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 0/8] docs: consolidate sysfs-block into
 Documentation/ABI/
Message-ID: <YcH1uxfdTRHIwl7Y@quark>
References: <20211209003833.6396-1-ebiggers@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211209003833.6396-1-ebiggers@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 08, 2021 at 04:38:25PM -0800, Eric Biggers wrote:
> This series consolidates the documentation for /sys/block/<disk>/queue/
> into Documentation/ABI/, where it is supposed to go (as per Greg KH:
> https://lore.kernel.org/r/YaXXpEAwVGTLjp1e@kroah.com).
> 
> This series also updates MAINTAINERS to associate the block
> documentation with the block layer.
> 
> This series applies to linux-block/for-next.
> 
> Changed v2 => v3:
>    - Improved documentation for stable_writes and virt_boundary_mask.
>    - Added more Reviewed-by tags.
> 
> Changed v1 => v2:
>    - Added patch which moves the documentation to the stable directory.
>    - Added Reviewed-by tags.

Jens, any interest in applying this series?

- Eric
