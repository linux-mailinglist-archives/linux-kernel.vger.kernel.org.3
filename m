Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F0666489CA3
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jan 2022 16:50:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236581AbiAJPuH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jan 2022 10:50:07 -0500
Received: from bhuna.collabora.co.uk ([46.235.227.227]:38516 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236565AbiAJPuF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jan 2022 10:50:05 -0500
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: kholk11)
        with ESMTPSA id 695701F431F7
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1641829804;
        bh=fsorzp0YVrrY1i4AgrQYCYpKgX6zUw3DeqZ2DK8mo5M=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=mvkffmslm8NRTxtMna6MbqSux/4MirI/NC5TDkduR1Xu+VXbacK9pzEjCdXaliV3U
         JFSpP7+MDRDh+psTEbUjYpwtk5mbdeGlTtuG/z6fXfO0C02xvw9bQBSF8vKZ43GaFa
         zwIwxdDWEAojpROlxo2xKAo93G2Q5XtKYlUj3ZiovIMP4O9FtEGo/ryB4GSh7I4PN6
         ueziIWHLa74FNXdtmpHv7mwpezMPjGJKJ1TZM1qkU41NJr9bB3Pw/P+uxTTzF/2QnX
         onnrDQPUXpFJa9u8AsvijARN0OJHWp0RHuHc+QgD87EJLrkpbd4qZ24EgAgSu0s1ZP
         TVCVXE7do22hQ==
Subject: Re: [v1 10/16] clk: mediatek: Add MT8186 wpesys clock support
To:     Chun-Jie Chen <chun-jie.chen@mediatek.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Nicolas Boichat <drinkcat@chromium.org>,
        Rob Herring <robh+dt@kernel.org>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-mediatek@lists.infradead.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, srv_heupstream@mediatek.com,
        Project_Global_Chrome_Upstream_Group@mediatek.com
References: <20220110134416.5191-1-chun-jie.chen@mediatek.com>
 <20220110134416.5191-11-chun-jie.chen@mediatek.com>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Message-ID: <26f4a15b-423c-ebc4-b50a-038cfb4b42fb@collabora.com>
Date:   Mon, 10 Jan 2022 16:50:00 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <20220110134416.5191-11-chun-jie.chen@mediatek.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Il 10/01/22 14:44, Chun-Jie Chen ha scritto:
> Add MT8186 wpesys clock controllers which provide clock gate
> control in Wrapping Engine.
> 
> Signed-off-by: Chun-Jie Chen <chun-jie.chen@mediatek.com>

Acked-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>

