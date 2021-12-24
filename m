Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D5C0E47F02A
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Dec 2021 17:33:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245488AbhLXQdT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Dec 2021 11:33:19 -0500
Received: from relay030.a.hostedemail.com ([64.99.140.30]:55602 "EHLO
        relay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S230213AbhLXQdT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Dec 2021 11:33:19 -0500
Received: from omf05.hostedemail.com (a10.router.float.18 [10.200.18.1])
        by unirelay02.hostedemail.com (Postfix) with ESMTP id 7087621CB1;
        Fri, 24 Dec 2021 16:33:17 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: joe@perches.com) by omf05.hostedemail.com (Postfix) with ESMTPA id 68F9220019;
        Fri, 24 Dec 2021 16:33:08 +0000 (UTC)
Message-ID: <bc5b21934b2b871d2745dab8f469ce6458222594.camel@perches.com>
Subject: Re: [PATCH v2 1/2] zram: zram_drv: add SPDX license identifiers
From:   Joe Perches <joe@perches.com>
To:     Miko Larsson <mikoxyzzz@gmail.com>, minchan@kernel.org,
        ngupta@vflare.org, senozhatsky@chromium.org, axboe@kernel.dk,
        linux-kernel@vger.kernel.org, linux-block@vger.kernel.org
Cc:     hch@infradead.org
Date:   Fri, 24 Dec 2021 08:33:13 -0800
In-Reply-To: <985cf51402ff6ea2c199869c3501a43a6588ae4f.camel@gmail.com>
References: <20211217063224.3474-1-mikoxyzzz@gmail.com>
         <20211217063224.3474-2-mikoxyzzz@gmail.com>
         <b71570d5bc14181c656f8dd7ba69a397fd775495.camel@perches.com>
         <985cf51402ff6ea2c199869c3501a43a6588ae4f.camel@gmail.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.40.4-1ubuntu2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Stat-Signature: 5phd8tk73e3sh895x1zw56qx3f765fsn
X-Spam-Status: No, score=-4.88
X-Rspamd-Server: rspamout08
X-Rspamd-Queue-Id: 68F9220019
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Session-ID: U2FsdGVkX199oY8bydCSIdLHs8JRyNoPq2HxB+fe+ZQ=
X-HE-Tag: 1640363588-879701
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

(resending, original sent with an html part, unknown how)

On Fri, 2021-12-24 at 14:13 +0100, Miko Larsson wrote:
> On Tue, 2021-12-21 at 01:33 -0800, Joe Perches wrote:
> > GPL v2 is a permissive license and this SPDX tag should probably be
> > 
> > // SPDX-License-Identifier: GPL-2.0-or-later or BSD-3-Clause
> 
> It shouldn't be GPL-2.0-or-later, because the original copyright notice
> doesn't have an "or later" clause.

On its face, a GPL-2.0 license notice grant does _not_ need to
include any 'or later' content.

The GPL 2.0 license is permissive, it's at the _grantee's_ option.

I believe Nitin Gupta, the original author and submitter, should
declare whether or not he intended the license to include the
'or later' option.

Nitin?

Did you intend to use GPL-2.0 only and exclude GPL-3.0 or any later
version?


