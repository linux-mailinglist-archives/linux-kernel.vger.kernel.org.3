Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DAC18508B1E
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Apr 2022 16:49:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354557AbiDTOv3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Apr 2022 10:51:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354442AbiDTOv1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Apr 2022 10:51:27 -0400
Received: from mail-qk1-x72c.google.com (mail-qk1-x72c.google.com [IPv6:2607:f8b0:4864:20::72c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D92799FC6
        for <linux-kernel@vger.kernel.org>; Wed, 20 Apr 2022 07:48:39 -0700 (PDT)
Received: by mail-qk1-x72c.google.com with SMTP id b68so1360524qkc.4
        for <linux-kernel@vger.kernel.org>; Wed, 20 Apr 2022 07:48:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=tkh8J2lKGPT+L0yWvNsS4Conro8aEFkfjN82mbeQ8Dk=;
        b=e6jldbqIFDukpdn3OA8ix6XZVlZaE6MpIhoZFApQQxRp0ZZ3qC3uL0fbApVXgkI28H
         5zJBU+17KnWrSNaPWVTaOQIxUGs/Y7s3tfCMnpLtHzUC/66qXOoQbUPp3f+OMYFeDMfA
         vIiAdPUyyX5jHQ08epts3UIJsoEmBSVJR9Cd8ZzRyO80K+PvmY/FwG4ke78ypWttVJmK
         jn+t80tH70XLZzplpNt0mxKPCP8RPvuTfm+LSu193TyVU0rniSOI+fzInL9nxJHb0mlf
         zYmTESTeKRdaDedk+HM4Op9goGzR6E0ARrmyhvgJckNQikMNNPIz8FjrvKoxy2GUdlIt
         Sv2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=tkh8J2lKGPT+L0yWvNsS4Conro8aEFkfjN82mbeQ8Dk=;
        b=06Srwl64CFWkc4vKJw0f0rqq0s1Anga+rVQ5esdCvBU0OzXqYiY37HrP4O7U+uTx8u
         TiakKDtkHCPqMZqOqapTpa/zvJn06B5FIJOZymEr/4gdYShZmYnHyzOsIwwZaxXV/ges
         inQbwPRvrUDnB7mViZnQ/uU18x4frxKKqomKa2kdIzhq8ee+etXeJcVDhoaBcuurA3oz
         rKdyGuqA4VahCf5r3jjujJTHS9PiKm8h0Pyj+fcflvkMGbWo4ErKiIhwMuhyaCAg1PJX
         9v3iT0eC+ZALLucwIuTgdUUvwWRy35J4+XqZjOchwD9HN5BlCAEuOUAeMeCJJfvougfA
         eFWQ==
X-Gm-Message-State: AOAM530lrSBPCnXnqTa+/QWiMKxGWkb/ug+nivQfJVlLgN7dmUF2/pcu
        CBFeKKLlFF14oeDUXDTpdTuf7GmDYiWkTTl9
X-Google-Smtp-Source: ABdhPJxxfYZulP7IF/wJCusWEypd1WbmQMAJ786C+J9Lvl3khU2wHW7JGB/a48jCRLC4GYj7QZVRXA==
X-Received: by 2002:a05:620a:3193:b0:69e:cbbe:d285 with SMTP id bi19-20020a05620a319300b0069ecbbed285mr4206821qkb.408.1650466118909;
        Wed, 20 Apr 2022 07:48:38 -0700 (PDT)
Received: from jaehee-ThinkPad-X1-Extreme ([2607:fb90:50e7:2813:48a4:4906:b926:9eef])
        by smtp.gmail.com with ESMTPSA id l13-20020a05622a050d00b002f205ba53efsm1818254qtx.25.2022.04.20.07.48.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Apr 2022 07:48:38 -0700 (PDT)
Date:   Wed, 20 Apr 2022 10:48:34 -0400
From:   Jaehee Park <jhpark1013@gmail.com>
To:     Dan Carpenter <dan.carpenter@oracle.com>
Cc:     Pavel Skripkin <paskripkin@gmail.com>, Larry.Finger@lwfinger.net,
        phil@philpotter.co.uk, gregkh@linuxfoundation.org,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        outreachy@lists.linux.dev
Subject: Re: [PATCH v3 1/7] staging: r8188eu: remove unused member
 free_bss_buf
Message-ID: <20220420144834.GA1313590@jaehee-ThinkPad-X1-Extreme>
References: <cover.1650392020.git.jhpark1013@gmail.com>
 <3c5a510938ac395a13bb09c0de1868cce8ca3dd8.1650392020.git.jhpark1013@gmail.com>
 <32587233-0ff6-ed0f-b873-cd4f797005a9@gmail.com>
 <20220420115534.GF2951@kadam>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220420115534.GF2951@kadam>
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 20, 2022 at 02:55:34PM +0300, Dan Carpenter wrote:
> As a kernel community, I don't think we are pro-active enough about
> preventing bugs.  One of my co-workers and I have started a bi weekly
> phone call to look at CVEs from the previous week and discuss how they
> could have been prevented or detected earlier.  Of course, my solutions
> are always centered around static analysis because that's my deal but
> some bugs are caused by process issues, or could be detected with better
> testing.
> 
> In this case there were two bugs proposed bugs.
> 
> 1) The memory leak that Fabio noticed.  Smatch is bad at detecting
>    memory leaks.  It's a hard problem, because in this case it's
>    across function boundaries.
> 
> Fabio caught the leak.  I don't know if I would have.
> 
> 2) The NULL dereference.
> 
>    The "&pnetwork->list" expression is not a dereference so this is also
>    a cross function thing.  I thought I used to have an unpublished check
>    for bogus addresses like that where pnetwork is NULL.
> 
>    Another is idea is that when you have pnetwork++ and it's a NULL
>    pointer then print an error message.  Or even potentially NULL.
>    There are various heuristics to use which mean that "A reasonable
>    person would think this could be NULL".
> 
>    Or another idea would be that we could test patches.  Right now we
>    don't really have a way to test these.  But, of course, we wish we
>    did.
> 
> It's not super likely that we would have committed the NULL deref
> patch.  I would have caught that one if you didn't and Fabio likely
> would have as well.  But I like to remove the human error whenever I
> can.
> 
> regards,
> dan carpenter

I'm sorry about the NULL dereference. I wasn't sure about pnetwork
and I should've asked. I wanted to ask why pbuf should be removed
when it was being used for pnetwork but ended up not asking and
sent a faulty patch. Sorry again and thank you for explaining the
errors. I will be more careful about memory leaks and dereferencing
errors. Are there checks that I can run to detect these?

Thanks,
Jaehee
