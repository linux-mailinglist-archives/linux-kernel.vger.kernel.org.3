Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0712E49EA73
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jan 2022 19:41:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244830AbiA0Sl0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jan 2022 13:41:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237215AbiA0SlW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jan 2022 13:41:22 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3092C061714
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jan 2022 10:41:22 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 62E4161CCC
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jan 2022 18:41:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C5AEDC340E4;
        Thu, 27 Jan 2022 18:41:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1643308881;
        bh=Xf/k/gcASUXDIYWT7wBXlpbc7n2efn52kakfZsVCrAE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=pIwBHjh5UcXHU6lWF/lWC6HTDt+N9AWkV73bbweknJu26bcl8l4stIa6rS2oKPP56
         7oMH10l17svk9/+Gl2/1q+blINezm8bqdXpcV89wfSrH8/Y1LK08djeQ5tWaEodDUD
         RtkwnUPAa1F3GGhcNCOP4OTtmVB0homm6V/wQ/4s=
Date:   Thu, 27 Jan 2022 19:41:18 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Hideki Yamane <henrich@iijmio-mail.jp>
Cc:     Takashi Iwai <tiwai@suse.de>, Luis Chamberlain <mcgrof@kernel.org>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH RFC 0/4] firmware: Add ZSTD-compressed file support
Message-ID: <YfLnTm7L3m6jEB+4@kroah.com>
References: <20210127154939.13288-1-tiwai@suse.de>
 <YBGeXDTEy8myghot@kroah.com>
 <20220128032213.c93b56aa2ea1c77e34b28290@iijmio-mail.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220128032213.c93b56aa2ea1c77e34b28290@iijmio-mail.jp>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 28, 2022 at 03:22:13AM +0900, Hideki Yamane wrote:
> On Wed, 27 Jan 2021 18:09:48 +0100
> Greg Kroah-Hartman <gregkh@linuxfoundation.org> wrote: > 
> > > Currently, I have no idea whether any distro would use ZSTD files for
> > > firmware files in near future, though.  That's the reason of this
> > > patch set being an RFC for now.
> > 
> > Looks sane enough to me, if we have a real user, I see no reason why to
> > not merge this.
> 
>  Just curious, any progress for this?

What is "this"?  You are responding to a year-old email message :)
