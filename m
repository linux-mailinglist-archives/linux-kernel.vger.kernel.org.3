Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 508E0523155
	for <lists+linux-kernel@lfdr.de>; Wed, 11 May 2022 13:19:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234323AbiEKLTe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 May 2022 07:19:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232140AbiEKLT2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 May 2022 07:19:28 -0400
Received: from mail-yb1-xb31.google.com (mail-yb1-xb31.google.com [IPv6:2607:f8b0:4864:20::b31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE71F703C1
        for <linux-kernel@vger.kernel.org>; Wed, 11 May 2022 04:19:27 -0700 (PDT)
Received: by mail-yb1-xb31.google.com with SMTP id v59so3293122ybi.12
        for <linux-kernel@vger.kernel.org>; Wed, 11 May 2022 04:19:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=yQGeRKstKMwle+FFENjDqj/4DWnPwpCL9cdUs5k3wq8=;
        b=cl6G1xs8S2DBnMExmfplmkS+v3ZwHXxin4dhUJqoE+TixyjEpJFSmHj/6I8mWpYkWM
         /ZoJFQlqyvcjR24HJ93y579e3MR2Oy0Do+2rFAYonByg4rWr1eZrCOk5tJdYvvXkvREw
         J7hs16H3XaOmewYXqPuVKzAzHvlGgnGBIMIIs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=yQGeRKstKMwle+FFENjDqj/4DWnPwpCL9cdUs5k3wq8=;
        b=zrwgRplqePZzbjXfEElRjEL1gEACRNgeeKFkFe1hoMsRoSUYrRIKckKzDAUcdfil7A
         66kQgf3y8inmac+Y+FPIbODTuPlvby9nJAocvxgaHKL5EuxoxWZzffgRzMTv/NB/35IV
         hzBFU9XaJE6pGxHqi+PUFqHYDrbjUZgxtrMFdeYKPHNsQLumxo00/nCyWv35T/WkAkSR
         1pmwIlp/YPq8lvAy3HjXL6xAwXuVQ9pGSdnyi4EEuAzb6KE7RQ+WRRlcJ0v4lO9094FU
         hGR9m8/b0M6lnrsJrxAZI5D120G8kffxuXLs3B5bA2bHT5vwRWp0Psmie8CaNV6U2bdo
         XE4Q==
X-Gm-Message-State: AOAM533HWCvMC4msS6ZjmGJUsLJBIsPQdKX7EselatUjL7967FSxajPE
        q9o+IwBgAl992QIgPiNcJ4+Jpoi82s/0f+eNNcNYOQ==
X-Google-Smtp-Source: ABdhPJy6dJ80HM/NWK6pxo9H8JX41aVVI3gTyJa9azUE6OxSQWZloSGluI7DV3dtaIWgbmFLH/QzRxwBbp1tFvNfzdM=
X-Received: by 2002:a25:cfc5:0:b0:647:39d4:49f5 with SMTP id
 f188-20020a25cfc5000000b0064739d449f5mr22874248ybg.595.1652267966978; Wed, 11
 May 2022 04:19:26 -0700 (PDT)
MIME-Version: 1.0
References: <20220511013057.245827-1-dlunev@chromium.org> <CAJfpegsmyY+D4kK3ov51FLGA=RkyGDKMcYiMo2zBqYuFNs78JQ@mail.gmail.com>
 <CAONX=-dqY64VkqF6cNYvm8t-ad8XRqDhELP9icfPTPD2iLobLA@mail.gmail.com>
 <CAJfpegvUZheWb3eJwVrpBDYzwQH=zQsuq9R8mpcXb3fqzzEdiQ@mail.gmail.com>
 <CAONX=-cxA-tZOSo33WK9iJU61yeDX8Ct_PwOMD=5WXLYTJ-Mjg@mail.gmail.com> <CAJfpegsNwsWJC+x8jL6kDzYhENQQ+aUYAV9wkdpQNT-FNMXyAg@mail.gmail.com>
In-Reply-To: <CAJfpegsNwsWJC+x8jL6kDzYhENQQ+aUYAV9wkdpQNT-FNMXyAg@mail.gmail.com>
From:   Daniil Lunev <dlunev@chromium.org>
Date:   Wed, 11 May 2022 21:19:16 +1000
Message-ID: <CAONX=-d9nfYpPkbiVcaEsCQT1ZpwAN5ry8BYKBA6YoBvm7tPfg@mail.gmail.com>
Subject: Re: [PATCH 0/2] Prevent re-use of FUSE superblock after force unmount
To:     Miklos Szeredi <miklos@szeredi.hu>
Cc:     linux-fsdevel@vger.kernel.org,
        fuse-devel <fuse-devel@lists.sourceforge.net>,
        linux-kernel@vger.kernel.org,
        Alexander Viro <viro@zeniv.linux.org.uk>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> At a glance it's a gross hack.   I can think of more than one way in
> which this could be achieved without adding a new field to struct
> super_block.
Can you advise what would be a better way to achieve that?

> But...  what I'd really prefer is if the underlying issue of fuse vs.
> suspend was properly addressed instead of adding band-aids.  And that
> takes lots more resources, for sure, and the result is not guaranteed.
> But you could at least give it a try.
We do have a limited success with userspace level sequencing of processes,
but on the kernel level - it is all quite untrivial, as you mentioned.
I did some
research, and what I found pretty much a 9 years old thread which went
nowhere at the end [1]. We would also prefer if suspend just worked (and
we have a person looking into what is actually breaking with suspend), but
there is an unbounded amount of time for how long the investigation and
search for a solution may be ongoing given the complexity of the problem,
and in the meantime there is no way to work around the problem.

Thanks,
Daniil

[1] https://linux-kernel.vger.kernel.narkive.com/UeBWfN1V/patch-fuse-make-fuse-daemon-frozen-along-with-kernel-threads
