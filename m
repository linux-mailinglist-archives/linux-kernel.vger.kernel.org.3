Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6FA585652A2
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Jul 2022 12:42:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234313AbiGDKlv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Jul 2022 06:41:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234071AbiGDKld (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jul 2022 06:41:33 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45307101C0;
        Mon,  4 Jul 2022 03:41:32 -0700 (PDT)
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 7056A660198A;
        Mon,  4 Jul 2022 11:41:30 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1656931291;
        bh=0SlVAsGcawQhzBIfHNTx//M3DY6rnjdPrfiIE/snMy4=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=oLs8awQwuu8NUFYad9CWS42fLD5oGA54IlN7Yek6KuOVjC91jN4ZEBELy8Klk1RWm
         t2/IL97FaYoJrxHlnrOP8O/2n5hnNK/scqHh9Xf2YBKCokVvY8FgEbjcWHNKV8yMhu
         CkBlS+3fzXi225G3rAUoZ0vbB5pE3Z3/+cOdIONkSBVQsPI5HD+T5l1BJMmi1E4Gwv
         aOc7ZFR8DThpkS88IjshlaZwTbCwsjeD0z3DVVpBHKHKCteAuWFbcQ8FKU9IXkmFKe
         gmqSCLHb10uByfOs5QB6ffsLW0cntfITwLKpOzZrbuH1pBB6KR5xLdJtWYsRoyzKR0
         QSHInhZVmvpXQ==
Message-ID: <c478ab1d-c6ce-30c3-5f15-1cce47db17a6@collabora.com>
Date:   Mon, 4 Jul 2022 12:41:27 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH v1 08/16] arm64: dts: mt8195: Add power domains controller
Content-Language: en-US
To:     Tinghan Shen <tinghan.shen@mediatek.com>,
        Yong Wu <yong.wu@mediatek.com>, Joerg Roedel <joro@8bytes.org>,
        Will Deacon <will@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Chun-Jie Chen <chun-jie.chen@mediatek.com>,
        Weiyi Lu <weiyi.lu@mediatek.com>
Cc:     iommu@lists.linux-foundation.org,
        linux-mediatek@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Project_Global_Chrome_Upstream_Group@mediatek.com
References: <20220704100028.19932-1-tinghan.shen@mediatek.com>
 <20220704100028.19932-9-tinghan.shen@mediatek.com>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20220704100028.19932-9-tinghan.shen@mediatek.com>
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

Il 04/07/22 12:00, Tinghan Shen ha scritto:
> Add power domains controller node for mt8195.
> 
> Signed-off-by: Weiyi Lu <weiyi.lu@mediatek.com>
> Signed-off-by: Tinghan Shen <tinghan.shen@mediatek.com>

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>

