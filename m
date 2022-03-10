Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 11D9A4D53E1
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Mar 2022 22:49:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240992AbiCJVsx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Mar 2022 16:48:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235276AbiCJVsv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Mar 2022 16:48:51 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 181FE1D30E
        for <linux-kernel@vger.kernel.org>; Thu, 10 Mar 2022 13:47:48 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id C5FCAB8279C
        for <linux-kernel@vger.kernel.org>; Thu, 10 Mar 2022 21:47:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3E5E5C340E8;
        Thu, 10 Mar 2022 21:47:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1646948865;
        bh=2X5UsQqmfuG8KSGHS8gSJqOhoKthVVktIHlz9/juScE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=WvW+MHriIfEX40ZH3UfgFBwbzLeTBxC+l2ChRwoG0raUSmQ5bArLF+ZKZijYV120L
         XN/FLz8HBkXDaAvfyApW4ayjLAvRbinZEAEtyKnT/UXMbIMsPl+Y907amoSsisi9j6
         ZH3yO+/df5Dl+7jpyovA4Ek/6VZdyOjzaIqDQ6D0=
Date:   Thu, 10 Mar 2022 22:47:43 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Chanwoo Choi <cw00.choi@samsung.com>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Chanwoo Choi (chanwoo@kernel.org)" <chanwoo@kernel.org>,
        =?utf-8?B?7ZWo66qF7KO8?= <myungjoo.ham@samsung.com>
Subject: Re: [GIT PULL] extcon next for v5.18
Message-ID: <Yipx/1t0We5uGhSQ@kroah.com>
References: <CGME20220308022359epcas1p2d145af3c2f462bb6e69da46663c38c95@epcas1p2.samsung.com>
 <49839780-1b58-5a30-0e56-e02f7756a216@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <49839780-1b58-5a30-0e56-e02f7756a216@samsung.com>
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 08, 2022 at 11:48:53AM +0900, Chanwoo Choi wrote:
> Dear Greg,
> 
> This is extcon-next pull request for v5.18. I add detailed description of
> this pull request on below. Please pull extcon with following updates.
> 
> Best Regards,
> Chanwoo Choi
> 
> The following changes since commit 7e57714cd0ad2d5bb90e50b5096a0e671dec1ef3:
> 
>   Linux 5.17-rc6 (2022-02-27 14:36:33 -0800)
> 
> are available in the Git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/chanwoo/extcon.git tags/extcon-next-for-5.18

You signed this tag with a gpg key that is expired, so my check failed
when pulling :(

Can you please fix your key and get the update in the kernel.org gpg
database?

thanks,

greg k-h
