Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 522A848C040
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jan 2022 09:51:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349537AbiALIvr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Jan 2022 03:51:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237959AbiALIvq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jan 2022 03:51:46 -0500
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17C26C06173F
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jan 2022 00:51:46 -0800 (PST)
Received: by mail-pl1-x629.google.com with SMTP id p14so3191309plf.3
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jan 2022 00:51:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=zzw2OtCR4zPV/tIIl1/hV37vrWAMfZ8fJBYvnqWy2q8=;
        b=hHECxXlMoYf14MQJ3tQJkv4kQ7uab+TTEaUemUAAkIuWjaabOadj1FMSjeYta2dCjp
         gB0HbhfB7MLID93RZnwH0a515EiVSiyjmZPlolw+jfvnHlu5WeeZy23jAIk1AHnB+nCk
         9magP1ZEMWU+D8gaJeSnz/i9FGS47HRhYJBJ2G/k7RTAlxY73lJsGqet7gYKpW0+G+uL
         fHjNbSdjcWpsbt1kRndztSsCdAiHr+se1zXxYqxlXXgM7H1tihAb15Pe0rjGitAgZMJH
         v23DvmU1ov2aUML97rlJ8HVdw/QG1cRewfebYLSdrmTKZqPYjAc/rQS+wL5w9UnbbzP9
         RD8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=zzw2OtCR4zPV/tIIl1/hV37vrWAMfZ8fJBYvnqWy2q8=;
        b=qyrBuyAyEPv2vvwUEtArrhdHovOz1JPBPYua9OawZQ+7XU+XodUE0Z8TDTMj1OklZN
         TFS2dXTDGlMPLu5Q37k+x50ywtf0prYUw0MtEtZyC9+2jIPdFRRZ/Xt9xWrh3+p6tC/P
         jPJyrIID2E1DjVXrZDxPvLYozMLbnC7d7XJg5oHMiBpfrjW6EjQEUBfpGQxX47mwCUNi
         mIuNri6DqrtR2w2H79KtSo7J0H3aHbAVmHR3/Rujm5azti2A3hOGS6fWLY0dctFs0xpC
         Wo+QebqTvOI2cXGjh5NC7r/si5vKvnTnCZ/KLF9qTSmcrW0f7K9xfcCLF/9ogrDUPTLr
         0uPQ==
X-Gm-Message-State: AOAM53217ml3cGgxtPtg4iMKjd1y4QCYUtIdU42On3wRKEb5o1yhahGE
        peX7OY8eazOyqMm2NUkErcoRNxS8V0mqi1l6xBI=
X-Google-Smtp-Source: ABdhPJzAMp0qhUOkAs8lyb7w/Cmd+w4mx+GQT+Hi8e57os8JA9Nyi+7lzew7Keed8zAsAPsBLVcpsorK+ZZ+drIuXuE=
X-Received: by 2002:a17:90a:68c5:: with SMTP id q5mr7636274pjj.40.1641977505496;
 Wed, 12 Jan 2022 00:51:45 -0800 (PST)
MIME-Version: 1.0
References: <20220112082524.667552-1-chi.minghao@zte.com.cn>
In-Reply-To: <20220112082524.667552-1-chi.minghao@zte.com.cn>
From:   Patrik Jakobsson <patrik.r.jakobsson@gmail.com>
Date:   Wed, 12 Jan 2022 09:51:34 +0100
Message-ID: <CAMeQTsbsrg0yNQMAxgocGuHkMtwiyRoh3nPJEmeR3yVGUoBg_g@mail.gmail.com>
Subject: Re: [PATCH] drm/gma500: remove redundant ret variable
To:     cgel.zte@gmail.com
Cc:     David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Minghao Chi <chi.minghao@zte.com.cn>,
        Zeal Robot <zealci@zte.com.cn>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 12, 2022 at 9:25 AM <cgel.zte@gmail.com> wrote:
>
> From: Minghao Chi <chi.minghao@zte.com.cn>
>
> Return value directly instead of taking this in another redundant
> variable.
>
> Reported-by: Zeal Robot <zealci@zte.com.cn>
> Signed-off-by: Minghao Chi <chi.minghao@zte.com.cn>
> Signed-off-by: CGEL ZTE <cgel.zte@gmail.com>

Thanks for the patch. I'll apply this to drm-misc-next

-Patrik

> ---
>  drivers/gpu/drm/gma500/cdv_intel_dp.c | 12 +++---------
>  1 file changed, 3 insertions(+), 9 deletions(-)
>
> diff --git a/drivers/gpu/drm/gma500/cdv_intel_dp.c b/drivers/gpu/drm/gma500/cdv_intel_dp.c
> index ba6ad1466374..74e67679714e 100644
> --- a/drivers/gpu/drm/gma500/cdv_intel_dp.c
> +++ b/drivers/gpu/drm/gma500/cdv_intel_dp.c
> @@ -82,7 +82,6 @@ i2c_algo_dp_aux_address(struct i2c_adapter *adapter, u16 address, bool reading)
>  {
>         struct i2c_algo_dp_aux_data *algo_data = adapter->algo_data;
>         int mode = MODE_I2C_START;
> -       int ret;
>
>         if (reading)
>                 mode |= MODE_I2C_READ;
> @@ -90,8 +89,7 @@ i2c_algo_dp_aux_address(struct i2c_adapter *adapter, u16 address, bool reading)
>                 mode |= MODE_I2C_WRITE;
>         algo_data->address = address;
>         algo_data->running = true;
> -       ret = i2c_algo_dp_aux_transaction(adapter, mode, 0, NULL);
> -       return ret;
> +       return i2c_algo_dp_aux_transaction(adapter, mode, 0, NULL);
>  }
>
>  /*
> @@ -122,13 +120,11 @@ static int
>  i2c_algo_dp_aux_put_byte(struct i2c_adapter *adapter, u8 byte)
>  {
>         struct i2c_algo_dp_aux_data *algo_data = adapter->algo_data;
> -       int ret;
>
>         if (!algo_data->running)
>                 return -EIO;
>
> -       ret = i2c_algo_dp_aux_transaction(adapter, MODE_I2C_WRITE, byte, NULL);
> -       return ret;
> +       return i2c_algo_dp_aux_transaction(adapter, MODE_I2C_WRITE, byte, NULL);
>  }
>
>  /*
> @@ -139,13 +135,11 @@ static int
>  i2c_algo_dp_aux_get_byte(struct i2c_adapter *adapter, u8 *byte_ret)
>  {
>         struct i2c_algo_dp_aux_data *algo_data = adapter->algo_data;
> -       int ret;
>
>         if (!algo_data->running)
>                 return -EIO;
>
> -       ret = i2c_algo_dp_aux_transaction(adapter, MODE_I2C_READ, 0, byte_ret);
> -       return ret;
> +       return i2c_algo_dp_aux_transaction(adapter, MODE_I2C_READ, 0, byte_ret);
>  }
>
>  static int
> --
> 2.25.1
>
