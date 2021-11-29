Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E406B462374
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Nov 2021 22:38:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231574AbhK2VmI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Nov 2021 16:42:08 -0500
Received: from ms.lwn.net ([45.79.88.28]:53548 "EHLO ms.lwn.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229863AbhK2VkH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Nov 2021 16:40:07 -0500
Received: from localhost (unknown [IPv6:2601:281:8300:104d::5f6])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id B5D1A2CA;
        Mon, 29 Nov 2021 21:36:48 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net B5D1A2CA
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
        t=1638221808; bh=B8iH4TQC8c+H4s20u3NqIZIegy7mUTlkTXWYTRZC8jU=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=bmHeuDw1OcFrUCtN0iMsL/egboh5F4mkMqb9sxPqNioa1tjl9pxZlQT9WB/uaIOAD
         xcVD+AJw348RUM2seir1qbyy0E3urhkSfruZa4y6cHk7RwnRxRBSQgcex/eKa+SSui
         pREeTVedDHTR8k0O/zLgr8ERkXXYkgBim7F9HCVzmYe77K7P+xGUnP6p+RlqvrpNhJ
         ClmR3q+l3h8PCdksICtq7ufmfL2J0rDDAb6CSCKjzAPIGTt616Nn9BguIeHlO0VWn/
         22QRdyneAfasggY6qtpneQfw7nN7wCiuiQxQlHBE+FlpfR/1psvsXvNwb62pgXiRGy
         t6Q7rZgNRwlJQ==
From:   Jonathan Corbet <corbet@lwn.net>
To:     Jani Nikula <jani.nikula@linux.intel.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Akira Yokosawa <akiyks@gmail.com>,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Cc:     Hans Verkuil <hverkuil@xs4all.nl>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Subject: Re: [PATCH] docs: conf.py: fix support for Readthedocs v 1.0.0
In-Reply-To: <87sfvik21z.fsf@intel.com>
References: <f0660b1d24bc9bc07b13fe9a25ccb69ca14e916d.1637923850.git.mchehab+huawei@kernel.org>
 <13c40ed9-a51f-7496-7224-03b563bb6695@gmail.com>
 <59f64802-c3dc-74cd-8f35-878e3fac64e2@infradead.org>
 <87sfvik21z.fsf@intel.com>
Date:   Mon, 29 Nov 2021 14:36:47 -0700
Message-ID: <87wnkqsky8.fsf@meer.lwn.net>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Jani Nikula <jani.nikula@linux.intel.com> writes:

> Taking a step back, choosing the sphinx-rtd-theme to begin with was
> purely arbitrary, I didn't put much effort into checking the
> alternatives, and as far as I recall, neither did Jon. There were more
> pressing issues at the time to get the documentation generation ball
> rolling at all.

Yeah, I was just happy to see something that worked ... :)

> Obviously anyone can change the theme for themselves, and I guess the
> question is rather what the default is, and, subsequently, what gets
> used at [1].
>
> I haven't followed the development on this closely, but I am somewhat
> surprised at the amount of theme overrides having been added, and it
> begs the question whether there'd perhaps be a readily available stock
> theme that would be better suited than sphinx-rtd-theme?

I've never been hugely pleased with the appearance of the processed
docs, but haven't had a chance to tear into it.  I'll try to look at the
themes Mauro pointed out in the near future.

Meanwhile, I'll go ahead and apply v2 of this patch, thanks.

jon
