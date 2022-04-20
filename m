Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3C863508D92
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Apr 2022 18:44:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1380719AbiDTQqi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Apr 2022 12:46:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1380654AbiDTQqe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Apr 2022 12:46:34 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 828CF46668
        for <linux-kernel@vger.kernel.org>; Wed, 20 Apr 2022 09:43:48 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1E8DE619F3
        for <linux-kernel@vger.kernel.org>; Wed, 20 Apr 2022 16:43:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 28C50C385A0;
        Wed, 20 Apr 2022 16:43:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1650473027;
        bh=9GjSLIfyruU+iE5gkdLNLZ4kse8AJfAtbsB0MjQ7940=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Q7FP/YTQ8e7+GXsDV31+TVqx4iwyLkJHmpjsZ0zGReLckU+i26tRlwhI91b3g9VSN
         ZJz95q6QX9DKSXlcqMcSrTOyy5txEZQsDyRJ+71u5eIdvWiBb3wDZxr6DHb9iYkHTr
         rrOpo+2sKkNu59tMrmEoXxYmTAuV+uFZumk+mIGM=
Date:   Wed, 20 Apr 2022 18:43:44 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Bruno Moreira-Guedes <codeagain@codeagain.dev>
Cc:     Martyn Welch <martyn@welchs.me.uk>,
        Manohar Vanga <manohar.vanga@gmail.com>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        outreachy@lists.linux.dev,
        Bruno's Patch Watchbox <patch-reply@codeagain.dev>
Subject: Re: [PATCH v3 0/3] staging: vme: Cleanup driver tree old structures
Message-ID: <YmA4QIRfx2QPhEJi@kroah.com>
References: <cover.1650321310.git.codeagain@codeagain.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1650321310.git.codeagain@codeagain.dev>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 18, 2022 at 08:29:49PM -0300, Bruno Moreira-Guedes wrote:
> This patch series modify the vme_user driver's place in
> menuconfig (1/3), fixes a missing `depends on` line in a Kconfig file
> (2/3), and rearrages the directory tree for the driver allowing a more
> straightforward comprehension of its contents (3/3).
> 
> The 'vme_user/' driver is the only remaining vme-family driver in the
> 'staging/' tree, but its structure, entry in menuconfig and building
> routines are still attached to the 'vme/' subtree now outside
> 'staging/'. The present patchset fixes it.
> 
> Signed-off-by: Bruno Moreira-Guedes <codeagain@codeagain.dev>

What about deleting the vme drivers entirely?

Martyn, anyone still using these?

thanks,

greg k-h
