Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8214B4F7928
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Apr 2022 10:09:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237668AbiDGIKD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Apr 2022 04:10:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242927AbiDGIH7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Apr 2022 04:07:59 -0400
Received: from mail-qt1-x82b.google.com (mail-qt1-x82b.google.com [IPv6:2607:f8b0:4864:20::82b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D38F18A3C6;
        Thu,  7 Apr 2022 01:05:28 -0700 (PDT)
Received: by mail-qt1-x82b.google.com with SMTP id a11so7393847qtb.12;
        Thu, 07 Apr 2022 01:05:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=LomUbG6PUJaOAyEeNPYEZc4yxOTynNZPy0VtcUyX4ZY=;
        b=qEXiGdWO0X885lVsV8evUW3Xj83FkNLGn+sz2Ih0nGowdrhhpAS2CFVNTlxHVHOu1K
         ycdLIJlkG/QO8uws4gGTEownETCyqcDPh2QaVRpIzDrOLMZZQ4ilO41WK2eY8mTxpMmr
         RNlHObg18i8GFQAbkYB3tTUvh0Ewyytn1gHI86RsOI8yBnP4KN8wuvV57H4QX3f0brGd
         zAf72uESLzGygARFlD0yEEIbSN1LdpibjcarKCVlUTr8KWaZfnbTtwyMqKsOb8dv11Ey
         LY9qCnbipxWjN8DZ53MyYc2dAJKSWb0m9DYKt77SoZsebcoW+xkJtl2pqTaPasHCMOQT
         Sm1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=LomUbG6PUJaOAyEeNPYEZc4yxOTynNZPy0VtcUyX4ZY=;
        b=dfy2NB34mOkqKoQrBjxs4U6cffjp+mBNaOiHj6IYOdLKrQwMcjrKvB0a5SMWjInDSI
         O3SaQEnPLQJNsVPvfdOPA9ezDrjdRg2YSj+e29eGbkGFfwrqkdHYVkcFq5rzOtuzvGTH
         azApvnYbYU/GER2dl8EFkVdzLMUoF34tdvBnyZasFdeK7zWs03FlNHmyVckZXK5MvrkU
         +EjUh2IIjlBlwTrXVoxPwFI6NIjKY0H5cV75nKmiyNW0K9mbMt69yFUGFDQ0cDDo297e
         is77QQGofPDtIK/HYrUMX8HWrvoWfjMOVvcQe9X50iOLIZtQMRuWJqwyB5GLcR0nCTCF
         WO5A==
X-Gm-Message-State: AOAM530jVFwrHlEcS1XJVek1/2cjmVIKrbwL8Touqx5lv8me8EwT8xES
        Gg/Qhb9zcHUunWuOb5fQGMKw+I25Chfl0zzp+h0=
X-Google-Smtp-Source: ABdhPJziSL8XilgioJ+e1Mjq34CoarB6ZiDVs658zsFvAH5lr0ZDr829LIWqEJ1qLVoQacv9INCueTY+IzGIft5r+m0=
X-Received: by 2002:a05:622a:14cd:b0:2e1:d83a:6fdd with SMTP id
 u13-20020a05622a14cd00b002e1d83a6fddmr10643425qtx.401.1649318727682; Thu, 07
 Apr 2022 01:05:27 -0700 (PDT)
MIME-Version: 1.0
References: <20220323064944.1351923-1-peng.fan@oss.nxp.com>
 <20220323064944.1351923-3-peng.fan@oss.nxp.com> <CAEnQRZB1LL=d3SBCgNomPErBvzEgTVtbBE_PH=V60v-_9UObEg@mail.gmail.com>
 <DU0PR04MB9417DEFA09AB85211AA72A2E88E79@DU0PR04MB9417.eurprd04.prod.outlook.com>
 <CAEnQRZBS8nLjVuTv739BjBFEnPDnN0iRkvdouT0ooJrEDDbH4A@mail.gmail.com>
In-Reply-To: <CAEnQRZBS8nLjVuTv739BjBFEnPDnN0iRkvdouT0ooJrEDDbH4A@mail.gmail.com>
From:   Daniel Baluta <daniel.baluta@gmail.com>
Date:   Thu, 7 Apr 2022 11:05:14 +0300
Message-ID: <CAEnQRZDpsMQUTSBvhztsnApEkWqtnjxf-NbNbr+L22mmiAV8AA@mail.gmail.com>
Subject: Re: [PATCH 2/2] remoteproc: imx_dsp_rproc: use common rproc_elf_load_segments
To:     Peng Fan <peng.fan@nxp.com>
Cc:     "Peng Fan (OSS)" <peng.fan@oss.nxp.com>,
        "bjorn.andersson@linaro.org" <bjorn.andersson@linaro.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        "S.J. Wang" <shengjiu.wang@nxp.com>,
        "linux-remoteproc@vger.kernel.org" <linux-remoteproc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        dl-linux-imx <linux-imx@nxp.com>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
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

On Wed, Apr 6, 2022 at 2:25 PM Daniel Baluta <daniel.baluta@gmail.com> wrote:
>
> On Wed, Apr 6, 2022 at 1:58 PM Peng Fan <peng.fan@nxp.com> wrote:
> >
> > > Subject: Re: [PATCH 2/2] remoteproc: imx_dsp_rproc: use common
> > > rproc_elf_load_segments
> > >
> > > On Thu, Mar 24, 2022 at 1:34 AM Peng Fan (OSS) <peng.fan@oss.nxp.com>
> > > wrote:
> > > >
> > > > From: Peng Fan <peng.fan@nxp.com>
> > > >
> > > > remoteproc elf loader supports the specific case that segments have
> > > > PT_LOAD and memsz/filesz set to zero, so no duplicate code.
> > > >
> > > > Signed-off-by: Peng Fan <peng.fan@nxp.com>

Acked-by: Daniel Baluta <daniel.baluta@nxp.com>

Peng,

I'm fine going on with this now. Next we need to replace the boolean is_iomem
with a flags parameter to hold ATT_IOMEM, ATT_IOMEM32, etc.

> > >
> > > I think this change OK, but we have a case with the DSP were reads/writes
> > > should be done in multiples of 32/64.
> > >
> > > We need a way to provide our own "memcpy" function to be used by
> > > rproc_elf_load_segments.
> >
> > I think when generating elf file, the sections needs to be 32/64bits aligned.
>
> Sure, that could be a fix. But some malicious user can crash the kernel
> by crafting an elf with unaligned sections.
