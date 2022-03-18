Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8331A4DD664
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Mar 2022 09:46:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233922AbiCRIr1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Mar 2022 04:47:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233918AbiCRIrY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Mar 2022 04:47:24 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5A662E625C
        for <linux-kernel@vger.kernel.org>; Fri, 18 Mar 2022 01:46:05 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 6183AB8219D
        for <linux-kernel@vger.kernel.org>; Fri, 18 Mar 2022 08:46:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 80E1CC340E8;
        Fri, 18 Mar 2022 08:46:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1647593163;
        bh=cWhrXvFTgU1ErDA0SpUZ0GqSHdi4e6cPHYhyBk/nnAk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:From;
        b=HkXAvEqfjW4y0Y9d10Fm4nJh6Pv3kZ8onmNVtoAG8zSMpgyvzOt6E7Fgs5YxQJqS3
         0XtvCnUHrkgMONiKPca6DtFwKeRQakIjCyd1GCsuegsW7PQ+M8SBPEyL+AkoJPuQdH
         B6YmSxSv7sjvV7DEAuFOYNK/MG6S4OcPZYZd0d+nTonhf+p6R9tdbWJjqXxOkmQ2iq
         Ygzrb8BI2DpKiEgNQIRbrKdizN5pJdWX5jomUS+McL2C57j5YsMTjJM2x+9611/8cR
         FyE7OYSlDsizFzz48RExcbrO2SOJvU/3HU2d1C0LWGQFzwqn7px0SCEcYSUJ+L6toI
         9TaFGP1cKtlGA==
From:   sj@kernel.org
To:     SeongJae Park <sj@kernel.org>
Cc:     roger.pau@citrix.com, jgross@suse.com, mheyne@amazon.de,
        xen-devel@lists.xenproject.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] xen-blk{back,front}: Update contact points for buffer_squeeze_duration_ms and feature_persistent
Date:   Fri, 18 Mar 2022 08:46:00 +0000
Message-Id: <20220318084600.26243-1-sj@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220301144628.2858-1-sj@kernel.org>
X-Spam-Status: No, score=-8.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Roger and Juergen,


May I ask your opinions to this patch, please?


Thanks,
SJ

On Tue, 1 Mar 2022 14:46:28 +0000 SeongJae Park <sj@kernel.org> wrote:

> SeongJae is currently listed as a contact point for some blk{back,front}
> features, but he will not work for XEN for a while.  This commit
> therefore updates the contact point to his colleague, Maximilian, who is
> understanding the context and actively working with the features now.
> 
> Signed-off-by: SeongJae Park <sj@kernel.org>
> Signed-off-by: Maximilian Heyne <mheyne@amazon.de>
> ---
>  Documentation/ABI/testing/sysfs-driver-xen-blkback  | 4 ++--
>  Documentation/ABI/testing/sysfs-driver-xen-blkfront | 2 +-
>  2 files changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/Documentation/ABI/testing/sysfs-driver-xen-blkback b/Documentation/ABI/testing/sysfs-driver-xen-blkback
> index a74dfe52dd76..7faf719af165 100644
> --- a/Documentation/ABI/testing/sysfs-driver-xen-blkback
> +++ b/Documentation/ABI/testing/sysfs-driver-xen-blkback
> @@ -29,7 +29,7 @@ Description:
>  What:           /sys/module/xen_blkback/parameters/buffer_squeeze_duration_ms
>  Date:           December 2019
>  KernelVersion:  5.6
> -Contact:        SeongJae Park <sj@kernel.org>
> +Contact:        Maximilian Heyne <mheyne@amazon.de>
>  Description:
>                  When memory pressure is reported to blkback this option
>                  controls the duration in milliseconds that blkback will not
> @@ -39,7 +39,7 @@ Description:
>  What:           /sys/module/xen_blkback/parameters/feature_persistent
>  Date:           September 2020
>  KernelVersion:  5.10
> -Contact:        SeongJae Park <sj@kernel.org>
> +Contact:        Maximilian Heyne <mheyne@amazon.de>
>  Description:
>                  Whether to enable the persistent grants feature or not.  Note
>                  that this option only takes effect on newly created backends.
> diff --git a/Documentation/ABI/testing/sysfs-driver-xen-blkfront b/Documentation/ABI/testing/sysfs-driver-xen-blkfront
> index 61fd173fabfe..7f646c58832e 100644
> --- a/Documentation/ABI/testing/sysfs-driver-xen-blkfront
> +++ b/Documentation/ABI/testing/sysfs-driver-xen-blkfront
> @@ -12,7 +12,7 @@ Description:
>  What:           /sys/module/xen_blkfront/parameters/feature_persistent
>  Date:           September 2020
>  KernelVersion:  5.10
> -Contact:        SeongJae Park <sj@kernel.org>
> +Contact:        Maximilian Heyne <mheyne@amazon.de>
>  Description:
>                  Whether to enable the persistent grants feature or not.  Note
>                  that this option only takes effect on newly created frontends.
> -- 
> 2.17.1
