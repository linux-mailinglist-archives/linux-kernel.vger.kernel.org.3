Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 23B6C52F866
	for <lists+linux-kernel@lfdr.de>; Sat, 21 May 2022 06:16:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354530AbiEUEQO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 21 May 2022 00:16:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354541AbiEUEQB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 21 May 2022 00:16:01 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BCC092190;
        Fri, 20 May 2022 21:15:57 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 6D5D8B80011;
        Sat, 21 May 2022 04:15:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 17D25C385A5;
        Sat, 21 May 2022 04:15:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1653106555;
        bh=OMD1OEoIkXI4CCO3Zv1sF9ELLI90pc9Y3NqH4mrjfq0=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=P7elz0wngF3JnaJJaoZi70Gnv/ssFzE1Z7PLtjSTMDWGjg61RrWSUkvP9iiKVXHmC
         GCv3QNJRyKXv0IM9O9lIG6Erb+z3akjDMShJf+ceXma/WEO5rGFSr3aH4nB9foZSmR
         2U/4pUYbca8kRlhY/tta+n2d4HMwohfYD/re8EYMux86Y/LXxCCRnk5p+FYHeNmibz
         TMckYe31UcLwWQbjxDJmfUqbAziacaITM/T2nKnZ03rdXs+Z3zuZ7Fj+Vt7l5aIgcB
         dA4x/LgOCdwsEPHqsWSCGn5hta0aMo0YhLPdjVlpgoq4WOmUKnJvWgYUiEnNcZBc2W
         dqcXt7+gMVIJA==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20220516070600.7692-9-gabriel.fernandez@foss.st.com>
References: <20220516070600.7692-1-gabriel.fernandez@foss.st.com> <20220516070600.7692-9-gabriel.fernandez@foss.st.com>
Subject: Re: [PATCH v4 08/14] clk: stm32mp13: add all STM32MP13 peripheral clocks
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
Date:   Fri, 20 May 2022 21:15:53 -0700
User-Agent: alot/0.10
Message-Id: <20220521041555.17D25C385A5@smtp.kernel.org>
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting gabriel.fernandez@foss.st.com (2022-05-16 00:05:54)
> From: Gabriel Fernandez <gabriel.fernandez@foss.st.com>
>=20
> All peripheral clocks are mainly based on stm32_gate clock.
>=20
> Signed-off-by: Gabriel Fernandez <gabriel.fernandez@foss.st.com>
> ---

Applied to clk-next
