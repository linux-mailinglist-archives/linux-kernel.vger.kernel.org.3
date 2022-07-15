Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B751D5760D5
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Jul 2022 13:47:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234687AbiGOLrr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Jul 2022 07:47:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234580AbiGOLrn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Jul 2022 07:47:43 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8DEBF89A93;
        Fri, 15 Jul 2022 04:47:42 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 34B3CB82B72;
        Fri, 15 Jul 2022 11:47:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3A567C341C6;
        Fri, 15 Jul 2022 11:47:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1657885659;
        bh=8pAt/EJziwJeBex/Oeo6RgjbtM2GLBwfpHRN/ZjIqwI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=McJkORLjvYNFldM9l8kt9HPlNnM3lYAsDQEj1hukwO5p8EQIN/TG2ejIb3/iQ9Gzr
         OrBvJ2B7rYOhSt9PtwnPelubVad092XWojCfWfz2pEqE5cGi5Dsrc6/qc10br6SY7L
         OrCwq9YTbx8ERQCHNSjIyLLEFxc7Js1NpZz05cylUREbk7VhCA7TlPD422axqun5YR
         DSQex7es1tchmP9cNXQXyyzIjXdswnPfZ8De6JJTHa8pH+tr3kjq6ULchkpGmjLRWP
         wi1lnYM4CoSGCUB2/LILferLs5VYRnKGy1oG7KWfVa/YUsN6wMAqeI/4iuz3wgWgpM
         vQcjW4w06D6Pw==
Date:   Fri, 15 Jul 2022 17:17:35 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Chunfeng Yun <chunfeng.yun@mediatek.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-phy@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: phy: mediatek: tphy: add compatible for
 mt8188
Message-ID: <YtFT171BBEXKMTpo@matsya>
References: <20220708065834.25424-1-chunfeng.yun@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220708065834.25424-1-chunfeng.yun@mediatek.com>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08-07-22, 14:58, Chunfeng Yun wrote:
> Add compatible for mt8188

Applied, thanks

-- 
~Vinod
