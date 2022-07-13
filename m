Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2D5355730CD
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Jul 2022 10:20:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235497AbiGMIUi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Jul 2022 04:20:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235379AbiGMIUR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jul 2022 04:20:17 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3201ED160
        for <linux-kernel@vger.kernel.org>; Wed, 13 Jul 2022 01:16:20 -0700 (PDT)
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 109F06601A33;
        Wed, 13 Jul 2022 09:15:58 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1657700159;
        bh=7M53S5bGqltVg134JPN859srEpQycq+FAWS7IeNPoXY=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=T9hMNh8kpXhhbUp3rLUW4Iu54RZG5/uf2pf0R5b7+QhGGtswSG9Mdrl3FBjGfrXOl
         yGVr+ZrkZ/rlbPAwI31Uwi3FwudjKSsyfp5hl+XbOnY1SUcZE/rl8fXywDo/TSxXVo
         /OOWCHZbs1v+XOKWZdna81RRVPNjZHl9olNYfYGqxAXJuetZC4XNasE2nd3jLCMpa2
         wxzBgrh1BdE6rHIn7uXWHI/U3Xom7Ce/+F3ZNPGsHK3Uc2YUT+TEvl7f/zhhDi9nef
         L7YpRUJZBcefUY5PsssOyRn3098dPR2J1AvmLxig9iPFAeCPkzX+PoHfCy84CB/Jh4
         ZvtZvc8Ww2zcA==
Message-ID: <fbd48e94-1d99-a005-1c0d-0f5416e2d42f@collabora.com>
Date:   Wed, 13 Jul 2022 10:15:55 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH] iommu/mediatek: Log with dev_err_probe when failing to
 parse dts
Content-Language: en-US
To:     =?UTF-8?B?TsOtY29sYXMgRi4gUi4gQS4gUHJhZG8=?= 
        <nfraprado@collabora.com>, Joerg Roedel <joro@8bytes.org>
Cc:     kernel@collabora.com, Matthias Brugger <matthias.bgg@gmail.com>,
        Will Deacon <will@kernel.org>, Yong Wu <yong.wu@mediatek.com>,
        iommu@lists.linux-foundation.org, iommu@lists.linux.dev,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-mediatek@lists.infradead.org
References: <20220712214427.544860-1-nfraprado@collabora.com>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20220712214427.544860-1-nfraprado@collabora.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Il 12/07/22 23:44, Nícolas F. R. A. Prado ha scritto:
> mtk_iommu_mm_dts_parse() can fail with EPROBE_DEFER if not all larbs
> have probed yet, so use dev_err_probe() to avoid logging as an error in
> that case. Also drop the return value from the message since it's
> already printed by dev_err_probe(), and add the missing newline at the
> end.
> 
> Signed-off-by: Nícolas F. R. A. Prado <nfraprado@collabora.com>
> 

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>

