Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 09F3A588E55
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Aug 2022 16:14:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238497AbiHCOOd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Aug 2022 10:14:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236322AbiHCOOc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Aug 2022 10:14:32 -0400
Received: from mail-il1-x129.google.com (mail-il1-x129.google.com [IPv6:2607:f8b0:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B49E712ACF
        for <linux-kernel@vger.kernel.org>; Wed,  3 Aug 2022 07:14:30 -0700 (PDT)
Received: by mail-il1-x129.google.com with SMTP id o14so3566953ilt.2
        for <linux-kernel@vger.kernel.org>; Wed, 03 Aug 2022 07:14:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=coSWDI5TPd206clMrpDHmTCH9S1/Zas/lvnlK0aNvZE=;
        b=tmoJe5DcfLGdmWoMUbd50bNL+RfThJhg1Y3Q6ryxOIOH5QQirM7YLK9GQfjlx6jbFr
         HNI4AdwMwK8oHwtxdIpZrl8/T8BAuc/m8UHGo+Uh22X2JfpvTBO3ouj5VDkdHrErk+mO
         wUBvYaegHJg8eKr7jzu1sIAcEZF5x+CTlvWB14BNAtGZBeSSi1QNt7qqQM9nL0DH7Qf9
         iWNOp/mMntG0vi5XdaWqIyE+KjfUiIg7xu9lUr4ctjNrqN1HtjU4OWwwg8nNHAmQkRKi
         iCXvqEY3mdk2ddOo6GLflSCZji2Ys15gAqdLIyKg6MzMBQeAsPtU+GDOkrtvZDaQsPHx
         oMbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=coSWDI5TPd206clMrpDHmTCH9S1/Zas/lvnlK0aNvZE=;
        b=k9UcFP77xd2VwJhi+UP2gs3Lz++Mbr3CkYOUiHjcGtnUj24smdp2hcsqCqtx/gl5d+
         jAogfPZBSipYW/ospUDpkz6/a2O/7lwHqL0kc/99hGdUZSBogJtOverD8bZigiCUuNI9
         7WYZx2mBG5RC604P1FLpqKTTZfOZAeIG2F5qHw4RNegvWc6XQZrxbhXekuvHovJ8BXdB
         TTcc+N0ycrKdlPj/OOHIg0HaZuz0t7ARo8Q0FF5py3hjnrbSTZQFuvi/0D8X4t9C0qJs
         wItCcm1lKK7p4qbmEs21lnkT5QnrLJBpT2HQzu2vtOs6puOPSYbp/VsO7vHGXQ/XlxLR
         UJaw==
X-Gm-Message-State: AJIora9JGFwiHp+KjkkWFoaKu00Rioa/qunW4CFXdzw5s6ZMFgWdgEML
        iL87b17l9cBcyJq2DySMd34G+g==
X-Google-Smtp-Source: AGRyM1sJ2DZdUFuDRvolZP2VpM79J+5a4bsqB7qAIkfSlUYfimdhUQGByoup9L5s4uyBDetZw9f+mQ==
X-Received: by 2002:a05:6e02:13c5:b0:2de:25c1:242 with SMTP id v5-20020a056e0213c500b002de25c10242mr9990149ilj.283.1659536069471;
        Wed, 03 Aug 2022 07:14:29 -0700 (PDT)
Received: from [192.168.1.172] ([207.135.234.126])
        by smtp.gmail.com with ESMTPSA id v18-20020a02b912000000b0034264f6a809sm249856jan.14.2022.08.03.07.14.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 03 Aug 2022 07:14:28 -0700 (PDT)
Message-ID: <6e61b631-fea0-7152-1e24-4f67cfd33f48@kernel.dk>
Date:   Wed, 3 Aug 2022 08:14:27 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: linux-next: manual merge of the vfs tree with the origin tree
Content-Language: en-US
To:     broonie@kernel.org
Cc:     Al Viro <viro@zeniv.linux.org.uk>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
References: <20220803121815.54438-1-broonie@kernel.org>
From:   Jens Axboe <axboe@kernel.dk>
In-Reply-To: <20220803121815.54438-1-broonie@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/3/22 6:18 AM, broonie@kernel.org wrote:
> Hi all,
> 
> Today's linux-next merge of the vfs tree got a conflict in:
> 
>   fs/io_uring.c
> 
> between commit:
> 
>   ed29b0b4fd835 ("io_uring: move to separate directory")
> 
> from the origin tree and commit:
> 
>   164f4064ca81e ("keep iocb_flags() result cached in struct file")
> 
> from the vfs tree.
> 
> I fixed it up (see below) and can carry the fix as necessary. This
> is now fixed as far as linux-next is concerned, but any non trivial
> conflicts should be mentioned to your upstream maintainer when your tree
> is submitted for merging.  You may also want to consider cooperating
> with the maintainer of the conflicting tree to minimise any particularly
> complex conflicts.
> 
> diff --git a/io_uring/rw.c b/io_uring/rw.c
> index 2b784795103cc..b20ba87e4926f 100644
> --- a/io_uring/rw.c
> +++ b/io_uring/rw.c
> @@ -661,7 +661,7 @@ static int io_rw_init_file(struct io_kiocb *req, fmode_t mode)
>  	if (!io_req_ffs_set(req))
>  		req->flags |= io_file_get_flags(file) << REQ_F_SUPPORT_NOWAIT_BIT;
>  
> -	kiocb->ki_flags = iocb_flags(file);
> +	kiocb->ki_flags = file->f_iocb_flags;
>  	ret = kiocb_set_rw_flags(kiocb, rw->flags);
>  	if (unlikely(ret))
>  		return ret;

That's the right resolution, mentioned that in my pull request as well.

-- 
Jens Axboe

