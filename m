Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 60F09510DDE
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Apr 2022 03:25:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356659AbiD0B0z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Apr 2022 21:26:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353781AbiD0B0x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Apr 2022 21:26:53 -0400
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 213F9B18A6
        for <linux-kernel@vger.kernel.org>; Tue, 26 Apr 2022 18:23:44 -0700 (PDT)
Received: by mail-wm1-x329.google.com with SMTP id c190-20020a1c35c7000000b0038e37907b5bso2567084wma.0
        for <linux-kernel@vger.kernel.org>; Tue, 26 Apr 2022 18:23:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=WADNevU3iLfLj8HeWS3JmYTBG3yWNRcchiXs+/9xM08=;
        b=brb5i0oYVN7sckD6LzumI32hk5pONpJFe6n/S9d3lJc9ybOaK9j4xNUNyjzMAXA+s3
         J7eaf1d8l7n7T67QylhnSFCkV/E9pDR84Y+aHyqzYNNmJIVhbCyKyFfziP+gqJOXH6lm
         us3FixNsQ2MH1j+PsDtW7AggtMOcvpKWKF3ofAvdYyN1pHKkj3RIIoiRUvffpTK4W0lX
         9DmR4GlxGwiwFLcdHJvkpiW6EmNgi09GVGau1iGzl1xXfQGKgyw17M/vTcUwwBrk0Scr
         jnHygpLfymE2coV+jRSGAViHHGQ2wRaZ6VAWD6VKWkovBAywqCCCzpxlydFlw8eHcZNh
         lIiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=WADNevU3iLfLj8HeWS3JmYTBG3yWNRcchiXs+/9xM08=;
        b=l5YvENX+qbedx4Bgte0+s+tme5m4W5uOK6o8VeFqkJPLEA2tlQeW+fkPUNjEj9L4Oq
         gnlw3j9ZB7RATaZHkCk3naJWPDdnsiyKT/5BAhqiDGTboFD0mjlaEezXRDYW99zkRCH5
         3TXa2bXAdSHub4AD2i0ph271RlzJ0oi2nJ0mJeOPzNTCxOq9yxi/U/umNO8PXPom6Wek
         QZKjszCAjA/fUKYZKQDtQVprTKowL+9mUU2HY6dS4Ct/ppDXHiSWv9iqDRBrCsVy9h0d
         gLHOfdLzFclz2MVOLkKjr70qJk5FWli8fpp2jfYm5tFXySJuWIkGHDzW32LAnGRsQJvk
         LTgg==
X-Gm-Message-State: AOAM532WzuZJ1WdTqoAbJ63MiqoG+KHObe74Y+pGs7/WiGPWVIrjniAy
        nCna7QMswZxtTMF224lMqGx9KLgfJy5M/E1jmuyufbOefSokaA==
X-Google-Smtp-Source: ABdhPJxWYTasjBuqehyjR7KsqFbTWfzDzSv7onjnkNmWrPBH1QRD6xTuiaKvn7yVJNWspNQiJ/T3Mi7mF5YPQnu2Lpk=
X-Received: by 2002:a05:600c:a03:b0:38c:f953:ae13 with SMTP id
 z3-20020a05600c0a0300b0038cf953ae13mr23367925wmp.99.1651022622631; Tue, 26
 Apr 2022 18:23:42 -0700 (PDT)
MIME-Version: 1.0
References: <20220425132410.2708304-1-gengcixi@gmail.com> <YmgFXLAGDlQe4LZ4@google.com>
In-Reply-To: <YmgFXLAGDlQe4LZ4@google.com>
From:   Cixi Geng <gengcixi@gmail.com>
Date:   Wed, 27 Apr 2022 09:23:06 +0800
Message-ID: <CAF12kFtjMEohkv27cWQYqTaFdASt05P1B02pAHEYugMYUJArJQ@mail.gmail.com>
Subject: Re: [PATCH] mfd: sprd: Add SC2730 PMIC to SPI device ID table
To:     Lee Jones <lee.jones@linaro.org>
Cc:     Orson Zhai <orsonzhai@gmail.com>,
        "baolin.wang7@gmail.com" <baolin.wang7@gmail.com>,
        Chunyan Zhang <zhang.lyra@gmail.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Lee Jones <lee.jones@linaro.org> =E4=BA=8E2022=E5=B9=B44=E6=9C=8826=E6=97=
=A5=E5=91=A8=E4=BA=8C 22:44=E5=86=99=E9=81=93=EF=BC=9A
>
> On Mon, 25 Apr 2022, Cixi Geng wrote:
>
> > From: Cixi Geng <cixi.geng1@unisoc.com>
> >
> > Add the SC2730 PMIC support for module autoloading
> > through SPI modalises.
> >
> > Signed-off-by: Cixi Geng <cixi.geng1@unisoc.com>
> > ---
> >  drivers/mfd/sprd-sc27xx-spi.c | 1 +
> >  1 file changed, 1 insertion(+)
> >
> > diff --git a/drivers/mfd/sprd-sc27xx-spi.c b/drivers/mfd/sprd-sc27xx-sp=
i.c
> > index 55d2c31bdfb2..cf4f89114ae4 100644
> > --- a/drivers/mfd/sprd-sc27xx-spi.c
> > +++ b/drivers/mfd/sprd-sc27xx-spi.c
> > @@ -248,6 +248,7 @@ MODULE_DEVICE_TABLE(of, sprd_pmic_match);
> >
> >  static const struct spi_device_id sprd_pmic_spi_ids[] =3D {
> >       { .name =3D "sc2731", .driver_data =3D (unsigned long)&sc2731_dat=
a },
> > +     { .name =3D "sc2730", .driver_data =3D (unsigned long)&sc2730_dat=
a },
>
> Nicer if these were ordered with the smallest number at the top.
I followed the order of struct of_device_id sprd_pmic_match[1],Do I need
adjust it as well?
[1].https://elixir.bootlin.com/linux/v5.18-rc4/source/drivers/mfd/sprd-sc27=
xx-spi.c#L242
>
> >       {},
> >  };
> >  MODULE_DEVICE_TABLE(spi, sprd_pmic_spi_ids);
>
> --
> Lee Jones [=E6=9D=8E=E7=90=BC=E6=96=AF]
> Principal Technical Lead - Developer Services
> Linaro.org =E2=94=82 Open source software for Arm SoCs
> Follow Linaro: Facebook | Twitter | Blog
