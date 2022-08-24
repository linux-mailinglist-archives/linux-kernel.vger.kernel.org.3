Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5DE6659F38C
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Aug 2022 08:19:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234949AbiHXGS5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Aug 2022 02:18:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229884AbiHXGSw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Aug 2022 02:18:52 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A647B72B62
        for <linux-kernel@vger.kernel.org>; Tue, 23 Aug 2022 23:18:51 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id A567CCE21D0
        for <linux-kernel@vger.kernel.org>; Wed, 24 Aug 2022 06:18:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A43A9C433C1;
        Wed, 24 Aug 2022 06:18:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1661321928;
        bh=xuOEfRn0BPqX1AVqOWxNeF9MJokEIlZnw9CPZ53hzOA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Be/1mBwYbAEN3+M04cd/EQ53zXBHkTrlGXOTdnHAs2pCkOF4a5YsvC01vDGRxM1hD
         8vg9KVrEJ12Onx9kZQNLYjOmDR4QnXy0qJsCfK8NkrNqi60yGClRnDE118F/LaDFe0
         3OGGnmVwTPacdjHGS0HGYWC36mUWFlIfDWiRmJyA=
Date:   Wed, 24 Aug 2022 08:18:45 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Vinod Koul <vkoul@kernel.org>
Cc:     alsa-devel@alsa-project.org,
        Bard Liao <yung-chuan.liao@linux.intel.com>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Sanyog Kale <sanyog.r.kale@intel.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/5] soundwire: sysfs: move sdw_slave_dev_attr_group into
 the existing list of groups
Message-ID: <YwXCxZuaiumS/Am5@kroah.com>
References: <20220729135041.2285908-1-gregkh@linuxfoundation.org>
 <YwT5gqOihDYK73aF@matsya>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YwT5gqOihDYK73aF@matsya>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 23, 2022 at 09:30:02PM +0530, Vinod Koul wrote:
> On 29-07-22, 15:50, Greg Kroah-Hartman wrote:
> > The sysfs logic already creates a list of groups for the device, so add
> > the sdw_slave_dev_attr_group group to that list instead of having to do
> > a two-step process of adding a group list and then an individual group.
> > 
> > This is a step on the way to moving all of the sysfs attribute handling
> > into the default driver core attribute group logic so that the soundwire
> > core does not have to do any of it manually.
> 
> Hey Greg,
> 
> DO you have a v2 for this, or if you are too busy I can update the
> patchset...

Oh wait, I did rebase it, I'll send it out this afternoon, thanks for
the reminder...

greg k-h
