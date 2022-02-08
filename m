Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8AB354ACE4C
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Feb 2022 02:49:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238405AbiBHBsg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Feb 2022 20:48:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345025AbiBHBne (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Feb 2022 20:43:34 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A97E2C061355
        for <linux-kernel@vger.kernel.org>; Mon,  7 Feb 2022 17:43:34 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 420D360E9D
        for <linux-kernel@vger.kernel.org>; Tue,  8 Feb 2022 01:43:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 249F8C340ED;
        Tue,  8 Feb 2022 01:43:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1644284613;
        bh=xaw81OWLyuHjUMNsu7vc3jEE0twr/5mqrEcd4KZXj60=;
        h=Date:Subject:To:References:From:In-Reply-To:From;
        b=hwmfAwJI3a0DoV58ZKIafVjMUKHn/jfkH6rq6AqYQSjc8B6hCM9FImI7Bc28gO5XI
         4j2iUZpgV7hmQf/2E2ZMi8Ym8TZroAR5Y9s84GrKtfZ3d9v+qx1DwejiGj4f7IWZ1k
         R/6EpMvGaKpRd4xycCZUePXXVODzo6TGVtf/vV9dULdDrxoocPI6iHudopkzdh1HiX
         bTGzIbMNGtZAlu6yDPIpYUdGACSe/TYRSsMLMBr92uQFsqw6XMUFMjueqq8mzatTXX
         /CJdwHEVVhzjyuWQ2mctgIOPfGK0MczJnK3bJykuHwfW4hfURefkQaaw7wGlJaXps0
         cX2HZPMfRHosw==
Message-ID: <38422afe-fed3-63ab-345f-04ff21c1a1cb@kernel.org>
Date:   Tue, 8 Feb 2022 09:43:30 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.1
Subject: Re: [f2fs-dev] [PATCH v3] f2fs: add a way to limit roll forward
 recovery time
Content-Language: en-US
To:     Jaegeuk Kim <jaegeuk@kernel.org>, linux-kernel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net
References: <20220127214102.2040254-1-jaegeuk@kernel.org>
 <YfsjEb2ii3eyPzng@google.com> <YgFsi7cvYOs6oB3e@google.com>
From:   Chao Yu <chao@kernel.org>
In-Reply-To: <YgFsi7cvYOs6oB3e@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022/2/8 3:01, Jaegeuk Kim wrote:
> This adds a sysfs entry to call checkpoint during fsync() in order to avoid
> long elapsed time to run roll-forward recovery when booting the device.
> Default value doesn't enforce the limitation which is same as before.
> 
> Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>

Reviewed-by: Chao Yu <chao@kernel.org>

Thanks,
