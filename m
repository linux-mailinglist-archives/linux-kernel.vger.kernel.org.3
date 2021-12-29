Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A844D4810D0
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Dec 2021 08:50:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239210AbhL2Huc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Dec 2021 02:50:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232037AbhL2Hub (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Dec 2021 02:50:31 -0500
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64426C061574;
        Tue, 28 Dec 2021 23:50:31 -0800 (PST)
Received: by mail-wr1-x431.google.com with SMTP id j18so42853747wrd.2;
        Tue, 28 Dec 2021 23:50:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=XnKm5iuVU2e6uGgjYmWwpTUlJuwhsXcjYMMwXOTiJAc=;
        b=mPAzfc8iTMOgBZuDKPUR3qN762DnmY6izecRYGcP4c1TuiUKHvz+sbnMRC1WSdToCG
         BCcP3HvehUaHKSvowWaS0PmUg5PpBDsVB/ZqXEphUeU9VGdk5ChRR9jWAZVyUm8lJhds
         k0l1p07JD5q1HWMO2pXwvacxZ4nPEo4cwdlRqmfga0Ox3+R4IQZ5EnRYIU/iODiNBiaS
         f8a/089Mxsvl7VUUW1rpChfcY+XomEGUjEMlS9pbIdJ3etqzC3B4+UbGHHRZMsb7XoGB
         ej2838dsFMu5KpG2COuH9vbMfwMZSYOlcglnCudP8uWqzPGxWN/cs7GCBgVayntRolZ4
         vtvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=XnKm5iuVU2e6uGgjYmWwpTUlJuwhsXcjYMMwXOTiJAc=;
        b=SVFrdCYRtZM64wEmodMvieWdYhGx3oN4xYlWdFeRwf5a5/cw5iUm8F+jJe7iZG9Udq
         v04tojOfgHUIn51B8ifOaKCc/yny1oE3Mz/ApjOrZgHhUYH8DPB/FFHCNj+AyQJDTjHL
         rSMo38Uwt8Xh4Aaq990ZkLSRZ0/WyXadS2IgpjKlRPivxPwHgTNo3morYPTABe+UzHY7
         5VDTF3ULejdoh1+Yxa47aD9/VTN4/2H/wNMQQpEkHSZ492KfO9BUvXnpOkFMBGS7FATx
         Nos+IbN8LbXkBLbKuByEkUpDldIkMMINfhAUd5gbh8Lt3rAwkUm+dqmQQJHdKqXKFIA3
         yZKA==
X-Gm-Message-State: AOAM531u0QJSLpqBZAUhQFcuWKl7G/yxsEOj2wlBpj9b6/hYIPbJhOHe
        +DF+4DnFT4tIPBS4ljy5Mpw=
X-Google-Smtp-Source: ABdhPJyjt4dO2ATROdW4g4BGo5zkRsyTtC9HUgtiuGXKtxw8RwSS/edOth5TZtiYz1w5vLpgot0UaA==
X-Received: by 2002:adf:f310:: with SMTP id i16mr9256503wro.8.1640764229960;
        Tue, 28 Dec 2021 23:50:29 -0800 (PST)
Received: from elementary ([217.113.240.86])
        by smtp.gmail.com with ESMTPSA id h27sm24292839wmc.43.2021.12.28.23.50.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Dec 2021 23:50:29 -0800 (PST)
Date:   Wed, 29 Dec 2021 08:50:25 +0100
From:   =?iso-8859-1?Q?Jos=E9_Exp=F3sito?= <jose.exposito89@gmail.com>
To:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc:     jikos@kernel.org, benjamin.tissoires@redhat.com,
        linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org
Subject: Re: [PATCH] HID: magicmouse: Fix an error handling path in
 magicmouse_probe()
Message-ID: <20211229075025.GA11488@elementary>
References: <b0777c29fb4c59f27a726f62680b4c7f04c5c76e.1640725695.git.christophe.jaillet@wanadoo.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <b0777c29fb4c59f27a726f62680b4c7f04c5c76e.1640725695.git.christophe.jaillet@wanadoo.fr>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 28, 2021 at 10:09:17PM +0100, Christophe JAILLET wrote:
> If the timer introduced by the commit below is started, then it must be
> deleted in the error handling of the probe. Otherwise it would trigger
> once the driver is no more.
> 
> Fixes: 0b91b4e4dae6 ("HID: magicmouse: Report battery level over USB")
> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
> ---
>  drivers/hid/hid-magicmouse.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/hid/hid-magicmouse.c b/drivers/hid/hid-magicmouse.c
> index eba1e8087bfd..b8b08f0a8c54 100644
> --- a/drivers/hid/hid-magicmouse.c
> +++ b/drivers/hid/hid-magicmouse.c
> @@ -873,6 +873,7 @@ static int magicmouse_probe(struct hid_device *hdev,
>  
>  	return 0;
>  err_stop_hw:
> +	del_timer_sync(&msc->battery_timer);
>  	hid_hw_stop(hdev);
>  	return ret;
>  }
> -- 
> 2.32.0
> 

My bad, thanks for catching it!

Tested-by: José Expósito <jose.exposito89@gmail.com>
