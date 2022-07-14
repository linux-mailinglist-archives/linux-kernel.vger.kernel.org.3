Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3A6955750BA
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Jul 2022 16:27:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240362AbiGNO06 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Jul 2022 10:26:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230307AbiGNO05 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jul 2022 10:26:57 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A101E5886B;
        Thu, 14 Jul 2022 07:26:56 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 4E78AB82630;
        Thu, 14 Jul 2022 14:26:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CA9E8C34114;
        Thu, 14 Jul 2022 14:26:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1657808813;
        bh=CAg8/LnTOzxaY9qJhxy8R3oL/V1rQyx2znEUl8z+EYw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ZGLnZ+wFa7yNDykkAAEa0U898cand82Opw4sswIYsCqFl9YyLCvzlc7lL85TSgUND
         OixhHQ8ceDWn7wPh1Qzol1oQ7QCM+SasTRDZNKV8YDMOI4AS+OFK4BCTv+a1ec0eha
         d5a7oCuoqb86t0wIdB031HnLvOlxhdvr1Ej4u9SOJ4KYGRBJBWWZbii1t/qH5z9dAt
         yMsRFkER3VAXTv9WywVIibzgx8gZFPEjyGeck3zKq2a/Jz7Sxkj1JNxiChhOjUd0/z
         KPwjxHAC7mnZ6j6CfUEf3GuT3X/Wl1cNLPmoSHhOqdvvZCgqmU9XiFLDzkoKsVi2Ze
         JnX3AyeM8RTBQ==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan@kernel.org>)
        id 1oBznu-0008CP-FL; Thu, 14 Jul 2022 16:26:59 +0200
Date:   Thu, 14 Jul 2022 16:26:58 +0200
From:   Johan Hovold <johan@kernel.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [GIT PULL] USB-serial fixes for 5.19-rc7
Message-ID: <YtAnssmb83/Y5IuF@hovoldconsulting.com>
References: <YtAitIrTRRVkaUKJ@hovoldconsulting.com>
 <YtAmvoSgn3J9+1DF@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YtAmvoSgn3J9+1DF@kroah.com>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 14, 2022 at 04:22:54PM +0200, Greg Kroah-Hartman wrote:
> On Thu, Jul 14, 2022 at 04:05:40PM +0200, Johan Hovold wrote:
> > The following changes since commit 32346491ddf24599decca06190ebca03ff9de7f8:
> > 
> >   Linux 5.19-rc6 (2022-07-10 14:40:51 -0700)
> > 
> > are available in the Git repository at:
> > 
> >   https://git.kernel.org/pub/scm/linux/kernel/git/johan/usb-serial.git tags/usb-serial-5.19-rc7
> 
> Ah, had to pull in 5.19-rc6 into my branch, but that worked.  Now pulled
> and pushed out, thanks.

Sorry about that. I usually check your fixes branch before
fast-forwarding but I apparently used the wrong base commit this week.

Thanks for taking care of it.

Johan
