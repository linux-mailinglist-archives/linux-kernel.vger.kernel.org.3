Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B374D4D3886
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Mar 2022 19:13:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235143AbiCISOS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Mar 2022 13:14:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232226AbiCISOQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Mar 2022 13:14:16 -0500
Received: from angie.orcam.me.uk (angie.orcam.me.uk [78.133.224.34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id F34A14AE06;
        Wed,  9 Mar 2022 10:13:16 -0800 (PST)
Received: by angie.orcam.me.uk (Postfix, from userid 500)
        id F2D2892009C; Wed,  9 Mar 2022 19:13:14 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
        by angie.orcam.me.uk (Postfix) with ESMTP id EB60D92009B;
        Wed,  9 Mar 2022 18:13:14 +0000 (GMT)
Date:   Wed, 9 Mar 2022 18:13:14 +0000 (GMT)
From:   "Maciej W. Rozycki" <macro@orcam.me.uk>
To:     Mike Rapoport <rppt@kernel.org>
cc:     Jonathan Corbet <corbet@lwn.net>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Sergey Shtylyov <s.shtylyov@omp.ru>,
        Tiezhu Yang <yangtiezhu@loongson.cn>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        linux-doc@vger.kernel.org, linux-mips@vger.kernel.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] docs/kernel-parameters: update description of mem=
In-Reply-To: <20220309172258.1183796-1-rppt@kernel.org>
Message-ID: <alpine.DEB.2.21.2203091809100.47558@angie.orcam.me.uk>
References: <20220309172258.1183796-1-rppt@kernel.org>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 9 Mar 2022, Mike Rapoport wrote:

> From: Mike Rapoport <rppt@linux.ibm.com>
> 
> The existing description of mem= does not cover all the cases and
> differences between how architectures treat it.
> 
> Extend the description to match the code.

 This:

> +	mem=nn[KMG]	[HEXAGON] Set the memory size.
> +			Must be specified, otherwise memory size will be 0.
> +

I guess would better be folded into the other `mem=nn[KMG]' description 
above, possibly between [ARM64] and [X86] so as to keep the order roughly 
alphabetic.

  Maciej
