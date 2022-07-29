Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A1A93585105
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Jul 2022 15:40:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236653AbiG2NkY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Jul 2022 09:40:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235451AbiG2NkW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Jul 2022 09:40:22 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C06111180C;
        Fri, 29 Jul 2022 06:40:20 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5D90861F4C;
        Fri, 29 Jul 2022 13:40:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 378BCC433D6;
        Fri, 29 Jul 2022 13:40:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1659102019;
        bh=0OSNx2MkLas4Uvqd32G0wnYPkqwVOT8GaNmWvKmuHQQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=VGi+dc17KprHrHpJ2H3pemHcy6c4NC2hK7DSwjiSMUlz7QJR6WZotCcvqZ3F4AJi6
         TeNza7yxrPninBAzA3R1493aUPyUVtu2uh0m620SFqZT8jpoQm/L1xmOLgOiDJZK4P
         WEDImwpAf+c6DSV8QEh7d/H+OOZetid+l9lWc1mU=
Date:   Fri, 29 Jul 2022 15:40:16 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Tom Lendacky <thomas.lendacky@amd.com>
Cc:     linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-doc-tw-discuss@lists.sourceforge.net,
        Jonathan Corbet <corbet@lwn.net>, Alex Shi <alexs@kernel.org>,
        Yanteng Si <siyanteng@loongson.cn>,
        Hu Haowen <src.res@email.cn>
Subject: Re: [PATCH] docs: embargoed-hardware-issues: remove bouncing AMD
 contact info
Message-ID: <YuPjQF11kf+8JYxv@kroah.com>
References: <20220729100745.2225558-1-gregkh@linuxfoundation.org>
 <YuO0bY7xMqFtrKCj@kroah.com>
 <7da72334-f3ea-fe73-b4b4-bec97ae15946@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7da72334-f3ea-fe73-b4b4-bec97ae15946@amd.com>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 29, 2022 at 07:59:42AM -0500, Tom Lendacky wrote:
> On 7/29/22 05:20, Greg Kroah-Hartman wrote:
> > On Fri, Jul 29, 2022 at 12:07:45PM +0200, Greg Kroah-Hartman wrote:
> > > The current AMD contact info in the embargoed-hardware-issues.rst file
> > > is bouncing as an invalid address, so remove it from the documentation.
> > > 
> > > At this point in time, the kernel community has no way to contact AMD
> > > for any hardware-specific problems.  Hopefully they can resolve this
> > > issue soon, or maybe they just don't have any hardware bugs and do not
> > > need to worry about this.
> > > 
> > > Cc: Jonathan Corbet <corbet@lwn.net>
> > > Cc: Alex Shi <alexs@kernel.org>
> > > Cc: Yanteng Si <siyanteng@loongson.cn>
> > > Cc: Hu Haowen <src.res@email.cn>
> > > Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> > > ---
> > >   Documentation/process/embargoed-hardware-issues.rst             | 2 +-
> > >   .../translations/zh_CN/process/embargoed-hardware-issues.rst    | 2 +-
> > >   .../translations/zh_TW/process/embargoed-hardware-issues.rst    | 2 +-
> > >   3 files changed, 3 insertions(+), 3 deletions(-)
> > > 
> > > diff --git a/Documentation/process/embargoed-hardware-issues.rst b/Documentation/process/embargoed-hardware-issues.rst
> > > index 95999302d279..a8c38e1c40dc 100644
> > > --- a/Documentation/process/embargoed-hardware-issues.rst
> > > +++ b/Documentation/process/embargoed-hardware-issues.rst
> > > @@ -244,7 +244,7 @@ disclosure of a particular issue, unless requested by a response team or by
> > >   an involved disclosed party. The current ambassadors list:
> > >     ============= ========================================================
> > > -  AMD		Tom Lendacky <tom.lendacky@amd.com>
> > > +  AMD
> > 
> > Wait, Tom, is this just the wrong email address for you?  And the one
> > above I used in the To: the correct one?
> 
> Wow, yes, I can't believe I made that mistake and haven't noticed it! You
> are correct, it should be thomas.lendacky@amd.com.

Ok, let me go fix this up and change the address in the files and redo
this patch.

thanks,

greg k-h
