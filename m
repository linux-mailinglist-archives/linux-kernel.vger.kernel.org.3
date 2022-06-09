Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C357B545788
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Jun 2022 00:41:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345770AbiFIWlS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Jun 2022 18:41:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232459AbiFIWlM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jun 2022 18:41:12 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3342C46B1C;
        Thu,  9 Jun 2022 15:41:11 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id BF88F61F9F;
        Thu,  9 Jun 2022 22:41:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1C263C341C6;
        Thu,  9 Jun 2022 22:41:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1654814470;
        bh=Y2HSc7Z1jkQzEuKspOkg7ZQGwg1OrCZ4VW4G4GMSY4I=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=ruo0HLJE8t8a0RVco/KAktGvDSmV2fwOXlvpQxKyuw0PSIQjLRwrUYS/7RB2DvEyf
         R3stsc28bt9HkRCgupXMe8wOWpaw1K8mIP5tQ3eI3OvSaex+Ikai5j8es07gbtEBiI
         F70kUPFq1Kh2jyQ+HaPA0FYs/hNR20YW6ViOaI9ZRkMG2pdmRbWYZGoQr7dz0wEtYj
         Y4LT2CTljEIDC1LsNRt/mGIBAcKIwZw2Q/KBwHUczCXoXQ9J3+vZgDRGUkK/4ki7ze
         kb9k/sMPKFun9q1knnGZco2BiRczpu6XvqSM0EhVhGYEu3i+fd+FxnxFhJZtiErSnN
         P3Psi0p3LLGiw==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20220531051742.43273-2-samuel@sholland.org>
References: <20220531051742.43273-1-samuel@sholland.org> <20220531051742.43273-2-samuel@sholland.org>
Subject: Re: [PATCH 2/2] dt-bindings: clock: fixed-factor: Drop Allwinner A10 compatible
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     Jernej Skrabec <jernej.skrabec@gmail.com>,
        Chen-Yu Tsai <wens@csie.org>,
        Maxime Ripard <mripard@kernel.org>,
        Samuel Holland <samuel@sholland.org>,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org
To:     Michael Turquette <mturquette@baylibre.com>,
        Samuel Holland <samuel@sholland.org>
Date:   Thu, 09 Jun 2022 15:41:08 -0700
User-Agent: alot/0.10
Message-Id: <20220609224110.1C263C341C6@smtp.kernel.org>
X-Spam-Status: No, score=-8.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Samuel Holland (2022-05-30 22:17:42)
> This compatible is part of the legacy sunxi clock support, and has not
> been used since commit 6b48644b1d29 ("ARM: gr8: Convert to CCU") in
> October 2016. Now that the code for this compatible has been removed,
> let's drop the compatible.
>=20
> Signed-off-by: Samuel Holland <samuel@sholland.org>
> ---

Applied to clk-next
