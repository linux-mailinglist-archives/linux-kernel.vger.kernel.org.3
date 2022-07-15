Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B3C8A575B06
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Jul 2022 07:34:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229982AbiGOFeL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Jul 2022 01:34:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229468AbiGOFeH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Jul 2022 01:34:07 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4FAE3371A4
        for <linux-kernel@vger.kernel.org>; Thu, 14 Jul 2022 22:34:06 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E526662266
        for <linux-kernel@vger.kernel.org>; Fri, 15 Jul 2022 05:34:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E05C0C341C8;
        Fri, 15 Jul 2022 05:34:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1657863245;
        bh=8AE4o8ewF2ekDEdTv+zAMfNARoKMQPEnhT7k5nsCu1Y=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ecLMnn2ISF4ZOoIIun04BH+G/iql5cyvTWtGpYxhjAMblyvqVobUY3Lz5ihldmnve
         UAB5k7fV36OcXrU+ly9+KSt7babHcTeL0/vJoXXdRQ5AK7GrzMzCe/oRZEs5BXwwZf
         xAjoyWm1KprpmbPOG2a3cn37L/OFoykYb51DAdnA=
Date:   Fri, 15 Jul 2022 07:33:39 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Vinod Koul <vkoul@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>
Subject: Re: [GIT PULL]: soundwire updates for v5.20-rc1
Message-ID: <YtD8M6+bf1ptLH1+@kroah.com>
References: <YtDxdBLgvAHG8IhG@matsya>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YtDxdBLgvAHG8IhG@matsya>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 15, 2022 at 10:17:48AM +0530, Vinod Koul wrote:
> Hello Greg,
> 
> Please pull to receive updates for soundwire subsystem. This is smallish
> request this time but few important changes:
> 
> The following changes since commit f2906aa863381afb0015a9eb7fefad885d4e5a56:
> 
>   Linux 5.19-rc1 (2022-06-05 17:18:54 -0700)
> 
> are available in the Git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/vkoul/soundwire.git tags/soundwire-5.20-rc1

Pulled and pushed out, thanks.

greg k-h
