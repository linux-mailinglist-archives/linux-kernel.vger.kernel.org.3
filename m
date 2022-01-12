Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CA67248CBC5
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jan 2022 20:21:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350032AbiALTVR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Jan 2022 14:21:17 -0500
Received: from bhuna.collabora.co.uk ([46.235.227.227]:37242 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345087AbiALTVD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jan 2022 14:21:03 -0500
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: alyssa)
        with ESMTPSA id 9798E1F45401
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1642015262;
        bh=lVHuJTVCQf5aCg943yBiAayu7pXkQ77QSMPJdhYfbC0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=PBDxUUFsJpdNyl14wheLSRX1rijOtRWsEHWy8+cwOq/vwIcnuQ4ARBRlPnp8GrZJP
         aUSNZrx7bFzOgK07ZCIB75he9IyAKiPZNMXOj2DaXQSKL6nCBEbCZILQkPgF5VxcCx
         eMmugtJLiofXyXPERPP39vS61ytniy1VY1b+nTgmlNAhof7guJm8KADHARMFz6n5lI
         lCUqbaqpn0K2L+7cv2DgekyYTP+ips7cSflfDUnQWTqLB5zf3x4IUJf5tQ1O4yzYv+
         pBq9yG1UU4wHePivoVEdbBMvF67EycY/gbr43pEbPbP0Rt2dEL6EbRVeebEwXewsmd
         8hvRW7GLet/Fg==
Date:   Wed, 12 Jan 2022 14:20:54 -0500
From:   Alyssa Rosenzweig <alyssa@collabora.com>
To:     Steven Price <steven.price@arm.com>
Cc:     Alyssa Rosenzweig <alyssa.rosenzweig@collabora.com>,
        dri-devel@lists.freedesktop.org, Rob Herring <robh@kernel.org>,
        Tomeu Vizoso <tomeu.vizoso@collabora.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] drm/panfrost: Merge some feature lists
Message-ID: <Yd8qFqkTqzdUzOxc@maud>
References: <20220109170920.2921-1-alyssa.rosenzweig@collabora.com>
 <20220109170920.2921-3-alyssa.rosenzweig@collabora.com>
 <c34845c7-481b-91c1-d2ae-e239324f8364@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c34845c7-481b-91c1-d2ae-e239324f8364@arm.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> > Now that we only list features of interest to kernel space, lots of GPUs
> > have the same feature bits. To cut down on the repetition in the file,
> > merge feature lists that are identical between similar GPUs.
> > 
> > Note that this leaves some unmerged identical Bifrost feature lists, as
> > there are more features affecting Bifrost kernel space that we do not
> > yet hanlde.
> 
> NIT: s/hanlde/handle/ ;)
> 
> Do you have any features in mind that we're missing? The list looks very
> similar to the kbase one. And anyway it is simple enough to split again
> if we need to.

Just IDVS group size. For some reason I thought there were more when I
wrote that commit message. It's split to avoid churn in that patch.

Logically, this series should contain three patches, with the IDVS group
size enablement patch at the end. That was the series I wrote and
committed to disk. For review I split it out, since the feature clean-up
can land now, while the (RFC) IDVS group size patch needs
testing/benchmarking.
