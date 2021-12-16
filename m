Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ADC76476F21
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Dec 2021 11:49:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236234AbhLPKtR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Dec 2021 05:49:17 -0500
Received: from mx24.baidu.com ([111.206.215.185]:48176 "EHLO baidu.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S236195AbhLPKtP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Dec 2021 05:49:15 -0500
Received: from BC-Mail-HQEX01.internal.baidu.com (unknown [172.31.51.57])
        by Forcepoint Email with ESMTPS id BC2246EA63F6B8BE0EB7;
        Thu, 16 Dec 2021 18:49:07 +0800 (CST)
Received: from BJHW-MAIL-EX27.internal.baidu.com (10.127.64.42) by
 BC-Mail-HQEX01.internal.baidu.com (172.31.51.57) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2308.20; Thu, 16 Dec 2021 18:49:06 +0800
Received: from localhost (172.31.63.8) by BJHW-MAIL-EX27.internal.baidu.com
 (10.127.64.42) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.20; Thu, 16
 Dec 2021 18:49:00 +0800
Date:   Thu, 16 Dec 2021 18:48:59 +0800
From:   Cai Huoqing <caihuoqing@baidu.com>
To:     Lukas Bulwahn <lukas.bulwahn@gmail.com>
CC:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        <linux-media@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        <linux-spdx@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] media: prefer generic SPDX-License expression to
 deprecated one
Message-ID: <20211216104859.GA238@LAPTOP-UKSR4ENP.internal.baidu.com>
References: <20211216103132.8087-1-lukas.bulwahn@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20211216103132.8087-1-lukas.bulwahn@gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Originating-IP: [172.31.63.8]
X-ClientProxiedBy: BC-Mail-Ex22.internal.baidu.com (172.31.51.16) To
 BJHW-MAIL-EX27.internal.baidu.com (10.127.64.42)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 16 12月 21 11:31:32, Lukas Bulwahn wrote:
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
Looks good to me.

Reviewed-by: Cai Huoqing <caihuoqing@baidu.com>
>  /*
>   * dvbdev.c
>   *
> -- 
> 2.17.1
> 
