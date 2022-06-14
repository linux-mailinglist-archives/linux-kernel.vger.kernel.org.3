Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6C40154B43F
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Jun 2022 17:11:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355917AbiFNPL1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Jun 2022 11:11:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241398AbiFNPLX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jun 2022 11:11:23 -0400
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5CCF2FE57;
        Tue, 14 Jun 2022 08:11:22 -0700 (PDT)
Received: by mail-ed1-x52e.google.com with SMTP id g7so12098739eda.3;
        Tue, 14 Jun 2022 08:11:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=z3hgroj28Zs89uEskySDVuV/EGAjFVx+1yzPc51SYbg=;
        b=IKXA/fv6Qo7hmQrY4ZMw0Jya/LfD9U/Rml8A+2Rg5Xl9Oebdh8vv3VQlqdirE6wR4q
         5iHXN2Kh468W4DUmRuCvoAzvVA/SVmj7LAjxt//ZE3hz6BSYCfXtG9mAk9GPjtC0MijI
         rER9KxJH2eEi4dFVZpKeaiS+/Jk8DCCHsw2pueu7CeGDefUZWv2GIakBY4klpQ+PN+u2
         J+DZt+vVsPb8TMcMAhh2wBLtzn5yay7tmJJE8sppo4P6eUYlnIjGXAEa4xC1soXHHoFW
         MLD9q6KDCpohqfml8YtGzQZzLf4lvL0F+TISEBISSqvGTEgqCPEa8BZo2K42OsKw6wV/
         GG5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=z3hgroj28Zs89uEskySDVuV/EGAjFVx+1yzPc51SYbg=;
        b=d6ioIP3mBF+CXDh0A1XlVDn1QvHjHyQ29kqBnWeeS9gq6diUCUGKouJ46XFZjfufNY
         eSTkkTaI06z6YkQs2LNX4EKzpu2cjwU4nVckZ/Diz2b6lgYAGEGViAgJ3gdZ5MX6mHyM
         xh7xjbDUoyibv3Ib0U35SHyAbKC0tbo9lCcVGXpKVAhDx3v4FPJgoyVBFD5DSnBzRuHq
         RxhtdjMphYo3JEleETc+ygCwbnxiGDLecmGqPBk6jpZ2cM0gtSEOU6KEkrQfG8+Empu9
         SqcZiuraDCLxLCPQ6kFMnyU72YGpeQYZTYK55/HGaBlsBtjItfM6/E427EC6wtgUHJaw
         6skQ==
X-Gm-Message-State: AOAM531e32xbCeC3555kYdE9K8PNr9DqjAkOSpB9M8NVqXER1SjKaoVE
        IhKDBvV5AwsjlVmpsHg8VJr9iKsXWc/PyC29JD3SZtfNMnsx2Q==
X-Google-Smtp-Source: AGRyM1sb9mKj5CCuJtLS5MIoTIZSWkJQSZvyEbXLvbtJrNfsKT2UeAuAEQpxurmfRMnuHdHBE7HW2BYeu6OJwZ/qOkc=
X-Received: by 2002:a05:6402:4390:b0:42e:b7e:e9ac with SMTP id
 o16-20020a056402439000b0042e0b7ee9acmr6643257edc.97.1655219481180; Tue, 14
 Jun 2022 08:11:21 -0700 (PDT)
MIME-Version: 1.0
References: <20220613120534.36991-1-andrea.merello@iit.it> <20220613120534.36991-9-andrea.merello@iit.it>
 <CAHp75Vdh8kAH6540xCwzFh5uf=QMVTHC42a8pOgvkpObzjfD+w@mail.gmail.com>
 <164f663acbba481a8ea8f45f185aaf83@iit.it> <CAHp75VeYK=oCbbBVp01_b5LK_FqAo4F_bic9Me4Y6PpfFnDU6g@mail.gmail.com>
 <a41936e4063f4c2c9da7c7e1d915bd62@iit.it>
In-Reply-To: <a41936e4063f4c2c9da7c7e1d915bd62@iit.it>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Tue, 14 Jun 2022 17:10:43 +0200
Message-ID: <CAHp75Vd_w1WOp9ntbNqxtuuVXi0kMGbX=OZ7cioNxoh2yUa1ag@mail.gmail.com>
Subject: Re: [v6 08/14] iio: imu: add Bosch Sensortec BNO055 core driver
To:     Andrea Merello <Andrea.Merello@iit.it>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        linux-iio <linux-iio@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Rob Herring <robh+dt@kernel.org>,
        Matt Ranostay <matt.ranostay@konsulko.com>,
        Alexandru Ardelean <ardeleanalex@gmail.com>,
        jmondi <jacopo@jmondi.org>,
        "andrea.merello@gmail.com" <andrea.merello@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 14, 2022 at 2:15 PM Andrea Merello <Andrea.Merello@iit.it> wrot=
e:

...

> >> >> +       devm_add_action_or_reset(priv->dev, bno055_debugfs_remove, =
priv->debugfs);
> >> >
> >> >Shouldn't we report the potential error here? It's not directly
> >> >related to debugfs, but something which is not directly related.
> >>
> >> The error eventually comes out from something that has nothing to do w=
ith debugs per se (i.e. the devm stuff), but it will only affect debugfs in=
deed.
> >>
> >> Assuming that we don't want to make the whole driver fail in case debu=
gfs stuff fails (see last part of the comment above debugfs_create_file() i=
mplementation), and given that the devm_add_action_or_reset(), should indee=
d "reset" in case of failure (i.e.  we should be in a clean situation anywa=
y), I would say it should be OK not to propagate the error and let things g=
o on.
> >
> >As I said, it's not directly related to debugfs. Here is the resource
> >leak possible or bad things happen if you probe the driver, that fails
> >to add this call for removal, remove it, and try to insert again, in
> >such case the debugfs will be stale.
>
> Hum, I would say this shouldn't ever happen: AFAICS devm_add_action_or_re=
set() is a wrapper around devm_add_action() and it's purpose is exactly to =
add a check for failure; devm_add_action_or_reset() immediately invokes the=
 action handler in case devm_add_action() fails. IOW in case of failure to =
add the devm stuff, the debugfs file is removed immediately and it shouldn'=
t cause any mess with next times probe()s; just the driver will go on witho=
ut the debugfs file being here.
>
> I think this is the point of using devm_add_action_or_reset() instead of =
dev_add_action()  indeed, or am I missing something?

Reading that code again and I think you are right, so dev_warn() will
be sufficient to show that we fail. OTOH, what is the point of adding
a resource for the failed debugfs call?

--=20
With Best Regards,
Andy Shevchenko
