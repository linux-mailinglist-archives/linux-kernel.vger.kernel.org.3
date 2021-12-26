Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 28BFE47F83C
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Dec 2021 17:34:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231927AbhLZQd6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 26 Dec 2021 11:33:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231185AbhLZQd5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Dec 2021 11:33:57 -0500
Received: from mail-qt1-x835.google.com (mail-qt1-x835.google.com [IPv6:2607:f8b0:4864:20::835])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1D37C061401
        for <linux-kernel@vger.kernel.org>; Sun, 26 Dec 2021 08:33:56 -0800 (PST)
Received: by mail-qt1-x835.google.com with SMTP id l17so11702229qtk.7
        for <linux-kernel@vger.kernel.org>; Sun, 26 Dec 2021 08:33:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=vanguardiasur-com-ar.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=zZoHskxxN8uGpMitWoUyROPhaBv9eU7NFpts0SGB6Y4=;
        b=YjiWxTyTeVTzSWi9xioHbeV4aonLvky5fZsBeFJ7XqtO8AxT7G6aHoDy3lEFWWvclD
         YVbdkTJTepFtIOWLwQmnMt+EwE3L6UaruTdHohDIiqhxDi0PJ2sxY6MF+0rQLClPU9Lp
         cGdKXP47OBxstkiHz6rgp1Mv9nEcKebhLtXOPww8yQKbh10GPSwY2wv2sDWmDEnDHG7S
         sKrMoJRnH5kkCFkzJGYAUb4i54Y9C/ruxL5uu8G2YKtQRHPuCen1XCoby4mNKETVN+Fl
         Uum3ZW1kiIaGw9rPgX97Td5sd0lMEhIY5mgYMCyqls3ZpvoS+txBVNddcJfRy/ukDxze
         ax4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=zZoHskxxN8uGpMitWoUyROPhaBv9eU7NFpts0SGB6Y4=;
        b=yXAlsz42bhlakinB0P/3872HHfdCcvZ6prqy+MJUbfmjHRDyTuy4TJbL2P2iilmeVO
         yOBYSW6Kyiiwc1iHB4Vxo6JUdz+pWQRiZPOaGe0EC2ctBSaB24GDfrsevJZE3qzw0Z5C
         GikMrJqroYyvdRuYKkavm57somjASFr/+DjWKQz7d/ZftQ1Hv1PwZuXtMN3sQpOl+4V1
         nik+f5RV6tEMOzmexSJEJYRmGjTgk/94ITI/8njZLlAcE2wElHJCkMjbHUu1QOgGzSVP
         QkWrvluqvuRjT2PpQzUkHZcvzN+TRyfPYdsCNxIRDH3T+MBy/wLYl8Ef4fsLMT4r1DzV
         swpg==
X-Gm-Message-State: AOAM533wGnILOXE0mOJnXvF/FsGnb4GOu0RsFuWvlxwL4Gk/emyLIETy
        bV9kiOKi1nuHahYdqVg/lXsPtA==
X-Google-Smtp-Source: ABdhPJwVVrktToZ/gNMXR1o9FvXwu8OdTH/Hk6BcQOE58abV4vSun5eteZNn+gSjKbtT0zBdzdiE6g==
X-Received: by 2002:ac8:5f4e:: with SMTP id y14mr12219600qta.620.1640536435884;
        Sun, 26 Dec 2021 08:33:55 -0800 (PST)
Received: from eze-laptop ([186.122.18.30])
        by smtp.gmail.com with ESMTPSA id f12sm11132002qtj.93.2021.12.26.08.33.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 26 Dec 2021 08:33:52 -0800 (PST)
Date:   Sun, 26 Dec 2021 13:33:43 -0300
From:   Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>
To:     Chen-Yu Tsai <wenst@chromium.org>
Cc:     Philipp Zabel <p.zabel@pengutronix.de>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Tomasz Figa <tfiga@chromium.org>, linux-media@vger.kernel.org,
        linux-rockchip@lists.infradead.org, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH RFT 5/7] media: hantro: jpeg: Add COM segment to JPEG
 header to align image scan
Message-ID: <YciZZ2hA4uMveN2l@eze-laptop>
References: <20211224084248.3070568-1-wenst@chromium.org>
 <20211224084248.3070568-6-wenst@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211224084248.3070568-6-wenst@chromium.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Fri, Dec 24, 2021 at 04:42:46PM +0800, Chen-Yu Tsai wrote:
> The JPEG header size is not 64-bit aligned. This makes the driver
> require a bounce buffer for the encoded JPEG image scan output.
> 
> Add a COM (comment) segment to the JPEG header so that the header size
> is a multiple of 64 bits. This will then allow dropping the use of the
> bounce buffer, and instead have the hardware write out to the capture
> buffer directly.
> 
> Signed-off-by: Chen-Yu Tsai <wenst@chromium.org>
> ---
>  drivers/staging/media/hantro/hantro_jpeg.c | 3 +++
>  drivers/staging/media/hantro/hantro_jpeg.h | 2 +-
>  2 files changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/staging/media/hantro/hantro_jpeg.c b/drivers/staging/media/hantro/hantro_jpeg.c
> index 7d4018bd6876..51e67e5cf86f 100644
> --- a/drivers/staging/media/hantro/hantro_jpeg.c
> +++ b/drivers/staging/media/hantro/hantro_jpeg.c
> @@ -247,6 +247,9 @@ static const unsigned char hantro_jpeg_header[JPEG_HEADER_SIZE] = {
>  	0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
>  	0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
>  
> +	/* COM */
> +	0xff, 0xfe, 0x00, 0x03, 0x00,
> +
>  	/* SOS */
>  	0xff, 0xda, 0x00, 0x0c, 0x03, 0x01, 0x00, 0x02,
>  	0x11, 0x03, 0x11, 0x00, 0x3f, 0x00,
> diff --git a/drivers/staging/media/hantro/hantro_jpeg.h b/drivers/staging/media/hantro/hantro_jpeg.h
> index f33c492134e4..0b49d0b82caa 100644
> --- a/drivers/staging/media/hantro/hantro_jpeg.h
> +++ b/drivers/staging/media/hantro/hantro_jpeg.h
> @@ -1,6 +1,6 @@
>  /* SPDX-License-Identifier: GPL-2.0+ */
>  
> -#define JPEG_HEADER_SIZE	619
> +#define JPEG_HEADER_SIZE	624

Can we add some compile-time check for the 8-byte alignment,
so this is always enforced?

Perhaps getting rid of the JPEG_HEADER_SIZE macro,
something like this....


@@ -140,7 +140,7 @@ static const unsigned char chroma_ac_table[] = {
  * and we'll use fixed offsets to change the width, height
  * quantization tables, etc.
  */
-static const unsigned char hantro_jpeg_header[JPEG_HEADER_SIZE] = {
+static const unsigned char hantro_jpeg_header[] = {
        /* SOI */
        0xff, 0xd8,

@@ -304,8 +304,13 @@ void hantro_jpeg_header_assemble(struct hantro_jpeg_ctx *ctx)
 {
        char *buf = ctx->buffer;

-       memcpy(buf, hantro_jpeg_header,
-              sizeof(hantro_jpeg_header));
+       /*
+        * THE JPEG buffer is prepended with the JPEG header,
+        * so 64-bit alignment is needed for DMA.
+        */
+       BUILD_BUG_ON(!IS_ALIGNED(sizeof(hantro_jpeg_header), 8));
+
+       memcpy(buf, hantro_jpeg_header, sizeof(hantro_jpeg_header));

Thanks,
Ezequiel
