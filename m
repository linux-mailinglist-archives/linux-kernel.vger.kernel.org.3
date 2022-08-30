Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7AAD25A60E7
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Aug 2022 12:37:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229846AbiH3Kg5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Aug 2022 06:36:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229739AbiH3Kgx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Aug 2022 06:36:53 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0548DA99D6;
        Tue, 30 Aug 2022 03:36:53 -0700 (PDT)
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 307116601D92;
        Tue, 30 Aug 2022 11:36:51 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1661855811;
        bh=rss5yhhAOkOZgTjBZofcKSYZN8+ajXcvMRSruFr6dis=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=RUAjO6OG7y1chiDV49ps6XX8amWr8x4vu6e0hPO26PpmdZwFEmx3SCcn4hZDfj9+u
         ktpfka3e/PYETn0wBuskZycxoQ2crlpZJpeahGRqi7tWwMv/mwh0GZL5kyJgBvGxp7
         eyUaOgRaAwVRePrSHz5RfJyzHTjiSGcFA0DCvNaIT9sUd0hiZSYKJjcrCLsUQ8teUQ
         fyiz/vEqUwq4Y1ASnBVumYPy1Rm/YDZOehKWxj4e3hmbwiYxIJJNvPKgToU9uDsS6Q
         ovMYZpcxOwqQfvUDGK/ERFtuMDJr+c3H5RksGbrBpCt90NQRWm1ON7Y4aPxX7EhBhH
         jVuCTKY53gesA==
Message-ID: <814291c8-e24f-ea5c-8f88-af978f72e335@collabora.com>
Date:   Tue, 30 Aug 2022 12:36:48 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH] pwm: mtk-disp: Fix the parameters calculated by the
 enabled flag of disp_pwm.
Content-Language: en-US
To:     xinlei.lee@mediatek.com, thierry.reding@gmail.com,
        u.kleine-koenig@pengutronix.de, matthias.bgg@gmail.com,
        jitao.shi@mediatek.com
Cc:     linux-pwm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        Project_Global_Chrome_Upstream_Group@mediatek.com
References: <1661745852-27323-1-git-send-email-xinlei.lee@mediatek.com>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <1661745852-27323-1-git-send-email-xinlei.lee@mediatek.com>
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

Il 29/08/22 06:04, xinlei.lee@mediatek.com ha scritto:
> From: xinlei lee <xinlei.lee@mediatek.com>
> 
> In the original mtk_disp_pwm_get_state() function, the result of reading
> con0 & BIT(0) is enabled as disp_pwm.
> In order to conform to the register table, we should use the disp_pwm
> base address as the enabled judgment.
> 
> Fixes: 3f2b16734914 ("pwm: mtk-disp: Implement atomic API .get_state()")
> 
> Signed-off-by: xinlei lee <xinlei.lee@mediatek.com>
> Reviewed-by: Miles Chen <miles.chen@mediatek.com>

This fix is valid for all MediaTek SoCs that are currently supported in
pwm-mtk-disp (and some others that aren't supported yet).

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
