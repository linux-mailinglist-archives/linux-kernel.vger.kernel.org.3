Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C656854AABE
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Jun 2022 09:36:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354754AbiFNHgf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Jun 2022 03:36:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354728AbiFNHgb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jun 2022 03:36:31 -0400
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18D663EABA;
        Tue, 14 Jun 2022 00:36:30 -0700 (PDT)
Received: by mail-lf1-x12f.google.com with SMTP id i29so12570470lfp.3;
        Tue, 14 Jun 2022 00:36:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=LFwMlD3e6MpOKchNvuK+4lcuy4YZDarqBQY4i719zcc=;
        b=PAh8hSghT45qJn8oTRAhx1ovw+P3HDYmlFpxUYNixZIUHxPIkAnksasR7avH8YiVVk
         UJqbd+bxOcGrbRKx0vyaV4g9U/iZYQJSSx6BkR3fEaZTaGgaG0P61/puTsbe5/Q+DWtF
         +Jf4v9X+tdwHSVipkPLq+ma11BuKtK6Xa6nfjuC18uMNzr3c/oSYoXNwsQWQCMmf1Rws
         dKFt79RZp2CIm9Uqnwbs39VyU2OWMXsXA9mzqS1Cm0wdmud97suQL+PS8gSqjS4eTCnE
         geR/6WFX9MoQ3U+8mh9eMkv2y0mlzumkOp5BKdefSjLztrSMQxnOGDrrX91/LQj5dIzr
         RQ3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=LFwMlD3e6MpOKchNvuK+4lcuy4YZDarqBQY4i719zcc=;
        b=mvOA8Hp6pVTHd7N+t8outqeR28OYoequgRZPMtEdnt+KXmGlPjbNYPlg6hxj6pjJv5
         5UcrwsPkOkcQLEKENT9cu7w/Y3LkwpLxwpg+CgiIEDrPqlZ1+tMbsW30+EyNXKQFPcND
         BYMMqkCi9UHgmseUdTpgKwGXukubQNCo2yuzgn6scvEWib8+psB/74B4zDSaDD3bjYN1
         apbVdfeGXUngxrS9NNTDuSPCK0BDmuDv3sBa166pdBcPbJJaQAEqUSAGYDQ6SKCrT9pC
         wvi5pFM3XUPWPUQ4LedZw4/+kPZ1AeCV2D8j7g9BBAj0x2vv6hlNVXXmijF7ykhZ90Wt
         NX+A==
X-Gm-Message-State: AJIora9y5BDDCj4rwVE6nVrmuOyfGfsV8A1Pe1X9Cs9af2ATLsWW02tZ
        xqquf8c6V6rmf7NpH+wa89pftzorBSlGzGQJYivOo84i
X-Google-Smtp-Source: AGRyM1uROblyDj8YDXZUc3ZoCBhH+XazHfRipMjAGBfNxPmWlz06u+/rd7JiQYm3NWYT2+vv0cn9AF47W2oVtwMUCtI=
X-Received: by 2002:a05:6512:1051:b0:479:6428:7a59 with SMTP id
 c17-20020a056512105100b0047964287a59mr2321642lfb.222.1655192188103; Tue, 14
 Jun 2022 00:36:28 -0700 (PDT)
MIME-Version: 1.0
References: <1651138365-17362-1-git-send-email-u0084500@gmail.com>
In-Reply-To: <1651138365-17362-1-git-send-email-u0084500@gmail.com>
From:   ChiYuan Huang <u0084500@gmail.com>
Date:   Tue, 14 Jun 2022 15:36:17 +0800
Message-ID: <CADiBU38V+03GrCt6SWbPywzJWfL=ibkzhDHFMJdu8n2XC=TKog@mail.gmail.com>
Subject: Re: [PATCH 0/4] leds: flash: mt6360: Apply the fixes and hardware features
To:     Pavel Machek <pavel@ucw.cz>,
        Matthias Brugger <matthias.bgg@gmail.com>
Cc:     cy_huang <cy_huang@richtek.com>,
        Jacek Anaszewski <jacek.anaszewski@gmail.com>,
        Gene Chen <gene_chen@richtek.com>,
        Linux LED Subsystem <linux-leds@vger.kernel.org>,
        linux-arm Mailing List <linux-arm-kernel@lists.infradead.org>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>,
        lkml <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi:

    Is there any comment about this patch series?
One is for the fix, second is Kconfig refine, others are for the HW
PWM/Breath feature added.

cy_huang <u0084500@gmail.com> =E6=96=BC 2022=E5=B9=B44=E6=9C=8828=E6=97=A5 =
=E9=80=B1=E5=9B=9B =E4=B8=8B=E5=8D=885:33=E5=AF=AB=E9=81=93=EF=BC=9A
>
> From: ChiYuan Huang <cy_huang@richtek.com>
>
> This patch series includes some fixes and add supproted ISNK hardware fea=
tures.
> From MT6360, ISNK can support three modes (CC, PWM, and Breath). The prev=
ious
> one can only support CC mode.
>
> ChiYuan Huang (4):
>   leds: flash: mt6360: Fix the wrong enable_reg in multicolor brightness
>     set
>   leds: flash: mt6360: Remove unused dependency in Kconfig
>   leds: flash: mt6360: Add mt6360 isnk channel hardware timer dimming
>     mode support
>   leds: flash: mt6360: Add mt6360 isnk channel hardwre breath mode
>     support
>
>  drivers/leds/flash/Kconfig       |   4 +-
>  drivers/leds/flash/leds-mt6360.c | 413 +++++++++++++++++++++++++++++++++=
+++++-
>  2 files changed, 410 insertions(+), 7 deletions(-)
>
> --
> 2.7.4
>
