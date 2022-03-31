Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 153804ED99C
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Mar 2022 14:26:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236082AbiCaM2J (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 31 Mar 2022 08:28:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236067AbiCaM2H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Mar 2022 08:28:07 -0400
Received: from mout.kundenserver.de (mout.kundenserver.de [217.72.192.74])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DCFCC1FB501;
        Thu, 31 Mar 2022 05:26:19 -0700 (PDT)
Received: from mail-lf1-f52.google.com ([209.85.167.52]) by
 mrelayeu.kundenserver.de (mreue109 [213.165.67.113]) with ESMTPSA (Nemesis)
 id 1MDQqe-1niBKu0xwk-00AV1U; Thu, 31 Mar 2022 14:26:18 +0200
Received: by mail-lf1-f52.google.com with SMTP id bq24so25242005lfb.5;
        Thu, 31 Mar 2022 05:26:18 -0700 (PDT)
X-Gm-Message-State: AOAM532qX2LJYis2VusYBT65BraBE55hFs19J0CtMtPMsrbcanJj/r5w
        x5yOrlCC9txH6J6xKDtrtq3aqAyJhu8Qz8nA+Jk=
X-Google-Smtp-Source: ABdhPJxblHzN8A8TvuiEkXNzMUEBbbuh2/h0a120rBFukLWeh1t2dCBmStJdCyrkTUm6pSHNZoOJL8soa/bMgZk8Rj4=
X-Received: by 2002:a5d:6505:0:b0:205:9a98:e184 with SMTP id
 x5-20020a5d6505000000b002059a98e184mr3195582wru.317.1648718240005; Thu, 31
 Mar 2022 02:17:20 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1648714851.git.qinjian@cqplus1.com> <c75df921c121c047d48a34de29cd18cf9a631d01.1648714851.git.qinjian@cqplus1.com>
In-Reply-To: <c75df921c121c047d48a34de29cd18cf9a631d01.1648714851.git.qinjian@cqplus1.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Thu, 31 Mar 2022 11:17:04 +0200
X-Gmail-Original-Message-ID: <CAK8P3a16M3nv+TQWsC-0Pr5M2vcTttC2WWTzctMBaqdODMFX-A@mail.gmail.com>
Message-ID: <CAK8P3a16M3nv+TQWsC-0Pr5M2vcTttC2WWTzctMBaqdODMFX-A@mail.gmail.com>
Subject: Re: [PATCH v12 7/9] irqchip: Add Sunplus SP7021 interrupt controller driver
To:     Qin Jian <qinjian@cqplus1.com>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Rob Herring <robh+dt@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <maz@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Russell King - ARM Linux <linux@armlinux.org.uk>,
        Arnd Bergmann <arnd@arndb.de>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        DTML <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-clk <linux-clk@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:9WfqbbizZrl6Bo03VzQB2usOo4kvLoR3iOej7IjwfhgAKCtgtdM
 q4E9I2PiQ56zhYMleHff2yCybxmJAWRVUCPmuiNaWc1T6sMlyMkG4j2NTST6jI3WE8uzGWk
 A14klJ0ofAURFE6aPFqX8CtTxqm88j3PXwVjVlt6ANiFVcFTpB5S/H8Sd+sUz4CUCbszqov
 7QRlTKkzs7egNJeGubjpA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:Ob6Y+w0dN6Q=:YsXZB2hvGiJqOsDtl1NhYy
 Dc4iyFsfML8dzyVhswNe4diF5jLkz8C9aUopCk/m9tjDomD76k4/bHFm9u53BKYEOJl/SJNhR
 uKw41aOzFOtG96mBFaq01ZkXHk7mQovv1pdGlvnrRbiM25W5AIVfz3WSNYYM/FvuVyYBgyB3u
 3qBIfDLYwNrhRtYtazKfJy9OnkT139kAXxRfm4994sIWGEq+YIUc8p9U2OCX2+gvsXD4tGFiN
 u44Pmf6MB8JSd2zSszLc1pV8wCtOb5IjPwyf4ulaufGHXFJeLv6K9vPq7XrZEX0F+IZ/DQlPE
 DCo2RnpR/Imfrsg1slMPccwtV/KA0QuG+c0i1hzcpoe4j9yZ5x36OOXx/zkok8GdfN8mstfxg
 ZclYN8EvKDwsVXND0JHgw84Xh0QwTA0IOV4vrzkqEN3GY5xLAPdJfpZ8Yihqz8yrL5NXlCNpX
 WzMIsS3i0gK/APi4IfxPK7635jIiujzPOTVDVSsPYsr3QTJ8+5VzCbGfPOsDN5xKkRFWNtD0+
 un3HquhO7NSVf4rxQ8iFfOJCWxWb0yxPE/3HcCbwmW94hItiNjmm/PaChTjyh4DnS100K3I4T
 tktjPtbVUwKgnvPo+m3HsfUXulM8vlMr2vQYI641MY+iGsIy/k77fwbkn0iMQUj6Q1+H1rgSz
 Bzryj8IjHtzGO1QdfuAtVYs5pStRlQVUpxg4nPIBnJ2vrCsndKK/d7Ol7TZBiWDXjHdg=
X-Spam-Status: No, score=-0.3 required=5.0 tests=BAYES_00,DATE_IN_PAST_03_06,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 31, 2022 at 10:29 AM Qin Jian <qinjian@cqplus1.com> wrote:

> +#ifdef CONFIG_SMP
> +static int sp_intc_set_affinity(struct irq_data *d, const struct cpumask *mask, bool force)
> +{
> +       return -EINVAL;
> +}
> +#endif
> +
> +static struct irq_chip sp_intc_chip = {
> +       .name = "sp_intc",
> +       .irq_ack = sp_intc_ack_irq,
> +       .irq_mask = sp_intc_mask_irq,
> +       .irq_unmask = sp_intc_unmask_irq,
> +       .irq_set_type = sp_intc_set_type,
> +#ifdef CONFIG_SMP
> +       .irq_set_affinity = sp_intc_set_affinity,
> +#endif
> +};

I don't think you need to define an irq_set_affinity() callback at all if you
just return -EINVAL, all the callers should have a check already. Even
if you do need the function, I think you can remove the #ifdef, as long
as the function itself can be built that way.

      Arnd
