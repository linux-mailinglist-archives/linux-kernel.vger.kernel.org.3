Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ABB7559EDC5
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Aug 2022 22:50:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231468AbiHWUtx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Aug 2022 16:49:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229974AbiHWUtd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Aug 2022 16:49:33 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A8E1E13;
        Tue, 23 Aug 2022 13:44:41 -0700 (PDT)
Received: from notapiano (unknown [194.36.25.10])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: nfraprado)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 0EDE56601E65;
        Tue, 23 Aug 2022 21:44:36 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1661287480;
        bh=jqLAj0YQtQZUtqXH+BAY2b9SkhzwQO4Yvi/MUffe6Zs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=UXlGRT0GN5ZkJgDkdHbW6movx3CyrChqNzrWEo3lqznM7S7DDEdcOhYyAGF4rG5Za
         UudB8D5M/M5rQxqQuU5Y1Z2ITl3UC/oSPGCiTh2I7PtLCENdiHdlwGOfzXzkcmPIbX
         Y3ecc0PrQcgGB9dEswKsR40q7xk1MYi17F4DXhiRogX10fDeKvlsOQZ2RTSNg43UOr
         WQnSPdmTcQS7ZUmehwrOjFWYkJ337Kux9LJOvgJhPGds3NmwYcG18ErEQ1NU4B4UVk
         0w4oPy7AXgzNkkZvf+lrAT6vq9N2X2qmlXxd5TdLwOAQ2hHGFRLxy9enmmRbb46+QA
         x0IR0rPcAsvbA==
Date:   Tue, 23 Aug 2022 16:44:32 -0400
From:   =?utf-8?B?TsOtY29sYXMgRi4gUi4gQS4=?= Prado 
        <nfraprado@collabora.com>
To:     Chunfeng Yun <chunfeng.yun@mediatek.com>
Cc:     Vinod Koul <vkoul@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-phy@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Eddie Hung <eddie.hung@mediatek.com>
Subject: Re: [PATCH 1/7] dt-bindings: phy: mediatek,tphy: add support type of
 SGMII
Message-ID: <20220823204432.ugfs7k3dn4ibbcky@notapiano>
References: <20220819091344.2274-1-chunfeng.yun@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220819091344.2274-1-chunfeng.yun@mediatek.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 19, 2022 at 05:13:38PM +0800, Chunfeng Yun wrote:
> Add support ethernet SGMII, forgot to update type supported.
> 
> Fixes: c01608b3b46b ("dt-bindings: phy: mediatek: tphy: support type switch by pericfg")
> Signed-off-by: Chunfeng Yun <chunfeng.yun@mediatek.com>

Hi Chunfeng,

when sending a patch series of more than 1 patch, please add a cover letter
describing a higher level overview of the changes done in the patches. Example:
[1]

Thanks,
Nícolas

[1] https://lore.kernel.org/all/20220629155956.1138955-1-nfraprado@collabora.com/
