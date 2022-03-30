Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0C3134ECCCF
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Mar 2022 21:00:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350382AbiC3TCS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Mar 2022 15:02:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350306AbiC3TCM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Mar 2022 15:02:12 -0400
Received: from elvis.franken.de (elvis.franken.de [193.175.24.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id CCE5265D3B;
        Wed, 30 Mar 2022 12:00:26 -0700 (PDT)
Received: from uucp (helo=alpha)
        by elvis.franken.de with local-bsmtp (Exim 3.36 #1)
        id 1nZdYO-0003Qd-01; Wed, 30 Mar 2022 21:00:24 +0200
Received: by alpha.franken.de (Postfix, from userid 1000)
        id 63D91C4DEF; Wed, 30 Mar 2022 20:34:48 +0200 (CEST)
Date:   Wed, 30 Mar 2022 20:34:48 +0200
From:   Thomas Bogendoerfer <tsbogend@alpha.franken.de>
To:     xkernel.wang@foxmail.com
Cc:     john@phrozen.org, linux-mips@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] MIPS: lantiq: check the return value of kzalloc()
Message-ID: <20220330183448.GB18042@alpha.franken.de>
References: <tencent_3E071B85643888D2C8BF388804334CAE2706@qq.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <tencent_3E071B85643888D2C8BF388804334CAE2706@qq.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 25, 2022 at 07:49:41PM +0800, xkernel.wang@foxmail.com wrote:
> From: Xiaoke Wang <xkernel.wang@foxmail.com>
> 
> kzalloc() is a memory allocation function which can return NULL when
> some internal memory errors happen. So it is better to check the
> return value of it to prevent potential wrong memory access or
> memory leak.
> 
> Signed-off-by: Xiaoke Wang <xkernel.wang@foxmail.com>
> ---
>  arch/mips/lantiq/falcon/sysctrl.c |  2 ++
>  arch/mips/lantiq/xway/gptu.c      |  2 ++
>  arch/mips/lantiq/xway/sysctrl.c   | 46 ++++++++++++++++++++-----------
>  3 files changed, 34 insertions(+), 16 deletions(-)

applied to mips-next.

Thomas.

-- 
Crap can work. Given enough thrust pigs will fly, but it's not necessarily a
good idea.                                                [ RFC1925, 2.3 ]
