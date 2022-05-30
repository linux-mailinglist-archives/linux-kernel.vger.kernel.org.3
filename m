Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 167E1537A83
	for <lists+linux-kernel@lfdr.de>; Mon, 30 May 2022 14:16:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236095AbiE3MQo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 May 2022 08:16:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236055AbiE3MQl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 May 2022 08:16:41 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [46.235.227.227])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40A4BD12D;
        Mon, 30 May 2022 05:16:40 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: kholk11)
        with ESMTPSA id 629D01F42E1C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1653912999;
        bh=9qwTfu2b89QONrY5kLAoHi0RGBsgZ6ra9T4m8UTj+4g=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=FhqQPNLQBOa+iQCv/uO2pdyE7X0sTI6EoUJb6PpYPaA0ihBdc7t1ziqi0r9WF3Ve1
         y4LVDZMc6HJp9OHRRW43g2x5pNeqkAtATsH0Xu46RCsMPgbnFsG9ISm0/wRXUzvXqq
         apdNMasqdCjnB8iF3wVnz8rIlZ1vxU9Czme4ULAoKI61Zdv5vWYS2NedEwG4qh2myJ
         QGwUwCcpPuPE174fm4atpTehxqDTWvnuLAccOx1T3NdAdk+vsv0Co7iXSUmBNKFOpo
         68YGV/IR8NMBN9ld7RM2WU9sNaCv03iWcJT/EFW9C3/8NM4vyTWMjNc3xA+OGgUL4R
         bkZFGSBeYFPew==
Message-ID: <7fcf0ac6-ffab-14fb-f4ba-716a3b6ad427@collabora.com>
Date:   Mon, 30 May 2022 14:16:36 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Subject: Re: [PATCH v6 1/2] dt-bindings: interconnect: Add MediaTek CCI
 dt-bindings
Content-Language: en-US
To:     Johnson Wang <johnson.wang@mediatek.com>, cw00.choi@samsung.com,
        krzk+dt@kernel.org, robh+dt@kernel.org, kyungmin.park@samsung.com
Cc:     khilman@kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, jia-wei.chang@mediatek.com,
        Project_Global_Chrome_Upstream_Group@mediatek.com
References: <20220527110036.8810-1-johnson.wang@mediatek.com>
 <20220527110036.8810-2-johnson.wang@mediatek.com>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20220527110036.8810-2-johnson.wang@mediatek.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Il 27/05/22 13:00, Johnson Wang ha scritto:
> Add devicetree binding of MediaTek CCI on MT8183 and MT8186.
> 
> Signed-off-by: Jia-Wei Chang <jia-wei.chang@mediatek.com>
> Signed-off-by: Johnson Wang <johnson.wang@mediatek.com>
> Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> Acked-by: Chanwoo Choi <cw00.choi@samsung.com>
> Reviewed-by: Chen-Yu Tsai <wenst@chromium.org>

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>

