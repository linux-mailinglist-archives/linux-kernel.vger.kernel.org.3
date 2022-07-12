Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 985D85716EB
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Jul 2022 12:13:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232770AbiGLKNZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Jul 2022 06:13:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233011AbiGLKM6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jul 2022 06:12:58 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28712ACEE8;
        Tue, 12 Jul 2022 03:12:57 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id AB8D1B8164D;
        Tue, 12 Jul 2022 10:12:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B9948C341C8;
        Tue, 12 Jul 2022 10:12:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1657620774;
        bh=mLrmLqzTtmLB7H+6kJe3yIOgyd7GxtXKOM0u5WSZMNc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=aEVFzkMR91MxJpFetnlno2ZaR6hbjYAzIcC+w/aFNokTe+msBrHCZfsNps690YH+Y
         52atfKYxMctWDKO4hQC8zWpNejLZwnD0doeE3spK1LIMJ6d9sbyUfVYonTUuZOqKLD
         BW3RA+M8GcSO2N2q5f5aiCSSfX8wA7AhzUgPRB0A=
Date:   Tue, 12 Jul 2022 12:12:51 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Nick Desaulniers <ndesaulniers@google.com>
Cc:     Jonathan Corbet <corbet@lwn.net>,
        Nathan Chancellor <nathan@kernel.org>,
        Tom Rix <trix@redhat.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Darren Hart <darren@os.amperecomputing.com>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        llvm@lists.linux.dev
Subject: Re: [PATCH] Documentation/process: Add embargoed HW contact for LLVM
Message-ID: <Ys1JI3nhgQHmUJ2F@kroah.com>
References: <20220711181101.1559558-1-ndesaulniers@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220711181101.1559558-1-ndesaulniers@google.com>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 11, 2022 at 11:10:58AM -0700, Nick Desaulniers wrote:
> Should the need for toolchain mitigations ever be necessary, add a group
> for toolchain ambassadors.
> 
> Add Nick Desaulniers as LLVM's ambassador for the embargoed hardware
> issues process.
> 
> Signed-off-by: Nick Desaulniers <ndesaulniers@google.com>
> ---
>  Documentation/process/embargoed-hardware-issues.rst | 3 +++
>  1 file changed, 3 insertions(+)

Thanks for volunteering, I'll go queue this up.

greg k-h
