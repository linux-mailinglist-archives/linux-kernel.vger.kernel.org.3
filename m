Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C8BB849474F
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jan 2022 07:29:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358732AbiATG3l (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Jan 2022 01:29:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1358720AbiATG3k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jan 2022 01:29:40 -0500
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee2:21ea])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DAC28C061574;
        Wed, 19 Jan 2022 22:29:39 -0800 (PST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4JfXfl22hFz4y3h;
        Thu, 20 Jan 2022 17:29:35 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ellerman.id.au;
        s=201909; t=1642660177;
        bh=R8Lod9NCI3CxXO/2uoFfkneQILqcaNlu86/osFgCPZw=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=gW8o1nPnWaSH1pl/Q48PFuObAFuQuO44Q1u+3v7D0bT8MRNn9d67w3bhfzPNngK/L
         eMahvidGZXdGUDyOmAZ75zHT3iSfy+LFaSreoZYPsNsSj7H76oAuPO5oGSfc+dduTo
         iaOexIEQXOnU9b0BBHXIC7oH/W2A4gY8gamLFzQCZF5DicbhrHCBiQGptGOSuz0Lnv
         yEks+86Pe2rnmuPaxzrBzPS5BYLviPiPlr3wvcjIG74WkbnS6I41KADbc4o6eLJxGA
         8JWYs+M6lyOtIzrVTZffJ8b6Ft9heTlm1oFoYLIww2OzIO4Ns2nPEW/A9ICbivLrxC
         FQn2VQ4J3YZ4w==
From:   Michael Ellerman <mpe@ellerman.id.au>
To:     Maxim <bigunclemax@gmail.com>, vladimir.oltean@nxp.com
Cc:     andrew@lunn.ch, benh@kernel.crashing.org, bigunclemax@gmail.com,
        davem@davemloft.net, devicetree@vger.kernel.org, fido_max@inbox.ru,
        linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        paulus@samba.org, robh+dt@kernel.org
Subject: Re: [PATCH v2] powerpc: dts: t1040rdb: fix ports names for Seville
 Ethernet switch
In-Reply-To: <20220111173723.26212-1-bigunclemax@gmail.com>
References: <20220111152947.6zvt7j7366wsg6o2@skbuf>
 <20220111173723.26212-1-bigunclemax@gmail.com>
Date:   Thu, 20 Jan 2022 17:29:31 +1100
Message-ID: <87czkmudh0.fsf@mpe.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Maxim <bigunclemax@gmail.com> writes:
> From: Maxim Kiselev <bigunclemax@gmail.com>
>
> On board rev A, the network interface labels for the switch ports
> written on the front panel are different than on rev B and later.
>
> This patch fixes network interface names for the switch ports according
> to labels that are written on the front panel of the board rev B.
> They start from ETH3 and end at ETH10.
>
> This patch also introduces a separate device tree for rev A.
> The main device tree is supposed to cover rev B and later.
>
> Signed-off-by: Maxim Kiselev <bigunclemax@gmail.com>
> Reviewed-by: Maxim Kochetkov <fido_max@inbox.ru>
> ---
>  arch/powerpc/boot/dts/fsl/t1040rdb-rev-a.dts | 30 ++++++++++++++++++++
>  arch/powerpc/boot/dts/fsl/t1040rdb.dts       |  8 +++---
>  2 files changed, 34 insertions(+), 4 deletions(-)
>  create mode 100644 arch/powerpc/boot/dts/fsl/t1040rdb-rev-a.dts

I applied this but it generated errors, you should have got some reports
from the kernel build robot.

cheers
