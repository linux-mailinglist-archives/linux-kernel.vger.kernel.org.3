Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3F9AF484780
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jan 2022 19:10:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235710AbiADSKP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Jan 2022 13:10:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234495AbiADSKO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jan 2022 13:10:14 -0500
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E6B0C061761
        for <linux-kernel@vger.kernel.org>; Tue,  4 Jan 2022 10:10:14 -0800 (PST)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: wlozano)
        with ESMTPSA id D6F991F43D38
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1641319812;
        bh=EP9qs2TSWUslRqwjtXoUQPJRHvy9rOdJWe+gcNWACyw=;
        h=Date:From:Subject:To:Cc:From;
        b=N9/lloEmKGYdZvrhzJGUr7CoAKiNKbQmxeuHwbquT+V40iUH9cwU3CL6MTzxGY2Yi
         yB+5gJ80e8V+T0zubx119mJRe9oWIL3+9uIriR0Lgv9DF94QJBXJ0aEE83URsV260r
         FZV16/4qwwUmWedZ3dt9r12XhfZsSioHf8x2txvdp4m33P+A4Bf5C7hb0MIPvdG3gG
         A47oSYjffq0zbBG+to8P523ZkfqaricPgCbHFGuI27L4VWeyjuStG7bUyn/fo6rXNZ
         PvBgJxLJ1kuGHVS19xZACb6/mM2d24OilD3sCUGCzSkrPuXbMhQMSvksZFQqSXjhwj
         EPeU4huZCnBkQ==
Message-ID: <be290dc3-db9c-2940-91bb-c91bf42fd8f6@collabora.com>
Date:   Tue, 4 Jan 2022 15:10:06 -0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.0
From:   Walter Lozano <walter.lozano@collabora.com>
Subject: Occasional hung with UM after enable VMAP_STACK
To:     johannes@sipsolutions.net, linux-um@lists.infradead.org,
        linux-kernel@vger.kernel.org
Cc:     Sjoerd Simons <sjoerd.simons@collabora.com>,
        ritesh sarraf <ritesh.sarraf@collabora.com>
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

I noticed that after "um: enable VMAP_STACK" [1] I experienced some 
occasional hung in my Gitlab CI jobs that use user-mode-linux to build 
distro images. The configuration use for the building is the one 
available from Debian, see [2] and [3]. Unfortunately I don't have much 
information, when the issue arises the job seems to hang and it is 
cancelled by Gitlab due to a job timeout.

So far I did some bisect to get the commit which introduces the issue 
and a quick check with latest Linux stable branch master to confirm the 
issue is still present. I know this is not a proper bug report but I 
thought it will be better to at least raise a comment.

Thanks in advance,

Walter

[1] http://lists.infradead.org/pipermail/linux-um/2021-August/001657.html

[2] https://packages.debian.org/bookworm/user-mode-linux

[3] https://salsa.debian.org/uml-team/user-mode-linux

-- 
Walter Lozano
Collabora Ltd.

