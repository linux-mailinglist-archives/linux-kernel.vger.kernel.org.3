Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C522C486FEC
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jan 2022 02:51:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344507AbiAGBv4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Jan 2022 20:51:56 -0500
Received: from dfw.source.kernel.org ([139.178.84.217]:45082 "EHLO
        dfw.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344415AbiAGBvz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jan 2022 20:51:55 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E6DAE61EAE;
        Fri,  7 Jan 2022 01:51:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 48E3AC36AE0;
        Fri,  7 Jan 2022 01:51:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1641520314;
        bh=aj1ErPqDs/ITG/uM0PDPwyI+d7LTz0H+L9vT1x6Z5jQ=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=lBdwHFhKyAEpkaOsLPgn1ysPm0xmmb2j1g9jSk7BlTe3tJmmYp7dkzCYYbArNRuhH
         UEQ+KHn/5b9t2h6Fyr0Yt0gBE69kRLb0/fTjBIEEbJ4hpL8cLMN3/lbwWCfnxl69ws
         +IEFio9uNo8hlOpNzkCKTn1Qrz+M3078x/7+YdWh1Ins/d+Cxo4HVUqmczEx0T+SWU
         wpRVme1tkFPX2Z3EYmR1cqfEEVjLZw7jYuoHiXKNZlG9csN3SJBYSFGThn1O52Sh4K
         ZOTp3SFuT+9OU+VswApNmDs7lK23Xnfdrlaj+rPSIQ2zXbl5mMm4fKNRlV5+Z7RBr6
         HAxy0334sHjYg==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20211220193319.114974-2-paul@crapouillou.net>
References: <20211220193319.114974-1-paul@crapouillou.net> <20211220193319.114974-2-paul@crapouillou.net>
Subject: Re: [PATCH v3 1/2] dt-bindings: clk/ingenic: Add MDMA and BDMA clocks
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     list@opendingux.net, linux-mips@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, Paul Cercueil <paul@crapouillou.net>
To:     Michael Turquette <mturquette@baylibre.com>,
        Paul Cercueil <paul@crapouillou.net>,
        Rob Herring <robh+dt@kernel.org>
Date:   Thu, 06 Jan 2022 17:51:53 -0800
User-Agent: alot/0.9.1
Message-Id: <20220107015154.48E3AC36AE0@smtp.kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Paul Cercueil (2021-12-20 11:33:18)
> The Ingenic JZ4760 and JZ4770 both have an extra DMA core named BDMA
> dedicated to the NAND and BCH controller, but which can also do
> memory-to-memory transfers. The JZ4760 additionally has a DMA core named
> MDMA dedicated to memory-to-memory transfers. The programming manual for
> the JZ4770 does have a bit for a MDMA clock, but does not seem to have
> the hardware wired in.
>=20
> Add macros for the MDMA and BDMA clocks to the dt-bindings include
> files, so that they can be used within Device Tree files.
>=20
> Signed-off-by: Paul Cercueil <paul@crapouillou.net>
> ---

Applied to clk-next
