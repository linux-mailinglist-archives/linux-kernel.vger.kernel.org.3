Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5DD3F55533E
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Jun 2022 20:21:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377088AbiFVSVd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Jun 2022 14:21:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1357635AbiFVSVa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jun 2022 14:21:30 -0400
Received: from mail-yw1-x1131.google.com (mail-yw1-x1131.google.com [IPv6:2607:f8b0:4864:20::1131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2143F627F;
        Wed, 22 Jun 2022 11:21:30 -0700 (PDT)
Received: by mail-yw1-x1131.google.com with SMTP id 00721157ae682-317a66d62dfso110611167b3.7;
        Wed, 22 Jun 2022 11:21:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=kDAGZ5oaKET8ZY2scbsG21nVOzoPsTcGCkjRzgJZ53w=;
        b=g9RCLBn7M8sBhhxv+amPLgoKXSDAQxKxCS22mkJsoJPriQ8MAhDweFUOzj+UCG1tLO
         Oij8eI9qnAKwdFhn6uuPvzxUowjKLHuFdX3fAo7toE9+skrseObn2kRitlH/bHExhfOJ
         nCej3PwXX4uS3BqloNnaxhlfRlCA6M5d9256AGoQVcZovl1g497aY/eU8J50OqfBlMVD
         OCLmk6tX/zN8ANxjyj7y65ueWomtF1hsFe+8wUPg20suESZhmOkbiW7Qr0Hpn1rSDFM4
         J8p3173pf/mBLbouPej8bGIdilyBBMFZmGElHDXH7YvcQ0uaFtD1VH04EcL3Bq8LY/DJ
         h0Hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=kDAGZ5oaKET8ZY2scbsG21nVOzoPsTcGCkjRzgJZ53w=;
        b=QeklCNYfbpa1SoSqw9jWtapLt66GaF8eass3lUHHLb6E3vw5wSNCe/ByBTG10wumzY
         bV9qXehvcAs88oRD76w8Z4nejQjH252i7l8YNQnItpEBz1iSVm+XHpBkPy+zjZ77HVl7
         DXlluNN7V3+bKbndvHMeR0H3pkYi1dxGdn4F6qSJTKJgpDTLJnKiQJY48zPxXQo7VVH9
         NDwM5aDbgWRaBjmkGAs2oj+asX4AJPZwBS7acT4EDvLBSXJN5tRfEb2MEi9qWdmTCm6Y
         d9wh/HAmlxbdSWC+46m1RukFB9AaYmRIGB2lOmCQ6JuxBn53DvJsCcHwHuiUQTlejyI9
         9kgQ==
X-Gm-Message-State: AJIora8Q0zExir4yOXXeEUL+812FOfu1ZrqPn5CYhQOHm+vR6LvthF3f
        zGrJbn09jeHMV02wLEPS02ppv+HQmAB7Wp4RB5l/5VZEnEzNsPDW
X-Google-Smtp-Source: AGRyM1tKGzFOHd28RGEedRsQr5Lj83Cx4CBMX1UnkuPCCnPoFsqePRP/XsocC4DX7VQ7mdnrHUMhl+f2KRI1DfldF7Y=
X-Received: by 2002:a05:690c:58d:b0:317:dd62:f6d9 with SMTP id
 bo13-20020a05690c058d00b00317dd62f6d9mr6030982ywb.78.1655922089325; Wed, 22
 Jun 2022 11:21:29 -0700 (PDT)
MIME-Version: 1.0
References: <20220622173614.12778-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20220622173614.12778-3-prabhakar.mahadev-lad.rj@bp.renesas.com> <CAMuHMdWbQ1VHH4ugQs2mamS2KGEj5AdWmNtmg=6eUJmyGRDTVw@mail.gmail.com>
In-Reply-To: <CAMuHMdWbQ1VHH4ugQs2mamS2KGEj5AdWmNtmg=6eUJmyGRDTVw@mail.gmail.com>
From:   "Lad, Prabhakar" <prabhakar.csengg@gmail.com>
Date:   Wed, 22 Jun 2022 19:21:03 +0100
Message-ID: <CA+V-a8vDem8=QaSdJr5mjHC+qbGmUtTBWEsf9T8njMZMT3BGJw@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] mmc: renesas_sdhi: Fix typo's
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Pavel Machek <pavel@denx.de>,
        Linux MMC List <linux-mmc@vger.kernel.org>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Biju Das <biju.das.jz@bp.renesas.com>
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

Hi Geert,

Thank you for the review.

On Wed, Jun 22, 2022 at 7:11 PM Geert Uytterhoeven <geert@linux-m68k.org> wrote:
>
> Hi Prabhakar,
>
> On Wed, Jun 22, 2022 at 7:36 PM Lad Prabhakar
> <prabhakar.mahadev-lad.rj@bp.renesas.com> wrote:
> > Fix typo's,
> > * difference -> different
> > * alignment -> aligned
> >
> > While at it replaced 128-bytes -> 128 byte.
> >
> > Reported-by: Pavel Machek <pavel@denx.de>
> > Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
>
> Thanks for your patch!
>
> Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
>
> > --- a/drivers/mmc/host/renesas_sdhi_internal_dmac.c
> > +++ b/drivers/mmc/host/renesas_sdhi_internal_dmac.c
> > @@ -355,7 +355,7 @@ renesas_sdhi_internal_dmac_map(struct tmio_mmc_host *host,
> >
> >         data->host_cookie = cookie;
> >
> > -       /* This DMAC cannot handle if buffer is not 128-bytes alignment */
> > +       /* This DMAC cannot handle if buffer is not 128 byte aligned */
>
> 128-byte? ;-)
>
In the previous version of the patch Wolfram never came back on your
reply, so I went with 128 byte instead.

Cheers,
Prabhakar
