Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E0DE55A1916
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Aug 2022 20:51:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243533AbiHYSvR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Aug 2022 14:51:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243489AbiHYSvG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Aug 2022 14:51:06 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD3C4B2CF7
        for <linux-kernel@vger.kernel.org>; Thu, 25 Aug 2022 11:51:05 -0700 (PDT)
Received: from notapiano (unknown [70.107.189.129])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: nfraprado)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 942E56601EAE;
        Thu, 25 Aug 2022 19:51:03 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1661453464;
        bh=jqjW7nQ84W8spFHzeSk+rHHJ/4I5iCIJLk6w8rmb7rc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=MH5HsrRkh3wk3XSsr+HODwUgKAGKEz2nM078683pQisORGSosmuU2vvz8w2xWrmYP
         MxqrWoLWdzzLXFUC2UKgceMIt0yW4/j51rTGu7XUgbBtM0lrmBkCjsDYRyWiEG7uIa
         NnQNlLGdxclJmEb25DlZ3/7Kb8xPG9xB7psiNMCm8l3EC69khxFKXdyHiz6eySopIk
         gQF+v6zbIiX7Xk5FZICrdgNonPUB5MoosO1BfDdnMcSl60IDQjR/shcL63TB2sbxtI
         qvrHz1kLWIk15ATI0mngDAOh/NLof2Ir6ctpYoYpw6DxVd6FgXKnEs9Jm08SMobyq5
         RBQUG/Ofj8LpA==
Date:   Thu, 25 Aug 2022 14:50:59 -0400
From:   =?utf-8?B?TsOtY29sYXMgRi4gUi4gQS4=?= Prado 
        <nfraprado@collabora.com>
To:     Matthias Brugger <matthias.bgg@gmail.com>
Cc:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>, roger.lu@mediatek.com,
        khilman@baylibre.com, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        kernel@collabora.com
Subject: Re: [PATCH 6/6] soc: mediatek: mtk-svs: Use bitfield access macros
 where possible
Message-ID: <20220825185059.xbh3gigksveg4h4u@notapiano>
References: <20220726141653.177948-1-angelogioacchino.delregno@collabora.com>
 <20220726141653.177948-7-angelogioacchino.delregno@collabora.com>
 <fa5f9bc8-f087-02c6-dd31-efa33244bf1b@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <fa5f9bc8-f087-02c6-dd31-efa33244bf1b@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 25, 2022 at 03:29:33PM +0200, Matthias Brugger wrote:
> 
> 
> On 26/07/2022 16:16, AngeloGioacchino Del Regno wrote:
> > In order to enhance readability and safety during registers setup
> > and value retrieval, redefine a few register related macros and
> > convert all open-coded instances of bitfield setting/retrieval
> > to use the FIELD_PREP() and FIELD_GET() macros.
> > While at it, some macros were renamed to further enhance readability.
> > 
> > This commit brings no functional changes.
> > 
> > Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
> 
> Does not apply, would you mind to resend together with 1/6? Thanks!

Hi Matthias,

Patches 1 and 6 rebased and sent [1].

Thanks,
Nícolas

[1] https://lore.kernel.org/all/20220825184616.2118870-1-nfraprado@collabora.com
