Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4818F58B417
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Aug 2022 08:46:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241723AbiHFGqF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 6 Aug 2022 02:46:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241695AbiHFGp5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 6 Aug 2022 02:45:57 -0400
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C3BB14D03;
        Fri,  5 Aug 2022 23:45:56 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4M0Cf929dXz4x2c;
        Sat,  6 Aug 2022 16:45:53 +1000 (AEST)
From:   Michael Ellerman <patch-notifications@ellerman.id.au>
To:     rcu@vger.kernel.org, npiggin@gmail.com, zhouzhouyi@gmail.com,
        adobriyan@gmail.com, linux-kernel@vger.kernel.org,
        lance@osuosl.org, benh@kernel.crashing.org, nick.child@ibm.com,
        paulmck@kernel.org, paulus@samba.org, clg@kaod.org,
        mpe@ellerman.id.au, linuxppc-dev@lists.ozlabs.org, robh@kernel.org,
        christophe.leroy@csgroup.eu, frank.rowand@sony.com,
        john.ogness@linutronix.de
In-Reply-To: <20220726015747.11754-1-zhouzhouyi@gmail.com>
References: <20220726015747.11754-1-zhouzhouyi@gmail.com>
Subject: Re: [PATCH linux-next v2] powerpc: init jump label early in ppc 64
Message-Id: <165976833358.1752861.14286034118835101770.b4-ty@ellerman.id.au>
Date:   Sat, 06 Aug 2022 16:45:33 +1000
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 26 Jul 2022 09:57:47 +0800, zhouzhouyi@gmail.com wrote:
> From: Zhouyi Zhou <zhouzhouyi@gmail.com>
> 
> In ppc 64, invoke jump_label_init in setup_feature_keys is too late
> because static key will be used in subroutine of parse_early_param
> which is again subroutine of early_init_devtree.
> 
> So we invoke jump_label_init just before parse_early_param in
> early_init_devtree.
> 
> [...]

Applied to powerpc/next.

[1/1] powerpc: init jump label early in ppc 64
      https://git.kernel.org/powerpc/c/ca829e05d3d4f728810cc5e4b468d9ebc7745eb3

cheers
