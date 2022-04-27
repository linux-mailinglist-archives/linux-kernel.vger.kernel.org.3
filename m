Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C180F511574
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Apr 2022 13:33:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232866AbiD0L3t (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Apr 2022 07:29:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232854AbiD0L3r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Apr 2022 07:29:47 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE0D934667
        for <linux-kernel@vger.kernel.org>; Wed, 27 Apr 2022 04:26:35 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 6CC4E210E4;
        Wed, 27 Apr 2022 11:26:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1651058794; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=/lbZNmZS8vmzUpyY0Qd4BWSK57etcLEy5Y/QnHt1MtM=;
        b=SbLxY8/qbJCmFyGqre9A3eLh6M1qsHwvi7yt4J/VJQlhjWdkMpCrS2otaukqANxj6iOFaC
        PfyFUtJn+hGHjte/jk/Y1AYHXQs8bR17NMb4Jlf3cfBPvBR+1ChIP0ZMVNuj5Gp7KsSE0v
        9omh7djvzWeWqZceBa4UDAudiibb8Es=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1651058794;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=/lbZNmZS8vmzUpyY0Qd4BWSK57etcLEy5Y/QnHt1MtM=;
        b=LJHsFPbT/rnnQl/5gnU7+8ScRsjAYQwlj6dglR0uxCQy89dKwLiAUCMQsMQ/X72mIOxG/H
        bLYwdb0xsXFO/9Dg==
Received: from kunlun.suse.cz (unknown [10.100.128.76])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 4D6142C141;
        Wed, 27 Apr 2022 11:26:34 +0000 (UTC)
Date:   Wed, 27 Apr 2022 13:26:33 +0200
From:   Michal =?iso-8859-1?Q?Such=E1nek?= <msuchanek@suse.de>
To:     Dan Williams <dan.j.williams@intel.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux NVDIMM <nvdimm@lists.linux.dev>
Subject: Re: ndctl tests usable?
Message-ID: <20220427112633.GK163591@kunlun.suse.cz>
References: <20220426123839.GF163591@kunlun.suse.cz>
 <CAPcyv4j66HAE_x-eAHQR71pNyR0mk5b463S6OfeokLzZHq5ezw@mail.gmail.com>
 <20220426161435.GH163591@kunlun.suse.cz>
 <CAPcyv4iG4L3rA3eX-H=6nVkwhO2FGqDCbQHB2Lv_gLb+jy3+bw@mail.gmail.com>
 <20220426163834.GI163591@kunlun.suse.cz>
 <CAPcyv4jUj3v+4Sf=1i5EjxTeX9Ur65Smib-vkuaBdKYjUrh7yA@mail.gmail.com>
 <20220426180958.GJ163591@kunlun.suse.cz>
 <CAPcyv4hr1LDaAXCOrfub1eys=OcQXAPYv2dHGzwbY7pt=_fKZQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAPcyv4hr1LDaAXCOrfub1eys=OcQXAPYv2dHGzwbY7pt=_fKZQ@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 26, 2022 at 11:22:55AM -0700, Dan Williams wrote:
> On Tue, Apr 26, 2022 at 11:10 AM Michal Suchánek <msuchanek@suse.de> wrote:
> >
> > On Tue, Apr 26, 2022 at 09:47:19AM -0700, Dan Williams wrote:
> > > On Tue, Apr 26, 2022 at 9:43 AM Michal Suchánek <msuchanek@suse.de> wrote:
> > > >
> > > > On Tue, Apr 26, 2022 at 09:32:24AM -0700, Dan Williams wrote:
> > > > > On Tue, Apr 26, 2022 at 9:15 AM Michal Suchánek <msuchanek@suse.de> wrote:
> > > > > >
> > > > > > On Tue, Apr 26, 2022 at 08:51:25AM -0700, Dan Williams wrote:
> > > > > > > On Tue, Apr 26, 2022 at 5:39 AM Michal Suchánek <msuchanek@suse.de> wrote:
> > > > > > > >
> > ...
> > > > >
> > > > > The modinfo just tells you what modules are available, but it does not
> > > > > necessarily indicate which modules are actively loaded in the system
> > > > > which is what ndctl_test_init() validates.
> > > >
> > > > Isn't what modinfo lists also what modrobe loads?
> > >
> > > It shows what modprobe would load on the next invocation, but
> > > sometimes when nfit_test fails it's because the initramfs or something
> > > else loaded the modules without respecting the extra/ (or updates/ in
> > > your case) override modules.
> > >
> > > > There isn't any pmem so I don't see why production modules would be
> > > > loaded before the test modules are installed. Unloading the modules
> > > > first does not really make any difference.
> > >
> > > Ok, my first guess was wrong... would need more debug to see what
> > > those other skip tests are complaining about.
> >
> > There was also missing parted and hostname command.
> >
> > However, the nfit.ko is detected as production even when I remove all
> > the production modules just in case. lsmod confirms that the nvdimm
> > modules are not loaded before the test.
> >
> > Maybe something goes wrong with the test module build?
> >
> > It is very fragile and requires complete kernel source for each
> > configuration built. See below for the package
> >
> > https://build.opensuse.org/package/show/home:michals/nfit_test
> >
> > Attaching the log of test run which does not report any missing tools,
> > only complains about nfit.ko being production.
> 
> Oh... something silly, ndctl_test_init() assumes that the out-of-tree
> module directory is always "/lib/modules/$(uname -r)/extra"
> 
>                 if (!strstr(path, "/extra/")) {
>                         log_err(&log_ctx, "%s.ko: appears to be
> production version: %s\n",
>                                         name, path);
>                         break;
>                 }
> 
> Looks like a build configuration variable is needed there to allow for
> "updates/".

yes, I could also change the path in the package to match this
expactation. Not sure if that would break something else.

There is one last bit: the tests require at least 1GB of ram, or
specifically the default VM with 512MB is not sufficient.

With that only monitor test fails, and some BTT test is skipped because
the 5.17 kernel supposedly does not have the correct support:

[  182s] 19/23 ndctl:ndctl / monitor.sh             FAIL 6.39s   exit status 1
[  182s] 
[  182s] 
[  182s] Ok:                 21  
[  182s] Expected Fail:      0   
[  182s] Fail:               1   
[  182s] Unexpected Pass:    0   
[  182s] Skipped:            1   
[  182s] Timeout:            0   

Thanks

Michal

