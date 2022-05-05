Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5991651C317
	for <lists+linux-kernel@lfdr.de>; Thu,  5 May 2022 16:55:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1380910AbiEEO7P (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 May 2022 10:59:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1380862AbiEEO7F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 May 2022 10:59:05 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [46.235.227.227])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D84DC15A0D;
        Thu,  5 May 2022 07:55:19 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: kholk11)
        with ESMTPSA id A139B1F4588E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1651762518;
        bh=GSjTTKSKlxp6CGEr4r1uWboFqF4OcgikJc5WH+aZ4/g=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=SJeHf6jcioipzxnqvWHiLnb/Q1GKNNe7Torc+t3v+XGkNPVGer0XJqqww15x5s7++
         JFVRgNpIP+Uc6vgIjALYu2ncBzZ3/LQXXxXNG9/ExD/YJf0JsfQREX7Hr1X+dIbBX/
         hxuX9tcfhgKIRXdimnMVnWVT/TV9CUqZYzyX/OyUYtJHMGIMlPOHd8cgraOuI6zkut
         pkfBIvN+sFxwp0xQni6t3OwL9IsKrdKDDtqizkhc4iwPy+aFTn7X7gnL80sftX4T/o
         7wLjXssOAYv+zaDjFBuhexxy2v6rKxBgxVgu9OkgHvyWsepWCdH3Y18RcMkpajzI4c
         56GWuJLcMAA+w==
Message-ID: <977dc0eb-fb3e-85bb-43a1-929da9aef307@collabora.com>
Date:   Thu, 5 May 2022 16:55:14 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH] rtc: mt6397: check return value after calling
 platform_get_resource()
Content-Language: en-US
To:     Yang Yingliang <yangyingliang@huawei.com>,
        linux-kernel@vger.kernel.org, linux-rtc@vger.kernel.org,
        linux-mediatek@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org
Cc:     eddie.huang@mediatek.com, sean.wang@mediatek.com,
        a.zummo@towertech.it, alexandre.belloni@bootlin.com,
        lee.jones@linaro.org
References: <20220505125043.1594771-1-yangyingliang@huawei.com>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20220505125043.1594771-1-yangyingliang@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Il 05/05/22 14:50, Yang Yingliang ha scritto:
> It will cause null-ptr-deref if platform_get_resource() returns NULL,
> we need check the return value.
> 
> Fixes: fc2979118f3f ("rtc: mediatek: Add MT6397 RTC driver")
> Signed-off-by: Yang Yingliang <yangyingliang@huawei.com>

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
