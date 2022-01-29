Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B9E0C4A2C1F
	for <lists+linux-kernel@lfdr.de>; Sat, 29 Jan 2022 07:29:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241399AbiA2G3h (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 29 Jan 2022 01:29:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241065AbiA2G3d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Jan 2022 01:29:33 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22D89C061714
        for <linux-kernel@vger.kernel.org>; Fri, 28 Jan 2022 22:29:32 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 74A97B810A9
        for <linux-kernel@vger.kernel.org>; Sat, 29 Jan 2022 06:29:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F351CC340E5;
        Sat, 29 Jan 2022 06:29:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1643437770;
        bh=qAe52EceE/ZktnrH9t02qqOXkPJeOr1aXAVgzP7cj1s=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=bGKgZgJapdwZZigk69QJrsUoRNGVRRFET8AAL6Y+oKdKrkyRdxu/AmwxR0JbhL/ma
         E4RfESH84YE6mos2ScF7QSudz2QkyQBseJiZmuij1QHj+efDjkQng6SG4lWXNPBJ10
         0XgcRCNwW/7/lWWWJh0SCclO3wYv6zash/PlhcFccphRLNI9tfMvAVks1xyX26Ec8j
         meFAP93pem50jSF3QZzlJZLQaqacCwTCXITQEgi3SopPGjOpQBoTKCwO9Btd0hlAGa
         eNwcEwpZrQHNtPEGl8hh2Xmby6ZASRJyYf6c/equNhcjWXhdlTYRIY8gxBQTUCdQxm
         +xrLyO0QUmAWA==
Message-ID: <513a1ad8-20b1-96a3-54c9-a8ce8773a087@kernel.org>
Date:   Sat, 29 Jan 2022 14:29:25 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.1
Subject: Re: [f2fs-dev] [PATCH 1/2] f2fs: move discard parameters into
 discard_cmd_control
Content-Language: en-US
To:     Jaegeuk Kim <jaegeuk@kernel.org>, linux-kernel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net
Cc:     Konstantin Vyshetsky <vkon@google.com>
References: <20220125202254.3111474-1-jaegeuk@kernel.org>
From:   Chao Yu <chao@kernel.org>
In-Reply-To: <20220125202254.3111474-1-jaegeuk@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022/1/26 4:22, Jaegeuk Kim wrote:
> From: Konstantin Vyshetsky <vkon@google.com>
> 
> This patch unifies parameters related to how often discard is issued and
> how many requests go out at the same time by placing them in
> discard_cmd_control. The move will allow the parameters to be modified
> in the future without relying on hard-coded values.
> 
> Signed-off-by: Konstantin Vyshetsky <vkon@google.com>
> Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>

Reviewed-by: Chao Yu <chao@kernel.org>

Thanks,
