Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 752884AE249
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Feb 2022 20:33:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1386117AbiBHTdC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Feb 2022 14:33:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352499AbiBHTdB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Feb 2022 14:33:01 -0500
Received: from mail-lf1-x143.google.com (mail-lf1-x143.google.com [IPv6:2a00:1450:4864:20::143])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 688E5C0613CB;
        Tue,  8 Feb 2022 11:33:00 -0800 (PST)
Received: by mail-lf1-x143.google.com with SMTP id z19so35214171lfq.13;
        Tue, 08 Feb 2022 11:33:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=2W7DYXaGXAgPpoGJnP20s2qFgNTqr+6rJEgdlvW7zvU=;
        b=kMuwFDLTnWORZko26nLUM2LJzxS9SY1CLZqxNW0lzKCV/vmPTR3Xxlgd7np844KD7d
         PDXePM3TLBe+GmDPUt7xrACd2kmIO70YDoMm1aPRiV2ErFCVkrWWHtkzS0JpAMSI/J9F
         b1HCDX3RjvFI07siXqPUpvHwawW+3wxh6eZLpaUIBw8m6dR49x8ULFVcgPk3YjSiGD6F
         XfIR4JSlHIzWOrWZMZZTFswMUs7UMsOqFyM7CUfiKIxJ3ZGflcpYIcVXrr1luVIRPaAn
         jk/nDRueStbx9blKjvcgfJwL1Q9oLdHQ50vQFBvEklyrfbG1TFENepzWmMrwbrPexK/S
         NUKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=2W7DYXaGXAgPpoGJnP20s2qFgNTqr+6rJEgdlvW7zvU=;
        b=TcqqT+hkHtMhr57wTe9D+fA05a/Gu3JsSoE8ykHd2e7dYt1RAo9hDwZpcuU6m1w9u3
         eE5g/XU9OKMNS35utHhF2kvUFZ6hT6vUBSGyWv51FvVLu75d1fX2cOnAX6a8YgriafOn
         YoAClpu3csULrqxcZgCc7gmbJ9hT/xlmXV9lSOroBE3enfpAqJSA7JsX6RqC5Oa1iYY7
         99vmAq4/1X6SQEdX+7W3fgrZmisBHo5/baZXv7D0po3tYgNd7KLDg34HUuQTd9KFeC58
         7MIbCVWZf+13826bCPAkxK2o30HGS+5k+/RNC2vP0ZZZ/hG0Pi1AbsEISU3l1L9php7h
         9jGQ==
X-Gm-Message-State: AOAM531fq6Vqeg3tn0an9YryO+ZfdzLhlAOFzay8GqIvxZV4pjCmLl4o
        SaNhOTLbbcp9f3bPDbuNbj8=
X-Google-Smtp-Source: ABdhPJwSvHo/X4lCJo2ybTEfnU54vBadmQxXw1Ya2qxlVVCvTSRNJGNpXJNqaYUBwPhLY6F/IWv3+Q==
X-Received: by 2002:a05:6512:2302:: with SMTP id o2mr3932007lfu.159.1644348778629;
        Tue, 08 Feb 2022 11:32:58 -0800 (PST)
Received: from pc ([185.108.107.99])
        by smtp.gmail.com with ESMTPSA id f22sm484707lfm.72.2022.02.08.11.32.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Feb 2022 11:32:58 -0800 (PST)
Date:   Tue, 8 Feb 2022 22:32:52 +0300
From:   Boris Lysov <arz65xx@gmail.com>
To:     Chen-Yu Tsai <wenst@chromium.org>
Cc:     Stephen Boyd <sboyd@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Chun-Jie Chen <chun-jie.chen@mediatek.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Miles Chen <miles.chen@mediatek.com>,
        linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 00/31] clk: mediatek: Cleanups and Improvements -
 Part 1
Message-ID: <20220208223252.7f179c63@pc>
In-Reply-To: <20220208124034.414635-1-wenst@chromium.org>
References: <20220208124034.414635-1-wenst@chromium.org>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, I couldn't find a particular patch to reply to so I'm replying cover
letter to give some input on the PLL subsystem.

On Tue,  8 Feb 2022 20:40:03 +0800
Chen-Yu Tsai <wenst@chromium.org> wrote:
>  drivers/clk/mediatek/clk-pll.c                | 100 +++++-
>  drivers/clk/mediatek/clk-pll.h                |  57 ++++

In clk-pll.c there is an mtk_clk_register_pll function which at some point
executes this:

> init.ops = &mtk_pll_ops;

In my opinion there should be a possibility to define a custom mtk_pll_ops for a
given SoC instead of using a hardcoded one because not all Mediatek SoCs share
the same PLL startup/powerdown flow. For example, the existing mtk_pll_prepare
implementation won't work for the entire Mediatek Cortex-A9 SoC family (this
includes but not limited to mt6515, mt6517, mt6575, and mt6577). 

> static int mtk_pll_prepare(struct clk_hw *hw)
> {
> 	struct mtk_clk_pll *pll = to_mtk_clk_pll(hw);
> 	u32 r;
> 	u32 div_en_mask;
> 
> 	r = readl(pll->pwr_addr) | CON0_PWR_ON;
> 	writel(r, pll->pwr_addr);

This code sets a bit to 1 to start a PLL but the SoCs I mentioned above would
need to have that bit cleared (set to 0) [1] [2].

Another interesting thing in mtk_pll_prepare is
> 	udelay(20);
Is 20 ms a settle time for PLL? If yes then it would also be cool to specify an
arbitrary value easily as some PLLs have longer settle time [3] [4].

Worth noting the SoCs I mentioned aren't in mainline yet, and I think there are
more modern mainline-worthy Mediatek SoCs that might also need these changes in
the future.

Thanks.

[1] MT6577 HSPA Smartphone Application Processor Datasheet, pages 1212-1227
(*_CON0 registers).
[2] MT6515 GSM/EDGE Smartphone Application Processor Datasheet, pages
1202-1216 (*_CON0 registers).
[3] pages 1303-1306 of [1]
[4] MT6589 HSPA+ Smartphone Application Processor Datasheet, page 1344
(MDPLL1 & MDPLL2)
