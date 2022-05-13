Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8C7405267AC
	for <lists+linux-kernel@lfdr.de>; Fri, 13 May 2022 18:56:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355758AbiEMQzF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 May 2022 12:55:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1382641AbiEMQyz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 May 2022 12:54:55 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [46.235.227.227])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 344F95418F;
        Fri, 13 May 2022 09:54:54 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: kholk11)
        with ESMTPSA id 908D91F4637D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1652460892;
        bh=BPDSRJ3l6xkyIcsf0pTvPMccH18vwhA/gg5edH7HCTM=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=dc+BOYbBSlAvKsAfLKJin9vTOc+nc+UCgcZKn4Bn+P/1wzurDas09aaHUJ4GMIZ1+
         h92jFExBpnYC6OHttD5RcKqFDvCm5kXCTziM8uBZp36qtvX4sgdk5fssavim9M4T/y
         jEUCQ/XQKc/f4nf8EOjzgVwJL2nw8sM5ouLdHrSw/jLvqjaFJDMymMIUyCIhelIQ2H
         8ljXMWvJYA2eok9Ac1XzDpHkXlNW9/JxZsM5Rq0LHEK4TjtrpSg/5VxqyiCWs7EPff
         XU5LUZQDBTmlvTai16KDp0EUdI6/vI8v54+8Cj1WH43xXQjdL0w5zZd2vbA77mngS7
         xeUATyvJy78yQ==
Message-ID: <7ed1b785-389f-9730-4686-bc6b85cc8f6d@collabora.com>
Date:   Fri, 13 May 2022 18:54:49 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Subject: Re: [PATCH 0/5] MediaTek Helio X10 MT6795 - Clock drivers
Content-Language: en-US
To:     robh+dt@kernel.org
Cc:     krzysztof.kozlowski+dt@linaro.org, matthias.bgg@gmail.com,
        mturquette@baylibre.com, sboyd@kernel.org, p.zabel@pengutronix.de,
        y.oudjana@protonmail.com, jason-jh.lin@mediatek.com,
        ck.hu@mediatek.com, fparent@baylibre.com, rex-bc.chen@mediatek.com,
        tinghan.shen@mediatek.com, chun-jie.chen@mediatek.com,
        weiyi.lu@mediatek.com, ikjn@chromium.org, miles.chen@mediatek.com,
        sam.shih@mediatek.com, wenst@chromium.org,
        bgolaszewski@baylibre.com, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-clk@vger.kernel.org,
        konrad.dybcio@somainline.org, marijn.suijten@somainline.org,
        martin.botka@somainline.org, ~postmarketos/upstreaming@lists.sr.ht,
        phone-devel@vger.kernel.org, paul.bouchara@somainline.org,
        kernel@collabora.com
References: <20220513165050.500831-1-angelogioacchino.delregno@collabora.com>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20220513165050.500831-1-angelogioacchino.delregno@collabora.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Il 13/05/22 18:50, AngeloGioacchino Del Regno ha scritto:
> In an effort to give some love to the apparently forgotten MT6795 SoC,
> I am upstreaming more components that are necessary to support platforms
> powered by this one apart from a simple boot to serial console.
> 
> This (very big) series introduces system clock, multimedia clock drivers
> (including resets) for this SoC.
> 
> Tested on a MT6795 Sony Xperia M5 (codename "Holly") smartphone.
> 

I forgot to add context to the cover letter for this series, so I'm adding that
in reply to myself.

This series depends on Chen-Yu's clocks cleanup series (clk_hw) [1] *and* on
Rex-BC's MTK reset binding-cleanup series [2].

[1] https://patchwork.kernel.org/project/linux-mediatek/list/?series=640122
[2] https://patchwork.kernel.org/project/linux-mediatek/list/?series=637849

Cheers,
Angelo
