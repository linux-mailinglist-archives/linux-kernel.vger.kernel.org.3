Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D71FF4CA829
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Mar 2022 15:30:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238601AbiCBObT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Mar 2022 09:31:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243038AbiCBO3c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Mar 2022 09:29:32 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1FE8252B23;
        Wed,  2 Mar 2022 06:28:21 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id BAD4261495;
        Wed,  2 Mar 2022 14:28:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 59142C36AE3;
        Wed,  2 Mar 2022 14:28:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1646231300;
        bh=ut9NbID3o+lZR6vImYsjP4BUbOvcddMf3AE6FYy2R4U=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=OT4jXWvhqFup2NwIlGO7/Dsj87GE64Qafm96DMEcwkjhZXb49lct0TQM1G8SOvgF3
         sVSjEgVEpLiiBByJk3JbKThFVAlJ4iPpl0CTTB2K6PxkkSlISR+uygQR/royD6kmX+
         RTk5Wx3tvQlLHk4QVn9skqXp6RZRs3JBUM4xPH/ZQzMGQUhp3l/efZqIeFSaMKjgvd
         BgxBWJ12FhY4h2tn0eP9RqeOWP7ONmC4ZOIsRT/wLw4rXEc5ThjnnkyMV5xddDgZSx
         piq9enB19Vsuwk+tzp6GTur3uq2LbT17pn++zbPeBeQmp2agONeJSHj8F+r64lpeqk
         UjN5Cun9WxHWQ==
Date:   Wed, 2 Mar 2022 19:58:16 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     Kishon Vijay Abraham I <kishon@ti.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/2] dt-bindings: phy: qcom,qmp: add sc8180x and
 sc8280xp ufs compatibles
Message-ID: <Yh9/ALkRZJYla2MA@matsya>
References: <20220225035105.2294599-1-bjorn.andersson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220225035105.2294599-1-bjorn.andersson@linaro.org>
X-Spam-Status: No, score=-7.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 24-02-22, 19:51, Bjorn Andersson wrote:
> Add compatible for the UFS PHY found in the Qualcomm SC8280XP platform
> and document the required clocks for this and the SC8180X UFS PHY.

Applied all, thanks

-- 
~Vinod
