Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4E7255A5ADD
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Aug 2022 06:47:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229684AbiH3ErF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Aug 2022 00:47:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229650AbiH3ErC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Aug 2022 00:47:02 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 332F2AB434
        for <linux-kernel@vger.kernel.org>; Mon, 29 Aug 2022 21:47:01 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id B1517B8162D
        for <linux-kernel@vger.kernel.org>; Tue, 30 Aug 2022 04:46:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AC4CDC433C1;
        Tue, 30 Aug 2022 04:46:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1661834818;
        bh=o/BsIPtg6md1OkJKd4gG8ixwnMhUgGQo7v8th2g+4fg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=qlfOsyLzQPR8vST6u16a00SupkgTKPLMi5QSIiqMCwlliNu6iYM6mKSClKLLjKkvl
         px5ZhJSQJWgASXjlOoZTkju15+FxmB1Bp1LW8/o/S/agnFqw5lV2R+whft4rm/M4lI
         imHDPcojO/U9exi5H99rCE3X83Ke9fSjhii8F4YVnBlsjZXh0Zsl7gBsYtdHncoPHA
         O6/M6uhOKwew5fFgRlFaMJm94IHYkF3e0OTyYS4A+5f8gZq3ztks5P9Y0maMw5XfJz
         gTRpv0mC1ec60jgIzK43d6/7qJklT+WtEfvI5Bo0D82Y33eOWmPWDcVtO7nuRAPYmi
         b710z4H2BtXyg==
Date:   Tue, 30 Aug 2022 10:16:53 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Bard Liao <yung-chuan.liao@linux.intel.com>
Cc:     alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        pierre-louis.bossart@linux.intel.com, bard.liao@intel.com
Subject: Re: [PATCH 0/3] soundwire: allocate device_number with IDA
Message-ID: <Yw2WPRiWSh/qk/rE@matsya>
References: <20220823045004.2670658-1-yung-chuan.liao@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220823045004.2670658-1-yung-chuan.liao@linux.intel.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 23-08-22, 12:50, Bard Liao wrote:
> The device_number is currently allocated in the scope of each bus and does
> not need to be unique at the system level.
> This leads e.g. on Dell devices with three or four Device1 on different
> bus segments. To make the device_number unique at the system level, and
> unified with the HDaudio/iDISP SDI values, this series allocates the
> dev_number with an IDA restricted between 4 and 11 (inclusive).

Applied, thanks

-- 
~Vinod
