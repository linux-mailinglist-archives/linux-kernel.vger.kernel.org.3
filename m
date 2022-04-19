Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3F91D506B71
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Apr 2022 13:50:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351933AbiDSLxC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Apr 2022 07:53:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351917AbiDSLwf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Apr 2022 07:52:35 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [46.235.227.227])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6FFCD1ADA5;
        Tue, 19 Apr 2022 04:49:53 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: kholk11)
        with ESMTPSA id 0A8C71F42295
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1650368991;
        bh=Pi7GPCmSvHdvR1Ecs53jheIVCw4lXdkX58W3D+whacM=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=ac5VlRksWcTJyr755h6mA9syvqZNifNIe88McjmaqzoZuT+dnL7nPx4We/fmgK9lL
         1KnGmgolPgLqN8VFxqsgd8Q0xXQ8td7NJUP5JxKkXg5F+2Zbf8bnzWBXYG1hwJZaqQ
         HUOsdCFS7klx/ip9rUV7IRxygaCBFeaT94rJpmi0JavW6ufQ67WPN0RNkqwLQonDv0
         maETNGQHZRySuiOjgNbpeE0xeujfaZIZDMphlddPQHikUDzdXOtmVQ6yB5H3abJVX3
         CwGOdW0PPgvxkdbv64IdxEz+KElMTKXO1/ac7hCPY/Z+gk00E6QMNJX078nBLQONN3
         19A2DAiX/Np6g==
Message-ID: <aa952c27-0ea3-19ac-3fee-eff48b920985@collabora.com>
Date:   Tue, 19 Apr 2022 13:49:49 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH v2 1/2] dt-bindings: remoteproc: mediatek: add
 firmware-name property
Content-Language: en-US
To:     Allen-KH Cheng <allen-kh.cheng@mediatek.com>,
        Ohad Ben-Cohen <ohad@wizery.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>
Cc:     Hsin-Yi Wang <hsinyi@chromium.org>,
        Project_Global_Chrome_Upstream_Group@mediatek.com,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-mediatek@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org,
        linux-remoteproc@vger.kernel.org
References: <20220414122140.6114-1-allen-kh.cheng@mediatek.com>
 <20220414122140.6114-2-allen-kh.cheng@mediatek.com>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20220414122140.6114-2-allen-kh.cheng@mediatek.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Il 14/04/22 14:21, Allen-KH Cheng ha scritto:
> The SCP needs firmware which differs between other platforms and SoCs.
> Add a new property "firmware-name" to allow the DT to specify the
> platform/board specific path to this firmware file.
> 
> Signed-off-by: Allen-KH Cheng <allen-kh.cheng@mediatek.com>

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>

