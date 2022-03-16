Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 45E3E4DB1B4
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Mar 2022 14:39:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352484AbiCPNkN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Mar 2022 09:40:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239490AbiCPNkM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Mar 2022 09:40:12 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61DA926AE9;
        Wed, 16 Mar 2022 06:38:54 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 90F4260B63;
        Wed, 16 Mar 2022 13:38:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4E599C340E9;
        Wed, 16 Mar 2022 13:38:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1647437934;
        bh=jkyP0tJEz44jNr8gm6cik1fDuFLMdPOw5VY4g8caLoU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=JSbieH9z+sfyBQ354Y59WFJFNXoZASTWqH2/BWo9R5cNn4b9suR0f1Ku2sA82Lmrp
         aoy7G0QYTIMo8TYI7gcf8ZdSKvL91l91CdDht09mZ11xgrN7bJ2FT9AO3h3u2dfDDD
         CI2AZU02p45UPQtWMTwHQWVuh5ameLzNH77mWJec=
Date:   Wed, 16 Mar 2022 14:38:49 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Lukas Bulwahn <lukas.bulwahn@gmail.com>
Cc:     Christoph Hellwig <hch@lst.de>,
        Arve =?iso-8859-1?B?SGr4bm5lduVn?= <arve@android.com>,
        Todd Kjos <tkjos@android.com>,
        Martijn Coenen <maco@android.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Christian Brauner <christian@brauner.io>,
        Hridya Valsaraju <hridya@google.com>,
        Suren Baghdasaryan <surenb@google.com>,
        linux-staging@lists.linux.dev, kernel-janitors@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] MAINTAINERS: remove the obsolete file entry for staging
 in ANDROID DRIVERS
Message-ID: <YjHoaV+Z5u10YWHC@kroah.com>
References: <20220316124802.372-1-lukas.bulwahn@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220316124802.372-1-lukas.bulwahn@gmail.com>
X-Spam-Status: No, score=-8.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 16, 2022 at 01:48:02PM +0100, Lukas Bulwahn wrote:
> Commit 721412ed3d81 ("staging: remove ashmem") removes the last android
> driver from staging, but misses to adjust MAINTAINERS.
> 
> Hence, ./scripts/get_maintainer.pl --self-test=patterns complains about a
> broken reference.
> 
> Remove the obsolete file entry in ANDROID DRIVERS.
> 
> Signed-off-by: Lukas Bulwahn <lukas.bulwahn@gmail.com>
> ---
> Greg, please pick this minor clean-up patch for your staging-next tree on
> top of the commit above.

Now picked up, thanks for the fix.

greg k-h
