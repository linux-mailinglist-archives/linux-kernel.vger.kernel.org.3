Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 441A04D3C8E
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Mar 2022 23:04:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236052AbiCIWFD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Mar 2022 17:05:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231388AbiCIWFC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Mar 2022 17:05:02 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE0DAE0A0F
        for <linux-kernel@vger.kernel.org>; Wed,  9 Mar 2022 14:04:02 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 78FA2B823FB
        for <linux-kernel@vger.kernel.org>; Wed,  9 Mar 2022 22:04:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E02FFC340E8;
        Wed,  9 Mar 2022 22:03:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1646863440;
        bh=SSpfr1b2f3+DNRdsuvOihzlrhkKi+VQ6CxXUEoX5hjk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=qfrxohpjXBAm8VmdaiLrg1/L0mE5flr2o/g5J2z9bsXM2YjjVlgVRo1vpfa5rLfeM
         KLQVLPxAw/KcKpAMrWlivbTtm/RQgf+JypnVFd63NHcuEZusenBsypd+0DzFbcfg+f
         csAEilzxq9SMYbOnZZFhFJ2VoPh5qE2+nb9yw4v2FuJiLYjgt4eLal3IjTCQYpce2T
         UQ3UyWiSFzn872tTqMNZVoUOVkmK9PqS4FHYcEVwZmSqdsqkfFw8iOFgVajdwUdE8S
         l7SieavFgIMUMgYvAy/wZfjh+nN5q3jJh4chBAY7V+1eU2HGd4ihmTAvveFTmu74Nc
         nOuQqqMCBDzZw==
Date:   Wed, 9 Mar 2022 14:03:58 -0800
From:   Jaegeuk Kim <jaegeuk@kernel.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Christoph Hellwig <hch@lst.de>, Chao Yu <chao@kernel.org>,
        linux-f2fs-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] f2fs: pass the bio operation to bio_alloc_bioset
Message-ID: <YikkTgK7aXvONopy@google.com>
References: <20220228124123.856027-1-hch@lst.de>
 <20220228124123.856027-3-hch@lst.de>
 <782226e0-5e7a-aec8-b9aa-e7fd7b3110a7@kernel.org>
 <20220308060624.GA23629@lst.de>
 <779bf1fe-7f58-51ed-27e8-1152375780ff@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <779bf1fe-7f58-51ed-27e8-1152375780ff@kernel.dk>
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jens,

On 03/08, Jens Axboe wrote:
> On 3/7/22 11:06 PM, Christoph Hellwig wrote:
> > On Tue, Mar 01, 2022 at 10:49:06AM +0800, Chao Yu wrote:
> >> On 2022/2/28 20:41, Christoph Hellwig wrote:
> >>> Refactor block I/O code so that the bio operation and known flags are set
> >>> at bio allocation time.  Only the later updated flags are updated on the
> >>> fly.
> >>>
> >>> Signed-off-by: Christoph Hellwig <hch@lst.de>
> >>
> >> Reviewed-by: Chao Yu <chao@kernel.org>
> > 
> > Is it okay for Jens to pick these two patches up in the
> > https://git.kernel.dk/cgit/linux-block/log/?h=for-5.18/alloc-cleanups
> > branch?
> 
> I have tentatively done so, let me know you prefer doing it differently.

I've acked to the patches, and it seems they need to be landed in block.
Thank you.

> 
> -- 
> Jens Axboe
