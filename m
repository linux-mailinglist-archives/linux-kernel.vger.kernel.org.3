Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7BD034D53E6
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Mar 2022 22:50:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232848AbiCJVvH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Mar 2022 16:51:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344083AbiCJVvE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Mar 2022 16:51:04 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12A6AFABD6
        for <linux-kernel@vger.kernel.org>; Thu, 10 Mar 2022 13:50:02 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9BA5861A95
        for <linux-kernel@vger.kernel.org>; Thu, 10 Mar 2022 21:50:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A4A7AC340E8;
        Thu, 10 Mar 2022 21:50:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1646949001;
        bh=CEC+fXpAIGgJovTgBZcpLqWqgTUrRG0j28afwA6P//Q=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=GpF6e6hj/Xt2Tpgk7CR/sTdekzEY/GguaxXnfm+qWz4y//STFnNcYYk67rx+Pz2ks
         Z29JGrBi8c9qEBcSdLxglJoQ5OEX6bTL5YwClEPgQsXpRCiRvDY7GEXmXa/ZQ2Q91c
         aARX5jieY+GLv+WSK2mJqrXCx1d3KFkJcdpCgI7I=
Date:   Thu, 10 Mar 2022 22:48:55 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Vinod Koul <vkoul@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>
Subject: Re: [GIT PULL] soundwire updates for v5.18-rc1
Message-ID: <YipyR+xRLKabmpXa@kroah.com>
References: <YiJJR1hYtlJfBCe4@matsya>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YiJJR1hYtlJfBCe4@matsya>
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 04, 2022 at 10:45:51PM +0530, Vinod Koul wrote:
> Hello Greg,
> 
> Please pull to receive updates for soundwire subsystem for v5.18.
> 
> Mostly bunch of core stream refactoring by Intel folks and qcom driver
> updates.
> 
> The following changes since commit e783362eb54cd99b2cac8b3a9aeac942e6f6ac07:
> 
>   Linux 5.17-rc1 (2022-01-23 10:12:53 +0200)
> 
> are available in the Git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/vkoul/soundwire.git tags/soundwire-5.18-rc1
> 

Pulled and pushed out, thanks.

greg k-h
