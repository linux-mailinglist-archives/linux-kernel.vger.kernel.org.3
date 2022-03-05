Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EB47D4CE70D
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Mar 2022 21:53:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232506AbiCEUyl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 5 Mar 2022 15:54:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231783AbiCEUyi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 Mar 2022 15:54:38 -0500
Received: from angie.orcam.me.uk (angie.orcam.me.uk [78.133.224.34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 585425F8DC;
        Sat,  5 Mar 2022 12:53:46 -0800 (PST)
Received: by angie.orcam.me.uk (Postfix, from userid 500)
        id 7ABCF92009C; Sat,  5 Mar 2022 21:53:45 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
        by angie.orcam.me.uk (Postfix) with ESMTP id 6C20D92009B;
        Sat,  5 Mar 2022 20:53:45 +0000 (GMT)
Date:   Sat, 5 Mar 2022 20:53:45 +0000 (GMT)
From:   "Maciej W. Rozycki" <macro@orcam.me.uk>
To:     Mike Rapoport <rppt@kernel.org>
cc:     Tiezhu Yang <yangtiezhu@loongson.cn>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        Xuefeng Li <lixuefeng@loongson.cn>, linux-mips@vger.kernel.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 0/4] MIPS: Modify mem= and memmap= parameter
In-Reply-To: <alpine.DEB.2.21.2203051837280.47558@angie.orcam.me.uk>
Message-ID: <alpine.DEB.2.21.2203052047090.47558@angie.orcam.me.uk>
References: <1646108941-27919-1-git-send-email-yangtiezhu@loongson.cn> <Yh3tgr+g/6IElq0P@kernel.org> <cfd74b5b-39c3-733a-5226-515991f91f39@loongson.cn> <Yh4uUoYT+YS5Jxsv@kernel.org> <8956c625-c18d-846e-3e65-7920776b27f3@loongson.cn>
 <alpine.DEB.2.21.2203041627150.47558@angie.orcam.me.uk> <4e10d7a4-3b3e-a220-8cd2-565614288950@loongson.cn> <YiNlDxF9WppxbkiX@kernel.org> <alpine.DEB.2.21.2203051837280.47558@angie.orcam.me.uk>
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

On Sat, 5 Mar 2022, Maciej W. Rozycki wrote:

>  Also to say (in said commit):
> 
> "There's no point to rewrite some logic to parse command line
> to pass initrd parameters or to declare a user memory area.
> We could use instead parse_early_param() that does the same
> thing."
> 
> is IMHO unfair given that the "rewrite" was there in place almost six 
> years before `parse_early_param' even started to exist!  Why do people 
> assume things have always been like they see them at the time they look?

 Self-correction for an incorrect last-moment edit: four years before 
rather than six (`parse_early_param' went in upstream shortly before:
<https://git.kernel.org/pub/scm/linux/kernel/git/ralf/linux.git/commit/?id=5145764263ab>).

  Maciej
