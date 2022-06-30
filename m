Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CE34D56212B
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Jun 2022 19:23:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236138AbiF3RXP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Jun 2022 13:23:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233100AbiF3RXN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Jun 2022 13:23:13 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA0F81C912;
        Thu, 30 Jun 2022 10:23:11 -0700 (PDT)
Received: from [192.168.2.145] (109-252-118-164.nat.spd-mgts.ru [109.252.118.164])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: dmitry.osipenko)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 45383660196C;
        Thu, 30 Jun 2022 18:23:09 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1656609790;
        bh=LJhSooS9IKyrkGhIs6fkyHnN38CkHuggqq2CmdQEVaA=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=ER4ulT9P0QybLv69xoZ3bZoWAVUKLsOeSv8QTbdsK6cDJ/3bo5P7LUiuZBlAoFbFN
         Uj1hg6uWtiZ1iT1CsAZxQ0PUekp2vXJuOZhOvoGKvb1tMWvzB9CD33W7ci9TN3pI/5
         GoxZ48aTIyjQmVlakrGpyAD/baZpWpMhvp3J/EuCd4LGUzCqE2Ujzg31TQHm6VIR5U
         gljtZPg8RhCeRcUomsL02VE1yajs06QiDFYvlHqqrKdnOhoO6IB56eAW+4zfphZyAb
         BH+uc+zEGV9idmOCa++Jj/FHMkHPDDhvjg4lcR7sygCZbfjyS3pAgcvGZivvHvLAWs
         S/4WJqwMriGKA==
Message-ID: <b7715f7d-c69d-2bb0-8226-bcb29e5bf91c@collabora.com>
Date:   Thu, 30 Jun 2022 20:23:06 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH v5 0/3] Support Sharp LQ101R1SX03 and HannStar HSD101PWW2
 panels
Content-Language: en-US
To:     Sam Ravnborg <sam@ravnborg.org>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org,
        Svyatoslav Ryhel <clamor95@gmail.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Dmitry Osipenko <digetx@gmail.com>,
        Anton Bambura <jenneron@protonmail.com>
References: <20220529180548.9942-1-clamor95@gmail.com>
From:   Dmitry Osipenko <dmitry.osipenko@collabora.com>
In-Reply-To: <20220529180548.9942-1-clamor95@gmail.com>
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

Hello Sam,

On 5/29/22 21:05, Svyatoslav Ryhel wrote:
> This series adds support for Sharp LQ101R1SX03 and HannStar HSD101PWW2
> display panels that are used by Asus Transformer tablets, which we're
> planning to support since 5.17 kernel.

The tablets now supported since 5.17 and awaiting for the panel patches.

> Changelog:
> v5: - previously patches were sent by Dmitry and he asked me to resend them
> 
> v4: - Added r-b from Rob Herring that he gave to the LQ101R1SX01 DT patch
>       of v2. I missed to add it to the v3 by accident.
> 
> v3: - No changes. Re-sending for 5.18. Device-trees of devices that use
>       these panels were merged to 5.17, so we're missing the display support.
> 
> v2: - Added ack from Rob Herring to the HSD101PWW2 binding.
> 
>     - Updated LQ101R1SX01 binding, like it was suggested by Rob Herring,
>       making LQ101R1SX03 directly compatible with the LQ101R1SX01.
>       Such that ["sharp,lq101r1sx03", "sharp,lq101r1sx01"] could be
>       used in DT. This removes need to update panel driver with the new
>       compatible.
> 
>     - Improved commit message of the LQ101R1SX03 patch.
> 
>     - Added my s-o-b to all patches.
> 
> Anton Bambura (1):
>   dt-bindings: sharp,lq101r1sx01: Add compatible for LQ101R1SX03
> 
> Svyatoslav Ryhel (2):
>   dt-bindings: display: simple: Add HannStar HSD101PWW2
>   drm/panel: simple: Add support for HannStar HSD101PWW2 panel
> 
>  .../bindings/display/panel/panel-simple.yaml  |  2 ++
>  .../display/panel/sharp,lq101r1sx01.yaml      |  7 ++++-
>  drivers/gpu/drm/panel/panel-simple.c          | 28 +++++++++++++++++++
>  3 files changed, 36 insertions(+), 1 deletion(-)
> 

Sam, could you please take a look at these patches? They missed two
kernel versions already because there was nobody to apply them. Thanks
in advance.

-- 
Best regards,
Dmitry
