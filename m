Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F120F489CAB
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jan 2022 16:50:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236529AbiAJPtc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jan 2022 10:49:32 -0500
Received: from bhuna.collabora.co.uk ([46.235.227.227]:38474 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236491AbiAJPt2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jan 2022 10:49:28 -0500
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: kholk11)
        with ESMTPSA id C2B1A1F431E9
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1641829767;
        bh=VXCtvDvQUrLbupuCpkEPMiaoUXD5PXNvPYcJ0sTKWMQ=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=VzF3op+mS7S1PxY9MnT9wVBOOosYJHX6QZ2LABXXZcr/ZIFsMzT7YpgbqcO7fin1v
         pJXkdh8q08GWVmXifKJJmQmU2tFzbAQQPFoJ4mIgAvGA8EzELdDOUKOdLlJmzPba2C
         uct0AYnJVClzBOURJqN2748/2gwp26UfG4E5GF3MWV/ieJhX5SxRVQPRE76EDJs4EA
         iGBUO6FOjzDvQsNgzQrvBrLZVb7GpKVQQb+7in1zluHdZY1DYzLXiqHiF9ZZu1F2V4
         ocdGGG6II4BnuSTAyKoFig3YPE2hoH8WbaNqCWcKuHL+eIZk0lHdGJg6qtVnlnio1L
         z5L2MWx0oNa1Q==
Subject: Re: [v1 15/16] clk: mediatek: Add MT8186 mdpsys clock support
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
 <20220110134416.5191-16-chun-jie.chen@mediatek.com>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Message-ID: <da97ff55-afb4-4912-5346-76c7426a64d9@collabora.com>
Date:   Mon, 10 Jan 2022 16:49:24 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <20220110134416.5191-16-chun-jie.chen@mediatek.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Il 10/01/22 14:44, Chun-Jie Chen ha scritto:
> Add MT8186 mdpsys clock controller which provides clock gate
> control in Multimedia Data Path.
> 
> Signed-off-by: Chun-Jie Chen <chun-jie.chen@mediatek.com>

Acked-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>

