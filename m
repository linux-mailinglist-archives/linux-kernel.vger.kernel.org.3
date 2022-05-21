Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9C66452F873
	for <lists+linux-kernel@lfdr.de>; Sat, 21 May 2022 06:17:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354580AbiEUERJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 21 May 2022 00:17:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354627AbiEUEQm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 21 May 2022 00:16:42 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A96D1EC6A;
        Fri, 20 May 2022 21:16:31 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id D286EB80011;
        Sat, 21 May 2022 04:16:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 86C38C385AA;
        Sat, 21 May 2022 04:16:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1653106588;
        bh=4wNqefbzGqvHmEmwIjbKQ79o6ZIZqb1FpmXJ7eMWmVs=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=mXrTBOLkUTk9NIIuBmLk+PsjjlsRVlzb5ppywkNfus6xDNVwfhSFNyKX8sFk2T9jQ
         f2AIUBno2z1WKXU2e6VOQjW/D7exSZGAtpmisrLaCyyftDWUPq6Gm+F7EWi4/DBL1q
         tIAdXtxi7dZWWMCDZZNFl4zVry6pIvnScNMWhQULWzgt1xzhbTTG1t1LaATkIJdJgy
         8VtTcnsyTQ4RcZMJzWSuZ76redz44iJD8+578kSbkpziJ2J/m732V8TUhU+q1l9hPs
         PinwljdRK2T7Dz+pfoWgqjSikpPhYlngMy9AJ7ZI+sgprb3dftxeJm3Wxb+TOUYMcF
         2wF/q07n0BDnQ==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20220516070600.7692-12-gabriel.fernandez@foss.st.com>
References: <20220516070600.7692-1-gabriel.fernandez@foss.st.com> <20220516070600.7692-12-gabriel.fernandez@foss.st.com>
Subject: Re: [PATCH v4 11/14] clk: stm32mp13: add safe mux management
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
Date:   Fri, 20 May 2022 21:16:26 -0700
User-Agent: alot/0.10
Message-Id: <20220521041628.86C38C385AA@smtp.kernel.org>
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting gabriel.fernandez@foss.st.com (2022-05-16 00:05:57)
> From: Gabriel Fernandez <gabriel.fernandez@foss.st.com>
>=20
> Some muxes need to set a the safe position when clock is off.
>=20
> Signed-off-by: Gabriel Fernandez <gabriel.fernandez@foss.st.com>
> ---

Applied to clk-next
