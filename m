Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0214954B4AB
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Jun 2022 17:30:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356727AbiFNP2J (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Jun 2022 11:28:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236270AbiFNP1q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jun 2022 11:27:46 -0400
Received: from mail-vs1-xe34.google.com (mail-vs1-xe34.google.com [IPv6:2607:f8b0:4864:20::e34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0F9C27B04;
        Tue, 14 Jun 2022 08:27:43 -0700 (PDT)
Received: by mail-vs1-xe34.google.com with SMTP id x187so9354259vsb.0;
        Tue, 14 Jun 2022 08:27:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:reply-to:from:date:message-id
         :subject:to:cc:content-transfer-encoding;
        bh=R6gek+7k8btaKHOjjow80I4o5y14I8XjWpXPB6g1/2Y=;
        b=B62h3QGdOCNz+CIyxl++5a3MAeWGpBpIqvE1LuIDxAiBT2KOwgQsKXMm+yXioIVHPB
         jjt0HWzkzU+KazGRGAzDxWR3PT8e2YZfMNNwZRjTISDAHYPOACZJXiWVcdlbj62O1iTH
         CRwo8tLU+5BPwTR0mx4PSFMKmNeaQFH128VbyZEXS80sLFMqOfLmOOzA8IxoLLnm8R1v
         HQXqYY7yI1kW48SwVZlyiRMCGRsWx44m6OPWTednk9+irfXrEil3L5JuvbC+KIUjgb7s
         Sv7mQHB3kSWGK1UJfXJjtiXsZawUtOKESqwxCQqrOQ56ByyQX/Ug9G+RZ1xaZgpJwVSc
         sYEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
         :from:date:message-id:subject:to:cc:content-transfer-encoding;
        bh=R6gek+7k8btaKHOjjow80I4o5y14I8XjWpXPB6g1/2Y=;
        b=EDhfSB7+NoOj7pKwu+KhQIx41dVAgqRQUZWIspAmJXXlxpVuS51qFrlkUYFWFJ7CHP
         60RdPHIWtqQn6qf1AnaWu45PM2p4yD6lIK1siZhOQWU8klegAGAOMuz0tjzz5QJtXSHs
         ufcxtde/eXaorrfU16JkkqKTjM89Fw3wDQQi3tv8B25USD4JRb8dP/iqIqHIk3LwE2+S
         7qQKPP+XbrA3yb3CRu/SZ6tYjoLqIhcOti5zRsvVXP59sY8cX25+lgo5IQzbWes5IvRD
         RoLtRVYVJWwmj1hSbLaBOKSmyIEDXt3bK8aeLgxpsQ4jXa25UMTTug5oUjDcXeuH/WxY
         VgNg==
X-Gm-Message-State: AJIora8OxFStUU0P+VLaJpjmXpnPILPnFl8fyJMnccVj85gYMMvzXyxm
        ErVHzKK0N4YgdBYYY3ZQcNBBuYlgSXttrNgL1dw15x0q
X-Google-Smtp-Source: AGRyM1sNY6Hgb1s6xJAYTUwIny72g5FhpKwdFq/0wKPM/o6VQY94iQFJ/lrdOaOTlJH1unL8KMyBHGsAJprHhcfb+js=
X-Received: by 2002:a67:eecb:0:b0:34b:f863:ce1b with SMTP id
 o11-20020a67eecb000000b0034bf863ce1bmr2411704vsp.55.1655220463027; Tue, 14
 Jun 2022 08:27:43 -0700 (PDT)
MIME-Version: 1.0
References: <20220613120534.36991-1-andrea.merello@iit.it> <20220613120534.36991-9-andrea.merello@iit.it>
 <CAHp75Vdh8kAH6540xCwzFh5uf=QMVTHC42a8pOgvkpObzjfD+w@mail.gmail.com>
 <164f663acbba481a8ea8f45f185aaf83@iit.it> <CAHp75VeYK=oCbbBVp01_b5LK_FqAo4F_bic9Me4Y6PpfFnDU6g@mail.gmail.com>
 <a41936e4063f4c2c9da7c7e1d915bd62@iit.it> <CAHp75Vd_w1WOp9ntbNqxtuuVXi0kMGbX=OZ7cioNxoh2yUa1ag@mail.gmail.com>
In-Reply-To: <CAHp75Vd_w1WOp9ntbNqxtuuVXi0kMGbX=OZ7cioNxoh2yUa1ag@mail.gmail.com>
Reply-To: andrea.merello@gmail.com
From:   Andrea Merello <andrea.merello@gmail.com>
Date:   Tue, 14 Jun 2022 17:27:32 +0200
Message-ID: <CAN8YU5PDoAaFcp83NMBZLcMJ99FWOxDc9DXLJthE9uNkK-izHg@mail.gmail.com>
Subject: Re: [v6 08/14] iio: imu: add Bosch Sensortec BNO055 core driver
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Andrea Merello <Andrea.Merello@iit.it>,
        Jonathan Cameron <jic23@kernel.org>,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        linux-iio <linux-iio@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Rob Herring <robh+dt@kernel.org>,
        Matt Ranostay <matt.ranostay@konsulko.com>,
        Alexandru Ardelean <ardeleanalex@gmail.com>,
        jmondi <jacopo@jmondi.org>
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

Il giorno mar 14 giu 2022 alle ore 17:11 Andy Shevchenko
<andy.shevchenko@gmail.com> ha scritto:
>
> On Tue, Jun 14, 2022 at 2:15 PM Andrea Merello <Andrea.Merello@iit.it> wr=
ote:
>
> ...
>
> > >> >> +       devm_add_action_or_reset(priv->dev, bno055_debugfs_remove=
, priv->debugfs);
> > >> >
> > >> >Shouldn't we report the potential error here? It's not directly
> > >> >related to debugfs, but something which is not directly related.
> > >>
> > >> The error eventually comes out from something that has nothing to do=
 with debugs per se (i.e. the devm stuff), but it will only affect debugfs =
indeed.
> > >>
> > >> Assuming that we don't want to make the whole driver fail in case de=
bugfs stuff fails (see last part of the comment above debugfs_create_file()=
 implementation), and given that the devm_add_action_or_reset(), should ind=
eed "reset" in case of failure (i.e.  we should be in a clean situation any=
way), I would say it should be OK not to propagate the error and let things=
 go on.
> > >
> > >As I said, it's not directly related to debugfs. Here is the resource
> > >leak possible or bad things happen if you probe the driver, that fails
> > >to add this call for removal, remove it, and try to insert again, in
> > >such case the debugfs will be stale.
> >
> > Hum, I would say this shouldn't ever happen: AFAICS devm_add_action_or_=
reset() is a wrapper around devm_add_action() and it's purpose is exactly t=
o add a check for failure; devm_add_action_or_reset() immediately invokes t=
he action handler in case devm_add_action() fails. IOW in case of failure t=
o add the devm stuff, the debugfs file is removed immediately and it should=
n't cause any mess with next times probe()s; just the driver will go on wit=
hout the debugfs file being here.
> >
> > I think this is the point of using devm_add_action_or_reset() instead o=
f dev_add_action()  indeed, or am I missing something?
>
> Reading that code again and I think you are right, so dev_warn() will
> be sufficient to show that we fail. OTOH, what is the point of adding
> a resource for the failed debugfs call?

Ah, you are right here: I'll make the call to
devm_add_action_or_reset() conditional to success of
debugfs_create_file(). In case any of the two fails we can also warn
the user.

> --
> With Best Regards,
> Andy Shevchenko
