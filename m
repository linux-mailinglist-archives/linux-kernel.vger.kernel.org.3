Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9B3F94A8762
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Feb 2022 16:14:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351756AbiBCPN5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Feb 2022 10:13:57 -0500
Received: from bhuna.collabora.co.uk ([46.235.227.227]:46960 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351779AbiBCPNw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Feb 2022 10:13:52 -0500
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: kholk11)
        with ESMTPSA id 8BCD81F45D8C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1643901231;
        bh=DRwHtfUXeJL5SMxS9YpwuFtjuxZGjG9oCJIGYngKhtg=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=CjPM8sjeGat4WGVSY4jbQoZJZRoxsZJQLq4pt6FmmJ4IIQc8gaa0uKCzlz5m7gh5n
         Y2B5LbSljLG0DYKRg56/2iPN+AxtN5cdUitanzNK88KKhFCkOWtzr+pUOqPbb+FdhH
         C/2L7hHdSws8U0EhubdOyOIUI+a2gnFZhAooIIL8X1BtjIBTvjt5gepqY4yeK2gzih
         Vc9jh2bRxfyhtW3rvM9Q3XGyNkYQy4+nHKCL42Kc4OSa+FAl//Zeh8EvhFvOWqOvvE
         F1mFbTrfxd9YRWucoUiXQfOqHAcirQ4EmTuP2h03M0KVk6AqdChAxNVB+m110fPo2M
         o8U1mYASq/blw==
Message-ID: <586066f9-c201-ff37-3e77-28ab3eb1c733@collabora.com>
Date:   Thu, 3 Feb 2022 16:13:48 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.1
Subject: Re: [V11,PATCH 05/19] soc: mediatek: add support for mt6873
Content-Language: en-US
To:     Dawei Chien <dawei.chien@mediatek.com>,
        Georgi Djakov <georgi.djakov@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Stephen Boyd <swboyd@chromium.org>,
        Ryan Case <ryandcase@chromium.org>
Cc:     Mark Rutland <mark.rutland@arm.com>,
        Nicolas Boichat <drinkcat@google.com>,
        devicetree@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mediatek@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org,
        Fan Chen <fan.chen@mediatek.com>,
        Arvin Wang <arvin.wang@mediatek.com>,
        James Liao <jamesjj.liao@mediatek.com>,
        Henry Chen <henryc.chen@mediatek.com>
References: <20210812085846.2628-1-dawei.chien@mediatek.com>
 <20210812085846.2628-6-dawei.chien@mediatek.com>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20210812085846.2628-6-dawei.chien@mediatek.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Il 12/08/21 10:58, Dawei Chien ha scritto:
> From: Henry Chen <henryc.chen@mediatek.com>
> 
> add support for mt6873
> 
> Signed-off-by: Henry Chen <henryc.chen@mediatek.com>

You forgot to add your Signed-off-by tag here. Even if this patch is
not yours, you're the sender, so you have to sign it.

Besides, can you please fix the title?

soc: mediatek: mtk-dvfsrc: Add support for MT6873
