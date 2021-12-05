Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A535A468A6F
	for <lists+linux-kernel@lfdr.de>; Sun,  5 Dec 2021 12:03:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233077AbhLELHN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 5 Dec 2021 06:07:13 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:56334 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233070AbhLELHL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Dec 2021 06:07:11 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id EF77DB80DCF
        for <linux-kernel@vger.kernel.org>; Sun,  5 Dec 2021 11:03:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2EA03C341C9;
        Sun,  5 Dec 2021 11:03:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1638702222;
        bh=oRGP/ta5t+1nOoDu2mLF02x3hunvstyw3cZxRZv2vyI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=1HwuYftcHlP4kqPb0LJmRDiKhWSoKfLS3/k5k5JszqoTXKN5gcNY+mnb4YeOqZAze
         zOd6PThpULSXGDgMGqXLIWVurJHDwQFN2lPYzGn6JOKD3xWgvUI1NpvAARxg3CQJoC
         MGSjB8kEZdFKBUc/sm20vZkk1KK8yxcI+t0bPn2Q=
Date:   Sun, 5 Dec 2021 12:03:40 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Alberto Merciai <alb3rt0.m3rciai@gmail.com>
Cc:     Forest Bond <forest@alittletooquiet.net>,
        Tommaso Merciai <tomm.merciai@gmail.com>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Karolina Drobnik <karolinadrobnik@gmail.com>,
        Aldas =?utf-8?B?VGFyYcWha2V2acSNaXVz?= <aldas60@gmail.com>,
        Lucas Henneman <lucas.henneman@linaro.org>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] staging: vt6655: remove unused variable byMinChannel
Message-ID: <YaycjDWo2QJBTz1t@kroah.com>
References: <20211204113407.3941035-1-alb3rt0.m3rciai@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211204113407.3941035-1-alb3rt0.m3rciai@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Dec 04, 2021 at 12:34:04PM +0100, Alberto Merciai wrote:
> Remove set but not used variable byMinChannel.
> 
> Signed-off-by: Alberto Merciai <alb3rt0.m3rciai@gmail.com>
> ---
> 
> v1 -> v2
> - Add Signed-off-by

I have a number of patches from you for this driver, all in different
orders and some being obsoleted by others, making this impossible for me
to easily determine what is, and what is not, viable for applying and in
what order.

Can you please resend all of your pending patches, in a patch series,
properly numbered, so that I have a chance of understanding this?

I have now dropped all of your pending patches from my review queue.

thanks,

greg k-h
