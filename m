Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4607E487906
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jan 2022 15:34:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347836AbiAGOdz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Jan 2022 09:33:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347845AbiAGOdq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jan 2022 09:33:46 -0500
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84646C061401;
        Fri,  7 Jan 2022 06:33:46 -0800 (PST)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: kholk11)
        with ESMTPSA id 70D191F4436E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1641566025;
        bh=dwxI2Zt9X3CdVPZ4YhQ/FM1Ow749UR2LLeAOwFZludY=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=Mjke4fniYh1ZBmUlRn8HVJSQa8j9OJsXcVHDy2QJclG1iDw0e1INlkq5MC9sN6Fz2
         xScuVfwSm5ZhAr3jkE1uMKbZCMmdAjTQmWE7iux43kfnKV2Mu094x9LY/jw7X+blcw
         KH04C+ptKe0AvLHPCjqpXXmVuz+cdnFMNQimzUrA+o589TZDJuw9oks9bawevnEkFi
         XOVJkpLR1wTdjv4AsBwJ/Pl5H0Kk4FnNaBJtsYgNHmA1Red7WWbAZ2sEx3/qBptnPC
         ToUzoeCg0WT7ejziVMHCTf+SKenX7MTshY7MJvWktOAoLb0NaFBd/Ednfqr/pgThpF
         LelrKJrjkZDwg==
Subject: Re: [PATCH v21 2/8] arm64: dts: mt8183: add svs device information
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
        YT Lee <yt.lee@mediatek.com>,
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
References: <20220107095200.4389-1-roger.lu@mediatek.com>
 <20220107095200.4389-3-roger.lu@mediatek.com>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Message-ID: <1d0afef1-47b2-4b36-9616-27d1df9ac113@collabora.com>
Date:   Fri, 7 Jan 2022 15:33:41 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <20220107095200.4389-3-roger.lu@mediatek.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Il 07/01/22 10:51, Roger Lu ha scritto:
> Add compitable/reg/irq/clock/efuse setting in svs node.
> 
> Signed-off-by: Roger Lu <roger.lu@mediatek.com>

Acked-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>

