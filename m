Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 016B4572A99
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Jul 2022 03:06:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232476AbiGMBGg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Jul 2022 21:06:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229711AbiGMBGe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jul 2022 21:06:34 -0400
Received: from nautica.notk.org (nautica.notk.org [91.121.71.147])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79DCAC6376;
        Tue, 12 Jul 2022 18:06:33 -0700 (PDT)
Received: by nautica.notk.org (Postfix, from userid 108)
        id 17298C01A; Wed, 13 Jul 2022 03:06:31 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=codewreck.org; s=2;
        t=1657674391; bh=1qv4IMb2MDp9Z7qtROj3Llp60lp0QU6Ztq2dP8uKKRw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=3Zh4QmOux1n0AJ7mi870ESPWe5V93WUfvIywSpDR3QPYgdIrK03fFACAzsQsDR0WK
         gx9JDNlBMg/UYSrcUgZC1dkTjskA7jhO5FO4lhmOHXIE3gPV0VVgtvfBidS9cFNOT2
         ON2zo2XgsAfFEgcRvhvlzVbQd7zArJUVEwARyhBTfjuogK0rZNADYe4qpmE4NJnmEV
         ghiHTjQyBlIrxBgLmz7aVMjRCzUx3j5d6RsYCKWwLkG7Iv7VHleMGU0FVb93j+ds+A
         3EVQj2lo2zcVIW9ca5AxH+CQnlj32Px6gFoL8tkKf16MB1TLyndwOJyyXfwyi8ROl1
         X1XHoDcRIQJOw==
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
Received: from odin.codewreck.org (localhost [127.0.0.1])
        by nautica.notk.org (Postfix) with ESMTPS id BF121C009;
        Wed, 13 Jul 2022 03:06:29 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=codewreck.org; s=2;
        t=1657674390; bh=1qv4IMb2MDp9Z7qtROj3Llp60lp0QU6Ztq2dP8uKKRw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=gYw34qlOCbEJvT+kqGvsjs8gK3lF+9+9OEhIYk0cYM8mJvpJpcEnkCW15PukEtM5o
         hIKB7k3A6qn3NN9fjc6WdmrvRKZAINr+IOWtQY7Oq9CjMTvRsrPkhPazotAPEHglzO
         kTMEUzBJhDFyeqTBYFvEVxkfmya1DuMiGTcL5SvnDe9Cpsd+b78cqk05ezsW/zez0h
         X+T1ec+Ihl65SkEt/1CDMabr8fEUnQEOmsEcVpDEXnr1OnBza0dvOAoxGsXtJTeUOb
         yDf/B/Gm8HLCNCFRaeqJTQgIy7A1zxdTaobOW30wKKeIFdy19rbT1DxBHbzHsoSvBy
         f07P8ZVT7MK0A==
Received: from localhost (odin.codewreck.org [local])
        by odin.codewreck.org (OpenSMTPD) with ESMTPA id dc3077cb;
        Wed, 13 Jul 2022 01:06:25 +0000 (UTC)
Date:   Wed, 13 Jul 2022 10:06:10 +0900
From:   Dominique Martinet <asmadeus@codewreck.org>
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: Re: linux-next: build failure after merge of the v9fs tree
Message-ID: <Ys4agrex2lNG/CzE@codewreck.org>
References: <20220713110222.70ca5fc5@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220713110222.70ca5fc5@canb.auug.org.au>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Stephen Rothwell wrote on Wed, Jul 13, 2022 at 11:02:22AM +1000:
> After merging the v9fs tree, today's linux-next build (x86_64
> allmodconfig) failed like this:
> 
> net/9p/trans_fd.c:275:12: error: 'failme' defined but not used [-Werror=unused-variable]
>   275 | static int failme;
>       |            ^~~~~~
> cc1: all warnings being treated as errors
> 
> Caused by commit
> 
>   c249fb4f9193 ("9p: roll p9_tag_remove into p9_req_put")
> 
> I have used the v9fs tree from next-20220712 for today.

Sorry, fixed in my tree.

That can wait tomorrow.

--
Dominique

