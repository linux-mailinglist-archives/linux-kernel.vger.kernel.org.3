Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1ACB94A3F97
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Jan 2022 10:57:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244333AbiAaJ5z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Jan 2022 04:57:55 -0500
Received: from bhuna.collabora.co.uk ([46.235.227.227]:57744 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242276AbiAaJ5x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Jan 2022 04:57:53 -0500
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: kholk11)
        with ESMTPSA id E429F1F42EBB
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1643623071;
        bh=EEi29dsWai5AtPWSIO5AT3qqVcaOhrIJ5p08/cthRIQ=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=BaVHoXjRJWFx7OC5C42/hLgEuAvv+qcmn2tFaG1/BDyCT6qZFgUIBicbgzhNXKXMR
         HvQzs2GUzlYTDPXmDYyBjvLBIeuCVW5lhF9dbHfuX5nYNPU2gavZ6WhKXxZARlGThN
         Vvfo7obqK3vipniGOOiTV7cKBgOr1hNCY7QT+QUc9B5SUYooMPoMAeQkYkdGADMJOb
         eXKqbSioyGQ/WeuW6ii71EiQr3yjicqgj1IQ2+QsFOKw5Wfsf4NbCptgwVo7N/GuvG
         xIwMvcP758TRuw5jAFLBWX3ere6Dws0GQ8aHDd614QoTG5vU24VIKRLygnQmY0kX+x
         8bCZ/ndGJ7gDw==
Message-ID: <2b5e6475-97db-b6b8-363a-7b33857a436b@collabora.com>
Date:   Mon, 31 Jan 2022 10:57:48 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.1
Subject: Re: [PATCH v2 3/4] arm64: dts: mediatek: mt8195: add efuse node and
 cells
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
 <20220128062902.26273-3-chunfeng.yun@mediatek.com>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20220128062902.26273-3-chunfeng.yun@mediatek.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Il 28/01/22 07:29, Chunfeng Yun ha scritto:
> Add efuse node and cells used by t-phy to fix the bit shift issue
> 
> Signed-off-by: Chunfeng Yun <chunfeng.yun@mediatek.com>

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>

