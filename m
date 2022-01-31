Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B13B04A4067
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Jan 2022 11:44:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358310AbiAaKok (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Jan 2022 05:44:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1358150AbiAaKog (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Jan 2022 05:44:36 -0500
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB658C061714;
        Mon, 31 Jan 2022 02:44:36 -0800 (PST)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: kholk11)
        with ESMTPSA id 33D791F4311D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1643625875;
        bh=8kwBiHu+rozMfTRk8eG2eaRsAY8jmwscyixrLHkGQZ4=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=eyB/p5HuyuwZUaLJdj2jW28sbi2CAuEJI1owJGs6WD+nZtWScfTBwOfCDsm2fAvw0
         PF2MUfVbHJTahO+mbSluTxWNCDCo59mFfBlJQiue7n85pXSPlWhgQCLMD0TY3zIQcY
         THkKQNVdBRgsPj77qZhcWMTCn/jCpOtjCUulRpV5Qm1V/eE7fVz6nDyzK2WqoWrP/0
         Oj8s8cFTTOybXRYS/CLNDbW+JtUGyZk3qBMQqaV+k8LySI2mWUKJdfu42tHsZPIEkG
         2KxhGlGmXOS+4GEJ5HIh82h62L3l9zsBiPzGAulvuPRnSZLXAlKr1/TzrpibxjjFb6
         phEgAtFz7ZApg==
Message-ID: <98696462-3648-24f7-6034-7864a3793ce4@collabora.com>
Date:   Mon, 31 Jan 2022 11:44:31 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.1
Subject: Re: [PATCH v22 4/7] soc: mediatek: SVS: add monitor mode
Content-Language: en-US
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
        Guenter Roeck <linux@roeck-us.net>
References: <20220127033956.24585-1-roger.lu@mediatek.com>
 <20220127033956.24585-5-roger.lu@mediatek.com>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20220127033956.24585-5-roger.lu@mediatek.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Il 27/01/22 04:39, Roger Lu ha scritto:
> SVS monitor mode is based on different thermal temperature
> to provide suitable SVS bank voltages.
> 
> Signed-off-by: Roger Lu <roger.lu@mediatek.com>

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>

