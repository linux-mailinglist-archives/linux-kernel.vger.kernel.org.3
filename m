Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D41555578CB
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Jun 2022 13:35:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230418AbiFWLf3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Jun 2022 07:35:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230169AbiFWLf1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jun 2022 07:35:27 -0400
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D88918B2F;
        Thu, 23 Jun 2022 04:35:27 -0700 (PDT)
Received: by mail-pj1-x102b.google.com with SMTP id t3-20020a17090a510300b001ea87ef9a3dso2286549pjh.4;
        Thu, 23 Jun 2022 04:35:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=vsyfHMyH/TR0E0PmGWrQW/kJNy9jLdkWqv7HwqClBfA=;
        b=OR6ycU+ajc0fFNhcfMnbJPRnd0/ofiHqUr3ab7LGj8MF+ym7drraZwkJKtwftYHb5b
         lPTMJACxTgNdg5g6KIsiHULN3xWME8R8lVuZiSLA+9JbeFOWFYTkgQmGxHXpGJpwcSzM
         ozCu99e7LTkXHuBxpUFvcY374w/RWay6M8Pzh5ljP57rlWuarGZ+vbW33Kabua24FYqh
         +slR7Wx5Dk9LU9IaIKKnU6NWbO/hbS5NRzSfJtNUC9D1OyE9pdUqun7h3x8so0r9qmxn
         g67L/M9l1wpHLX023iL2gDMvwJD1UqLq4iEZqrQLyAJeueRHeB8H8ZFsacF8vAb01poW
         brNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=vsyfHMyH/TR0E0PmGWrQW/kJNy9jLdkWqv7HwqClBfA=;
        b=YGF9TO1yWoiYnYl7ilun5kcZTd6r+fYYQTn0I3RlgJUHhKaKm24ccMI7OtcAROp3Ym
         YuLktN1nbKq0jcH0BqrIGtHV7/m9GS4dL6+LdXofm/xEL0HlfjUw12MREaOEWDzwUgO1
         Z/yluUlkxEOrLr+WE7oY3EQz7/68U85d4sVVICy3iHdQYns/oden/lUi9E+AuogC96U/
         3kZ5fwBJZLLSh4IlqlRG/Io6tUD0KHpYoopStZR3M+2SsSBOv2dCwWI4rDJwrRZECsXg
         mm8eu8sJrUnGoW2CJ4qIGHQ/FwBiUQih1OD1Uw/syxwZyWzP/b+x8NDdZcGknIGgfH06
         QisA==
X-Gm-Message-State: AJIora8RnU1zlQpzd5oY1VsilCzf8QqYPZjXTZWnVNgAJJaaNA3RqyMy
        7wBmQkv/dVs00fLcLyIxkSIhNBZVtNa5OfRVUHw=
X-Google-Smtp-Source: AGRyM1vw+t0OrQ8WbLbDKkZP/uTThp4PbUVk/mze6U4Ga2khFe22L5OBe1mJXbLj7D0R1uqO+xylnsdjHoaOq414Ldo=
X-Received: by 2002:a17:903:32cb:b0:16a:3f2e:ca70 with SMTP id
 i11-20020a17090332cb00b0016a3f2eca70mr11260495plr.153.1655984126848; Thu, 23
 Jun 2022 04:35:26 -0700 (PDT)
MIME-Version: 1.0
References: <20220622062027.994614-1-peng.fan@oss.nxp.com> <20220622072435.GT1615@pengutronix.de>
 <CAGETcx9JpTbYtGFoKttWLeiBB73QzzBM1o-OL0o-XuFouLcEog@mail.gmail.com>
In-Reply-To: <CAGETcx9JpTbYtGFoKttWLeiBB73QzzBM1o-OL0o-XuFouLcEog@mail.gmail.com>
From:   Fabio Estevam <festevam@gmail.com>
Date:   Thu, 23 Jun 2022 08:35:15 -0300
Message-ID: <CAOMZO5DFX72xuxWwAPsuk4Q667Ap7Dk+pR89cWDQJkzT0D2osA@mail.gmail.com>
Subject: Re: [PATCH] arm64: dts: imx8mp: drop dmas property for uart console
To:     Saravana Kannan <saravanak@google.com>
Cc:     Sascha Hauer <s.hauer@pengutronix.de>,
        "Peng Fan (OSS)" <peng.fan@oss.nxp.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Shawn Guo <shawnguo@kernel.org>,
        NXP Linux Team <linux-imx@nxp.com>, hvilleneuve@dimonoff.com,
        Lucas Stach <l.stach@pengutronix.de>,
        abbaraju.manojsai@amarulasolutions.com,
        Jagan Teki <jagan@amarulasolutions.com>,
        Matteo Lisi <matteo.lisi@engicam.com>,
        Tim Harvey <tharvey@gateworks.com>,
        Teresa Remmet <t.remmet@phytec.de>,
        =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>, t.remmet@phytec.deh,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Peng Fan <peng.fan@nxp.com>
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

Hi Saravana,

On Wed, Jun 22, 2022 at 7:31 PM Saravana Kannan <saravanak@google.com> wrote:

> Peng, I sent a fix. Can you give it a shot please?
>
> https://lore.kernel.org/lkml/20220622215912.550419-1-saravanak@google.com/

It didn't work for me on an imx6q-sabresd board. I could not find a v2.

Also, would this solution work when stdout-path is not passed in the devicetree?

Thanks
