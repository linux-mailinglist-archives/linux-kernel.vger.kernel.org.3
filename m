Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 79BAF5A9A44
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Sep 2022 16:30:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234765AbiIAO3f (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Sep 2022 10:29:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234821AbiIAO3Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Sep 2022 10:29:25 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89FC76C138
        for <linux-kernel@vger.kernel.org>; Thu,  1 Sep 2022 07:29:21 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3B27D61D13
        for <linux-kernel@vger.kernel.org>; Thu,  1 Sep 2022 14:29:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 488FFC433C1;
        Thu,  1 Sep 2022 14:29:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1662042559;
        bh=jFE2xM5WLXWebAiP4GZXPcQbfdEnIL2CMtGp9xZiGUU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=OO2lNa3jeF4nJVKeq4IPO0QlDFMlwDcFT9hM5Puy2CWXpAPCfx8cJ/HUISxb37uww
         WGplzQe3lGb/tDVST8jVWCgDnND5rqSLAK7g96oON5MEM5Cw+xKEczRyscFvPyv+qg
         wb41AmTzwsU5CjrVoJnpe0RJfa/18dDkAvcMFb/w=
Date:   Thu, 1 Sep 2022 16:29:16 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Petr Vorel <pvorel@suse.cz>
Cc:     linux-kernel@vger.kernel.org,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        David Sterba <dsterba@suse.com>
Subject: Re: [PATCH v2 1/1] drivers/base/cpu: Print kernel arch
Message-ID: <YxDBvD5XrbLApWMy@kroah.com>
References: <20220729125141.12786-1-pvorel@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220729125141.12786-1-pvorel@suse.cz>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 29, 2022 at 02:51:41PM +0200, Petr Vorel wrote:
> Print the machine hardware name (UTS_MACHINE) in /proc/sys/kernel/arch.
> 
> This helps people who debug kernel with initramfs with minimal
> environment (i.e. without coreutils or even busybox) or allow to open
> sysfs file instead of run 'uname -m' in high level languages.
> 
> Signed-off-by: Petr Vorel <pvorel@suse.cz>
> ---
>  Documentation/admin-guide/sysctl/kernel.rst | 5 +++++
>  kernel/utsname_sysctl.c                     | 7 +++++++
>  2 files changed, 12 insertions(+)

Wait, why does the subject line say "drivers/base/cpu"?  That's not a
file being touched in this commit at all, so this isn't for me to take
:(

thanks,

greg k-h
