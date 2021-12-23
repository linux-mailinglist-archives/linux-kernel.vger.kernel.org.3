Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5887F47E662
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Dec 2021 17:31:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349191AbhLWQa6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Dec 2021 11:30:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244178AbhLWQa6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Dec 2021 11:30:58 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E527AC061401
        for <linux-kernel@vger.kernel.org>; Thu, 23 Dec 2021 08:30:57 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id F0CAFB81FC5
        for <linux-kernel@vger.kernel.org>; Thu, 23 Dec 2021 16:30:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E1235C36AE9;
        Thu, 23 Dec 2021 16:30:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1640277054;
        bh=5h5jlL1CoD8c3uPG+Th3OmXqA0mLDqdKzYcnCsiy/94=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=UNblrztlpZhICT0sHBF0Iu0vcot62hR5AKJflq1A29L5YTNuonMuPIIN1FzzB/iiw
         OtqNvs3Ujjtbxvyt77jsJNd6vpYuhzJVU3maglC6yHOhJX64dE5k41CaMDMlbSWUCH
         OX3maWpTyPSPJ7W/SsXtHrI0XbJfizJi6fPmjk+8q8eHT10zcwmT+iCG5bPfmtJp/U
         YQNvh1miHph0e+ZQQGpuWroD6OJrQCnSNT8o1zRDag6G3r6I5idCL7cyW/vS7uraxk
         8V3ZshlUnb8IdXiEgjgxGh4m0iK1PzCT1AHm1RE1nz7wc4iRTUpImEjMriGeRO/IQE
         vKLtheWBHdAUA==
Date:   Thu, 23 Dec 2021 22:00:50 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Bard Liao <yung-chuan.liao@linux.intel.com>
Cc:     alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        tiwai@suse.de, broonie@kernel.org, gregkh@linuxfoundation.org,
        srinivas.kandagatla@linaro.org,
        pierre-louis.bossart@linux.intel.com, sanyog.r.kale@intel.com,
        bard.liao@intel.com
Subject: Re: [PATCH 2/7] ASoC/soundwire: intel: simplify callbacks for
 params/hw_free
Message-ID: <YcSkOuwjKNLDUIc7@matsya>
References: <20211213054634.30088-1-yung-chuan.liao@linux.intel.com>
 <20211213054634.30088-3-yung-chuan.liao@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211213054634.30088-3-yung-chuan.liao@linux.intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 13-12-21, 13:46, Bard Liao wrote:
> From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
> 
> We don't really need to pass a substream to the callback, we only need
> the direction. No functionality change, only simplification to enable
> improve suspend with paused streams.

Acked-By: Vinod Koul <vkoul@kernel.org>

-- 
~Vinod
