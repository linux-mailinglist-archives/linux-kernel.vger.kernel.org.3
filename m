Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A81E959EB3A
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Aug 2022 20:40:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230186AbiHWSjy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Aug 2022 14:39:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231722AbiHWSjZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Aug 2022 14:39:25 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF93F114A61
        for <linux-kernel@vger.kernel.org>; Tue, 23 Aug 2022 10:02:53 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E48D761464
        for <linux-kernel@vger.kernel.org>; Tue, 23 Aug 2022 17:02:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B513AC433D6;
        Tue, 23 Aug 2022 17:02:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1661274155;
        bh=Ibs+xRoiWZvLOCWaBxHFQWXGaJte9vq3bvRSu1GDUiM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=F0YMd2tZxtNH50fa66VGMeNTwf7iBCdhboNsBN+ki8oajLcDN2j5BybfnwsTZAUno
         U/A00OxbKXCPJtxhKpuLFZUCpBwxgZxyfnNExNkYvb8pN6TZttmqnv3MzHwiB2rqnN
         J+MYri8PCvS5f96QUtVEqNiFNRbI1vsqEY7xQBoimQ3sRytNtEaMuqujAorPA5RdzE
         GKzIUnYnv5nQmWAlt3QjzfbIs1tKW1hpLd8WdhmEbWRx+SZ6VkeAcNq4qDJk3779qC
         RsPe3gq9/DtjLd6qiETysJYSp++UToRo9zuufO1W0Z59e2lZeOwc5rsPXXTryhHQB6
         F1rjDAC+75FmA==
Date:   Tue, 23 Aug 2022 22:32:31 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Bard Liao <yung-chuan.liao@linux.intel.com>
Cc:     alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        gregkh@linuxfoundation.org, pierre-louis.bossart@linux.intel.com,
        bard.liao@intel.com
Subject: Re: [PATCH 0/2] soundwire: remove use of __func__ in dev_dbg
Message-ID: <YwUIJ4fuPIB4vJLZ@matsya>
References: <20220823050158.2671245-1-yung-chuan.liao@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220823050158.2671245-1-yung-chuan.liao@linux.intel.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 23-08-22, 13:01, Bard Liao wrote:
> The module and function information can be added with
> 'modprobe foo dyndbg=+pmf'

Applied, thanks

-- 
~Vinod
