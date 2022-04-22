Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1CF0150B91B
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Apr 2022 15:51:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1448204AbiDVNxc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Apr 2022 09:53:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1385747AbiDVNxb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Apr 2022 09:53:31 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D01B44741;
        Fri, 22 Apr 2022 06:50:37 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 268FFB82D83;
        Fri, 22 Apr 2022 13:50:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 63795C385A8;
        Fri, 22 Apr 2022 13:50:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1650635434;
        bh=kOYsQIP60r5ccaWLbr0vP4t0dL0lxnzSBmIr3twcl1M=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Z2dzjIw1xa6gzs9Nf0/C04j1Ne6EnVg89VWmoA1LOLw4TB9rY6tj1mVpzyFGXFSYi
         5ptZWHsysMabcADUPEcqv4qKQPo134I891CakNCg8Joi6oz21xzKYcwQvsB/3iPeFB
         uN8lwl7N/u2XQOVVMbvKENyGOSIiRLGWA04rwEzU=
Date:   Fri, 22 Apr 2022 15:50:26 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Georgi Djakov <djakov@kernel.org>
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [GIT PULL] interconnect fixes for 5.18-rc
Message-ID: <YmKyoiBRY504UXk7@kroah.com>
References: <20220422073221.30745-1-djakov@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220422073221.30745-1-djakov@kernel.org>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 22, 2022 at 10:32:21AM +0300, Georgi Djakov wrote:
> Hello Greg,
> 
> This pull request contains interconnect driver fixes for an issue that
> has been reported. Please pull into char-misc-linus when possible. The
> patches have been in linux-next for a week.
> 
> Thanks,
> Georgi
> 
> The following changes since commit 3123109284176b1532874591f7c81f3837bbdc17:
> 
>   Linux 5.18-rc1 (2022-04-03 14:08:21 -0700)
> 
> are available in the Git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/djakov/icc.git tags/icc-5.18-rc4

Pulled and pushed out,t hanks.

greg k-h
