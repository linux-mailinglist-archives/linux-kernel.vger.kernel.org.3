Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8E7885AF390
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Sep 2022 20:27:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229812AbiIFS1e (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Sep 2022 14:27:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229748AbiIFS1c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Sep 2022 14:27:32 -0400
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com [IPv6:2a00:1450:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 305CE9AFF6
        for <linux-kernel@vger.kernel.org>; Tue,  6 Sep 2022 11:27:31 -0700 (PDT)
Received: by mail-lf1-x132.google.com with SMTP id bt10so18703064lfb.1
        for <linux-kernel@vger.kernel.org>; Tue, 06 Sep 2022 11:27:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date;
        bh=ZUpzMHvchnbWsqxJeFoXp/P2C7rf8MP7y5MO8R3SUlg=;
        b=evVapLaaGlVqqY/j8Gbn/X1kndSZrQhs5Lna2QWGqYVrzb2qwk3oWh03Zfl3RstmE8
         mD5KYILVb8zBPNZlpkRj/PfH09eLqiLeQyUxd5GE1F9JaTeWg/9G27i9JQTxsNdaFRsF
         U0/C0ZOzeMa46PtXqc2g2GN8Dhr8IzFsmqHwsmOZcb16mc15wdAOOrAkJQ00ADf/0NfW
         R78camhq2XuD5rJnuHKbIE6kXICzs76RqtVlOyBbuyRrWaMUvjlLGeuSk2nhtTxCO0z0
         MLyybXhPfk38/XNYb+oW428CP3UVHYjTvKL3VrIUY9PI0dGDV/3Xn9WJ9pdGJNBQenf+
         UD3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date;
        bh=ZUpzMHvchnbWsqxJeFoXp/P2C7rf8MP7y5MO8R3SUlg=;
        b=1XdBZckvPw7kZZJuMGG1nLWJRaUFQuDgIZHCGJn896K0cyJI/aosnSDlwfyNcNMwVZ
         dORMSpTW5sHKZJYvokjI10sejZNYI7sI89kqOg5omNr8yQEfFXzetCKLu3cNpa9D9OZR
         3AHlM9m5BdJeYBbPAdDgJX08QORK/JoYF9RabgjBSztKWHulPzcRT7pmWwSgiqeoC4he
         u2hOzmfgavkPG6VPkHY7AM3tlbMAyEMDopVFV/vsisk+MO6j5ZnYSviVMYCSINauAVfb
         smSal3h0mnVaXRm+/P4iEI7UI6Q9xNo3H9oh6ug8N+G7F2zFIOJKECqvuTDi5H6fy6AU
         aygA==
X-Gm-Message-State: ACgBeo16B9rd2Tk9RfW9TcislAa3tzrLMPSqmQdnrtwPF12Du5ljukuD
        4EG7oh1oR58WGYlr5ZJMrwQ=
X-Google-Smtp-Source: AA6agR41sXkcrlFUvaDZz3CT3CfJxkJn7FWtdUKQQVWcjNmsBlr/xcVF925VCaBcqDb1oIFYUQN74Q==
X-Received: by 2002:a05:6512:158b:b0:48b:38:cff8 with SMTP id bp11-20020a056512158b00b0048b0038cff8mr17134954lfb.100.1662488849452;
        Tue, 06 Sep 2022 11:27:29 -0700 (PDT)
Received: from pc636 ([155.137.26.201])
        by smtp.gmail.com with ESMTPSA id a3-20020a056512200300b0049306939413sm1888852lfb.211.2022.09.06.11.27.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Sep 2022 11:27:28 -0700 (PDT)
From:   Uladzislau Rezki <urezki@gmail.com>
X-Google-Original-From: Uladzislau Rezki <urezki@pc636>
Date:   Tue, 6 Sep 2022 20:27:26 +0200
To:     Song Liu <songliubraving@fb.com>
Cc:     Song Liu <song@kernel.org>, Linux-MM <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Uladzislau Rezki <urezki@gmail.com>,
        Baoquan He <bhe@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH v2] mm/vmalloc: Extend find_vmap_lowest_match_check with
 extra arguments
Message-ID: <YxeRDjJfYhXp+kE5@pc636>
References: <20220906060548.1127396-1-song@kernel.org>
 <75CD7F46-F419-4D93-B59D-A8C0F942BB91@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <75CD7F46-F419-4D93-B59D-A8C0F942BB91@fb.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> 
> 
> > On Sep 5, 2022, at 11:05 PM, Song Liu <song@kernel.org> wrote:
> > 
> > find_vmap_lowest_match() is now able to handle different roots. With
> > DEBUG_AUGMENT_LOWEST_MATCH_CHECK enabled as:
> > 
> > diff --git a/mm/vmalloc.c b/mm/vmalloc.c
> > index e68c0081e861..7552f1f8350e 100644
> > --- a/mm/vmalloc.c
> > +++ b/mm/vmalloc.c
> > @@ -713,7 +713,7 @@ EXPORT_SYMBOL(vmalloc_to_pfn);
> > /*** Global kva allocator ***/
> > 
> > -#define DEBUG_AUGMENT_LOWEST_MATCH_CHECK 0
> > +#define DEBUG_AUGMENT_LOWEST_MATCH_CHECK 1
> > 
> > compilation failed as:
> > 
> > mm/vmalloc.c: In function 'find_vmap_lowest_match_check':
> > mm/vmalloc.c:1328:32: warning: passing argument 1 of 'find_vmap_lowest_match' makes pointer from integer without a cast [-Wint-conversion]
> > 1328 |  va_1 = find_vmap_lowest_match(size, align, vstart, false);
> >     |                                ^~~~
> >     |                                |
> >     |                                long unsigned int
> > mm/vmalloc.c:1236:40: note: expected 'struct rb_root *' but argument is of type 'long unsigned int'
> > 1236 | find_vmap_lowest_match(struct rb_root *root, unsigned long size,
> >     |                        ~~~~~~~~~~~~~~~~^~~~
> > mm/vmalloc.c:1328:9: error: too few arguments to function 'find_vmap_lowest_match'
> > 1328 |  va_1 = find_vmap_lowest_match(size, align, vstart, false);
> >     |         ^~~~~~~~~~~~~~~~~~~~~~
> > mm/vmalloc.c:1236:1: note: declared here
> > 1236 | find_vmap_lowest_match(struct rb_root *root, unsigned long size,
> >     | ^~~~~~~~~~~~~~~~~~~~~~
> > 
> > Extend find_vmap_lowest_match_check() and find_vmap_lowest_linear_match()
> > with extra arguments to fix this.
> > 
> > Fixes: f9863be49312 ("mm/vmalloc: extend __alloc_vmap_area() with extra arguments")
> > Cc: Uladzislau Rezki (Sony) <urezki@gmail.com>
> > Cc: Baoquan He <bhe@redhat.com>
> > Cc: Andrew Morton <akpm@linux-foundation.org>
> > Signed-off-by: Song Liu <song@kernel.org>
> 
> Forgot to add the following from v1:
> 
> Reviewed-by: Baoquan He <bhe@redhat.com>
> Reviewed-by: Uladzislau Rezki (Sony) <urezki@gmail.com>
> 

Works great to me. Appreciate it!

--
Uladzislau Rezki
