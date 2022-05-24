Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B4C9F5328B3
	for <lists+linux-kernel@lfdr.de>; Tue, 24 May 2022 13:19:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235186AbiEXLQa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 May 2022 07:16:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236463AbiEXLPk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 May 2022 07:15:40 -0400
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 349C69155E
        for <linux-kernel@vger.kernel.org>; Tue, 24 May 2022 04:15:39 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4L6s7Y0nh8z4ySt;
        Tue, 24 May 2022 21:15:37 +1000 (AEST)
From:   Michael Ellerman <patch-notifications@ellerman.id.au>
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Finn Thain <fthain@linux-m68k.org>
Cc:     linux-kernel@vger.kernel.org, Randy Dunlap <rdunlap@infradead.org>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        linuxppc-dev@lists.ozlabs.org
In-Reply-To: <5edbe76ce68227f71e09af4614cc4c1bd61c7ec8.1649326292.git.fthain@linux-m68k.org>
References: <5edbe76ce68227f71e09af4614cc4c1bd61c7ec8.1649326292.git.fthain@linux-m68k.org>
Subject: Re: [PATCH v2] macintosh/via-pmu: Fix build failure when CONFIG_INPUT is disabled
Message-Id: <165339058086.1718562.16646756520470631496.b4-ty@ellerman.id.au>
Date:   Tue, 24 May 2022 21:09:40 +1000
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

On Thu, 07 Apr 2022 20:11:32 +1000, Finn Thain wrote:
> drivers/macintosh/via-pmu-event.o: In function `via_pmu_event':
> via-pmu-event.c:(.text+0x44): undefined reference to `input_event'
> via-pmu-event.c:(.text+0x68): undefined reference to `input_event'
> via-pmu-event.c:(.text+0x94): undefined reference to `input_event'
> via-pmu-event.c:(.text+0xb8): undefined reference to `input_event'
> drivers/macintosh/via-pmu-event.o: In function `via_pmu_event_init':
> via-pmu-event.c:(.init.text+0x20): undefined reference to `input_allocate_device'
> via-pmu-event.c:(.init.text+0xc4): undefined reference to `input_register_device'
> via-pmu-event.c:(.init.text+0xd4): undefined reference to `input_free_device'
> make[1]: *** [Makefile:1155: vmlinux] Error 1
> make: *** [Makefile:350: __build_one_by_one] Error 2
> 
> [...]

Applied to powerpc/next.

[1/1] macintosh/via-pmu: Fix build failure when CONFIG_INPUT is disabled
      https://git.kernel.org/powerpc/c/86ce436e30d86327c9f5260f718104ae7b21f506

cheers
