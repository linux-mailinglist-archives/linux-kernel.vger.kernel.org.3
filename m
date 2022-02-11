Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DA18B4B1EBB
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Feb 2022 07:49:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346075AbiBKGsg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Feb 2022 01:48:36 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:41116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239269AbiBKGsf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Feb 2022 01:48:35 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9BAF10B4
        for <linux-kernel@vger.kernel.org>; Thu, 10 Feb 2022 22:48:34 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 97430B81EBC
        for <linux-kernel@vger.kernel.org>; Fri, 11 Feb 2022 06:48:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 78AB3C340E9;
        Fri, 11 Feb 2022 06:48:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1644562112;
        bh=gmBDke/Eqe0vt9nmaqpu+uYvi5DAKYYCl85zDp/sin0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Xoaj3I/S1Qn84qINfIRlgGNGWzeWc7INRi9oy3CbwGvmxPssVMF8r+SycTI2w4CE/
         xhqSvqYM0ENUrj5kokkm3/ShV2dNXeZiyBmJKhtpEDA8Vu5+rTOdC1SFIX6+93+dpw
         6cmcHMCY8Y9lh5IvoCFUSeoj5ui4rd7XSbtWixax+khMGXbC7Uua0P4MqOx2eW/oTu
         Dmq84R4A5wrPzzLy80MEMRQrK9j/LeWgKBgoShARtksz9AzEZxhV4vL1Vt/CgP2x+N
         Ou//xV+Ei+miRQPyzVpImm/nQ9cA7/VcmLlVO7SXZ8v9G82/T0IyMAnostNp2Um97q
         657rn2HByJeaw==
Date:   Fri, 11 Feb 2022 12:18:27 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Bard Liao <yung-chuan.liao@linux.intel.com>
Cc:     alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        gregkh@linuxfoundation.org, srinivas.kandagatla@linaro.org,
        pierre-louis.bossart@linux.intel.com, sanyog.r.kale@intel.com,
        bard.liao@intel.com
Subject: Re: [PATCH 00/19] soundwire: stream: cleanup of 'stream' support
Message-ID: <YgYGu1S/RTuC5rhm@matsya>
References: <20220126011715.28204-1-yung-chuan.liao@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220126011715.28204-1-yung-chuan.liao@linux.intel.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 26-01-22, 09:16, Bard Liao wrote:
> This series revisits the SoundWire 'sdw_stream' support to split allocation
> and configuration steps. This is necessary if for example the routines are
> called multiple times from the hw_params stage. This also helps with better
> error handling.

Patch 13 added a trailing empty line to file, I have fixed that up while
applying...

-- 
~Vinod
