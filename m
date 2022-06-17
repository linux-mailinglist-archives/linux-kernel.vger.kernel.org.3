Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D15A154FB87
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Jun 2022 18:53:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1383059AbiFQQwN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Jun 2022 12:52:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1382967AbiFQQvv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jun 2022 12:51:51 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7240753724
        for <linux-kernel@vger.kernel.org>; Fri, 17 Jun 2022 09:50:24 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id C0D50CE2964
        for <linux-kernel@vger.kernel.org>; Fri, 17 Jun 2022 16:50:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C5784C3411C;
        Fri, 17 Jun 2022 16:50:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1655484621;
        bh=prjUJrbVE5x0yiMzgyo3mK2A9LSWth8Gi1HX3PvfTp0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=OTyy4eLFepkJl5S9gSy7oHiErOL6sTJtIx0492eQEMH/6N5jsFc9onMCQ+ptZHGmw
         Ns+rhHPxCW18IZjEWd90XlcKuHwxI7kp1eDtiQ5PF2onODY5sCAv0Nh5aZv19y9KQr
         Rmqix7rw8rtse2JlJqBUsWFbnRAiFP0U1WcQID7E8Q3P9rT5xAeli9M+vxhV763Hgl
         RtVqNk+mOUQkkNXyKLzimMxmucAX7hyQiFBRsX1TupL59AcFgL32YBJSyphHDLC6SS
         iAQUj4s9I5siLd0uWA/VSE1FjopbL8opasJM2xSruv+jnGjzSN4PfztamyEuzKpIBR
         /H9LsimG4/zxA==
Date:   Fri, 17 Jun 2022 09:50:19 -0700
From:   Nathan Chancellor <nathan@kernel.org>
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org
Subject: Re: [GIT PULL] Char/Misc driver fixes 5.19-rc3
Message-ID: <Yqywy+Md2AfGDu8v@dev-arch.thelio-3990X>
References: <Yqw4Jujzz5ZzZ2Wg@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Yqw4Jujzz5ZzZ2Wg@kroah.com>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Greg,

On Fri, Jun 17, 2022 at 10:15:34AM +0200, Greg KH wrote:
> The following changes since commit f2906aa863381afb0015a9eb7fefad885d4e5a56:
> 
>   Linux 5.19-rc1 (2022-06-05 17:18:54 -0700)
> 
> are available in the Git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/char-misc.git tags/char-misc-5.19-rc3
> 
> for you to fetch changes up to 0a35780c755ccec097d15c6b4ff8b246a89f1689:
> 
>   eeprom: at25: Split reads into chunks and cap write size (2022-06-10 16:42:48 +0200)
> 
> ----------------------------------------------------------------
> Char/Misc driver fixes for 5.19-rc3
> 
> Here are some small char/misc driver fixes for 5.19-rc3 that resolve
> some reported issues.
> 
> They include:
> 	- mei driver fixes
> 	- comedi driver fix
> 	- rtsx build warning fix
> 	- fsl-mc-bus driver fix
> 
> All of these have been in linux-next for a while with no reported
> issues.
> 
> Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

I think you tagged the wrong branch (char-misc-next vs. char-misc-linus)?
The commits below do not match the tag description above.

Cheers,
Nathan

> ----------------------------------------------------------------
> Brad Bishop (1):
>       eeprom: at25: Split reads into chunks and cap write size
> 
> Miaoqian Lin (1):
>       misc: atmel-ssc: Fix IRQ check in ssc_probe
> 
> Shreenidhi Shedi (1):
>       char: lp: remove redundant initialization of err
> 
>  drivers/char/lp.c          |  2 +-
>  drivers/misc/atmel-ssc.c   |  4 +-
>  drivers/misc/eeprom/at25.c | 93 ++++++++++++++++++++++++++--------------------
>  3 files changed, 56 insertions(+), 43 deletions(-)
> 
