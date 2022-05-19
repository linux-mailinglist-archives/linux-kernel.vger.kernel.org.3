Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C047B52CE6A
	for <lists+linux-kernel@lfdr.de>; Thu, 19 May 2022 10:35:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235472AbiESIfD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 May 2022 04:35:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231893AbiESIe6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 May 2022 04:34:58 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [46.235.227.227])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6600737B7;
        Thu, 19 May 2022 01:34:56 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: kholk11)
        with ESMTPSA id 0A50E1F4579F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1652949295;
        bh=FZgvMJ0kHgvO/lRqb0qbd8VZzOHceqNAMCfwzMKqFIs=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=IM/HW1THEui3bX1ea2rHydF4flBObYJkUsRcNngJ6uqvKLR7FEOHg/AWpkM4DniMD
         dLZxrHULt08D1XrqsDVLHiUi7CogBQMCbyK8obKoIC+aj9ooOftHQlyG5IeUSAlBqt
         d3kpSdzbkERherUwK9ZtB/YOQJ8Oy6xw6Lq/zC1Lq8cuo0BXP1gjOUTJb9OvlvGthm
         nI1Vde25LBH0oeNlPuhoefjmusPgaip4mwioS4rmuC/sWCV80avwlRhmCbnNI+tCX5
         udrVEKVYC701OqE3sJg/pPWUMzXjykJxf2RNMP6QsEHY1JRuxcBV1MTjkJCX25sMZn
         tOCU5bfyLyQWg==
Message-ID: <5ff3f8b1-9521-5c7a-7b64-19f61989496c@collabora.com>
Date:   Thu, 19 May 2022 10:34:52 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Subject: Re: [PATCH v2 3/4] dt-bindings: soc: mediatek: add mt8195 svs
 dt-bindings
Content-Language: en-US
To:     Tim Chang <jia-wei.chang@mediatek.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Roger Lu <roger.lu@mediatek.com>,
        Kevin Hilman <khilman@kernel.org>
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        Project_Global_Chrome_Upstream_Group@mediatek.com,
        hsinyi@google.com
References: <20220519060924.13493-1-jia-wei.chang@mediatek.com>
 <20220519060924.13493-4-jia-wei.chang@mediatek.com>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20220519060924.13493-4-jia-wei.chang@mediatek.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Il 19/05/22 08:09, Tim Chang ha scritto:
> From: Jia-Wei Chang <jia-wei.chang@mediatek.com>
> 
> Add mt8195 svs compatible in dt-bindings.
> 
> Signed-off-by: Jia-Wei Chang <jia-wei.chang@mediatek.com>

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>


