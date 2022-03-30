Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 064F14EC829
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Mar 2022 17:24:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348155AbiC3PZp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Mar 2022 11:25:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348145AbiC3PZm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Mar 2022 11:25:42 -0400
Received: from mail-vk1-xa2d.google.com (mail-vk1-xa2d.google.com [IPv6:2607:f8b0:4864:20::a2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11CCF55BE9
        for <linux-kernel@vger.kernel.org>; Wed, 30 Mar 2022 08:23:56 -0700 (PDT)
Received: by mail-vk1-xa2d.google.com with SMTP id p143so11748685vkf.5
        for <linux-kernel@vger.kernel.org>; Wed, 30 Mar 2022 08:23:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linbit-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=BLYncbAZMOiJKAipKssMlulVwN4gsXJDU6wQcnVJrcI=;
        b=ZXWqagMRJZx5ZagPoe2qFheb0tGHoohxT6qiA5JHf1K4MEDSLioqew2vwYPmpw0qT0
         dVl7r56RXDAQ1nV9jyghhad4bMzLfEV2w4qkrZhDAit+ZzuL/l6O9YgkNgBe7JqlwIls
         bINQGGfGnUL1z98DHedbHxloKuIamQP6iwtbY9vPpqIOQ1q3qv6W7OWzwImtmxMzjR1Q
         uTQL/JyGXmkUbs0GzRlP6HspkQA2ozIlGB5U7fbtvxicCQLGIX1wBDWFtSjGPKNb+3nZ
         aocqP2D3ncBkxRXq4v2V2jztFUg0K76AD4vRJSMn3JFp+5O9ZA6PNgfnRwoKs+ZFSyx3
         4bRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=BLYncbAZMOiJKAipKssMlulVwN4gsXJDU6wQcnVJrcI=;
        b=jiGpCvnjcRLSK2Weqs3QXzHQb9InqAMV3sz2b5WHsTLWt5JsKDxbTd+O4KsZ09b53v
         0EnjqMU4SErFNMGQ2hjwz8xiHo1/UYaPxSKmUxealpYe6UgAcpYc7MNlF2luFGTFzps5
         a2XOdP/8fJciXnfvHl8FD5CKWneKE4KVs8w3sipoc+tiXXUlZuRw6ExF+CsLLQWi2UNM
         XyfxNPqNyGxSeZBpgZiuBEBu5gI7w6JN2Y5q7YGmSZE7KFS599Lj0/92M3obDC14p4hu
         pbT2zOpDPqNwzQeYwHmF7FASZnrUl/2UfV9zRpvW4cPc7u7p7K7Nt/fmoGF07zzXa1kb
         T4wQ==
X-Gm-Message-State: AOAM531MF/tbdvavt4W2V/5WmdMM8E4l3MF3ZsiQ9v0K2gSvMeWGV0jM
        m6lkd3kC4HlgsBFq+TwSR468R0UIQZ/M5lj7f4NhFA==
X-Google-Smtp-Source: ABdhPJyazN6J/DokQyWBzXDLtEfX/3PUb7ZFV2DTUEmghAQI5hs1C+qZwYX9ZfGlyQTOGDTxKDsFVc2cTbaIwVC7gl8=
X-Received: by 2002:a1f:6a82:0:b0:33f:7eeb:5989 with SMTP id
 f124-20020a1f6a82000000b0033f7eeb5989mr21102144vkc.29.1648653835147; Wed, 30
 Mar 2022 08:23:55 -0700 (PDT)
MIME-Version: 1.0
References: <20220329070618.GA20396@lst.de> <CADGDV=UgjZAbmAN-2bO1nyDvA=XCC9Lf2dxWHZ0BwxF12nnztQ@mail.gmail.com>
 <20220329073254.GA20691@lst.de> <CADGDV=U5jwe0CZ12174cMahfD_h-GsBswWaA1VOJbHaC1nsrUw@mail.gmail.com>
 <f9d89282-3a67-ad97-149f-52325e23607c@kernel.dk> <CADGDV=WN2TFR6dO7ZdiQ2ijPjs+7HSsvk0ZCHsHj6ZG5t-oEdA@mail.gmail.com>
 <3c42b1ed-7c03-64e6-409e-e92247288cac@kernel.dk>
In-Reply-To: <3c42b1ed-7c03-64e6-409e-e92247288cac@kernel.dk>
From:   Philipp Reisner <philipp.reisner@linbit.com>
Date:   Wed, 30 Mar 2022 17:23:44 +0200
Message-ID: <CADGDV=WcTSSC70yG61dazo-WyoLOzp3r+nOk-Eg2x_Ncx=3nRg@mail.gmail.com>
Subject: Re: state of drbd in mainline
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Christoph Hellwig <hch@lst.de>,
        Lars Ellenberg <lars.ellenberg@linbit.com>,
        drbd-dev@lists.linbit.com, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> > Jens, my intention is to keep it in-tree, and at some point update it.
> > Regarding your questions:
>
> That'd be great, but it's been years since there was any significant
> updates to the in-kernel drbd... I would strongly suggest that the
> in-kernel be brought closer to what people are mostly running, as it
> stands it's basically unmaintained.

The changes we worked on over many Years in the more recent drbd-9.x
branches are just too fundamental to do them in small chunks, we could
upstream bit by bit.  We need to get that reviewed in a big series.  If I
started to dump them on linux-block right away, nobody would look at it
seriously, since it would be too much.  I intend to get people from red
hat/suse assigned to do such a review. Then we will do that on linux-block,
so that everyone who cares sees what happens.

[...]
> The main discrepancy here is that there are apparently huge numbers of
> in-tree users, yet no fixes or patches at all making it to mainline.
> Either drbd is bug free and doesn't require any fixes at all, which I
> very much would doubt, or fixes aren't being sent upstream.

It is the broad consent among the users of the drbd-8.4 branch (that is what
is in-tree), is that it works for its purpose. It is for sure not bug-free,
but people are not running into bugs anymore. So, call it free of relevant
bugs, if you want.  No new features go into that branch, on purpose. To keep
it that way.

Have a look at that one real bug-fix that was identified in the last Year.
https://patchwork.kernel.org/project/linux-block/patch/20210426163032.3454129-1-christoph.boehmwalder@linbit.com/

When do you want to have that reposted to you?
right now? Just before the next merge window opens?
