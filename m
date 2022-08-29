Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AAA4D5A4E89
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Aug 2022 15:50:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229935AbiH2Nt5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Aug 2022 09:49:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229753AbiH2Nty (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Aug 2022 09:49:54 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F04BDA449
        for <linux-kernel@vger.kernel.org>; Mon, 29 Aug 2022 06:49:50 -0700 (PDT)
Received: from notapiano (unknown [70.107.189.129])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: nfraprado)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id E2C6A6601DC4;
        Mon, 29 Aug 2022 14:49:47 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1661780989;
        bh=INGbphvqng/9YH+Uc8bMKz/do1TcHYSTNqW55zHsUwQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=fbIIK+JUF9TglZipH4EnVCozhC+uFmadTrTjvS4WSuRd/Tu8QcrhxhabNPE2YZwME
         NVvq/jWIyd/YnMG1lkmULUzdRaX6OXi/Pm0LiEZV49bE9vScG7OIgRCP8XnjbtGjPU
         iDXuAhvhKROs5bUJkHfCcxHU0CsZZxmc7Ht9eoz1+PTG7OFjBiPWDe7woHOhlVQwup
         sOyBO9Ds7MpIyZ167RwCrNgugVHIDC9XBe0vux1SiLx0QodyLQCOQL65DDr2zGRiYZ
         eKuoz3bGSIbERwiBe+VU4F75e8Xk0evAwSOXeJ+R2DbA+1+FAZmQWMO5Q7gxOjAqOm
         fxZLHDigta+BA==
Date:   Mon, 29 Aug 2022 09:49:44 -0400
From:   =?utf-8?B?TsOtY29sYXMgRi4gUi4gQS4=?= Prado 
        <nfraprado@collabora.com>
To:     xinlei.lee@mediatek.com
Cc:     matthias.bgg@gmail.com, angelogioacchino.delregno@collabora.com,
        rex-bc.chen@mediatek.com, jason-jh.lin@mediatek.com,
        yongqiang.niu@mediatek.com, chunkuang.hu@kernel.org,
        p.zabel@pengutronix.de, airlied@linux.ie, daniel@ffwll.ch,
        jitao.shi@mediatek.com, dri-devel@lists.freedesktop.org,
        linux-mediatek@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Project_Global_Chrome_Upstream_Group@mediatek.com
Subject: Re: [PATCH v4,2/2] drm: mediatek: Adjust the dpi output format to
 MT8186
Message-ID: <20220829134751.kvljnlsjwvmxhve7@notapiano>
References: <1661743308-29120-1-git-send-email-xinlei.lee@mediatek.com>
 <1661743308-29120-3-git-send-email-xinlei.lee@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1661743308-29120-3-git-send-email-xinlei.lee@mediatek.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 29, 2022 at 11:21:48AM +0800, xinlei.lee@mediatek.com wrote:
> From: Xinlei Lee <xinlei.lee@mediatek.com>
> 
> Dpi output needs to adjust the output format to dual edge for MT8186.
> 
> Co-developed-by: Jitao Shi <jitao.shi@mediatek.com>
> Signed-off-by: Jitao Shi <jitao.shi@mediatek.com>
> Signed-off-by: Xinlei Lee <xinlei.lee@mediatek.com>

Reviewed-by: Nícolas F. R. A. Prado <nfraprado@collabora.com>

Thanks,
Nícolas
