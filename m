Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8579658472B
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Jul 2022 22:45:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231745AbiG1Up2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Jul 2022 16:45:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232454AbiG1UpU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jul 2022 16:45:20 -0400
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D99E2A41F;
        Thu, 28 Jul 2022 13:45:19 -0700 (PDT)
Received: by mail-ej1-x62a.google.com with SMTP id b11so5071432eju.10;
        Thu, 28 Jul 2022 13:45:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc;
        bh=jdpil24lO0iEvMW3eA1lw/j938uWspxlfFkfnuxPIOA=;
        b=q6d5bp+qm+ovYAMuOGiMthRlJgbO7sF2yg1GwO9Qkd0SgrvwwOK78OHE6CMdSa53Z7
         36se4wO1CwIa2Z2OuOfXa2lHEkDcrJr82aJ9RvFxAvIqBcIcCULYICBR0VK++0ydO3rc
         Gm1/MiAAkQL2zN7gf2FqnEMoVNJ18jTva9OWJHQcdJIfAlEq2aPz75MY4kMHwWnrLJLr
         8/FklTQB4mDa5lBN31MAwNIVs6YS2qBYa8UMFtd39rZJxK9oLa84wgrrnKWMOJGPMHC+
         zsbFqh+dvlCnNRTANE/794EvJxfgYEuyMvdmiYhdUMTUn5ME8kUNEV4boVGqt+2iCdGz
         Hcfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc;
        bh=jdpil24lO0iEvMW3eA1lw/j938uWspxlfFkfnuxPIOA=;
        b=1exvdQsQtLX3Ggy08/5TYVlAq6MKgmNjx5QxKKwKsMh/w7XArefKof9Gk/vCqfGsUO
         3scI9wkktLfRNSo8LqTdRaKmpjtWPLCwYtsfnkRUQoa9EIdgddSU6YnNoRG6trbE4l3T
         SIoWEwoCruYMqcV0x7njOumAyiAQcbcoTDGbjzi6xXMiOUkGpdyGGYN0HlViIpPIXvZj
         16R2AOIR9+7EdEw3Su8DpF7jJ/HovWNiuFv6u9M6OP3FRaKusc0noIkGHGraCN33rrXG
         0O7kJlfwK3o4sIkqMYYMrJyXLr0hELAo8kayGzXtERHW1aKL0GF75EVGSVC0IULRlCtf
         QdzQ==
X-Gm-Message-State: AJIora8sPfoymftA8GzW7n1hbqrIoX6pE3ExXxixhvdaojkWmFh8K34w
        CIWnoZtYP74pUFxG6FoGugYWK15sFXQ5S3uZVgM=
X-Google-Smtp-Source: AGRyM1uNY/QrMsYf49zn72vdG57jOa1NZfj0c+6Nr/xRD8fkS1eiRj6UOgHY6ibgiWKyVjxbeALVoOKx5wNeDW1Iso4=
X-Received: by 2002:a17:906:9b14:b0:72b:313b:2df4 with SMTP id
 eo20-20020a1709069b1400b0072b313b2df4mr490764ejc.99.1659041117836; Thu, 28
 Jul 2022 13:45:17 -0700 (PDT)
MIME-Version: 1.0
References: <20220728003417.3083353-1-potin.lai.pt@gmail.com>
 <20220728003417.3083353-3-potin.lai.pt@gmail.com> <CAHp75VfEfirG+aALEhoSLgcLrFTJq7AQc=_BJg7p7QUykpZHhA@mail.gmail.com>
 <cd033ada-f990-9b19-9aad-8cdf7970a64d@gmail.com>
In-Reply-To: <cd033ada-f990-9b19-9aad-8cdf7970a64d@gmail.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Thu, 28 Jul 2022 22:44:39 +0200
Message-ID: <CAHp75VdGH6g2TBPFyds3Qz4PJNb5jC01aKMour1AfpbV5kqynA@mail.gmail.com>
Subject: Re: [PATCH v4 0/2] iio: humidity: hdc100x: add manufacturer and
 device ID check
To:     Potin Lai <potin.lai.pt@gmail.com>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Patrick Williams <patrick@stwcx.xyz>,
        Potin Lai <potin.lai@quantatw.com>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
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

On Thu, Jul 28, 2022 at 2:40 PM Potin Lai <potin.lai.pt@gmail.com> wrote:
> Andy Shevchenko =E6=96=BC 7/28/2022 7:58 PM =E5=AF=AB=E9=81=93:
> > On Thursday, July 28, 2022, Potin Lai <potin.lai.pt@gmail.com> wrote:

Please, remove the unneeded context when replying!

...


> Sorry, I think I misunderstood your comment in your previous reply.
> (Introducing a temporary variable for struct device pointer might also he=
lp in future to refactor to make code neater.)

It was about

  struct device *dev =3D &client->dev;

but as I said it may be done in a separate patch.

--=20
With Best Regards,
Andy Shevchenko
