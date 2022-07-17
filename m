Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2A2305774E8
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Jul 2022 09:22:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232764AbiGQHWt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 17 Jul 2022 03:22:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229544AbiGQHWr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Jul 2022 03:22:47 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F5EF18357
        for <linux-kernel@vger.kernel.org>; Sun, 17 Jul 2022 00:22:46 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 114A1B80D04
        for <linux-kernel@vger.kernel.org>; Sun, 17 Jul 2022 07:22:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 054A4C3411E;
        Sun, 17 Jul 2022 07:22:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1658042563;
        bh=uowBzTAtI0/7jqB0RPR1OcIA4voVXuqAMxbVN+P/1WI=;
        h=Date:Subject:To:References:From:In-Reply-To:From;
        b=HULUngCpkNemnED4/Sj1y39sLFVZwtYsM955a3BEqiBcsnmjSyP7X2Cbe/gnVY82o
         9qNYYP7SN6RwAe5N+CotE0c7bWNlwdLXL1sYOhEnwuDxtEX4WU7THJmd/6WVBMZcfm
         DY1FhyvqSIUEJf9n/nhnHIa1m4fRAAtw3SgF+ltbzs+Vaevw7VkN+81HWw6Je07xEW
         U6pOvSzley87wcWtWf2cIra806qX7fjjUfkBaVfkaWz1bTN0EzwlFIg6wuje3PWb3R
         COUI1w4UHmIsEd1OSy2n71TPcz86CGx4emfVkkx8gnDUILvPlmm5qT532nQ8SGUvXX
         uKF7Beo/1jG6w==
Message-ID: <b1a70a93-6773-ba7b-5e15-259a6e23793f@kernel.org>
Date:   Sun, 17 Jul 2022 15:22:39 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [f2fs-dev] [PATCH 1/3] f2fs: enforce single zone capacity
Content-Language: en-US
To:     Jaegeuk Kim <jaegeuk@kernel.org>, linux-kernel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net
References: <20220628234733.3330502-1-jaegeuk@kernel.org>
From:   Chao Yu <chao@kernel.org>
In-Reply-To: <20220628234733.3330502-1-jaegeuk@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022/6/29 7:47, Jaegeuk Kim wrote:
> In order to simplify the complicated per-zone capacity, let's support
> only one capacity for entire zoned device.
> 
> Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>

Reviewed-by: Chao Yu <chao@kernel.org>

Thanks,
