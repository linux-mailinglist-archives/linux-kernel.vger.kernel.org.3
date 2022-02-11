Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5CE3A4B293C
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Feb 2022 16:42:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344297AbiBKPmX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Feb 2022 10:42:23 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:54036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343923AbiBKPmV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Feb 2022 10:42:21 -0500
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E49ECF0;
        Fri, 11 Feb 2022 07:42:20 -0800 (PST)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id A8AC4212B8;
        Fri, 11 Feb 2022 15:42:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1644594138;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=MOvt3nP6o555NwCZ0+/YXZ/7DPCmnppoG+QFn1Mcl/s=;
        b=dIg+c6GG044XfCDI0EaMRO0Ucap381BvO//H1tMkb5BGDgYXgUGjjuCz7xQoLpWIroU4wK
        Iu0Pg2sDRD86xIGNMbA5F7FIWWkjphDFjg5hHXpM098itV1hBqZvxyFp2Ij+1Koxim+cxl
        AzLDFkuHNzPf2iMi6UBfqxJnRETwJbI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1644594138;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=MOvt3nP6o555NwCZ0+/YXZ/7DPCmnppoG+QFn1Mcl/s=;
        b=IjHGNhWEeiJa7RNTR9QWRv91zymNNRRHT/v+L5B7DQaAd2BHkttK31VUuIiouSWBiKrvqt
        R0siUtNFvOo99tDg==
Received: from ds.suse.cz (ds.suse.cz [10.100.12.205])
        by relay2.suse.de (Postfix) with ESMTP id 9CBC5A3B8A;
        Fri, 11 Feb 2022 15:42:18 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 59C37DA823; Fri, 11 Feb 2022 16:38:36 +0100 (CET)
Date:   Fri, 11 Feb 2022 16:38:36 +0100
From:   David Sterba <dsterba@suse.cz>
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Kees Cook <keescook@chromium.org>, David Sterba <dsterba@suse.com>,
        Omar Sandoval <osandov@fb.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: Re: linux-next: build failure after merge of the btrfs tree (Was:
 Re: linux-next: build failure after merge of the kspp tree)
Message-ID: <20220211153835.GY12643@suse.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Stephen Rothwell <sfr@canb.auug.org.au>,
        Kees Cook <keescook@chromium.org>, David Sterba <dsterba@suse.com>,
        Omar Sandoval <osandov@fb.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
References: <20220125115757.20bc45e8@canb.auug.org.au>
 <20220125140730.GO14046@suse.cz>
 <20220211104238.5da77acd@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220211104238.5da77acd@canb.auug.org.au>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 11, 2022 at 10:42:38AM +1100, Stephen Rothwell wrote:
> > > --- a/fs/btrfs/ioctl.c
> > > +++ b/fs/btrfs/ioctl.c
> > > @@ -5079,9 +5079,14 @@ static int btrfs_ioctl_encoded_write(struct file *file, void __user *argp,
> > >  		}
> > >  		args.iov = compat_ptr(args32.iov);
> > >  		args.iovcnt = args32.iovcnt;
> > > -		memcpy(&args.offset, &args32.offset,
> > > -		       sizeof(args) -
> > > -		       offsetof(struct btrfs_ioctl_encoded_io_args, offset));
> > > +		args.offset = args32.offset;
> > > +		args.flags = args32.flags;
> > > +		args.len = args32.len;
> > > +		args.unencoded_len = args32.unencoded_len;
> > > +		args.unencoded_offset = args32.unencoded_offset;
> > > +		args.compression = args32.compression;
> > > +		args.encryption = args32.encryption;
> > > +		memcpy(args.reserved, args32.reserved, sizeof(args.reserved));
> > >  #else
> > >  		return -ENOTTY;
> > >  #endif  
> > 
> > Thanks, the patchset is still in progress so I'll apply this a fixup
> > until the patch gets updated.
> 
> This has come back today ... presumably the hack was removed but the
> original patch was not fixed.

I've updated the patchset and thought the fixup has been applied but no.
I'll fold it to the patch so it doesn't get lost again.
