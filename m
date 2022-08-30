Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4EF805A5FB9
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Aug 2022 11:46:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229630AbiH3JqV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Aug 2022 05:46:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229698AbiH3JqS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Aug 2022 05:46:18 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7A26A2DA1;
        Tue, 30 Aug 2022 02:46:16 -0700 (PDT)
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id C5ACD6601BF7;
        Tue, 30 Aug 2022 10:46:14 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1661852775;
        bh=yjC89saAgBju8ExXt9nwpmDQQR18E9xc86/sSTGhJEQ=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=AddUnld3tR1MuhWklJh9cxZbTR0S+J3RifWNZeGGGLhVFmcYSHF1zPBERasbYg8uN
         nxo1Mu92N1gD7OLNFVmCQ0aQV/o/+8bDqhHwHt4boW1gIEhHwQsd/AJmoW2HZZEP1T
         LI4jeTLXV2F7hvbYf6eGChkbWyi0fTFpivZt42XKQR/K59b7xtQlAofjYQijtWtkvv
         Jq1HEqkVE4IfUeUTE4TISKWbnoGYlGBJKrmhYkxuds42KygoG3eLOQkOcDGs61UJ41
         0txWtrYR1/UujPChcQVQSk+xxth56j0rqCPnGGkQqBeqW4A1Mo7BnmVrMyN9umw8hs
         fDhQkmniXhTTQ==
Message-ID: <a0396687-f27e-a601-1bb6-daa6fa210ea5@collabora.com>
Date:   Tue, 30 Aug 2022 11:46:11 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH 1/4] spi: mt7621: Fix an error message in
 mt7621_spi_probe()
Content-Language: en-US
To:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        broonie@kernel.org, matthias.bgg@gmail.com,
        gregkh@linuxfoundation.org, neil@brown.name, blogic@openwrt.org
Cc:     linux-spi@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org
References: <cover.1661599671.git.christophe.jaillet@wanadoo.fr>
 <928f3fb507d53ba0774df27cea0bbba4b055993b.1661599671.git.christophe.jaillet@wanadoo.fr>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <928f3fb507d53ba0774df27cea0bbba4b055993b.1661599671.git.christophe.jaillet@wanadoo.fr>
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

Il 27/08/22 13:42, Christophe JAILLET ha scritto:
> 'status' is known to be 0 at this point. The expected error code is
> PTR_ERR(clk).
> 
> Switch to dev_err_probe() in order to display the expected error code (in a
> human readable way).
> This also filters -EPROBE_DEFER cases, should it happen.
> 
> Fixes: 1ab7f2a43558 ("staging: mt7621-spi: add mt7621 support")
> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
> Reviewed-by: Matthias Brugger <matthias.bgg@gmail.com>

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
