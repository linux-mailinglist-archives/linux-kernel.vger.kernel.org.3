Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 81AC9571532
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Jul 2022 10:58:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231432AbiGLI6Q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Jul 2022 04:58:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229559AbiGLI6P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jul 2022 04:58:15 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE28AA9E4F
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jul 2022 01:58:14 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 74BC261703
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jul 2022 08:58:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 88245C341CB;
        Tue, 12 Jul 2022 08:58:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1657616293;
        bh=J8/AN9zql59oQV4mFnIcGySCPyWa1GSrVzwMfuTFGZE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=R78s45Wnkg1efEqiQzFDVNvdyz1YofBHbu19Vkcv+JqxScD3ggVgdYSlzr02Zs5xv
         26a4z2wCuYr8KRQVOOpgj8xMJpclmNDqrMESLu6afVf6t0u7W7jg63CyO38TqzMx0w
         yFePovJbnMifcxwq1TU12ysx5KzHg6eqY1wVOD0c=
Date:   Tue, 12 Jul 2022 10:56:43 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Oded Gabbay <ogabbay@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: Re: [git pull] habanalabs pull request for kernel 5.20
Message-ID: <Ys03S59M8sTE61pB@kroah.com>
References: <20220712075345.GA3318116@ogabbay-vm-u20>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220712075345.GA3318116@ogabbay-vm-u20>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 12, 2022 at 10:53:45AM +0300, Oded Gabbay wrote:
> Hi Greg,
> 
> This is habanalabs pull request for the merge window of kernel 5.20.
> 
> This is a relatively large pull request as it contains the code to support our
> new Gaudi2 AI accelerator.
> 
> Outside of that there is nothing else too exciting. Except for a few
> enhancements to features added in 5.19, most of the commits are small bug
> fixes or cleanups.
> 
> Full details are in the tag.
> 
> Thanks,
> Oded
> 
> The following changes since commit 7e724422a7e9dfc8229ba90ee95aaafb902a788b:
> 
>   Merge tag 'coresight-next-v5.20' of git://git.kernel.org/pub/scm/linux/kernel/git/coresight/linux into char-misc-next (2022-07-11 20:54:28 +0200)
> 
> are available in the Git repository at:
> 
>   https://git.kernel.org/pub/scm/linux/kernel/git/ogabbay/linux.git tags/misc-habanalabs-next-2022-07-12

Pulled and pushed out, thanks.

greg k-h
