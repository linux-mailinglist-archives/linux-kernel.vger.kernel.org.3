Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2F729509885
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Apr 2022 09:06:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1385347AbiDUGyj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Apr 2022 02:54:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1386019AbiDUGxv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Apr 2022 02:53:51 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D4991836B;
        Wed, 20 Apr 2022 23:49:43 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id B948FB821B0;
        Thu, 21 Apr 2022 06:49:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E4907C385A5;
        Thu, 21 Apr 2022 06:49:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1650523780;
        bh=JuzxgADo0HR49i0JgmCb45QoqigVSVD5kw+mijrOit4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=mWm5xHWzgN0YrSZGeKqDtc2fgkKQxwu4bRiXF3nT9Q6ZySTiiARojnCzzCKtjc9Xm
         pLbBtKNoRnReGhjCM1sJ0fP9xlR6AtlVnCRDfgqNYdZlezC4rc2f6crqOl5vpoa0pO
         13B9qlZSAJkQypB6b884G63QVcEYwH9Qyebi5uQw=
Date:   Thu, 21 Apr 2022 08:49:37 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Tony Luck <tony.luck@intel.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: Re: linux-next: build warning after merge of the driver-core.current
 tree
Message-ID: <YmD+geU9CmjoVnN9@kroah.com>
References: <20220421152645.3a849198@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220421152645.3a849198@canb.auug.org.au>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 21, 2022 at 03:26:45PM +1000, Stephen Rothwell wrote:
> Hi all,
> 
> After merging the driver-core.current tree, today's linux-next build
> (x86_64 allnoconfig) produced this warning:
> 
> drivers/base/topology.c: In function 'topology_is_visible':
> drivers/base/topology.c:158:24: warning: unused variable 'dev' [-Wunused-variable]
>   158 |         struct device *dev = kobj_to_dev(kobj);
>       |                        ^~~
> 
> Introduced by commit
> 
>   aa63a74d4535 ("topology/sysfs: Hide PPIN on systems that do not support it.")

Tony, can you please send a fixup patch for this, or should I just
revert this commit for now?

thanks,

greg k-h
