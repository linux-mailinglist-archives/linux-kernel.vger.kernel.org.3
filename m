Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 63DCF4D6D04
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Mar 2022 07:31:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230388AbiCLGcV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 12 Mar 2022 01:32:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230137AbiCLGcT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 Mar 2022 01:32:19 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F3602255BB
        for <linux-kernel@vger.kernel.org>; Fri, 11 Mar 2022 22:31:14 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8275B60B92
        for <linux-kernel@vger.kernel.org>; Sat, 12 Mar 2022 06:31:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 31C63C340EB;
        Sat, 12 Mar 2022 06:31:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1647066672;
        bh=ZY0df/1CsYQRoxMLvDhtdZbmCR4aoRBB8dUm8GjX82k=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=DSYQxNK5yvzKe+iKksC2/ae7eQRDpUsw+QSgGtDjll58FP221nhj3RW+e8RWHxbW9
         G8srMGvalxwdWhRyjEhhw1gv8ZEFEgTwhaMofhe0qH6YNRKNNBu8PHZXqN2VPqswb+
         khA1k6Y/+5PXbgC6baLT8DX7G9tBThUWOs/KH9S8=
Date:   Sat, 12 Mar 2022 07:31:06 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Yusuf Khan <yusisamerican@gmail.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Jason Wang <jasowang@redhat.com>,
        Michael Kelley <mikelley@microsoft.com>,
        "Michael S. Tsirkin" <mst@redhat.com>, javier@javigon.com,
        Arnd Bergmann <arnd@arndb.de>, Will Deacon <will@kernel.org>,
        Jens Axboe <axboe@kernel.dk>
Subject: Re: [PATCH v7] drivers: ddcci: upstream DDCCI driver
Message-ID: <Yiw+Kil2BmLPQf7H@kroah.com>
References: <20220311074413.14644-1-yusisamerican@gmail.com>
 <YisE6jjbzJyytqB8@kroah.com>
 <CAJoG2+9w=GP9=+d=pLuNRoR7USH1V7f=DSPURxnxotYs_CwW+w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJoG2+9w=GP9=+d=pLuNRoR7USH1V7f=DSPURxnxotYs_CwW+w@mail.gmail.com>
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 11, 2022 at 09:09:45PM -0800, Yusuf Khan wrote:
> > How can this ever fail?
> If ddcci_verify_device() fails
> > Not needed, just do not have it.
> I'm assuming you mean the locks?
> > This should not be needed in sysfs.  What tool wants this?
> Its for the idSerial and modalias part of the userland interface.
> > Why "_void"?
> suppressing "initialization of ‘void (*)(struct device *)’ from
> incompatible pointer type ‘int (*)(struct device *)’"

I have no context at all for this email response, sorry.

Take a look at how email discussions work on the mailing list, with
proper amounts of quoting and the like.

Remember, some of us get at least a thousand emails a day to deal with,
and do not remember what we said in the past, nor what it was about, at
all.  By stripping off all context, that ensures we will never remember
it either :(

greg k-h
