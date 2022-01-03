Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2F080483725
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jan 2022 19:45:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235697AbiACSp3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Jan 2022 13:45:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229796AbiACSp2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jan 2022 13:45:28 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64D44C061761;
        Mon,  3 Jan 2022 10:45:28 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 10F14B81094;
        Mon,  3 Jan 2022 18:45:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5A988C36AEE;
        Mon,  3 Jan 2022 18:45:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1641235525;
        bh=1nf0LLVBuyKdqNzhtLsgYxgDKiFETVjOaaMe10ks6B0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=MMcd71laQfvXEel6ekWVbeuhX8uOKjua/mZDpGCSsVu+zmArX/lcZPAyVaBIiDcz3
         Lk07fpFgAN4eEGytixxDJPLPBNoUE6XAcIy9PV+Ofzp0oyTiH1VCm6B6/l1zQo6lr+
         iMuxYcIzSQIMEcEMg8BFGQuD8SQ/L6JJy3qjPoXXpgg7qN1bITWK7zH+J82pe2lWGB
         YHgUEE+g+G9Z6nkhgy23z9Ps8enZhKUY2uSclamNmSpvO658mvaJRo0/+yWFfpIRug
         6Cnp6C3UuVeBiA/LBH2KSR5FZTPAadUxSAuD1TMLjvu8C0ySfZRo+7IfTbVGjxMX9e
         knp4VbiXgtclw==
Date:   Mon, 3 Jan 2022 11:45:21 -0700
From:   Nathan Chancellor <nathan@kernel.org>
To:     Mauro Carvalho Chehab <mchehab@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux Media Mailing List <linux-media@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        llvm@lists.linux.dev
Subject: Re: [GIT PULL for v5.17-rc1] New year's media updates
Message-ID: <YdNEQbgpBJP2lIiP@archlinux-ax161>
References: <20220101024250.39c9b5b6@coco.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220101024250.39c9b5b6@coco.lan>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Mauro,

On Sat, Jan 01, 2022 at 02:42:50AM +0100, Mauro Carvalho Chehab wrote:
>       media: atomisp: shift some structs from input_system_local

Please consider applying my patch that fixes this one to avoid breaking
certain distribution configurations when CONFIG_WERROR is enabled:

https://lore.kernel.org/r/20211227164243.2329724-1-nathan@kernel.org/

I know there has not been much time between when I sent it and now but
there have been two reports about it from the kernel test robot (one was
back in November) and it is rather noisy in a build.

https://lore.kernel.org/r/202111182229.beNw3l9E-lkp@intel.com/
https://lore.kernel.org/r/202112311809.bEKUPkjh-lkp@intel.com/

If it cannot be applied now because the tag has been created and the
pull has been sent, could you make sure it makes it in a fixes pull
request?

Thank you!
Nathan
