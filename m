Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EEC9350F9BA
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Apr 2022 12:09:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348539AbiDZKLz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Apr 2022 06:11:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348521AbiDZKLH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Apr 2022 06:11:07 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25CA620BDD7;
        Tue, 26 Apr 2022 02:34:19 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: kholk11)
        with ESMTPSA id 261811F42EA8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1650965658;
        bh=tcRCODsiHa0GCjxOg9qb3gec1FUUlqIrKCXGOGU7ZjU=;
        h=Date:From:Subject:To:Cc:References:In-Reply-To:From;
        b=l8S1h1bWx9PtCiYzoXrXDfMtsZONH2SY1+FJ1e2Ayu8Dd/tZowI8gpOzFuIhVyC0h
         0HtGoFU59JMgok80/St8vahQQIlZajspvpYARimS4e1G9okckV2pOCll5nH9ukc3M6
         JmAHDxVe5ev77Xmp4QZPWcUKryRmqkgCghwOAEV0XyNGE8fUUOVaSHOiuP7T+ZIoUy
         25MIKYsvtzIj7DQHm+ZFuC5kiKqnFC1Vr2SMGpIKA7c3+7yQeekiqJTs1GweOraw/i
         v8vUzkG3LG80ZMLE+5kcT8AFt2RfULFfNzCiV1UVuXi0TDTYKjaIkLlPchOXzpr3Ds
         IF+KCL8t6rT6w==
Message-ID: <2e2f27b5-2ad9-b70a-3f2c-3bcdbd0bec72@collabora.com>
Date:   Tue, 26 Apr 2022 11:34:14 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Subject: Re: [PATCH V3 08/17] clk: mediatek: reset: Add new register reset
 function with device
To:     Rex-BC Chen <rex-bc.chen@mediatek.com>, mturquette@baylibre.com,
        sboyd@kernel.org, matthias.bgg@gmail.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org
Cc:     p.zabel@pengutronix.de, chun-jie.chen@mediatek.com,
        wenst@chromium.org, runyang.chen@mediatek.com,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org,
        Project_Global_Chrome_Upstream_Group@mediatek.com
References: <20220422060152.13534-1-rex-bc.chen@mediatek.com>
 <20220422060152.13534-9-rex-bc.chen@mediatek.com>
Content-Language: en-US
In-Reply-To: <20220422060152.13534-9-rex-bc.chen@mediatek.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_PASS,
        SPF_PASS,UNPARSEABLE_RELAY autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Il 22/04/22 08:01, Rex-BC Chen ha scritto:
> It's a proper implementation using device to register reset controller.
> Howerver, some clock drviers of MediaTeks only provide device_node.
> Therefore, we still remain register reset function with device_node and
> add a function with device to register reset controller.
> 
> Signed-off-by: Rex-BC Chen <rex-bc.chen@mediatek.com>

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>

