Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E1C5454F2FC
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Jun 2022 10:31:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1381048AbiFQIbN convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Fri, 17 Jun 2022 04:31:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1380922AbiFQIbI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jun 2022 04:31:08 -0400
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5348E69283;
        Fri, 17 Jun 2022 01:31:06 -0700 (PDT)
Received: from ip5b412258.dynamic.kabel-deutschland.de ([91.65.34.88] helo=diego.localnet)
        by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <heiko@sntech.de>)
        id 1o27NU-0003My-Jd; Fri, 17 Jun 2022 10:30:52 +0200
From:   Heiko =?ISO-8859-1?Q?St=FCbner?= <heiko@sntech.de>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Christoph Hellwig <hch@lst.de>, palmer@dabbelt.com,
        paul.walmsley@sifive.com, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org, wefu@redhat.com, guoren@kernel.org,
        cmuellner@linux.com, philipp.tomsich@vrull.eu, samuel@sholland.org,
        atishp@atishpatra.org, anup@brainfault.org, mick@ics.forth.gr,
        robh+dt@kernel.org, krzk+dt@kernel.org, devicetree@vger.kernel.org,
        drew@beagleboard.org, Atish Patra <atish.patra@wdc.com>
Subject: Re: [PATCH 2/3] riscv: Implement Zicbom-based cache management operations
Date:   Fri, 17 Jun 2022 10:30:51 +0200
Message-ID: <16237654.geO5KgaWL5@diego>
In-Reply-To: <20220616121157.GA11657@lst.de>
References: <20220610004308.1903626-1-heiko@sntech.de> <2041345.KlZ2vcFHjT@diego> <20220616121157.GA11657@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
Content-Type: text/plain; charset="iso-8859-1"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,T_SPF_HELO_TEMPERROR autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am Donnerstag, 16. Juni 2022, 14:11:57 CEST schrieb Christoph Hellwig:
> On Thu, Jun 16, 2022 at 02:09:47PM +0200, Heiko Stübner wrote:
> > My guess was that new platforms implementing cache-management will want
> > to be non-coherent by default?
> 
> No.  Cache incoherent DMA is absolutely horrible and almost impossible
> to get right for the corner cases.  It is a cost cutting measure seen on
> cheap SOCs and mostly avoided for more enterprise grade products.

ok, then we'll do it the other way around as suggested :-) .
Coherent by default and marking the non-coherent parts.

DT people on IRC yesterday were also open to adding a dma-noncoherent
property for that case.

Heiko


