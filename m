Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5FF24572DE2
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Jul 2022 08:07:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234117AbiGMGHm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Jul 2022 02:07:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229568AbiGMGHl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jul 2022 02:07:41 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6848E9FE14;
        Tue, 12 Jul 2022 23:07:40 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 13B0DB81C13;
        Wed, 13 Jul 2022 06:07:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EC7C9C341C6;
        Wed, 13 Jul 2022 06:07:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1657692457;
        bh=PGjtPrJEPTf/72LLV3qAcGcGsp8I6w2AwRMY1DZJTyQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=jyASqPhDBB+76WOVuFljq3hv03BsQlkA3rh8uS2mAyt+3kqKZmrjTVcdeQkYIsUkt
         5WsA8QYkLKdkKD3bepCpQjaABIxWU9ddv1z6NIoDyM6XJVxFqf66xm8CF763IehB/Y
         6LslmGA/738L1rqMSydw8dDHdNzrZX5Ic1GvNYX2b7xJ4+KJxMLB+p1bq8jPLxV61Z
         st3uwK2/ikysnh8ECBCbzTPJr/DNkRbSNde+zooY+1UezXsxgZfcaVkX+TaXeBT/H7
         orgfiicgwIpWCyKDg0Dze6YyFivYyiP737h9fTzJ10t6qV56S0Jen18wN+rDmRT/3b
         lGzaJnpbm+jvA==
Date:   Wed, 13 Jul 2022 11:37:33 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org
Subject: Re: [PATCH] arm64: defconfig: Demote Qualcomm USB PHYs to modules
Message-ID: <Ys5hJSRqRGWm27xg@matsya>
References: <20220712031821.4134712-1-bjorn.andersson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220712031821.4134712-1-bjorn.andersson@linaro.org>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11-07-22, 20:18, Bjorn Andersson wrote:
> The Qualcomm USB PHYs are not critical for reaching the ramdisk to load
> modules, so they can be demoted to be built as such instead of builtin.

Reviewed-by: Vinod Koul <vkoul@kernel.org>

-- 
~Vinod
