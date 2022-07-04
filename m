Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AAFD55653C2
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Jul 2022 13:36:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233337AbiGDLgP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Jul 2022 07:36:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233401AbiGDLgH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jul 2022 07:36:07 -0400
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2906AFD29;
        Mon,  4 Jul 2022 04:36:01 -0700 (PDT)
Received: by mail-ej1-x632.google.com with SMTP id lw20so16255499ejb.4;
        Mon, 04 Jul 2022 04:36:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=0aIGlqcgCn/YTg5HHzWZ8DwAqY9DnpV3nvPZa0+ECR8=;
        b=jg/tik05NVZMTks/DSZe6tsevVMUxmFiVoIruozLWe2xuR1DzLM0w6wZSe6dTFefDm
         QQdGb1Q0adnkGKtXgIOOxXYuGIEKQB5DOT588r1A8yd6zy+AtihpV7hWAuhLfnKKBrJL
         bOh6cVlixBy/8yNwTUx9nHIvhyviRc8rPdl7NEigfk3ODnmIsrVSZu8PJcNtoTWP8ejU
         ZDnWh8cP9liIFHAU08KkCw1WFv/UT8qPvBWZVcG15YvugvSVvNDjEETJY/dSnbHbm1wO
         Dgel1Wjd219PzTlaePNQU/Z/wPHkr5GCTg6xsldWWpenFDMXKq89jMJycziiXsO1WxfM
         Ubcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=0aIGlqcgCn/YTg5HHzWZ8DwAqY9DnpV3nvPZa0+ECR8=;
        b=IWjpLtgdmY7Qo7LCTfGBvyhakJui+Qdvs9hNgqBhGvjZyrKlT18l9orGLyf+7p22dA
         RM8IleQtADmiUMkSxS8yy/nwKHdZJahK5I8p/plMXTzo4JQoTglibmTtlUi+Zy/Px0Rg
         2rAJDjrA89eqvBZ3mOSM6Ai6+GsQ3NFZH0nFnTFh9j36Fij0VDxsk+uKDD5O7peYvnJP
         VOUzNkm1HxH3irWmK3C+3SXM7bXw3z0yyURb7/H85DK8FR2pEbgiYVEiewnXEVux9uqU
         x42ZMi9TtClSKu3adt8J/aQ+yHCz6IwvYN+52LKKosfGQA0ZU466njCBOsomID5W2PlZ
         otzg==
X-Gm-Message-State: AJIora9wBTfXAGqhzKwY20wTXd+WuvvsB7HTRvcA8KCL0/vwrgHsOsvX
        HWiuVmDzxypc/WTfWy+nLre+d7XZbbIVwwIxPqM=
X-Google-Smtp-Source: AGRyM1tl31k3c5SOlRTZWyreyxtcgBnhBMYbIvLrxaq0UnwsbYCEy4jAc6rcR42c2kvcYDzPa0qi6SDI9riI4+wygUs=
X-Received: by 2002:a17:906:4985:b0:727:c6ac:5b31 with SMTP id
 p5-20020a170906498500b00727c6ac5b31mr27940905eju.501.1656934559712; Mon, 04
 Jul 2022 04:35:59 -0700 (PDT)
MIME-Version: 1.0
References: <20220703194020.78701-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20220703194020.78701-2-prabhakar.mahadev-lad.rj@bp.renesas.com> <CAMuHMdWDQYp+ub+GW8mBb=fFz9KJH5ZwxKe28cDj_0O6E0FN+w@mail.gmail.com>
In-Reply-To: <CAMuHMdWDQYp+ub+GW8mBb=fFz9KJH5ZwxKe28cDj_0O6E0FN+w@mail.gmail.com>
From:   "Lad, Prabhakar" <prabhakar.csengg@gmail.com>
Date:   Mon, 4 Jul 2022 12:35:32 +0100
Message-ID: <CA+V-a8sa1Y8OnnauAB9E_F6SnG42TThd9=e=RmGwQoSq03Sd3g@mail.gmail.com>
Subject: Re: [PATCH v7 1/5] dt-bindings: interrupt-controller: Add Renesas
 RZ/G2L Interrupt Controller
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Marc Zyngier <maz@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Biju Das <biju.das.jz@bp.renesas.com>,
        Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        Rob Herring <robh@kernel.org>
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

On Mon, Jul 4, 2022 at 9:44 AM Geert Uytterhoeven <geert@linux-m68k.org> wrote:
>
> Hi Prabhakar,
>
> On Sun, Jul 3, 2022 at 9:41 PM Lad Prabhakar <prabhakar.csengg@gmail.com> wrote:
> > Add DT bindings for the Renesas RZ/G2L Interrupt Controller.
> >
> > Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
>
> checkpatch.pl:
> WARNING: From:/Signed-off-by: email address mismatch: 'From: Lad
> Prabhakar <prabhakar.csengg@gmail.com>' != 'Signed-off-by: Lad
> Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>'
>
Ouch my bad, not sure why send-email didn't pick up the --from option.

Cheers,
Prabhakar
