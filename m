Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 461EB5959D3
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Aug 2022 13:22:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233831AbiHPLWY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Aug 2022 07:22:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234437AbiHPLV7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Aug 2022 07:21:59 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1FC19F745;
        Tue, 16 Aug 2022 02:49:18 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 762FA612C5;
        Tue, 16 Aug 2022 09:49:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 89368C433C1;
        Tue, 16 Aug 2022 09:49:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1660643357;
        bh=qhlPUMRzP1URLEWjxdv/4RbjfeJ6EtQ6TbWVy0D1eBw=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=DQyUs0peFY8Ww+zsM3kmgA0sfw8rYI3y4bZOcrDwW4QJhrHJGMS+U7r+Bm4qHX9Wk
         g2kwaozRfUtk1Ug+fx+Y/Q6C4gkVNoisU11JxR9nUjgnMs73AqIGCn5jQIgPjJJjix
         rW/HpebVCkSKF429FQOBVFOxJtlTktzc65JowSu9/lfjEJm+ivdfO5bWTCe0YxDV2y
         01wO206j0+eRT3F93KdYc/pE3JpNWmhRPkPON3qiBtcRRmY++qNoKHWBSlzk3hyZw2
         vxF3g0nTAI1ZEmzOZ9qkFJY2+FnJW5EJcaKDWNY6gxzNJgeV8VhkPo8BfrbBQ44Gm8
         C7tJv0v5FlVlg==
Message-ID: <0b17f336-5c04-e375-ef4a-3804f9702bf8@kernel.org>
Date:   Tue, 16 Aug 2022 12:49:11 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Subject: Re: [PATCH v2 1/3] dt-bindings: watchdog: Add compatible for MediaTek
 MT8188
Content-Language: en-US
To:     Runyang Chen <Runyang.Chen@mediatek.com>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Rob Herring <robh+dt@kernel.org>, nfraprado@collabora.com
Cc:     angelogioacchino.delregno@collabora.com,
        Project_Global_Chrome_Upstream_Group@mediatek.com,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-mediatek@lists.infradead.org
References: <20220816065330.27570-1-Runyang.Chen@mediatek.com>
 <20220816065330.27570-2-Runyang.Chen@mediatek.com>
From:   Krzysztof Kozlowski <krzk@kernel.org>
In-Reply-To: <20220816065330.27570-2-Runyang.Chen@mediatek.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 16/08/2022 09:53, Runyang Chen wrote:
> From: Runyang Chen <runyang.chen@mediatek.com>
> 
> Add dt-binding documentation of watchdog for MediaTek MT8188 Soc
> 


Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>


Best regards,
Krzysztof
