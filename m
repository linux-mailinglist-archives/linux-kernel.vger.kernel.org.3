Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 500F458A45D
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Aug 2022 03:06:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234270AbiHEBFy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Aug 2022 21:05:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230160AbiHEBFw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Aug 2022 21:05:52 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1BC7D32BB6
        for <linux-kernel@vger.kernel.org>; Thu,  4 Aug 2022 18:05:52 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9A4C361886
        for <linux-kernel@vger.kernel.org>; Fri,  5 Aug 2022 01:05:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E0E64C433D6;
        Fri,  5 Aug 2022 01:05:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1659661551;
        bh=B7XxrfERBbTlIBqrM1waNRn5SpO/7um6JtmhY9AoCtQ=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=b1yFBpTR5VdyzsR21hKFUTdBpG2mnd9APc2Ws35mS0ZEFVPm+IA1RNfE6avnAf3PQ
         zqU1hl0Gq50c5hgBr6rDyM0tBMDpFbaYz7wHjW1dPPsJABxn9r7L8F2C5D48HKBRxb
         NYXxM+B1Mjhe2EHJ6ZW9tLUkjoornqA1nh1HLo/G5ckv9eUx9Ar0U7l8h2LJFnENRp
         KLOTHeXmGd9OcYOz4/fy9xfObl0EMzbCW1enu5w0GfYZ4czzBQ5CZh/vzIMs6GCLSb
         wmpxnya0hsV0hBcg0cfTsYjAkCmrjrd4kKCbUJjsJmlDjR9Bq9HI55PhcIXqvLLP2U
         ViP7RwB6vkvEQ==
Message-ID: <88992c8e-3a39-bfd2-4850-03d46ff6585a@kernel.org>
Date:   Fri, 5 Aug 2022 09:05:46 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [f2fs-dev] [PATCH] f2fs: fix to check compression feature before
 enabling file compression
Content-Language: en-US
To:     Eric Biggers <ebiggers@kernel.org>
Cc:     jaegeuk@kernel.org, linux-kernel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net
References: <20220804134140.14455-1-chao@kernel.org>
 <YuwP67c0oNjhojmt@gmail.com>
From:   Chao Yu <chao@kernel.org>
In-Reply-To: <YuwP67c0oNjhojmt@gmail.com>
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

On 2022/8/5 2:28, Eric Biggers wrote:
> How is this different from the same check that occurs earlier in the function?

Oops, I missed that one, please ignore this patch.

Thanks,
