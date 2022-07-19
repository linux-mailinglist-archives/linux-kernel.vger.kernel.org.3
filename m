Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EC7795793C8
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Jul 2022 09:04:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234970AbiGSHEz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Jul 2022 03:04:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234012AbiGSHEx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jul 2022 03:04:53 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C600331DFF;
        Tue, 19 Jul 2022 00:04:52 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5E96361658;
        Tue, 19 Jul 2022 07:04:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8F5C6C341C6;
        Tue, 19 Jul 2022 07:04:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1658214291;
        bh=A4C0jcLWbw5eTQtyHQPhjBsYHmiVfNG4D86dfCO5Ujo=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=NCPJOa1HVRbRkzrVQhu12U8H2cs2fal6N1kdmBHkfV0rNMlk0luq5KneJuAQELE9C
         nd2nC169BS9H+L/00LvyDzq7zZjmfF5l/pRIn7yZJNwyPNmNgq7m5pYXivS9iBLCKw
         0cB9yl++pbbTllbIRqBZd+ytsdw1t7t16k0g71CewYcvVaIwlWjEOpNMBjzJO7VWB7
         dE1T9LkoHT7XYMIPZY7qALeNzwKyxWTIZiUvJY6ErJ0N/1v954ROvDtRS2OhML1qRD
         oy5ylyU1zseH9mVBLfoL+Id/v0cjxzFt0cSbB9PKfhFo+XWZNaU3Aup8bzM29a96VF
         7r4o2wSIPCxgQ==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20220704102845.168438-2-herve.codina@bootlin.com>
References: <20220704102845.168438-1-herve.codina@bootlin.com> <20220704102845.168438-2-herve.codina@bootlin.com>
Subject: Re: [PATCH v5 1/3] clk: lan966x: Fix the lan966x clock gate register address
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     linux-usb@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-clk@vger.kernel.org,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Herve Codina <herve.codina@bootlin.com>
To:     Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Claudiu Beznea <claudiu.beznea@microchip.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Herve Codina <herve.codina@bootlin.com>,
        Horatiu Vultur <horatiu.vultur@microchip.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Rob Herring <robh+dt@kernel.org>
Date:   Tue, 19 Jul 2022 00:04:49 -0700
User-Agent: alot/0.10
Message-Id: <20220719070451.8F5C6C341C6@smtp.kernel.org>
X-Spam-Status: No, score=-7.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Herve Codina (2022-07-04 03:28:43)
> The register address used for the clock gate register is the base
> register address coming from first reg map (ie. the generic
> clock registers) instead of the second reg map defining the clock
> gate register.
>=20
> Use the correct clock gate register address.
>=20
> Fixes: 5ad5915dea00 ("clk: lan966x: Extend lan966x clock driver for clock=
 gating support")
> Signed-off-by: Herve Codina <herve.codina@bootlin.com>
> ---

Applied to clk-fixes
