Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2873A585130
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Jul 2022 15:57:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236404AbiG2N46 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Jul 2022 09:56:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233822AbiG2N4w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Jul 2022 09:56:52 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C82D969F33;
        Fri, 29 Jul 2022 06:56:51 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 58C2D61F69;
        Fri, 29 Jul 2022 13:56:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 59B78C433D6;
        Fri, 29 Jul 2022 13:56:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1659103010;
        bh=1DbvJbyAe/SbMkObImq82pI14sEfhsB5KkeCrVzsf6w=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=FMZ7bfV2UUhZha+TIVrEl5x39Vv/sWn2JIxADYVSUXUwruqFctD4i0uCFA8wxGWWK
         /v4L+KNE0WHKW0N9TNsYIUekDCJ57K8ajr9E2LuFfNjLsOfOyBZG8imc+TzQKniIoZ
         3N/tbLvsXdp/Dxnp9wCm0GBatmSPS4MPV0ue6KP4=
Date:   Fri, 29 Jul 2022 15:56:47 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Tom Lendacky <thomas.lendacky@amd.com>
Cc:     linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-doc-tw-discuss@lists.sourceforge.net,
        Jonathan Corbet <corbet@lwn.net>, Alex Shi <alexs@kernel.org>,
        Yanteng Si <siyanteng@loongson.cn>,
        Hu Haowen <src.res@email.cn>
Subject: Re: [PATCH] docs: embargoed-hardware-issues: fix invalid AMD contact
 email
Message-ID: <YuPnHzrtcqzXmsdG@kroah.com>
References: <20220729134517.2284700-1-gregkh@linuxfoundation.org>
 <3531fa50-106b-35e9-d064-a1c9c6598817@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3531fa50-106b-35e9-d064-a1c9c6598817@amd.com>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 29, 2022 at 08:48:21AM -0500, Tom Lendacky wrote:
> On 7/29/22 08:45, Greg Kroah-Hartman wrote:
> > The current AMD contact info email address is incorrect, so fix it up to
> > use the correct one.
> > 
> > Cc: Jonathan Corbet <corbet@lwn.net>
> > Cc: Alex Shi <alexs@kernel.org>
> > Cc: Yanteng Si <siyanteng@loongson.cn>
> > Cc: Hu Haowen <src.res@email.cn>
> > Cc: Tom Lendacky <thomas.lendacky@amd.com>
> > Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> 
> Still can't believe I did that...
> 
> Acked-by: Tom Lendacky <thomas.lendacky@amd.com>

Thanks for the quick response, I'll go queue this up now.

greg k-h
