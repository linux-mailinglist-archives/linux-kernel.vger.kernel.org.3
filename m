Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2FBA352F872
	for <lists+linux-kernel@lfdr.de>; Sat, 21 May 2022 06:17:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354563AbiEUEQ6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 21 May 2022 00:16:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354600AbiEUEQZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 21 May 2022 00:16:25 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2810A14D28;
        Fri, 20 May 2022 21:16:16 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 4C897B82DC0;
        Sat, 21 May 2022 04:16:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 07AFFC385A9;
        Sat, 21 May 2022 04:16:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1653106573;
        bh=GXl4fheAypsewLYAFsARnQq1bewWK3sUj5kcyqf5yWU=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=ZZeL7ePzvWKDwyML5KIiDZki/JJ2k7cpAZWZou/I7no8XtySimIkf4MKcuuI6Pp1b
         DNtoIAiCgzU4EPGSlE+m1jEviNCoFOD2tOWlYoL6fWrKTuTisqwrU9mRa9FEgVW/Yk
         NGIgKrADonEpyCUtkt2Ai0HDH9MwvyRXIAdm61B7EPmg9Sd9q2ZUiWulWwvjYf9p7D
         wCpafkCBmok11k+oVbYjYeJ7sV72LHDnGfS05/Az//rOh5d5ATrczuYngScbWEC0uw
         MazJnfptUTk+kroIUQagBAIDAbDmq+wi+GXLUYUmeUmoK9Nyr4q1aU4a1VvUTY3D+F
         /6RhBvub1FzKw==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20220516070600.7692-11-gabriel.fernandez@foss.st.com>
References: <20220516070600.7692-1-gabriel.fernandez@foss.st.com> <20220516070600.7692-11-gabriel.fernandez@foss.st.com>
Subject: Re: [PATCH v4 10/14] clk: stm32mp13: add multi mux function
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
To:     Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Gabriel Fernandez <gabriel.fernandez@foss.st.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Rob Herring <robh+dt@kernel.org>
Date:   Fri, 20 May 2022 21:16:11 -0700
User-Agent: alot/0.10
Message-Id: <20220521041613.07AFFC385A9@smtp.kernel.org>
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting gabriel.fernandez@foss.st.com (2022-05-16 00:05:56)
> From: Gabriel Fernandez <gabriel.fernandez@foss.st.com>
>=20
> Some RCC muxes can manages two output clocks with same register.
>=20
> Signed-off-by: Gabriel Fernandez <gabriel.fernandez@foss.st.com>
> ---

Applied to clk-next
