Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 259494BE184
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Feb 2022 18:53:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1381562AbiBURQF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Feb 2022 12:16:05 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:41082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1381542AbiBURPr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Feb 2022 12:15:47 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7AAFB2611C
        for <linux-kernel@vger.kernel.org>; Mon, 21 Feb 2022 09:15:23 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 234B3B8169B
        for <linux-kernel@vger.kernel.org>; Mon, 21 Feb 2022 17:15:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 42D68C340F1;
        Mon, 21 Feb 2022 17:15:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1645463720;
        bh=3hVFByujHotYCnp1JQ7r1J0fFmKwYercGN1DL1gGxmQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=rk+dLpJwKxFOf6dAvit8EWf/5mZJvV4hJwnY8/9c3QFvmCISmqNSeEfVrD2Otp3DD
         WdDK1+nTiBwQjEbAn+qX7AeLwzGwzvjOtbSP2lXsl2Cbe+T3TI6C9DMWPy0TW/TVSc
         qK9mVWDdZbsIbpdIXBIUYGrVukFs41Y0ESY37xog=
Date:   Mon, 21 Feb 2022 18:15:18 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Philipp Hortmann <philipp.g.hortmann@gmail.com>
Cc:     Forest Bond <forest@alittletooquiet.net>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/3] staging: vt6656: Add comment and change macro to
 function
Message-ID: <YhPIpvz4X9BrR3J6@kroah.com>
References: <cover.1645386791.git.philipp.g.hortmann@gmail.com>
 <3eb14cfaa3f97695bd4db0dd75ac78408c557821.1645386791.git.philipp.g.hortmann@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3eb14cfaa3f97695bd4db0dd75ac78408c557821.1645386791.git.philipp.g.hortmann@gmail.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Feb 20, 2022 at 09:30:36PM +0100, Philipp Hortmann wrote:
> This patch fixes the checkpatch.pl warnings like:
> - CHECK: spinlock_t definition without comment
> - CHECK: Avoid CamelCase: <uVar>
> - CHECK: Macro argument reuse 'uVar' - possible side-effects?

That is 3 different things and so, should be 3 different patches.
Please break patches up into "one patch per logical change".

thanks,

greg k-h
