Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 36B814CE248
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Mar 2022 03:32:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230403AbiCECdO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Mar 2022 21:33:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229565AbiCECdK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Mar 2022 21:33:10 -0500
Received: from mail-oo1-xc2e.google.com (mail-oo1-xc2e.google.com [IPv6:2607:f8b0:4864:20::c2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4E9E230E68;
        Fri,  4 Mar 2022 18:32:21 -0800 (PST)
Received: by mail-oo1-xc2e.google.com with SMTP id n5-20020a4a9545000000b0031d45a442feso11499803ooi.3;
        Fri, 04 Mar 2022 18:32:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=iFq5ilKFOxR6t6aC3pK/MvPKcBTbF799h40RZuoXp6s=;
        b=Rv7xyDfyINVGIDTtWnfOYa3zhYPcZoIF0xbOktgJBQr3MFzJ+x95qwpChVYJLkcC9p
         uWVgeAM55LMlkNAyPjl1qrYHASqeR6707wpN2wkKikiC8YTUAxMQarVgkYfGzCR5pIsU
         w8ZcYWf9lRMdeROU5/gPHQH73OLGn7EMVGzyP9e1yDoExFpLc9mJWMFVF4W/B8O0w10D
         hHrAJiOdnBbTpgauZUXxVAL4rAwEJoiS0E87oLdt27BBH0EJEXw1efeL2KvRraegBUNz
         iKkzaPE7WFx2Y1Q8rEiXl1+o+XkhkgEd0Skq/oqj7ktqIuDuSdpJR1CJQ3yLAI/Z9vrP
         puWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=iFq5ilKFOxR6t6aC3pK/MvPKcBTbF799h40RZuoXp6s=;
        b=o+OGso6qQnwNFeclzFZjfQfIatu+wI6pgae3UsON3QFuJ4etg4C4KmD+tdOo4n5Tdo
         +ObpZKkKWgBvNeSh+tQ4imcqS+L4qccLYmknMKxNb8AZkEmelEAs+NadmldUfe/VE2QI
         z9IP819oGopNUQlLjwjHX3enOKiUbmymf51rz86qJPp+M8ex9A+E2XB3UhfWF/RipgFF
         0g5lY+gIIeNkKaZnm0ZU4otG2iNIOQg83AQk7IKmzsazYO2yF8HwNfy57W2Rr125ySHB
         cMs30KKV+vlSSCqd7Y2TlG7h1TxVr5WpXqGiBj5Najz2B/ZT5LNEFAehEq9xDlw7bQWS
         HDgw==
X-Gm-Message-State: AOAM532xRtigb9CoibkUs0zeTXu3MbF2Wo8R0RZ++mXZW4xHHWDkN8XL
        vdJWyOdxHeObiksRmOsNO90=
X-Google-Smtp-Source: ABdhPJw3V11UONP5t2HNgXEWPRk3PvUtshcW0XVoQ/3zF9hMAwS7V+zqvLJeprcqLNcPMTrxwczhSw==
X-Received: by 2002:a05:6870:b507:b0:da:b3f:2b40 with SMTP id v7-20020a056870b50700b000da0b3f2b40mr1154579oap.223.1646447541196;
        Fri, 04 Mar 2022 18:32:21 -0800 (PST)
Received: from marsc.168.1.7 ([2804:30c:b7a:7b00:70e:e3d5:be94:991])
        by smtp.gmail.com with ESMTPSA id w20-20020a056870339400b000d75f1d9b83sm2984548oae.48.2022.03.04.18.32.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Mar 2022 18:32:20 -0800 (PST)
Date:   Fri, 4 Mar 2022 23:32:17 -0300
From:   Marcelo Schmitt <marcelo.schmitt1@gmail.com>
To:     "Colin King (gmail)" <colin.i.king@gmail.com>
Cc:     Jonathan Cameron <jic23@kernel.org>, linux-iio@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: iio:adc:ad7280a: Move out of staging
Message-ID: <YiLLsQmnK+f6hjvi@marsc.168.1.7>
References: <69aeef03-69ba-07f4-2506-31e481f86c76@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <69aeef03-69ba-07f4-2506-31e481f86c76@gmail.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 02/24, Colin King (gmail) wrote:
> Hi,
> 
> Static analysis with clang scan picked up a potential issue with
> drivers/iio/adc/ad7280a.c in function ad7280a_write_thresh, the analysis is
> as follows:
> 
>         switch (chan->type) {
>         case IIO_VOLTAGE:
>                 value = ((val - 1000) * 100) / 1568; /* LSB 15.68mV */
>                 value = clamp(value, 0L, 0xFFL);
> 
>                 ^^
> Note: variable value is being assigned a value
> 
>                 switch (dir) {
>                 case IIO_EV_DIR_RISING:
>                         addr = AD7280A_CELL_OVERVOLTAGE_REG;
>                         ret = ad7280_write(st, AD7280A_DEVADDR_MASTER, addr,
>                                            1, val);
>                         if (ret)
>                                 break;
>                         st->cell_threshhigh = value;
> 
> ..and value is being used here ^^
> 
>                         break;
>                 case IIO_EV_DIR_FALLING:
>                         addr = AD7280A_CELL_UNDERVOLTAGE_REG;
>                         ret = ad7280_write(st, AD7280A_DEVADDR_MASTER, addr,
>                                            1, val);
>                         if (ret)
>                                 break;
>                         st->cell_threshlow = value;
> 
> and value is being used here ^^
> 
>                         break;
>                 default:
>                         ret = -EINVAL;
>                         goto err_unlock;
>                 }
>                 break;
> 
> However for the IIO_TEMP case:
> 
>         case IIO_TEMP:
>                 value = (val * 10) / 196; /* LSB 19.6mV */
>                 value = clamp(value, 0L, 0xFFL);
> 
>                 ^^
> Note: variable value is being assigned a value
> 
>                 switch (dir) {
>                 case IIO_EV_DIR_RISING:
>                         addr = AD7280A_AUX_ADC_OVERVOLTAGE_REG;
>                         ret = ad7280_write(st, AD7280A_DEVADDR_MASTER, addr,
>                                            1, val);
>                         if (ret)
>                                 break;
>                         st->aux_threshhigh = val;
>                                              ^^
> But val is being used here rather than value
> 
>                         break;
>                 case IIO_EV_DIR_FALLING:
>                         addr = AD7280A_AUX_ADC_UNDERVOLTAGE_REG;
>                         ret = ad7280_write(st, AD7280A_DEVADDR_MASTER, addr,
>                                            1, val);
>                         if (ret)
>                                 break;
>                         st->aux_threshlow = val;
>                                             ^^
> and val us being used here rather than value too
> 
> 
> So for the IIO_TEMP case either the assignment to value is redundant or the
> setting of st->aux_threshhigh or st->auxthreashlow is incorrect.

Good catch. This has really slipped through my review.
It's impressive how we can discuss changes at one specific part of the
code and miss inconsistencies a few lines below it.

Thanks,
Marcelo

> 
> Colin
