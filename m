Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C32AB59EA63
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Aug 2022 19:57:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230166AbiHWR4j (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Aug 2022 13:56:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234437AbiHWRz7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Aug 2022 13:55:59 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5CDBD69F4C
        for <linux-kernel@vger.kernel.org>; Tue, 23 Aug 2022 09:00:09 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 0B094B81E5E
        for <linux-kernel@vger.kernel.org>; Tue, 23 Aug 2022 16:00:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 34439C433D6;
        Tue, 23 Aug 2022 16:00:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1661270406;
        bh=wwA2YBGNNnFA5PDfuSBe87l2HUq3ccMQ6rtyqsiqxMU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=D2wzR9srCXN1qFL5426wgoeqRnsuJ0GkcO8kvNGy+dgikGCoykZkcyFXACWabGHM1
         DYNag5zeaudntWOiwvzIvTQOuE84z7uHTNCfhY6Dr3z9CRv2yMPkg412p0fzCFbWIz
         2UfVn1OEvm2EYh/l0vA/+k04YnAaXnddlF36KkCh4iJTF4QuYMG6QehMauZtjnGv3w
         fuIMBTQ29WWV1jxEZPFR9PmGwv3hlkZPDscXPJqQ4jyH+td2N87GLmg3vhIK7KqadG
         PaB9wvyKjSwKQlfmgOjASXPoMCOLTJp0KSkMsWhXc6fDECMdL0kVj0QmrHIzrAgTp0
         5rgSHZ/mAYZJw==
Date:   Tue, 23 Aug 2022 21:30:02 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     alsa-devel@alsa-project.org,
        Bard Liao <yung-chuan.liao@linux.intel.com>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Sanyog Kale <sanyog.r.kale@intel.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/5] soundwire: sysfs: move sdw_slave_dev_attr_group into
 the existing list of groups
Message-ID: <YwT5gqOihDYK73aF@matsya>
References: <20220729135041.2285908-1-gregkh@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220729135041.2285908-1-gregkh@linuxfoundation.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 29-07-22, 15:50, Greg Kroah-Hartman wrote:
> The sysfs logic already creates a list of groups for the device, so add
> the sdw_slave_dev_attr_group group to that list instead of having to do
> a two-step process of adding a group list and then an individual group.
> 
> This is a step on the way to moving all of the sysfs attribute handling
> into the default driver core attribute group logic so that the soundwire
> core does not have to do any of it manually.

Hey Greg,

DO you have a v2 for this, or if you are too busy I can update the
patchset...

-- 
~Vinod
