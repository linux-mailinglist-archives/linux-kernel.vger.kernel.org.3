Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DAF3B5688AB
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Jul 2022 14:50:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233368AbiGFMuG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Jul 2022 08:50:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230233AbiGFMuC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jul 2022 08:50:02 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0333BB5E;
        Wed,  6 Jul 2022 05:50:01 -0700 (PDT)
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 519CC66019A9;
        Wed,  6 Jul 2022 13:49:59 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1657111799;
        bh=Lx6CLz1kr9O2ozQR9usOEE/FDQenTT+4HsaadEWYqIM=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=OMgTIWt3U+1cB9BYr+gOcyOsPqK7v8e8P/WBhNWMbDxkYH5kYMpttkvgY5+5W5nSu
         v105C1/AilNKoz3pMZRnKRHPj/fuZ6YHE9pxaV2DLodX3d9ifVJbRT0QhB/1oE1lAt
         RmmXxuAk23goJrllyrOfqZFccEOCIrrdfTyUu+9DLpCTFKne2PVrzkCs7xDyBFs5zE
         BsOevQASYsIP6JGyauvP1uTQ01Miu9hiSni2n6Oyo0OvyTgnOaIKFLvGulj8YMyYq/
         XLFC3pwezEXn9trqoX5eeEUwmLlYjVVO9k73mYvUDUoxDQQvRvxPBwkINmbrLRh5o6
         BSbqQr8aNjDxA==
Message-ID: <57367b11-f2d4-476b-b92d-16c1726316c0@collabora.com>
Date:   Wed, 6 Jul 2022 14:49:56 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH v3 RESEND 0/4] MediaTek Helio X10 MT6795 - MT6331/6332
 Regulators
Content-Language: en-US
To:     Mark Brown <broonie@kernel.org>
Cc:     lgirdwood@gmail.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, matthias.bgg@gmail.com,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
References: <20220706100912.200698-1-angelogioacchino.delregno@collabora.com>
 <YsV9IerWCoa/xtwM@sirena.org.uk>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <YsV9IerWCoa/xtwM@sirena.org.uk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Il 06/07/22 14:16, Mark Brown ha scritto:
> On Wed, Jul 06, 2022 at 12:09:08PM +0200, AngeloGioacchino Del Regno wrote:
>> In an effort to give some love to the apparently forgotten MT6795 SoC,
>> I am upstreaming more components that are necessary to support platforms
>> powered by this one apart from a simple boot to serial console.
> 
> This previously got 0day failures due to missing dependencies which
> need would need a merge with IIRC MFD, I see no reference in the cover
> letter to dependencies?

The only blocker for this series was the MFD patch, which got picked and
it's present in next-20220706 (as you suggested me to resend when things
were picked... I decided to wait until they actually landed on -next...)

https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/commit/?h=next-20220706&id=ad7f984a6aa9722443c1db9e8f72609bf06a8910

Regards,
Angelo
