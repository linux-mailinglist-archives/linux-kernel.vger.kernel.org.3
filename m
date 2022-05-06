Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A738C51E285
	for <lists+linux-kernel@lfdr.de>; Sat,  7 May 2022 01:41:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1444746AbiEFWdO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 May 2022 18:33:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229912AbiEFWdL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 May 2022 18:33:11 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52F0F5E153;
        Fri,  6 May 2022 15:29:26 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 1A187B839E6;
        Fri,  6 May 2022 22:29:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3A067C385A8;
        Fri,  6 May 2022 22:29:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1651876163;
        bh=y0FngmsSSvJom30mMBhLoZvRrNbqeZl4qnTn2t+QXjI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=vLWpiL6W1i7NALe3Gr1u0yqXziOB2D1Y79FbmrcBm6ez0KEs8X2L2Xg6dGtG+UuM5
         kQG4w38vN1g4pYSLCWI7rgZc283xkPUrFja+fD+v1YFscqyKdq/cvgsAaYPsLei/nf
         BWuoKQiXm34Gs1xfReP3QoxC2ZhjrdGHkUnI0KC6vSOiHli5y/nlmeIFkBgbpu+KnO
         TIjLVVvdcJx2f/OvbcDVoZ2EIg3g9++OfPd7eqsiE0SaqFx4UKA2aLoPcP9ieWe7yu
         OQc+PnxI8onIBUc3Az541pmd3zndBZ+rwn+NVpaLrPL5ThN8OO3HdoYAnkhhB5nbea
         kwbVGmHVd0Zmg==
Date:   Sat, 7 May 2022 01:30:48 +0300
From:   Jarkko Sakkinen <jarkko@kernel.org>
To:     Dave Hansen <dave.hansen@intel.com>
Cc:     cgel.zte@gmail.com, dave.hansen@linux.intel.com,
        tglx@linutronix.de, linux-sgx@vger.kernel.org,
        linux-kernel@vger.kernel.org, Minghao Chi <chi.minghao@zte.com.cn>,
        Zeal Robot <zealci@zte.com.cn>
Subject: Re: [PATCH] x86/sgx: simplify the return expression of sgx_drv_init()
Message-ID: <YnWhmNMHG4yE5qhX@kernel.org>
References: <20220505021659.54210-1-chi.minghao@zte.com.cn>
 <a29146f2-271b-8471-f846-15f0f50e614d@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a29146f2-271b-8471-f846-15f0f50e614d@intel.com>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 05, 2022 at 10:31:41AM -0700, Dave Hansen wrote:
> On 5/4/22 19:16, cgel.zte@gmail.com wrote:
> > From: Minghao Chi <chi.minghao@zte.com.cn>
> > 
> > Simplify the return expression.
> > 
> > Reported-by: Zeal Robot <zealci@zte.com.cn>
> > Signed-off-by: Minghao Chi <chi.minghao@zte.com.cn>
> 
> Folks, I'd really encourage you to spend your time elsewhere.  These
> "cleanup" or "simplify" patches as a whole have high rates of bugs.  I
> don't trust them.  Plus, they don't really make the code easier to
> understand.

I agree. I get this kind of clean up in the context of doing something
to the functionality (in the same path) but it does not live by its own.

Plus, these type of patches add to the effort backporting fixes.

BR, Jarkko
