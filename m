Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B00FF4E5924
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Mar 2022 20:29:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344257AbiCWTbS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Mar 2022 15:31:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236043AbiCWTbR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Mar 2022 15:31:17 -0400
Received: from isilmar-4.linta.de (isilmar-4.linta.de [136.243.71.142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A1D6888FB;
        Wed, 23 Mar 2022 12:29:45 -0700 (PDT)
X-isilmar-external: YES
X-isilmar-external: YES
X-isilmar-external: YES
X-isilmar-external: YES
X-isilmar-external: YES
Received: from owl.dominikbrodowski.net (owl.brodo.linta [10.2.0.111])
        by isilmar-4.linta.de (Postfix) with ESMTPSA id 12CD6201407;
        Wed, 23 Mar 2022 19:29:43 +0000 (UTC)
Received: by owl.dominikbrodowski.net (Postfix, from userid 1000)
        id 832E980631; Wed, 23 Mar 2022 20:29:36 +0100 (CET)
Date:   Wed, 23 Mar 2022 20:29:36 +0100
From:   Dominik Brodowski <linux@dominikbrodowski.net>
To:     "Jason A. Donenfeld" <Jason@zx2c4.com>
Cc:     linux-kernel@vger.kernel.org, linux-crypto@vger.kernel.org,
        Theodore Ts'o <tytso@mit.edu>,
        Graham Christensen <graham@grahamc.com>
Subject: Re: [PATCH] random: treat bootloader trust toggle the same way as
 cpu trust toggle
Message-ID: <Yjt1IHpxCOJ4/MhC@owl.dominikbrodowski.net>
References: <20220323041123.146459-1-Jason@zx2c4.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220323041123.146459-1-Jason@zx2c4.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am Tue, Mar 22, 2022 at 10:11:23PM -0600 schrieb Jason A. Donenfeld:
> If CONFIG_RANDOM_TRUST_CPU is set, the RNG initializes using RDRAND.
> But, the user can disable (or enable) this behavior by setting
> `random.trust_cpu=0/1` on the kernel command line. This allows system
> builders to do reasonable things while avoiding howls from tinfoil
> hatters. (Or vice versa.)
> 
> CONFIG_RANDOM_TRUST_BOOTLOADER is basically the same thing, but regards
> the seed passed via EFI or device tree, which might come from RDRAND or
> a TPM or somewhere else. In order to allow distros to more easily enable
> this while avoiding those same howls (or vice versa), this commit adds
> the corresponding `random.trust_bootloader=0/1` toggle.
> 
> Cc: Dominik Brodowski <linux@dominikbrodowski.net>
> Cc: Theodore Ts'o <tytso@mit.edu>
> Cc: Graham Christensen <graham@grahamc.com>
> Link: https://github.com/NixOS/nixpkgs/pull/165355
> Signed-off-by: Jason A. Donenfeld <Jason@zx2c4.com>

Reviewed-by: Dominik Brodowski <linux@dominikbrodowski.net>

Thanks,
	Dominik
