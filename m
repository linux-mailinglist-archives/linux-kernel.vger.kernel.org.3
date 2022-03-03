Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 441B84CBE0D
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Mar 2022 13:41:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232972AbiCCMmN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Mar 2022 07:42:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230189AbiCCMmK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Mar 2022 07:42:10 -0500
Received: from mail-io1-xd35.google.com (mail-io1-xd35.google.com [IPv6:2607:f8b0:4864:20::d35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D9E217AEFF
        for <linux-kernel@vger.kernel.org>; Thu,  3 Mar 2022 04:41:25 -0800 (PST)
Received: by mail-io1-xd35.google.com with SMTP id c14so5515201ioa.12
        for <linux-kernel@vger.kernel.org>; Thu, 03 Mar 2022 04:41:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sartura-hr.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=9r6ZfFAaOqyWk6kgbqfNam/C9zF89QVW36Fk2rUPv5I=;
        b=kQhkTuAMW21wgujo+qf+haNIwEOnVhDpCk/w3OWQlXSzVdjQRskWRaTVo7FsF8VT5u
         txDom55OgR+S/eB3OFU7NBpl9W5T+lTVu3RNM7ZfjTgEv/JUeQs5qNiy05rvjebeWFxm
         4FLbgo0SlOdp2mj+/RbNeSMU8smBjdnAbg6XQoG48aVdv1t0kRHJCAo7ZC98EP2pXP2U
         Cn4A8UP4n14Bp3pI/QrFZ4+ERCbPGcZBF77Llv79IVxB3iWoigXtdOXGlmnqHk5sWax0
         LzDmwQJWnKT7+nBX07iBvnu+/cP4vb+zMGAnnw10w5U8uhgTVgRHrAQ+J6evTnhoIqGj
         pAnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=9r6ZfFAaOqyWk6kgbqfNam/C9zF89QVW36Fk2rUPv5I=;
        b=KT+53eB4wYKJy8BLzer4JevIYNoX9ESl30lX7Fp22ZkpPMmTV0HGIC7liTZAxrtVAF
         M658vAJNqZodxsGCADW2zcBV/x0KrEp7Dm/Ib45odWGAbgCAzBopa16AS9BqdNnEVMld
         tvgBWLocNZugKMNL3F4QeDPIuLX095snaqu/id3w5lJ+Hvo8JxucqK80SKMvmv8n/opC
         PsAe7Ogvs6p3jL4ketKXEZSW75Ry8vvYilKEFcxAT33vQi9e34smOVP6v9dQXyAWx5hg
         A53FrwIQ4mP4S/5OfeqHttwQ+cky87j/E+KBW7Ay/pUNfdsPc318TI8SSTL3sl656Mke
         HpcQ==
X-Gm-Message-State: AOAM533NBmCnDuFQuB1D4HZNVucpybQN0pZ2yZPaEy3tKv7oMfQ8hXOk
        trUCWotpR+vUNN4yoXpiOzuSN0zxDdznQSmNz6CPXw==
X-Google-Smtp-Source: ABdhPJzCT9ADPJDw76n+48DdfN1TK3J5QScqCaHw6cFVfo1ZTGglNXZMIpNjVlBaBGR7nOMXwQZmqtYkga5BDpnpC2o=
X-Received: by 2002:a02:7f95:0:b0:314:2966:1d39 with SMTP id
 r143-20020a027f95000000b0031429661d39mr29710005jac.317.1646311284120; Thu, 03
 Mar 2022 04:41:24 -0800 (PST)
MIME-Version: 1.0
References: <20220131133049.77780-1-robert.marko@sartura.hr>
 <20220131133049.77780-6-robert.marko@sartura.hr> <Yh8vJNc4D6rA68au@google.com>
 <Yh/kFzNuvbwA2qeE@robh.at.kernel.org>
In-Reply-To: <Yh/kFzNuvbwA2qeE@robh.at.kernel.org>
From:   Robert Marko <robert.marko@sartura.hr>
Date:   Thu, 3 Mar 2022 13:41:13 +0100
Message-ID: <CA+HBbNHComN9kgFp1Xr4mdedwYjDMbSUkw+6_KAe8+O4hrtvKQ@mail.gmail.com>
Subject: Re: [PATCH v10 5/6] dt-bindings: mfd: Add Delta TN48M CPLD drivers bindings
To:     Rob Herring <robh@kernel.org>
Cc:     Lee Jones <lee.jones@linaro.org>,
        Linus Walleij <linus.walleij@linaro.org>, brgl@bgdev.pl,
        Philipp Zabel <p.zabel@pengutronix.de>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        skhan@linuxfoundation.org, Luka Perkov <luka.perkov@sartura.hr>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 2, 2022 at 10:39 PM Rob Herring <robh@kernel.org> wrote:
>
> On Wed, Mar 02, 2022 at 08:47:32AM +0000, Lee Jones wrote:
> > On Mon, 31 Jan 2022, Robert Marko wrote:
> >
> > > Add binding documents for the Delta TN48M CPLD drivers.
> > >
> > > Signed-off-by: Robert Marko <robert.marko@sartura.hr>
> >
> > This is missing a DT review.
>
> How about this one[1]?
>
> Rob
>
> [1] https://lore.kernel.org/all/20210719225906.GA2769608@robh.at.kernel.org/

Hi Rob,
Thanks for reaching out.

As you can see the bindings have evolved since v6,
GPIO driver now only uses 2 distinct compatibles.

I am open to discussion in order to reach some kind of a consensus on
this matter
as the whole series is currently unfortunately stalled.

Regards,
Robert
-- 
Robert Marko
Staff Embedded Linux Engineer
Sartura Ltd.
Lendavska ulica 16a
10000 Zagreb, Croatia
Email: robert.marko@sartura.hr
Web: www.sartura.hr
