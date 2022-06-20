Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8EC5C551208
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Jun 2022 10:01:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239712AbiFTIBi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Jun 2022 04:01:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237592AbiFTIBf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jun 2022 04:01:35 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6078311174;
        Mon, 20 Jun 2022 01:01:34 -0700 (PDT)
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 60363660166E;
        Mon, 20 Jun 2022 09:01:32 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1655712092;
        bh=1QfDJm0Il75vWMVfyjj3z3sKxluz2uEePpUdetg+Ws8=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=hWCb+WR2UI/EwmUEQ127NgCyTcFmAPnPG6VTgs1BbRO3hZRz0q2kqJmPhDceua0zL
         4+mjlQU1CIigYkJGddLQxDF53wux+6w5bB8totm/p1oXOoH7vV2mNdxucDbm4gqEho
         Yv6XMqSb+/imR2zIT7fP7wRMzMvyVpo89/3bNq/DT8yR5UJsFD8QfyIe8kYjSJH+xE
         7jDpyoI5P/1WrCSrrfqH0vMZc7kRrJoFF6BDUBDbKbTM7CSnPfvxvwv9q2yts0x7Ek
         uMagYu57KO2nIXVW0feS1e0Niyic81EGvxdb1u0TmRjfja4nbGFQsvypvCDeuRLkZ2
         zxsRyrRM3Jung==
Message-ID: <abb9a03f-f873-1f28-b8a6-ddd2b66c15f7@collabora.com>
Date:   Mon, 20 Jun 2022 10:01:30 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH 1/2] arm64: dts: mt8192: Fix idle-states nodes naming
 scheme
Content-Language: en-US
To:     =?UTF-8?B?TsOtY29sYXMgRi4gUi4gQS4gUHJhZG8=?= 
        <nfraprado@collabora.com>,
        Matthias Brugger <matthias.bgg@gmail.com>
Cc:     kernel@collabora.com, James Liao <jamesjj.liao@mediatek.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-mediatek@lists.infradead.org
References: <20220617233150.2466344-1-nfraprado@collabora.com>
 <20220617233150.2466344-2-nfraprado@collabora.com>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20220617233150.2466344-2-nfraprado@collabora.com>
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

Il 18/06/22 01:31, Nícolas F. R. A. Prado ha scritto:
> Tweak the name of the idle-states subnodes so that they follow the
> binding pattern, getting rid of dtbs_check warnings.
> 
> Only the usage of "-" in the name was necessary, but "off" was also
> exchanged for "sleep" since that seems to be a more common wording in
> other dts files.
> 
> Fixes: 9260918d3a4f ("arm64: dts: mt8192: Add cpu-idle-states")
> Signed-off-by: Nícolas F. R. A. Prado <nfraprado@collabora.com>
> 

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>

