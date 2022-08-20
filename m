Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3408759AAB7
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Aug 2022 04:35:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243557AbiHTCcE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Aug 2022 22:32:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230039AbiHTCcC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Aug 2022 22:32:02 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB504B4EA8
        for <linux-kernel@vger.kernel.org>; Fri, 19 Aug 2022 19:32:01 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 76B3561944
        for <linux-kernel@vger.kernel.org>; Sat, 20 Aug 2022 02:32:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 95113C433D6;
        Sat, 20 Aug 2022 02:31:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1660962720;
        bh=0ifbXkwVaZDFn/JcHj2ZQnv4iXqWMem4eEs4IJYr9co=;
        h=Date:Subject:To:References:From:In-Reply-To:From;
        b=A/XfBhKCOr6ka1fD+wSWxejS+C3JnBcEbPgqo+hBPccQNAOKGJjJsIpSxtipoTi/q
         wfLAKyywPHHe1AxdpVgX4WCPo4E7f4crTbg0aC0V1KEbQo6Numq6f2BzJnqfO5YsQJ
         aougx4XnaAerZ41Q4cKYci14+PrZcYuJc8Jd3ru7uvX4OqwS8Yd61t8MCHvLjBOOFa
         pXkDVx7EXujXxN0/RcznaQ/xkHKiuGD75W4bRYzxVFd5iBu2ng/i0lKHRm7zLG/CEN
         vtLAOw3PAiz8m4yThHLC1N+gvrY2rN3CvWSX+f6V1fir/RqdHiEMOBnpmx7mQ2IeV8
         TwiB5vxOaAsKg==
Message-ID: <347f5fe4-1db6-a8ab-7ab7-398b72f4b2df@kernel.org>
Date:   Sat, 20 Aug 2022 10:31:57 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [f2fs-dev] [PATCH v2] f2fs: LFS mode does not support ATGC
Content-Language: en-US
To:     Jaegeuk Kim <jaegeuk@kernel.org>, linux-kernel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net
References: <20220811225454.2125297-1-jaegeuk@kernel.org>
 <YwAiZTYkFi/EP/Ls@google.com>
From:   Chao Yu <chao@kernel.org>
In-Reply-To: <YwAiZTYkFi/EP/Ls@google.com>
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

On 2022/8/20 7:53, Jaegeuk Kim wrote:
> ATGC is using SSR which violates LFS mode used by zoned device.
> 
> Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>

Reviewed-by: Chao Yu <chao@kernel.org>

Thanks,
