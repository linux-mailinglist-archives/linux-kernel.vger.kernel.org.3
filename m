Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 410BC4DD90E
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Mar 2022 12:37:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235873AbiCRLiy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Mar 2022 07:38:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235869AbiCRLiu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Mar 2022 07:38:50 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A52D2C541E;
        Fri, 18 Mar 2022 04:37:32 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: kholk11)
        with ESMTPSA id 03A6A1F420EE
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1647603451;
        bh=DUwF+4TszQDCNeDXlM+WluEPY94AYWvLFUDw8QuwfQg=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=e2oz9OXocQV79/AfrGxOzkoRbUznG1dof/wXLvHC1AfiKFDmr4MsShYDdKA9ZvB34
         vvfzVjTIiK6qrARQe+gyzQ3ZStFL3Etc7f8cWSosXcR6cGtYtF1SBAivHQ3BqIc3AN
         Gadotll2cJQyGu93vJR3WrzCcewVLamUp5NElChpNYVZvSXJQJqJbhwfCA2Vh7dZyn
         sxAiKS+NlPYiNx+yU1cu9Vl29BzqKIsUt6jw53RFU2GBXaQKkNh5UlhcUWF9VKgbJy
         OYdVq9gioWE/S8NIKPmBdHx65Z+u1pjpLeXqoh08oSMz21nxMjk0gU1of1FDfbcl8W
         I1Cyboi+vZE4Q==
Message-ID: <251d7e90-c20f-f870-85bd-97bdd55ac4e9@collabora.com>
Date:   Fri, 18 Mar 2022 12:37:28 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.1
Subject: Re: [PATCH v2 1/2] regulator: mt6366: Add support for MT6366
 regulator
Content-Language: en-US
To:     Johnson Wang <johnson.wang@mediatek.com>, broonie@kernel.org,
        robh+dt@kernel.org
Cc:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org,
        Project_Global_Chrome_Upstream_Group@mediatek.com
References: <20220317030402.24894-1-johnson.wang@mediatek.com>
 <20220317030402.24894-2-johnson.wang@mediatek.com>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20220317030402.24894-2-johnson.wang@mediatek.com>
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

Il 17/03/22 04:04, Johnson Wang ha scritto:
> The MT6366 is a regulator found on boards based on MediaTek MT8186 and
> probably other SoCs. It is a so called pmic and connects as a slave to
> SoC using SPI, wrapped inside the pmic-wrapper.
> 
> Reviewed-by: Mark Brown <broonie@kernel.org>

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>

> Signed-off-by: Johnson Wang <johnson.wang@mediatek.com>
> ---
>   drivers/regulator/mt6358-regulator.c       | 213 ++++++++++++++++++++-
>   include/linux/regulator/mt6358-regulator.h |  45 +++++
>   2 files changed, 253 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/regulator/mt6358-regulator.c b/drivers/regulator/mt6358-regulator.c
