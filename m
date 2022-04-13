Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A3A5F4FF029
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Apr 2022 08:53:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233150AbiDMGzO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Apr 2022 02:55:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229490AbiDMGzL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Apr 2022 02:55:11 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A055426118
        for <linux-kernel@vger.kernel.org>; Tue, 12 Apr 2022 23:52:50 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2929261D07
        for <linux-kernel@vger.kernel.org>; Wed, 13 Apr 2022 06:52:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2C799C385A4;
        Wed, 13 Apr 2022 06:52:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1649832769;
        bh=IEqi4TrpG6lNCJBW66RRrnO7sFCu0A/GuxCQPlxDAAM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=WXTeBgqPioI0G42uxtMfVmti0ZNWls+Xr0edWGJ7b9DWXiF8ROxVDDMMeAJhp3Ns/
         6MiLdHqCeshWqw+OUG8toAKOUfMJUf17lLNAq9HdpS98i85grXycDHlNTCLdIHLP8m
         psGQpthk/ZOlsZBhf6gymq4DWqEVTXJqx6UiWR/4=
Date:   Wed, 13 Apr 2022 08:52:47 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
Cc:     linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        outreachy@lists.linux.dev
Subject: Re: [PATCH] staging: Remove the drivers for the Unisys s-Par
Message-ID: <YlZzP5ghZeR1AtIg@kroah.com>
References: <20220412215901.31046-1-fmdefrancesco@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220412215901.31046-1-fmdefrancesco@gmail.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 12, 2022 at 11:59:01PM +0200, Fabio M. De Francesco wrote:
> The Unisys sub-tree contains three drivers for the "Unisys Secure Partition"
> (s-Par(R)): visorhba, visorinput, visornic.
> 
> They have no maintainers, in fact the only one that is listed in MAINTAINERS
> has an unreacheable email address. During 2021 and 2022 several patches have
> been submitted to these drivers but nobody at Unisys cared of reviewing the
> changes. Probably, also the "sparmaintainer" internal list of unisys.com is
> not anymore read by interested Unisys' engineers.
> 
> Therefore, remove the ./unisys subdirectory of staging and delete the related
> entries in the MAINTAINERS, Kconfig, Makefile files.
> 
> Suggested-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Signed-off-by: Fabio M. De Francesco <fmdefrancesco@gmail.com>
> ---
>  MAINTAINERS                                   |    8 -

You forgot to at least cc: the people/list on the MAINTAINERS entry that
you are removing here, to give them a hint that this is happening in
case they want to speak up here (and to give us the ability to point to
that years later when they complain they were never notified...)

Also, if you are in the "delete code" mood, I think drivers/staging/vme/
and drivers/vme/ can probably also be deleted given that the maintainer
for that has moved on to other jobs.  Ask them and see!

thanks,

greg k-h
