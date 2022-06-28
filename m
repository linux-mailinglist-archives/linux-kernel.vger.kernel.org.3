Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 011D655CADC
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Jun 2022 14:59:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344581AbiF1LtT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Jun 2022 07:49:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344313AbiF1LtS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jun 2022 07:49:18 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2572860D5
        for <linux-kernel@vger.kernel.org>; Tue, 28 Jun 2022 04:49:11 -0700 (PDT)
Received: from [192.168.2.145] (109-252-118-164.nat.spd-mgts.ru [109.252.118.164])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: dmitry.osipenko)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 3321A660184F;
        Tue, 28 Jun 2022 12:49:09 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1656416949;
        bh=HGQEPLnVH+jJ83Zot50l0PdSWCuDqpbeVYS48mJP2vs=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=kdJe+hsxGDkqHitC4VywwVUdMSa0p1LJvIbmEMvG8yLFoS8FoF05EUhaL7RdtdOiL
         ODglyQWuRcqO8Z4xTd9YwEoObsgo/eMMBpbHCocY/hUgQ9X3Wj888YUAqLbMXakCvd
         AjV+jKscFH196pEGB/x6rxUPw3eYVPWpp92JrejLsBjhM+zkPwa7hl6ZeTZlusqnGV
         gqrYQnbaGmY3NjMUyYfdk4tQJ82vMXZbgFv5xicP4WfdL6eSFVPfQo/UezmQ9Z9Bpo
         2B/QR++KoJOGMprTXnWMhvpZzccFpEOU2BTwAYxT+d6+8LfU8Q9I6U6caMsZyxmTI/
         y3ZDg+Bvli1Mg==
Message-ID: <ed9e1326-b62a-bc98-027a-79121fe2914c@collabora.com>
Date:   Tue, 28 Jun 2022 14:49:06 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH v2] soc: mediatek: Introduce mediatek-regulator-coupler
 driver
Content-Language: en-US
To:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>, matthias.bgg@gmail.com
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, wenst@chromium.org,
        alyssa.rosenzweig@collabora.com, nfraprado@collabora.com,
        digetx@gmail.com
References: <20220628110128.64137-1-angelogioacchino.delregno@collabora.com>
From:   Dmitry Osipenko <dmitry.osipenko@collabora.com>
In-Reply-To: <20220628110128.64137-1-angelogioacchino.delregno@collabora.com>
Content-Type: text/plain; charset=UTF-8
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

Hi Angelo,

On 6/28/22 14:01, AngeloGioacchino Del Regno wrote:
> +		mrc->vsram_rdev = rdev;
> +	} else if (!strstr(rdev_name, "vgpu") && !strstr(rdev_name, "Vgpu"))
> +		return 1;

Nit: checkpatch --strict should warn about the missing {} here. In
general braces are always needed for each condition if they were needed
once in the if-else.

Reviewed-by: Dmitry Osipenko <dmitry.osipenko@collabora.com>

-- 
Best regards,
Dmitry
