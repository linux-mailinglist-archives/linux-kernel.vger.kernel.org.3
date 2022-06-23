Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 32BE15578D8
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Jun 2022 13:39:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231203AbiFWLjl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Jun 2022 07:39:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230320AbiFWLjf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jun 2022 07:39:35 -0400
Received: from mail-yw1-x1132.google.com (mail-yw1-x1132.google.com [IPv6:2607:f8b0:4864:20::1132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8686E4BFDD;
        Thu, 23 Jun 2022 04:39:34 -0700 (PDT)
Received: by mail-yw1-x1132.google.com with SMTP id 00721157ae682-317741c86fdso189200227b3.2;
        Thu, 23 Jun 2022 04:39:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
        bh=omRmebZ/oY7CY9g8zXjNwG5YUCBp0sw1aQgxBX9Qr6o=;
        b=G91znaNiWal/0ob/917Hlvp0GRpczJ17O8mxXPBbV+l1LK0LM8IMdF55uVZKuKTGFq
         +ppo+uJ3tqZoucO7I9ZseIe6QlW93gTRkrtqu7/bvIoO+026qCnhi7jbwLKAmRE0FBdr
         8fY2XcAVDliyJ5GSbEVYm9tG9sSQx0CLesvX++6VvvWzKNX6Q75sG257aEc0ic0bgMK+
         ViWE5V20XBRIRx2X37rNbWlBPmeM5WmKB3lh0gbxWcNmZu3eP03RVg+HSFyda/pHSep8
         t4rGlbJD+BYK+3jYcuK8Zd4Ayc0wiEWe8wtq9GSUWa/RB0z+8Mj2+luXiB3DgTolW/zW
         910g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to;
        bh=omRmebZ/oY7CY9g8zXjNwG5YUCBp0sw1aQgxBX9Qr6o=;
        b=HwkZ0i3z1Yd831PkOKKZ+AWgant7mj8Jlq3P25NV04Vv7rfum/fDnGNKdB8afWq9Ma
         oJRzwBjCP1pB/uQwLJGrN29coGG9MNBsi/zXDsMZOwKCLk8Ri7LK26Y2SYqacM0gBc85
         TTJmlBab6VL5hL5V9TIBGP1/5Kk2D6iW+mZGHUI34BsgkmRs+lBidESf+9B/9rlHv1Wr
         FPsbGBlg1EisJcq9JYrCDfoDzJZvArdludtgvqdAivJypT6ifDCoNuKXTdsL1wmc3/zU
         5TXo1NEFPOT+3d5HgGLmXSMn5tzQeDBAhFMByaSls9LqsqYBI65csTYo+XTn3ZTqJMNY
         +MbA==
X-Gm-Message-State: AJIora+DWN4bXJZGiEsEX76Vglfw4Lgxlla1pTplxZfQOUZOQgv3uhoo
        8yGYBS+nxgUIoXWwW6YiymdogCu7cIkwZKcK6hA=
X-Google-Smtp-Source: AGRyM1tIccF6SA0l7YfTqzWSZNqiyehUPuP5isoKUNjBxUNacNtJbPk6Af35vL1VRBh7BRCji4F8il2LX/zERRUL7b8=
X-Received: by 2002:a05:690c:58d:b0:317:dd62:f6d9 with SMTP id
 bo13-20020a05690c058d00b00317dd62f6d9mr10409900ywb.78.1655984373752; Thu, 23
 Jun 2022 04:39:33 -0700 (PDT)
MIME-Version: 1.0
References: <20220622173614.12778-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20220622173614.12778-3-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <CAMuHMdWbQ1VHH4ugQs2mamS2KGEj5AdWmNtmg=6eUJmyGRDTVw@mail.gmail.com>
 <CA+V-a8vDem8=QaSdJr5mjHC+qbGmUtTBWEsf9T8njMZMT3BGJw@mail.gmail.com> <YrNo6LLDixpZ16k/@kunai>
In-Reply-To: <YrNo6LLDixpZ16k/@kunai>
From:   "Lad, Prabhakar" <prabhakar.csengg@gmail.com>
Date:   Thu, 23 Jun 2022 12:39:07 +0100
Message-ID: <CA+V-a8tTtaX2gj7Hc0JLjZcnuQ6BJLveWEtxGuT4fsk=pRa_KQ@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] mmc: renesas_sdhi: Fix typo's
To:     Wolfram Sang <wsa+renesas@sang-engineering.com>,
        "Lad, Prabhakar" <prabhakar.csengg@gmail.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
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

Hi Wolfram,

On Wed, Jun 22, 2022 at 8:09 PM Wolfram Sang
<wsa+renesas@sang-engineering.com> wrote:
>
>
> > > > -       /* This DMAC cannot handle if buffer is not 128-bytes alignment */
> > > > +       /* This DMAC cannot handle if buffer is not 128 byte aligned */
> > >
> > > 128-byte? ;-)
> > >
> > In the previous version of the patch Wolfram never came back on your
> > reply, so I went with 128 byte instead.
>
> I hoped for a native speaker to chime in. I don't care about the '-' but
> maybe we should rephrase it to:
>
> /* This DMAC needs buffers to be 128-byte aligned */
>
> ?
Fine by me, will update and resend a v3.

Cheers,
Prabhakar
