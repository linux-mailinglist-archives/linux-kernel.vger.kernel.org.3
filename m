Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 77D2B4DA699
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Mar 2022 01:02:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352729AbiCPAD6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Mar 2022 20:03:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352717AbiCPAD4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Mar 2022 20:03:56 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5E305DE4F;
        Tue, 15 Mar 2022 17:02:42 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 723E96149A;
        Wed, 16 Mar 2022 00:02:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C7C86C340E8;
        Wed, 16 Mar 2022 00:02:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1647388961;
        bh=gSjwqWfs0xHAYr2djQjQy7OqRlnUPhxMCbMqx3FoaNo=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=tRV99RsTh7UBRLm80E74A83E1av840luLqyGcVBIazJDG+QAvwJrmzIOkRn3GVndU
         dcbiUWNiOMAv2xwvEHVGd427Hm0z9vbzaOEdtP4KgurnRm6UykHbeO6vGx0qAT39YX
         Mai0EkzClKVJRGExXv3sEp8zY3Pj3S+zOGKxi01T1i/sFIFAprjMBbek7m8M87oLKz
         Gu7KTw7PNfgIakn3khUNKxEbdHA/Q4UXPk0Dr1MQ5mvp+ySnqfdwLdSFoYHCn+6r/R
         uyX+Sa2CvMuTSuW8ZRzLm7ZSl9kg7CaitKm+4UiVUZmnZGwkaBu7hDQEZ26accK9ci
         ExUnIdJ7hUMww==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <a3c7ec5c46c1d8be455d1c347db4855bb56cec53.1646388139.git.zong.li@sifive.com>
References: <cover.1646388139.git.zong.li@sifive.com> <a3c7ec5c46c1d8be455d1c347db4855bb56cec53.1646388139.git.zong.li@sifive.com>
Subject: Re: [PATCH v2 5/5] clk: sifive: Move all stuff into SoCs header files from C files
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     Zong Li <zong.li@sifive.com>, Palmer Dabbelt <palmer@rivosinc.com>
To:     Zong Li <zong.li@sifive.com>, devicetree@vger.kernel.org,
        lee.jones@linaro.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
        mturquette@baylibre.com, palmer@dabbelt.com,
        paul.walmsley@sifive.com, robh+dt@kernel.org
Date:   Tue, 15 Mar 2022 17:02:40 -0700
User-Agent: alot/0.10
Message-Id: <20220316000241.C7C86C340E8@smtp.kernel.org>
X-Spam-Status: No, score=-8.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Zong Li (2022-03-04 02:03:21)
> Improve PRCI driver to reduce the complexity, we remove the SoCs C files
> by putting all stuff in each SoCs header files, and include these
> SoCs-specific header files in core of PRCI. It can also avoid the W=3D1
> kernel build warnings about variable defined but not used
> [-Wunused-const-variable=3D], like commit 487dc7bb6a0c ("clk: sifive:
> fu540-prci: Declare static const variable 'prci_clk_fu540' where it's
> used") does.
>=20
> Signed-off-by: Zong Li <zong.li@sifive.com>
> Suggested-by: Lee Jones <lee.jones@linaro.org>
> Reviewed-by: Lee Jones <lee.jones@linaro.org>
> Acked-by: Palmer Dabbelt <palmer@rivosinc.com>
> ---

Applied to clk-next
