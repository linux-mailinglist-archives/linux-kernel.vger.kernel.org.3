Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7E7BB4BFF58
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Feb 2022 17:53:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234372AbiBVQxz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Feb 2022 11:53:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231357AbiBVQxx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Feb 2022 11:53:53 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 336A43334D;
        Tue, 22 Feb 2022 08:53:28 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C32E560FFC;
        Tue, 22 Feb 2022 16:53:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 708C8C340E8;
        Tue, 22 Feb 2022 16:53:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1645548807;
        bh=TUxBIxRT0G5OuJaTd5jQshN1DOVr2xzMdhYOQd/l81o=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=bxKgcTT/Ulyk+/DiKVeNI0Iu9KLF1yhZAMLNIvFAFk4I7djaVVSUEGoRYodftm4Do
         a6MVGkfo8w8fy294W88abJW/pEx0BJ2B5+XosRv6zkeAGOgKGkh7Vk3FFaKpFmTLGj
         k0Nzr/67IVmShBwkOQ7HQYrgXFjMse9yNX5wLLO2m5qc1iBZepO+mEMzfNIV/2kjvv
         v3RHMu6H5MkK14FhFzX7XUK9suxBf6+FNvKTYhJRxCkfJGZd1usfj7krFxhcHn1MVL
         ychDpI4Ky+9RZqiWuOziRCjsV49aRYWQ81Afs2zJxbNE43iHGXFP4YUS7CWN8aXW65
         mEapEZ6TKrvAg==
Date:   Tue, 22 Feb 2022 22:23:23 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Stephen Boyd <sboyd@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        David Collins <quic_collinsd@quicinc.com>
Cc:     linux-arm-msm@vger.kernel.org,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        David Dai <daidavid1@codeaurora.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 0/2] spmi: pmic-arb: Add support for PMIC v7
Message-ID: <YhUVAwtfjuIdKrRQ@matsya>
References: <20220201134108.2677578-1-vkoul@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220201134108.2677578-1-vkoul@kernel.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 01-02-22, 19:11, Vinod Koul wrote:
> Hello,
> 
> The is version 3 of support for PMIC v7. I have added a new property
> qcom,bus-id for supporting v7 and then add driver changes for v7
> 
> This depends on yaml conversion patch:
> https://lore.kernel.org/linux-arm-msm/20211227170151.73116-1-david@ixit.cz/

Any feedback on this...

> 
> Changes since v2:
>  - Drop yaml conversion patch
>  - Fix author for spmi patch
> Changes since v1:
>  - Add yaml conversion patch and new binding
>  - fix driver bug report by Jonathan
> 
> David Collins (1):
>   spmi: pmic-arb: Add support for PMIC v7
> 
> Vinod Koul (1):
>   dt-bindings: spmi: Add qcom,bus-id
> 
>  .../bindings/spmi/qcom,spmi-pmic-arb.yaml     |  11 +
>  drivers/spmi/spmi-pmic-arb.c                  | 233 ++++++++++++++++--
>  2 files changed, 225 insertions(+), 19 deletions(-)
> 
> -- 
> 2.31.1

-- 
~Vinod
