Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8C5194CA88C
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Mar 2022 15:51:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243262AbiCBOwU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Mar 2022 09:52:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243255AbiCBOwT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Mar 2022 09:52:19 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18AA9C7D5A
        for <linux-kernel@vger.kernel.org>; Wed,  2 Mar 2022 06:51:36 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B37C061633
        for <linux-kernel@vger.kernel.org>; Wed,  2 Mar 2022 14:51:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C9965C004E1;
        Wed,  2 Mar 2022 14:51:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1646232695;
        bh=55OowXDED0T4vPvUE/5AM8e5SF3G5PjA0k0ySt2ITdg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=m+YEZ5Bfg7TqQzSIBDab8rx+gNq7K9v9aRtf9fYksmhqqKINQYWK705moc1pAiu4X
         tWhFcZoNX0PGkRozS1ynXICP3uXAOU/Nllueri+G5+qwieI8SOlldjMRqMNeUka5nz
         B0HrIG0UC5GKpifl98DqtWGAbMztgC5pEL022tOs=
Date:   Wed, 2 Mar 2022 15:51:32 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Nguyen Dinh Phi <phind.uet@gmail.com>
Cc:     linux-kernel@vger.kernel.org
Subject: Re: [PATCH RESEND] samples/kobject: Use sysfs_emit instead of
 snprintf
Message-ID: <Yh+EdGcsoF+lBjfX@kroah.com>
References: <20220302120759.380932-1-phind.uet@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220302120759.380932-1-phind.uet@gmail.com>
X-Spam-Status: No, score=-7.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 02, 2022 at 08:07:59PM +0800, Nguyen Dinh Phi wrote:
> Convert sprintf() to sysfs_emit() in order to check buffer overrun on sysfs
> outputs.

There are no such buffer overruns on these sysfs files.

> 
> Signed-off-by: Nguyen Dinh Phi <phind.uet@gmail.com>
> ---
>  samples/kobject/kobject-example.c | 4 ++--
>  samples/kobject/kset-example.c    | 4 ++--
>  2 files changed, 4 insertions(+), 4 deletions(-)

Why is this a resend?  What happened to the first version?

thanks,

greg k-h
