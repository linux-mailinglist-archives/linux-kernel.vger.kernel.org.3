Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 82674590AD9
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Aug 2022 05:49:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236501AbiHLDs7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Aug 2022 23:48:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232527AbiHLDsw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Aug 2022 23:48:52 -0400
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CFEDA98596;
        Thu, 11 Aug 2022 20:48:50 -0700 (PDT)
Received: by mail-pj1-x1032.google.com with SMTP id h21-20020a17090aa89500b001f31a61b91dso7207875pjq.4;
        Thu, 11 Aug 2022 20:48:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:subject:cc
         :to:from:date:message-id:from:to:cc;
        bh=Ncu1JcFDmP0VMNE6i7v1fZbIY+FxdJgQnM3J2QjmWgs=;
        b=Ypn7cJoqgMe/lhhnMj5T9n/eTbkRlnTbnjka7yqT3Tvzf7yzdPu5yMxGDcoX/qRrKT
         Pw6LrtsexG1vcl9742zh7fd7Ct96qI6b5GuqdlsP6Bimsw6j9K2OqOTNFuDvn6hhQBkw
         NQhTzE0t8yRDgBPZQhZ29t/H/pwZTzlLdrgG8tFlY9vakZnh8jNQMONLNUw/Wt7Tqgr8
         NR7aCWdfbBcmKre82f7uxrpJGq0dyMUA1KvAo7F4bWk7uAGUFoKGkwS9zBTljvg1IgPc
         u7MO+qBGybbj5/smjfoi+WpyMZ72vxXuPgBUF4dxkqC6Uj31QjLhJLmW/tvWc5mEvL6g
         UBMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:subject:cc
         :to:from:date:message-id:x-gm-message-state:from:to:cc;
        bh=Ncu1JcFDmP0VMNE6i7v1fZbIY+FxdJgQnM3J2QjmWgs=;
        b=RqgmeoM8S6vwAJQJwOKSF0ASDFjfoM1IbDBM8NkXgOVWXBPqDQnToe7oCOpqxGT/3g
         k4apdB7HG8ZMHbAiWn2dVxq7TPvKmcoNGx8kgdDD9cWD23Dun1jTFY7b7jjgW0sDSLtI
         iXQ/UriocpSedEn2HKfDCXap9rPEuJ3eFPVBIB/C42+4eHxWlqnFUeCCMApG7SvSsq34
         rWxEXekMLjLIzt8Rg1XCXgD8dpBbk2c1pWmgNd9Lonafo4tKGq7lX6ydr/WPZ/9cnrk1
         hFCPAr95MYdEwRHtdz6DYEw/hwoxxx5u1bk+u53X7s9hpFHoQwn4smS0JSpMk8hxYnGH
         x3eg==
X-Gm-Message-State: ACgBeo0bcJin2mmf7lOqE0Vqh0UnI4kOnDJF2PmVc+cDnr8cBS9xTTXT
        5KjSz1v6hxytYkgrKQSCrnA=
X-Google-Smtp-Source: AA6agR7tG68qxm8iVn7MwS6oTFLxbFhoOUQZx/VUFxjNUxV6llWl3UelpbyoxkDoyAzbHxKL8FThfw==
X-Received: by 2002:a17:90b:2c13:b0:1f3:359a:c7d5 with SMTP id rv19-20020a17090b2c1300b001f3359ac7d5mr2215720pjb.72.1660276130330;
        Thu, 11 Aug 2022 20:48:50 -0700 (PDT)
Received: from localhost ([193.203.214.57])
        by smtp.gmail.com with ESMTPSA id 200-20020a6216d1000000b005289fad1bbesm499655pfw.94.2022.08.11.20.48.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Aug 2022 20:48:49 -0700 (PDT)
Message-ID: <62f5cda1.620a0220.7697b.1387@mx.google.com>
X-Google-Original-Message-ID: <20220812034848.GA29715@cgel.zte@gmail.com>
Date:   Fri, 12 Aug 2022 03:48:48 +0000
From:   CGEL <cgel.zte@gmail.com>
To:     Joonsoo Kim <js1304@gmail.com>
Cc:     LKML <linux-kernel@vger.kernel.org>, mm-commits@vger.kernel.org,
        Matthew Wilcox <willy@infradead.org>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        David Hildenbrand <david@redhat.com>, corbet@lwn.net,
        bsingharora@gmail.com, yang.yang29@zte.com.cn,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: + filemap-make-the-accounting-of-thrashing-more-consistent.patch
 added to mm-unstable branch
References: <20220811215204.64911C433D6@smtp.kernel.org>
 <CAAmzW4MV4rqZsSkbUO385jiijMnLzW1i7U9DaikL-T4H8Pje=A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAAmzW4MV4rqZsSkbUO385jiijMnLzW1i7U9DaikL-T4H8Pje=A@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We have discussed related question before. See:
https://lore.kernel.org/all/Yio17pXawRuuVJFO@cmpxchg.org/
The problem is that there is no suitable place to measure pagecache thrashing
in fs level likes swap_readpage(). We have to measure it in folio_wait_bit_common().

If we measure swap thrashing just in swap_readpage(), we will miss pagecache
thrashing. If we measure swap thrashing in swap_readpage(), and measure 
pagecache thrashing in folio_wait_bit_common(), it will be rerpeated calculation.

So this patch is not perfect and it works. If one day we solve the problem of
measure thrashing in folio_wait_bit_common(), we may improve this patch correspond.

Thanks.
