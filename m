Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 429E155C21B
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Jun 2022 14:46:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243980AbiF1DAr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Jun 2022 23:00:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231207AbiF1DAp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jun 2022 23:00:45 -0400
Received: from mail-yw1-x1132.google.com (mail-yw1-x1132.google.com [IPv6:2607:f8b0:4864:20::1132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D56D6E57
        for <linux-kernel@vger.kernel.org>; Mon, 27 Jun 2022 20:00:44 -0700 (PDT)
Received: by mail-yw1-x1132.google.com with SMTP id 00721157ae682-3177f4ce3e2so103436747b3.5
        for <linux-kernel@vger.kernel.org>; Mon, 27 Jun 2022 20:00:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=NGQFBKn6mTJLQJJQb0hf6HN+JadFUru77ofDSmMfQME=;
        b=rc0n1c6TbIrQRNmMMiEnaFh0hkBAnLACeL7OVUBc1y63A9tRBXlkByzzujNZkWLuAc
         J2OdWFCudl0xouJCt7hJmzZ8KtYihsfHhff9u1eCTd+ow+JMUq/fRL1W0lpGuZtcgNJt
         NhXTHPFoB66MWty0x0OcTWKeq1qIoqHuUUtesJb6va754w3Of4LZFLBxocLfYxXqjZu2
         18ez++TyOlnFMvyGG/xy/Ub89MG2F4WRe8IsXnAEBC03Jnkz7o0QfkU0XQaP7AONxHfy
         NXOvOrb/Fq/Nz406VXbfwz3cuSSGLNExm8RydGxWaaAZBKsHiD3XQ8n9HbHHWECPvru5
         xATQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=NGQFBKn6mTJLQJJQb0hf6HN+JadFUru77ofDSmMfQME=;
        b=nYK5ez0ca+ojxfzDng8TG/yj5sroISDo3+DSbIzYZJUuJGzcq9PgeDD4uegRsHH1Uw
         Xu5N9qox/koYtbQGXWogMO0EKTkAnyHjLzaa1n82CXOiUtDEWNJ5AOg/TnK8Bo5P/gIC
         ya6g5F1JSfIL5rnYKmG66fNlw/oDcB880XSOYSzJ20kOx3jYv/3R3rNYvsGEIjl1R8S7
         AEo3obyTX5kNRozSyBuJO25ceIivLSaYhQuKgYwTRjRyOLte/FFVuXNXmaN+A9UxCq5z
         +m72XUou4mwoc2q+Cx/voB9QCIr3B7YvjF2TO4pBCW8ITNsYeEYndNhjvlgnLcD5J+5T
         Rkkw==
X-Gm-Message-State: AJIora89OBg3rYa0yLEnnjf/BiMcxQCEht7b5bbg6cibkYM7+ijXI5j6
        rGjUs3mMC2Jez5eAPmUt5GSzX4x/VmiYOuL6GRTZRA==
X-Google-Smtp-Source: AGRyM1vNTu5scvESmObYMGE7sPUp2Y8jmjQXh5dEqfRMki2YHOK/AUCj+at+NEttVXdfG4i+8ADKbHWvMr50nzzZPh8=
X-Received: by 2002:a81:4896:0:b0:317:f767:95f8 with SMTP id
 v144-20020a814896000000b00317f76795f8mr19057497ywa.218.1656385243830; Mon, 27
 Jun 2022 20:00:43 -0700 (PDT)
MIME-Version: 1.0
References: <20220622062027.994614-1-peng.fan@oss.nxp.com> <20220622072435.GT1615@pengutronix.de>
 <CAGETcx_R0zr1PMgNO8HAqcWpaQNOBGzpYdnrMa2MD=HP6mzDqg@mail.gmail.com> <cb65069b-909a-7318-68d8-eaa23c316740@oss.nxp.com>
In-Reply-To: <cb65069b-909a-7318-68d8-eaa23c316740@oss.nxp.com>
From:   Saravana Kannan <saravanak@google.com>
Date:   Mon, 27 Jun 2022 20:00:07 -0700
Message-ID: <CAGETcx-=x=M8ULfJyLtKP11qXvjPYBGAVTD7RNhg1BOGx1UEYg@mail.gmail.com>
Subject: Re: [PATCH] arm64: dts: imx8mp: drop dmas property for uart console
To:     "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Cc:     Sascha Hauer <s.hauer@pengutronix.de>, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, shawnguo@kernel.org,
        festevam@gmail.com, linux-imx@nxp.com, hvilleneuve@dimonoff.com,
        l.stach@pengutronix.de, abbaraju.manojsai@amarulasolutions.com,
        jagan@amarulasolutions.com, matteo.lisi@engicam.com,
        tharvey@gateworks.com, t.remmet@phytec.de,
        u.kleine-koenig@pengutronix.de, t.remmet@phytec.deh,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, Peng Fan <peng.fan@nxp.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 27, 2022 at 1:22 AM Peng Fan (OSS) <peng.fan@oss.nxp.com> wrote=
:
>
> Hi Saravana,
>
> =E5=9C=A8 2022/6/25 15:15, Saravana Kannan =E5=86=99=E9=81=93:
> > On Wed, Jun 22, 2022 at 12:24 AM Sascha Hauer <s.hauer@pengutronix.de> =
wrote:
> >> +Cc Saravana Kannan <saravanak@google.com>, the author of 71066545b48e=
4
> >>
> >> On Wed, Jun 22, 2022 at 02:20:27PM +0800, Peng Fan (OSS) wrote:
> >>> From: Peng Fan <peng.fan@nxp.com>
> >>>
> >>> Commit 71066545b48e4("driver core: Set fw_devlink.strict=3D1 by defau=
lt")
> >>> default set fw_devlink to true. This has a side effect to i.MX uart
> >>> console. The sdma will make the i.MX8MP uart driver defer probe for s=
ome
> >>> time (~10s with i.MX8MP-EVK board) until sdma ready, because sdma is =
a
> >>> supplier with property dmas set in device tree node.
> >> I just tested this on an i.MX6 board and observed the same behaviour.
> >> The same will happen on any other i.MX board as well. This will also
> >> likely happen on any other SoC on which the UART driver uses dmaengine=
.
> >>
> >>> Since this uart is for console, we need log printed out as soon as
> >>> possible, so remove the dmas property for the uart console node.
> >> Fixing this at board level is not really an option because that means
> >> fixing each and every, at least i.MX board in the tree. Furthermore
> >> this would mean to bring the deleted property back in and to remove
> >> another dmas property should a user want to switch to another console
> >> port.
> >>
> >> For what it's worth: NACK for 71066545b48e4.
> > Hi Peng/Sascha/Fabio,
> >
> > I was looking at a fix for this (even when stdout-path isn't set in
> > DT) and looking at the older code (say, 5.18), and it looks like
> > before my recent changes the console would still only get probed
> > during late_initcall(). Does that match your experience?
>
> I could not get you. In driver, it is module init:
> module_init(imx_uart_init), not late_initcall.
>

Correct, the driver does use module_init(). However, because of how
driver_deferred_probe_check_state() is implemented in 5.18, the
console would get deferred probe until late_initcall(). In my earlier
email, I'm trying to get you to confirm my analysis is what you were
seeing in 5.18 (or 5.19-rcX without my series that deletes
driver_deferred_probe_check_state()).

-Saravana
