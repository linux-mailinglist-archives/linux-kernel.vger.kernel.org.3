Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3A933470C27
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Dec 2021 22:02:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344287AbhLJVFz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Dec 2021 16:05:55 -0500
Received: from ms.lwn.net ([45.79.88.28]:53646 "EHLO ms.lwn.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S243297AbhLJVFy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Dec 2021 16:05:54 -0500
Received: from localhost (unknown [IPv6:2601:281:8300:104d::5f6])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id 4580D2CC;
        Fri, 10 Dec 2021 21:02:19 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net 4580D2CC
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
        t=1639170139; bh=GvSX/ZCZPs8U5XQqMREhp8iTFJQHrxzaFtmJBzs3WBk=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=RnAiA/uyNENHqLJBfKZOsInq156XxL6m9FQWmUBz4EOHEm9nh/h0OGam7Wq9aOYzl
         tspnUcE5J0UWOHdLMCAqTfa4UYf1DPIM0sQyh+7T1x/Fo4xHnEo+5M48zgUgxMZpZa
         uDMunCWWORl4bEBid740T/CEXeZqbA04lwO/EHepb7Lolg26fNmtkg7knc5o8PMOBn
         HxZKAFaXoCLEkH+xkOhrVYv1RR600+7mak2a2/nncWlXYtmRWBTl3f0xk/0ZvwzG/l
         1J7/GtOs1pZJQMwp0STYT66J+RTObiA9hsl9jDw+VRDyM1U4BpcKUuXpCAddpAzN8T
         ezL0nD0JqWX6w==
From:   Jonathan Corbet <corbet@lwn.net>
To:     Shuah Khan <skhan@linuxfoundation.org>
Cc:     Shuah Khan <skhan@linuxfoundation.org>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] docs: update self-protection __ro_after_init status
In-Reply-To: <20211208164051.8783-1-skhan@linuxfoundation.org>
References: <20211208164051.8783-1-skhan@linuxfoundation.org>
Date:   Fri, 10 Dec 2021 14:02:18 -0700
Message-ID: <87r1akqilh.fsf@meer.lwn.net>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Shuah Khan <skhan@linuxfoundation.org> writes:

> __ro_after_init is no longer new and under development. Update the
> document to reflect the correct status.
>
> Signed-off-by: Shuah Khan <skhan@linuxfoundation.org>
> ---
>  Documentation/security/self-protection.rst | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
>
> diff --git a/Documentation/security/self-protection.rst b/Documentation/security/self-protection.rst
> index f584fb74b4ff..910668e665cb 100644
> --- a/Documentation/security/self-protection.rst
> +++ b/Documentation/security/self-protection.rst
> @@ -81,8 +81,7 @@ of the kernel, gaining the protection of the kernel's strict memory
>  permissions as described above.
>  
>  For variables that are initialized once at ``__init`` time, these can
> -be marked with the (new and under development) ``__ro_after_init``
> -attribute.
> +be marked with the ``__ro_after_init`` attribute.
>  
Applied, thanks.

jon
