Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D077258A0D6
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Aug 2022 20:51:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240075AbiHDSvT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Aug 2022 14:51:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240144AbiHDSvG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Aug 2022 14:51:06 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C77846D9FE;
        Thu,  4 Aug 2022 11:50:56 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B235661625;
        Thu,  4 Aug 2022 18:50:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B1CCFC433D7;
        Thu,  4 Aug 2022 18:50:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1659639055;
        bh=m7gbpioiTTpHCUtP6HqOQngY+wqQ8d/zSfbprVPAx5o=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Im1+lXQev4xyjoSV38vPLfOXUFCosL5ywaLbu27oFTIVywVSXxOQ6zvTEzdDinSUa
         /N+jN4r8JenLnPancbu6l11L2O3FSLWNikp12DA5gErV5aJFiDyrb2qzPT064PLVO3
         r1Me40iXc5PoM3auNDflNrU+mkkZNP3t5GmivKmP1Wcu8aKkGDcccse+CplV5j8zu8
         h29qalG4x3tupfDlv38ftw6L7FkIH7VZTp5VCSnEBsUcXXvXjDFlyjr717N2hPsg+7
         LjY8JiM7X07SQNt2vtPuW2VqQzqg8g5iSUZ/8mDcCa2OGjFnlSuGA7Nhf2uLWBEfZB
         p1ead9hCes0pQ==
Date:   Thu, 4 Aug 2022 11:50:52 -0700
From:   Nathan Chancellor <nathan@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Greg KH <gregkh@linuxfoundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
        Andrey Strachuk <strochuk@ispras.ru>
Subject: Re: [GIT PULL] USB / Thunderbolt driver changes for 6.0-rc1
Message-ID: <YuwVDE94jZVMMyX6@dev-arch.thelio-3990X>
References: <YuqB0tl2hjT3x7a4@kroah.com>
 <YuqXtcaUPflINBd6@dev-arch.thelio-3990X>
 <CAHk-=wjdoqmF4fC8orFv0pRZBUfgyQMGM8yS136_vZ=9=8uQ3Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wjdoqmF4fC8orFv0pRZBUfgyQMGM8yS136_vZ=9=8uQ3Q@mail.gmail.com>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 04, 2022 at 11:45:25AM -0700, Linus Torvalds wrote:
> On Wed, Aug 3, 2022 at 8:43 AM Nathan Chancellor <nathan@kernel.org> wrote:
> >
> > For the record, this breaks allmodconfig with clang (I haven't seen a
> > formal report on it anywhere and this missed -next coverage because
> > Stephen is on vacation):
> 
> Hmm. It passes my own internal clang testing, but that's for a more
> limited config.

I figured that would be the case. It appears that allmodconfig is now
broken for other reasons though (I missed the errors in -next amongst
some other breakage, I only caught it this morning around the same time
as Sudip):

https://lore.kernel.org/YuwRyQYPCb1FD+mr@debian/

> So I've merged this in my tree, but would appreciate a fixup patch if
> you have one.

I CC'd you on https://lore.kernel.org/20220803162422.2981308-1-nathan@kernel.org/,
let me know if you don't see it for some reason or if there is a better
fix.

Cheers,
Nathan
