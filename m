Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7FB8051130A
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Apr 2022 09:55:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359180AbiD0H5n (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Apr 2022 03:57:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1359262AbiD0H5c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Apr 2022 03:57:32 -0400
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7961D146EE9
        for <linux-kernel@vger.kernel.org>; Wed, 27 Apr 2022 00:54:22 -0700 (PDT)
Received: by mail-wm1-x330.google.com with SMTP id y21so656932wmi.2
        for <linux-kernel@vger.kernel.org>; Wed, 27 Apr 2022 00:54:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=B8nbN3swfbrXgnYGSCO4wAtDKLCsRP8j7OqfaetiPQc=;
        b=lp9sAgV2eeIr66JXRJlrf3ETIVkbcilpN74x1Dw6ECybnsjBxoKKMVJgHaecM22rOT
         Qev0V0WusMIxthHrjGiX3kAtz3rimj5QVkQA0Mq5sSpoT2JqCrqNwWf7P7P3tDgqCn+N
         e7CIyyKKVqD1f3aLTo9YHgd7hUezW84ycY6D+LlW4tbT0LOpuraIF3qa70P7IAH7SSwC
         +qHzzqYt4BDhC4VES0A5R66IXNX5Uv7A2KHum43Dp0A8zVjIppU2yUt4UzoX4iodihj2
         1vKmah5Q3v/4p7QF1WpHEWzRuP3xD4UQNDuCIT6DJBZEGk0NnNLfnYSbp8Cc+zes78oH
         4tZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=B8nbN3swfbrXgnYGSCO4wAtDKLCsRP8j7OqfaetiPQc=;
        b=axqfn5MMjumTBTiawCXl6xQ2croBrDP4cs5o7UwhB3H2o98xW7gyvAccY86KniN2M9
         NEeYrpzcJQfMiJzWZHJd6ebrRVWffRpy2tMFRfkPMlWOldmUJQcnbE0JIlTEfE786FyC
         bcMoCfDgdfTQY8U5OsPW1rfe+0l3EgG+J5b676KmVNzs3CGpUGXF3WaYpGKAfB7tdfCs
         gRfdPxwOvp95CBey3R04ZMF3gS2Wz3sFvKRJ14xrtot4R7Hdc9T1ZjNOuBSEwpWQCYd1
         GDHTfF1bvlco+zJOj5toBECfTKzJ/HA0YngLaS/7LVTCnjDzjSCo/Auey14XFb8tphzQ
         Djdw==
X-Gm-Message-State: AOAM530s7jiMqalLEleRevF6WF2Yh7aF3m2LVFji1vRKNLO9YgTempKQ
        Gr90ObZkc/qCpHh7zCngpVoZJkc3t2iGZWThO+M=
X-Google-Smtp-Source: ABdhPJzCTLB6yYxazrpi5VUaJbPabeq8V8EFrD1craGCPNjB3CosAaFOSV3RVIY0aW3i9QkKX28Rz+QcCWj8Xlsujno=
X-Received: by 2002:a05:600c:35c5:b0:390:9982:73ec with SMTP id
 r5-20020a05600c35c500b00390998273ecmr33946774wmq.196.1651046060791; Wed, 27
 Apr 2022 00:54:20 -0700 (PDT)
MIME-Version: 1.0
References: <20220425132410.2708304-1-gengcixi@gmail.com> <YmgFXLAGDlQe4LZ4@google.com>
 <CAF12kFtjMEohkv27cWQYqTaFdASt05P1B02pAHEYugMYUJArJQ@mail.gmail.com> <YmjyvM32FQKx50iL@google.com>
In-Reply-To: <YmjyvM32FQKx50iL@google.com>
From:   Cixi Geng <gengcixi@gmail.com>
Date:   Wed, 27 Apr 2022 15:53:44 +0800
Message-ID: <CAF12kFt0017pq=6BFLtwrK6SBeuLVnPKnmTpsES4ka0gvbxn=Q@mail.gmail.com>
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

Lee Jones <lee.jones@linaro.org> =E4=BA=8E2022=E5=B9=B44=E6=9C=8827=E6=97=
=A5=E5=91=A8=E4=B8=89 15:37=E5=86=99=E9=81=93=EF=BC=9A
>
> On Wed, 27 Apr 2022, Cixi Geng wrote:
>
> > Lee Jones <lee.jones@linaro.org> =E4=BA=8E2022=E5=B9=B44=E6=9C=8826=E6=
=97=A5=E5=91=A8=E4=BA=8C 22:44=E5=86=99=E9=81=93=EF=BC=9A
> > >
> > > On Mon, 25 Apr 2022, Cixi Geng wrote:
> > >
> > > > From: Cixi Geng <cixi.geng1@unisoc.com>
> > > >
> > > > Add the SC2730 PMIC support for module autoloading
> > > > through SPI modalises.
> > > >
> > > > Signed-off-by: Cixi Geng <cixi.geng1@unisoc.com>
> > > > ---
> > > >  drivers/mfd/sprd-sc27xx-spi.c | 1 +
> > > >  1 file changed, 1 insertion(+)
> > > >
> > > > diff --git a/drivers/mfd/sprd-sc27xx-spi.c b/drivers/mfd/sprd-sc27x=
x-spi.c
> > > > index 55d2c31bdfb2..cf4f89114ae4 100644
> > > > --- a/drivers/mfd/sprd-sc27xx-spi.c
> > > > +++ b/drivers/mfd/sprd-sc27xx-spi.c
> > > > @@ -248,6 +248,7 @@ MODULE_DEVICE_TABLE(of, sprd_pmic_match);
> > > >
> > > >  static const struct spi_device_id sprd_pmic_spi_ids[] =3D {
> > > >       { .name =3D "sc2731", .driver_data =3D (unsigned long)&sc2731=
_data },
> > > > +     { .name =3D "sc2730", .driver_data =3D (unsigned long)&sc2730=
_data },
> > >
> > > Nicer if these were ordered with the smallest number at the top.
> > I followed the order of struct of_device_id sprd_pmic_match[1],Do I nee=
d
> > adjust it as well?
> > [1].https://elixir.bootlin.com/linux/v5.18-rc4/source/drivers/mfd/sprd-=
sc27xx-spi.c#L242
>
> I've applied this patch for now.
>
> Could you please submit a follow-up changing both?
Thanks, a new patch to change the order send.
>
> --
> Lee Jones [=E6=9D=8E=E7=90=BC=E6=96=AF]
> Principal Technical Lead - Developer Services
> Linaro.org =E2=94=82 Open source software for Arm SoCs
> Follow Linaro: Facebook | Twitter | Blog
