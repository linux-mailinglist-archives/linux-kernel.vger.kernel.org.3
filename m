Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 91970580A18
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Jul 2022 05:45:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237475AbiGZDpS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Jul 2022 23:45:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229852AbiGZDpQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jul 2022 23:45:16 -0400
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ADADD265D;
        Mon, 25 Jul 2022 20:45:14 -0700 (PDT)
Received: by mail-ej1-x629.google.com with SMTP id tk8so23919246ejc.7;
        Mon, 25 Jul 2022 20:45:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=hK9bdKxTQpaVNAf62mZs34iWrOFJN74ACx5fLDVM42o=;
        b=dQ1lsD0pepwYEFblTk7mpzcFBnxB6tyOgcPOpx/6lHi03xM2x6XoOMsftr0Ahyhnyp
         YKRNwmbk3S/dLgnWzqNgPvK3hzQRuTVRQls/Mi1FhdzbDczqdn38liHHuEZW47JFLsk1
         +h8lkfRCPTDjr9YQRU8WmvTdoUuNXQFyhb7IMeTpMpj5T/h8sYR0lb0eox1DrvXaLl90
         u8PqQ4B47CZB0IIFF6SbpRISJlWaXFWXrxg6Ylkgcn2ynkyqgVjdVxYWOU1X6rvhpy8R
         pTzJRcOEm6vNKlAm0C7wQxZPfKBpMYuFfOzuVH69iBnapUG9N+QMFhV7yxDIhCFQNAdJ
         /mtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=hK9bdKxTQpaVNAf62mZs34iWrOFJN74ACx5fLDVM42o=;
        b=y9Thlp2Cm6fVezY/mAlU30Z0KdXXnV48dd5JHwH6pxqYAhBAM4rHy082jQRU5cylQH
         ZCgNgheuN2XDJFEGTkNZ/ArKCPrl9okpCKeosQxcJ1ReX6UNNf9S2Ggvo1w20lp1weYt
         n3a955YG5EH1NMvlGUfhL76sYVyeuu98kIm9wcrde10AP1uPTZ/CyZc2Boqc/N/f/xl5
         9wgV1aAvgT/wIyPd8rRJqsvyvzmQSTZKmQoaWl2djn5aEWjZIaG3nzjOfnX/196kGp/U
         PYH+EpIUbODrK+y4PLvkqpXI2FiEQ3R7p/bUOz95cnWnPBSO+J5JJHknuOflA57kTNg5
         PXEQ==
X-Gm-Message-State: AJIora9GuM8QjTucc0BbrvGUBzIKkWQvROY4QJGfzmu2cyDNw4YqBN5W
        qmPN9PpY0U8+9erQ8W+92ioDVsJq8tddYfAXqwY=
X-Google-Smtp-Source: AGRyM1uBh2/Ujp0DRIZAzAQnZ43gbhiJIymwO1u6SGrzdqZ5yaYUGN2qu0sR6xbFs3MVvu26GUSOxwk4olKhadauEMc=
X-Received: by 2002:a17:906:844f:b0:72b:549e:a654 with SMTP id
 e15-20020a170906844f00b0072b549ea654mr11954747ejy.535.1658807113081; Mon, 25
 Jul 2022 20:45:13 -0700 (PDT)
MIME-Version: 1.0
References: <1657780937-20891-1-git-send-email-u0084500@gmail.com>
In-Reply-To: <1657780937-20891-1-git-send-email-u0084500@gmail.com>
From:   ChiYuan Huang <u0084500@gmail.com>
Date:   Tue, 26 Jul 2022 11:45:00 +0800
Message-ID: <CADiBU39x98iyO_OB2sYdAUGUOW9pV4dt+mEdfquhuJVm1HDRHA@mail.gmail.com>
Subject: Re: [PATCH v3 0/3] Add Richtek RT5120 PMIC support
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Lee Jones <lee.jones@linaro.org>,
        Mark Brown <broonie@kernel.org>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc:     Liam Girdwood <lgirdwood@gmail.com>,
        cy_huang <cy_huang@richtek.com>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>, lkml <linux-kernel@vger.kernel.org>,
        linux-input@vger.kernel.org
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

cy_huang <u0084500@gmail.com> =E6=96=BC 2022=E5=B9=B47=E6=9C=8814=E6=97=A5 =
=E9=80=B1=E5=9B=9B =E4=B8=8B=E5=8D=882:42=E5=AF=AB=E9=81=93=EF=BC=9A
>
> From: ChiYuan Huang <cy_huang@richtek.com>
>
> This patch series is to add Richtek RT5120 PMIC support.
> In RT5120, it integrates four channels of buck converter, one channel of =
LDO,
> and one external enable channel to control the external power source.
ping ......
>
> rt5120-regulator can be referred in the below link
> Link: https://lore.kernel.org/lkml/165599062767.127406.125714869841700832=
13.b4-ty@kernel.org/
>
> Since v3:
> - Use a 'dev' variable and dev_err_probe to decrease the LOC in mfd.
> - Simplify the power key irq handler key report
> - Since press and release irq not needed to keep in private data, change =
'press',
>   'release' irq as local variable only.
> - Fix Kconfig typo for pwrkey.
>
> Since v2:
> - Add 'unevaluatedProperties: false' for regulator buck1~4/ldo/exten.
> - Fix indention and remove status for powerkey.
> - Refine powerkey description for more HW details.
> - For the regulator property parsing, use of_property_read_u32 instead.
> - Not to overwrite regulator constraint.
> - Refine regulator desc coding.
>
> ChiYuan Huang (3):
>   dt-binding: mfd: Add Richtek RT5120 PMIC support
>   mfd: rt5120: Add Richtek PMIC support
>   input: misc: rt5120: Add power key support
>
>  .../devicetree/bindings/mfd/richtek,rt5120.yaml    | 178 +++++++++++++++=
++++++
>  drivers/input/misc/Kconfig                         |   9 ++
>  drivers/input/misc/Makefile                        |   1 +
>  drivers/input/misc/rt5120-pwrkey.c                 | 105 ++++++++++++
>  drivers/mfd/Kconfig                                |  12 ++
>  drivers/mfd/Makefile                               |   1 +
>  drivers/mfd/rt5120.c                               | 121 ++++++++++++++
>  7 files changed, 427 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/mfd/richtek,rt5120.=
yaml
>  create mode 100644 drivers/input/misc/rt5120-pwrkey.c
>  create mode 100644 drivers/mfd/rt5120.c
>
> --
> 2.7.4
>
