Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4628F509BC1
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Apr 2022 11:08:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1387291AbiDUJKc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Apr 2022 05:10:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1387266AbiDUJKb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Apr 2022 05:10:31 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 141B422BDE;
        Thu, 21 Apr 2022 02:07:40 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: kholk11)
        with ESMTPSA id AB8861F45275
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1650532059;
        bh=0HWC7ec+glvIpCeURwckv2JXqZkHzdllhtNLJ63db1c=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=n27EksOKKfO70UpAqE050D5D0Kyw7zOs/Lt6uNLZ+m8P8b9/hPVG/0zgfJo8X1npi
         AluSwqObfgMJNjSrDIAT1v0rUmXiww1rp8Y+awXOTldin7il0UsbcKMdJIbDNWsSOX
         KnIIwmr7aD+Aevmp5WDyWGTFxthf2jYlhmS35VyYFkjd7HL+463rc60Rynx77Dlthe
         uhIyAtf16kLw3fnokjXw7FRj6A9gl/DGLNEQjPQ/5MzmvrbVuJSPT3hC/YeMEeBwvS
         AlGvIWrHC8tqdq5GFxujBFjrjrUSE2tPeEmknw8xKH7hNK6ka63DGh3u5urrYqyoNf
         eTwz6Whgxjtkw==
Message-ID: <e2750949-72b6-6a7c-148c-221c01eaa0e7@collabora.com>
Date:   Thu, 21 Apr 2022 11:07:36 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH V2 12/12] clk: mediatek: reset: Add infra_ao reset support
 for MT8195
Content-Language: en-US
To:     Rex-BC Chen <rex-bc.chen@mediatek.com>, mturquette@baylibre.com,
        sboyd@kernel.org
Cc:     matthias.bgg@gmail.com, p.zabel@pengutronix.de,
        chun-jie.chen@mediatek.com, wenst@chromium.org,
        runyang.chen@mediatek.com, linux-kernel@vger.kernel.org,
        allen-kh.cheng@mediatek.com, linux-clk@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org,
        Project_Global_Chrome_Upstream_Group@mediatek.com
References: <20220420130527.23200-1-rex-bc.chen@mediatek.com>
 <20220420130527.23200-13-rex-bc.chen@mediatek.com>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20220420130527.23200-13-rex-bc.chen@mediatek.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_PASS,
        SPF_PASS,UNPARSEABLE_RELAY autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Il 20/04/22 15:05, Rex-BC Chen ha scritto:
> The infra_ao reset is needed for MT8195. Therefore, we add this patch
> to support it.
> 
> Signed-off-by: Rex-BC Chen <rex-bc.chen@mediatek.com>

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>


