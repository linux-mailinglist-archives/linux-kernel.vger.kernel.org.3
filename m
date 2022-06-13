Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E3BC054813C
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Jun 2022 10:02:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238870AbiFMIC0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Jun 2022 04:02:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239307AbiFMICH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jun 2022 04:02:07 -0400
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DCC7615A24;
        Mon, 13 Jun 2022 01:02:06 -0700 (PDT)
Received: by mail-pj1-x1031.google.com with SMTP id k12-20020a17090a404c00b001eaabc1fe5dso2222014pjg.1;
        Mon, 13 Jun 2022 01:02:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=p1C8yN+vY8r/BHzAHLXxk073G3pWCMQ/vUB+HuPD1g4=;
        b=aSepHBzqKyR8Qo5Ni0Ko6/WPnq+LpRSeEYfmQngvGmWanOcbzx2aiaaZQa8eQadyJ9
         dDlrjox3fpUosoUz8TVBuRrVDb+97Wl2wvvmZQ5PjWF+MckNqtoF0Yqjfp1JiEGapoH9
         wz1pf8EuHtCVmFBbIXiY9LmPpzE9OQpoIIgx91IYpnQxpyTRTtfb+1GAi3DxhIKrbkKN
         N1NK74nkvvYnOtImC2zpVWDa2FwLrek2i8y6h66bEXMWyg0IOiDQAdHJY5QSIbr2K94S
         gdujIYqPT1xp+21GLpVsPtRLshj81Who+zb4KBxHDhX6J7NLhycAWX+JQaOSSNbDRwf4
         bSxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=p1C8yN+vY8r/BHzAHLXxk073G3pWCMQ/vUB+HuPD1g4=;
        b=alPhgJ9J3a1QqtxWyWasHuSvBayF3JL4dTB7Scq+BEAeY2qLkwmX4vqFYINNYOY9X3
         hBMX53dR5hrmVnDSj36cfbTWt0s0Q+kE8SwRp7Uyojh+yccQpYAxkb1V7L3AX8dONPPd
         les8+fBLI+ybcrePMGmIr0dMVVpooSKauyfy6BIqgtznb7CdvvG15lv60eZkx83i0XHq
         WmxknNbOnFFeY1F8K9XJgJKUy9KbUTiL+YMz98j3fqBv0x/2V3IFHVjhf/xI5Pqu2ohb
         l8qIJxw4Y4Fu37kq+mR5OGCUps5G6SE1Gbp6Xb649wj6AS8FRnKkpsaZrDG3z3zkNmzF
         +/mg==
X-Gm-Message-State: AOAM53276Im6mQfPx7T8h2Crcu4oOA+/LL3KyzLux0wgnd2vOpcriaNf
        xqnWie7wFRANtnt/081F9Mk=
X-Google-Smtp-Source: ABdhPJyvL+v4MFBf2+W3Xz3H2xuY0V3wLF4p+6lH0Y3cve/USE1Poi/owF+J0aydCJ7qDD3UPUlfcA==
X-Received: by 2002:a17:90b:350f:b0:1e6:94e1:bd17 with SMTP id ls15-20020a17090b350f00b001e694e1bd17mr14587004pjb.162.1655107326065;
        Mon, 13 Jun 2022 01:02:06 -0700 (PDT)
Received: from liuchao-VM ([156.236.96.165])
        by smtp.gmail.com with ESMTPSA id ct21-20020a056a000f9500b0051c0784cb45sm4728274pfb.99.2022.06.13.01.02.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Jun 2022 01:02:05 -0700 (PDT)
Date:   Mon, 13 Jun 2022 16:02:00 +0800
From:   Chao Liu <chaoliu719@gmail.com>
To:     Matthew Wilcox <willy@infradead.org>, Chao Yu <chao@kernel.org>
Cc:     Jaegeuk Kim <jaegeuk@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
        linux-f2fs-devel@lists.sourceforge.net, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, Yue Hu <huyue2@coolpad.com>,
        Wayne Zhang <zhangwen@coolpad.com>,
        Chao Liu <liuchao@coolpad.com>
Subject: Re: [PATCH v2] docs: filesystems: f2fs: fix description about
 compress ioctl
Message-ID: <Yqbu+BArbUNGvft9@liuchao-VM>
References: <20220613020800.3379482-1-chaoliu719@gmail.com>
 <Yqaw3VTD46PAMN8O@casper.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Yqaw3VTD46PAMN8O@casper.infradead.org>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 13, 2022 at 04:37:01AM +0100, Matthew Wilcox wrote:
> On Mon, Jun 13, 2022 at 10:08:00AM +0800, Chao Liu wrote:
> > v2:
> > - s/file size/filesize/
>
> Why would you change it to be wrong?
>

This is a suggestion from Chao Yu. Maybe he has some other considerations.

Hi Chao,

Can you help with this question?

Thanks.

> >  Documentation/filesystems/f2fs.rst | 13 +++++++------
> >  1 file changed, 7 insertions(+), 6 deletions(-)
> >
> > diff --git a/Documentation/filesystems/f2fs.rst b/Documentation/filesystems/f2fs.rst
> > index ad8dc8c040a2..531b0f8a3946 100644
> > --- a/Documentation/filesystems/f2fs.rst
> > +++ b/Documentation/filesystems/f2fs.rst
> > @@ -818,10 +818,11 @@ Compression implementation
> >    Instead, the main goal is to reduce data writes to flash disk as much as
> >    possible, resulting in extending disk life time as well as relaxing IO
> >    congestion. Alternatively, we've added ioctl(F2FS_IOC_RELEASE_COMPRESS_BLOCKS)
> > -  interface to reclaim compressed space and show it to user after putting the
> > -  immutable bit. Immutable bit, after release, it doesn't allow writing/mmaping
> > -  on the file, until reserving compressed space via
> > -  ioctl(F2FS_IOC_RESERVE_COMPRESS_BLOCKS) or truncating filesize to zero.
> > +  interface to reclaim compressed space and show it to user after setting a
> > +  special flag to the inode. Once the compressed space is released, the flag
> > +  will block writing data to the file until either the compressed space is
> > +  reserved via ioctl(F2FS_IOC_RESERVE_COMPRESS_BLOCKS) or the filesize is
> > +  truncated to zero.
> >
> >  Compress metadata layout::
> >
> > @@ -830,12 +831,12 @@ Compress metadata layout::
> >  		| cluster 1 | cluster 2 | ......... | cluster N |
> >  		+-----------------------------------------------+
> >  		.           .                       .           .
> > -	.                       .                .                      .
> > +	  .                      .                .                      .
> >      .         Compressed Cluster       .        .        Normal Cluster            .
> >      +----------+---------+---------+---------+  +---------+---------+---------+---------+
> >      |compr flag| block 1 | block 2 | block 3 |  | block 1 | block 2 | block 3 | block 4 |
> >      +----------+---------+---------+---------+  +---------+---------+---------+---------+
> > -	    .                             .
> > +	       .                             .
> >  	    .                                           .
> >  	.                                                           .
> >  	+-------------+-------------+----------+----------------------------+
> > --
> > 2.36.1
> >
