Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C2802464A2E
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Dec 2021 09:51:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242111AbhLAIzM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Dec 2021 03:55:12 -0500
Received: from sin.source.kernel.org ([145.40.73.55]:51588 "EHLO
        sin.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236947AbhLAIzK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Dec 2021 03:55:10 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id D3E23CE1D69;
        Wed,  1 Dec 2021 08:51:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 72A6FC53FAD;
        Wed,  1 Dec 2021 08:51:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1638348707;
        bh=HRgtxenx6M7iGjCis32pKgZWfxM0VWhEZ1gCZGNh7WI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=EHtc68yIQgY3U1+aDQBmrMgJfNoqptwFsHA/5AFntg9tue2QotJpkbfsRMXXJbgpB
         Ugg3Fq0HcqwYIcPA9rxQ6ctmL6SeKFWdf5sXWXZRRuNy/tIJQB1RujvEewX+5YHMlE
         D0L3F1SpwBLuIZPiOb9QeFuwtZPZwKas/D8iYIW4=
Date:   Wed, 1 Dec 2021 09:51:44 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Eric Biggers <ebiggers@kernel.org>
Cc:     linux-block@vger.kernel.org, Jens Axboe <axboe@kernel.dk>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/7] docs: consolidate sysfs-block into Documentation/ABI/
Message-ID: <Yac3oNe0bJLn6IfO@kroah.com>
References: <20211201084524.25660-1-ebiggers@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211201084524.25660-1-ebiggers@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 01, 2021 at 12:45:17AM -0800, Eric Biggers wrote:
> This series consolidates the documentation for /sys/block/<disk>/queue/
> into Documentation/ABI/, where it is supposed to go (as per Greg KH:
> https://lore.kernel.org/r/YaXXpEAwVGTLjp1e@kroah.com).
> 
> This series also updates MAINTAINERS to associate the block
> documentation with the block layer.
> 
> This series applies to linux-block/for-next.
> 
> Eric Biggers (7):
>   docs: sysfs-block: sort alphabetically
>   docs: sysfs-block: add contact for nomerges
>   docs: sysfs-block: fill in missing documentation from queue-sysfs.rst
>   docs: sysfs-block: document stable_writes
>   docs: sysfs-block: document virt_boundary_mask
>   docs: block: remove queue-sysfs.rst
>   MAINTAINERS: add entries for block layer documentation

Wonderful, thanks for doing this!

Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
