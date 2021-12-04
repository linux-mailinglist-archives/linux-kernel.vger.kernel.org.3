Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DA38F4686F2
	for <lists+linux-kernel@lfdr.de>; Sat,  4 Dec 2021 19:21:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1385411AbhLDSXy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 4 Dec 2021 13:23:54 -0500
Received: from smtprelay0034.hostedemail.com ([216.40.44.34]:50336 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S229534AbhLDSXx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Dec 2021 13:23:53 -0500
Received: from omf12.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay03.hostedemail.com (Postfix) with ESMTP id 2F8DC837F24C;
        Sat,  4 Dec 2021 18:20:27 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: joe@perches.com) by omf12.hostedemail.com (Postfix) with ESMTPA id 8CB391C;
        Sat,  4 Dec 2021 18:20:25 +0000 (UTC)
Message-ID: <429227f33cf14aee6f0668a3d98aa220b54383d6.camel@perches.com>
Subject: Re: [PATCH] MAINTAINERS: Sort entries using parse-maintainers.pl
From:   Joe Perches <joe@perches.com>
To:     Jonathan =?ISO-8859-1?Q?Neusch=E4fer?= <j.neuschaefer@gmx.net>,
        linux-kernel@vger.kernel.org
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        linux-riscv@lists.infradead.org, llvm@lists.linux.dev
Date:   Sat, 04 Dec 2021 10:20:24 -0800
In-Reply-To: <20211204175255.1361385-1-j.neuschaefer@gmx.net>
References: <20211204175255.1361385-1-j.neuschaefer@gmx.net>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.40.4-1ubuntu2 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Stat-Signature: foo3f1u3hgn5jmzzcthbws61qao1rhua
X-Rspamd-Server: rspamout01
X-Rspamd-Queue-Id: 8CB391C
X-Spam-Status: No, score=0.10
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Session-ID: U2FsdGVkX1/cyDD7NO8kshW4/mXLo5/vMS1r9aOWN88=
X-HE-Tag: 1638642025-813990
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2021-12-04 at 18:52 +0100, Jonathan Neuschäfer wrote:
> The MAINTAINERS file got slightly out of order again, making it
> difficult to put new entries at the right (alphabetical) position.
> 
> Run parse-maintainers.pl to restore the alphabetical order.
[]
> Checkpatch warns about a few unordered "F:" lines within sections, but I
> left those alone because I wanted this patch to be as automated as possible.

The --order option does that.

$ ./scripts/parse-maintainers.pl --order --output MAINTAINERS


