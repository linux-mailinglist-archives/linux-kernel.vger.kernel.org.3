Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9E97155887B
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Jun 2022 21:16:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229564AbiFWTQd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Jun 2022 15:16:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229840AbiFWTQJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jun 2022 15:16:09 -0400
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E18CC131E79;
        Thu, 23 Jun 2022 11:20:30 -0700 (PDT)
Received: by mail-pj1-x102b.google.com with SMTP id n16-20020a17090ade9000b001ed15b37424so376984pjv.3;
        Thu, 23 Jun 2022 11:20:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=yBYKrcrF5QlUGbulyTLfet9VDcmeStQQOVl6cu10I3g=;
        b=YprQHHchgAcNU/wU/W30ufULtBlhlphvqN58LEx2irZ9kktJUTcvYVfU4styS75v0L
         r4bYO5ewqSRExSIGSdapAEzKpZvm2+hBUVdyLgBi4+lMrnWIXrtO+ojYbGcwhEqLHBce
         O5etZGzP5ra2AR9lF5m+Rj2Ayj1B4WvcohGtkCZdZAWQJ7HnSrVMZj9H8FdH7sgn5AfG
         d2ohy4GQTMIAsFAaK7jumr0S7BtHkZvtErIFRXuroqJvEnCpTJzxnF6owUU+syK0loqB
         lcS/f5wilQ5GY1NfLvufnW+ObN+zt5zTKztuO0UUMsXdFp9q/sW1Qf010s4wPLEAL6P2
         P2zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=yBYKrcrF5QlUGbulyTLfet9VDcmeStQQOVl6cu10I3g=;
        b=NuB3GSrXG6MPOLOAdM31ysTA0QWQsh6vxIf2JHu4VqsDIkzaJJ4XyZKeUgklpUMKmV
         uDMQ4MIIV5ynLAlTvGOCmeWq9gu9k2omUw7elLGB4ipzx317Vh0+Zt3TK5oQBFwvQ1jp
         QCBeNNEvNU9RNLUNx5bRU8vvD+rXAI4eEMSAO17qejI4Tqq7kE5RKuOIzsAqyjX1nPm8
         x9cp3Imn1EtFk5ixroniIQINJ0EBbeSPwUTJRceRUZb5O2HXeZ217YoPOWorh63Y57qE
         UZb3PucV8ucIP56tK0v91lVQaa4Qlx1aC9MEeBnLFLQyK1yjHwOAHGXvkem91MtHqDpq
         a96A==
X-Gm-Message-State: AJIora+fMgMk3pTWI9ZvjldjUoEyP/HKOvIHFZtGIJ002CI8Ma6PpLvJ
        k8i8/og9FPRGdlyF1X72CW5Aj5fXRHeZ6Y6ELpY=
X-Google-Smtp-Source: AGRyM1uW3/CosuvjmlWJMhk+hLrUeVGEH85m/SWozF8ek4r7Y8GJdZSYPxoAW/hwFs4UAGDuzH71ZELQl8BfE/F6QdU=
X-Received: by 2002:a17:90b:4d0e:b0:1e2:bcd7:c68c with SMTP id
 mw14-20020a17090b4d0e00b001e2bcd7c68cmr5303559pjb.74.1656008429701; Thu, 23
 Jun 2022 11:20:29 -0700 (PDT)
MIME-Version: 1.0
References: <20220622062027.994614-1-peng.fan@oss.nxp.com> <20220622072435.GT1615@pengutronix.de>
 <CAGETcx9JpTbYtGFoKttWLeiBB73QzzBM1o-OL0o-XuFouLcEog@mail.gmail.com> <CAOMZO5DFX72xuxWwAPsuk4Q667Ap7Dk+pR89cWDQJkzT0D2osA@mail.gmail.com>
In-Reply-To: <CAOMZO5DFX72xuxWwAPsuk4Q667Ap7Dk+pR89cWDQJkzT0D2osA@mail.gmail.com>
From:   Fabio Estevam <festevam@gmail.com>
Date:   Thu, 23 Jun 2022 15:20:18 -0300
Message-ID: <CAOMZO5Ccu_v_G9DEwrEfVHq83-hfrXCP_h20Rv0=oFTLux5AkQ@mail.gmail.com>
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

On Thu, Jun 23, 2022 at 8:35 AM Fabio Estevam <festevam@gmail.com> wrote:

> It didn't work for me on an imx6q-sabresd board. I could not find a v2.

Ok, found your v2 and tested it.

It solves the console problem on an imx6q-sabresd.

> Also, would this solution work when stdout-path is not passed in the devicetree?

I have confirmed that v2 does not fix the case when stdout-path is not
passed in the devicetree.

While it is a good practice to describe stdout-path in dt, not all
devicetree files do this,
so 71066545b48e4 will cause regressions on several boards.
