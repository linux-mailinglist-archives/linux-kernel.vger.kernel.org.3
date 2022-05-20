Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7EF9C52E399
	for <lists+linux-kernel@lfdr.de>; Fri, 20 May 2022 06:22:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241746AbiETEWE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 May 2022 00:22:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234687AbiETEV5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 May 2022 00:21:57 -0400
Received: from 1wt.eu (wtarreau.pck.nerim.net [62.212.114.60])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 70642F689A
        for <linux-kernel@vger.kernel.org>; Thu, 19 May 2022 21:21:55 -0700 (PDT)
Received: (from willy@localhost)
        by pcw.home.local (8.15.2/8.15.2/Submit) id 24K4LjYV005139;
        Fri, 20 May 2022 06:21:45 +0200
Date:   Fri, 20 May 2022 06:21:45 +0200
From:   Willy Tarreau <w@1wt.eu>
To:     Ammar Faizi <ammarfaizi2@gnuweeb.org>
Cc:     "Paul E. McKenney" <paulmck@kernel.org>,
        Alviro Iskandar Setiawan <alviro.iskandar@gnuweeb.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        GNU/Weeb Mailing List <gwml@vger.gnuweeb.org>,
        Facebook Kernel Team <kernel-team@fb.com>
Subject: Re: [PATCH v1 2/2] tools/nolibc/stdio: Add format attribute to
 enable printf warnings
Message-ID: <20220520042145.GD5001@1wt.eu>
References: <20220519172116.283687-1-ammarfaizi2@gnuweeb.org>
 <20220519172116.283687-3-ammarfaizi2@gnuweeb.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220519172116.283687-3-ammarfaizi2@gnuweeb.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 20, 2022 at 12:21:16AM +0700, Ammar Faizi wrote:
> From: Alviro Iskandar Setiawan <alviro.iskandar@gnuweeb.org>
> 
> When we use printf and fprintf functions from the nolibc, we don't
> get any warning from the compiler if we have the wrong arguments.
> For example, the following calls will compile silently:
> ```
>   printf("%s %s\n", "aaa");
>   fprintf(stdout, "%s %s\n", "xxx", 1);
> ```
> (Note the wrong arguments).
> 
> Those calls are undefined behavior. The compiler can help us warn
> about the above mistakes by adding a `printf` format attribute to
> those functions declaration.

I'm shocked I forgot it, I use it all the time, I'm even seeing this
as a bug fix for the series I sent. Thanks for fixing this mistake of
mine!

Acked-by: Willy Tarreau <w@1wt.eu>

Willy
