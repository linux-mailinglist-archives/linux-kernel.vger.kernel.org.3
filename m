Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D5215531491
	for <lists+linux-kernel@lfdr.de>; Mon, 23 May 2022 18:25:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236275AbiEWN3O (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 May 2022 09:29:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236261AbiEWN3H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 May 2022 09:29:07 -0400
Received: from elvis.franken.de (elvis.franken.de [193.175.24.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 5F1C2A6;
        Mon, 23 May 2022 06:29:02 -0700 (PDT)
Received: from uucp (helo=alpha)
        by elvis.franken.de with local-bsmtp (Exim 3.36 #1)
        id 1nt87K-0002gG-00; Mon, 23 May 2022 15:29:02 +0200
Received: by alpha.franken.de (Postfix, from userid 1000)
        id EAD17C0311; Mon, 23 May 2022 15:28:52 +0200 (CEST)
Date:   Mon, 23 May 2022 15:28:52 +0200
From:   Thomas Bogendoerfer <tsbogend@alpha.franken.de>
To:     Tiezhu Yang <yangtiezhu@loongson.cn>
Cc:     Xuefeng Li <lixuefeng@loongson.cn>, linux-mips@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/3] MIPS: Modify early_parse_mem()
Message-ID: <20220523132852.GA8289@alpha.franken.de>
References: <1647615920-23103-1-git-send-email-yangtiezhu@loongson.cn>
 <c3e2d39f-1691-4065-c1fb-06f4059c3e0c@loongson.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c3e2d39f-1691-4065-c1fb-06f4059c3e0c@loongson.cn>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 09, 2022 at 03:30:11PM +0800, Tiezhu Yang wrote:
> 
> 
> On 03/18/2022 11:05 PM, Tiezhu Yang wrote:
> > Tiezhu Yang (3):
> >   MIPS: Return -EINVAL if mem parameter is empty in early_parse_mem()
> >   MIPS: Return -EINVAL if mem parameter is invalid in early_parse_mem()
> >   MIPS: Use memblock_add_node() in early_parse_mem() under CONFIG_NUMA
> > 
> >  arch/mips/kernel/setup.c | 35 +++++++++++++++++++++++++++++------
> >  1 file changed, 29 insertions(+), 6 deletions(-)
> > 
> 
> Hi Thomas,
> 
> Any comments? Are you OK with these changes?

first and last patch are ok with me. The second patch changes semantics
for mem=, which I don't want to change. Iirc the latest idea to solve
your problem was to use mem=XX@ syntax to limit detected memory, which
is the preferred way for me, too.

If you want I'll take patch 1 and 3 out of this series.

Thomas.

-- 
Crap can work. Given enough thrust pigs will fly, but it's not necessarily a
good idea.                                                [ RFC1925, 2.3 ]
