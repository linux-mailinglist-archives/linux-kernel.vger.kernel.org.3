Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E8B394F08C9
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Apr 2022 12:38:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356501AbiDCKj6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 3 Apr 2022 06:39:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1356730AbiDCKjy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Apr 2022 06:39:54 -0400
Received: from angie.orcam.me.uk (angie.orcam.me.uk [IPv6:2001:4190:8020::34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 516FC39804;
        Sun,  3 Apr 2022 03:37:54 -0700 (PDT)
Received: by angie.orcam.me.uk (Postfix, from userid 500)
        id F22BB92009D; Sun,  3 Apr 2022 12:37:53 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by angie.orcam.me.uk (Postfix) with ESMTP id ECD3492009B;
        Sun,  3 Apr 2022 11:37:53 +0100 (BST)
Date:   Sun, 3 Apr 2022 11:37:53 +0100 (BST)
From:   "Maciej W. Rozycki" <macro@orcam.me.uk>
To:     Andrew Holmes <aholmes@omnom.net>
cc:     yaliang.wang@windriver.com, rppt@kernel.org,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        huangpei@loongson.cn, Andrew Morton <akpm@linux-foundation.org>,
        kumba@gentoo.org, Geert Uytterhoeven <geert@linux-m68k.org>,
        anshuman.khandual@arm.com, penberg@kernel.org,
        linux-mips@vger.kernel.org, linux-kernel@vger.kernel.org,
        Greg KH <gregkh@linuxfoundation.org>
Subject: Re: [PATCH] MIPS: pgalloc: fix memory leak caused by pgd_free()
In-Reply-To: <9cc88b1c-8a8c-95ea-2cf7-31be3b771495@omnom.net>
Message-ID: <alpine.DEB.2.21.2204031122020.47162@angie.orcam.me.uk>
References: <20220310113116.2068859-1-yaliang.wang@windriver.com> <alpine.DEB.2.21.2204021446370.47162@angie.orcam.me.uk> <9cc88b1c-8a8c-95ea-2cf7-31be3b771495@omnom.net>
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

On Sun, 3 Apr 2022, Andrew Holmes wrote:

> MIPS64 has essentially been broken/unusable for 8 kernel releases,
> including two LTS kernels, since the original commit landed. Should
> there not have been CI/tests that caught this? It's pretty major!

 AFAIK the MIPS port is only maintained on the best effort basis nowadays 
I'm afraid.  I.e. it's enthusiasts investing their free time for the joy 
of fiddling with things.  So things are bound to break from time to time 
and remain unnoticed for a while.  We're doing our best, but our resources 
are limited.

 Taking these limitations into account I think Thomas has been doing a 
tremendous job maintaining the MIPS port, but he hasn't been cc-ed on the 
submission of the original change and it's very easy to miss stuff in the 
flood that has only been posted to a mailing list.

  Maciej
