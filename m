Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 81E9E4D5B8A
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Mar 2022 07:20:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244097AbiCKGVZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Mar 2022 01:21:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233190AbiCKGVV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Mar 2022 01:21:21 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 235A115C9F2
        for <linux-kernel@vger.kernel.org>; Thu, 10 Mar 2022 22:20:19 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7A231619EE
        for <linux-kernel@vger.kernel.org>; Fri, 11 Mar 2022 06:20:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 53EEDC340E9;
        Fri, 11 Mar 2022 06:20:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1646979617;
        bh=uDmUx36eHTIw4L+boF+y8DerwpznrlE3aJ0t7bjUwu4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=HEfNKw/1jmo/+ANgkNejAKx5w//lDF+X9dI7Rxbp/+25LgoSeabUfarHnUqisP40Y
         GdN6l/zKVH7D91l3UnUlOMqUcLLZ/cxo0/PM+MEN6NnLr6MIL+5PdxC8mlnwdGsv3E
         u9ShmVtfeq28YhPtCHKup3R5IEQjsqZFTxd/bm/w=
Date:   Fri, 11 Mar 2022 07:20:14 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Chanwoo Choi <cw00.choi@samsung.com>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Chanwoo Choi (chanwoo@kernel.org)" <chanwoo@kernel.org>,
        =?utf-8?B?7ZWo66qF7KO8?= <myungjoo.ham@samsung.com>
Subject: Re: [GIT PULL] extcon next for v5.18
Message-ID: <YirqHsUPTJZGFCEx@kroah.com>
References: <CGME20220308022359epcas1p2d145af3c2f462bb6e69da46663c38c95@epcas1p2.samsung.com>
 <49839780-1b58-5a30-0e56-e02f7756a216@samsung.com>
 <Yipx/1t0We5uGhSQ@kroah.com>
 <59f03dd1-6731-87f2-7d4b-51e5058fb9da@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <59f03dd1-6731-87f2-7d4b-51e5058fb9da@samsung.com>
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 11, 2022 at 11:28:52AM +0900, Chanwoo Choi wrote:
> On 3/11/22 6:47 AM, Greg KH wrote:
> > On Tue, Mar 08, 2022 at 11:48:53AM +0900, Chanwoo Choi wrote:
> >> Dear Greg,
> >>
> >> This is extcon-next pull request for v5.18. I add detailed description of
> >> this pull request on below. Please pull extcon with following updates.
> >>
> >> Best Regards,
> >> Chanwoo Choi
> >>
> >> The following changes since commit 7e57714cd0ad2d5bb90e50b5096a0e671dec1ef3:
> >>
> >>   Linux 5.17-rc6 (2022-02-27 14:36:33 -0800)
> >>
> >> are available in the Git repository at:
> >>
> >>   git://git.kernel.org/pub/scm/linux/kernel/git/chanwoo/extcon.git tags/extcon-next-for-5.18
> > 
> > You signed this tag with a gpg key that is expired, so my check failed
> > when pulling :(
> > 
> > Can you please fix your key and get the update in the kernel.org gpg
> > database?
> 
> I'm sorry to bother you. After fixing key issue, I'll resend pull request.

In the meantime, you can send me changes by email.

thanks,

greg k-h
