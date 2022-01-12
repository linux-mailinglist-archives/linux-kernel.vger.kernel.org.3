Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 76B4F48BF2F
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jan 2022 08:44:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237688AbiALHn5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Jan 2022 02:43:57 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:49534 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231359AbiALHn4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jan 2022 02:43:56 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 88507B81E06;
        Wed, 12 Jan 2022 07:43:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A7BEFC36AEA;
        Wed, 12 Jan 2022 07:43:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1641973434;
        bh=P4fphtGFF/hVfABFIytuAPP0L5tQIZq8gmY+Nbs2xK4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:From;
        b=occkmkh4v3Dq9b8k6mUnoKo+F98hcecUsaIMFliimpfwiREZBWIuQtHNWMn9ePE+a
         oxbWoq3uDNy3J6YQrN7i87NHXqDNWYA6Dz7dHwRBiBPXIxYMLKZb8xxTDRGIqEc51H
         6krBDPRFTjJHBOatjtldRhPTeYj2anascRn53R2v9VsXFGkzlftDRuqs+z72KGHE4K
         XLX2PTg91K7C1qsuC8Jm6RDkcF+xFUTCyxSvF7xqDmdt28ipOR40SN3Z76PnxMakuo
         83j79CPpvEjFFjpaZs2ELxMfBmpqspRhjXPDAZn0mDzMh47keiOcgFyysUjyUP41bQ
         nY3QqkgD0m1CA==
From:   SeongJae Park <sj@kernel.org>
To:     Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Cc:     SeongJae Park <sj@kernel.org>, Miguel Ojeda <ojeda@kernel.org>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Wedson Almeida Filho <wedsonaf@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Wei Liu <wei.liu@kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        rust-for-linux <rust-for-linux@vger.kernel.org>
Subject: Re: [PATCH v2 for-rust-for-linux] init/Kconfig: Specify the interpreter for rust-version.sh
Date:   Wed, 12 Jan 2022 07:43:51 +0000
Message-Id: <20220112074351.31353-1-sj@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <CANiq72=uZ58gQ5PmF5bXk7f47yGGzeL=WQnNbybeBPDZuQhijA@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 12 Jan 2022 01:32:20 +0100 Miguel Ojeda <miguel.ojeda.sandonis@gmail.com> wrote:

> On Mon, Jan 10, 2022 at 11:13 AM Miguel Ojeda
> <miguel.ojeda.sandonis@gmail.com> wrote:
> >
> > Picking it up, thanks!
> 
> This is now in linux-next (Jan 11) -- hopefully it is now better for you!

Confirmed that, thank you! :)

> 
> I will carry the patch in our rust-next branch but I won't put it in
> the patch series, this way we won't need to revert it when merged into
> mainline.

Sure.  Looking forward to the day!


Thanks,
SJ

> 
> Cheers,
> Miguel
