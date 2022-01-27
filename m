Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 23D0949DBC1
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jan 2022 08:36:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237414AbiA0HgR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jan 2022 02:36:17 -0500
Received: from dfw.source.kernel.org ([139.178.84.217]:35058 "EHLO
        dfw.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230174AbiA0HgQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jan 2022 02:36:16 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1366F619E5;
        Thu, 27 Jan 2022 07:36:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 19911C340E4;
        Thu, 27 Jan 2022 07:36:14 +0000 (UTC)
Date:   Thu, 27 Jan 2022 08:36:12 +0100
From:   Greg KH <greg@kroah.com>
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     "Maciej W. Rozycki" <macro@embecosm.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: Re: linux-next: build warnings after merge of the tty.current tree
Message-ID: <YfJLbC6JIhfT5VyR@kroah.com>
References: <20220127091800.1e8f333b@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220127091800.1e8f333b@canb.auug.org.au>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 27, 2022 at 09:18:00AM +1100, Stephen Rothwell wrote:
> Hi all,
> 
> After merging the tty.current tree, today's linux-next build (x86_64
> allmodconfig) produced these warnings:
> 
> In file included from <command-line>:
> ./usr/include/linux/cyclades.h:6:2: warning: #warning "Support for features provided by this header has been removed" [-Wcpp]
>     6 | #warning "Support for features provided by this header has been removed"
>       |  ^~~~~~~
> ./usr/include/linux/cyclades.h:7:2: warning: #warning "Please consider updating your code" [-Wcpp]
>     7 | #warning "Please consider updating your code"
>       |  ^~~~~~~
> 
> 
> Introduced by commit
> 
>   f23653fe6447 ("tty: Partially revert the removal of the Cyclades public API")
> 
> This is a bit annoying :-(
> 
> Can we exclude include/uapi/linux/cyclades.h from the headers checking,
> please?

Fix sent:
	https://lore.kernel.org/r/20220127073304.42399-1-gregkh@linuxfoundation.org

