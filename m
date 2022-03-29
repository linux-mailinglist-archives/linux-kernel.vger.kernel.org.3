Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2F7F64EA8CE
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Mar 2022 09:53:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233646AbiC2Hwd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Mar 2022 03:52:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233635AbiC2Hw3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Mar 2022 03:52:29 -0400
Received: from mail-ua1-x92a.google.com (mail-ua1-x92a.google.com [IPv6:2607:f8b0:4864:20::92a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A84320A3A5
        for <linux-kernel@vger.kernel.org>; Tue, 29 Mar 2022 00:50:45 -0700 (PDT)
Received: by mail-ua1-x92a.google.com with SMTP id o26so7335863uap.4
        for <linux-kernel@vger.kernel.org>; Tue, 29 Mar 2022 00:50:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linbit-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Oq+Z6jNlZq+ZQofugfp2fRT6ds4wfKxot/aZdwn2WhA=;
        b=yZhdVjxwh2/m5mbLgEngbkgE3G3gnxZFRf1jW13GjQM5F98zv7M82fzW8oKWfZSKUF
         kluYlmO7/djcCa8os2SM3k7YOg+loZt0FPygDR9ComSmwQxnkNHbWxildLYxmsKVkXDb
         DxyJesNbu7I7TwfK9xMRH1fit0kbIQ3DRgi3aOoe33j4XbntfXHuMGxiZBbsCdhlaCMt
         3Jq20be/b7HvMOVMr9CZHcCAcpxSR6s3i7RaHeD3ZZSZr1s+cG8i8RIe7mqtt2RRtCgS
         u51da3zY7RvzdQZihKHdUI5EDco+FytktD3YVJYkeoz/wes7UkclKvRM1J8sV6BlmVgt
         nVcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Oq+Z6jNlZq+ZQofugfp2fRT6ds4wfKxot/aZdwn2WhA=;
        b=bBSk9GjVgia1buCHejkrcVuHvxTYcOFEQYJ87VhDmPj2kH8pgn+0V8r/3KXjoGOu7p
         /Jq9decUhxVK2Lmw9uslh68vnyETtbLJ51nDC4rLUfJODpNFO4fkhtlAMblXdh5Xivfl
         fxhvQRsyHv7OV24vkEXbuh/oYlhmthzTQv91BhZmOM0AUIqXA4i9bh84/mp7FAdt26Tu
         yS2Gy2nWDuA2VmcF/f3MR7Ro9dk1mBCdE0AKD+LFKbv+KNdBHwbbYF9SiQzsAepr7KBk
         qotkEdFZNc4mS4ANQJiDeSBt8mYsqsewIZmVR+P6iTZ5a6qyXL6TkGYX8GVtdONWr0T8
         O6Rw==
X-Gm-Message-State: AOAM5331dUJpHhczopIEDjkcIw/I7BgNEtFX4E3EoTGfyf2L12sAtxWT
        okyPHRW76+OaXsWSlPulDXNFFb/jFGXEXBB7boRJuBH99W4=
X-Google-Smtp-Source: ABdhPJw5plfdPb+L2JPLk102d32wrj5zplTwmUxFp7a5XaOP/QkyG0KqpejT+kgULLuf4pgaK9Mu7q3gz8Vv5zQqzws=
X-Received: by 2002:ab0:6c48:0:b0:359:cfea:c24f with SMTP id
 q8-20020ab06c48000000b00359cfeac24fmr9497635uas.104.1648540244878; Tue, 29
 Mar 2022 00:50:44 -0700 (PDT)
MIME-Version: 1.0
References: <20220329070618.GA20396@lst.de> <CADGDV=UgjZAbmAN-2bO1nyDvA=XCC9Lf2dxWHZ0BwxF12nnztQ@mail.gmail.com>
 <20220329073254.GA20691@lst.de>
In-Reply-To: <20220329073254.GA20691@lst.de>
From:   Philipp Reisner <philipp.reisner@linbit.com>
Date:   Tue, 29 Mar 2022 09:50:33 +0200
Message-ID: <CADGDV=U5jwe0CZ12174cMahfD_h-GsBswWaA1VOJbHaC1nsrUw@mail.gmail.com>
Subject: Re: state of drbd in mainline
To:     Christoph Hellwig <hch@lst.de>
Cc:     Lars Ellenberg <lars.ellenberg@linbit.com>,
        Jens Axboe <axboe@kernel.dk>, drbd-dev@lists.linbit.com,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
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

> The complete lack of bug reports and maintainer interaction usually
> suggests low to no use and heavy bitrot.  If that is not the case
> here that's fine, just asking..
>

FYI, feature-wise the in-tree DRBD is frozen. Maintenance only. Users,
seeking advanced
features switch to the out-of-tree DRBD and use other means of communication:
Github issues, linbit's community slack channel, last not least
linbit's ticketing system.

That is why you see virtually no activity.
