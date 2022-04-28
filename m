Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9E3CB513586
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Apr 2022 15:44:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347595AbiD1NsI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Apr 2022 09:48:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233789AbiD1NsH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Apr 2022 09:48:07 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [46.235.227.227])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9262E5C77F;
        Thu, 28 Apr 2022 06:44:52 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: kholk11)
        with ESMTPSA id 893481F41A71
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1651153491;
        bh=fB7oaBnDq+Pk5dXIeNanIcPDn8WmB6Fwxu0ws9sHRSw=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=bjk4ghRjSBpf6pJdMGDZ4L3zRpEu7fxmpsiGi/WkeVIKRmw0oXu9LqxJ+5m3PNbEX
         8OdUYcQS9It+X/1TWAfhbqOXW2GDc74Ho3ORZRDV8q1HXc569ha05VY16TrSure/z5
         QrOnPcgAopTzm0KtdcfihZkCFIP5naB6EPxEDCEnsvO+tCJrwTK2saalGKNwVFZyJO
         7jrc+86cJ8grY3sRo10M2pJhKBWhqnJuyvFsniZonUHg8W2IHXRhPbTF+Lukddg82L
         mfbX2QdmbnjMkNwm+YE0hUClWM38It1b5rz4RM64K1+PFw8l7SNyK9L923C12lz5Bo
         lIhNawWmyMVaA==
Message-ID: <28fcda49-5f4e-508c-26cd-b30dc5837e9e@collabora.com>
Date:   Thu, 28 Apr 2022 15:44:47 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH V5 16/16] arm64: dts: mediatek: Add infra #reset-cells
 property for MT8195
Content-Language: en-US
To:     Rex-BC Chen <rex-bc.chen@mediatek.com>, mturquette@baylibre.com,
        sboyd@kernel.org, matthias.bgg@gmail.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org
Cc:     p.zabel@pengutronix.de, chun-jie.chen@mediatek.com,
        wenst@chromium.org, runyang.chen@mediatek.com,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org,
        Project_Global_Chrome_Upstream_Group@mediatek.com
References: <20220428115620.13512-1-rex-bc.chen@mediatek.com>
 <20220428115620.13512-17-rex-bc.chen@mediatek.com>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20220428115620.13512-17-rex-bc.chen@mediatek.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_PASS,
        SPF_PASS,UNPARSEABLE_RELAY autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Il 28/04/22 13:56, Rex-BC Chen ha scritto:
> We will use mediatek clock reset as infracfg_ao reset instead of
> ti-syscon. To support this, remove property of ti reset and add
> property of #reset-cells for mediatek clock reset.
> 
> Fixes: 4c78814a1f46ac0 (arm64: dts: Add mediatek SoC mt8195 and evaluation board)
> Signed-off-by: Rex-BC Chen <rex-bc.chen@mediatek.com>

Please remove the Fixes tag: the reset commits are not going to be backported, so
this commit also shall not be backported.

After the removal:

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>

