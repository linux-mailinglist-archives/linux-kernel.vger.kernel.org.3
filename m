Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CFE664A3FB0
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Jan 2022 10:59:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358057AbiAaJ7f (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Jan 2022 04:59:35 -0500
Received: from bhuna.collabora.co.uk ([46.235.227.227]:57762 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1358007AbiAaJ7Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Jan 2022 04:59:25 -0500
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: kholk11)
        with ESMTPSA id D88A11F4304D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1643623164;
        bh=+hm6ZImxvBGa+HA0+ijccYU5XbKiUj9BJvCO0RBev24=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=mrObOY6JAhNU2uhmAWi5fG6Rt2KWM/8j1W+HN7v5pTEawV1ZAPXHOw7XfVhFiB/ZX
         NHrvmOpbG3NsxjYtHSi5U/0negLFEps2UHQAL97qEr8VRI7SLc4PuLB2thGq/5eLps
         zWkTCfcdq3/nZdohiMzZhz6/dLqxF67+rKsMd7y3mmJZbB4IfgBjJWD64/fO+RsxT6
         saJFZ+k21/Mpiwr2y7LmrqMvycfCfCurDXcCqpA1BM+bVFhZFkwTRo5b1MFjc7ZrTk
         Atcgl9/rkXu2DN232INqORjE7nXB44dvIA6b2FXykn4u6ahqnfe5shbCFzXhW4iahf
         Gk/Kg0UBwM+rA==
Message-ID: <6707a581-b42c-de13-c8d6-0528955d0218@collabora.com>
Date:   Mon, 31 Jan 2022 10:59:20 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.1
Subject: Re: [PATCH v2 4/4] arm64: dts: mediatek: mt8195: enable usb remote
 wakeup
Content-Language: en-US
To:     Chunfeng Yun <chunfeng.yun@mediatek.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Matthias Brugger <matthias.bgg@gmail.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Mathias Nyman <mathias.nyman@intel.com>,
        linux-usb@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Tianping Fang <tianping.fang@mediatek.com>,
        Eddie Hung <eddie.hung@mediatek.com>
References: <20220128062902.26273-1-chunfeng.yun@mediatek.com>
 <20220128062902.26273-4-chunfeng.yun@mediatek.com>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20220128062902.26273-4-chunfeng.yun@mediatek.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Il 28/01/22 07:29, Chunfeng Yun ha scritto:
> Enable USB remote wakeup of all four xHCI controllers
> 
> Signed-off-by: Chunfeng Yun <chunfeng.yun@mediatek.com>

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>

