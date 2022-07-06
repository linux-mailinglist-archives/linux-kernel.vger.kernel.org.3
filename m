Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F2F6B568876
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Jul 2022 14:36:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232371AbiGFMgq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Jul 2022 08:36:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232245AbiGFMgo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jul 2022 08:36:44 -0400
Received: from mail-yw1-x1132.google.com (mail-yw1-x1132.google.com [IPv6:2607:f8b0:4864:20::1132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ADF981BE8A;
        Wed,  6 Jul 2022 05:36:41 -0700 (PDT)
Received: by mail-yw1-x1132.google.com with SMTP id 00721157ae682-317a66d62dfso138428067b3.7;
        Wed, 06 Jul 2022 05:36:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=sTOpDj3B0JNGWnvk1OWAvZnWT1OVUubXtuttRhdrPpM=;
        b=k1QLo+8ys7NyUAOL0fmOmMeACSgLMkm66WZnE4lyiyUyXvUqqiJFX432ZMIs26K6e+
         KRnG/cXS4CMPiLVh6RmFsDVrGWoeFYDyANNBVRq23+pvD5kGrZTH610t4n8+XzQc7Sjo
         o+AlQOPYCg/pjEFLFEGXf0TyTzhgZpuR2eYdPoWLmw6Fi33PrXwvgqwDpxHqovNo+Zm/
         SmiZ/tFCaBpToim9J6dgXRJhbcd56t/ZYXVIyf64B/P1fiN/otZLO10pmBN0XT6pjJmY
         FHk+nQX0Q/9lDPyzdmGQqxp2Zpwhu8zt2w1/Ikt2U4PPu8pFmRjyrdEFsCZX80W+lZVe
         yRKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=sTOpDj3B0JNGWnvk1OWAvZnWT1OVUubXtuttRhdrPpM=;
        b=bTrLdtjjMvIBsUHp25jK6hKGNXZlPFahdX7/RfP2w2xfpCV07zwwxH2HGLodmmgWsF
         XHu2v7Ofo+g+QS3ExJrpcOj8PpLlR2P+mliYQMK8Dl9L2xgCNibKY8Ulg965d7LHf2W6
         iSPjLmCAII9pq9EfUBwdIUvw+Nbz3sMBHpXLiUUUFH9RBlrbSldoR3ZloQ8cfaDQURJD
         2eH+t6SoKdQCz4ObdheEQyaSXeGITfjYi9rgE93E86D4/Co3yzMfFDHz+nvANdoG9gaT
         8Ox+M6QmuCfKM45wjY22EK8o635Jtu0k5AJNvn7cwSnLUH7Z8rhy27gxIA3oorpArVkX
         jEgg==
X-Gm-Message-State: AJIora/cFtiHuUnkOnmykRg6w+giHiDaVuOgHtZujs9CLlomTteB/UYQ
        pJSCcqTKhhQjv1T6zELA0PHLu3spkcVgblRR3To=
X-Google-Smtp-Source: AGRyM1tut2KEhyTX/0JRT+GpR24w2i80fdtHRSQIkoJRE7efMWT7H8RkbjZe2FXj0Yq/SMO0qGcWsLfx8dWDdu2NHls=
X-Received: by 2002:a81:108f:0:b0:31c:d7ae:9ff1 with SMTP id
 137-20020a81108f000000b0031cd7ae9ff1mr7723915ywq.18.1657111000815; Wed, 06
 Jul 2022 05:36:40 -0700 (PDT)
MIME-Version: 1.0
References: <20220705121756.41660-1-kai.heng.feng@canonical.com>
 <CAHp75VdnvxhR7yB2sroH4y8VgU3ORnCC3wH4CEKYCX1XSPvMxg@mail.gmail.com> <CAAd53p4ZNna2G7hD4vDfDF-fAtLNJinr+tr9LddMq06yFT26YA@mail.gmail.com>
In-Reply-To: <CAAd53p4ZNna2G7hD4vDfDF-fAtLNJinr+tr9LddMq06yFT26YA@mail.gmail.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Wed, 6 Jul 2022 14:36:04 +0200
Message-ID: <CAHp75VegnLShEPHg=aRG=M3kf36M3tHPL7Jwz-i=A3Z48-2pYA@mail.gmail.com>
Subject: Re: [PATCH] iio: light: cm32181: Add PM support
To:     Kai-Heng Feng <kai.heng.feng@canonical.com>
Cc:     Kevin Tsai <ktsai@capellamicro.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Hans de Goede <hdegoede@redhat.com>,
        linux-iio <linux-iio@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 6, 2022 at 4:02 AM Kai-Heng Feng
<kai.heng.feng@canonical.com> wrote:
> On Wed, Jul 6, 2022 at 3:12 AM Andy Shevchenko
> <andy.shevchenko@gmail.com> wrote:
> > On Tue, Jul 5, 2022 at 2:31 PM Kai-Heng Feng
> > <kai.heng.feng@canonical.com> wrote:

...

> > > +static int cm32181_resume(struct device *dev)
> > > +{
> > > +       struct i2c_client *client = to_i2c_client(dev);
> > > +       struct cm32181_chip *cm32181 = iio_priv(i2c_get_clientdata(client));
> >
> > Simply device_get_drvdata(dev) ?
>
> iio_priv() is still needed to get the struct priv.

I'm not objecting to that. My point is that you don't need to
dereference dev --> client --> dev.

And yes, I see that client is still used, but it's again not about my point.

> > > +       return i2c_smbus_write_word_data(client, CM32181_REG_ADDR_CMD,
> > > +                                        cm32181->conf_regs[CM32181_REG_ADDR_CMD]);
> > > +}

-- 
With Best Regards,
Andy Shevchenko
