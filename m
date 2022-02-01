Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D8B694A5C30
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Feb 2022 13:26:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237991AbiBAM0N (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Feb 2022 07:26:13 -0500
Received: from sin.source.kernel.org ([145.40.73.55]:53252 "EHLO
        sin.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229532AbiBAM0K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Feb 2022 07:26:10 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id E6962CE184A;
        Tue,  1 Feb 2022 12:26:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D9657C340EB;
        Tue,  1 Feb 2022 12:26:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1643718367;
        bh=eHjoFrZQtYh4JUgQ+/QAfZhk5M1/GQ1oH1oKZQM2zZM=;
        h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
        b=Gt+6x/fhkdpHwoPmwOWxK7T9R7P6AUWo1XgeORHP8vGIMyPkz+CKO2UMm0zl5HLyq
         7+0L2hXkE7INZVJEYcX2wgMMwpqw6JcYvSzT/k4M28fFVp7p/XlZ/RXiJmX3AABdT3
         Fffstnl+9JA8grCjJwQ6ZQjiXN6xuhdDaM9ENj7cshWQXQitMqjtufUHM2OT3fu1Ly
         cPe+zruTmlOaz8xU05fdp0INRF7VWQ7b1V+/LtDIZ3Imz4sn3NEm9uYMLxaPoCW4Uz
         k9TnbT/xcdKSN1yc3xeAN6ZX9d9ppUD7YHxOr/ByvddLCEvfd2za1uacXlRp7ZS8bb
         c2G6ol1jNj1EA==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH] ssb: fix boolreturn.cocci warning
From:   Kalle Valo <kvalo@kernel.org>
In-Reply-To: <fa4f1fa737e715eb62a85229ac5f12bae21145cf.1642065490.git.davidcomponentone@gmail.com>
References: <fa4f1fa737e715eb62a85229ac5f12bae21145cf.1642065490.git.davidcomponentone@gmail.com>
To:     davidcomponentone@gmail.com
Cc:     m@bues.ch, davidcomponentone@gmail.com,
        linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org,
        Yang Guang <yang.guang5@zte.com.cn>,
        Zeal Robot <zealci@zte.com.cn>
User-Agent: pwcli/0.1.0-git (https://github.com/kvalo/pwcli/) Python/3.7.3
Message-ID: <164371836390.16633.773589948034456813.kvalo@kernel.org>
Date:   Tue,  1 Feb 2022 12:26:05 +0000 (UTC)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

davidcomponentone@gmail.com wrote:

> From: Yang Guang <yang.guang5@zte.com.cn>
> 
> The coccinelle report
> ./include/linux/ssb/ssb_driver_gige.h:98:8-9:
> WARNING: return of 0/1 in function
> 'ssb_gige_must_flush_posted_writes' with return type bool
> 
> Return statements in functions returning bool should use true/false
> instead of 1/0.
> 
> Reported-by: Zeal Robot <zealci@zte.com.cn>
> Signed-off-by: Yang Guang <yang.guang5@zte.com.cn>
> Signed-off-by: David Yang <davidcomponentone@gmail.com>

Patch applied to wireless-next.git, thanks.

6d3ac94bae21 ssb: fix boolreturn.cocci warning

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/fa4f1fa737e715eb62a85229ac5f12bae21145cf.1642065490.git.davidcomponentone@gmail.com/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

