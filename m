Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 276D054B404
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Jun 2022 16:59:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356459AbiFNO66 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Jun 2022 10:58:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243033AbiFNO6X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jun 2022 10:58:23 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DDFFF13F8F
        for <linux-kernel@vger.kernel.org>; Tue, 14 Jun 2022 07:58:22 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 861FC60B98
        for <linux-kernel@vger.kernel.org>; Tue, 14 Jun 2022 14:58:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 97ED5C3411B;
        Tue, 14 Jun 2022 14:58:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1655218702;
        bh=npIA38Z8CVWlfRLv4ZtqSctmDUHm77bZCDxb74j2+gI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=qvcbqPZJHuCT0eFTnnoN3AJBRpPqtGAN14cJ9P/FUkuqAiMZxQjp9r70Z8JgBWqi0
         RNjmh3EMoK9uuTLxqBsXNPPY65XKXOLVRjlzrbtb5jefLPHtoPBURrrwTdgA+jjrSX
         6K51ChBZ93RmwXrU00uCTwKuRTxUSAXvcqOWlW/Q=
Date:   Tue, 14 Jun 2022 16:58:19 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     wuchi <wuchi.zero@gmail.com>
Cc:     alexios.zavras@intel.com, allison@lohutok.net, armijn@tjaldur.nl,
        akpm@linux-foundation.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] lib/klist: Remove mb() before wake_up_process
Message-ID: <YqiiC+4xES0DoV7X@kroah.com>
References: <20220614144443.6566-1-wuchi.zero@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220614144443.6566-1-wuchi.zero@gmail.com>
X-Spam-Status: No, score=-8.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 14, 2022 at 10:44:43PM +0800, wuchi wrote:
> Function wake_up_process always executes a general memory barrier,
> so remove the mb() before it.

Really?  On all systems?  I do not see that, where does it happen?

> Signed-off-by: wuchi <wuchi.zero@gmail.com>

We need a "real name" for commits.

How did you test this patch?

thanks,

greg k-h
