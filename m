Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4F65B47FB69
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Dec 2021 10:42:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233173AbhL0Jl6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Dec 2021 04:41:58 -0500
Received: from dfw.source.kernel.org ([139.178.84.217]:41210 "EHLO
        dfw.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229853AbhL0Jl5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Dec 2021 04:41:57 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4D71C60F59;
        Mon, 27 Dec 2021 09:41:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 058E2C36AE9;
        Mon, 27 Dec 2021 09:41:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1640598115;
        bh=L+yN0EdGPEF1CAH5M8xP84CA+DKOGY7GVjyxiaS06ss=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=qRbPP+VJtSjSj/bbwYID9++TxHwJOQrbvj0TJqG6uY2BXjdpH+wNura5iz5zd7Lu+
         PlSkMITF4uryouSmhsZZGRfsUE7HHp6jdz0GFxyRCNvN2aUr4haY1kQ74Jk++kR/2W
         Ge2QQLGuMunkz5AM/RomILL2yKIwYQFFUrps2W4Y=
Date:   Mon, 27 Dec 2021 10:37:57 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Wedson Almeida Filho <wedsonaf@google.com>
Cc:     rafael@kernel.org, corbet@lwn.net, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] driver core: make kobj_type constant.
Message-ID: <YcmJdXEeKd29+4jD@kroah.com>
References: <20211224231345.777370-1-wedsonaf@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211224231345.777370-1-wedsonaf@google.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 24, 2021 at 11:13:45PM +0000, Wedson Almeida Filho wrote:
> This way instances of kobj_type (which contain function pointers) can be
> stored in .rodata, which means that they cannot be [easily/accidentally]
> modified at runtime.
> 
> Signed-off-by: Wedson Almeida Filho <wedsonaf@google.com>

Ah, much nicer than the version I did last week but never sent out for
review yet:
	https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/driver-core.git/commit/?h=kobject-const&id=3230b957cac5f596b36c7939fe81b4f54c6d1bb3

I'll go take this one now instead, thanks!

greg k-h
