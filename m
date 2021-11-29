Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E335E46130C
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Nov 2021 12:03:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354060AbhK2LHB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Nov 2021 06:07:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235838AbhK2LE7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Nov 2021 06:04:59 -0500
Received: from mail-yb1-xb31.google.com (mail-yb1-xb31.google.com [IPv6:2607:f8b0:4864:20::b31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 971FDC0613FA;
        Mon, 29 Nov 2021 02:19:30 -0800 (PST)
Received: by mail-yb1-xb31.google.com with SMTP id j2so40633428ybg.9;
        Mon, 29 Nov 2021 02:19:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ppG/ZLMPwOtn6jb5uz3xg0bkyKQKbtFMdorf6y+f5O8=;
        b=fH0Z+H11NlvR2Vo3lKedItgHqleYX6iHBY+IGVtYaZjg+fDnsbzHXbPU+hxwM5OZzD
         /wRycMore58LZFi2gM/Hvc3sgfqq1hU9GP7q2sNcSRNIqIneoCJcaTcAs2INj8VXI/5l
         9M1fdnpMcVoWPRukw7kMFMIMOwcOk5cOb+lYzZBvubIjXuhmFIQpFfLlyyV7jKaXyq/X
         0J+bGNT7h7wcZ9azbn3Nov2S0Z/8RQQdGfxNz9tRnuMFCTHTdHHfRdT1TzWRJDAo9ytt
         DLTxXQu4VIXN6HIvp60bjA2OtOG5h0dwdLfc9bVIn2dsCCwnq71bsrDdJUAZEoypEWYj
         qKsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ppG/ZLMPwOtn6jb5uz3xg0bkyKQKbtFMdorf6y+f5O8=;
        b=wDhUrEsHeieZ89FzlLY/8TBBhTXtBqoKIcQvax/fvI+HfoQHt2cJYWgt3ZG3HvxVBb
         2y30lkP/c3NWKxvMSgbCIxF9T26MPoa4cJ4C3Y+xQnjJ3mvkYvdaHsvnt3m58Aec6ih8
         f+sAGf884KtJ9Aq2I721prpSY2bYFz2JMTXlcd/wVVjIKhPvSPS4s/xahZTAybuT/0W3
         Gbh3S2NKd+6OTT+Ezt4QWoI8Tv7TkVLTBk4duR9AocdthFBYtx8FyOFy3cn26pAI3b48
         iqct032+f993TxG0EzpPuYzZN6BPW9MTWUA7VdvSIUHdXr2kdFMlLkqHAosm0gmRyPCs
         2TGQ==
X-Gm-Message-State: AOAM530n+GO9R/8up/6/FmeKcd0nFr1HYhpIT3UDo2q/uQVSG/l+5gnK
        RDdFJ+ACuUvGXNtfy3ujYkeVnRT5mpDkHxF24n4=
X-Google-Smtp-Source: ABdhPJzG7Lik7bR0zFFLYlNQEHnT5wMALB0Xeav5csPj+MAzakqOJjCvBkEbkO/PqI3cA8q0BuWMFqAVoWf0kx9DPEY=
X-Received: by 2002:a25:abe3:: with SMTP id v90mr34015526ybi.315.1638181169899;
 Mon, 29 Nov 2021 02:19:29 -0800 (PST)
MIME-Version: 1.0
References: <cover.1638179135.git.mchehab+huawei@kernel.org> <0c086fea0d3f0771f6c8627e99edb719e282a49c.1638179135.git.mchehab+huawei@kernel.org>
In-Reply-To: <0c086fea0d3f0771f6c8627e99edb719e282a49c.1638179135.git.mchehab+huawei@kernel.org>
From:   "Lad, Prabhakar" <prabhakar.csengg@gmail.com>
Date:   Mon, 29 Nov 2021 10:19:04 +0000
Message-ID: <CA+V-a8tDNmNDoOGyt-qD13Rk1ta8_EqNBydSpvGW_X-LcD76BQ@mail.gmail.com>
Subject: Re: [PATCH v2 16/20] media: davinci: vpbe_osd: mark read reg function
 as __always_unused
To:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Cc:     linuxarm@huawei.com, mauro.chehab@huawei.com,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-media <linux-media@vger.kernel.org>, llvm@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 29, 2021 at 9:48 AM Mauro Carvalho Chehab
<mchehab+huawei@kernel.org> wrote:
>
> Such function is currently unused, but could be needed in the
> future. So, keep it, marking it as __always_unused, in order to
> avoid a clang W=1 error.
>
> Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
> ---
>
> See [PATCH v2 00/20] at: https://lore.kernel.org/all/cover.1638179135.git.mchehab+huawei@kernel.org/
>
>  drivers/media/platform/davinci/vpbe_osd.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
Reviewed-by: Lad Prabhakar <prabhakar.csengg@gmail.com>

Cheers,
Prabhakar

> diff --git a/drivers/media/platform/davinci/vpbe_osd.c b/drivers/media/platform/davinci/vpbe_osd.c
> index 91b571a0ac2c..32f7ef547c82 100644
> --- a/drivers/media/platform/davinci/vpbe_osd.c
> +++ b/drivers/media/platform/davinci/vpbe_osd.c
> @@ -45,7 +45,7 @@ static const struct platform_device_id vpbe_osd_devtype[] = {
>  MODULE_DEVICE_TABLE(platform, vpbe_osd_devtype);
>
>  /* register access routines */
> -static inline u32 osd_read(struct osd_state *sd, u32 offset)
> +static inline u32 __always_unused osd_read(struct osd_state *sd, u32 offset)
>  {
>         struct osd_state *osd = sd;
>
> --
> 2.33.1
>
