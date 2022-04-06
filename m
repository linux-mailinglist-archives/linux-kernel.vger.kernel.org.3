Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4173A4F6032
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Apr 2022 15:52:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233931AbiDFNvS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Apr 2022 09:51:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233819AbiDFNuu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Apr 2022 09:50:50 -0400
Received: from mail-qt1-x836.google.com (mail-qt1-x836.google.com [IPv6:2607:f8b0:4864:20::836])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE62655A9BD;
        Wed,  6 Apr 2022 04:25:17 -0700 (PDT)
Received: by mail-qt1-x836.google.com with SMTP id j21so3812858qta.0;
        Wed, 06 Apr 2022 04:25:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=fRfBKq2P4//0SFuNiXfECCkNKXeLtDttSZNKsMp2WCU=;
        b=janivnOrj0WfAFDkiZfQFj1YfWZDlUxLJTw3WrTNerLK5hPgZs8wsCo3ypjgltR5/3
         KvLCk0pSySZp28oIj9QX+PIx6stQLgU8LQEZ6SvwxXVlR7CUdQ4vSsyKKkR2krVj0LaH
         7XVQCeOarYh6xONc0SV+BdsZOgNgOJiGxfxbUdaW9g0lq+dfFpbLDHC+8ywqBpFJN2vx
         WuF7TERkP8dRRjMxyVRZbaNNKnRGFBO57MDUz7yZdtBeYlGsPX0Hp/swq4D/vHmLTCdC
         HeURi7Z6PIrkhP6WDKSbbDgylCDtYPIXoYVVgfb+1vsrpfw2kXJA4dPtuB5GYTyL8ROC
         l2gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=fRfBKq2P4//0SFuNiXfECCkNKXeLtDttSZNKsMp2WCU=;
        b=IkX0nQRaO0GC8ssVEQMPf2wo5mKyx/MRqMPIUssjanmvwKVqi5DNiDkY3I3SgV4G6z
         NuiIRpqJB+UF9tVP+Q9aUFf+uiZJYo6K46Wa6joOY1V1rX+95J6zV0MqU/huyy7AkVSG
         Fu6bPFhaiVPe6ji0ubmcVjB7pyZxi1GISleQMwUPL7Y9cixmVbZBXEUHaoc3iTBZU9ew
         Iko2p4EUIF4GqhJnWCRHS//dYp5nGAYjX30/sjnXbs3kBVH4IuhdL3DL06qukhxuaqxN
         6fThG5igRdt0xg6J7ahQGtJhzGEF1IcGefN2bVibVdRvqTjU7hQTKN3ui7ZJzd1W91fj
         TrlA==
X-Gm-Message-State: AOAM532leRSywJWHTWGFleVifzKY5W8N0iceMF0ALOt4yluSzLTbtc52
        +6iHfO+pT+hEWZaESSA0u5FBwaM/+vqEzV8C6m88DP9Xfgo=
X-Google-Smtp-Source: ABdhPJyQ+UL77ur2OYW2kcXC75ppAut+XrGsPQBFPpQBYaZ8A1nns+dkdPRB0qUibVneZhWv8ZmF6tRumrpH4f4buk4=
X-Received: by 2002:a05:622a:1343:b0:2eb:8171:ce27 with SMTP id
 w3-20020a05622a134300b002eb8171ce27mr6939126qtk.8.1649244316577; Wed, 06 Apr
 2022 04:25:16 -0700 (PDT)
MIME-Version: 1.0
References: <20220323064944.1351923-1-peng.fan@oss.nxp.com>
 <20220323064944.1351923-3-peng.fan@oss.nxp.com> <CAEnQRZB1LL=d3SBCgNomPErBvzEgTVtbBE_PH=V60v-_9UObEg@mail.gmail.com>
 <DU0PR04MB9417DEFA09AB85211AA72A2E88E79@DU0PR04MB9417.eurprd04.prod.outlook.com>
In-Reply-To: <DU0PR04MB9417DEFA09AB85211AA72A2E88E79@DU0PR04MB9417.eurprd04.prod.outlook.com>
From:   Daniel Baluta <daniel.baluta@gmail.com>
Date:   Wed, 6 Apr 2022 14:25:04 +0300
Message-ID: <CAEnQRZBS8nLjVuTv739BjBFEnPDnN0iRkvdouT0ooJrEDDbH4A@mail.gmail.com>
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

On Wed, Apr 6, 2022 at 1:58 PM Peng Fan <peng.fan@nxp.com> wrote:
>
> > Subject: Re: [PATCH 2/2] remoteproc: imx_dsp_rproc: use common
> > rproc_elf_load_segments
> >
> > On Thu, Mar 24, 2022 at 1:34 AM Peng Fan (OSS) <peng.fan@oss.nxp.com>
> > wrote:
> > >
> > > From: Peng Fan <peng.fan@nxp.com>
> > >
> > > remoteproc elf loader supports the specific case that segments have
> > > PT_LOAD and memsz/filesz set to zero, so no duplicate code.
> > >
> > > Signed-off-by: Peng Fan <peng.fan@nxp.com>
> >
> > I think this change OK, but we have a case with the DSP were reads/writes
> > should be done in multiples of 32/64.
> >
> > We need a way to provide our own "memcpy" function to be used by
> > rproc_elf_load_segments.
>
> I think when generating elf file, the sections needs to be 32/64bits aligned.

Sure, that could be a fix. But some malicious user can crash the kernel
by crafting an elf with unaligned sections.
