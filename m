Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 05E2C4BB9B4
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Feb 2022 13:58:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232621AbiBRM5b (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Feb 2022 07:57:31 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:35496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235563AbiBRM4e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Feb 2022 07:56:34 -0500
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1DCD2B4DAA;
        Fri, 18 Feb 2022 04:56:04 -0800 (PST)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: kholk11)
        with ESMTPSA id 372E01F46910
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1645188963;
        bh=XW7+IsiJCyQvn/kGTZJ48n2E6mk8i5iYk8R0llcuSY0=;
        h=Date:From:Subject:To:Cc:References:In-Reply-To:From;
        b=koH7FGCFWaaF8QFokOmwuV3Y3jtv8pXSpz6cXv/ooDF2XHTSHGXIB9R1v2sdnpici
         axA2Rb8cbu18q/uwO1Qo9RHRPmN9Q2GKF9KSFXT2O7XPx2OmLRWuN28ft7cs21lb3z
         CfiVoAmkgaLzcXl95oDcvhzYeyG7xSpxXe3wtebfLrJAP2Z8U/7mBziDMq1/uanuHu
         OQ270UyJzOlx+Y+4Qexx14VIFH46RKTfTMdCazAAiIJogYWk9e6S6PV5OlYi/IkQ1y
         ysCC2Td5nMfJzhcBBBMkek8Oe+Ub/K7XjOcT80CGBKf2s4KFDYR8gZz8Deu1159W0t
         0mIbRYcgIBNUw==
Message-ID: <0a656d44-c9db-b32c-86f7-f1b5a80fbd30@collabora.com>
Date:   Fri, 18 Feb 2022 13:56:00 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.1
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Subject: Re: [PATCH v2 15/23] arm64: dts: mt8192: Add m4u and smi nodes
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
 <20220218091633.9368-16-allen-kh.cheng@mediatek.com>
Content-Language: en-US
In-Reply-To: <20220218091633.9368-16-allen-kh.cheng@mediatek.com>
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
> Add m4u and smi nodes for mt8192 SoC
> 
> Signed-off-by: Allen-KH Cheng <allen-kh.cheng@mediatek.com>

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>

> ---
>   arch/arm64/boot/dts/mediatek/mt8192.dtsi | 191 +++++++++++++++++++++++
>   1 file changed, 191 insertions(+)
> 
