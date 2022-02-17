Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8E2F54B9C40
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Feb 2022 10:41:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238759AbiBQJl6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Feb 2022 04:41:58 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:47176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230252AbiBQJlz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Feb 2022 04:41:55 -0500
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [46.235.227.227])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7EF51274B;
        Thu, 17 Feb 2022 01:41:40 -0800 (PST)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: kholk11)
        with ESMTPSA id 3881D1F45872
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1645090898;
        bh=EDIdEKK6SMkldx032oK0H4yJOSkKYBHmETqLtrlrpCc=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=U0Ok2m0J+4ywDbMgEt7+gsj0pQnXax/cpyKK5DurNiUTA9VO39y1yxK1JBy7PNUYc
         Va54+5g9YQb530pPhWUCQel+shjAmEYVzefjYjfIwBdAQx3xFAxveyc9qqRYW/kM/E
         sL7PmDlHxIU4i56f53p8pMfX7CHx0TViYL/wU7k4zA2ZGrVJ6e4acFxqJfFTNkvRZO
         M/uXAl78w2I97KNYob7zFVumC6/Kb8Bvw8itjEaQ9cHxJSMOtdLuk0JfYgNhvi9JN+
         voHTH822yjlPEHafN5W9RKfgnGoDvS52s+BuMcyU+yf/jFLglP1jBNtIFjK0FX2/vn
         O/6XGlN67zcyQ==
Message-ID: <aa54361f-6a8f-a616-640a-b9a098d82cba@collabora.com>
Date:   Thu, 17 Feb 2022 10:41:35 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.1
Subject: Re: [v6 3/3] arm64: dts: mt8183: add jpeg enc node for mt8183
Content-Language: en-US
To:     Hsin-Yi Wang <hsinyi@chromium.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Rob Herring <robh+dt@kernel.org>, linux-media@vger.kernel.org
Cc:     linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        yong.wu@mediatek.com
References: <20211206130425.184420-1-hsinyi@chromium.org>
 <20211206130425.184420-3-hsinyi@chromium.org>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20211206130425.184420-3-hsinyi@chromium.org>
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
> From: Maoguang Meng <maoguang.meng@mediatek.com>
> 
> Add jpeg encoder device tree node.
> 
> Signed-off-by: Maoguang Meng <maoguang.meng@mediatek.com>
> Signed-off-by: Hsin-Yi Wang <hsinyi@chromium.org>

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>

