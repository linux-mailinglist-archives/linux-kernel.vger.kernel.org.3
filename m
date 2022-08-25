Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AF6495A1556
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Aug 2022 17:14:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242427AbiHYPN7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Aug 2022 11:13:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230072AbiHYPN5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Aug 2022 11:13:57 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 685B2B56F3;
        Thu, 25 Aug 2022 08:13:56 -0700 (PDT)
Received: from notapiano (unknown [70.107.189.129])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: nfraprado)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 4B3396601D97;
        Thu, 25 Aug 2022 16:13:53 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1661440435;
        bh=YozKHKtuLc9sgOOMnJ698obW3XC7fZK8JlCRNnws3Z8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=XCrYGlxCbZXCnEAAfddALgZrTr2weESYZu+q4cSm3CLcCajqiJEFpx3AWHuuFdmdJ
         Neci/sVHdyzWoyaMo84+/+KNMV2UmZoKbRJJK7MA9QPnuUtR7hIcszM1O02FnLXGUj
         y/YDFaz+7VE6qGZe8ookczri5k3BXzjLTE9rXXRo/5JSP2J3W9IprZzNXziqvWy8bp
         8h4EfBlXtn3Hhkqm29huE3Pan2lLAwRbEbTfqTaT+/TV+CeKdB42dM73IObJwS8UvB
         SdvLL753ffZRWdejYmDlAkq5HKn2KVxdZQ6hzeahEyop5/x37dV9U03wf7BirrmllR
         w9McTn69yNUZg==
Date:   Thu, 25 Aug 2022 11:13:50 -0400
From:   =?utf-8?B?TsOtY29sYXMgRi4gUi4gQS4=?= Prado 
        <nfraprado@collabora.com>
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     Hui Liu <hui.liu@mediatek.com>, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, matthias.bgg@gmail.com,
        angelogioacchino.delregno@collabora.com, wenst@google.com,
        Project_Global_Chrome_Upstream_Group@mediatek.com,
        jianguo.zhang@mediatek.com, zhiyong.tao@mediatek.com,
        sean.wang@mediatek.com, linux-gpio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6 0/2] MediaTek pinctrl patch on mt8188
Message-ID: <20220825151350.mbovhtvcgnf6shwd@notapiano>
References: <20220818075012.20880-1-hui.liu@mediatek.com>
 <CACRpkdbGjbd9Q9Chcnnc=3nD3XALsCdk7dz9mT3BfJdZs62xjA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CACRpkdbGjbd9Q9Chcnnc=3nD3XALsCdk7dz9mT3BfJdZs62xjA@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 25, 2022 at 02:54:32PM +0200, Linus Walleij wrote:
> On Thu, Aug 18, 2022 at 9:50 AM Hui Liu <hui.liu@mediatek.com> wrote:
> 
> > Changes in patch v6:
> > 1.Update driver file's coding style.
> 
> No further comments on this version so patch applied. If Sean
> has further comments they can be addressed in-tree.
> 
> Nicolas: thanks for helping out with review!

Sure! Glad to help.
