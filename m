Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AB21A590C13
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Aug 2022 08:45:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237312AbiHLGp0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Aug 2022 02:45:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229524AbiHLGpW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Aug 2022 02:45:22 -0400
Received: from mail-io1-xd34.google.com (mail-io1-xd34.google.com [IPv6:2607:f8b0:4864:20::d34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DAC4215A30;
        Thu, 11 Aug 2022 23:45:20 -0700 (PDT)
Received: by mail-io1-xd34.google.com with SMTP id z145so166941iof.9;
        Thu, 11 Aug 2022 23:45:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc;
        bh=WSNSeeymQH5rX6gep7G14n7qacd9r1ygZ7oMTL0zyjQ=;
        b=q3Oo0vil6ca555f9dQgm2pUQLGmLkUoqHdWAmdw34SZQY154g64IgvBh5xB9JUQjLI
         fhzaUJFlbiIeNMVUxJj69EnvsGYbbn0Kke0D8QOl/h8fmUtTIIVzrMl4HgHA18LoHOF1
         +fTMDe+bdDWwO095Yu+NiRLCNPZs7wTq6n7GuGlKGdhNhAtMJ8xDwlvgma1Ch2q149tc
         90/+yj3sUcS3L2JneAjWv2V7bT1tIxl3H3DLYk13veAR0KjlmJGCgKVLySSUMHjNEUnc
         32vnXpDvQnMQaIeX+xRvP6RCW9FM1fpkNdQKYIvlmzbSvfxBcCV0EuSvpcf+4fxxS3RM
         P3UQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc;
        bh=WSNSeeymQH5rX6gep7G14n7qacd9r1ygZ7oMTL0zyjQ=;
        b=s29FX2VlqstBU4N/Pf8eW0oz6NsAr4NOZiOEf//Y/2gID+fe6knTyxTXZzrhnzldcD
         1BrFZBJylFeGYbSZ2pM/4IuaHvZDj+jTmrZhNzbtv7Ik+venDWaihiunN+j+HaLju/Q/
         3hPuONY3lpOjnkCxYvYADAgeDqSBH+QdA+PvtYX/OzWyYPJjFYFARmj1IgBrYwTiZBtW
         lkMif4p560sPCsiP0H5RaW4nC45e2IbanJDfwVEfY+Za+9djbOzsnO28bBQqeHjdes5F
         kbCD7gfo3KoRgvYskV7rsd8etctqAfjV9TNPz3e7VHcvIO2xGceGXZS3ruq/Mh/KaJfi
         ybKg==
X-Gm-Message-State: ACgBeo063U03bKcv19VQST8I+QqqTpYVxOM1ia6nKAW6e+f0xU/lxqto
        vsPUbSze8zMF1+E0QFU8S2T6qa49dvwXUV3CeYA=
X-Google-Smtp-Source: AA6agR4DB8kmM0oH4/QOEOKXa+NxdzOYDH3888wTtomlAKlVMTsVFcAfpY4sSr8Ti92Q5GbOAW1au/XM5or3t2+N5x8=
X-Received: by 2002:a05:6638:140c:b0:342:e625:2c2d with SMTP id
 k12-20020a056638140c00b00342e6252c2dmr1298705jad.119.1660286720279; Thu, 11
 Aug 2022 23:45:20 -0700 (PDT)
MIME-Version: 1.0
References: <20220811215204.64911C433D6@smtp.kernel.org> <CAAmzW4MV4rqZsSkbUO385jiijMnLzW1i7U9DaikL-T4H8Pje=A@mail.gmail.com>
 <62f5cda1.620a0220.7697b.1387@mx.google.com>
In-Reply-To: <62f5cda1.620a0220.7697b.1387@mx.google.com>
From:   Joonsoo Kim <js1304@gmail.com>
Date:   Fri, 12 Aug 2022 15:45:09 +0900
Message-ID: <CAAmzW4NAe2RBmw_OwRVOE+PEEwABrLzAQrVtFJBA7gZNm__oiw@mail.gmail.com>
Subject: Re: + filemap-make-the-accounting-of-thrashing-more-consistent.patch
 added to mm-unstable branch
To:     CGEL <cgel.zte@gmail.com>
Cc:     LKML <linux-kernel@vger.kernel.org>, mm-commits@vger.kernel.org,
        Matthew Wilcox <willy@infradead.org>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        David Hildenbrand <david@redhat.com>, corbet@lwn.net,
        bsingharora@gmail.com, yang.yang29@zte.com.cn,
        Andrew Morton <akpm@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

2022=EB=85=84 8=EC=9B=94 12=EC=9D=BC (=EA=B8=88) =EC=98=A4=ED=9B=84 12:48, =
CGEL <cgel.zte@gmail.com>=EB=8B=98=EC=9D=B4 =EC=9E=91=EC=84=B1:
>
> We have discussed related question before. See:
> https://lore.kernel.org/all/Yio17pXawRuuVJFO@cmpxchg.org/
> The problem is that there is no suitable place to measure pagecache thras=
hing
> in fs level likes swap_readpage(). We have to measure it in folio_wait_bi=
t_common().
>
> If we measure swap thrashing just in swap_readpage(), we will miss pageca=
che
> thrashing. If we measure swap thrashing in swap_readpage(), and measure
> pagecache thrashing in folio_wait_bit_common(), it will be rerpeated calc=
ulation.

Maybe, repeated calculation issue could be easily solved by
re-entrance detection on
delayacct_thrashing_start().

Thanks.
