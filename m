Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ED9FC584061
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Jul 2022 15:51:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230326AbiG1Nuf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Jul 2022 09:50:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230342AbiG1Nud (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jul 2022 09:50:33 -0400
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB60E286C2
        for <linux-kernel@vger.kernel.org>; Thu, 28 Jul 2022 06:50:31 -0700 (PDT)
Received: by mail-ej1-x636.google.com with SMTP id b11so3240180eju.10
        for <linux-kernel@vger.kernel.org>; Thu, 28 Jul 2022 06:50:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=vxq8TONSE00HXKwla5aOrD7/8grrZxrUZOEScjMYlXo=;
        b=I6w8bTdjtiWIAiiIyaZ8AqDCot6M72QWjJBec1p0ARnt8AHMFhDNL//ZXHs6Aj4TcJ
         /igAyJV2zhTPOL5+D4ckDgbeeKGK3pDFJZ+uLHafanehs6HrIAZgeCEw8EHOns5jIFk+
         kyjl9Ue4ngXTZEorTt7u464GVRsyPj5c8vMftb95KYLL3gFvZNpyv6A5Zo94ZzGwndM3
         7+JncdsyRgSX7u3FMswQZT3L7jNW+jf0yxlZ6ZPCMyQTccQP9r8yzYtBQR4prpLllOTd
         4gUdCmFwmc7lUNriFAqKS368bnIz7FImfmejvwn+pqMKb/5uwMK0Lacm33F2cCXgb+o5
         MBUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=vxq8TONSE00HXKwla5aOrD7/8grrZxrUZOEScjMYlXo=;
        b=Tet64Cn7IqwTM7pbUgcMRHEKMf2Peq7RQiIS1DMih14wcSAAvxHS3Cjfil3QQJbJyO
         Hp/92Bb3B2y+YsW9H4B3cIkGolEQz2WRRb1vLXGn7OWDjYwwFOLrLgcW2MhE4buWd3A1
         XN2IrSZ6LZvCOYAjOpuovdiZuHuJ4HSza9S5UUBrq6IJD+bnrLIEJNgeyk1rkY9vau1v
         zbqdiagVg8xHKtdCL5mGn0cuqSSApQ8hfJ/Kz69C7zWnVicmLEyO5KRJNxMOMKkbr38p
         8fhhxwn7aq32rOE4K6clwyFGkNBFlsboPNy+0YdI6svtZBvMlRvEQDDcbqDDRXTC/Hs7
         PmGA==
X-Gm-Message-State: AJIora/cS+Z7CqJ1M82D6CJJxmZT9kpdQCCiG2krcndgHXXTVLJr6Ezb
        t9cTNL8BTqAAtNh0DXUtnUmQZcNv+zRQqk/TLoiO6w==
X-Google-Smtp-Source: AGRyM1vd13k6pgor+DlHJHQfDA7PQXuMPPW6KeHGTUbH0ZXwLGn62yE4jjI826yPI+uPcZiWt3sa3ZGDqeczrsLkYNM=
X-Received: by 2002:a17:907:9482:b0:72b:8c16:dac0 with SMTP id
 dm2-20020a170907948200b0072b8c16dac0mr18135736ejc.286.1659016230136; Thu, 28
 Jul 2022 06:50:30 -0700 (PDT)
MIME-Version: 1.0
References: <20220723160513.271692-1-Mr.Bossman075@gmail.com>
 <20220723160513.271692-4-Mr.Bossman075@gmail.com> <CACRpkdZMFdYDssk9B7R-MH7xG8Ukp+ZQpXCRVtPRCS=SFh34mA@mail.gmail.com>
In-Reply-To: <CACRpkdZMFdYDssk9B7R-MH7xG8Ukp+ZQpXCRVtPRCS=SFh34mA@mail.gmail.com>
From:   Bartosz Golaszewski <brgl@bgdev.pl>
Date:   Thu, 28 Jul 2022 15:50:19 +0200
Message-ID: <CAMRc=Mf02_L1Msf3Wynqu1EROq+nsizhdEWEBJR0DpTybQ=KWA@mail.gmail.com>
Subject: Re: [PATCH v5 03/12] dt-bindings: gpio: fsl-imx-gpio: Add i.MXRT compatibles
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     Jesse Taube <mr.bossman075@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Rob Herring <robh+dt@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Sascha Hauer <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        Aisheng Dong <aisheng.dong@nxp.com>, stefan@agner.ch,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Arnd Bergmann <arnd@arndb.de>, olof@lixom.net, soc@kernel.org,
        Russell King <linux@armlinux.org.uk>, abel.vesa@nxp.com,
        dev@lynxeye.de, Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        Tim Harvey <tharvey@gateworks.com>,
        Leo Li <leoyang.li@nxp.com>,
        Sebastian Reichel <sebastian.reichel@collabora.com>,
        cniedermaier@dh-electronics.com, clin@suse.com,
        giulio.benetti@benettiengineering.com,
        devicetree <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-clk <linux-clk@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        Rob Herring <robh@kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 26, 2022 at 10:04 AM Linus Walleij <linus.walleij@linaro.org> wrote:
>
> On Sat, Jul 23, 2022 at 6:05 PM Jesse Taube <mr.bossman075@gmail.com> wrote:
>
> > Both the i.MXRT1170 and 1050 have the same gpio controller as
> > "fsl,imx35-gpio". Add i.MXRT to the compatible list.
> >
> > Signed-off-by: Jesse Taube <Mr.Bossman075@gmail.com>
> > Acked-by: Rob Herring <robh@kernel.org>
>
> Acked-by: Linus Walleij <linus.walleij@linaro.org>
> Bartosz needs to apply this to the GPIO tree, I think it can just be applied
> directly without regard for the rest of the patches.
>
> Yours,
> Linus Waleij

Applied, thanks!

Bart
