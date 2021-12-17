Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 60A4147833E
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Dec 2021 03:40:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231579AbhLQCkB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Dec 2021 21:40:01 -0500
Received: from relay036.a.hostedemail.com ([64.99.140.36]:17492 "EHLO
        relay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S229471AbhLQCkA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Dec 2021 21:40:00 -0500
Received: from omf10.hostedemail.com (a10.router.float.18 [10.200.18.1])
        by unirelay08.hostedemail.com (Postfix) with ESMTP id 97C6B2051E;
        Fri, 17 Dec 2021 02:39:59 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: joe@perches.com) by omf10.hostedemail.com (Postfix) with ESMTPA id BAB1635;
        Fri, 17 Dec 2021 02:39:58 +0000 (UTC)
Message-ID: <286e55e0c37d2ae60c123412318f90accf0473d0.camel@perches.com>
Subject: Re: [RFC] Add a 'tag' field to MAINTAINERS
From:   Joe Perches <joe@perches.com>
To:     Matthew Wilcox <willy@infradead.org>,
        Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org
Date:   Thu, 16 Dec 2021 18:39:57 -0800
In-Reply-To: <Ybuy++k9sitvrem3@casper.infradead.org>
References: <Ybuy++k9sitvrem3@casper.infradead.org>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.40.4-1ubuntu2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.04
X-Stat-Signature: e1hmq1ekhdkdd8tu1q3cma4n3p5umpqy
X-Rspamd-Server: rspamout05
X-Rspamd-Queue-Id: BAB1635
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Session-ID: U2FsdGVkX1+L+MsXCm29j3MGY4MfgRejPTyewD0MGG8=
X-HE-Tag: 1639708798-907170
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2021-12-16 at 21:43 +0000, Matthew Wilcox wrote:
> People find it hard to use the right tag when sending patches which
> affect a maintainer that they don't interact with often.  If we add
> a field to MAINTAINERS, perhaps a tool will be written some day that
> automatically adds it to patches.
> 
> Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 0a1410d5a621..c6358fa58fed 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -81,6 +81,7 @@ Descriptions of section entries:
>  	R: Designated reviewer: FullName <address@domain>
>  	   These reviewers should be CCed on patches.
>  	L: Mailing list that is relevant to this area
> +	J: Prefix to use when sending a patch
>  	W: Web-page with status/info
>  	B: URI for where to file bugs. A web-page with detailed bug
>  	   filing info, a direct bug tracker link, or a mailto: URI.
> @@ -2667,6 +2668,7 @@ F:	drivers/leds/leds-blinkm.c
>  BLOCK LAYER
>  M:	Jens Axboe <axboe@kernel.dk>
>  L:	linux-block@vger.kernel.org
> +J:	block
>  T:	git git://git.kernel.org/pub/scm/linux/kernel/git/axboe/linux-block.git
>  S:	Maintained
>  F:	block/
> @@ -14927,6 +14929,7 @@ M:	Pawel Osciak <pawel@osciak.com>
>  M:	Marek Szyprowski <m.szyprowski@samsung.com>
>  M:	Kyungmin Park <kyungmin.park@samsung.com>
>  L:	linux-media@vger.kernel.org
> +J:	videobuf
>  S:	Maintained
>  F:	drivers/media/v4l2-core/videobuf2-*
>  F:	include/media/videobuf2-*
> 


