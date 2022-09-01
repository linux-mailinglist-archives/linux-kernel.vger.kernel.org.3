Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CA3B15A99F1
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Sep 2022 16:19:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234090AbiIAOSy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Sep 2022 10:18:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234592AbiIAOSt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Sep 2022 10:18:49 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4A5F1582A
        for <linux-kernel@vger.kernel.org>; Thu,  1 Sep 2022 07:18:48 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 408F5CE272F
        for <linux-kernel@vger.kernel.org>; Thu,  1 Sep 2022 14:18:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0787CC433D6;
        Thu,  1 Sep 2022 14:18:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1662041925;
        bh=hs2646H51sI+x6YEgtT2/4R2T6F8OKF1rNarvVd9o0Y=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=pXOwHS7vWVfkgdb+CBypjamX/3JIE+bvFUch5gN25y4eiu/IJ7qsZ67oOjHtBQSAQ
         P7iDfoRyXTTEl8Gx0b2mprC9z3Wvc3/TQzWe9hXLNAbYCtuBfBzfOscEOATJ3X+82g
         kFejBzZKDIAaIqg07zqXZaREVEOOO57Czl8gl1NA=
Date:   Thu, 1 Sep 2022 16:18:42 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Carlos Llamas <cmllamas@google.com>
Cc:     kernel-team@android.com,
        Arve =?iso-8859-1?B?SGr4bm5lduVn?= <arve@android.com>,
        Todd Kjos <tkjos@android.com>,
        Martijn Coenen <maco@android.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Christian Brauner <brauner@kernel.org>,
        Suren Baghdasaryan <surenb@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Liam Howlett <liam.howlett@oracle.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/7] fix null-ptr-deref in binder_alloc and others
Message-ID: <YxC/QiivgZHc9+DW@kroah.com>
References: <20220829201254.1814484-1-cmllamas@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220829201254.1814484-1-cmllamas@google.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 29, 2022 at 08:12:47PM +0000, Carlos Llamas wrote:
> This patch series fixes primarily a null dereference of alloc->vma_vm_mm
> reported by syzbot which unfortunately is quite easy to reproduce. Also,
> included here are several other patches for more trivial things I found
> along the way.

Because you had 1 bugfix, and 6 "normal" patches, I had to split this up
across branches.  Which caused some of the normal patches to fail to
apply :(

Please wait until 6.0-rc5 or so is out with the fix patch merged and
then rebase the remaining against my char-misc-next branch and resend
them.

thanks,

greg k-h
