Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 042C6554BDB
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Jun 2022 15:53:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357726AbiFVNxR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Jun 2022 09:53:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1357706AbiFVNxO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jun 2022 09:53:14 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74D07E0BE;
        Wed, 22 Jun 2022 06:53:12 -0700 (PDT)
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id B2E3766016D1;
        Wed, 22 Jun 2022 14:53:10 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1655905991;
        bh=HhcnnDq4beNtScTMb3h4VkbecdlE9lMBTPsEFrZW0n0=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=iVMNDQFf9pL9Oze0QR5fsQ5tXYq+ypFB8D+RRhc3Lo3FR90qs8PjhorqD/2KiLOW3
         bvyNIvm+QoCHQgQ2nAJf+hx5Wmqx2tSFwKtv2dmTgFxnCIVfm5nLLErkjth4Zvrfm5
         v/zvS3DNkgINyheqUXu44yoVIP4Upz9cUnjFqG9GLrZW9XIr5yeqHSX88QU9zd46to
         HaStmFNoTQBSAJDrYPvB/FeGZ8dDGprBEVPI0nUVVeiFm6C8iVEFN/f9WdaTgxV9Z6
         H4vBoisLJ3dGIH5OtDaoTPzG6e24PdsKuPe7T9h6ggN2S1/RbF6DAColJufPDJjmRs
         7HOfPnlpFjvag==
Message-ID: <b587116e-712e-07a5-cc83-457de768835b@collabora.com>
Date:   Wed, 22 Jun 2022 15:53:07 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH 0/3] leds-mt6323: Make driver flexible and cleanups
Content-Language: en-US
To:     sean.wang@mediatek.com
Cc:     pavel@ucw.cz, matthias.bgg@gmail.com, linux-leds@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        kernel@collabora.com
References: <20220516094222.30414-1-angelogioacchino.delregno@collabora.com>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20220516094222.30414-1-angelogioacchino.delregno@collabora.com>
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

Il 16/05/22 11:42, AngeloGioacchino Del Regno ha scritto:
> MT6323 is not the only PMIC that has a LEDs controller IP and it was
> found that the others do have a compatible register layout, except
> for some register offsets.
> The logic contained in this driver can be totally reused for other
> PMICs as well, so I can't see any reason to keep this specific to
> the MT6323 part.
> 
> This series brings meaningful platform data to this driver, giving
> it flexibility and making it possible and straightforward to add
> support for other (older, or newer!) PMICs.
> 
> AngeloGioacchino Del Regno (3):
>    leds: leds-mt6323: Specify registers and specs in platform data
>    leds: leds-mt6323: Open code and drop MT6323_CAL_HW_DUTY macro
>    leds: leds-mt6323: Drop MT6323_ prefix from macros and defines
> 
>   drivers/leds/leds-mt6323.c | 258 ++++++++++++++++++++++++-------------
>   1 file changed, 166 insertions(+), 92 deletions(-)
> 

Gentle ping on this series...

Thanks,
Angelo
