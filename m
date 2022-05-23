Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 74232530E04
	for <lists+linux-kernel@lfdr.de>; Mon, 23 May 2022 12:42:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233848AbiEWKFe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 May 2022 06:05:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233793AbiEWKFZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 May 2022 06:05:25 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [46.235.227.227])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A01F43ECD;
        Mon, 23 May 2022 03:05:24 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: kholk11)
        with ESMTPSA id 708351F424C1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1653300323;
        bh=hyzoYsUfBPMt2w65TtM4E/48BZdlAw/F0S4w7MVe23I=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=ibFDRrkcUQuTq/dhq7xF6dFMKOooP2nCjmq4nQveMhwVt/tBvEMtWih+xHGI+SAq+
         WHXedhOfRhOdAt9Q/e9oC9GW8B5pSgNGhIW5lUVEqv3scktOSCt2ddAfIk9hMmeTFG
         LyPGgnibzGxDR+xfXpVWykL4oYlC1LvBHZkxEraz4b6JrFNQNjA72R5QjDnSMNMq1u
         53HSwmSHRNRdln3qn65/+QPFi7oQcvwuj+Zbt7OJbk2lqvZH0o3t76YA4quB8QXUUQ
         +4vKmvPX3wjO72xocYLIbrMZ65vbfXgoOfqo0eMxvRM8tl/EoVEXLDjO3mBtgEot+2
         iq9Uc6uLJINyw==
Message-ID: <29641040-f6f1-a3c1-cad4-96911c8e38a8@collabora.com>
Date:   Mon, 23 May 2022 12:05:20 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Subject: Re: [PATCH v2 4/4] clk: mediatek: mt8183: Add clk mux notifier for
 MFG mux
Content-Language: en-US
To:     Chen-Yu Tsai <wenst@chromium.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Chun-Jie Chen <chun-jie.chen@mediatek.com>,
        Miles Chen <miles.chen@mediatek.com>,
        linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20220523085923.1430470-1-wenst@chromium.org>
 <20220523085923.1430470-5-wenst@chromium.org>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20220523085923.1430470-5-wenst@chromium.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Il 23/05/22 10:59, Chen-Yu Tsai ha scritto:
> When the MFG PLL clock, which is upstream of the MFG clock, is changed,
> the downstream clock and consumers need to be switched away from the PLL
> over to a stable clock to avoid glitches.
> 
> This is done through the use of the newly added clk mux notifier. The
> notifier is set on the mux itself instead of the upstream PLL, but in
> practice this works, as the rate change notifitcations are propogated
> throughout the sub-tree hanging off the PLL. Just before rate changes,
> the MFG mux is temporarily and transparently switched to the 26 MHz
> main crystal. After the rate change, the mux is switched back.
> 
> Signed-off-by: Chen-Yu Tsai <wenst@chromium.org>

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>

