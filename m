Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4240E4943E3
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jan 2022 00:32:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344508AbiASXcY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Jan 2022 18:32:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232430AbiASXcX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jan 2022 18:32:23 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1743C061574
        for <linux-kernel@vger.kernel.org>; Wed, 19 Jan 2022 15:32:22 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 7D677B81C25
        for <linux-kernel@vger.kernel.org>; Wed, 19 Jan 2022 23:32:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0606DC004E1;
        Wed, 19 Jan 2022 23:32:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1642635140;
        bh=Uus0J0HgopD+MxeEpf7dm1D8Q2ch+7tnlV2ygA6lKsE=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=mcYrIc5ksgmGPxth2lZrTVNVKwF34XrQCsCT6ojm8eX5zAfo8oxxELRPMFIEL1LlC
         dfP5MNKZkqwsyWq7tKwJev7bKCHNUmjhpqaHkZJJtx8JP/EpRpODd80YwS3dgf3DuB
         yU6OVHEPi/6Nk64JbKqyt4/Isyh0CLU94bbeED5mZe93q0Uy9gLFxuypw1Sj8M4v0i
         e/3G0eyA9a/oKCCKOytSFlvB7cY9E8TrFAonoP/8neuWWIM9E2aG8Xuy5tVb8WGgzw
         UR99WWk2Rm26f9cRPehznvnP8gFzxOZ6XsDYhSJSSAKQEJ/CpMAey+cXMelYKrapRB
         309Si6dg4h2EQ==
Date:   Wed, 19 Jan 2022 15:32:18 -0800
From:   Jakub Kicinski <kuba@kernel.org>
To:     Borislav Petkov <bp@suse.de>
Cc:     kernel test robot <lkp@intel.com>,
        "Paul E. McKenney" <paulmck@kernel.org>, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org
Subject: Re: vmlinux.o: warning: objtool: do_machine_check()+0x5fa: call to
 memset() leaves .noinstr.text section
Message-ID: <20220119153218.02ee6789@kicinski-fedora-PC1C0HJN.hsd1.ca.comcast.net>
In-Reply-To: <YeicA7BKdstxbteX@zn.tnic>
References: <202110261614.Bt8EM6Nj-lkp@intel.com>
        <YXe7AnMmiWXk36NC@zn.tnic>
        <20220119102250.7e20b3df@kicinski-fedora-PC1C0HJN.hsd1.ca.comcast.net>
        <YehZsGAqgd3tJyDV@zn.tnic>
        <20220119104017.31e5ecc7@kicinski-fedora-PC1C0HJN.hsd1.ca.comcast.net>
        <20220119111523.71f8e9e3@kicinski-fedora-PC1C0HJN.hsd1.ca.comcast.net>
        <Yeh013gIveIKdFMP@zn.tnic>
        <20220119123714.22b54d4c@kicinski-fedora-PC1C0HJN.hsd1.ca.comcast.net>
        <Yeh/oEYGyg2+XYSJ@zn.tnic>
        <20220119145727.2034a180@kicinski-fedora-PC1C0HJN.hsd1.ca.comcast.net>
        <YeicA7BKdstxbteX@zn.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 20 Jan 2022 00:17:23 +0100 Borislav Petkov wrote:
> So, I'd like to reproduce that here and play with it a bit. What iso
> can I install in a guest here so that I can get pretty close to your
> environment?

It's CentOS Stream 8. It may have some extra backports done by my $corp
but I don't think the compiler is backported.
