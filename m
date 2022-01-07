Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 406BA486FF0
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jan 2022 02:52:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344531AbiAGBwI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Jan 2022 20:52:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344429AbiAGBwH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jan 2022 20:52:07 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4741C0611FD;
        Thu,  6 Jan 2022 17:52:06 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id A02F9B824A3;
        Fri,  7 Jan 2022 01:52:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4AACFC36AE5;
        Fri,  7 Jan 2022 01:52:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1641520324;
        bh=8aNMSd2LjTF1fT1O87x/hjzHQzOifUmvU82cq4e1PiM=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=e+C1JuNtmxO1Oh6o8u89tQZQmtbZcFpg89UQ+938qT3Res9XRoHc+ctOmI4VgqsQJ
         ZkdEthZ9mD1ZnCFjyHuFj8sWiqwKFH5Ps0HjYJ+wApUVGLuX7oNPedmtNB70584uag
         0pfR75L1SLKc/t3WJNHkl0KWW9FHSEh88Eh/TIbSaUQRdw9qfNrkmqysikkZmIleBv
         kZc9XTvKVwuetTAC8lScpEEssRg0GGmQiQ9Xt854GQ0Md/5KHYdUt5AVw2zLko5fs/
         pwnXYtmUd4lfuHbloMQfkXRi8DKWxwwuIr225sQz+J+P3N7Xjw3Glnjn7pcXZB1BbV
         tN+zS4s6SwyIQ==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20211220193319.114974-3-paul@crapouillou.net>
References: <20211220193319.114974-1-paul@crapouillou.net> <20211220193319.114974-3-paul@crapouillou.net>
Subject: Re: [PATCH v3 2/2] clk: ingenic: Add MDMA and BDMA clocks
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     list@opendingux.net, linux-mips@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, Paul Cercueil <paul@crapouillou.net>
To:     Michael Turquette <mturquette@baylibre.com>,
        Paul Cercueil <paul@crapouillou.net>,
        Rob Herring <robh+dt@kernel.org>
Date:   Thu, 06 Jan 2022 17:52:03 -0800
User-Agent: alot/0.9.1
Message-Id: <20220107015204.4AACFC36AE5@smtp.kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Paul Cercueil (2021-12-20 11:33:19)
> The Ingenic JZ4760 and JZ4770 both have an extra DMA core named BDMA
> dedicated to the NAND and BCH controller, but which can also do
> memory-to-memory transfers. The JZ4760 additionally has a DMA core named
> MDMA dedicated to memory-to-memory transfers. The programming manual for
> the JZ4770 does have a bit for a MDMA clock, but does not seem to have
> the hardware wired in.
>=20
> Add the BDMA and MDMA clocks to the JZ4760 CGU code, and the BDMA clock
> to the JZ4770 code, so that the BDMA and MDMA controllers can be used.
>=20
> Signed-off-by: Paul Cercueil <paul@crapouillou.net>
> ---

Applied to clk-next
