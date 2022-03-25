Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7C5DB4E70A3
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Mar 2022 11:09:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358634AbiCYKKD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Mar 2022 06:10:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1358650AbiCYKJ6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Mar 2022 06:09:58 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E34D138189;
        Fri, 25 Mar 2022 03:08:05 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 56E75B827F0;
        Fri, 25 Mar 2022 10:08:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B6A3EC340E9;
        Fri, 25 Mar 2022 10:08:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1648202881;
        bh=qnTrwxZwlx4JG6ef5Hpqjr7DBS+5G7kxBbPkVdOe7v4=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
        b=TbC6WVNLkuiB6WiLwbiYIc3o/1tuKdJ1cgZDmibGQFeacOxRvaE7P5NOvcmwY5O7k
         xEbcX6AKPCzMdfQUjY5vQeawr4nCSZ1gFsHPQEIgNdkvXn/Vvudv7UyPqeJl9yt76c
         HrXN+73ndmvDjSEmLwu6VpydmIujy5SYaIF/beSawrX+GNCUsNYZwLxhQmp8OFspan
         fYbnlr9mDGz9tAIGYMzJIXktLNbug+m/LuVlqJxaDmTo8NEUNzi9iYWrN8KCmAgR3a
         Wn6VjQaWwcRWh5KZ7QIRYzuQo5sgvwpf3jujZO4frXajZ6m2piT/HXFM43ATxKy77F
         Sp/LwCvebj5RA==
From:   Kalle Valo <kvalo@kernel.org>
To:     Haowen Bai <baihaowen@meizu.com>
Cc:     <Larry.Finger@lwfinger.net>, <linux-wireless@vger.kernel.org>,
        <b43-dev@lists.infradead.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] wireless: broadcom: b43legacy: Fix assigning negative error code to unsigned variable
References: <1648108733-27272-1-git-send-email-baihaowen@meizu.com>
Date:   Fri, 25 Mar 2022 12:07:55 +0200
In-Reply-To: <1648108733-27272-1-git-send-email-baihaowen@meizu.com> (Haowen
        Bai's message of "Thu, 24 Mar 2022 15:58:53 +0800")
Message-ID: <87pmma8hvo.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-8.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Haowen Bai <baihaowen@meizu.com> writes:

> fix warning reported by smatch:
> drivers/net/wireless/broadcom/b43legacy/phy.c:1181 b43legacy_phy_lo_b_measure()
> warn: assigning (-772) to unsigned variable 'fval'
>
> Signed-off-by: Haowen Bai <baihaowen@meizu.com>
> ---
>  drivers/net/wireless/broadcom/b43legacy/phy.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

The prefix should be only "b43legacy:", I can fix that.

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
