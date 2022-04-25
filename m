Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 58C0C50E4DC
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Apr 2022 17:55:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243068AbiDYP6N (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Apr 2022 11:58:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240590AbiDYP6M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Apr 2022 11:58:12 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 522A7AE
        for <linux-kernel@vger.kernel.org>; Mon, 25 Apr 2022 08:55:06 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id AFAE6CE1366
        for <linux-kernel@vger.kernel.org>; Mon, 25 Apr 2022 15:55:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 66825C385A4;
        Mon, 25 Apr 2022 15:55:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1650902102;
        bh=6YSxGBUI5ZjIGM77MdIrIvONvTO+PAT1SIs3ZNSmV+Y=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=A/2+hJAQQP5DzlSl1v5deM4nTmLMI+9VJ2l0/Jjsbe7gyr4PcOHbYcshWp2xPzV3g
         4mOB7y2JUmQl9MAzUR6/PJz1YQRXfqzDbVSoS4ZmnFJ/PppADv10YLX3qwK29SWJ9x
         fVUz9IiTDkPKB+9vtq/c3PxbJKCGSwW2in4jiPag=
Date:   Mon, 25 Apr 2022 17:54:59 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Masami Hiramatsu <mhiramat@kernel.org>
Cc:     kernel test robot <lkp@intel.com>, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org, Ingo Molnar <mingo@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: Re: [linux-stable-rc:queue/4.19 3886/9999]
 arch/ia64/kernel/kprobes.c:414:24: error: implicit declaration of function
 '__kretprobe_trampoline_handler'; did you mean 'kretprobe_trampoline'?
Message-ID: <YmbEU4t57gEJAdi8@kroah.com>
References: <202204130102.JZPa6KCQ-lkp@intel.com>
 <20220422221312.f1bc4222cd2eb871ff066e24@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220422221312.f1bc4222cd2eb871ff066e24@kernel.org>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 22, 2022 at 10:13:12PM +0900, Masami Hiramatsu wrote:
> Hi Greg,
> 
> Can you revert/drop this patch from 4.19 stable tree?

Can you please send a revert as I do not know what commit you are
referring to exactly.

> This patch is a part of bigger series, which introduces a generic
> arch-independent kretprobe trampoline handler, but that is not for the
> stable tree.
> 
> Also, the commit f5f96e3643dc33d6117cf7047e73512046e4858b is in the 4.19
> stable tree, which fixes this commit. Thus that must be removed too.

Same for this, can you send a revert?

thanks,

greg k-h
