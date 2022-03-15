Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AB5F94DA68C
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Mar 2022 01:00:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352700AbiCPABJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Mar 2022 20:01:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344372AbiCPABI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Mar 2022 20:01:08 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E63E05BE75;
        Tue, 15 Mar 2022 16:59:55 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 82FFD61537;
        Tue, 15 Mar 2022 23:59:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DBDEDC340E8;
        Tue, 15 Mar 2022 23:59:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1647388794;
        bh=VIGn1ncc/0gbk0CSV7hTIb7IyEeDRexfDbUxge/z2yo=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=Xs8Bw6DTVN1p+y1/8dm4UTd0+HPW41Aj8RH7gToMBUnVtWS4MK2n7FTAHN8ie1GlM
         RtYPLDvVm9NZTCfjakfa5FvgLtjlGpfV7Db6A5JUJifrzHjHu0fC9K8B1CW0/19POc
         QTm9u5I3cUecjDAoEurX7mfjqOVLcCnP6KoKG5qBlcWb/t2To7oBg8SnRviVTgyrWT
         omshvAgSWlPAO1T4x+jmtuRMwyx9xd8xwmQzvCYTOA0kuGg8JG2OXYh7k0WowP+bVP
         w1P9lpryqnz+O15F9F0FScPN9Dy3EHyyEOvlj/yKcFZrbazkFEAye/ApZadXRI442X
         tk9jWtZ7zwk1g==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <f9284873c2993a9952d9fe4f8dd5e89f20daab75.1646388139.git.zong.li@sifive.com>
References: <cover.1646388139.git.zong.li@sifive.com> <f9284873c2993a9952d9fe4f8dd5e89f20daab75.1646388139.git.zong.li@sifive.com>
Subject: Re: [PATCH v2 2/5] dt-bindings: change the macro name of prci in header files and example
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     Zong Li <zong.li@sifive.com>, Rob Herring <robh@kernel.org>,
        Palmer Dabbelt <palmer@rivosinc.com>
To:     Zong Li <zong.li@sifive.com>, devicetree@vger.kernel.org,
        lee.jones@linaro.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
        mturquette@baylibre.com, palmer@dabbelt.com,
        paul.walmsley@sifive.com, robh+dt@kernel.org
Date:   Tue, 15 Mar 2022 16:59:53 -0700
User-Agent: alot/0.10
Message-Id: <20220315235954.DBDEDC340E8@smtp.kernel.org>
X-Spam-Status: No, score=-8.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Zong Li (2022-03-04 02:03:18)
> We currently change the macro name for fu540 and fu740 by adding the
> prefix respectively, the dt-bindings should be modified as well.
>=20
> Signed-off-by: Zong Li <zong.li@sifive.com>
> Acked-by: Rob Herring <robh@kernel.org>
> Acked-by: Palmer Dabbelt <palmer@rivosinc.com>
> ---

Applied to clk-next
