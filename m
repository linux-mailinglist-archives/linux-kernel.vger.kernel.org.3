Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C08C2566846
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Jul 2022 12:40:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232455AbiGEKky (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Jul 2022 06:40:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230421AbiGEKkq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jul 2022 06:40:46 -0400
Received: from elvis.franken.de (elvis.franken.de [193.175.24.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 64BB71573D;
        Tue,  5 Jul 2022 03:40:44 -0700 (PDT)
Received: from uucp (helo=alpha)
        by elvis.franken.de with local-bsmtp (Exim 3.36 #1)
        id 1o8fz0-0002Jv-06; Tue, 05 Jul 2022 12:40:42 +0200
Received: by alpha.franken.de (Postfix, from userid 1000)
        id AD934C0230; Tue,  5 Jul 2022 12:40:21 +0200 (CEST)
Date:   Tue, 5 Jul 2022 12:40:21 +0200
From:   Thomas Bogendoerfer <tsbogend@alpha.franken.de>
To:     Yury Norov <yury.norov@gmail.com>
Cc:     Alexander Lobakin <alobakin@pm.me>,
        Huacai Chen <chenhuacai@kernel.org>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>,
        Mao Bibo <maobibo@loongson.cn>,
        Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <f4bug@amsat.org>,
        WANG Xuerui <kernel@xen0n.name>, linux-kernel@vger.kernel.org,
        linux-mips@vger.kernel.org
Subject: Re: [PATCH] mips: micro-optimize calculate_cpu_foreign_map()
Message-ID: <20220705104021.GJ9951@alpha.franken.de>
References: <20220621144729.533026-1-yury.norov@gmail.com>
 <Yr5i+OCeb89YMNZw@yury-laptop>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Yr5i+OCeb89YMNZw@yury-laptop>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 30, 2022 at 07:59:04PM -0700, Yury Norov wrote:
> On Tue, Jun 21, 2022 at 07:47:29AM -0700, Yury Norov wrote:
> > The inner loop in calculate_cpu_foreign_map() walks the whole
> > cpumask to check if we have siblings for a given cpu.
> > 
> > We can just break after a 1st match and avoid useless traversing
> > the rest of mask.
> > 
> > Loongarch has an identical function, so fix it here as well.
> > 
> > Signed-off-by: Yury Norov <yury.norov@gmail.com>
> 
> Ping?

as this is touching two different archs, it would have been easier
to send this in two different patches.

Huacai, should I take the patch ?

Thomas.

-- 
Crap can work. Given enough thrust pigs will fly, but it's not necessarily a
good idea.                                                [ RFC1925, 2.3 ]
