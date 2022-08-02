Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B061F587B3F
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Aug 2022 13:03:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236734AbiHBLDB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Aug 2022 07:03:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236701AbiHBLCy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Aug 2022 07:02:54 -0400
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AEE274B0C9;
        Tue,  2 Aug 2022 04:02:53 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4LxsXW6xw8z4x1V;
        Tue,  2 Aug 2022 21:02:51 +1000 (AEST)
From:   Michael Ellerman <patch-notifications@ellerman.id.au>
To:     linuxppc-dev@lists.ozlabs.org, john.ogness@linutronix.de,
        frank.rowand@sony.com, clg@kaod.org, nick.child@ibm.com,
        linux-kernel@vger.kernel.org, lance@osuosl.org,
        christophe.leroy@csgroup.eu, rcu@vger.kernel.org,
        adobriyan@gmail.com, benh@kernel.crashing.org, paulus@samba.org,
        robh@kernel.org, mpe@ellerman.id.au, paulmck@kernel.org,
        zhouzhouyi@gmail.com, npiggin@gmail.com
In-Reply-To: <20220726015747.11754-1-zhouzhouyi@gmail.com>
References: <20220726015747.11754-1-zhouzhouyi@gmail.com>
Subject: Re: [PATCH linux-next v2] powerpc: init jump label early in ppc 64
Message-Id: <165943814554.1061647.998228378866777067.b4-ty@ellerman.id.au>
Date:   Tue, 02 Aug 2022 21:02:25 +1000
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
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
