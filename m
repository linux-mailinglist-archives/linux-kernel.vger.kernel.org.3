Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5069D566407
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Jul 2022 09:26:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231215AbiGEH0R (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Jul 2022 03:26:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231193AbiGEH0M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jul 2022 03:26:12 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 548F412AD2;
        Tue,  5 Jul 2022 00:26:11 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id A8F3CCE18D9;
        Tue,  5 Jul 2022 07:26:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0DA5AC341C7;
        Tue,  5 Jul 2022 07:26:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1657005967;
        bh=2ke/GFcpKNlkf1abJKLSvHpq01nNyM6rM105EyusMAo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=vD0UG/32u10tfpK5mUHaEpKbdaZsSMrAG0z8MyitWdYIoKNOhHDh6YZqHz5nbnELi
         6bB0xZ57sqZJtTzEgLXxTQzJtzPi7rO5urI6IiVNe7wNjPETXJUGRqb8WL4H+HBcnu
         5FRoskCWb2Qtr58GAwwpSQrewL7BMIec4zEh1RB0jbll1RAAF+BKcU7UeZ0b3IxejS
         j3k/L622MeDjlD0CnjQPmYst5ZlCCK95RJQX4VoKuWbyV/rs+DoPDjXpU65MyFljfx
         cwE3qB9L4UmImykpNnecYDQhRXiMFVoqpE/fAhkLQUkbA4eqD/XIH2KWiw3dnWjzPq
         U0skef4+wZo6w==
Date:   Tue, 5 Jul 2022 12:56:02 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Robert Marko <robimarko@gmail.com>
Cc:     agross@kernel.org, bjorn.andersson@linaro.org, kishon@ti.com,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        dmitry.baryshkov@linaro.org
Subject: Re: [PATCH v4 1/3] phy: qcom-qmp-pcie: make pipe clock rate
 configurable
Message-ID: <YsPnirGLLlBdOZsL@matsya>
References: <20220621195512.1760362-1-robimarko@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220621195512.1760362-1-robimarko@gmail.com>
X-Spam-Status: No, score=-7.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 21-06-22, 21:55, Robert Marko wrote:
> IPQ8074 Gen3 PCIe PHY uses 250MHz as the pipe clock rate instead of 125MHz
> like every other PCIe QMP PHY does, so make it configurable as part of the
> qmp_phy_cfg.

Applied, thanks

-- 
~Vinod
