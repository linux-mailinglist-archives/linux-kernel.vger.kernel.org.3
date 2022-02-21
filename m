Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 20C6A4BDD5E
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Feb 2022 18:45:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378999AbiBUPU4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Feb 2022 10:20:56 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:36646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378992AbiBUPUu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Feb 2022 10:20:50 -0500
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02B061DA75;
        Mon, 21 Feb 2022 07:20:27 -0800 (PST)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: kholk11)
        with ESMTPSA id 055AA1F41EEC
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1645456820;
        bh=AEBHpU/YbpjVEE8sZ5e3auTLaK6lJUMCcaPJ3UkaE2k=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=jZecYRDSM0F1Bp2byQMHOXaZ+4j0RYg3NQ9SGon82I9nC4mXy4ZC9g3Ko3n8Ulwnq
         IxwJhIh9bAvdLEqiiq/MwLRTYK6f3sys6ayrZi32wwZvjGYx7Gg8pJ4AhcEiFkIDLS
         85PS9J+KBAk/VtY2il5I5+/0AqM74nUwR3x/NKNYUuOY354iWDvKeqLwUTrT2CxhN4
         5NZ+dbKDh2ILefofSluV6/SVfbj62+cSIFIYqX/Rzt+qjBAHFp5lNElCRl4XicKtDT
         Y352CifU41aaojSbv45BlylJVUzStY1cXPklAKqXonJKvwuIPuBpT6qWNdEzIyjRU6
         4qviYDH4uqGXw==
Message-ID: <d4e27af2-0f64-9c7f-489d-0f7dfcdd9ee5@collabora.com>
Date:   Mon, 21 Feb 2022 16:20:17 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.1
Subject: Re: [PATCH v2 09/23] arm64: dts: mt8192: Add infracfg_rst node
Content-Language: en-US
To:     "allen-kh.cheng" <allen-kh.cheng@mediatek.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        --to=Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Cc:     Project_Global_Chrome_Upstream_Group@mediatek.com,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-mediatek@lists.infradead.org,
        Chen-Yu Tsai <wenst@chromium.org>,
        Ryder Lee <ryder.lee@kernel.org>
References: <20220218091633.9368-1-allen-kh.cheng@mediatek.com>
 <20220218091633.9368-10-allen-kh.cheng@mediatek.com>
 <c84ec638-3134-fc1c-4761-7f1ec8381a39@collabora.com>
 <8a3a6167450bdd51bdff2e9b12a15522a18dd38e.camel@mediatek.com>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <8a3a6167450bdd51bdff2e9b12a15522a18dd38e.camel@mediatek.com>
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

Il 21/02/22 14:05, allen-kh.cheng ha scritto:
> On Fri, 2022-02-18 at 13:55 +0100, AngeloGioacchino Del Regno wrote:
>> Il 18/02/22 10:16, Allen-KH Cheng ha scritto:
>>> add infracfg_rst node for mt8192 SoC.
>>>
>>> Signed-off-by: Allen-KH Cheng <allen-kh.cheng@mediatek.com>
>>
>> For v3, please mention that you're adding simple-mfd to allow probing
>> the
>> ti,syscon-reset node.
>>
>> After the commit description fix:
>> Reviewed-by: AngeloGioacchino Del Regno <
>> angelogioacchino.delregno@collabora.com>
>>
> 
> Hi Angelo,
> 
> Thanks for reminding, I will update commit message.
> 
> Do I need to also change the commit title ?
> 
> Best regards,
> Allen
> 

Hi Allen,

Please update only the description; the title is fine.

Thank you,
Angelo
