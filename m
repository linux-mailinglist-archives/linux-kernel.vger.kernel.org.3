Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 327564DC5BB
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Mar 2022 13:23:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233511AbiCQMYb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Mar 2022 08:24:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233509AbiCQMY2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Mar 2022 08:24:28 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE49BAC060
        for <linux-kernel@vger.kernel.org>; Thu, 17 Mar 2022 05:23:10 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3DA8060F28
        for <linux-kernel@vger.kernel.org>; Thu, 17 Mar 2022 12:23:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D6F41C340E9;
        Thu, 17 Mar 2022 12:23:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1647519789;
        bh=FMgPDbk2fBw3oYvS8YviKVNhODsyO44hJ1OmNfCDISo=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=ljufRSOjhQHYhrd85n5Myho6xsI7ty90UxcG8IIg35ZYbqTwNq7D/RHnlMHI0hFM+
         ghHs0QzGgmVMKOq6W6sofOkx4acz600s26sfdrSOQU3+jvLAKPaN9JE2sIa0RTOqro
         V8tPCcNMqaEV+sDBLbkfwsD09N2p/xbKbzbYBbcU8ZExwuFjaeofgBLCEXz3WuvU5e
         GM45pFkzBNbhwebgobXZp9aVP+yQV6xfLrGJ9XggMzZnVTaBT+EUdd4mLnHjF5rf6X
         AnpcUAfAwYiek0NB4MXo8Hg9X21L2t8sZCANEGGhwUPk1fy56xXT2Ibj8pFVRQC8Rk
         qQJQqrptrZ8cw==
Message-ID: <40bafa49-41a0-880d-d1bc-85124cf9f750@kernel.org>
Date:   Thu, 17 Mar 2022 20:23:06 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH v2] erofs: rename ctime to mtime
Content-Language: en-US
To:     Gao Xiang <hsiangkao@linux.alibaba.com>,
        linux-erofs@lists.ozlabs.org
Cc:     LKML <linux-kernel@vger.kernel.org>,
        David Anderson <dvander@google.com>
References: <YjFrSivX%2F%2F3sGdSr@B-P7TQMD6M-0146.local>
 <20220317114959.106787-1-hsiangkao@linux.alibaba.com>
From:   Chao Yu <chao@kernel.org>
In-Reply-To: <20220317114959.106787-1-hsiangkao@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-8.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022/3/17 19:49, Gao Xiang wrote:
> From: David Anderson <dvander@google.com>
> 
> EROFS images should inherit modification time rather than change time,
> since users and host tooling have no easy way to control change time.
> 
> To reflect the new timestamp meaning, i_ctime and i_ctime_nsec are
> renamed to i_mtime and i_mtime_nsec.
> 
> Signed-off-by: David Anderson <dvander@google.com>
> [ Gao Xiang: update document as well. ]
> Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>

Reviewed-by: Chao Yu <chao@kernel.org>

Thanks,
