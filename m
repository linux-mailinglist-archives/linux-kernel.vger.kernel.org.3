Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2791158A3F0
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Aug 2022 01:36:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237281AbiHDXgd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Aug 2022 19:36:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230432AbiHDXgb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Aug 2022 19:36:31 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2495061B36;
        Thu,  4 Aug 2022 16:36:30 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id B98ECB8279C;
        Thu,  4 Aug 2022 23:36:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3B3EAC433C1;
        Thu,  4 Aug 2022 23:36:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1659656187;
        bh=pmh3e4mDNTCV0r8NXeHl/HmI/K4YjTK/3rIK77K26zo=;
        h=Date:From:To:cc:Subject:In-Reply-To:References:From;
        b=hAsEHrAxvWjmV3K1Bo5RXXZ+6Rvz8EQSVtKVOKD34XyaBd1yVWuO53ehDrNCt9VqB
         Lt8+xqtkLlDo7rXJr6hvWTgVnCfMiJ3zvNk/R2TlhbIX1feL05r1V6Ql/rNs8arFnF
         E+diwAz6JMc8zqis8peA9U0HVLuSIplaHR0vChTj8xFIZowXOBvQ/zbE83QDH58y2g
         T5EyNBAPrHUxMe+xi12/Y0qlUd6QrecrQFt8SjD0gMi87/UeRexF88ZOCBnZUEHyhG
         AqwiGzUwusC+QP88Pt5SStJLdjP68Koljyvm/HyFAApqoHs26E1v5+2zuOHC5rr8Hn
         YME7YMh3+E6NQ==
Date:   Fri, 5 Aug 2022 01:36:23 +0200 (CEST)
From:   Jiri Kosina <jikos@kernel.org>
To:     Mark Brown <broonie@kernel.org>
cc:     Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: Re: linux-next: build failure after merge of the input tree
In-Reply-To: <Yuu8rmJ1VsGPakqF@sirena.org.uk>
Message-ID: <nycvar.YFH.7.76.2208050133310.19850@cbobk.fhfr.pm>
References: <20220801214434.2058469-1-broonie@kernel.org> <Yuu8rmJ1VsGPakqF@sirena.org.uk>
User-Agent: Alpine 2.21 (LSU 202 2017-01-01)
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

On Thu, 4 Aug 2022, Mark Brown wrote:

> > Hi all,
> > 
> > After merging the hid tree, today's linux-next build (x86_64 allmodconfig)
> > failed like this:
> > 
> > /tmp/next/build/drivers/hid/hid-nintendo.c:406:29: error: redefinition of 'JC_RUMBLE_ZERO_AMP_PKT_CNT'
> >   406 | static const unsigned short JC_RUMBLE_ZERO_AMP_PKT_CNT = 5;
> >       |                             ^~~~~~~~~~~~~~~~~~~~~~~~~~
> > /tmp/next/build/drivers/hid/hid-nintendo.c:295:29: note: previous definition of 'JC_RUMBLE_ZERO_AMP_PKT_CNT' was here
> >   295 | static const unsigned short JC_RUMBLE_ZERO_AMP_PKT_CNT = 5;
> >       |                             ^~~~~~~~~~~~~~~~~~~~~~~~~~
> 
> This error persists, I've gone back to 20220722 which seems to be the
> last version.

for-next branch accumulated so many reverts and -next-specific fixups (not 
always correct) over the years (with the only goal of not rebasing it) 
that it's now time to finally rebase it. Which I just did, and things 
should be good now.

Sorry for the noise,

-- 
Jiri Kosina
SUSE Labs

