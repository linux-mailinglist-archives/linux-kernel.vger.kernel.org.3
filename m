Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 557044BF0A6
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Feb 2022 05:10:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230168AbiBVECZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Feb 2022 23:02:25 -0500
Received: from gmail-smtp-in.l.google.com ([23.128.96.19]:60748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229545AbiBVECT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Feb 2022 23:02:19 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C54BF3135C;
        Mon, 21 Feb 2022 20:01:41 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 31BF4B81851;
        Tue, 22 Feb 2022 04:01:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E81FAC340E8;
        Tue, 22 Feb 2022 04:01:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1645502498;
        bh=+YrMSPDyIBd73yuuFazYh2T7Cw/wvs931utX9SkopcI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=tEE+BdTqnz+YKZ0D0ACZ+ckqK2dHio40tIWT/GjuMik+vFxbBrEacN4jKCwmM547r
         edGtr2FKqKskz3NBwZ65NRrC1SRPfw3HB4FFPKPg03qdzFEV2WCqkEMD8esGXeA0yR
         FOB6C8aKVBIuv5nmh58+d3mPnGX/odBvanS5PruxVABZR58L2HCrZDp6WeujhEn6/3
         4VnsQSTPoZkEkIejLHCx/4abAjdKIp+C7fblvYgAwRa1++IsTtiAlGSPfu3BF6eG2s
         1QynUr4SKf7jpK4B2X4s0CEHx19ogzmAZZ2JnCnF14CWCdnyCGzK1Gqjmgs/uuJmy4
         T5twrxfxz801g==
Date:   Tue, 22 Feb 2022 09:31:34 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] soc: qcom: mdt_loader: Fix split-firmware condition
Message-ID: <YhRgHgp7dUkQ1+AB@matsya>
References: <20220215034819.1209367-1-bjorn.andersson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220215034819.1209367-1-bjorn.andersson@linaro.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 14-02-22, 19:48, Bjorn Andersson wrote:
> The updated condition checking if a segment can be found in the loaded
> firmware blob, or need to be loaded from a separate file, incorrectly
> classifies segments that ends at the end of the loaded blob. The result
> is that the mdt loader attempts to load the segment from a separate
> file.
> 
> Correct the conditional to use the loaded segment instead.
> 
> Fixes: ea90330fa329 ("soc: qcom: mdt_loader: Extend check for split firmware")
> Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>

Reviewed-by: Vinod Koul <vkoul@kernel.org>

-- 
~Vinod
