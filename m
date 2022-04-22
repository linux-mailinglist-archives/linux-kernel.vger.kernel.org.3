Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1E6C450C179
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Apr 2022 00:06:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231423AbiDVWFR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Apr 2022 18:05:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231445AbiDVWFG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Apr 2022 18:05:06 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB91E41D1F0;
        Fri, 22 Apr 2022 13:47:47 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 20A4061E06;
        Fri, 22 Apr 2022 20:36:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 26FDAC385AA;
        Fri, 22 Apr 2022 20:36:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1650659808;
        bh=a+XR4UoEGJUvtEOaoDDXPDz++it2F/wJ7l1aRxdt+0A=;
        h=Date:From:To:cc:Subject:In-Reply-To:References:From;
        b=U1C6BKzOQuYL/nfuZoLkjlUF20h2YUwLxJY1jSCzxIVnBUp4EdJZVs73O1Pn6Utof
         mjCRxX9TNkmFvZRFKUp56ZToSf4XCNw3aT2W7Bb3Wj1WnU12GEiA8K4+pF9M/zJgab
         Izb9tqF2ccr987MY+dxr3hXiq9qVIVBJ5f2n2B6Jbyvz1tasMZIf9LgX+MYnKR/xjG
         E7WDSqaSUS+UtgaJCSFEciax2GbqTfgDORciTT4qkV5m2axVo/H+60yclotNZx8AJ0
         da1zxk6XQKfI87Sn8gDX/QDKt5eLqEfHH35itwJbVBrcOOqKMbhg2APRBh3695gRXT
         MN2pwmL/0NspQ==
Date:   Fri, 22 Apr 2022 13:36:47 -0700 (PDT)
From:   Stefano Stabellini <sstabellini@kernel.org>
X-X-Sender: sstabellini@ubuntu-linux-20-04-desktop
To:     Stephen Rothwell <sfr@canb.auug.org.au>
cc:     Juergen Gross <jgross@suse.com>,
        Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        Stefano Stabellini <sstabellini@kernel.org>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Xen Devel <xen-devel@lists.xenproject.org>,
        Stefano Stabellini <stefano.stabellini@xilinx.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: Re: linux-next: Signed-off-by missing for commit in the xen-tip
 tree
In-Reply-To: <20220422111438.3946dbae@canb.auug.org.au>
Message-ID: <alpine.DEB.2.22.394.2204221336170.915916@ubuntu-linux-20-04-desktop>
References: <20220422111438.3946dbae@canb.auug.org.au>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Juergen, Boris,

I forced-pushed the linux-next and for-linus-5.18 branches to solve the
issue


On Fri, 22 Apr 2022, Stephen Rothwell wrote:
> Hi all,
> 
> Commit
> 
>   b12d41716e32 ("arm/xen: Fix some refcount leaks")
> 
> is missing a Signed-off-by from its committer.
> 
> -- 
> Cheers,
> Stephen Rothwell
> 
