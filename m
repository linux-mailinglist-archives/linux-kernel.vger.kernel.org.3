Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7E522550A64
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Jun 2022 13:52:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236498AbiFSLwC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 19 Jun 2022 07:52:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232251AbiFSLwB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Jun 2022 07:52:01 -0400
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D67C12098;
        Sun, 19 Jun 2022 04:52:00 -0700 (PDT)
Received: from pendragon.ideasonboard.com (62-78-145-57.bb.dnainternet.fi [62.78.145.57])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id C6A3325E;
        Sun, 19 Jun 2022 13:51:58 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1655639519;
        bh=U8T5YtF7Hm8RYD0xYvGiWRWoW/mJIMjaHSf3ZUOezCA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=AHIgK/VQ4icDuuO+diTuqMhG0/brKjaSmYB4Jf7JCPgK45iElEmIvJzWZPbYjdNdk
         5g2WwLR+0vqyeJRVZosSzCYT878HKBRdzL8wAKvyrh8QuvqFFj6bB3lDkYX2Qw74Xj
         jX77S9+wg7q+GijjtuNe5617yEH2uFUSGH6qZR/0=
Date:   Sun, 19 Jun 2022 14:51:44 +0300
From:   Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Chunfeng Yun <chunfeng.yun@mediatek.com>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Vinod Koul <vkoul@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Anurag Kumar Vulisha <anurag.kumar.vulisha@xilinx.com>,
        Michal Simek <michal.simek@xilinx.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-phy@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Sean Anderson <sean.anderson@seco.com>
Subject: Re: [PATCH] dt-bindings: phy: make phy-cells description a text
Message-ID: <Yq8N0ASsp3e+rDAd@pendragon.ideasonboard.com>
References: <20220619113325.21396-1-krzysztof.kozlowski@linaro.org>
 <Yq8LHN+WGVpXDwiM@pendragon.ideasonboard.com>
 <8fbee49a-8215-32b7-3545-66df70ecc38d@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <8fbee49a-8215-32b7-3545-66df70ecc38d@linaro.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jun 19, 2022 at 01:46:17PM +0200, Krzysztof Kozlowski wrote:
> On 19/06/2022 13:40, Laurent Pinchart wrote:
> > Hi Krzysztof,
> > 
> > Thank you for the patch.
> > 
> > On Sun, Jun 19, 2022 at 01:33:25PM +0200, Krzysztof Kozlowski wrote:
> >> The description field is a string, so using YAML inside phy-cells
> >> description is not actually helpful.
> > 
> > Does it hurt though ? For xlnx,zynqmp-psgtr.yaml I wrote it that way to
> > prepare for a future where it could be described using a YAML schema
> > (but such future may never come).
> 
> No, it does not hurt. It is however confusing some folks and they think
> schema goes into description. The description should be
> readable/descriptive for humans, so if you think your approach is
> better, I am perfectly fine with it.

I don't mind much. If you think it would be a good idea to eventually
describe the #phy-cells elements in YAML schema then I'd rather keep the
current description, if there's very little chance it will happen, I
don't mind changing it.

-- 
Regards,

Laurent Pinchart
