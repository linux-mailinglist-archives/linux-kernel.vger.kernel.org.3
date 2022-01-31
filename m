Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D463E4A4C90
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Jan 2022 17:56:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1380665AbiAaQ4R (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Jan 2022 11:56:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232421AbiAaQ4Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Jan 2022 11:56:16 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97CDAC061714
        for <linux-kernel@vger.kernel.org>; Mon, 31 Jan 2022 08:56:15 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 681F0B82BD0
        for <linux-kernel@vger.kernel.org>; Mon, 31 Jan 2022 16:56:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D4E1BC340E8;
        Mon, 31 Jan 2022 16:56:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1643648173;
        bh=eS2+Xac4ucnE0xtF1Jdku4PVeGTD2yXq8zB3lKqLB4g=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=kA3e2FJIBsIe6uSdnXarRRUjxrI4WzMgH5AtXx6FcQjwCF5JqzLWaHVREzMwiE9LZ
         Ju/51ZTQtlxwaimO0iWxfK9qJUEr00dYsnbIJdONJN0vAxieD+/nRLGf4gu9PJWuua
         wF7KTdRPglL+ILQFogM4zlBZLdpYaAdnpmdMUAmIqT8MicLe6aJZwc18RVhQi2OLQC
         pmYGxu9KgvUONiSEGA6kvqAhkCl2yQBe0Vj2gLtQlo8aIUCzLLlC4fkY6fWee+Gpre
         R2opq5Uw8O7o6oNtwPRFj/JNS8n4oAtk8LVtcCshl8vke+YQh7J7pStrKoKRUNb7af
         Y4pmVDWqOUV3w==
Date:   Mon, 31 Jan 2022 08:56:11 -0800
From:   Jakub Kicinski <kuba@kernel.org>
To:     Borislav Petkov <bp@suse.de>
Cc:     kernel test robot <lkp@intel.com>,
        "Paul E. McKenney" <paulmck@kernel.org>, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org
Subject: Re: vmlinux.o: warning: objtool: do_machine_check()+0x5fa: call to
 memset() leaves .noinstr.text section
Message-ID: <20220131085611.4371c9da@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
In-Reply-To: <YffQ1XJ+9YAVa163@zn.tnic>
References: <20220119102250.7e20b3df@kicinski-fedora-PC1C0HJN.hsd1.ca.comcast.net>
        <YehZsGAqgd3tJyDV@zn.tnic>
        <20220119104017.31e5ecc7@kicinski-fedora-PC1C0HJN.hsd1.ca.comcast.net>
        <20220119111523.71f8e9e3@kicinski-fedora-PC1C0HJN.hsd1.ca.comcast.net>
        <Yeh013gIveIKdFMP@zn.tnic>
        <20220119123714.22b54d4c@kicinski-fedora-PC1C0HJN.hsd1.ca.comcast.net>
        <Yeh/oEYGyg2+XYSJ@zn.tnic>
        <20220119145727.2034a180@kicinski-fedora-PC1C0HJN.hsd1.ca.comcast.net>
        <YeicA7BKdstxbteX@zn.tnic>
        <20220119153218.02ee6789@kicinski-fedora-PC1C0HJN.hsd1.ca.comcast.net>
        <YffQ1XJ+9YAVa163@zn.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 31 Jan 2022 13:06:45 +0100 Borislav Petkov wrote:
> Ok, while trying to boot an externally supplied kernel with qemu -kernel
> and with a guest install of centos8, I managed to trigger the issues on
> the test box.
> 
> I've pushed a branch here for you to test:
> 
> https://git.kernel.org/pub/scm/linux/kernel/git/bp/bp.git/log/?h=rc1%2bmce-noinstr
> 
> Lemme know how that goes.

CLEAN! All the warnings are gone, thank you :)
