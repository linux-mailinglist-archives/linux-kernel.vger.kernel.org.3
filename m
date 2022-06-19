Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6F0AD550A68
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Jun 2022 13:56:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236897AbiFSL4j (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 19 Jun 2022 07:56:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231256AbiFSL4c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Jun 2022 07:56:32 -0400
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3BCBB120B3
        for <linux-kernel@vger.kernel.org>; Sun, 19 Jun 2022 04:56:31 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4LQrpj696vz4xXg;
        Sun, 19 Jun 2022 21:56:29 +1000 (AEST)
From:   Michael Ellerman <patch-notifications@ellerman.id.au>
To:     linux-kernel@vger.kernel.org,
        Michael Ellerman <mpe@ellerman.id.au>,
        "Jason A. Donenfeld" <Jason@zx2c4.com>,
        linuxppc-dev@lists.ozlabs.org
Cc:     Christophe Leroy <christophe.leroy@csgroup.eu>
In-Reply-To: <20220611151015.548325-1-Jason@zx2c4.com>
References: <20220611151015.548325-1-Jason@zx2c4.com>
Subject: Re: [PATCH v3 0/3] powerpc: wire up rng during setup_arch
Message-Id: <165563974695.2516477.14135241088366642761.b4-ty@ellerman.id.au>
Date:   Sun, 19 Jun 2022 21:55:46 +1000
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 11 Jun 2022 17:10:12 +0200, Jason A. Donenfeld wrote:
> The platform's RNG must be available before random_init() in order to be
> useful for initial seeding, which in turn means that it needs to be
> called from setup_arch(), rather than from an init call. This series
> wires that up properly on the three platforms that currently initialize
> the RNG from the wrong place.
> 
> Cc: Michael Ellerman <mpe@ellerman.id.au>
> Cc: Christophe Leroy <christophe.leroy@csgroup.eu>
> 
> [...]

Patches 1 & 3 applied to powerpc/fixes.

[1/3] powerpc/microwatt: wire up rng during setup_arch
      https://git.kernel.org/powerpc/c/20a9689b3607456d92c6fb764501f6a95950b098
[3/3] powerpc/pseries: wire up rng during setup_arch
      https://git.kernel.org/powerpc/c/e561e472a3d441753bd012333b057f48fef1045b

cheers
