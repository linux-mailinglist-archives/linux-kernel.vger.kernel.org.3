Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 48A7D462385
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Nov 2021 22:41:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231403AbhK2Voy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Nov 2021 16:44:54 -0500
Received: from ms.lwn.net ([45.79.88.28]:53550 "EHLO ms.lwn.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231929AbhK2Vmw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Nov 2021 16:42:52 -0500
Received: from localhost (unknown [IPv6:2601:281:8300:104d::5f6])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id 776D1221;
        Mon, 29 Nov 2021 21:39:34 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net 776D1221
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
        t=1638221974; bh=KUWR2wrj1GBdUBCsyEtNF7J8KqKNmk27V80VSJG77ks=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=Rp2HE8FFknHIUzRL8icxKz5Zt4SB0dYyXIEqH1losWDIOwOp4WRceSggyk92M4yEu
         xw+Yln75m+92lkzuRgJF1E67MJz33DMSf6I605O86XE7Xo9HWdsWBojOsFrm2xPXh/
         E1Y3KqVLz7GTqetSwuZgjM8e4XW2EssoklObCjWtHZa1BTFFUfl9PfxBe6Ydbiq7ej
         FTz4YpxmfG1MD7amBMVlGB4P18guxrJyMnnWnZiEcGDxIDyvq26LV2hBohxvhzlgi/
         TZAVsOfW7310igQkjy3NMcty1aJt0MpLtN05lZUuHd3ZsTD3YHqxgUWV/wjhBFrm1M
         IXgwTatPjHRgw==
From:   Jonathan Corbet <corbet@lwn.net>
To:     Akira Yokosawa <akiyks@gmail.com>,
        Joel Colledge <joel.colledge@linbit.com>
Cc:     Philipp Reisner <philipp.reisner@linbit.com>,
        Lars Ellenberg <lars.ellenberg@linbit.com>,
        drbd-dev@lists.linbit.com, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] docs: admin-guide/blockdev: Remove digraph of
 node-states
In-Reply-To: <7df04f45-8746-e666-1a9d-a998f1ab1f91@gmail.com>
References: <7df04f45-8746-e666-1a9d-a998f1ab1f91@gmail.com>
Date:   Mon, 29 Nov 2021 14:39:33 -0700
Message-ID: <87sfvesktm.fsf@meer.lwn.net>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Akira Yokosawa <akiyks@gmail.com> writes:

> While node-states-8.dot has two digraphs, the dot(1) command can
> not properly handle multiple graphs in a DOT file and the
> kernel-doc page at
>
>     https://www.kernel.org/doc/html/latest/admin-guide/blockdev/drbd/figures.html
>
> fails to render the graphs.
>
> It turned out that the digraph of node_states can be removed.
>
> Quote from Joel's reflection:
>
>     On reflection, the digraph node_states can be removed entirely.
>     It is too basic to contain any useful information. In addition
>     it references "ioctl_set_state". The ioctl configuration
>     interface for DRBD has long been removed. In fact, it was never
>     in the upstream version of DRBD.
>
> Remove node_states and rename the DOT file peer_states-8.dot.
>
> Suggested-by: Joel Colledge <joel.colledge@linbit.com>
> Signed-off-by: Akira Yokosawa <akiyks@gmail.com>
> Cc: Philipp Reisner <philipp.reisner@linbit.com>
> Cc: Lars Ellenberg <lars.ellenberg@linbit.com>

Applied, thanks.

jon
