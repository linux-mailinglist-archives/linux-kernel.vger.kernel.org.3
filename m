Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B782B507F86
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Apr 2022 05:17:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359212AbiDTDT2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Apr 2022 23:19:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349010AbiDTDTZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Apr 2022 23:19:25 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E7109FD6;
        Tue, 19 Apr 2022 20:16:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1650424601; x=1681960601;
  h=message-id:subject:from:to:cc:date:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=xjxCuPU1wDXGLoKd2DsY+kJ78tcX02C4AYF3wxGy00A=;
  b=XZ+VoGmTr0oSig5pJ7UGumJicNTfgzbIZWi1RZqQxnAoV7YCgLPXJx6t
   innQiSHAMWp4KoG6ixP8OeOD4X+n7hzaKmpqDUeY8RWQS6D3SMBuWN32i
   m6aal5PlbjItJUw0N42yblmqKLxMd9LTesMaVAGLvkcHTlA86xzx7HTtC
   BInTI4BOrraqPdoNouJPtGRCDXAE4D1uHw8taT56loZu8ebV62uh+FNOl
   Ck9oHUTbZqTBS/cduzyAeRnNb/d7UD9hCrfL6fdxKIdInusirr1+Y/VrE
   uXgFdMCpmRUkXXcCGM5LaQ2mafFGxib/CJjTxV4Xm8IDT2Gsmh+8jSJio
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10322"; a="289029155"
X-IronPort-AV: E=Sophos;i="5.90,274,1643702400"; 
   d="scan'208";a="289029155"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Apr 2022 20:16:40 -0700
X-IronPort-AV: E=Sophos;i="5.90,274,1643702400"; 
   d="scan'208";a="529566305"
Received: from spandruv-desk.jf.intel.com ([10.54.75.8])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Apr 2022 20:16:40 -0700
Message-ID: <b78bd722081baa4db571c0360559f105d0a7d175.camel@linux.intel.com>
Subject: Re: [PATCH v2 0/4] tools/thermal: thermal library and tools
From:   srinivas pandruvada <srinivas.pandruvada@linux.intel.com>
To:     Daniel Lezcano <daniel.lezcano@linaro.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>
Date:   Tue, 19 Apr 2022 20:16:40 -0700
In-Reply-To: <51d63f20-4834-184b-2ac2-30c399bd9988@linaro.org>
References: <20220330100444.3846661-1-daniel.lezcano@linaro.org>
         <f526d227-ffbb-4ac0-ceb6-c793ab912559@linaro.org>
         <5380fef6d45f2f7a0b8a5f681934f02943d5e138.camel@linux.intel.com>
         <9ccb342b-2f20-6efd-a668-96d593aa921e@linaro.org>
         <CAJZ5v0hrRuVz8pgD6-m7EhVdHPPn67O4ajx_7vkOOOYdTkv2BQ@mail.gmail.com>
         <0181977f5843fb9df4eae7d397d96c890846a0db.camel@linux.intel.com>
         <f1d2b1c7a9691c64ece07fbc1fc5a2d4e70aa00a.camel@linux.intel.com>
         <916d2e4c-7224-f824-f3cf-5c1dee411ed1@linaro.org>
         <dc9b317f88f7d43cd30141376156c0f3eec687d8.camel@linux.intel.com>
         <ba3cbf3d-938b-1530-1178-68b447f20a9c@linaro.org>
         <f7e4f4604f122dfab4aa5e589d68eb2c8773e00d.camel@linux.intel.com>
         <51d63f20-4834-184b-2ac2-30c399bd9988@linaro.org>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.38.4 (3.38.4-1.fc33) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Daniel,

On Tue, 2022-04-19 at 22:26 +0200, Daniel Lezcano wrote:
> 
> Hi Srinivas,
> 
> 
> On 18/04/2022 05:36, srinivas pandruvada wrote:
> > Hi Daniel,
> > 
> > The attached diff fixes the crash,
> > 
> > Also when you run in daemon mode, you need to use some pid lock
> > file.
> > Otherwise it launches multiple daemons.
> 
> I've been thinking about it and I don't think it is a problem to have
> multiple instances of the daemon. The netlink allows multicast and
> can 
> be run as non-root user.
> 
> If the finality of the thermal engine is to manage the system and has
> some code making actions on the system with the root privilege, the
> init 
> scripts can take care of the pid lock
> 
If there is use case, then this is fine otherwise wasting system
resources.

Thanks,
Srinivas





> 
> 


