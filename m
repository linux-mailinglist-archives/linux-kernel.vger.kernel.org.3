Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EDBB251A01B
	for <lists+linux-kernel@lfdr.de>; Wed,  4 May 2022 14:57:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350115AbiEDNBO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 May 2022 09:01:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235988AbiEDNBK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 May 2022 09:01:10 -0400
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CBBE13BA50;
        Wed,  4 May 2022 05:57:34 -0700 (PDT)
Received: by mail-wr1-x435.google.com with SMTP id u3so1920051wrg.3;
        Wed, 04 May 2022 05:57:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:subject:to:cc:message-id:in-reply-to:references
         :mime-version;
        bh=kZZv9mgu5CwmRiMWt33fgzODsP/Bo5LczhPKHEYKI2g=;
        b=P8vaQY9TUngwqCpijFd2d4LAeqJbERfj96ozEtY4mzt2p/c1Ywp7QSOfCTgTq+FJOO
         Gbr4t70Tgv4ll5c1Q9qyQD+7wVYumYk6crLyqkNjC/HrTBPf8y2ybrG0cvsu2Ik5SRN/
         JIP5BUgHCTVfVFcWhysaVBqlUCqdySDe929u/WByEhUtpO4obfaVaYFn3OgPodqJv5M8
         sawCqySWh+/b8sbZwqH1cH7YPpXnGYwTbiE+WimD5cwoH5r5656z1snH0h6R4lvfm5X+
         u/RD95dKWlF3dInYCUqun/LQgeX0c5ledhTrLWy1Wv6DMggWNPELirWNJGplpXEX0imC
         RW6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:subject:to:cc:message-id:in-reply-to
         :references:mime-version;
        bh=kZZv9mgu5CwmRiMWt33fgzODsP/Bo5LczhPKHEYKI2g=;
        b=dSqeIUgMzWOpYh8MeLR21bxQdsYCJTXriodewfggnBXZ8sOOMEMGMo4WVZUoBcJlCC
         eSfaUWSA2Yr0L9fAShFkLJ5Il+lLymQgMo3lQiEqQyimm/uQjCkP2k5r+eGsSn95drhA
         9BiPGXov2vAD8+ANR1IEoMK90DTRSQrcyk4NAPBzOx1oGuIyAOhAldWCzkhn+U4DMrCA
         brMD6XrmIu9D6ti+z8YAKoidWABdE3KGdAsF2zzl8sAqKtwxIbpvZqax9IsR6NFhdSrS
         +Ra3pMXxX2yt5s6xT0K/8ANuqlYM5hLGaIXUbx65lnYN+M42E9i08aOAugx0MCq2ouQR
         Z1dQ==
X-Gm-Message-State: AOAM530/EGim4anPESUL5NBpiZmG6AkLL1ELRbEcbbyfB9c61wEvOzHe
        54+3CrqC/JtzlKGH6X9H9W8=
X-Google-Smtp-Source: ABdhPJyg2nw7z5umMABTaNhWVzD3nqvwRSbwwdit8bqaZZDXTjb6FZqLpoDfrj9rWMr0ZmKS70ECbw==
X-Received: by 2002:a5d:510a:0:b0:20c:4452:3161 with SMTP id s10-20020a5d510a000000b0020c44523161mr16584044wrt.31.1651669053295;
        Wed, 04 May 2022 05:57:33 -0700 (PDT)
Received: from [192.168.98.247] (185-177-124-12.hosted-by-worldstream.net. [185.177.124.12])
        by smtp.gmail.com with ESMTPSA id e13-20020adf9bcd000000b0020c5253d8basm11723098wrc.6.2022.05.04.05.57.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 May 2022 05:57:32 -0700 (PDT)
Date:   Wed, 04 May 2022 16:55:08 +0400
From:   Yassine Oudjana <yassine.oudjana@gmail.com>
Subject: Re: [PATCH 09/13] clk: mediatek: reset: Export
 mtk_register_reset_controller symbols
To:     Rex-BC Chen <rex-bc.chen@mediatek.com>
Cc:     Matthias Brugger <matthias.bgg@gmail.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Yassine Oudjana <y.oudjana@protonmail.com>,
        Chun-Jie Chen <chun-jie.chen@mediatek.com>,
        Chen-Yu Tsai <wenst@chromium.org>,
        Tinghan Shen <tinghan.shen@mediatek.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Weiyi Lu <weiyi.lu@mediatek.com>,
        Ikjoon Jang <ikjn@chromium.org>,
        Miles Chen <miles.chen@mediatek.com>,
        Sam Shih <sam.shih@mediatek.com>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-mediatek@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org
Message-Id: <WVZCBR.JP1KZVF249S43@gmail.com>
In-Reply-To: <fda797664ad3cde1143838bdf63cc587459b2c2f.camel@mediatek.com>
References: <20220504122601.335495-1-y.oudjana@protonmail.com>
        <20220504122601.335495-10-y.oudjana@protonmail.com>
        <fda797664ad3cde1143838bdf63cc587459b2c2f.camel@mediatek.com>
X-Mailer: geary/40.0
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Wed, May 4 2022 at 20:46:22 +0800, Rex-BC Chen 
<rex-bc.chen@mediatek.com> wrote:
> On Wed, 2022-05-04 at 16:25 +0400, Yassine Oudjana wrote:
>>  From: Yassine Oudjana <y.oudjana@protonmail.com>
>> 
>>  Export mtk_register_reset_controller and
>>  mtk_register_reset_controller_set_clr to support building reset
>>  drivers as modules.
>> 
>>  Signed-off-by: Yassine Oudjana <y.oudjana@protonmail.com>
>>  ---
>>   drivers/clk/mediatek/reset.c | 2 ++
>>   1 file changed, 2 insertions(+)
>> 
>>  diff --git a/drivers/clk/mediatek/reset.c
>>  b/drivers/clk/mediatek/reset.c
>>  index bcec4b89f449..6c2effe6afef 100644
>>  --- a/drivers/clk/mediatek/reset.c
>>  +++ b/drivers/clk/mediatek/reset.c
>>  @@ -129,6 +129,7 @@ void mtk_register_reset_controller(struct
>>  device_node *np,
>>   	mtk_register_reset_controller_common(np, num_regs, regofs,
>>   		&mtk_reset_ops);
>>   }
>>  +EXPORT_SYMBOL_GPL(mtk_register_reset_controller);
>> 
>>   void mtk_register_reset_controller_set_clr(struct device_node *np,
>>   	unsigned int num_regs, int regofs)
>>  @@ -136,5 +137,6 @@ void 
>> mtk_register_reset_controller_set_clr(struct
>>  device_node *np,
>>   	mtk_register_reset_controller_common(np, num_regs, regofs,
>>   		&mtk_reset_ops_set_clr);
>>   }
>>  +EXPORT_SYMBOL_GPL(mtk_register_reset_controller_set_clr);
>> 
>>   MODULE_LICENSE("GPL");
> 
> Hello Yassine,
> 
> Thanks for your patch for mediatek clk reset.
> But I have another series to cleanup mediatek clk reset drivers and
> most of my patches are reviewed.
> Please refer to
> https://patchwork.kernel.org/project/linux-mediatek/list/?series=637849

Great! In that case I'll rebase my patches onto your series and see
if anything is missing.

Thanks,
Yassine


