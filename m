Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C729452F857
	for <lists+linux-kernel@lfdr.de>; Sat, 21 May 2022 06:15:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343760AbiEUEPz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 21 May 2022 00:15:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354530AbiEUEPl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 21 May 2022 00:15:41 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26B20196692;
        Fri, 20 May 2022 21:15:37 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A88B36092E;
        Sat, 21 May 2022 04:15:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 06454C385A5;
        Sat, 21 May 2022 04:15:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1653106536;
        bh=qPriblw4rk+2h3lqeQI8PWrSU3HXCVp+/fQ79FYviWA=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=mY2YGO/yRR4izeKfc6W+jKzXEA8MRJxXcGs5Dvli87rzL0Klh26AEsLN5df7WKaaQ
         zNVGg8EKwNDvNp5pboE3KKHwfQiTIS78bralzevsb67qJaYD3UNcvGbzV69XBJza9h
         H53VORErvdUZ7x6G+tTxadU2Q6dNXZOAZAB5wNLME0A8ahiAx/zLZRtB6ZQBXgGRPH
         5EwPyBzxii0OrvHEmVVFk1lz0ePXUC5pVmLP23Hg+zrPn/8Ykkw2SNstWAJCu9p74L
         EBTPY0idQNK7IKK7fGzWpHNeB20bZIDg+kZZEb4qZwRVm95ETequOC1UDcGTY2EJXX
         h3OT9wzwp6ZOQ==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20220516070600.7692-7-gabriel.fernandez@foss.st.com>
References: <20220516070600.7692-1-gabriel.fernandez@foss.st.com> <20220516070600.7692-7-gabriel.fernandez@foss.st.com>
Subject: Re: [PATCH v4 06/14] clk: stm32mp13: add composite clock
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
Date:   Fri, 20 May 2022 21:15:34 -0700
User-Agent: alot/0.10
Message-Id: <20220521041536.06454C385A5@smtp.kernel.org>
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting gabriel.fernandez@foss.st.com (2022-05-16 00:05:52)
> From: Gabriel Fernandez <gabriel.fernandez@foss.st.com>
>=20
> Just to introduce management of stm32 composite clock.
>=20
> Signed-off-by: Gabriel Fernandez <gabriel.fernandez@foss.st.com>
> ---

Applied to clk-next
