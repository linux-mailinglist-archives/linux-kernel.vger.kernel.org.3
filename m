Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2510559EB22
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Aug 2022 20:36:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229972AbiHWSfg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Aug 2022 14:35:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232211AbiHWSfP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Aug 2022 14:35:15 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0AD7811055A
        for <linux-kernel@vger.kernel.org>; Tue, 23 Aug 2022 09:57:28 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9CDF3612F4
        for <linux-kernel@vger.kernel.org>; Tue, 23 Aug 2022 16:57:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6E004C433C1;
        Tue, 23 Aug 2022 16:57:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1661273847;
        bh=ILofJQNAPtCt8D4KROyhb9HXhaTVCSnLCCkexZJs6WQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=aj5W19QIbx6s3zf4uNbcihaIRNhaCWfnn1FHQfFMoLMcYfhkOA4MvkAB9GQXj0LwJ
         3/J514Yqs4iGttCRRYqf3pp2S0XBEn1YIdBkz9fqkPErZLhz7DnW4D4JxRnzOXroKK
         Sqm0lNOIExWp6HXueo+QxZKFlVm/LyUJmpvm38EiHCZ0IEK37EzippOJp6vD3I3uEt
         uLcdRv4o0ShoSkKxrwvsgkzPalhGdFNIhN41q48Z8dhXodCovB4F7ypU8YYdzdGkLR
         1oyDErA687AWLL+T9q+wySrExvJDY8B2ZG2FNzcHrX8lIzvNlr8x08DSZTye1j953w
         AiOE25T30Pkfg==
Date:   Tue, 23 Aug 2022 22:27:21 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Bard Liao <yung-chuan.liao@linux.intel.com>
Cc:     alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        pierre-louis.bossart@linux.intel.com, bard.liao@intel.com
Subject: Re: [PATCH] soundwire: dmi-quirks: add remapping for HP Omen
 16-k0005TX
Message-ID: <YwUG8bRepEWv0imD@matsya>
References: <20220823030919.2346629-1-yung-chuan.liao@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220823030919.2346629-1-yung-chuan.liao@linux.intel.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 23-08-22, 11:09, Bard Liao wrote:
> From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
> 
> The DSDT for this device has a number of problems:
> a) it lists rt711 on link0 and link1, but link1 is disabled
> b) the rt711 entry on link0 uses the wrong v2 instead of v3 (SDCA)
> c) the rt1316 amplifier on link3 is not listed.
> 
> Add a remapping table to work-around these BIOS shenanigans.

Applied, thanks

-- 
~Vinod
