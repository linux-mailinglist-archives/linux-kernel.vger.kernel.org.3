Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2E8C84CA82F
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Mar 2022 15:30:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237096AbiCBObc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Mar 2022 09:31:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243121AbiCBOaK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Mar 2022 09:30:10 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D1EB6E34B;
        Wed,  2 Mar 2022 06:28:53 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 1ACA7B81FF6;
        Wed,  2 Mar 2022 14:28:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5BC28C340ED;
        Wed,  2 Mar 2022 14:28:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1646231330;
        bh=x5NhZSDTe+nBk7s18b/KMi3nUIEuVJYY1jAlwghRTyk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=lZCrFgAVl4vJwdBUJKqCZreKsAfPLt6WCJ3rKSfZYE1Ygf1C1lKiVYAWqo51qTIkz
         hKteFm4C9635nJ773d5Me4M+0h1bSFNFgLy9hk/ifpwHZvqMWT/JpVJQJfv6yuI5vw
         scC4wN4I/KiENygKF0tDoUUsxzRCL4mFlcp5opU0DFa2/rjXybuTqQ7AWpJFp10NVE
         U29UZSVNmQz7Zow63+JcBshpMw6Fjy6iG/kRaNE8rrtl45v4EH7r51r/Zx7GpJo6+N
         V9OCGCciFnIG3Xo7awHeaWrnDJRCyHXG54eTik6I6XNbwbjcJ/GHRSyKqXiTjI3yl6
         Ncm56n8TBwBEw==
Date:   Wed, 2 Mar 2022 19:58:47 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     Kishon Vijay Abraham I <kishon@ti.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Wesley Cheng <wcheng@codeaurora.org>,
        linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] dt-bindings: phy: qcom,usb-snps-femto-v2: Add
 sc8180x and sc8280xp
Message-ID: <Yh9/H9SQilPoHaa/@matsya>
References: <20220225034049.2294207-1-bjorn.andersson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220225034049.2294207-1-bjorn.andersson@linaro.org>
X-Spam-Status: No, score=-7.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 24-02-22, 19:40, Bjorn Andersson wrote:
> Add compatible for the femto USB PHY found in sc8180x, sc8280xp and the
> generic 5nm form of the latter.

Applied all, thanks

-- 
~Vinod
