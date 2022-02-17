Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 562624B9C4B
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Feb 2022 10:43:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238789AbiBQJmF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Feb 2022 04:42:05 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:47264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230252AbiBQJl6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Feb 2022 04:41:58 -0500
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [46.235.227.227])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6BAD71274B;
        Thu, 17 Feb 2022 01:41:44 -0800 (PST)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: kholk11)
        with ESMTPSA id D81271F45873
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1645090903;
        bh=5gCnKVu2EnKN4MXtv85oi3T/aFkCocbc2QoSdjZi18E=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=iiXg+ttcnnw2yTaOFrDGoP8ZOg6sWslKxid6RC05HtUQkhEdocLjVucycg1cu1c4l
         wqaullkVBxeTlmRnfG9tXGbnDsgNE3lJ6nZ4nHNyQlO/0VLmQI05Tustwafd+xlX7n
         nwL0W3GZ2feSUiuaLpUKDRxpCAGUQ14vQ2maj+lt5EAMu0cp/+2yuj282daIA0BTyV
         eDbmQSFKvHm/Xvd3hRRHIToKeNKtcvsXD1LSiXva96YoBMnGGFfeO5MV4ELXQeP1iJ
         /VSHQatzRNGizbrTxEY4P55mHM8MXHyl10UNho2FU5qKMVNECdNaXCnoZ4UDMnsh7+
         3PcSd49Elj6FA==
Message-ID: <267c115a-1033-ba71-8d68-af8acd5b85e7@collabora.com>
Date:   Thu, 17 Feb 2022 10:41:39 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.1
Subject: Re: [v6 2/3] dt-bindings: mediatek: Add mediatek, mt8183-jpgenc
 compatible
Content-Language: en-US
To:     Hsin-Yi Wang <hsinyi@chromium.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Rob Herring <robh+dt@kernel.org>, linux-media@vger.kernel.org
Cc:     linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        yong.wu@mediatek.com
References: <20211206130425.184420-1-hsinyi@chromium.org>
 <20211206130425.184420-2-hsinyi@chromium.org>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20211206130425.184420-2-hsinyi@chromium.org>
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

Il 06/12/21 14:04, Hsin-Yi Wang ha scritto:
> Add mediatek,mt8183-jpgenc compatible to binding document.
> 
> Signed-off-by: Hsin-Yi Wang <hsinyi@chromium.org>
> Reviewed-by: Matthias Brugger <matthias.bgg@gmail.com>
> Reviewed-by: Rob Herring <robh@kernel.org>

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>


