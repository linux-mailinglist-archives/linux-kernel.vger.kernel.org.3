Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8A71452E39D
	for <lists+linux-kernel@lfdr.de>; Fri, 20 May 2022 06:24:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242500AbiETEYA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 May 2022 00:24:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234687AbiETEXz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 May 2022 00:23:55 -0400
Received: from 1wt.eu (wtarreau.pck.nerim.net [62.212.114.60])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 80A74F7491
        for <linux-kernel@vger.kernel.org>; Thu, 19 May 2022 21:23:54 -0700 (PDT)
Received: (from willy@localhost)
        by pcw.home.local (8.15.2/8.15.2/Submit) id 24K4NjtK005145;
        Fri, 20 May 2022 06:23:45 +0200
Date:   Fri, 20 May 2022 06:23:45 +0200
From:   Willy Tarreau <w@1wt.eu>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     Ammar Faizi <ammarfaizi2@gnuweeb.org>,
        Alviro Iskandar Setiawan <alviro.iskandar@gnuweeb.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        GNU/Weeb Mailing List <gwml@vger.gnuweeb.org>,
        Facebook Kernel Team <kernel-team@fb.com>
Subject: Re: [PATCH v1 0/2] nolibc updates for Linux 5.20
Message-ID: <20220520042345.GE5001@1wt.eu>
References: <20220519172116.283687-1-ammarfaizi2@gnuweeb.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220519172116.283687-1-ammarfaizi2@gnuweeb.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 20, 2022 at 12:21:14AM +0700, Ammar Faizi wrote:
> Not much to do this time. Only small nolibc updates here. There are two
> patches in this series.
> 
> 1. Address Willy's comment about overflow checking in the multiplication
>    operation [1]. This patch supports overflow checking for older
>    compiler versions. Currently, we use `__builtin_mul_overflow()` that
>    doesn't exist in older compiler versions. Instead of using this
>    built-in, use a simple division to check for overflow in the `calloc()`
>    function.
> 
> 2. The compiler can warn us about wrong `printf` arguments. This patch
>    enables the warnings. Currently, only two functions use this attribute:
>    `printf` and `fprintf`.

Paul, in summary I'm perfectly fine with the whole series, you can take it.

Thanks!
Willy
