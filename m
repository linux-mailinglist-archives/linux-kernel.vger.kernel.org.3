Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D98BF47555E
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Dec 2021 10:43:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241259AbhLOJnP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Dec 2021 04:43:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235889AbhLOJnO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Dec 2021 04:43:14 -0500
Received: from mail-lj1-x22a.google.com (mail-lj1-x22a.google.com [IPv6:2a00:1450:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C86A8C061574;
        Wed, 15 Dec 2021 01:43:13 -0800 (PST)
Received: by mail-lj1-x22a.google.com with SMTP id 207so32383004ljf.10;
        Wed, 15 Dec 2021 01:43:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=SHYGGsN12bZDGv3lZplFZt1y38p4XURYrLZM5pERPgY=;
        b=X3Qm3BAnZghY8Odp1CCNEpMH58Nw0jNwfyzeiozYtxXBPd0KsOxz0oyTTXgRKZVwqp
         SkHI5exRc0ouMCMixhgIcpmzXujnS6CXzJ7TrccC4HiOi9AnUkq/JkvOdoz28ExDchE0
         wQ/3gkWfyTkHbgBSYjF7hhpmqbfEcr5DHIyYkMp7czeleIb4dW73OD6YCt7JKw8v2PhR
         qZCJZIrxY4tagAwIJGx2y2Sdr52QO6rmGbnGT9T1o/wcu7/pQt1A45GOX6zFIOKHFezw
         +qhfA9Z2LaW6lsOAZNtVqHdLCexQHqpaA9NWOAmHEt1sRwpq7OYANQzniVz4LQMoC/tt
         2Blg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=SHYGGsN12bZDGv3lZplFZt1y38p4XURYrLZM5pERPgY=;
        b=SByq/xYMZI/jeh4JrAXRgfQ2zSLpXJUuyJ1d5/sp+NRbpwxBci2GtCeLgSZ1wLc+p0
         0QuruahzP+PybQg3kf+vae2++uzPbReo8K4HX287Q5JVQtrWJHRGK6ky9Rewuw4jHbA4
         sN8aFn0FZOQEkHiikjn9WSelVHcdMt8m88bGvm04soMAZfoycsOcIouXSokAbOQ6rYnW
         FNTF0EOKhH16xtKfEAS4rtKm2gKi2Beq2uMSq0RfCHAV2ruvMwHTADFZ5OA06jUfYMy1
         1gcWRXjoQSRCN9e3/qn1Hu2Phd66M3s1AJEOxaGEnfnBkFqjL6QDt6n/gNuzhUT4Xzuo
         Y2ug==
X-Gm-Message-State: AOAM532jmie90Csp8Gq7o3hiO44jpd5J9OSxemt56H/fDrTFx1JrIaWj
        oAECd9aG6nO2aXM/9taL81zG7AOGMD9PAHVeB1M=
X-Google-Smtp-Source: ABdhPJxF/xnQ5Krr4KzeZoI2KPmdz3sfC4SozmAbyfoYqy3HlSxi0duPyhapdRggkQBkjLIXhvwMp2j5v4475BZBg9s=
X-Received: by 2002:a2e:8892:: with SMTP id k18mr9167947lji.288.1639561392097;
 Wed, 15 Dec 2021 01:43:12 -0800 (PST)
MIME-Version: 1.0
References: <1638867233-8383-1-git-send-email-vincent.sunplus@gmail.com>
 <1638867233-8383-2-git-send-email-vincent.sunplus@gmail.com>
 <1b336b98-7546-93e3-f1ed-92d041c2df35@linaro.org> <CAPvp3RgqQ_M9rXfkWFTC5zOgk7OUGO1=o8wDjxiB+5wMPoS_Rg@mail.gmail.com>
 <36d17f8b-2480-6c1d-fe84-d4bd04e4170f@linaro.org>
In-Reply-To: <36d17f8b-2480-6c1d-fe84-d4bd04e4170f@linaro.org>
From:   =?UTF-8?B?5pa96YyV6bS7?= <vincent.sunplus@gmail.com>
Date:   Wed, 15 Dec 2021 17:45:07 +0800
Message-ID: <CAPvp3RiA_vGWV7z_MFKOH4iwjC4qLJavTv0Oz==Er5nS8wBUhg@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] nvmem: Add driver for OCOTP in Sunplus SP7021
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Cc:     linux-kernel@vger.kernel.org, robh+dt@kernel.org,
        devicetree@vger.kernel.org, wells.lu@sunplus.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

hello

Srinivas Kandagatla <srinivas.kandagatla@linaro.org> =E6=96=BC 2021=E5=B9=
=B412=E6=9C=8814=E6=97=A5 =E9=80=B1=E4=BA=8C =E4=B8=8B=E5=8D=885:08=E5=AF=
=AB=E9=81=93=EF=BC=9A
>
>
>
> On 10/12/2021 08:50, =E6=96=BD=E9=8C=95=E9=B4=BB wrote:
> >
> >      > +
> >      > +static const struct of_device_id sp_ocotp_dt_ids[] =3D {
> >      > +     { .compatible =3D "sunplus,sp7021-ocotp", .data =3D &sp_ot=
p_v0 },
> >      > +     { }
> >      > +};
> >      > +MODULE_DEVICE_TABLE(of, sp_ocotp_dt_ids);
> >      > +
> >      > +static struct platform_driver sp_otp_driver =3D {
> >      > +     .probe     =3D sp_ocotp_probe,
> >      > +     .driver    =3D {
> >      > +             .name           =3D "sunplus,sp7021-ocotp",
> >      > +             .of_match_table =3D sp_ocotp_dt_ids,
> >      > +     }
> >      > +};
> >      > +
> >      > +static int __init sp_otp0_drv_new(void)
> >      > +{
> >      > +     return platform_driver_register(&sp_otp_driver);
> >      > +}
> >      > +subsys_initcall(sp_otp0_drv_new);
> >
> >     Why this needs to be subsys_initcall() why can't it be module_init?
> >
> >   The OTP driver will store the mac address for ethernet driver and usb=
2
> > disconnect voltage
> >   for usb2 one. Therefore the order of the OTP driver should take highe=
r
> > priority over the
> > other ones.
>
> drivers that are looking for mac address or other values from nvmem
> should get an EPROBE_DEFER if nvmem provider is not ready.
>
> does that not work for you?
>
>
> --srini

After modification and verification, I found the algorithm of
EPROBE_DEFER worked.
I will replace subsys_initcall() with module_init() for the driver.
Thanks for your review.
