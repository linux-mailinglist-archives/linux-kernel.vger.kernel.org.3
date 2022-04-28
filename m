Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BBF665135AD
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Apr 2022 15:51:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233489AbiD1NxZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Apr 2022 09:53:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347699AbiD1NxW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Apr 2022 09:53:22 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41D3F39D;
        Thu, 28 Apr 2022 06:50:07 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: kholk11)
        with ESMTPSA id 970DB1F458D4
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1651153806;
        bh=p0LBmr6xOjfSOkbGUyCZlDHkH8yMb/71DA4vGV6dvEw=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=jhsMveSLZaTMEHHdlGv9JbUiTX7LDVQY+nY1zfuAUduJr/1UjuHlhzonCQ5foGjAb
         zcDz0BexZoraX/sFx/HgChOxrXaNt9xsESe2zSVB2XcJg+ZfzTFTsQRcJD2R7efzYW
         zvPPqQ2mLSHnl5QM5R5tdTxDGkc8sv4UEYzSTPvuRsF0FBo/t40kKj73JF3AkD1n63
         8Qqv7UMj02XGUJ2bYTDkCfsCA8YLSxLXLfbyZ12UcPtbZHvNNJbJUTVxqYKv9R4v5S
         scB/ftayVxqQ5E7g7QXgh35AUC058K8VR+gbo6/sZOi7IkV8nvp6S8MXveGdxwdRYU
         m9g5LTmWVEo+A==
Message-ID: <3ae5b1ea-4721-3e61-9b5f-505ab2d5f037@collabora.com>
Date:   Thu, 28 Apr 2022 15:50:02 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH] arm64: dts: mediatek: mt8183-pumpkin: fix bad thermistor
 node name
Content-Language: en-US
To:     Fabien Parent <fparent@baylibre.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Matthias Brugger <matthias.bgg@gmail.com>
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20220426164755.435372-1-fparent@baylibre.com>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20220426164755.435372-1-fparent@baylibre.com>
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

Il 26/04/22 18:47, Fabien Parent ha scritto:
> Fix the following dtbs_check error by using the correct node name:
> /home/fabo/build/linux/mt8183-pumpkin/arch/arm64/boot/dts/mediatek/mt8183-pumpkin.dtb: ntc: $nodename:0: 'ntc' does not match '^thermistor(.*)?$'
> 	From schema: /home/fabo/devel/baylibre/linux-mainline/Documentation/devicetree/bindings/hwmon/ntc-thermistor.yaml
> 
> Signed-off-by: Fabien Parent <fparent@baylibre.com>
> Reviewed-by: Mattijs Korpershoek <mkorpershoek@baylibre.com>

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>

