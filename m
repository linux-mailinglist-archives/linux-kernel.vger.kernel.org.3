Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9CCC249D2DB
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jan 2022 20:54:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244587AbiAZTy4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jan 2022 14:54:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244558AbiAZTy4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jan 2022 14:54:56 -0500
Received: from mail-qv1-xf33.google.com (mail-qv1-xf33.google.com [IPv6:2607:f8b0:4864:20::f33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0EF0C06173B
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jan 2022 11:54:55 -0800 (PST)
Received: by mail-qv1-xf33.google.com with SMTP id o9so787537qvy.13
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jan 2022 11:54:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :content-transfer-encoding;
        bh=/b9yrYylsR3IXw2MBkgKmnslMTaks1EUQq+pWFo3vMU=;
        b=jIM+Tc+JfN7AxN6yCV944hevmEwbziOmVrsSDKFKhxcK5czEdfwuGa1+JKEm5p153D
         slLmda6m/yCZO8ZIHlLZl6IqweIwHdlxDpwmS9sacFA2fhuXmFY8LEFoX+85O/+Bx4OE
         iGciw+hNYyVKtUVlJOaV2lZ+sKD0MAsMcI/LQl+lQZdZ70jf6CnR8vIw7OtQFvUwfrZJ
         lhlzFUgt9mOyvy8aEn4Oyx65EgV/2T/N1fYGTTkn2R2iHkCpwr0QXQR7i6xi6krzpt4Q
         B7QgV0Cbl2yPbyxMuyZmyWX6EsCRk/5btemPGasR9kB/RKqdVkmYF45VVp+Q7EiGvBjs
         T3MQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:content-transfer-encoding;
        bh=/b9yrYylsR3IXw2MBkgKmnslMTaks1EUQq+pWFo3vMU=;
        b=L1mQJUb92rZ8A0zkqXmsWpSqP0W+Wk5Wn1FUY7NlbR5uBEkAvbk+iaTU/y7fhj+3QW
         5gYIk2eNumL85G/G5y7FbP2nZEAMw2UxO9C74OMIqk3/kNRen9lp2d+RW2QmyzcKiMGp
         mrzbbjUVEbs86qFl1ZeduV6dtC/cvn4d4ET4PkTt+ChDSD3HpFsk4z54lkWFS3gsOd4/
         sYgSadWNuztjUEBbAtob81WB87lhkbRJXLBIu8COCndrVHHcdwjL1tlk2cccUoIqZ1Ef
         xuScKScVXet/mBwGzbcHl5RcKqq8sceEqa/kXOl9U6JTJHb5BsYS2t+1edzM8XGyXAA5
         Oj1w==
X-Gm-Message-State: AOAM531Yiioc+THdErGdX5biUoHHnJ+uUkFc/H+cEBqZM2xVsb8chtoB
        ZGbyEbuHhuQPN6R+fGGPC8mWWA==
X-Google-Smtp-Source: ABdhPJzDiy8lWJPalTqmHodK4vLPsn5OI+iOGQeHou4Hn9uAp27KEpv7ql8yuu4Af0KUxh9Hg0NE3g==
X-Received: by 2002:a05:6214:e45:: with SMTP id o5mr364368qvc.10.1643226894754;
        Wed, 26 Jan 2022 11:54:54 -0800 (PST)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id bs33sm148633qkb.103.2022.01.26.11.54.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Jan 2022 11:54:54 -0800 (PST)
Date:   Wed, 26 Jan 2022 14:54:53 -0500
From:   Josef Bacik <josef@toxicpanda.com>
To:     lsf-pc@lists.linuxfoundation.org
Cc:     linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        linux-block@vger.kernel.org, linux-scsi@vger.kernel.org,
        linux-nvme@lists.infradead.org, bpf@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: LSF/MM/BPF: 2022: Call for Proposals
Message-ID: <YfGnDRM/Pe4jzbSr@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The annual Linux Storage, Filesystem, Memory Management, and BPF
(LSF/MM/BPF) Summit for 2022 will be held from May 2 to May 4 at The
Margaritaville Resort Palm Springs in Palm Springs, California.
LSF/MM/BPF is an invitation-only technical workshop to map out
improvements to the Linux storage, filesystem, BPF, and memory
management subsystems that will make their way into the mainline kernel
within the coming years.

COVID is at the front of our minds as we attempt to put together the
best and safest conference we can arrange.  The logistics of how to hold
an in person event will change and evolve as we get closer to the actual
date, but rest assured we will do everything recommended by public
health officials.

LSF/MM/BPF 2022 will be a three day, stand-alone conference with four
subsystem-specific tracks, cross-track discussions, as well as BoF and
hacking sessions.

On behalf of the committee I am issuing a call for agenda proposals
that are suitable for cross-track discussion as well as technical
subjects for the breakout sessions.

If advance notice is required for visa applications then please point
that out in your proposal or request to attend, and submit the topic as
soon as possible.

This years instructions are similar to our previous attempts.  We're
asking that you please let us know you want to be invited by March 1,
2022.  We realize that travel is an ever changing target, but it helps
us get an idea of possible attendance numbers.  Clearly things can and
will change, so consider the request to attend deadline more about
planning and less about concrete plans.

1) Fill out the following Google form to request attendance and
suggest any topics

	https://forms.gle/uD5tbZYGpaRXPnE19

In previous years we have accidentally missed people's attendance
requests because they either didn't cc lsf-pc@ or we simply missed them
in the flurry of emails we get.  Our community is large and our
volunteers are busy, filling this out will help us make sure we don't
miss anybody.

2) Proposals for agenda topics should still be sent to the following
lists to allow for discussion among your peers.  This will help us
figure out which topics are important for the agenda.

        lsf-pc@lists.linux-foundation.org

and CC the mailing lists that are relevant for the topic in question:

        FS:     linux-fsdevel@vger.kernel.org
        MM:     linux-mm@kvack.org
        Block:  linux-block@vger.kernel.org
        ATA:    linux-ide@vger.kernel.org
        SCSI:   linux-scsi@vger.kernel.org
        NVMe:   linux-nvme@lists.infradead.org
        BPF:    bpf@vger.kernel.org

Please tag your proposal with [LSF/MM/BPF TOPIC] to make it easier to
track. In addition, please make sure to start a new thread for each
topic rather than following up to an existing one. Agenda topics and
attendees will be selected by the program committee, but the final
agenda will be formed by consensus of the attendees on the day.

We will try to cap attendance at around 25-30 per track to facilitate
discussions although the final numbers will depend on the room sizes
at the venue.

For discussion leaders, slides and visualizations are encouraged to
outline the subject matter and focus the discussions. Please refrain
from lengthy presentations and talks; the sessions are supposed to be
interactive, inclusive discussions.

There will be no recording or audio bridge. However, we expect that
written minutes will be published as we did in previous years:

2019: https://lwn.net/Articles/lsfmm2019/

2018: https://lwn.net/Articles/lsfmm2018/

2017: https://lwn.net/Articles/lsfmm2017/

2016: https://lwn.net/Articles/lsfmm2016/

2015: https://lwn.net/Articles/lsfmm2015/

2014: http://lwn.net/Articles/LSFMM2014/

3) If you have feedback on last year's meeting that we can use to
improve this year's, please also send that to:

        lsf-pc@lists.linux-foundation.org

Thank you on behalf of the program committee:

        Josef Bacik (Filesystems)
        Amir Goldstein (Filesystems)
        Martin K. Petersen (Storage)
        Omar Sandoval (Storage)
        Michal Hocko (MM)
        Dan Williams (MM)
        Alexei Starovoitov (BPF)
        Daniel Borkmann (BPF)
