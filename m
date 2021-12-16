Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B73C7477156
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Dec 2021 13:07:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234933AbhLPMHI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Dec 2021 07:07:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231468AbhLPMHI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Dec 2021 07:07:08 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D11B6C061574;
        Thu, 16 Dec 2021 04:07:07 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 70FC261D72;
        Thu, 16 Dec 2021 12:07:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5432DC36AE4;
        Thu, 16 Dec 2021 12:07:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1639656426;
        bh=Lpngu9hFJGunkQpcmdN1SxSLmcV8j4YsPPU4i9XXEWM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=EjWdqhQZhclnPTkWgSmGu5Mkcbemwe10wI1QbiUIB42e6he47+GcB0/BEMw4Y3bEE
         vdzTKEdl3P2rApVIH0mwFx/y2GCbJ9A8+Q0RjgDdBxitzP0gwy1ETvmRSTIBhMSXYV
         9rVruAPbvNBmC+4USrqqCY0agN38SwXRDjelq3I4=
Date:   Thu, 16 Dec 2021 13:07:04 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Lukas Bulwahn <lukas.bulwahn@gmail.com>
Cc:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        Cai Huoqing <caihuoqing@baidu.com>,
        linux-media@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        linux-spdx@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] media: prefer generic SPDX-License expression to
 deprecated one
Message-ID: <Ybsr6H4/lbzCZBle@kroah.com>
References: <20211216103132.8087-1-lukas.bulwahn@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211216103132.8087-1-lukas.bulwahn@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 16, 2021 at 11:31:32AM +0100, Lukas Bulwahn wrote:
> Commit 8d395ce6f04b ("media: dvb-core: Convert to SPDX identifier") and
> commit e67219b0496b ("media: b2c2: flexcop: Convert to SPDX identifier")
> introduce the SPDX-License expression LGPL-2.1-or-later for some files.
> 
> The command ./scripts/spdxcheck.py warns:
> 
>   drivers/media/dvb-core/dmxdev.c: 1:28 Invalid License ID: LGPL-2.1-or-later
>   drivers/media/dvb-core/dvb_demux.c: 1:28 Invalid License ID: LGPL-2.1-or-later
>   drivers/media/dvb-core/dvbdev.c: 1:28 Invalid License ID: LGPL-2.1-or-later
>   drivers/media/common/b2c2/flexcop.c: 1:28 Invalid License ID: LGPL-2.1-or-later
> 
> The preferred SPDX expression for LGPL-2.1 or any later version is with
> the more generic "+"-extension for "any later version", so: LGPL-2.1+
> 
> This makes spdxcheck happy again.
> 
> Fixes: 8d395ce6f04b ("media: dvb-core: Convert to SPDX identifier")
> Fixes: e67219b0496b ("media: b2c2: flexcop: Convert to SPDX identifier")
> Signed-off-by: Lukas Bulwahn <lukas.bulwahn@gmail.com>
> ---
>  drivers/media/common/b2c2/flexcop.c | 2 +-
>  drivers/media/dvb-core/dmxdev.c     | 2 +-
>  drivers/media/dvb-core/dvb_demux.c  | 2 +-
>  drivers/media/dvb-core/dvbdev.c     | 2 +-
>  4 files changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/media/common/b2c2/flexcop.c b/drivers/media/common/b2c2/flexcop.c
> index e7a88a2d248c..38c300da3fc2 100644
> --- a/drivers/media/common/b2c2/flexcop.c
> +++ b/drivers/media/common/b2c2/flexcop.c
> @@ -1,4 +1,4 @@
> -// SPDX-License-Identifier: LGPL-2.1-or-later
> +// SPDX-License-Identifier: LGPL-2.1+
>  /*
>   * Linux driver for digital TV devices equipped with B2C2 FlexcopII(b)/III
>   * flexcop.c - main module part
> diff --git a/drivers/media/dvb-core/dmxdev.c b/drivers/media/dvb-core/dmxdev.c
> index f6ee678107d3..2b4fb2ec1efd 100644
> --- a/drivers/media/dvb-core/dmxdev.c
> +++ b/drivers/media/dvb-core/dmxdev.c
> @@ -1,4 +1,4 @@
> -// SPDX-License-Identifier: LGPL-2.1-or-later
> +// SPDX-License-Identifier: LGPL-2.1+
>  /*
>   * dmxdev.c - DVB demultiplexer device
>   *
> diff --git a/drivers/media/dvb-core/dvb_demux.c b/drivers/media/dvb-core/dvb_demux.c
> index 83cc32ad7e12..35bf76b0425c 100644
> --- a/drivers/media/dvb-core/dvb_demux.c
> +++ b/drivers/media/dvb-core/dvb_demux.c
> @@ -1,4 +1,4 @@
> -// SPDX-License-Identifier: LGPL-2.1-or-later
> +// SPDX-License-Identifier: LGPL-2.1+
>  /*
>   * dvb_demux.c - DVB kernel demux API
>   *
> diff --git a/drivers/media/dvb-core/dvbdev.c b/drivers/media/dvb-core/dvbdev.c
> index 675d877a67b2..861559e8b4c9 100644
> --- a/drivers/media/dvb-core/dvbdev.c
> +++ b/drivers/media/dvb-core/dvbdev.c
> @@ -1,4 +1,4 @@
> -// SPDX-License-Identifier: LGPL-2.1-or-later
> +// SPDX-License-Identifier: LGPL-2.1+

No, the existing tags are fine.

thanks,

greg k-h
