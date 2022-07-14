Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E00915750AA
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Jul 2022 16:23:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239639AbiGNOXD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Jul 2022 10:23:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232255AbiGNOXB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jul 2022 10:23:01 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63D9364E39;
        Thu, 14 Jul 2022 07:23:00 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 1745DB82627;
        Thu, 14 Jul 2022 14:22:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3B2E9C341C6;
        Thu, 14 Jul 2022 14:22:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1657808577;
        bh=pdAoBFZRz9UfEP/QQUjjAH4AlTTPjJTxY2ZFDkrk9qk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=FGFlLSkWn6Xa4BJ1cJkqmvJiuFHNjVqTdF5uRztkX82ue2HMTRM9/loMPfoJDn+gB
         CmKGeWybZLkT1lhyMZDynfKi5YuLUqm3W79is8fxDf+271ii74G9bEWEFhG2bQnDEZ
         eycpZpL0OQxatM0D20xODpfpbidlAFnNneL6hD44=
Date:   Thu, 14 Jul 2022 16:22:54 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Johan Hovold <johan@kernel.org>
Cc:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [GIT PULL] USB-serial fixes for 5.19-rc7
Message-ID: <YtAmvoSgn3J9+1DF@kroah.com>
References: <YtAitIrTRRVkaUKJ@hovoldconsulting.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YtAitIrTRRVkaUKJ@hovoldconsulting.com>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 14, 2022 at 04:05:40PM +0200, Johan Hovold wrote:
> The following changes since commit 32346491ddf24599decca06190ebca03ff9de7f8:
> 
>   Linux 5.19-rc6 (2022-07-10 14:40:51 -0700)
> 
> are available in the Git repository at:
> 
>   https://git.kernel.org/pub/scm/linux/kernel/git/johan/usb-serial.git tags/usb-serial-5.19-rc7

Ah, had to pull in 5.19-rc6 into my branch, but that worked.  Now pulled
and pushed out, thanks.

greg k-h
