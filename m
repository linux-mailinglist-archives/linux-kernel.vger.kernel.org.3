Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3AA2A4AB607
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Feb 2022 08:49:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236589AbiBGHnk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Feb 2022 02:43:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242505AbiBGHjd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Feb 2022 02:39:33 -0500
Received: from mail-il1-x12d.google.com (mail-il1-x12d.google.com [IPv6:2607:f8b0:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CCA11C043181;
        Sun,  6 Feb 2022 23:39:31 -0800 (PST)
Received: by mail-il1-x12d.google.com with SMTP id z18so10328763ilp.3;
        Sun, 06 Feb 2022 23:39:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=E6mGN2TJPnhfJHMvM5rybIz+H73xpBLlP90eQggs1YM=;
        b=orksEyljccx/8YH8KVqrESdUXZnTMGugo1jS9kO7rQ1J+FtntbU2JNARxoqjWmeHil
         8CWmas+UJoBytJ494KlQsiyu5cLKbgre4Hnz0zUYrtm2YrAS7js0yqTh250TilZ62hYN
         dCafApU7zcsOvxsF8XvC7+HnKuAB9vAtxI+RpQHrR10o4nX/Wz4+b/9AWOiee03eOYYn
         HMFE03iK10wHRS+Fj2vXL/QoMg/gylwzRExNijEAQfrs+NnZU/Rf4E2uAdIYwWzLloSz
         t2uHZQr+2rOv2JMchCC0fzCTmJMq38tT1KshwQxZHve7U01LFrM2hs1eceEOFA3gq8fk
         i86w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=E6mGN2TJPnhfJHMvM5rybIz+H73xpBLlP90eQggs1YM=;
        b=23Ulj9axA8ma0iKkytoxa2czH4LoTvxNVlcIxdqy2nk+fpfebjf9l3knkmXlCQ2q1z
         Ft6m6BC2lVSvFtdmb95YwUDwdllO3bWPivMHWqN84YtMAgfmodUNRHyC7FOdBUnLNF38
         sHJZJB0JsLVlN6xFXThHCC4ul3xt0lU+7eHnSfVE+1L+6vLacTBZvx5rWjA74iWpAt5a
         Au9rcZWGpDkiJtx236YGwRth+yFLPgu3gyolM6b9AlvXN9pu9MaRRnzAnHEWAX3qI0PC
         Q6beK8bauIdj1s+9pIg1hIj3PJiLPp7xEYwoZgIz+6QmW0qY/1dBOPYGkJscwo4/O+sC
         6vgg==
X-Gm-Message-State: AOAM5313agyVvTFoHYQ17G5wFNzPXf3ds1yTVc5vwOnQXiCQmu77xoNZ
        cczTGW15Sv5fKEj2OGO6K0/h0hflPPhL3V4wAKs=
X-Google-Smtp-Source: ABdhPJyRIpQirwQp9aUyJ5eQHhLn+RmuIsV0E4eQpshzR02aOWAEx3MdUL63cUVM61IfbJb21QwUx3GHBS8pbTPfTnk=
X-Received: by 2002:a05:6e02:1be9:: with SMTP id y9mr5454052ilv.221.1644219571201;
 Sun, 06 Feb 2022 23:39:31 -0800 (PST)
MIME-Version: 1.0
References: <1642003482-48935-1-git-send-email-wang.yong12@zte.com.cn>
 <CAMU9jJquKLfzLOjN3xTLHgPJFWONpeVgUDG-0vsf_8ia3r3ALQ@mail.gmail.com>
 <CAOH5QeBxnK-vOwVh9HNeu5PjMPJrHtWCyTK_y43iCbfzN+aoEg@mail.gmail.com>
 <CAOH5QeAka4QsLCOHaNK8NBp1BUFsu3HqEqiOhWOewabA58fVqw@mail.gmail.com>
 <CAMU9jJr4A0jsZGAqdOUTc-gBeshCgPAS=2Vvubs_kmsJSegzkQ@mail.gmail.com>
 <CAJy-Amne22+2cApoeEAGSc7d7ppSQja7pLX6SY_3+0wr8i3Asw@mail.gmail.com> <87y231qb0m.fsf@meer.lwn.net>
In-Reply-To: <87y231qb0m.fsf@meer.lwn.net>
From:   Alex Shi <seakeel@gmail.com>
Date:   Mon, 7 Feb 2022 15:38:55 +0800
Message-ID: <CAJy-AmmaOrhgOrkkoVWySgHMDPHcNTEmWDNPFzMHbvOLGeAsgg@mail.gmail.com>
Subject: Re: [PATCH] docs/zh_CN: Update zh_CN/accounting/delay-accounting.rst
To:     Jonathan Corbet <corbet@lwn.net>
Cc:     teng sterling <sterlingteng@gmail.com>,
        yong w <yongw.pur@gmail.com>, Alex Shi <alexs@kernel.org>,
        Yanteng Si <siyanteng@loongson.cn>,
        Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>, wang.yong12@zte.com.cn,
        Yang Yang <yang.yang29@zte.com.cn>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 28, 2022 at 2:38 AM Jonathan Corbet <corbet@lwn.net> wrote:
>
> Alex Shi <seakeel@gmail.com> writes:
>
> > Right. The better way is asking Yang Yang to give a reviewed-by in
> > mailing list next time. Otherwise, the private tag can't give a good
> > support.
>
> Agreed with that.
>
> > for this patch. Reviewed-by: Alex Shi <alexs@kernel.org>
>
> Another nice rule of thumb: put Reviewed-by on its own line so that b4
> picks it up :)

Right!
Thanks for reminding me!

>
> Patch applied, thanks.
>
> jon
