Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 786BB4EFC3C
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Apr 2022 23:39:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352837AbiDAVlc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Apr 2022 17:41:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234406AbiDAVlb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Apr 2022 17:41:31 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A310CFB93;
        Fri,  1 Apr 2022 14:39:40 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 9C060CE26F8;
        Fri,  1 Apr 2022 21:39:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C600CC340F3;
        Fri,  1 Apr 2022 21:39:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1648849176;
        bh=Gpj96KiChSJYrco1LEnEifrxak3dPMzFR8DmbI5Y51s=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=BMbb/oXfDAnwKuMtKiAn7XIQNQFmU1cdvrW0qNXR7OYLTHqC/3Xxv/jtng0vKnY4o
         tzs7mcbHd95F6BvfuQ5qBvrljgv2Z/U9PN8tEGyOhneA86hbRnQONyizz7gZNwHo7k
         bWK7BtPSxvLIL6caFDawnt2TgdA7X+u4AlmgNVyfILkcPpR++j9YEhFzmDsLaoYTU5
         I/tbjEPcDhA++G+BqW7osamcV4gxnFOoMSxcABH51V89WZ5UtChlzIhiEjLnZwwXVU
         fyOLMSnuu+BJrpJ2MvRNFkHfpKLvC3KvPR3tf2nMioyP/2DQdpXwG04lbyepNrwwbY
         87Mnmm6Mbd5/A==
Received: by mail-il1-f182.google.com with SMTP id z10so2939097iln.0;
        Fri, 01 Apr 2022 14:39:36 -0700 (PDT)
X-Gm-Message-State: AOAM533KrPg0iU1Ehe6bO9PMhACeAi6bSBBD0G3NVoUc0pftwnghD1tA
        GIasXacqo1ubLQvEVN3ttH5FGAWxVx/mFc9LRg==
X-Google-Smtp-Source: ABdhPJz67vhBzOCPrpee46biTkgz2GvmlKmq0iYmwGAecXJCtTCuJEWVeUD1D8eRi+FyDIsw/lgsheByhgZAgBHK7wA=
X-Received: by 2002:a05:6e02:2183:b0:2c7:fe42:7b07 with SMTP id
 j3-20020a056e02218300b002c7fe427b07mr745149ila.302.1648849175895; Fri, 01 Apr
 2022 14:39:35 -0700 (PDT)
MIME-Version: 1.0
References: <20220401212658.30607-1-palmer@rivosinc.com>
In-Reply-To: <20220401212658.30607-1-palmer@rivosinc.com>
From:   Rob Herring <robh@kernel.org>
Date:   Fri, 1 Apr 2022 16:39:24 -0500
X-Gmail-Original-Message-ID: <CAL_JsqL8swP_NuMUiBeRrYhQ2XQct4uPxinOaE4dnn0K8mB1Wg@mail.gmail.com>
Message-ID: <CAL_JsqL8swP_NuMUiBeRrYhQ2XQct4uPxinOaE4dnn0K8mB1Wg@mail.gmail.com>
Subject: Re: [PATCH v3] dt-bindings: Fix phandle-array issues in the
 idle-states bindings
To:     Palmer Dabbelt <palmer@rivosinc.com>
Cc:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Anup Patel <anup@brainfault.org>, Guo Ren <guoren@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        devicetree@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        linux-riscv <linux-riscv@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 1, 2022 at 4:36 PM Palmer Dabbelt <palmer@rivosinc.com> wrote:
>
> From: Palmer Dabbelt <palmer@rivosinc.com>
>
> As per 39bd2b6a3783 ("dt-bindings: Improve phandle-array schemas"), the
> phandle-array bindings have been disambiguated.  This fixes the new
> RISC-V idle-states bindings to comply with the schema.
>
> Fixes: 1bd524f7e8d8 ("dt-bindings: Add common bindings for ARM and RISC-V idle states")
> Signed-off-by: Palmer Dabbelt <palmer@rivosinc.com>
> ---
> Changes since v2:
>
> * Add the missing schema requirement to riscv/cpus.yaml
>
> Changes since v1:
>
> * Only fix the RISC-V bindings, to avoid a merge conflict.
>
> ---
>  .../devicetree/bindings/cpu/idle-states.yaml     | 16 ++++++++--------
>  .../devicetree/bindings/riscv/cpus.yaml          |  2 ++
>  2 files changed, 10 insertions(+), 8 deletions(-)

Reviewed-by: Rob Herring <robh@kernel.org>

Thanks for fixing quickly.

Rob
