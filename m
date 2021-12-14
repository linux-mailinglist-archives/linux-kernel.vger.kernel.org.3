Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6AD70473F95
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Dec 2021 10:34:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232469AbhLNJej (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Dec 2021 04:34:39 -0500
Received: from elvis.franken.de ([193.175.24.41]:46452 "EHLO elvis.franken.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230319AbhLNJe1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Dec 2021 04:34:27 -0500
Received: from uucp (helo=alpha)
        by elvis.franken.de with local-bsmtp (Exim 3.36 #1)
        id 1mx4CW-0005hz-03; Tue, 14 Dec 2021 10:34:24 +0100
Received: by alpha.franken.de (Postfix, from userid 1000)
        id 22A5FC0752; Tue, 14 Dec 2021 10:32:07 +0100 (CET)
Date:   Tue, 14 Dec 2021 10:32:07 +0100
From:   Thomas Bogendoerfer <tsbogend@alpha.franken.de>
To:     Tiezhu Yang <yangtiezhu@loongson.cn>
Cc:     Jason Self <jason@bluehome.net>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Ryutaroh Matsumoto <ryutaroh@ict.e.titech.ac.jp>,
        Nathan Chancellor <nathan@kernel.org>,
        linux-mips@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 0/2] MIPS: Remove some code
Message-ID: <20211214093207.GD7220@alpha.franken.de>
References: <1639451342-7029-1-git-send-email-yangtiezhu@loongson.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1639451342-7029-1-git-send-email-yangtiezhu@loongson.cn>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 14, 2021 at 11:09:00AM +0800, Tiezhu Yang wrote:
> Thanks Nathan, Masahiro and Ryutaroh.
> 
> v4:
>   -- update the commit message of patch #1
>   -- add Reviewed-by tags
> 
> Tiezhu Yang (2):
>   MIPS: SGI-IP22: Remove unnecessary check of GCC option
>   MIPS: Makefile: Remove "ifdef need-compiler" for Kbuild.platforms
> 
>  arch/mips/Makefile          | 2 --
>  arch/mips/sgi-ip22/Platform | 5 -----
>  2 files changed, 7 deletions(-)
> 
> -- 
> 2.1.0

series applied to mips-next.

Thomas.

-- 
Crap can work. Given enough thrust pigs will fly, but it's not necessarily a
good idea.                                                [ RFC1925, 2.3 ]
