Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C100055FA60
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Jun 2022 10:25:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231779AbiF2IXl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Jun 2022 04:23:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231775AbiF2IXi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Jun 2022 04:23:38 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 493C43B54D
        for <linux-kernel@vger.kernel.org>; Wed, 29 Jun 2022 01:23:37 -0700 (PDT)
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 9ADB066018F6;
        Wed, 29 Jun 2022 09:23:35 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1656491016;
        bh=Tlj2vF7pAPWGRIwrz16g80+PcSeGWCYrUwBN2Zp9Gqg=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=FdcAaRzQZY9/TmuD5FpfBRWinXwWCHKIaEFfjzsgv0aXujyD0MAKsrlAn423LFy0/
         MeZje1XipfLs3Wlm/Z8FQ8Z9y17k2yYHH+pxqjppBZ/cpWgfd6158UDN4LdaMP7ZU3
         jKaSzJF1+FD7GTUy9S/ZgASDVdhDyFHLB0eLipISgn8XlVfu3x1nOiz/caleNXhnLi
         Z4WaIk3y8TyEC+OfSsjTDlKnBEckwAysKgztjRX/Sn1/HsN51MYGL3B7lm1ROvo8ph
         S8z73nEeVt0lEze3BLvOjGNhYFMMFPbe28VyUKNOdMgyggixXmkSetwv7qvjeob5a+
         yrRiV6PiwQ4rQ==
Message-ID: <72d87ff5-4af2-c186-3112-bde153a6a4c5@collabora.com>
Date:   Wed, 29 Jun 2022 10:23:32 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH 2/2] regulator: mt6370: Use the correct header for
 platform_device_id
Content-Language: en-US
To:     cy_huang <u0084500@gmail.com>, broonie@kernel.org
Cc:     lgirdwood@gmail.com, matthias.bgg@gmail.com, chiaen_wu@richtek.com,
        alice_chen@richtek.com, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org,
        ChiYuan Huang <cy_huang@richtek.com>
References: <1656466861-7737-1-git-send-email-u0084500@gmail.com>
 <1656466861-7737-2-git-send-email-u0084500@gmail.com>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <1656466861-7737-2-git-send-email-u0084500@gmail.com>
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

Il 29/06/22 03:41, cy_huang ha scritto:
> From: ChiYuan Huang <cy_huang@richtek.com>
> 
> 'platform_device_id' struct is defined in 'mod_devicetable.h'.
> Even 'of.h' also includes this header usage. The 'of.h' cannot be removed
> due to 'of_match_ptr' function.
> 
> Signed-off-by: ChiYuan Huang <cy_huang@richtek.com>

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>

