Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AFF154D80CB
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Mar 2022 12:34:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239024AbiCNLfB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Mar 2022 07:35:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238997AbiCNLe6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Mar 2022 07:34:58 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BDA393EB8E
        for <linux-kernel@vger.kernel.org>; Mon, 14 Mar 2022 04:33:48 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3F7996112F
        for <linux-kernel@vger.kernel.org>; Mon, 14 Mar 2022 11:33:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6C0F6C340EC;
        Mon, 14 Mar 2022 11:33:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1647257627;
        bh=WnA80cH9bCfifQAruhmVw0SF3GOH8r0waE1k9+hp16M=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=NtN9qLvGrdCVps1JMlMK+p3Zl6l/JM8B2TKNo/eHGwlfB+zl2jVvb9xhyjedeLN7K
         ZOwkP8PInd4Q1R6cYhpxvJmagFxptOMCqBWTjDuwzwu6w1FxGzQ41rW7PPGOy8cTGU
         /UUqeoFQ/ONH3p/P7ESxslIQpDebHm/19u/RmBaE=
Date:   Mon, 14 Mar 2022 12:33:42 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     shaikh kamaluddin <shaikhkamal2012@gmail.com>
Cc:     Pavel Skripkin <paskripkin@gmail.com>,
        Arve =?iso-8859-1?B?SGr4bm5lduVn?= <arve@android.com>,
        Todd Kjos <tkjos@android.com>,
        Martijn Coenen <maco@android.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Christian Brauner <brauner@kernel.org>,
        Hridya Valsaraju <hridya@google.com>,
        Suren Baghdasaryan <surenb@google.com>,
        linux-kernel@vger.kernel.org, linux-staging@lists.linux.dev
Subject: Re: [PATCH] staging: android: ashmem: Declared file operation with
 const keyword Warning found by checkpatch.pl script.
Message-ID: <Yi8oFtMxfTkPF8/h@kroah.com>
References: <20220312204128.3942-1-shaikhkamal2012@gmail.com>
 <303ed0c8-8e2c-51a4-a4da-be973a25cdec@gmail.com>
 <bf27518d-4990-8b0e-c6ea-26a658ce2e54@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <bf27518d-4990-8b0e-c6ea-26a658ce2e54@gmail.com>
X-Spam-Status: No, score=-8.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 14, 2022 at 04:55:55PM +0530, shaikh kamaluddin wrote:
> On 3/13/2022 3:13 AM, Pavel Skripkin wrote:
> > Hi Shaikh,
> > 
> > On 3/12/22 23:41, shaikh kamal wrote:
> > > Signed-off-by: shaikh kamal <shaikhkamal2012@gmail.com>
> > > ---
> > >   drivers/staging/android/ashmem.c | 2 +-
> > >   1 file changed, 1 insertion(+), 1 deletion(-)
> > > 
> > > diff --git a/drivers/staging/android/ashmem.c
> > > b/drivers/staging/android/ashmem.c
> > > index ddbde3f8430e..4c6b420fbf4d 100644
> > > --- a/drivers/staging/android/ashmem.c
> > > +++ b/drivers/staging/android/ashmem.c
> > > @@ -377,7 +377,7 @@ ashmem_vmfile_get_unmapped_area(struct file
> > > *file, unsigned long addr,
> > >   static int ashmem_mmap(struct file *file, struct vm_area_struct *vma)
> > >   {
> > > -    static struct file_operations vmfile_fops;
> > > +    static const struct file_operations vmfile_fops;
> > >       struct ashmem_area *asma = file->private_data;
> > >       int ret = 0;
> > 
> > Are you sure this patch compiles? vmfile_fops is overrided few lines below
> > 
> > odd checkpatch.pl warning...
> > 
> > 
> > 
> > 
> > With regards,
> > Pavel Skripkin
> 
> Thank you,yes vmfile_fops is overrided in below code.
> Building the kernel - make -j4,
> drivers/staging/android/ashmem.c: In function ‘ashmem_mmap’:
> drivers/staging/android/ashmem.c:431:16: error: assignment of read-only
> variable ‘vmfile_fops’
>     vmfile_fops = *vmfile->f_op;
>                 ^
> drivers/staging/android/ashmem.c:432:21: error: assignment of member ‘mmap’
> in read-only object
>     vmfile_fops.mmap = ashmem_vmfile_mmap;
>                      ^
> drivers/staging/android/ashmem.c:433:34: error: assignment of member
> ‘get_unmapped_area’ in read-only object
>     vmfile_fops.get_unmapped_area =
>                                   ^
> scripts/Makefile.build:288: recipe for target
> 'drivers/staging/android/ashmem.o' failed
> make[3]: *** [drivers/staging/android/ashmem.o] Error 1
> scripts/Makefile.build:550: recipe for target 'drivers/staging/android'
> failed
> make[2]: *** [drivers/staging/android] Error 2
> scripts/Makefile.build:550: recipe for target 'drivers/staging' failed
> make[1]: *** [drivers/staging] Error 2
> Makefile:1831: recipe for target 'drivers' failed

As always, it is expected that when you submit a change to the kernel,
at the very least you have test-built it to ensure that it does not
break the build.  Please remember to do this next time.

thanks,

greg k-h
