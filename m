Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1F8E14C3A3E
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Feb 2022 01:22:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235997AbiBYAWN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Feb 2022 19:22:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235989AbiBYAWJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Feb 2022 19:22:09 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D460D26134;
        Thu, 24 Feb 2022 16:21:37 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6F40F61CE5;
        Fri, 25 Feb 2022 00:21:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C4277C340E9;
        Fri, 25 Feb 2022 00:21:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1645748496;
        bh=zL7K5H0gG9i3MojJhvMFQOdtVRIDLw7kDEqM24zLUlA=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=dUfqYmeiNZpNTuzZiH/9xYLYzlWiB4P+/auqvVlPa1U+gKz5qhfFBVwj9UZ6LMYQx
         vgeM1YWVAWtz1xOeeXZ6z9dGQoDigFZzzxCEll27gpvgN6mDTtiATjXZRG05uQ8lby
         oMpky7ylgWVr8jY5UeKL/0+TFKV/HinmxsqAhf/rxUU/VmUB5onQ3BwOdTqHqx2Zgo
         pq9LG0+SIhHwFTFsouc26LuFSxSJ8mlo+ozcg5qPuGZ32lQ2VkzEDiGm5zHB/p+rKg
         2Bm1X9/3DZIUWhuIhi7nmiqvH78+v5RV2N7Grt8OvlQnZAxPlncSP2Yy9d1bnPGURK
         cKT4DzX3hqhkQ==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20220223185606.3941-2-tdas@codeaurora.org>
References: <20220223185606.3941-1-tdas@codeaurora.org> <20220223185606.3941-2-tdas@codeaurora.org>
Subject: Re: [v2 2/2] clk: qcom: dispcc: Update the transition delay for MDSS GDSC
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     Rajendra Nayak <rnayak@codeaurora.org>,
        linux-arm-msm@vger.kernel.org, linux-soc@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        Taniya Das <tdas@codeaurora.org>
To:     Michael Turquette <mturquette@baylibre.com>,
        Taniya Das <tdas@codeaurora.org>
Date:   Thu, 24 Feb 2022 16:21:35 -0800
User-Agent: alot/0.10
Message-Id: <20220225002136.C4277C340E9@smtp.kernel.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Taniya Das (2022-02-23 10:56:06)
> On SC7180 we observe black screens because the gdsc is being
> enabled/disabled very rapidly and the GDSC FSM state does not work as
> expected. This is due to the fact that the GDSC reset value is being
> updated from SW.
>=20
> The recommended transition delay for mdss core gdsc updated for
> SC7180/SC7280/SM8250.
>=20
> Fixes: dd3d06622138 ("clk: qcom: Add display clock controller driver for =
SC7180")
> Fixes: 1a00c962f9cd ("clk: qcom: Add display clock controller driver for =
SC7280")
> Fixes: 80a18f4a8567 ("clk: qcom: Add display clock controller driver for =
SM8150 and SM8250")
> Signed-off-by: Taniya Das <tdas@codeaurora.org>
> ---

Applied to clk-fixes
