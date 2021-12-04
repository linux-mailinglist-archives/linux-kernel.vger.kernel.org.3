Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3BEBC46881E
	for <lists+linux-kernel@lfdr.de>; Sat,  4 Dec 2021 23:35:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232227AbhLDWjH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 4 Dec 2021 17:39:07 -0500
Received: from smtprelay0212.hostedemail.com ([216.40.44.212]:44174 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S231468AbhLDWjG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Dec 2021 17:39:06 -0500
Received: from omf11.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay07.hostedemail.com (Postfix) with ESMTP id 98888181D2FC9;
        Sat,  4 Dec 2021 22:35:39 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: joe@perches.com) by omf11.hostedemail.com (Postfix) with ESMTPA id EB20020033;
        Sat,  4 Dec 2021 22:34:37 +0000 (UTC)
Message-ID: <2ced60214ef3bf449e27f5cb22d3dbd0863d97bb.camel@perches.com>
Subject: Re: [PATCH] MAINTAINERS: Sort entries using parse-maintainers.pl
From:   Joe Perches <joe@perches.com>
To:     Jonathan =?ISO-8859-1?Q?Neusch=E4fer?= <j.neuschaefer@gmx.net>
Cc:     linux-kernel@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        linux-riscv@lists.infradead.org, llvm@lists.linux.dev
Date:   Sat, 04 Dec 2021 14:34:36 -0800
In-Reply-To: <YavGALvWdsW+BO9w@latitude>
References: <20211204175255.1361385-1-j.neuschaefer@gmx.net>
         <429227f33cf14aee6f0668a3d98aa220b54383d6.camel@perches.com>
         <YavGALvWdsW+BO9w@latitude>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.40.4-1ubuntu2 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Stat-Signature: 38ddh1sw19sydmoenji6nsdzpy4fsty1
X-Rspamd-Server: rspamout01
X-Rspamd-Queue-Id: EB20020033
X-Spam-Status: No, score=-2.78
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Session-ID: U2FsdGVkX1/GhABztSc7GYEWxwTLNE04mHDPa73JKYY=
X-HE-Tag: 1638657277-951064
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2021-12-04 at 20:48 +0100, Jonathan Neuschäfer wrote:
> On Sat, Dec 04, 2021 at 10:20:24AM -0800, Joe Perches wrote:
> > On Sat, 2021-12-04 at 18:52 +0100, Jonathan Neuschäfer wrote:
> > > The MAINTAINERS file got slightly out of order again, making it
> > > difficult to put new entries at the right (alphabetical) position.
> > > 
> > > Run parse-maintainers.pl to restore the alphabetical order.
> > []
> > > Checkpatch warns about a few unordered "F:" lines within sections, but I
> > > left those alone because I wanted this patch to be as automated as possible.
> > 
> > The --order option does that.
> > 
> > $ ./scripts/parse-maintainers.pl --order --output MAINTAINERS
> 
> Ah, good point.
> 
> Unfortunately, the result of parse-maintainers.pl --order currently
> produces a (small) merge conflict when merged/cherry-picked on top of
> -next, so it might be better to start without --order. (Not sure.)

My preference is still to automate the running of this command
by some script and apply it just before every -rc1 is released.


