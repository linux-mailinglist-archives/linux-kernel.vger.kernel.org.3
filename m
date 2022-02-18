Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6CAFE4BB9AD
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Feb 2022 13:58:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235478AbiBRM5U (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Feb 2022 07:57:20 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:34388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235557AbiBRM4v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Feb 2022 07:56:51 -0500
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [46.235.227.227])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DEBE72B5234;
        Fri, 18 Feb 2022 04:56:21 -0800 (PST)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: kholk11)
        with ESMTPSA id 19A971F46910
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1645188980;
        bh=uTrs0iGpet0hB7fvu9Fq9q2SGeE6Ag+LJv9/NiWa+1o=;
        h=Date:From:Subject:To:Cc:References:In-Reply-To:From;
        b=WQsTRT8IGihAUjMC5wMtRguyPezEtkoidxgsN/MJHZYwKrcD9Ipye768N701zA6vF
         pzp+qgWCPiSCFTRfdBeDkmfv917k6Ih4+6dFDMtwbW9KnlxQ5m9E/t3/ThyvK+beGH
         jOh06U7IrqwLyChqj82/Es3ydkLssuoSor9//5HwnZeC1UgNmbfNlWrX2CMl5/05zA
         QIb7zZiW6R/4NFH4Dn3dVUAdzWV4yRQjXY+IVImQS4vuShTvR2IMYqzZG/y6K4YO2J
         eCSlqmPqxCjyWioiOJOEy4Hui+HNKDG3pt3mLEW7bfFYTSOMjc6Wh/vm5rA4kR9vOe
         wAK4eW0axprTA==
Message-ID: <870bdae1-309e-fef4-0312-e50c33abf020@collabora.com>
Date:   Fri, 18 Feb 2022 13:56:17 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.1
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Subject: Re: [PATCH v2 20/23] arm64: dts: mt8192: Add display nodes
To:     Allen-KH Cheng <allen-kh.cheng@mediatek.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        --to=Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Cc:     Project_Global_Chrome_Upstream_Group@mediatek.com,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-mediatek@lists.infradead.org,
        Chen-Yu Tsai <wenst@chromium.org>,
        Ryder Lee <ryder.lee@kernel.org>,
        =?UTF-8?B?TsOtY29sYXMgRi4gUi4gQS4gUHJhZG8=?= 
        <nfraprado@collabora.com>
References: <20220218091633.9368-1-allen-kh.cheng@mediatek.com>
 <20220218091633.9368-21-allen-kh.cheng@mediatek.com>
Content-Language: en-US
In-Reply-To: <20220218091633.9368-21-allen-kh.cheng@mediatek.com>
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

Il 18/02/22 10:16, Allen-KH Cheng ha scritto:
> Add display nodes for mt8192 SoC.
> 
> Signed-off-by: Allen-KH Cheng <allen-kh.cheng@mediatek.com>

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>

