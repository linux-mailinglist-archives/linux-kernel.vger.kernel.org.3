Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E2ECE57F49A
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Jul 2022 12:00:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231370AbiGXKAr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 24 Jul 2022 06:00:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229462AbiGXKAo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Jul 2022 06:00:44 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4834111834
        for <linux-kernel@vger.kernel.org>; Sun, 24 Jul 2022 03:00:42 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 01E3FB80D5B
        for <linux-kernel@vger.kernel.org>; Sun, 24 Jul 2022 10:00:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A5F93C3411E;
        Sun, 24 Jul 2022 10:00:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1658656839;
        bh=A4FHc+P9y/UxGoatQYWWeSdTQMu+VX8oS36oBmrynAo=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=mGqwt1OzRK2G0vTIgC026+s1UGmIMTpZtc++EhtzGRx5FUPu9VvBJ4xDxeiRiiSJN
         j+umsZvRUBYCHTIqaGqnkgVuYT2p/hLDhTIP3FQIwewSDXC+mZzfH9k2w5CFkpcIhh
         1xOyqBpOF14wtB4hGlcfWGJKWXZquHYWE9KsKzzNGv375W5p+d9C/CtO48YmGA34+y
         0AHA2HzBX9TLGOFKqoiWrBTs1QstMJBnihEx1rFoDojOzfVOjExZEJ0nQ+6Pe94XFu
         q/7/RPBARxrhD64DrLdv2gwpAcXxOzBMHEhPnGavegGndXLl6r/VB4EfZFpat6U3lm
         w1B/BPPKW/vJg==
Message-ID: <ebd98d0a-09c2-311f-0e82-ed87b3b7d66b@kernel.org>
Date:   Sun, 24 Jul 2022 18:00:36 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH] f2fs: don't bother wait_ms by foreground gc
Content-Language: en-US
To:     Jaegeuk Kim <jaegeuk@kernel.org>, qixiaoyu1 <qxy65535@gmail.com>
Cc:     linux-f2fs-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org, qixiaoyu1 <qixiaoyu1@xiaomi.com>
References: <20220718032840.9653-1-qixiaoyu1@xiaomi.com>
 <YtoOGu/wyqKBJd1v@google.com>
From:   Chao Yu <chao@kernel.org>
In-Reply-To: <YtoOGu/wyqKBJd1v@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022/7/22 10:40, Jaegeuk Kim wrote:
> On 07/18, qixiaoyu1 wrote:
>> f2fs_gc returns -EINVAL via f2fs_balance_fs when there is enough free
>> secs after write checkpoint, but with gc_merge enabled, it will cause
>> the sleep time of gc thread to be set to no_gc_sleep_time even if there
>> are many dirty segments can be selected.
>>
>> Signed-off-by: qixiaoyu1 <qixiaoyu1@xiaomi.com>

> 
> I applied without {} to match the coding style.

Reviewed-by: Chao Yu <chao@kernel.org>

Thanks,
