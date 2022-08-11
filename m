Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DAAE458F9BB
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Aug 2022 11:07:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234904AbiHKJHZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Aug 2022 05:07:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234055AbiHKJHW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Aug 2022 05:07:22 -0400
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA64F66A70
        for <linux-kernel@vger.kernel.org>; Thu, 11 Aug 2022 02:07:20 -0700 (PDT)
Received: by mail-ej1-x62d.google.com with SMTP id dc19so32323491ejb.12
        for <linux-kernel@vger.kernel.org>; Thu, 11 Aug 2022 02:07:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc;
        bh=AMPkpS8XZ9CZD7YiSg9zmbD0TWPYAuMvL4cZq8GvvrE=;
        b=62a0C5PIahTCbPIksLIFFasCo8TkJnD0NrXBn75/X87Qr/o+/1NPhqnBEbWnu5Wcdk
         lRYIYl5fXk0Dw9eEbPB1bObIWPebpURMO/843tj5b1d96igg9QQGJREzgVkUEQBd48r1
         kxKpJKprjM5cQJlGQYHR2VbK+7+9No/cw7W3kOJZb+hNVit8SW9PG6zuwzPCxel/IOlU
         x4Lj9TjdZwOgBZJn24Ou+97ylNvzLEaRNuj+hDRyPzdMqUWlkbPsCq/VA1u/yB0TsI/s
         EbDs0yBi+n5roSPaQhaT3pbbdy0H7oramsx+uZ7R9vaKvyP1zLu85dJVZhVje0elW2YR
         HHqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc;
        bh=AMPkpS8XZ9CZD7YiSg9zmbD0TWPYAuMvL4cZq8GvvrE=;
        b=Gt9XPyYzd+phMbyjarE7/Vcx+qSDpzMw7/YLbbiFtc5iuswREhvOZZSL7pDkenyGOh
         uZTDssijoTNND+EUZR0iZNXuHQSS9j93oJfQlaH1/Vc+sEqPKwMr2bWsm+B7IcRJOHp7
         CM5B2YfFfD6FZOFXMUeFOaWU7zAf7OFUbb9sGcg4O2S3adgozcHkacFfZ3JNLDqlgGi5
         aw346xF6jfOmwGU2nVE+0RWONByT3UFQsOr5TPwNQ3vZxPLCSxh46jdIiAyjjEDhjFdr
         59uqk/MEozhgzWpQIjClZiuClYW5wuOqwwevyf9p4Jeeg72+7WDrQyXY3luzwgJhofbF
         MEuw==
X-Gm-Message-State: ACgBeo0iqpYZsxr8aFyqTOLnf4sg7rHiUusi58+ehTYrjHBbKjUdna2j
        FR5YRh5Dhk7xPeRj2uJ9Qh1tQA==
X-Google-Smtp-Source: AA6agR6FPq1KkD0ldPcxaEg0KRXTEf6/cyaUQQuox6k2VfpKYxcf47DjxelzwSrXqEQDqVxug6WiiA==
X-Received: by 2002:a17:907:763c:b0:730:c378:b860 with SMTP id jy28-20020a170907763c00b00730c378b860mr22547616ejc.97.1660208839498;
        Thu, 11 Aug 2022 02:07:19 -0700 (PDT)
Received: from blmsp ([2001:4090:a243:8036:200c:a862:4253:884])
        by smtp.gmail.com with ESMTPSA id m26-20020aa7c2da000000b0043c0fbdcd8esm8876699edp.70.2022.08.11.02.07.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Aug 2022 02:07:18 -0700 (PDT)
Date:   Thu, 11 Aug 2022 11:07:18 +0200
From:   Markus Schneider-Pargmann <msp@baylibre.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Fabien Parent <parent.f@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        Fabien Parent <fparent@baylibre.com>
Subject: Re: [PATCH v3 4/4] clk: mediatek: add driver for MT8365 SoC
Message-ID: <20220811090718.spieeqcb5ogknlfc@blmsp>
References: <20220811084433.2598575-1-msp@baylibre.com>
 <20220811084433.2598575-5-msp@baylibre.com>
 <dc7a4f78-4244-7425-a1c2-509172ec97de@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <dc7a4f78-4244-7425-a1c2-509172ec97de@linaro.org>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Krzysztof,

On Thu, Aug 11, 2022 at 11:53:19AM +0300, Krzysztof Kozlowski wrote:
> On 11/08/2022 11:44, Markus Schneider-Pargmann wrote:
> > From: Fabien Parent <fparent@baylibre.com>
> > 
> > Add clock drivers for MT8365 SoC.
> > 
> > Signed-off-by: Fabien Parent <fparent@baylibre.com>
> > Signed-off-by: Markus Schneider-Pargmann <msp@baylibre.com>
> > ---
> > 
> > Notes:
> >     Changes in v3:
> >     - Changed all Kconfig options to be tristate
> >     - Do not depend on ARM64
> >     - Fix order of frees on probe errors.
> >     - Use mtk_clk_register_gates_with_dev
> >     - Fixed null clocks
> >     - Removed clk26m_ck
> >     - Use MUX_GATE_CLR_SET_UPD instead of custom MT8365_MUX_CLR_SET_UPD
> >     - Use devm_clk_hw_register_mux for top_misc_muxes
> >     - Use devm_clk_hw_register_gate for peri_clks and top_clks
> >     - Fix checkpatch warnings
> >     - Add missing MODULE_LICENSEs in all files
> > 
> >  drivers/clk/mediatek/Kconfig                  |   50 +
> >  drivers/clk/mediatek/Makefile                 |    7 +
> >  drivers/clk/mediatek/clk-mt8365-apu.c         |   55 +
> >  drivers/clk/mediatek/clk-mt8365-cam.c         |   57 +
> >  drivers/clk/mediatek/clk-mt8365-mfg.c         |   63 +
> >  drivers/clk/mediatek/clk-mt8365-mm.c          |  112 ++
> >  drivers/clk/mediatek/clk-mt8365-vdec.c        |   63 +
> >  drivers/clk/mediatek/clk-mt8365-venc.c        |   52 +
> >  drivers/clk/mediatek/clk-mt8365.c             | 1155 +++++++++++++++++
> >  .../dt-bindings/clock/mediatek,mt8365-clk.h   |  179 ++-
> 
> No, bindings are always separate.

Of course, I screwed up my rebasing here, sorry. Fixed for v4.

Best,
Markus
