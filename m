Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 64E305263BB
	for <lists+linux-kernel@lfdr.de>; Fri, 13 May 2022 16:17:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351152AbiEMORH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 May 2022 10:17:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353946AbiEMORA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 May 2022 10:17:00 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0546512719F;
        Fri, 13 May 2022 07:16:54 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9365862100;
        Fri, 13 May 2022 14:16:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8B0E6C34115;
        Fri, 13 May 2022 14:16:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1652451413;
        bh=uUlfBuKJ/pXteOQsAi9561/Hcft4in4NOg5BYSoXlbE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=VAVglbrxJ1vyTbhM5XYLF77hQocf/KZ2Q3kfCTlMeKdFRjbLymhEboo74FU0r4A5b
         UKNFd0IjLZgQdlrfJrXibW8QvTrOVcofTxp13H5k5EwFw2n2iZXLkNtlsjwFt8Hh0c
         XUjiKgiMVo2mYPUMFWnhN0/L6cGS0nK5j3HTSM2c=
Date:   Fri, 13 May 2022 16:16:50 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Georgi Djakov <djakov@kernel.org>
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [GIT PULL] interconnect fix for 5.18-rc
Message-ID: <Yn5oUv7Wh96HDEzZ@kroah.com>
References: <20220506085923.23816-1-djakov@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220506085923.23816-1-djakov@kernel.org>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 06, 2022 at 11:59:23AM +0300, Georgi Djakov wrote:
> Hello Greg,
> 
> This pull request contains one more fix for the current cycle. The
> details are in the signed tag. It has been in linux-next during the
> last few days. Please pull into char-misc-linus when possible.
> 
> Thanks,
> Georgi
> 
> The following changes since commit 2fb251c265608636fc961b7d38e1a03937e57371:
> 
>   interconnect: qcom: sdx55: Drop IP0 interconnects (2022-04-14 09:47:16 +0300)
> 
> are available in the Git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/djakov/icc.git tags/icc-5.18-rc6

Sorry for the delay, now pulled and pushed out.

greg k-h
