Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D9968584E9B
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Jul 2022 12:20:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235582AbiG2KUh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Jul 2022 06:20:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229925AbiG2KUe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Jul 2022 06:20:34 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 526074AD61;
        Fri, 29 Jul 2022 03:20:33 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B47E161DEC;
        Fri, 29 Jul 2022 10:20:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9090FC433D6;
        Fri, 29 Jul 2022 10:20:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1659090032;
        bh=T5X54hI0Wtlb7oHjJG9VCX4+WnI6m6WZJ0F+TdyKmpU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=IHGM28zhnWgluDKd3aCiVNEchXDOLoL+JtPOVw+KsyM6Dc+Me8ST9R2zTOhvT3AMo
         dbXTX8/V880dnc+8v7q8CobLKjTMwIMP4Wn6iyabJ9yE7zPEGXgEebpTWYtEcnFyJ5
         42bKVSRmoHZYZ1ejfOGLQZyPgEtowSED8bZ9klwo=
Date:   Fri, 29 Jul 2022 12:20:29 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Tom Lendacky <thomas.lendacky@amd.com>,
        linux-kernel@vger.kernel.org
Cc:     linux-doc@vger.kernel.org,
        linux-doc-tw-discuss@lists.sourceforge.net,
        Jonathan Corbet <corbet@lwn.net>, Alex Shi <alexs@kernel.org>,
        Yanteng Si <siyanteng@loongson.cn>,
        Hu Haowen <src.res@email.cn>
Subject: Re: [PATCH] docs: embargoed-hardware-issues: remove bouncing AMD
 contact info
Message-ID: <YuO0bY7xMqFtrKCj@kroah.com>
References: <20220729100745.2225558-1-gregkh@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220729100745.2225558-1-gregkh@linuxfoundation.org>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 29, 2022 at 12:07:45PM +0200, Greg Kroah-Hartman wrote:
> The current AMD contact info in the embargoed-hardware-issues.rst file
> is bouncing as an invalid address, so remove it from the documentation.
> 
> At this point in time, the kernel community has no way to contact AMD
> for any hardware-specific problems.  Hopefully they can resolve this
> issue soon, or maybe they just don't have any hardware bugs and do not
> need to worry about this.
> 
> Cc: Jonathan Corbet <corbet@lwn.net>
> Cc: Alex Shi <alexs@kernel.org>
> Cc: Yanteng Si <siyanteng@loongson.cn>
> Cc: Hu Haowen <src.res@email.cn>
> Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> ---
>  Documentation/process/embargoed-hardware-issues.rst             | 2 +-
>  .../translations/zh_CN/process/embargoed-hardware-issues.rst    | 2 +-
>  .../translations/zh_TW/process/embargoed-hardware-issues.rst    | 2 +-
>  3 files changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/Documentation/process/embargoed-hardware-issues.rst b/Documentation/process/embargoed-hardware-issues.rst
> index 95999302d279..a8c38e1c40dc 100644
> --- a/Documentation/process/embargoed-hardware-issues.rst
> +++ b/Documentation/process/embargoed-hardware-issues.rst
> @@ -244,7 +244,7 @@ disclosure of a particular issue, unless requested by a response team or by
>  an involved disclosed party. The current ambassadors list:
>  
>    ============= ========================================================
> -  AMD		Tom Lendacky <tom.lendacky@amd.com>
> +  AMD

Wait, Tom, is this just the wrong email address for you?  And the one
above I used in the To: the correct one?

confused,

greg k-h
