Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EB5405AA879
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Sep 2022 09:03:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235332AbiIBHDM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Sep 2022 03:03:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230295AbiIBHDJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Sep 2022 03:03:09 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42ECEBC813
        for <linux-kernel@vger.kernel.org>; Fri,  2 Sep 2022 00:03:09 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id D8149B829EA
        for <linux-kernel@vger.kernel.org>; Fri,  2 Sep 2022 07:03:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 34CF7C433C1;
        Fri,  2 Sep 2022 07:03:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1662102186;
        bh=YyWJyhjcgghGxYhOkC8ahoD6cFG8bpuWcSdNANs2bKk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=YEpz/kQazWWhaW7bT/aZVfIQpyXKf50Jb5HpkShaXJEdEdU9OoKHrTDggox8xY15w
         j5x47/Qzcx/eE6t4+suByReo4e47VgywmUQk9YCsiVyRYjXcb2MQCedd6l4sCQYWyk
         LelZHWF9iuTqTXncV8zB3yPt+lBQdAGSpZiZZkfM=
Date:   Fri, 2 Sep 2022 09:03:03 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Vinod Koul <vkoul@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>
Subject: Re: [GIT PULL]: Soundwire fixes for v6.0
Message-ID: <YxGqp4XCEr/+lnFC@kroah.com>
References: <YxGeD1ZoLB/IOB4x@matsya>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YxGeD1ZoLB/IOB4x@matsya>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 02, 2022 at 11:39:19AM +0530, Vinod Koul wrote:
> Hello Greg,
> 
> Please pull to receive two fixes for qcom driver. Both of these are in
> linux-next.
> 
> The following changes since commit 568035b01cfb107af8d2e4bd2fb9aea22cf5b868:
> 
>   Linux 6.0-rc1 (2022-08-14 15:50:18 -0700)
> 
> are available in the Git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/vkoul/soundwire.git tags/soundwire-6.0-fixes

Pulled and pushed out, thanks.

greg k-h
