Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BD8164D53BE
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Mar 2022 22:43:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241714AbiCJVnB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Mar 2022 16:43:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244741AbiCJVmy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Mar 2022 16:42:54 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F8B016FDE9
        for <linux-kernel@vger.kernel.org>; Thu, 10 Mar 2022 13:41:53 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 12864B825F2
        for <linux-kernel@vger.kernel.org>; Thu, 10 Mar 2022 21:41:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7ACE1C340E8;
        Thu, 10 Mar 2022 21:41:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1646948510;
        bh=IHIGH8VQeIMqkTxrdZMNBNPGNyfnXTljpt3MpP9xA5w=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=eUQjxW48yvusyqGAU8fHLbgiAfv6qGsUdPtgJr5bhzAIyn78qAjpEhaOYIHbYKRko
         O1eHG0dwBpdeZ3oDfHM6Yh5wa3nAAU/DnkET0H/eSu+W358jCcEoC6HdBEQ3v6hsZt
         K3s11e/4UIoYzR3SVIE4Sxrj3wwhz42fLhnLdE4A=
Date:   Thu, 10 Mar 2022 22:40:28 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Oded Gabbay <ogabbay@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: Re: [git pull] habanalabs pull request for kernel 5.18
Message-ID: <YipwTAfBdZpuLYQA@kroah.com>
References: <20220228135111.GA1174849@ogabbay-vm-u20.habana-labs.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220228135111.GA1174849@ogabbay-vm-u20.habana-labs.com>
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 28, 2022 at 03:51:11PM +0200, Oded Gabbay wrote:
> Hi Greg,
> 
> This is habanalabs pull request for the merge window of kernel 5.18.
> Although it adds small number of features, this pull request mainly
> fixes multiple bugs in the code and also does some re-factoring to
> better organize the code.
> 
> Full details are in the tag.
> 
> Thanks,
> Oded
> 
> The following changes since commit 085686fb8491a7cbf6a7260d5b9d4169a041c340:
> 
>   Merge 5.17-rc6 into char-misc-next (2022-02-28 07:30:32 +0100)
> 
> are available in the Git repository at:
> 
>   https://git.kernel.org/pub/scm/linux/kernel/git/ogabbay/linux.git tags/misc-habanalabs-next-2022-02-28
> 
> for you to fetch changes up to 655221c56739058ae73a7aabd90847a024dabff6:
> 
>   habanalabs: remove deprecated firmware states (2022-02-28 14:34:50 +0200)

Pulled and pushed out, thanks.

greg k-h
