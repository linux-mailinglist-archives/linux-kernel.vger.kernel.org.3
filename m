Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 246F64B0F27
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Feb 2022 14:49:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242419AbiBJNsp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Feb 2022 08:48:45 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:48648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233034AbiBJNso (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Feb 2022 08:48:44 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8588191
        for <linux-kernel@vger.kernel.org>; Thu, 10 Feb 2022 05:48:45 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 7A3FBB82557
        for <linux-kernel@vger.kernel.org>; Thu, 10 Feb 2022 13:48:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6EACDC004E1;
        Thu, 10 Feb 2022 13:48:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1644500923;
        bh=p4N+78S3zEuymfrL0nYcGvJ9HSg9I+EqER3IH8vanbw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=RCpZyENIV4XpcuwU2buWrt+5Y6o0fabxY8fTF9YUi37BjKPmx3kqwdH5n0rRtbhqv
         tEKjct5vRxAlO4LunX6eu4/y3W9CbWcF3IW6bt1k5rUbhCl9YQ2f0Wr/GyJ19BtlaT
         rApMZquzP6WJ3qWygWpJqf5unNurs/vonu4/x6U9R4vEbBUKReUSTRaVv+VDuKOzPp
         LMj+4xc5jO+a1mvgBmwQIAbvMM0O0svGdYxerPIdeIEKURjVgDpHk1fLfMTam7jf/s
         +7d2QqoiY6Ci4ouT3HXxxTIJ/AETxWsVsRY4ssorOSroeTCNpX9MSMAQDgdEyQ5Zj2
         Oiju85ZQLkTwA==
Date:   Thu, 10 Feb 2022 19:18:39 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Bard Liao <yung-chuan.liao@linux.intel.com>
Cc:     alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        gregkh@linuxfoundation.org, srinivas.kandagatla@linaro.org,
        pierre-louis.bossart@linux.intel.com, sanyog.r.kale@intel.com,
        bard.liao@intel.com, libin.yang@intel.com
Subject: Re: [PATCH] soundwire: intel: fix wrong register name in
 intel_shim_wake
Message-ID: <YgUXtwfOPy0tD33z@matsya>
References: <20220126011451.27853-1-yung-chuan.liao@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220126011451.27853-1-yung-chuan.liao@linux.intel.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 26-01-22, 09:14, Bard Liao wrote:
> From: Libin Yang <libin.yang@intel.com>
> 
> When clearing the sdw wakests status, we should use SDW_SHIM_WAKESTS.

Applied, thanks

-- 
~Vinod
