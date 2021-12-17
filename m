Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 49F564786B4
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Dec 2021 10:07:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234007AbhLQJHD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Dec 2021 04:07:03 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:40192 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233996AbhLQJHC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Dec 2021 04:07:02 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 8F96BB82753
        for <linux-kernel@vger.kernel.org>; Fri, 17 Dec 2021 09:07:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B28B0C36AE1;
        Fri, 17 Dec 2021 09:06:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1639732020;
        bh=6Bzk8dGdngYwyDyHY0r0URjPEUKUH6MyMzQwWawU6m4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Evz2nNiNFyeEvM24vxEw/5R6mOmnyajwlf+iTbUpQ3dxPhm5AuCRe05AB+is4L3tY
         PzA+ydSrMZwkn0P4r7K9DVuOW4y4ROs/nExV/8bUJyViO70bT+wi/QwtIYxUq4zQtz
         CY4Lfnn8a7gBsMZDCnWegrVYdthnI7fuPmw0OINs=
Date:   Fri, 17 Dec 2021 10:06:52 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Kees Cook <keescook@chromium.org>
Cc:     linux-kernel@vger.kernel.org, Ard Biesheuvel <ardb@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Misono Tomohiro <misono.tomohiro@jp.fujitsu.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>
Subject: Re: [GIT PULL] lkdtm updates for -next
Message-ID: <YbxTLFz//4KQvs2l@kroah.com>
References: <202112161601.DB11DD9@keescook>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202112161601.DB11DD9@keescook>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 16, 2021 at 04:02:03PM -0800, Kees Cook wrote:
> Hi Greg,
> 
> Please pull these lkdtm updates for -next.
> 
> Thanks!
> 
> -Kees
> 
> The following changes since commit 136057256686de39cc3a07c2e39ef6bc43003ff6:
> 
>   Linux 5.16-rc2 (2021-11-21 13:47:39 -0800)
> 
> are available in the Git repository at:
> 
>   https://git.kernel.org/pub/scm/linux/kernel/git/kees/linux.git tags/lkdtm-v5.17-rc1

Pulled and pushed out, thanks.

greg k-h
