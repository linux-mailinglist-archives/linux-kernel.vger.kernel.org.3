Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CDEA048C7A1
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jan 2022 16:52:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354824AbiALPwh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Jan 2022 10:52:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245483AbiALPwe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jan 2022 10:52:34 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A97FAC06173F;
        Wed, 12 Jan 2022 07:52:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=WJbLqDhZiskfp5FI4IE2x8brDDmN7SOUeyren1ySdPE=; b=jxnEEsy5n0BssJvJbU2r4hq+Ew
        /D5esqzqKe83/Jar+jJ9J31vVLRiPHNNUZfgpMQmhKPeeJZXJQodW8TSjOqlavH86xSGIB4Xbq1y5
        Ihgx/dD3V+p43hLKc4IS+jLFj/ikxFL0I6CEM7wI7CAHhQzgFD9rhpbZgJVMuL5c4ciVhE+Ankv4Q
        itXE5XZ1OW5j/5ODe/1HJhSJIu6XOCEc6Yw88/sGuFX0G4JfGd8JTa/mrGRFKHbxlSMP9koaQcs1+
        UFDziF99LWaYJb8B61onPRed20UYQY/F9v0NJU4LrSQbqoHWHwwNaxgOfg9KsdJoxEH4ao7VeSy9c
        xmN2tFgQ==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1n7fvH-0030LB-GT; Wed, 12 Jan 2022 15:52:27 +0000
Date:   Wed, 12 Jan 2022 07:52:27 -0800
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     Aaron Tomlin <atomlin@redhat.com>
Cc:     Allen <allen.lkml@gmail.com>, Christoph Lameter <cl@linux.com>,
        Petr Mladek <pmladek@suse.com>,
        Miroslav Benes <mbenes@suse.cz>,
        Andrew Morton <akpm@linux-foundation.org>, jeyu@kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-modules@vger.kernel.org, atomlin@atomlin.com,
        ghalat@redhat.com
Subject: Re: [RFC PATCH v2 00/13] module: core code clean up
Message-ID: <Yd75OzrhrjDp7CVa@bombadil.infradead.org>
References: <20220106234319.2067842-1-atomlin@redhat.com>
 <CAOMdWSJHm9bRAcrB6U+FsRiK6Fg2bbtbUH82w54VD7kbFmnVsA@mail.gmail.com>
 <CAOMdWS+Sn1sZJt8ocig5U7d7qG3N8oJBW-D1ey0qbZ3AXF-JWg@mail.gmail.com>
 <20220112132104.7emyelwuv3jmmhdt@ava.usersys.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220112132104.7emyelwuv3jmmhdt@ava.usersys.com>
Sender: Luis Chamberlain <mcgrof@infradead.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 12, 2022 at 01:21:04PM +0000, Aaron Tomlin wrote:
> On Tue 2022-01-11 17:16 -0800, Allen wrote:
> > Hi Aaron,
> 
> Hi Allen,
> 
> >   Was the code compile tested?
> 
> Not entirely i.e. not the whole of kernel/module/Makefile, unfortunately.
> Furthermore, only x86-64 was compiled tested. At the moment, I felt the
> need to share the concept/or approach thus far to simply obtain some
> overall feedback before further modifications.
> 
> >   Unfortunately, I could not apply the series cleanly on top of the
> > latest 5.17-rc1.
> 
> Sorry about that: this work was based on Linus' commit 81361b837a34 ("Merge
> tag 'kbuild-v5.14' of
> git://git.kernel.org/pub/scm/linux/kernel/git/masahiroy/linux-kbuild.").

Please work off of modules-next tree:

https://git.kernel.org/pub/scm/linux/kernel/git/mcgrof/linux.git/log/?h=modules-next

That is, this tree on the modules-next branch:

git://git.kernel.org/pub/scm/linux/kernel/git/mcgrof/linux.git

  Luis
