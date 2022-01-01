Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A218048263E
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Jan 2022 02:29:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231208AbiAAB3n (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 31 Dec 2021 20:29:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229473AbiAAB3n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Dec 2021 20:29:43 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9AE7C061574;
        Fri, 31 Dec 2021 17:29:42 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9E12F61807;
        Sat,  1 Jan 2022 01:29:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AD368C36AE9;
        Sat,  1 Jan 2022 01:29:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1641000581;
        bh=2CNbiF3YPMIT9cpn4uAY+oAFvQemZTuOHBjbeQKEjW8=;
        h=Date:From:To:Cc:Subject:From;
        b=dTPTM2Lw/BJmbk/JWZcGA15ht+v0GMu46TgJ/2QnARub706pBrovKUHvvHi3JIHxL
         xe8QB6JlHzrNrEeQ1KiumNxcY/GRB6jk93jqZ6VKfEkVaZnmq0LIwutNrcrBmuVUfK
         epEip4SFzSaSdOcGvGLr5j+WhVW4Y+wqSNoYKEvqAjdiOx18QS1nuLT4ZA8ONPeItC
         mJo/RPjwi4Qlg7UNosdbodW2yygHfbEhr46gDgqZvfZfnO94T4VTifgpT67/1Kw/pt
         L+hFeQEagm2cIbyeMfWXtkfvMvhNYPNGkwIaMNLdU9hE9HUlrVV0YfAsCYQtASCUwF
         uOL/NS//LKaaA==
Date:   Sat, 1 Jan 2022 02:29:36 +0100
From:   Mauro Carvalho Chehab <mchehab@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux Media Mailing List <linux-media@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [GIT PULL for v5.17-rc1] New year's media updates
Message-ID: <20220101022920.62f31d16@coco.lan>
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.31; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

Since this year the next merge window may happen at the first couple of weeks 
in January, I'm opting to submit the media pull request a little earlier, as
we don't expect too much traffic anyway on media ML, and this might help you
on any travel plans you could have. Also, there's nothing better to desire a
wishful New Year to everybody than to send patches to improve the Linux 
Kernel ;-)

So, please merge from:
  git://git.kernel.org/pub/scm/linux/kernel/git/mchehab/linux-media tags/media/v5.17-1

For:

  - New sensor driver: ov5693;
  - A new driver for STM32 Chrom-ART Accelerator;
  - Added V4L2 core helper functions for VP9 codec;
  - Hantro driver has gained support for VP9 codecs;
  - Added support for Maxim MAX96712 Quad GMSL2 Deserializer;
  - The staging atomisp driver has gained lots of improvements, fixes
    and cleanups. It now works with userptr;
  - Lots of random driver improvements as usual.

Happy New Year!

Best regards,
Mauro


The following changes since commit 0fcfb00b28c0b7884635dacf38e46d60bf3d4eb1:


Thanks,
Mauro
