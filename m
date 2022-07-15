Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3913E575D4B
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Jul 2022 10:23:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230439AbiGOIWN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Jul 2022 04:22:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229459AbiGOIWK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Jul 2022 04:22:10 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7F2674780;
        Fri, 15 Jul 2022 01:22:09 -0700 (PDT)
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 7F7EE6601A3F;
        Fri, 15 Jul 2022 09:22:07 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1657873328;
        bh=sUZouS3lE1J14tvmlfvtX6XwZPGBxusKP+JBfQl5o+8=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=Jl3Ep2702F1Hv+y/rgolfrFceblEiEI/XWHj03jg+HtkrHLPuIB2dR+MYJ1oBibzN
         u14TtGUOyS4ev9oN28GqS87p6sAYnKuevWSxvFd4tksTHM3zP8BCoasDt29ysS5use
         vEeKKR3RLuhc6hcfikfVL10JRgyLgiInE+zHmAIBx6lAXulc/1p/4+Apet4dES/LBU
         gW89BP8q1GGK23snISdzk0lsfHxIhv1HPuPi6fxfv9i2IT7GkMHKxtDOnHCYzYpqlw
         53BhUWo7AKElTegX7aQuJc8sXRhM9uVhKUXC6nYYpG1dbyzI0IhZ3u/uItMYp9jN90
         6U9+fIMHS6Kwg==
Message-ID: <5c25eaa7-c578-258e-a2ec-ca4a72488e72@collabora.com>
Date:   Fri, 15 Jul 2022 10:22:04 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v1 2/2] remoteproc: mediatek: Support MT8188 SCP
Content-Language: en-US
To:     Tinghan Shen <tinghan.shen@mediatek.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Matthias Brugger <matthias.bgg@gmail.com>
Cc:     linux-remoteproc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        Project_Global_Chrome_Upstream_Group@mediatek.com
References: <20220715051821.30707-1-tinghan.shen@mediatek.com>
 <20220715051821.30707-3-tinghan.shen@mediatek.com>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20220715051821.30707-3-tinghan.shen@mediatek.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Il 15/07/22 07:18, Tinghan Shen ha scritto:
> MT8188 SCP has two RISC-V cores and similar to MT8195 with some
> differences. The MT8188 SCP doesn't have the l1tcm and fix the
> DSP EMI issue on MT8195.
> 
> Signed-off-by: Tinghan Shen <tinghan.shen@mediatek.com>

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>

