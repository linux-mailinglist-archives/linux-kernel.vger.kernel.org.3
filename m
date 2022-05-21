Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9FEDC52F845
	for <lists+linux-kernel@lfdr.de>; Sat, 21 May 2022 06:15:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343862AbiEUEOz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 21 May 2022 00:14:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233175AbiEUEOv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 21 May 2022 00:14:51 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10C6BB227D;
        Fri, 20 May 2022 21:14:49 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id A5ABEB80011;
        Sat, 21 May 2022 04:14:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 43926C385A5;
        Sat, 21 May 2022 04:14:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1653106487;
        bh=7gM14UvdWAoUM3vw+F70R7QTBfcPO+x3EXyC2ksiP5Q=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=H7qk/Ipgntr4U5EYaEa7XRNb4Of6ZBLxywWEQnHa1IfWDXEIt3SXD8GOEAdTcjRwD
         Ox/E3yTX77qLt1NTywtdGcq3IQJ1ZTcBVUjfI4SCVm7xnWiOkntglcA+pmGrwJRENx
         2K4I93WFtEum6dngyCADKlzLR5oDtzakknb/0EOdXraGxkPXz6VbJaSq7FGSQyMj6B
         Zt4ubXp7Cfyrig5oc5dhcESk3q7fwaq6RrkdV70z7oernbvYWHMscoaT3c7l583vRr
         QExx+RT3e2Jw6Zu/0B28RPcYLz7seM6phnCq+nwFysCH8witjVh07ekVlWfzRpnl3d
         4NQ+ZFopRwQlg==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20220516070600.7692-2-gabriel.fernandez@foss.st.com>
References: <20220516070600.7692-1-gabriel.fernandez@foss.st.com> <20220516070600.7692-2-gabriel.fernandez@foss.st.com>
Subject: Re: [PATCH v4 01/14] dt-bindings: rcc: stm32: add new compatible for STM32MP13 SoC
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
Date:   Fri, 20 May 2022 21:14:45 -0700
User-Agent: alot/0.10
Message-Id: <20220521041447.43926C385A5@smtp.kernel.org>
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting gabriel.fernandez@foss.st.com (2022-05-16 00:05:47)
> From: Gabriel Fernandez <gabriel.fernandez@foss.st.com>
>=20
> New compatible to manage clock and reset of STM32MP13 SoC.
>=20
> Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
> Signed-off-by: Gabriel Fernandez <gabriel.fernandez@foss.st.com>
> ---

Applied to clk-next
