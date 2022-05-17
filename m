Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1060B529F76
	for <lists+linux-kernel@lfdr.de>; Tue, 17 May 2022 12:31:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344291AbiEQKaO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 May 2022 06:30:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344221AbiEQK3x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 May 2022 06:29:53 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A1DD1CA;
        Tue, 17 May 2022 03:29:52 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D217761625;
        Tue, 17 May 2022 10:29:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9EF0FC34113;
        Tue, 17 May 2022 10:29:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1652783391;
        bh=EM3NqtS9pkUfuQgYoW/nMsk0n8LnITURDPKnZJUO2jQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=QaTwCSVuTMjiW0VJy6Pu/Q56Rt0+4XaIVH804hLYyCC43eocUDAbI3qD8CA2JVF3a
         Flg1euvuvathvngZ0FF2VFbQm0mxnNOiclkDD59p9TKNRh35gGr8fWBH39GD+sLaIe
         xRQ3jye9UAnYj9hE86WruRJBzBLDXQVO1ZIe0O7+8z0SyodxxpPXnewWK4E0wyQ/9g
         oucPvESIk0fqdUGSvFXe0GbEkBGQjNu4o5A4xeOahg802DjYRmfKcSDuZfowu+gce+
         wdCvLhVeUrcrQc/Vfy6s/XP3EMyGrq2ioS0HcpJlyBL7vktX4NEEWpPHF7MUm8+X/R
         gFxFlNo3EoBoA==
Date:   Tue, 17 May 2022 15:59:47 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 2/2] clk: qcom: add sc8280xp GCC driver
Message-ID: <YoN5G9VMFJUd6Onp@matsya>
References: <20220505025457.1693716-1-bjorn.andersson@linaro.org>
 <20220505025457.1693716-3-bjorn.andersson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220505025457.1693716-3-bjorn.andersson@linaro.org>
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04-05-22, 19:54, Bjorn Andersson wrote:
> Add support for the Global Clock Controller found in the Qualcomm
> SC8280XP platform.

Reviewed-by: Vinod Koul <vkoul@kernel.org>

-- 
~Vinod
