Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1CE3B57C588
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Jul 2022 09:50:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231150AbiGUHur (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Jul 2022 03:50:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230132AbiGUHun (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jul 2022 03:50:43 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54DDA7CB58
        for <linux-kernel@vger.kernel.org>; Thu, 21 Jul 2022 00:50:42 -0700 (PDT)
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 546D466019C1;
        Thu, 21 Jul 2022 08:50:40 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1658389840;
        bh=bIs4puJF1ypK7T97yrk9nig/lJRabP16hi59FxQjuDk=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=bOdJVSBHGriYyATXFgE9KN5QI0yyXrQRGdGkqVlP6VGahNZq+yecm7A20jbxHmzEg
         peOnOc/WRPTYNdZp7tIwSY4u8Pu8TB0xfuTgewazEUJGFKM5kNQ14qEtTT6Xo2+1fb
         1uj4ICLpnynC/GtfzhtKzCUn9XCWZW0g6LCMr2tWJIA4HEI4/g1C0tRN/rjtqd1jyr
         wPqKRdCaUDFiQxmLwcKmGwnx/9orW87NH0IKOurRecndfWK8MEIrp+8TwW2+BMxDfE
         WnYd5y5d0NFGY9rx4lmNmFiksC98ACZX7Skccqnx76fkPXw4BQsEYBda0k3Wa9g3zq
         1xRVXWD61qfUw==
Message-ID: <f0c1cbe3-3eb6-7994-eb0b-fc9c919aa1cd@collabora.com>
Date:   Thu, 21 Jul 2022 09:50:37 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v2] drm/panel-edp: Add panel entry for B120XAN01.0
Content-Language: en-US
To:     =?UTF-8?B?TsOtY29sYXMgRi4gUi4gQS4gUHJhZG8=?= 
        <nfraprado@collabora.com>, Douglas Anderson <dianders@chromium.org>
Cc:     kernel@collabora.com, Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@linux.ie>,
        Sam Ravnborg <sam@ravnborg.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
References: <20220720191158.1590833-1-nfraprado@collabora.com>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20220720191158.1590833-1-nfraprado@collabora.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Il 20/07/22 21:11, Nícolas F. R. A. Prado ha scritto:
> Add panel identification entry for the AUO B120XAN01.0 (product ID:
> 0x1062) panel.
> 
> Signed-off-by: Nícolas F. R. A. Prado <nfraprado@collabora.com>

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>

