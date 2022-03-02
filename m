Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2D3A54CA7E7
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Mar 2022 15:23:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241512AbiCBOYf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Mar 2022 09:24:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233867AbiCBOYc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Mar 2022 09:24:32 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54B7953E35;
        Wed,  2 Mar 2022 06:23:49 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id F2D06B81FF4;
        Wed,  2 Mar 2022 14:23:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ED0EBC004E1;
        Wed,  2 Mar 2022 14:23:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1646231026;
        bh=+KRRkkTu7KJThUJTNzBgWGqfwZmhGW8tBePw/LZh/5Y=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=RpSC14E+HAIvzMhphulhgbxErI4/p6vxVDacEaux7wJXlEa1WNr+D2+rnMu7NCCNk
         1lm8Fi0XyqWtwREtt8w2TjQtO4ffcsh81mE+zZm4L70ZYUIPiPyzRWAXEPNFphXTcp
         Px3JmcDki7dvBDaPve7vE7oVxpmo6jht+pARFkjqgxtKie/ZNP7HNvHQ+L0D8AzRLq
         ZtxMgOnyxkj1v+x46fLIbuLVqjxXE87V9aawdmjK5Ic3Z8kjch5Pa4i5g9ldCj5uyP
         0j89SYP5UYqODauEv2dfGhGbQA5xDnFV/z0U8mPPzoGWsPZALuj/H8wzJs0kYOunUF
         gea7f+VCUGMrw==
Date:   Wed, 2 Mar 2022 19:53:42 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Cc:     Geert Uytterhoeven <geert+renesas@glider.be>,
        linux-renesas-soc@vger.kernel.org, devicetree@vger.kernel.org,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
        linux-kernel@vger.kernel.org,
        Prabhakar <prabhakar.csengg@gmail.com>,
        Biju Das <biju.das.jz@bp.renesas.com>,
        linux-phy@lists.infradead.org
Subject: Re: [PATCH v2] dt-bindings: phy: renesas,usb2-phy: Document RZ/V2L
 phy bindings
Message-ID: <Yh997pOE3Mx9fdF2@matsya>
References: <20220301124255.16836-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220301124255.16836-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Spam-Status: No, score=-7.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 01-03-22, 12:42, Lad Prabhakar wrote:
> Document USB phy bindings for RZ/V2L SoC. RZ/V2L USB phy is identical to
> one found on the RZ/G2L SoC. No driver changes are required as generic
> compatible string "renesas,rzg2l-usb2-phy" will be used as a fallback.
> 
> While at it, drop the comment "RZ/G2L family" for "renesas,rzg2l-usb2-phy"
> compatible string as this will avoid changing the line for every new SoC
> addition.

Applied, thanks

-- 
~Vinod
