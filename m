Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0544E50F9C5
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Apr 2022 12:09:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348171AbiDZKLP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Apr 2022 06:11:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348424AbiDZKLD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Apr 2022 06:11:03 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B68D208594;
        Tue, 26 Apr 2022 02:34:05 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: kholk11)
        with ESMTPSA id 508501F42EA7
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1650965644;
        bh=rJV+WgKQbS9YkErAeAH4ZHj5hEyYRCA+EeCqsUmDst8=;
        h=Date:From:Subject:To:Cc:References:In-Reply-To:From;
        b=Ydb2vsaYzSHDHjT5WtuxJ73o6SZ/9ds70/2T1b3/NOYe5Ii6uMUn+e09tdZaazUnY
         13IolpGgsqAa0crJPa9+zVuGptmz6bdmP9WkO5J3aeRjHLdV2j0jcdabw2KCIuuFDO
         q4XJVC1jC1Xipu+kXdXO0SDUcAyD7gcqdnE4MAPIpnd/xE1T75NfVf7DzMpOfHWe9i
         2UK/3KBu8Xtu/4feI7SGGZWuPwBIVPsiBJeKcckVX0uGMf8I3cFy5VleYqzcD+20w6
         wg03TevLDvIxzEj+dWj6MD617WyDMuxTaKaTeJkR+Pb0zDWz+krwx0yb3Mt4OK7qVw
         bgYDCeQUcHYVg==
Message-ID: <54232342-b8a1-d7cc-fe2a-548794036da1@collabora.com>
Date:   Tue, 26 Apr 2022 11:34:00 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Subject: Re: [PATCH V3 03/17] clk: mediatek: reset: Refine and reorder
 functions in reset.c
To:     Rex-BC Chen <rex-bc.chen@mediatek.com>, mturquette@baylibre.com,
        sboyd@kernel.org, matthias.bgg@gmail.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org
Cc:     p.zabel@pengutronix.de, chun-jie.chen@mediatek.com,
        wenst@chromium.org, runyang.chen@mediatek.com,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org,
        Project_Global_Chrome_Upstream_Group@mediatek.com
References: <20220422060152.13534-1-rex-bc.chen@mediatek.com>
 <20220422060152.13534-4-rex-bc.chen@mediatek.com>
Content-Language: en-US
In-Reply-To: <20220422060152.13534-4-rex-bc.chen@mediatek.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_PASS,
        SPF_PASS,UNPARSEABLE_RELAY autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Il 22/04/22 08:01, Rex-BC Chen ha scritto:
> To make drivers more readable, we modify the indentation of the drivers
> and reorder the location of functions.
> 
> Signed-off-by: Rex-BC Chen <rex-bc.chen@mediatek.com>

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>

