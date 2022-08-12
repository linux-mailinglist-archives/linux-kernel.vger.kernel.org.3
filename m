Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 87328590C80
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Aug 2022 09:25:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237339AbiHLHYv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Aug 2022 03:24:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237325AbiHLHYp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Aug 2022 03:24:45 -0400
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8448FA5C48;
        Fri, 12 Aug 2022 00:24:44 -0700 (PDT)
Received: by mail-pl1-x630.google.com with SMTP id w14so51159plp.9;
        Fri, 12 Aug 2022 00:24:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:subject:cc:to:from:date:message-id:from:to
         :cc;
        bh=jnfvUNaiRVkMfI9C49t+wGC/LAZaEG0+vnS173VWr9A=;
        b=N32+sVbkv5Z5LSKrj3J20qXr3PwMHh8c+xsFSUEb2upxuAxiLhPolGdF/rsE4NXHEU
         HffP0Nj/IJ4uTNzmpzmf27VWNxqUOO01mNaIuAs8UjegSsHxf/DwaaS5J48bbpE4o2S9
         CsGyJJ1sl6P7uiKhoG0EZFUkyyF/o1hXZDjO73crr8xa25oculgm68UjH4vTQfQHf527
         /KDk4h5UTJRGT2+QMxhczFwRId1rgbynYhr9Xq6MuKzXFSRFJrM9zXfMniImR5hkqk8j
         trI5BK3jLNXFYvQS/93wFlv0g9tdyR8DkaDAmWwfmOPYmgxoga5Uaq4fhbnQzt4Nj1GS
         +H6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:subject:cc:to:from:date:message-id
         :x-gm-message-state:from:to:cc;
        bh=jnfvUNaiRVkMfI9C49t+wGC/LAZaEG0+vnS173VWr9A=;
        b=bABrUZmJPhgiQoP4mQrKDwDl/GVQ1AbzG2z3CzXKvbc6P2X9wjgvrHkJXNxXP3ajmt
         N3U8l3HnMBaXaPJt01w3jMrDWs04xckIBitbrOZxKgtaIlGHgWwvUWmNrXK1ttCxknoH
         072BSl6tp5vPBzv6KaxcfLAJHuWeKfhb8qJ5sbeNY1LhtuYArn+jc340N7qhzMXhBgvF
         6ufk01oEwhClO3c5e/hcNdwDABIo6o/fb1nBpiY3eXfYrbKTtj9lym+0pIA3OMFh6AvV
         /XdOhDdu1XUkbsB+Y2h89dse/JxNXNvbpaqeSBb383xhSXAZ0PxfCZkKyz7KJBb0Q6ql
         /Dbw==
X-Gm-Message-State: ACgBeo01fgUnwQtFONtelfIAxCC/IxCekd3rYHJ5R6WMTKDcNZ+vEd3g
        Lh0qd/1h30YGjZVfexdja8Taq2gx52I=
X-Google-Smtp-Source: AA6agR7aeFo6755JGWoRnWWAkisVlR1uW6w0ZFz33fsTTJDuCRaYaq64SCNVDx7ZRCmIDun2+CcAug==
X-Received: by 2002:a17:90a:a2a:b0:1f3:1479:e869 with SMTP id o39-20020a17090a0a2a00b001f31479e869mr2737190pjo.41.1660289083951;
        Fri, 12 Aug 2022 00:24:43 -0700 (PDT)
Received: from localhost ([193.203.214.57])
        by smtp.gmail.com with ESMTPSA id a8-20020a170902ecc800b0016efbccf2c0sm957720plh.56.2022.08.12.00.24.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Aug 2022 00:24:43 -0700 (PDT)
Message-ID: <62f6003b.170a0220.e7d9.1bbb@mx.google.com>
X-Google-Original-Message-ID: <20220812072442.GA33169@cgel.zte@gmail.com>
Date:   Fri, 12 Aug 2022 07:24:42 +0000
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
 <62f5cda1.620a0220.7697b.1387@mx.google.com>
 <CAAmzW4NAe2RBmw_OwRVOE+PEEwABrLzAQrVtFJBA7gZNm__oiw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAAmzW4NAe2RBmw_OwRVOE+PEEwABrLzAQrVtFJBA7gZNm__oiw@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 12, 2022 at 03:45:09PM +0900, Joonsoo Kim wrote:
> 2022년 8월 12일 (금) 오후 12:48, CGEL <cgel.zte@gmail.com>님이 작성:
> >
> > We have discussed related question before. See:
> > https://lore.kernel.org/all/Yio17pXawRuuVJFO@cmpxchg.org/
> > The problem is that there is no suitable place to measure pagecache thrashing
> > in fs level likes swap_readpage(). We have to measure it in folio_wait_bit_common().
> >
> > If we measure swap thrashing just in swap_readpage(), we will miss pagecache
> > thrashing. If we measure swap thrashing in swap_readpage(), and measure
> > pagecache thrashing in folio_wait_bit_common(), it will be rerpeated calculation.
> 
> Maybe, repeated calculation issue could be easily solved by
> re-entrance detection on
> delayacct_thrashing_start().
>
If no other suggestion from others, I will commit another patch
to realize this.

And I think this patch will not conflict with the later patch.

Thanks.

> Thanks.
