Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4B63E530D08
	for <lists+linux-kernel@lfdr.de>; Mon, 23 May 2022 12:41:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232641AbiEWJHI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 May 2022 05:07:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232696AbiEWJGB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 May 2022 05:06:01 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [46.235.227.227])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0643E2E2;
        Mon, 23 May 2022 02:05:58 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: kholk11)
        with ESMTPSA id E49261F426EC
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1653296756;
        bh=oHX6Oa0zn9w/29wsm4kiFu/0J+uT7hELazl/urkOVls=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=ZtLnLgxN9JOdZHJx0bXUekgWwX/E90i174BSK9Gx0h8X26u45N91FSZZyupj3qoAZ
         ZTppOG2uRkrdGlz5THIUaV0Q0854xONUmU/g8wo0jqA9o1K6Gy0OpqWm1UQPSrCIWE
         NWKRVq8T7UH4n7lJmCCoA+l9Z8ZbxbMvB+M5LZPUzbFNF5gqoM9C9sYZw3k+h8lGz5
         hWeTUhhAbn5Lk2p/KbeHtjwYH0BRTw1+QbbQe3i/UojawbQP1pUUtpzX5v0D3ymk8v
         EBvcHI6D+aYhyZSClqGrmmaL6q7qoxWiH+rlcKVg2w68e/+zM6kiIM80fkdpYynPvc
         MBfrOjeuK1jVw==
Message-ID: <be340e39-ffd4-63ec-ec91-ea4f7a475650@collabora.com>
Date:   Mon, 23 May 2022 11:05:53 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Subject: Re: [PATCH v8 17/19] dt-bindings: reset: mediatek: Add infra_ao reset
 index for MT8186
Content-Language: en-US
To:     Rex-BC Chen <rex-bc.chen@mediatek.com>, mturquette@baylibre.com,
        sboyd@kernel.org, matthias.bgg@gmail.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org
Cc:     p.zabel@pengutronix.de, nfraprado@collabora.com,
        chun-jie.chen@mediatek.com, wenst@chromium.org,
        runyang.chen@mediatek.com, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org,
        Project_Global_Chrome_Upstream_Group@mediatek.com
References: <20220523060056.24396-1-rex-bc.chen@mediatek.com>
 <20220523060056.24396-18-rex-bc.chen@mediatek.com>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20220523060056.24396-18-rex-bc.chen@mediatek.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Il 23/05/22 08:00, Rex-BC Chen ha scritto:
> To support reset of infra_ao, add the index of infra_ao reset of
> thermal/svs for MT8186.
> 
> Signed-off-by: Rex-BC Chen <rex-bc.chen@mediatek.com>
> Acked-by: Rob Herring <robh@kernel.org>
> Reviewed-by: Nícolas F. R. A. Prado <nfraprado@collabora.com>
> Tested-by: Nícolas F. R. A. Prado <nfraprado@collabora.com>

Rex, sorry but you've probably misunderstood Nicolas' Tested-by... he has
tested these on MT8192, so his T-b tag is not applicable to MT8186, MT8195.

Anyway:

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>

