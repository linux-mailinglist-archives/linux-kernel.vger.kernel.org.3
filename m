Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6291D4BC833
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Feb 2022 12:34:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240215AbiBSLfL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 19 Feb 2022 06:35:11 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:45742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239587AbiBSLfK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 19 Feb 2022 06:35:10 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6B641B127C
        for <linux-kernel@vger.kernel.org>; Sat, 19 Feb 2022 03:34:51 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 58E2C61151
        for <linux-kernel@vger.kernel.org>; Sat, 19 Feb 2022 11:34:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7D50FC004E1;
        Sat, 19 Feb 2022 11:34:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1645270490;
        bh=OKlx/FClzpOEQUKVzcalOiKnCJi/40i0qewDv8BgHPk=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=iZZfI8YVIrxGEKJgw6YE1friXXRNqMKmn+EZ2pOmjl6e7iv1dR4smYUJ0TIql5N4h
         55GAF2aF8BVJCtcItJP9eLMLN92paTVJq12ToiaTP+cI7k1uiRZZVPYJufrJt/N106
         Uk5l4hpylO7PLV0ffa6IJzlcxTnldY2nfIytL6aCeiuUKw2mUhYrYPRDTuV1JbZDa7
         4K3nFTdepXCh8rKgIoeOIuZr78nZMe7Ub9VsIOHJlqZbVt4MRo5QeCPZOhIlTWmpQW
         GROHThbBgFeZIzalITvuUY7SVyCQstk9RlbHBltyI0OWixRVFUaf8TPJmiV8zTgdWV
         MCPml7EByuZ2A==
Date:   Sat, 19 Feb 2022 12:34:45 +0100
From:   Marek =?UTF-8?B?QmVow7pu?= <kabel@kernel.org>
To:     Pali =?UTF-8?B?Um9ow6Fy?= <pali@kernel.org>
Cc:     Andrew Lunn <andrew@lunn.ch>,
        Gregory Clement <gregory.clement@bootlin.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] arm64: dts: marvell: armada-37xx: Remap IO space to bus
 address 0x0
Message-ID: <20220219123445.14940a12@thinkpad>
In-Reply-To: <20220218212526.16021-1-pali@kernel.org>
References: <20220218212526.16021-1-pali@kernel.org>
X-Mailer: Claws Mail 3.18.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 18 Feb 2022 22:25:26 +0100
Pali Roh=C3=A1r <pali@kernel.org> wrote:

> Remap PCI I/O space to the bus address 0x0 in the Armada 37xx
> device-tree in order to support legacy I/O port based cards which have
> hardcoded I/O ports in low address space.
>=20
> Some legacy PCI I/O based cards do not support 32-bit I/O addressing.
>=20
> Since commit 64f160e19e92 ("PCI: aardvark: Configure PCIe resources from
> 'ranges' DT property") this driver can work with I/O windows which have
> a different address for CPU than for PCI bus (unless there is some
> conflict with other A37xx mapping), without needing additional support
> for this in the firmware.
>=20
> Note that DDR on A37xx is mapped to bus address 0x0 and that mapping of
> I/O space can be set to address 0x0 too because MEM space and I/O space
> are separate and so they do not conflict.
>=20
> Signed-off-by: Pali Roh=C3=A1r <pali@kernel.org>
> Reported-by: Arnd Bergmann <arnd@arndb.de>

Reviewed-by: Marek Beh=C3=BAn <kabel@kernel.org>
