Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 84F224D6C28
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Mar 2022 03:54:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230157AbiCLCza (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Mar 2022 21:55:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229480AbiCLCz3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Mar 2022 21:55:29 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19F7224F78B;
        Fri, 11 Mar 2022 18:54:25 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 958BA61171;
        Sat, 12 Mar 2022 02:54:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E95DDC340E9;
        Sat, 12 Mar 2022 02:54:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1647053664;
        bh=L4dUQRs8FoT7ROYgs/J7sfaL9SDWe4mhi6JsExSzNDs=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=l7yjZgl5Zs4/1YsZLJP+XlbpOY6ZDQj3ir5Ga0PymbXAGuaKswus3xXuPhXNSDxhi
         ugL2CEgZo/4FgbqFLRpoAsDv2vbRiex0M2PmTV3Y6aqozZL03VWll4fjtal9K+TL7B
         0fMnPEVh4lnCNGt5/0WgfeSBJ5r2xH8MkKGJtWeCQYq+4aemMSR2DUc4K0vN/RKaBg
         WhaskJ2DgHNKpXHGwcZ579loFOwIzq0dYIek+nIuwcm3C2B4Ztn/ywC1aE364XWZiU
         RyssdFo/q7qtP3vdb0+DC/jQijepzm9bUXxZRSz7D2jWlIm5w5xjSC5rTjPq4PacdA
         Uv2yS1OW9zQFw==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20220225133137.813919-10-gabriel.fernandez@foss.st.com>
References: <20220225133137.813919-1-gabriel.fernandez@foss.st.com> <20220225133137.813919-10-gabriel.fernandez@foss.st.com>
Subject: Re: [PATCH v2 09/13] clk: stm32mp13: add all STM32MP13 kernel clocks
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
Date:   Fri, 11 Mar 2022 18:54:20 -0800
User-Agent: alot/0.10
Message-Id: <20220312025423.E95DDC340E9@smtp.kernel.org>
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting gabriel.fernandez@foss.st.com (2022-02-25 05:31:33)
> From: Gabriel Fernandez <gabriel.fernandez@foss.st.com>
>=20
> Completed all kernel clocks of stm32mp13.
>=20
> Change-Id: If47ae88e48d418534d6c3a9488cc803b62e0dde5

No changeid please.

> Signed-off-by: Gabriel Fernandez <gabriel.fernandez@foss.st.com>
