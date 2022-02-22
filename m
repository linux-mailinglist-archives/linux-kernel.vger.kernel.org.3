Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0FABC4BF4AE
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Feb 2022 10:27:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230177AbiBVJ2H (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Feb 2022 04:28:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230169AbiBVJ2D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Feb 2022 04:28:03 -0500
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86BDC109A64;
        Tue, 22 Feb 2022 01:27:38 -0800 (PST)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: kholk11)
        with ESMTPSA id 503761F43FA5
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1645522057;
        bh=cayn+auikT0w9IULKbpp2mswVEEC/k7IazdXdcM/Ni0=;
        h=Date:From:Subject:To:Cc:References:In-Reply-To:From;
        b=Bkgsw53ODr8XaXUD17PcC5FRHbvo+Hj9oUoU7c63dJOdmDp/EnqzSGAMkk0hdiKOd
         E4xPF4Jdbd3EbB6LoB6ThzJkrRnunN5btutCoHYM6AOvroVM9f2DA7AGsBRUNSh0Hd
         VK0/S6+hUKS5DyOJQzlpsaiHqMC8iyCiJGXyuBRPaqbv5dd8WMaBdv/dSkfpQEaJAm
         b4Fg3auh6B5taY7kmlsmJHtfbXbXYYXffBzHmc6C2O1OK3b77+RDaF6R84qLa2zJTD
         F+hATlco0LtV1KUJZuAPURjFkXSRy7w8Hpgq2f6yRqL1XByhg5RxiLir1LuEx8eWgJ
         IORlWxq5oudHg==
Message-ID: <2992a565-7ec4-3714-5e78-8374f7f12d4e@collabora.com>
Date:   Tue, 22 Feb 2022 10:27:34 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.1
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Subject: Re: [PATCH v23 2/7] arm64: dts: mt8183: add svs device information
To:     Roger Lu <roger.lu@mediatek.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Enric Balletbo Serra <eballetbo@gmail.com>,
        Kevin Hilman <khilman@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Nicolas Boichat <drinkcat@google.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>
Cc:     Fan Chen <fan.chen@mediatek.com>,
        HenryC Chen <HenryC.Chen@mediatek.com>,
        Xiaoqing Liu <Xiaoqing.Liu@mediatek.com>,
        Charles Yang <Charles.Yang@mediatek.com>,
        Angus Lin <Angus.Lin@mediatek.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Nishanth Menon <nm@ti.com>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org,
        Project_Global_Chrome_Upstream_Group@mediatek.com,
        Guenter Roeck <linux@roeck-us.net>,
        Jia-wei Chang <jia-wei.chang@mediatek.com>
References: <20220221063939.14969-1-roger.lu@mediatek.com>
 <20220221063939.14969-3-roger.lu@mediatek.com>
Content-Language: en-US
In-Reply-To: <20220221063939.14969-3-roger.lu@mediatek.com>
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

Il 21/02/22 07:39, Roger Lu ha scritto:
> Add compatible/reg/irq/clock/efuse setting in svs node.
> 
> Signed-off-by: Roger Lu <roger.lu@mediatek.com>
> Acked-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>

Sorry, there was a mistake in the tag (my bad!) - I didn't mean Acked-by, but:

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>

