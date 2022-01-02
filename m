Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B38C4482B6A
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Jan 2022 14:33:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232266AbiABNc4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 2 Jan 2022 08:32:56 -0500
Received: from elvis.franken.de ([193.175.24.41]:52740 "EHLO elvis.franken.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231324AbiABNcy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Jan 2022 08:32:54 -0500
Received: from uucp (helo=alpha)
        by elvis.franken.de with local-bsmtp (Exim 3.36 #1)
        id 1n40yi-0002m7-07; Sun, 02 Jan 2022 14:32:52 +0100
Received: by alpha.franken.de (Postfix, from userid 1000)
        id A8F3AC0A4B; Sun,  2 Jan 2022 14:32:31 +0100 (CET)
Date:   Sun, 2 Jan 2022 14:32:31 +0100
From:   Thomas Bogendoerfer <tsbogend@alpha.franken.de>
To:     Tiezhu Yang <yangtiezhu@loongson.cn>
Cc:     Xuefeng Li <lixuefeng@loongson.cn>, linux-mips@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 3/3] MIPS: signal: Remove unnecessary DEBUG_SIG
 related code
Message-ID: <20220102133231.GH3468@alpha.franken.de>
References: <1639974460-3278-1-git-send-email-yangtiezhu@loongson.cn>
 <1639974460-3278-4-git-send-email-yangtiezhu@loongson.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1639974460-3278-4-git-send-email-yangtiezhu@loongson.cn>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 20, 2021 at 12:27:40PM +0800, Tiezhu Yang wrote:
> DEBUG_SIG is not defined on MIPS, so DEBUGP() is an empty function.
> Additionally, it is unacceptable to printk messages in the normal
> path of signal handling, the system can not work well if DEBUG_SIG
> is defined, so just remove the related code.

I like to keep this debug aid for now.

Thomas.

-- 
Crap can work. Given enough thrust pigs will fly, but it's not necessarily a
good idea.                                                [ RFC1925, 2.3 ]
