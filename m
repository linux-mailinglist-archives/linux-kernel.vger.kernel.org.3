Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D8D2A577A8C
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Jul 2022 07:48:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232865AbiGRFnm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Jul 2022 01:43:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229585AbiGRFni (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jul 2022 01:43:38 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A9FD13D55
        for <linux-kernel@vger.kernel.org>; Sun, 17 Jul 2022 22:43:37 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 9E7BFB80B63
        for <linux-kernel@vger.kernel.org>; Mon, 18 Jul 2022 05:43:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7DF7BC341C8;
        Mon, 18 Jul 2022 05:43:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1658123014;
        bh=8BtyTe4sNVL2w0ntx6AQKvZa+6/Vk6UGPounqoCrpzY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Vs/9XArQKK8pyqa6WpINT2ck4onBuCbxxyeGf5ZXvAVXoK0JV30kmyIQ5SZ05hUbD
         xUOqAFcu84t0c+fXefhVuwB1SfYiqjeI/JNJIFhQUcto6M4iCPMBX6KkyCDuHTZJ+C
         3Mew5ALBowFQ5LyT38xo6XIo/2D2QknOZl2kI35Bo+w2/JY3qJvRyCDM69ZfS23pl2
         PQEw87iLMVC3c+6r9zRQhZzYvGm6+P4tcjSBU/wB23F3NCqE2F8DxTb8nZvkAftszV
         ja6ZwEQspvSL+mXySywszePSH+qKNt1J8tmQhHP4BOFZWIoU6n7kBTVuLqhVAwyDnM
         MV4fYX+MoFDBQ==
Date:   Mon, 18 Jul 2022 11:13:29 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Mark Brown <broonie@kernel.org>
Cc:     Bard Liao <yung-chuan.liao@linux.intel.com>,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        tiwai@suse.de, pierre-louis.bossart@linux.intel.com,
        bard.liao@intel.com
Subject: Re: [PATCH 4/4] ASoC: codecs: show PING status on resume failures
Message-ID: <YtTzAS+lflz6tk1Z@matsya>
References: <20220714011043.46059-1-yung-chuan.liao@linux.intel.com>
 <20220714011043.46059-5-yung-chuan.liao@linux.intel.com>
 <YtBs1jwgop756z6T@sirena.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YtBs1jwgop756z6T@sirena.org.uk>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hey Mark,

On 14-07-22, 20:21, Mark Brown wrote:
> On Thu, Jul 14, 2022 at 09:10:43AM +0800, Bard Liao wrote:
> > From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
> > 
> > This helper should help identify cases where devices fall off the bus
> > and don't resync.
> 
> Acked-by: Mark Brown <broonie@kernel.org>
> 
> If this is applied to the Soundwire tree it might be good to get a pull
> request in case of conflicts, though I guess they are relatively
> unlikely here.

It is bit late for sdw tree (we are closed for this cycle now), if you
are okay, pls feel free to take thru ASoC tree:

You may use:
git://git.kernel.org/pub/scm/linux/kernel/git/vkoul/soundwire.git tags/soundwire-5.20-rc1

-- 
~Vinod
