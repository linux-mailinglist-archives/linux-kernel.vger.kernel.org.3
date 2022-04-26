Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 30AF950F17A
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Apr 2022 08:47:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240678AbiDZGuo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Apr 2022 02:50:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231560AbiDZGum (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Apr 2022 02:50:42 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3FB5237E3
        for <linux-kernel@vger.kernel.org>; Mon, 25 Apr 2022 23:47:35 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 822B261347
        for <linux-kernel@vger.kernel.org>; Tue, 26 Apr 2022 06:47:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5388CC385A0;
        Tue, 26 Apr 2022 06:47:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1650955654;
        bh=XH7q6MHWA3rgijXbIu3rZDrO4X+yfP3UQJasn1WX37I=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=sAA5HHA5tnJNMKDa2GKNi2FCIjdCp96jJouQ1lUlrOAdy5/yWCSbDVjYuSRKPoQUT
         YLZN6MKj2Gsg3ZIPnnp2gmaDngeqUVW5aykR7g3JXEBfn9SXCpR9++yCyb4M/cYom0
         f6PeeKKpmpcKxlkfc/aMJCOgdSOQwozyr9hxNAUYMQiotF86G+lEmelCTscic6w3tP
         YbSafvWK/qVAFny23rcgzpY6dQTJ/Z0RRYHye326zvGXjaxdi4RC5ZR5ZB28jYGk3W
         WbPg0fccxouXEPqPHodbNO7mDi9hg/WwyzZg+R1q5P0X/o0TMPziV5ExiH+/8ae5Gt
         +TlJAVSgBCDcw==
Date:   Tue, 26 Apr 2022 15:47:30 +0900
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     kernel test robot <lkp@intel.com>, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org, Ingo Molnar <mingo@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: Re: [linux-stable-rc:queue/4.19 3886/9999]
 arch/ia64/kernel/kprobes.c:414:24: error: implicit declaration of function
 '__kretprobe_trampoline_handler'; did you mean 'kretprobe_trampoline'?
Message-Id: <20220426154730.3b5b934990faf267176dcf7c@kernel.org>
In-Reply-To: <YmbEU4t57gEJAdi8@kroah.com>
References: <202204130102.JZPa6KCQ-lkp@intel.com>
        <20220422221312.f1bc4222cd2eb871ff066e24@kernel.org>
        <YmbEU4t57gEJAdi8@kroah.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-9.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 25 Apr 2022 17:54:59 +0200
Greg Kroah-Hartman <gregkh@linuxfoundation.org> wrote:

> On Fri, Apr 22, 2022 at 10:13:12PM +0900, Masami Hiramatsu wrote:
> > Hi Greg,
> > 
> > Can you revert/drop this patch from 4.19 stable tree?
> 
> Can you please send a revert as I do not know what commit you are
> referring to exactly.
> 
> > This patch is a part of bigger series, which introduces a generic
> > arch-independent kretprobe trampoline handler, but that is not for the
> > stable tree.
> > 
> > Also, the commit f5f96e3643dc33d6117cf7047e73512046e4858b is in the 4.19
> > stable tree, which fixes this commit. Thus that must be removed too.
> 
> Same for this, can you send a revert?

OK, let me send it.

Thanks!

> 
> thanks,
> 
> greg k-h


-- 
Masami Hiramatsu <mhiramat@kernel.org>
