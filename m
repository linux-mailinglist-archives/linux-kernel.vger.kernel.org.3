Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 226724A878E
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Feb 2022 16:20:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232561AbiBCPTM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Feb 2022 10:19:12 -0500
Received: from bhuna.collabora.co.uk ([46.235.227.227]:47088 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351785AbiBCPTG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Feb 2022 10:19:06 -0500
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: kholk11)
        with ESMTPSA id 308241F45DD5
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1643901545;
        bh=fLoPv0+RiVmvVfeppxoTLboNJ5Eskh8vvQVvN5nnJR0=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=KRVIbEfFUKJJdKx9V5+0wGDSbA0fv0PEFKVp+6C3qiVO2kSkS7N2AesEajTENzr+M
         i9k3o+t29Ac7/0Nlv0tWwbWgjHBg+rkcXeFWTgw7hdS6TXrpcwuNJlt1qw95HQpetO
         Rr+y8UXWOIcBq9KEPLIjo9x6taMd4HBe9uAbCuluZJiX/VeMpzin0exBFqvmHd2juv
         jsKLeA8AwtALLmfaB6KHNL5UmvoxTBCGmqQIQTAo9jJstpTHfuSf+NnQQqKHZf07bn
         O73C61N5yEkq7kjlytno74GKt7q0rg+EAZKKJmr2RE9MV0Q+bXyKNthV/HhZhzqspk
         EiaorkfIsWMbw==
Message-ID: <abf785dd-c1d8-b433-f280-3c42043e4684@collabora.com>
Date:   Thu, 3 Feb 2022 16:19:01 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.1
Subject: Re: [V11, PATCH 12/19] interconnect: mediatek: Add interconnect
 provider driver
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
 <20210812085846.2628-13-dawei.chien@mediatek.com>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20210812085846.2628-13-dawei.chien@mediatek.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Il 12/08/21 10:58, Dawei Chien ha scritto:
> From: Henry Chen <henryc.chen@mediatek.com>
> 
> Introduce Mediatek MT6873/MT8183/MT8192 specific provider driver
> using the interconnect framework.
> 
>               ICC provider         ICC Nodes
>                                ----          ----
>               ---------       |CPU |   |--- |VPU |
>      -----   |         |-----  ----    |     ----
>     |DRAM |--|DRAM     |       ----    |     ----
>     |     |--|scheduler|----- |GPU |   |--- |DISP|
>     |     |--|(EMI)    |       ----    |     ----
>     |     |--|         |       -----   |     ----
>      -----   |         |----- |MMSYS|--|--- |VDEC|
>               ---------        -----   |     ----
>                 /|\                    |     ----
>                  |change DRAM freq     |--- |VENC|
>               ----------               |     ----
>              |  DVFSR   |              |
>              |          |              |     ----
>               ----------               |--- |IMG |
>                                        |     ----
>                                        |     ----
>                                        |--- |CAM |
>                                              ----
> Signed-off-by: Henry Chen <henryc.chen@mediatek.com>
> Reviewed-by: Georgi Djakov <georgi.djakov@linaro.org>

This patch deserves my Reviewed-by tag, but I cannot release that if the
driver is not properly signed-off.
