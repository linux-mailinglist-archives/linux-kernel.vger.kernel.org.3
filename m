Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 850A2569D9D
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Jul 2022 10:41:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235078AbiGGIlS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Jul 2022 04:41:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229827AbiGGIlQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jul 2022 04:41:16 -0400
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF913F30;
        Thu,  7 Jul 2022 01:41:13 -0700 (PDT)
Received: from ip5b412258.dynamic.kabel-deutschland.de ([91.65.34.88] helo=diego.localnet)
        by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <heiko@sntech.de>)
        id 1o9N4E-0005a2-Jj; Thu, 07 Jul 2022 10:40:58 +0200
From:   Heiko =?ISO-8859-1?Q?St=FCbner?= <heiko@sntech.de>
To:     palmer@dabbelt.com, paul.walmsley@sifive.com
Cc:     linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        wefu@redhat.com, guoren@kernel.org, cmuellner@linux.com,
        philipp.tomsich@vrull.eu, hch@lst.de, samuel@sholland.org,
        atishp@atishpatra.org, anup@brainfault.org, mick@ics.forth.gr,
        robh+dt@kernel.org, krzk+dt@kernel.org, devicetree@vger.kernel.org,
        drew@beagleboard.org, rdunlap@infradead.org,
        Atish Patra <atish.patra@wdc.com>
Subject: Re: [PATCH v7 3/4] riscv: Add support for non-coherent devices using zicbom extension
Date:   Thu, 07 Jul 2022 10:40:57 +0200
Message-ID: <1729939.VLH7GnMWUR@diego>
In-Reply-To: <20220706231536.2041855-4-heiko@sntech.de>
References: <20220706231536.2041855-1-heiko@sntech.de> <20220706231536.2041855-4-heiko@sntech.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,T_SPF_HELO_TEMPERROR autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am Donnerstag, 7. Juli 2022, 01:15:35 CEST schrieb Heiko Stuebner:
> The Zicbom ISA-extension was ratified in november 2021
> and introduces instructions for dcache invalidate, clean
> and flush operations.
> 
> Implement cache management operations for non-coherent devices
> based on them.
> 
> Of course not all cores will support this, so implement an
> alternative-based mechanism that replaces empty instructions
> with ones done around Zicbom instructions.
> 
> As discussed in previous versions, assume the platform
> being coherent by default so that non-coherent devices need
> to get marked accordingly by firmware.
> 
> Reviewed-by: Christoph Hellwig <hch@lst.de>
> Signed-off-by: Heiko Stuebner <heiko@sntech.de>
> Cc: Christoph Hellwig <hch@lst.de>
> Cc: Atish Patra <atish.patra@wdc.com>
> Cc: Guo Ren <guoren@kernel.org>
> Cc: Anup Patel <anup@brainfault.org>

Over in v6 Guo provided [0] a

Reviewed-by: Guo Ren <guoren@kernel.org>



[0] https://lore.kernel.org/r/CAJF2gTRN1J3edjbt5L9ELLtMzXKWUABQb=QxDA90uY7mj=O0rw@mail.gmail.com


