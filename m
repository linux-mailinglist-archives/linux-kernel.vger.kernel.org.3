Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BCED64DD90F
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Mar 2022 12:37:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235892AbiCRLi4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Mar 2022 07:38:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235872AbiCRLix (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Mar 2022 07:38:53 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [46.235.227.227])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E94562C541E;
        Fri, 18 Mar 2022 04:37:34 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: kholk11)
        with ESMTPSA id 1C8B91F45EB1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1647603453;
        bh=HEbHZXkfpwq3S1FcdQbuhM9tVhx8Xv8BuRA4LclJiC8=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=mNMz39O+ZMEOfKmWGkyQ1cADDZsEHAAizAz0GdccTV/RBiQmnoO2YgfPf37MYH25q
         sQjom76sRq/ZN/jWYByltJJlSIxyUDSsTWS/rtNwyOgxvL14dhbdECv/eDLdk/SyuX
         Bb21MZac9EVfUO6Hehn1FECVy/jvnyDdpx/TpNcjbmrEJPsdnTSGn3d1qKPpQ3q24X
         vBl3Yv6l5Ut4c5us56x6izl5xXu2W5e9vnFc843qtIKIVjgdpANGp7SMojmPKdIoWU
         L5AyqCP3OnDiQjfbOaVmzpuydaIvx8Jh3vb4xO+VzfjB6TAcNVqGU1MEcoMdNgH78e
         FyUXQjKimkNew==
Message-ID: <8ac7a386-049a-ccfa-6cd5-11c53c060229@collabora.com>
Date:   Fri, 18 Mar 2022 12:37:31 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.1
Subject: Re: [PATCH v2 2/2] dt-bindings: regulator: Add BUCK and LDO document
 for MT6358 and MT6366
Content-Language: en-US
To:     Johnson Wang <johnson.wang@mediatek.com>, broonie@kernel.org,
        robh+dt@kernel.org
Cc:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org,
        Project_Global_Chrome_Upstream_Group@mediatek.com
References: <20220317030402.24894-1-johnson.wang@mediatek.com>
 <20220317030402.24894-3-johnson.wang@mediatek.com>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20220317030402.24894-3-johnson.wang@mediatek.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Il 17/03/22 04:04, Johnson Wang ha scritto:
> Add buck_vcore_sshub and ldo_vsram_others_sshub
> regulators to binding document for MT6358 and MT6366.
> 
> Reviewed-by: Rob Herring <robh@kernel.org>
> Reviewed-by: Mark Brown <broonie@kernel.org>

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>

> Signed-off-by: Johnson Wang <johnson.wang@mediatek.com>
> ---
>   .../bindings/regulator/mt6358-regulator.txt   | 22 ++++++++++++++-----
>   1 file changed, 17 insertions(+), 5 deletions(-)
> 
