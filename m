Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E1DDE50D6B8
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Apr 2022 03:50:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240243AbiDYBxP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 24 Apr 2022 21:53:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237354AbiDYBxN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Apr 2022 21:53:13 -0400
Received: from mail-yb1-xb29.google.com (mail-yb1-xb29.google.com [IPv6:2607:f8b0:4864:20::b29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8E71632B;
        Sun, 24 Apr 2022 18:50:09 -0700 (PDT)
Received: by mail-yb1-xb29.google.com with SMTP id u33so150615ybd.11;
        Sun, 24 Apr 2022 18:50:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=mDDt8M1t/G8uSDIgwdLPig614Vo7S3NbYE/nG8CEaIY=;
        b=RyK07uLMCiAxUPIrw0scL+OICAsiAYK31fHCS8kYD11NTAfCjDZUpct7AVnuLk9hzj
         /7k6RnZSUU2m9x/LAMI+uGyyjcb+6XRPILW63xpJTplFNuN4ofNQByTmAaMQQSI2ArhS
         KL2mT+b6lEPVPbGyJvwvGRadnFMzARfz0XZDCEVP3vzcZPMMb86lw/45eLBpgJUKiyiT
         KJoX2PofhiEFIZCFWl6NqfwHT4i00f66oMLHP5PfL39HFlYPzAUjp4eTAD3h/1NjME5o
         p5LHeqXtwkQh6PbS87GpuXZxaTvGv9xVkm4/JZQmreiYRVUdgFhtGlz6HTPijoWS1cfT
         EtAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=mDDt8M1t/G8uSDIgwdLPig614Vo7S3NbYE/nG8CEaIY=;
        b=7GyPbn9IOVhWMkNQ6nmVvFn4QEirUNB3V/gx7+hXqMfDKb2o+NuDNd0co3k6xTSPvS
         +Nyi9ZFbl/o2QSMnHV2NbtdSRAz65iTKEmWLKUnThhel6/5sUnXaL9dONNFa4jroQqmM
         k6wfsUENNCg4DOzB84mDd6f3dJqS3dM1jSJ1StPJEiUwuLnDMiHbgqud+7qcuugpGzCT
         g8+D7hBN6cr6zSxoCP1k+OzPwHIfv8CF/SXkMUi27XYOscUfnak0DKXUIce+eOF2NPF1
         uzqKyCThXGusQ5UkPZhXprQBzmn8uIvFJVFcDd16ibPaHtPFdy1NGRdovwBBeFVrcLId
         /wNA==
X-Gm-Message-State: AOAM531jN7TjB4QPBhuTuGmLqp/wBJFcrYzdyi1xa5RxEkk8e1iYTyPw
        r2FXlUb1TdQ0DOW+tfiRb6FEd+T/ME0cJi3Bbc0=
X-Google-Smtp-Source: ABdhPJzl54Fa3ZhWH0bvr1eOLo8+xWpsNJfwykF34nk0OeV8Jzikdnw+uKbmBC7EUbgCp99QDOu8OIWB+LSDAcdDTXg=
X-Received: by 2002:a05:6902:154d:b0:644:b2e7:146 with SMTP id
 r13-20020a056902154d00b00644b2e70146mr13945668ybu.271.1650851408712; Sun, 24
 Apr 2022 18:50:08 -0700 (PDT)
MIME-Version: 1.0
References: <1647945781-10191-1-git-send-email-hammerh0314@gmail.com> <YmLkjriZCm+juYEP@orome>
In-Reply-To: <YmLkjriZCm+juYEP@orome>
From:   hammer hsieh <hammerh0314@gmail.com>
Date:   Mon, 25 Apr 2022 09:49:57 +0800
Message-ID: <CAOX-t57vzkVVO25EMCpvddmE++M1_a8RoDhbNk_M=ObbrqzZMA@mail.gmail.com>
Subject: Re: [PATCH v4 0/2] Add PWM driver for Suplus SP7021 SoC
To:     Thierry Reding <thierry.reding@gmail.com>
Cc:     =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>, lee.jones@linaro.org,
        robh+dt@kernel.org, linux-pwm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        wells.lu@sunplus.com, "hammer.hsieh" <hammer.hsieh@sunplus.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Yes, my colleague is working on it right now.
But he submitted too many items at a time. (clock/reset/interrupt,
defconfig/, arch/arm...)
Current patch v13, still ongoing.
https://lore.kernel.org/all/cover.1649659095.git.qinjian@cqplus1.com/

Thierry Reding <thierry.reding@gmail.com> =E6=96=BC 2022=E5=B9=B44=E6=9C=88=
23=E6=97=A5 =E9=80=B1=E5=85=AD =E4=B8=8A=E5=8D=881:23=E5=AF=AB=E9=81=93=EF=
=BC=9A
>
> On Tue, Mar 22, 2022 at 06:42:59PM +0800, Hammer Hsieh wrote:
> > This is a patch series for PWM driver for Suplus SP7021 SoC.
> >
> > Sunplus SP7021 is an ARM Cortex A7 (4 cores) based SoC. It integrates
> > many peripherals (ex: UART. I2C, SPI, SDIO, eMMC, USB, SD card and
> > etc.) into a single chip. It is designed for industrial control.
>
> I just noticed as I was trying to do test builds that ARCH_SUNPLUS
> doesn't exist yet. Are there any plans to add those in the near future?
>
> I can always use COMPILE_TEST to do test build, but I like to also do
> proper builds because they sometimes flag things that COMPILE_TEST
> misses (like this one).
>
> Thierry
