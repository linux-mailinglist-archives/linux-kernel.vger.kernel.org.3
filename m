Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 357C25535EB
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Jun 2022 17:24:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352738AbiFUPWE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Jun 2022 11:22:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352733AbiFUPWC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jun 2022 11:22:02 -0400
Received: from elvis.franken.de (elvis.franken.de [193.175.24.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id E7D1328E2C;
        Tue, 21 Jun 2022 08:22:01 -0700 (PDT)
Received: from uucp (helo=alpha)
        by elvis.franken.de with local-bsmtp (Exim 3.36 #1)
        id 1o3fh4-0001zL-05; Tue, 21 Jun 2022 17:21:30 +0200
Received: by alpha.franken.de (Postfix, from userid 1000)
        id DAA63C01AA; Tue, 21 Jun 2022 17:16:11 +0200 (CEST)
Date:   Tue, 21 Jun 2022 17:16:11 +0200
From:   Thomas Bogendoerfer <tsbogend@alpha.franken.de>
To:     Liang He <windhl@126.com>
Cc:     yangtiezhu@loongson.cn, linux-mips@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] mips/pic32/pic32mzda: Fix refcount leak bugs
Message-ID: <20220621151611.GF12206@alpha.franken.de>
References: <20220619045427.4064946-1-windhl@126.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220619045427.4064946-1-windhl@126.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jun 19, 2022 at 12:54:27PM +0800, Liang He wrote:
> of_find_matching_node(), of_find_compatible_node() and
> of_find_node_by_path() will return node pointers with refcout
> incremented. We should call of_node_put() when they are not
> used anymore.
> 
> Signed-off-by: Liang He <windhl@126.com>
> ---
>  changelog: 
>  
>  v2: (1) merge pic32/pic32mzda bugs into one patch
>      (2) fix leak bug related to of_find_node_by_path.
>  v1: use two patch for intit.c and time.c
> 
>  arch/mips/pic32/pic32mzda/init.c | 7 ++++++-
>  arch/mips/pic32/pic32mzda/time.c | 3 +++
>  2 files changed, 9 insertions(+), 1 deletion(-)

applied to mips-fixes.

Thomas.

-- 
Crap can work. Given enough thrust pigs will fly, but it's not necessarily a
good idea.                                                [ RFC1925, 2.3 ]
