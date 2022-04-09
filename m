Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2501E4FA167
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Apr 2022 03:47:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240227AbiDIBtU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Apr 2022 21:49:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229490AbiDIBtS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Apr 2022 21:49:18 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C16F38DB3;
        Fri,  8 Apr 2022 18:47:13 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id BD3956221F;
        Sat,  9 Apr 2022 01:47:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 11AD7C385A1;
        Sat,  9 Apr 2022 01:47:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1649468832;
        bh=3QQ/+sw7zjk5GcFkLao0bBqHI5QBDVe2Le75SeHVzv0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=IMemyBydUGRiLyonnv9uUGsm2/mEYJQjyCeQd9xFCb7nxLjlczmTyNjnA0E/dEcj5
         fkwTuN/aiQnse0UYbbJe0SW4ygxSM+C2gNAA+MrW2iHPbWfT2u5jA8awS/oZvQaPVG
         IEyAZo5KcCS2nufnrQpjlBkCG19ibMjltl1voxuykz7HT64ncFFlMFArh9q/IsxiFF
         3lGdP4DGfrRXIY97uW/+L9ShcBE3RnQm6+cIgoHO1U8B5EdqGOl+4pbmuMWtF8gW1+
         bJ2wYoXdEeCWy4bf+7oH6A/2wVVb/zLG2qoy1m2nHj0YUYdlxc8w38LFojbglnQBzn
         ZP8DS8mxA6gFQ==
Date:   Sat, 9 Apr 2022 09:47:02 +0800
From:   Peter Chen <peter.chen@kernel.org>
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: Re: linux-next: please clean up the usb-chipidea-fixes/next trees
Message-ID: <20220409014702.GA3421@Peter>
References: <20220406113242.3d7aefbd@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220406113242.3d7aefbd@canb.auug.org.au>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 22-04-06 11:32:42, Stephen Rothwell wrote:
> Hi all,
> 
> [Try again to an address that may work ...]
> 
> The usb-chipidea-fixes and -next trees have not been updated since Oct,
> 2021 and the -fixes tree is generating a conflict when merged.  Please
> clean them it up WRT Linus' tree as the only patches in them have been
> merged as other commits.
> 

Hi Stephen,

Sorry about that. I have a little busy these years, the USB patches
which went to my tree will go to the Greg's USB tree directly, I only
review these patches now. Would you please also delete my tree from
your merge list? Thanks.

-- 

Thanks,
Peter Chen

