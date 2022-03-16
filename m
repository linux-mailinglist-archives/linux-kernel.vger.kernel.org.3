Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 754C64DA697
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Mar 2022 01:02:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352711AbiCPADw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Mar 2022 20:03:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352704AbiCPADu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Mar 2022 20:03:50 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A1B05DA72;
        Tue, 15 Mar 2022 17:02:36 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 196C6B819AA;
        Wed, 16 Mar 2022 00:02:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ACFF6C340E8;
        Wed, 16 Mar 2022 00:02:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1647388953;
        bh=EyOsPySWxTjLPtQ+W1dS//mkQk4bJni7kyKXhYQWRNA=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=hm1nUPeb1uEtxYW7f9X75DtmwuiNriskOOw0rJ9KrfYu7WVWcOvm/LmGtvRLCXSRY
         oljvhPhErwiOPpltM/ql+A/20PU1gKAkfStDscN48SwnDeNrZrqa186/8TwHAsnr6j
         FHVYmL9csvVBCc5Fo1PklMVAsPkkn36kMLL5s6/HZ3PvK+1/uZz0bKqnWFEsrjbeid
         emW10G7jTWqz8sDthxypHx3o4WkgGEvlHCgtPklgUBtkhMHR1Zivr9TJSkurS9mwLt
         RSja2GwwX88Z+TMSxNYHElb422x8PwyNoPhzJclBpRfKzZlO0PyrAr1w2WOnlD8XjU
         SeyZOiSMDp5og==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <7728ef662c59449ce954b1b62c6ad5241e07adfb.1646388139.git.zong.li@sifive.com>
References: <cover.1646388139.git.zong.li@sifive.com> <7728ef662c59449ce954b1b62c6ad5241e07adfb.1646388139.git.zong.li@sifive.com>
Subject: Re: [PATCH v2 4/5] clk: sifive: Add SoCs prefix in each SoCs-dependent data
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     Zong Li <zong.li@sifive.com>, Palmer Dabbelt <palmer@rivosinc.com>
To:     Zong Li <zong.li@sifive.com>, devicetree@vger.kernel.org,
        lee.jones@linaro.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
        mturquette@baylibre.com, palmer@dabbelt.com,
        paul.walmsley@sifive.com, robh+dt@kernel.org
Date:   Tue, 15 Mar 2022 17:02:31 -0700
User-Agent: alot/0.10
Message-Id: <20220316000233.ACFF6C340E8@smtp.kernel.org>
X-Spam-Status: No, score=-8.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Zong Li (2022-03-04 02:03:20)
> This patch is prerequisite for moving SoCs C files into SoCs header
> files. Currently, fu540-prci.c and fu740-prci.c use same names for
> several macro definitions and variables, it would cause redefinition
> error when we trying to include all stuff in sifive-prci.c. In this
> patch, we also remove the temporary macro definitions which are
> added by previous patch.
>=20
> Signed-off-by: Zong Li <zong.li@sifive.com>
> Acked-by: Palmer Dabbelt <palmer@rivosinc.com>
> ---

Applied to clk-next
