Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DB13F4ED83D
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Mar 2022 13:09:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234947AbiCaLLf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 31 Mar 2022 07:11:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233340AbiCaLLd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Mar 2022 07:11:33 -0400
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.126.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9202C33884;
        Thu, 31 Mar 2022 04:09:46 -0700 (PDT)
Received: from mail-wm1-f47.google.com ([209.85.128.47]) by
 mrelayeu.kundenserver.de (mreue010 [213.165.67.97]) with ESMTPSA (Nemesis) id
 1MmDVA-1oHm4e41eC-00iCg9; Thu, 31 Mar 2022 13:09:45 +0200
Received: by mail-wm1-f47.google.com with SMTP id n63-20020a1c2742000000b0038d0c31db6eso1795830wmn.1;
        Thu, 31 Mar 2022 04:09:44 -0700 (PDT)
X-Gm-Message-State: AOAM530INeJhUyv5hTt1xlNCMP/TyN4P4MdYtbgp3t0YnqZOIslYlVKg
        Rl4p27tp/QYUl7zF9X660PPR6EEfdc+Xu894ZDQ=
X-Google-Smtp-Source: ABdhPJwswRRqbDwMtkp76KOHqIEK5fi1EuTDxnoFxe5vzZsgSg3vLorXuscXGtdUiF56ngc1yrWuHFdJZZOovE9Zm/8=
X-Received: by 2002:a05:600c:1e0b:b0:38c:9ac5:b486 with SMTP id
 ay11-20020a05600c1e0b00b0038c9ac5b486mr3913978wmb.71.1648718552480; Thu, 31
 Mar 2022 02:22:32 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1648714851.git.qinjian@cqplus1.com> <fe4f4c3b0c768d1cd66fb648d74fa302e86787c0.1648714851.git.qinjian@cqplus1.com>
In-Reply-To: <fe4f4c3b0c768d1cd66fb648d74fa302e86787c0.1648714851.git.qinjian@cqplus1.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Thu, 31 Mar 2022 11:22:16 +0200
X-Gmail-Original-Message-ID: <CAK8P3a0OGM4aiaE2Nfc=7XGkGwAbnB99-j3PhVUmuA1z2FWeKg@mail.gmail.com>
Message-ID: <CAK8P3a0OGM4aiaE2Nfc=7XGkGwAbnB99-j3PhVUmuA1z2FWeKg@mail.gmail.com>
Subject: Re: [PATCH v12 5/9] clk: Add Sunplus SP7021 clock driver
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
X-Provags-ID: V03:K1:EZyyEWyEMOU9SLsFVTSJz5+xXPGenqIY6YVzxSAVJPwSyeitGdv
 tP3jJeb1oqHB4ap9WCt8EMPp4V7dIAtHV7oPtiADTIOndc56vVfxwGbIDb2A/VGmJvlbUQf
 tklCGkC8EFdJmjLhWYNPCfRcGHDRBtb90pem18oEplQmb3jwqIFh91776xK+Uq+fFK6QPTU
 Ci1Gxl45DHzAkUfPj2KZw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:YkAHc5UKE0I=:yiFaEkbErLxW5htSyxiAuo
 XpVqbSp97TMKGxcdgtgjlaNMx4qu5wPIlTAPLHe4zBjFSvVWOYdCm7w+vPocf5VAH8aE0WvLN
 Ri5NOmcfzUhb5JhO8rRGWaThiI/h5IDvUptyI4Xwg5kEKALoZsqzl9acKTJsb/MeZF1WsbY0N
 PCtbqDOLUS3zKQayZt4rR/IspX9Eyqp6/fh2ZQKKlspwsMTQuI3e2CshnQTZm4TM/maMYPS30
 6BOFcJBSedTx1ilj9JO/4426nl+yanqogLgqKRTpP069EO2CxipR+fPStixazzJaK3/eA/cWn
 XYeiwiMyuP762BGbLx2/R4Bvo71C0nIgxQsC4hZ4hw93OBTyL8hFT0OQ1A3zNWyBYAsdWnqKv
 G9PTzuhyEMh4eMW42D/rkPwcBM+dxWe8QHBVoZ/zXUO5Ee/8ea7UPx0m94OkQBWw/FG2uZNFS
 hOZppkpxyHXNzsx/SlXGYH+hf64dW5pOyP83Cv8v4Amj1H0AARNgvIbqDiszfOhOK1Zx/I/5B
 15WEY7Swao4lnEldLot+wlR4HztobZk4jTRZyyxnCzlX+khGojf9wJ3trerJS6MPACE58azyW
 r5iXXgf0jf8R4RnH7q/WDRCQEpKoW1EnMiYkHmXj8n/dNePyocXenXS+MVwBPDHx9NdFHub4z
 Z6/6FIGlyHiTjNIrkZWilcuT28I0S1nuCDgNv/N+lODPwf1NO6dn7f2wZeTRTeIvGLTMK1SGO
 VuIFID5UBWY+3aaQa4fcDfEy8W3WF+HQg9XXIqSF9lpJsn3rAfeQBBGIzrkv7MgJT7gA0UNOw
 v30omITtNA52kqHi4G49kCniQVXfmfphD+pXVrFlVvkswk9mSE=
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 31, 2022 at 10:29 AM Qin Jian <qinjian@cqplus1.com> wrote:

> +static int sp_pll_enable(struct clk_hw *hw)
> +{
> +       struct sp_pll *clk = to_sp_pll(hw);
> +       unsigned long flags;
> +
> +       spin_lock_irqsave(clk->lock, flags);
> +       writel(BIT(clk->pd_bit + 16) | BIT(clk->pd_bit), clk->reg); /* power up */
> +       spin_unlock_irqrestore(clk->lock, flags);
> +
> +       return 0;
> +}
> +
> +static void sp_pll_disable(struct clk_hw *hw)
> +{
> +       struct sp_pll *clk = to_sp_pll(hw);
> +       unsigned long flags;
> +
> +       spin_lock_irqsave(clk->lock, flags);
> +       writel(BIT(clk->pd_bit + 16), clk->reg); /* power down */
> +       spin_unlock_irqrestore(clk->lock, flags);
> +}

What does the spinlock actually protect here? As writel() is posted, it
can already leak of of the lock, and the inputs would appear to be
constant.

> +       /* This memory region include multi HW regs in discontinuous order.
> +        * clk driver used some discontinuous areas in the memory region.
> +        * Using devm_platform_ioremap_resource() would conflicted with other drivers.
> +        */
> +       res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> +       sp_clk_base = devm_ioremap(dev, res->start, resource_size(res));
> +       if (!sp_clk_base)
> +               return -ENXIO;

Can you explain this comment in more detail? Generally, the 'reg' properties
of drivers should not overlap, so it is supposed to be safe to call
devm_platform_ioremap_resource() here.

We discussed this in the context of the iop driver that did have overlapping
registers with this driver, and that was incorrect. Are there any other drivers
that conflict with the clk driver?

      Arnd
