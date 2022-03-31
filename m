Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7C6D04EDFB2
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Mar 2022 19:34:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231351AbiCaRfj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 31 Mar 2022 13:35:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231313AbiCaRfi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Mar 2022 13:35:38 -0400
Received: from out5-smtp.messagingengine.com (out5-smtp.messagingengine.com [66.111.4.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3532656C12;
        Thu, 31 Mar 2022 10:33:48 -0700 (PDT)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.nyi.internal (Postfix) with ESMTP id 4CEC65C01F0;
        Thu, 31 Mar 2022 13:33:46 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute5.internal (MEProxy); Thu, 31 Mar 2022 13:33:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=anarazel.de; h=
        cc:cc:content-type:date:date:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to; s=fm1; bh=PwYhrtBILCwKQQwACdj9E0hN1reoXLuXM4GNYp
        6BBNo=; b=Kihow+nh39VTZ8m+1FkTo3bI0iKf0P0sA0MNJIWMMGl3xLjqUpSDPH
        +VSpuSHvl9iaUNdkaX/5IFd81r84sXwnihB0wr5lB6uJ207cOGQciJUyWfkJwjOd
        mrCPfLezNjqUBXtx6ZOA6Rx7BKN05SzY6EcRAAKHKBlFHzS8vKF+RypMiSJUY3O6
        rOrgzvmnCqNNcWZP2ubD4pEcfkk695iqm4GbCtZIXniIyN+BQ5ITlAyj65YZSlul
        gFckzfhP8XLMDmFIrZuwYYp0DzcnYBVFnz2vdM8em6UEbnczr916DJcmAIwoh6qf
        70D5JXnSz8Mw6lxWEEPfgOjKFcoADGeg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm3; bh=PwYhrtBILCwKQQwAC
        dj9E0hN1reoXLuXM4GNYp6BBNo=; b=I9t3BZvZRa21JcYXNNDhqhLcgTBJ7tFpg
        hPPZXri+kPIMBBdu1BL8FJLATM+RknWGo1df5RO5tlJomcAxa4OCSU2XEgzFbEmM
        VKr0x2tNIvVSCcBQpB+UkUyJa7P4iKuMeZtZ0hET0js1fGgj/JTljUK9nyW1R9cr
        vmJrYHuYA2WL8n16ArlgPQe87Vh4kQnV9YseEwA3GPybiFcORZD0TXgsbuwicg1K
        EHBHLPp3ugnZ31oO6whI+DYZpTV3wcKnPXAyjrmtN/xKfNyXiKLCiyLK6uMy8LWe
        SXYTvJkhZWQ/zjdp4ClqTdDgNXD5omTRrimtP0L4d1dBpOhy+zpjw==
X-ME-Sender: <xms:-eVFYinerVmoiWjitEf0BkdNLJbesDylHzp-D6W7Fy9AucCyBXQKjA>
    <xme:-eVFYp2JYgiabSLn3jh0HAr8AP4z0X1gdK7wyenk3tsqfnH9hXtLHb1rE1Ulg5XAA
    uABknbr7XU7o6BAbg>
X-ME-Received: <xmr:-eVFYgr-sxNxz70M2NWByMpRowBO2g1AtuIO9nq_jV3K91HdKa9zocwTN8rNewIJl1dUXBgmW4EoLXlhGk8AlwhRx1voFPuw_XVqOzkkabIBPIilkCNHYjY5qCUZ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvvddrudeigedguddugecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpeffhffvuffkfhggtggujgesthdtredttddtvdenucfhrhhomheptehnughr
    vghsucfhrhgvuhhnugcuoegrnhgurhgvshesrghnrghrrgiivghlrdguvgeqnecuggftrf
    grthhtvghrnhepvdfhieejvdevheehjeegvefhheektefhleeihfeuheelgfdtjeeludei
    hfeuudejnecuffhomhgrihhnpehkvghrnhgvlhdrohhrghdptghirhhruhhsqdgtihdrtg
    homhenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegr
    nhgurhgvshesrghnrghrrgiivghlrdguvg
X-ME-Proxy: <xmx:-eVFYmmS-zvcyktGUt0gBz4Syzx-g22uqED6Tqvxacr7tNiLNf8LOQ>
    <xmx:-eVFYg1xt9Lip9BxkZNo07TbI7mOotui4mPUh0285JTXHyhxZn9Wvw>
    <xmx:-eVFYttsj4aMAfEh8qCHmazqe_lOgbLawMIhkImr87eGQ5SZy-8Dgg>
    <xmx:-uVFYltsFvthkqYBOdDk5gBunPCdwYaiipKz1fUU7j-y3RINzyclAQ>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 31 Mar 2022 13:33:45 -0400 (EDT)
Date:   Thu, 31 Mar 2022 10:33:44 -0700
From:   Andres Freund <andres@anarazel.de>
To:     Matthieu Baerts <matthieu.baerts@tessares.net>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        John Garry <john.garry@huawei.com>, mptcp@lists.linux.dev,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH perf] perf tools: .git/ORIG_HEAD might not exist
Message-ID: <20220331173344.xvhp4yi67fv6p6t5@alap3.anarazel.de>
References: <20220329093120.4173283-1-matthieu.baerts@tessares.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220329093120.4173283-1-matthieu.baerts@tessares.net>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 2022-03-29 11:31:20 +0200, Matthieu Baerts wrote:
> It seems it cannot be assumed .git/ORIG_HEAD exists if .git/HEAD is
> there.
> 
> Indeed, recently our public CI reported[1] the following error when
> compiling Perf tool:
> 
>   $ cd tools/perf
>   $ make -j4 -l4 O=/tmp/(...)/perf DESTDIR=/usr install
>   (...)
>   make[2]: *** No rule to make target '../../.git/ORIG_HEAD', needed by '/tmp/(...)/perf/PERF-VERSION-FILE'.
> 
> This is because apparently[2] Cirrus Ci uses a Git client implemented
> purely in Go[3] to perform a clone. Most likely, this tool doesn't
> create any .git/ORIG_HEAD file but .git/HEAD is there. The error can
> indeed be reproduced by renaming this .git/ORIG_HEAD file while keeping
> .git/HEAD. In other words, it means it is not enough to check the
> presence of .git/HEAD to assume .git/ORIG_HEAD exists as well.

FWIW, It's not just custom git implementations, stock git doesn't ensure it's
there either. I build a nightly VM image with Linus' kernel for postgres
testing, and as part of that I do a minimal clone:
  git clone --single-branch --depth 1 git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git /usr/src/linux
and then build the kernel. The build recently started failing like this:
https://cirrus-ci.com/task/4648999113195520?logs=build_image#L3121

It's not a question of "--single-branch --depth 1" - ORIG_HEAD just isn't
there in a new clone. Which makes sense, because there's no previous value for
HEAD.

Greetings,

Andres Freund
