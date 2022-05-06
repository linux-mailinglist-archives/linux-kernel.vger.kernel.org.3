Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6C92C51D167
	for <lists+linux-kernel@lfdr.de>; Fri,  6 May 2022 08:33:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348394AbiEFGgo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 May 2022 02:36:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346705AbiEFGgk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 May 2022 02:36:40 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC9D95EBDA
        for <linux-kernel@vger.kernel.org>; Thu,  5 May 2022 23:32:58 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 88BFE61E41
        for <linux-kernel@vger.kernel.org>; Fri,  6 May 2022 06:32:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A3DD5C385A8;
        Fri,  6 May 2022 06:32:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1651818778;
        bh=ZDI5eE9bg9C0Wj48HjyHvazNLVqpUpreJ/qe0kZV4ZI=;
        h=Date:From:To:cc:Subject:In-Reply-To:References:From;
        b=gK05L7iCwvnU3ysFoZAZ1dK5zDhaiytBTw+S4TIL7DzzVU4gsdDpHuGsnZmM5n39b
         Ojbph5bOP3hd35loR9ksIDgYzWd1GiQyV1cw5gS/DORER9ghu5U2WcAqFsEzi40bEP
         6tUuPU8FTt4OgIaSD/FcGLbNJMmXk/TeVQI9912vGQVcOFc943rKB+ZoUeQ90vnUwJ
         w4uyfJSP3ysqSQVWkLR3rSCzkm6tGEr+CGVfmMYel7wNV5VH+B6iWye9sSukYDqDbb
         ELXZ/Xt091MIaY3vEdYreaBefFmhxE4GntjR2MJRLmSGRRvoHqQ02SYp1TR+Ns/Ckc
         W3NXHjBF6AQvg==
Date:   Fri, 6 May 2022 08:32:53 +0200 (CEST)
From:   Jiri Kosina <jikos@kernel.org>
To:     Daniel Ogorchock <djogorchock@gmail.com>
cc:     kernel test robot <lkp@intel.com>, llvm@lists.linux.dev,
        kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: Re: drivers/hid/hid-nintendo.c:403:29: warning: unused variable
 'JC_RUMBLE_ZERO_AMP_PKT_CNT'
In-Reply-To: <CAEVj2tk8uzXm5D-17QppezPgSfrYd3dW6K6CiU+BFvUd4jYtTQ@mail.gmail.com>
Message-ID: <nycvar.YFH.7.76.2205060832320.28985@cbobk.fhfr.pm>
References: <202204211058.3UoweQuz-lkp@intel.com> <nycvar.YFH.7.76.2204211021050.30217@cbobk.fhfr.pm> <CAEVj2tk8uzXm5D-17QppezPgSfrYd3dW6K6CiU+BFvUd4jYtTQ@mail.gmail.com>
User-Agent: Alpine 2.21 (LSU 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 21 Apr 2022, Daniel Ogorchock wrote:

> Hi Jiri,
> 
> Apologies for the delay on this. I'll try to carve some time out this
> weekend to submit a patch to avoid the warnings.

Just a friendly ping to make sure this doesn't get lost in between cracks 
:) Thanks,

-- 
Jiri Kosina
SUSE Labs

