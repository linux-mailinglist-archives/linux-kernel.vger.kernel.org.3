Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C011B4B10FF
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Feb 2022 15:54:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243241AbiBJOyO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Feb 2022 09:54:14 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:40974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242942AbiBJOyL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Feb 2022 09:54:11 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C09DD96
        for <linux-kernel@vger.kernel.org>; Thu, 10 Feb 2022 06:54:12 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 7B622B8255A
        for <linux-kernel@vger.kernel.org>; Thu, 10 Feb 2022 14:54:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2B9F2C36AE5
        for <linux-kernel@vger.kernel.org>; Thu, 10 Feb 2022 14:54:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1644504850;
        bh=Wrhb3S8klJMz7NSMKYsAwfxDSgIdAnsOXa1GaJGwWaY=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=a4YfbtS1KvUvU6nfp0IwQ8+mC6ESwTt90uNo6ti2F4AKAnQ/jwjcuOprh00Ok0U87
         /UiO9cET38+oBC25XZq8xjPVI3Wk5aQZkXr9MNGsCFwfR79gFf3Pq4iUCs5sNAnUIH
         FE46ACvAC5C7Q3WG1zXYs0PXb5gtPiUxeok2e5nOxqUxyCuTNyckIpPEXgj6sni+Mn
         BTercxk7Imz/tgfmmWlAul6rCFCO9FdOKAmb8l+X9CI8gz3IM3EvOG8+BPF4ieBKsF
         hPGVp/xH+yP3Li66fwOuiGAKKQ52cRc4xCJJnuI1RBswop35CdT06uzI+TtR0FlXjk
         bzf7bwTeMPjqA==
Received: by mail-wr1-f41.google.com with SMTP id d27so6267800wrb.5
        for <linux-kernel@vger.kernel.org>; Thu, 10 Feb 2022 06:54:10 -0800 (PST)
X-Gm-Message-State: AOAM533VilRaElI7QAZwQzdDt/NGD0sNzkL7SPXBYEurm4/YIDlpGoWa
        bKQqysjW40tJOUpzZiGTqJKrZJqmGkOx5aeX46E=
X-Google-Smtp-Source: ABdhPJzaJB9Niq44mEYYsJklBWapq7kpEFilLrqbVHVir+q/Z6Ea2Uly7fMWC9EYl7cD4AKnrUSa3rJF5KYMwX2/PPg=
X-Received: by 2002:a05:6000:3c6:: with SMTP id b6mr6520953wrg.12.1644504848550;
 Thu, 10 Feb 2022 06:54:08 -0800 (PST)
MIME-Version: 1.0
References: <20220209144910.1484686-1-arnd@kernel.org> <80c6df0717014472aa81093ae3894d39@AcuMS.aculab.com>
 <CAK8P3a3tZEc30AaiNENbHKf8+x5VOw7Q=4dVDMNwz0F6+v9YrQ@mail.gmail.com> <cc2a0d0eb77b4ace872263db7bf0c115@AcuMS.aculab.com>
In-Reply-To: <cc2a0d0eb77b4ace872263db7bf0c115@AcuMS.aculab.com>
From:   Arnd Bergmann <arnd@kernel.org>
Date:   Thu, 10 Feb 2022 15:53:52 +0100
X-Gmail-Original-Message-ID: <CAK8P3a1v37=1Knrctnvqrb-igMsAvwPySFkzYfFvtLrb3DOzHQ@mail.gmail.com>
Message-ID: <CAK8P3a1v37=1Knrctnvqrb-igMsAvwPySFkzYfFvtLrb3DOzHQ@mail.gmail.com>
Subject: Re: [PATCH] microblaze: remove CONFIG_SET_FS
To:     David Laight <David.Laight@aculab.com>
Cc:     Michal Simek <monstr@monstr.eu>,
        Christoph Hellwig <hch@infradead.org>,
        Arnd Bergmann <arnd@arndb.de>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 10, 2022 at 3:21 PM David Laight <David.Laight@aculab.com> wrote:
> From: Arnd Bergmann Sent: 10 February 2022 13:30
>
> > static inline int __range_ok(unsigned long addr, unsigned long size)
> > {
> >         return size <= TASK_SIZE && addr <= (TASK_SIZE - size);
> > }
> >
> > since 'size' is usually constant, so this turns into a single comparison
> > against a compile-time constant.
>
> Hmmm... maybe there should be a comment that it is the same as
> the more obvious:
>         (addr <= TASK_SIZE && addr <= TASK_SIZE - size)
> but is better for constant size.
> (Provided TASK_SIZE is a constant.)
>
> I'm sure Linus was 'unhappy' about checking against 2^63 for
> 32bit processes on a 64bit kernel.
>
> Hmmm compat code that has 32bit addr/size needn't even call
> access_ok() - it can never access kernel memory at all.

I suppose the generic function should compare against
TASK_SIZE_MAX or user_addr_max() then, to make it a
constant while TASK_SIZE potentially depends on compat
mode.

        Arnd
