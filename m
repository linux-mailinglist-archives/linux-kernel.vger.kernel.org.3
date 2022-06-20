Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 38F27551212
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Jun 2022 10:02:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239718AbiFTIBy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Jun 2022 04:01:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237592AbiFTIBw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jun 2022 04:01:52 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5F3110FF7;
        Mon, 20 Jun 2022 01:01:51 -0700 (PDT)
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id EA044660166E;
        Mon, 20 Jun 2022 09:01:49 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1655712110;
        bh=g5QlZVQ9AY69dLhGJBI/NoglBgUUwPY0hqE1JlNdASQ=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=WA9wKi/gQWlt5xFzenLxlqRm5TK6T7eh7A/TO5GztVNNvaN6+rQKhhrc99jX2EBCp
         yYgDzQ46twRQlBTVl/L9HYqQTrGsaB+YZ2SdhCNnuKX/EQipNH9p4th8+uaFhYfNfb
         E4WbOyuMyrL1wfQRDOtBHAg+hDnrFEBvzI7xKvtw1OR8EdnPtdFr2ip8tsELDOPOt5
         5EstX3ZSuqIjEBjXnAJpz8gmvgBH/Ygwmocnhxtbg3xTeP8nESsh+fcsYkSGvemRry
         XrExpreGrzI0rDTG/Ni1RSCzT67uJn6Op8YuSf0cYHr6S3gH4NBh5Ji7qZvVFd3C7R
         BHcZTwSOC5xww==
Message-ID: <61b06602-999f-b976-097f-895907798b40@collabora.com>
Date:   Mon, 20 Jun 2022 10:01:47 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH 2/2] arm64: dts: mt8192: Fix idle-states entry-method
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
 <20220617233150.2466344-3-nfraprado@collabora.com>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20220617233150.2466344-3-nfraprado@collabora.com>
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
> The entry-method property of the idle-states node should be "psci" as
> described in the idle-states binding, since this is already the value of
> enable-method in the CPU nodes. Fix it to get rid of a dtbs_check
> warning.
> 
> Fixes: 9260918d3a4f ("arm64: dts: mt8192: Add cpu-idle-states")
> Signed-off-by: Nícolas F. R. A. Prado <nfraprado@collabora.com>

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>

