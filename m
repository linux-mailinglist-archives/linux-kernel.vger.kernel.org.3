Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7AE274EADA7
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Mar 2022 14:51:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234892AbiC2Mu6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Mar 2022 08:50:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234837AbiC2Mti (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Mar 2022 08:49:38 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF4B41B2;
        Tue, 29 Mar 2022 05:47:54 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: kholk11)
        with ESMTPSA id BCB281F43E07
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1648558073;
        bh=tJzMYOhX+6l/q9zZjN+QPrd8ljoj0rb7a1tgDfRrPbE=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=O8GNe3VfKg3pYdZ1I8sCYquUFd3JTXG47fVyk4/DELPOhaEyYXPaqqCMaQRum5ABL
         nLTj/0NFPa6rsIOqyIbVU0WBvKCO/ed/kSqGLCT5Dw33SMxA+BReycYTJqX4wEY7t/
         EZwqjhi2wfNLtxbPYZCew6QiDqDOIsfO/5vhk9ZQ6lGYiTKZ4pVNKuj9Y2ciqIJhuz
         t4FXcLiZ1QQmo9J0TC/B9hsLFIszOpTvq9ezpMZNaHUnoqeMiZCYw5EXZrF/IcchM9
         NCVD/dDFRANMa3ojLk4nDut1LDYowr0eIuTU+zLw3hNpbqvQCUChfDSTbU+7cWteW1
         7gmzR+I7KPV6w==
Message-ID: <97f2b11d-15c7-d28e-f7b5-e65f2f333580@collabora.com>
Date:   Tue, 29 Mar 2022 14:47:50 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH v12 1/3] dt-bindings: mmc: mtk-sd: fix yamllint error
Content-Language: en-US
To:     Tinghan Shen <tinghan.shen@mediatek.com>,
        Chaotian Jing <chaotian.jing@mediatek.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Wenbin Mei <wenbin.mei@mediatek.com>
Cc:     linux-mmc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org,
        Project_Global_Chrome_Upstream_Group@mediatek.com,
        ryder.lee@kernel.org, wenst@chromium.org, chunfeng.yun@mediatek.com
References: <20220329114540.17140-1-tinghan.shen@mediatek.com>
 <20220329114540.17140-2-tinghan.shen@mediatek.com>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20220329114540.17140-2-tinghan.shen@mediatek.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Il 29/03/22 13:45, Tinghan Shen ha scritto:
> Documentation/devicetree/bindings/mmc/mtk-sd.yaml
>    54:81     error    line too long (95 > 80 characters)  (line-length)
> 

I can't reproduce this error that you're getting... this commit is not
necessary, as the .yamllint file in the kernel allows a maximum line-length
of 110 characters.

rules:
   line-length:
     # 80 chars should be enough, but don't fail if a line is longer
     max: 110

https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/tree/Documentation/devicetree/bindings/.yamllint?h=next-20220329

Please drop this commit.

> Signed-off-by: Tinghan Shen <tinghan.shen@mediatek.com>
> ---
>   Documentation/devicetree/bindings/mmc/mtk-sd.yaml | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)
