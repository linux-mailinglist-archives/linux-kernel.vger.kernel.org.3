Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C375054A72E
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Jun 2022 04:59:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239465AbiFNC6V (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Jun 2022 22:58:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348867AbiFNC5q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jun 2022 22:57:46 -0400
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6E7E36E2A;
        Mon, 13 Jun 2022 19:49:47 -0700 (PDT)
Received: by mail-pj1-x102a.google.com with SMTP id t3-20020a17090a510300b001ea87ef9a3dso7799640pjh.4;
        Mon, 13 Jun 2022 19:49:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=LaVJJVoW1ZPNs1w8IwxxzimUXb+MOrA0NjgrLCWagYc=;
        b=LrD1D7q7s9Bn9qtPByR7VUT0RmFu7eHKmvp0ikfKmyvM7vZ5y441etLy7xjuhlwsoi
         LLw7H+bXbgfXrGdevyLMp65fgB14CPP/Q+0CQBfGDJcuaq9g6x2IQRVXlfvADn1bINX+
         QCOGVUDzwfqZVD0Fice34E+asX0xM0YgQ9b8NtOBO2am93KsYr94c6TfjUX97cm1v2Pb
         tQptYXnuYqQHXdKgZrD6f+6NGPobQUkJ3eKKxvX7/6DbQbXVHiZTAcxVjaPc+kH6seDm
         xD3TlBaou+fCOX0XrMxLRpIJikT7XklIeD+ey25DHutvQLwxp3ssxF7xx/2pYNvH4xqn
         pYgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=LaVJJVoW1ZPNs1w8IwxxzimUXb+MOrA0NjgrLCWagYc=;
        b=D1f1ryekYwOKzx+6o3NV5AAPfUX88izDQwiuCs5rRns1og4l5yOzC0pOaNuldytFQl
         GQmlCD8KqmRsRKFSRYfTA9aFRBgOnk4XlSKc0SAnLVuxpbaM+povcJa7oDn2ofGDG+he
         6yDa6g06BEf6E9JKCgtwg7hwr87/m+fKkkkzM4qVWbp8Cch9BKNjAAZSxNcUcNjnpFLt
         baTWYTVrUaLUqTNpiYmzIgIenaODeWcP+m9j6HGgIDbQhW7LtG6eJsiwc1lAx/dYtH8N
         hZzZxdRWlrDkE+cQO4aD4JmyzrpPvjJ398pk5/C+DQlGSY53Txdrs5UGftOw84gO54GR
         o8NA==
X-Gm-Message-State: AJIora8fCoCUawnf8QbV2mw+LdiEasWxvUyc5ljNVVDI7H8puHFlXJGi
        OII1BRpwCdqkTbc54+T2bFtArJyIYFWfE58MEnU=
X-Google-Smtp-Source: AGRyM1v/elZzkeRRgw6Rn0c31Ol5uWIHtPYsuOt7qNjxcWS9NHecfbB8Ze/UCez8IDdjcyw4g3/HLA==
X-Received: by 2002:a17:902:ecc9:b0:163:f779:f97a with SMTP id a9-20020a170902ecc900b00163f779f97amr2069128plh.167.1655174987197;
        Mon, 13 Jun 2022 19:49:47 -0700 (PDT)
Received: from liuchao-VM ([156.236.96.165])
        by smtp.gmail.com with ESMTPSA id z28-20020a62d11c000000b0051bc44f26d9sm6177916pfg.23.2022.06.13.19.49.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Jun 2022 19:49:45 -0700 (PDT)
Date:   Tue, 14 Jun 2022 10:49:40 +0800
From:   Chao Liu <chaoliu719@gmail.com>
To:     Jonathan Corbet <corbet@lwn.net>, Chao Yu <chao@kernel.org>
Cc:     Matthew Wilcox <willy@infradead.org>,
        Jaegeuk Kim <jaegeuk@kernel.org>,
        linux-f2fs-devel@lists.sourceforge.net, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, Yue Hu <huyue2@coolpad.com>,
        Wayne Zhang <zhangwen@coolpad.com>,
        Chao Liu <liuchao@coolpad.com>
Subject: Re: [PATCH v2] docs: filesystems: f2fs: fix description about
 compress ioctl
Message-ID: <Yqf3RDuu4+rqmzSA@liuchao-VM>
References: <20220613020800.3379482-1-chaoliu719@gmail.com>
 <Yqaw3VTD46PAMN8O@casper.infradead.org>
 <Yqbu+BArbUNGvft9@liuchao-VM>
 <87czfc1nr8.fsf@meer.lwn.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87czfc1nr8.fsf@meer.lwn.net>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 13, 2022 at 11:23:07AM -0600, Jonathan Corbet wrote:
> Chao Liu <chaoliu719@gmail.com> writes:
>
> > On Mon, Jun 13, 2022 at 04:37:01AM +0100, Matthew Wilcox wrote:
> >> On Mon, Jun 13, 2022 at 10:08:00AM +0800, Chao Liu wrote:
> >> > v2:
> >> > - s/file size/filesize/
> >>
> >> Why would you change it to be wrong?
> >>
> >
> > This is a suggestion from Chao Yu. Maybe he has some other considerations.
>
> Sorry, I should have replied to that.  I disagree with that suggestion.
> "Filesize" is not an English word, and there doesn't seem to be any
> reason to use it in our docs.
>
> <checks>
>
> We have to occurrences now - one already in the f2fs docs.  I think we
> shouldn't add more.  So my plan is to apply the first version of this
> patch.  Chao Liu: is there a reason why you didn't add the Reviewed-by
> from Chao Yu in the second version?

Sorry for my carelessness. I should have added it.

Thanks,
