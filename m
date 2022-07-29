Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 189405850BB
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Jul 2022 15:19:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234368AbiG2NTa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Jul 2022 09:19:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236247AbiG2NT0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Jul 2022 09:19:26 -0400
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D42F2558F6
        for <linux-kernel@vger.kernel.org>; Fri, 29 Jul 2022 06:19:24 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4LvSlt555Bz4xG3;
        Fri, 29 Jul 2022 23:19:22 +1000 (AEST)
From:   Michael Ellerman <patch-notifications@ellerman.id.au>
To:     paulus@samba.org, Jason Wang <wangborong@cdjrlc.com>
Cc:     mpe@ellerman.id.au, npiggin@gmail.com, benh@kernel.crashing.org,
        Julia.Lawall@inria.fr, clg@kaod.org, linuxppc-dev@lists.ozlabs.org,
        linux-kernel@vger.kernel.org, nick.child@ibm.com,
        haren@linux.ibm.com
In-Reply-To: <20220718075553.70897-1-wangborong@cdjrlc.com>
References: <20220718075553.70897-1-wangborong@cdjrlc.com>
Subject: Re: [PATCH] powerpc/pseries/vas: Fix comment typo
Message-Id: <165909977858.253830.9547689135709883077.b4-ty@ellerman.id.au>
Date:   Fri, 29 Jul 2022 23:02:58 +1000
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

On Mon, 18 Jul 2022 15:55:53 +0800, Jason Wang wrote:
> The double `the' in line 807 is duplicated, remove one.
> 
> 

Applied to powerpc/next.

[1/1] powerpc/pseries/vas: Fix comment typo
      https://git.kernel.org/powerpc/c/901a30cf5f765a26f1308701d9df9e7f3d0023a5

cheers
