Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6A2EF497BEE
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jan 2022 10:26:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233690AbiAXJ0a (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jan 2022 04:26:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233534AbiAXJ0Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jan 2022 04:26:24 -0500
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C414FC06173D;
        Mon, 24 Jan 2022 01:26:23 -0800 (PST)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: kholk11)
        with ESMTPSA id 679C51F4331D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1643016381;
        bh=QKdfQZOdmYZJNu5RLWnu+T/Ig0eAu7tkYNWvSAxrBts=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=CWLx9uGiQ9qmn3+wTYnZ8fnLYrAVsfuclNxMso2wH/ogXuiYbl/Yd5zNkXlhOg5fT
         Z6d7EreNWMpdktOBbkSCNcDzgHZusFAZrtXb1EecMAa58pv+YHUM9B3MZGpNYIkg36
         yACj2xPrGdnoe4xEow6BG+KtfT89CADGMbU+NUydmfFzv97QR15J5i1ONzZrxUAdjG
         RmLmfI2FSUz7kSJYHlZmpfuUNgJ7B5X1k68YVglOL+2zfRmNBcluqCqzKvZQw02e2m
         Lp4NqyCaIJDmD4+Bx8jmbsEKsnM6SYRx8vdH/yCfHlIB5/12LwjoeDETGF3hUDIEhq
         gPE4tIC9b4LWA==
Subject: Re: [PATCH][next] usb: xhci-mtk: Use struct_size() helper in
 create_sch_ep()
To:     "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        Mathias Nyman <mathias.nyman@intel.com>,
        Chunfeng Yun <chunfeng.yun@mediatek.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Matthias Brugger <matthias.bgg@gmail.com>
Cc:     linux-usb@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org
References: <20220120015546.GA75917@embeddedor>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Message-ID: <1e41c2fe-38b2-e7db-ec71-cab1abb708f3@collabora.com>
Date:   Mon, 24 Jan 2022 10:26:18 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <20220120015546.GA75917@embeddedor>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Il 20/01/22 02:55, Gustavo A. R. Silva ha scritto:
> Make use of the struct_size() helper instead of an open-coded version,
> in order to avoid any potential type mistakes or integer overflows that,
> in the worst scenario, could lead to heap overflows.
> 
> Also, address the following sparse warnings:
> drivers/usb/host/xhci-mtk-sch.c:265:20: warning: using sizeof on a flexible structure
> 
> Link: https://github.com/KSPP/linux/issues/160
> Link: https://github.com/KSPP/linux/issues/174
> Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
> Acked-by: Chunfeng Yun <chunfeng.yun@mediatek.com>

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>

