Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 31B324A8791
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Feb 2022 16:21:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351842AbiBCPVL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Feb 2022 10:21:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236933AbiBCPVI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Feb 2022 10:21:08 -0500
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60E4EC061714;
        Thu,  3 Feb 2022 07:21:08 -0800 (PST)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: kholk11)
        with ESMTPSA id 56F011F45DD5
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1643901667;
        bh=iV1sqiQOtKFpu0HhrXC3X2rfQtdmuKUeRmBVzyqKu0I=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=J+mpjeD7bci9vv0bH96Og16BmYCzyreKPjr3Y6HPlSRJz//zz4FNDho5jeRTabd6L
         BLZAopmgAguskvL0BKTuSVCYRZKC2lw1wqbg/PVZF8Nd7kCVk3j19AahmCs/qm8r24
         TqTmRSoQbLsEPRq+9QHpjUFd+1+RO/BOanvYxMEWXOvJf6YHnBcWQ/VgGD9J4DfVZd
         o+FxTngvDtwyxhKAKeXCMD9SRM+m/RgOgd1SJkFVUdXuISgnQNNmh+zh+o5o6eBYu+
         xv2zErDYc7Fphlo3xBM+1mBf2vG4qlaVsxM1rpF7b7w2ldmxnjxYXL2ovy/uXQqFzg
         RX9uZV0Obz49g==
Message-ID: <d40ab2d8-14ec-ca7b-b182-bcd750ff24a1@collabora.com>
Date:   Thu, 3 Feb 2022 16:21:04 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.1
Subject: Re: [V11,PATCH 15/19] regulator: mediatek: add support for mt8195
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
        James Liao <jamesjj.liao@mediatek.com>
References: <20210812085846.2628-1-dawei.chien@mediatek.com>
 <20210812085846.2628-16-dawei.chien@mediatek.com>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20210812085846.2628-16-dawei.chien@mediatek.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Il 12/08/21 10:58, Dawei Chien ha scritto:
> add platform data on mt8195
> 
> Signed-off-by: Dawei Chien <dawei.chien@mediatek.com>

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
