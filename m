Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 72623481462
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Dec 2021 16:23:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240512AbhL2PXm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Dec 2021 10:23:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237012AbhL2PXl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Dec 2021 10:23:41 -0500
Received: from ms.lwn.net (ms.lwn.net [IPv6:2600:3c01:e000:3a1::42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03C3DC061574;
        Wed, 29 Dec 2021 07:23:40 -0800 (PST)
Received: from localhost (unknown [IPv6:2601:281:8300:104d::5f6])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id 8D3C12CA;
        Wed, 29 Dec 2021 15:23:39 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net 8D3C12CA
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
        t=1640791419; bh=Fgd1IEApQgGgD5aA/qn3y4383wZstwGT6BI7GYzaQEY=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=Tdzsuej5iFUKN+spl8PMtp6YMOL323W9I0aFHXe7aoyvdPbm0saDXJbC8tLOVOUMY
         kdG6ecyXQ/pbB0UBDqKa58JsNoSIA3MsUI9Hui0Jott8mb/H4V/VqMasD+zJ94dqhp
         HqMdhOXAzbbdqsr5fD8ppVpiNUridlnXWpq6G0AdwjJYLxQIFUcApdKSpg/Yeircin
         B6mWQRG7sYLspY54YxA/pcXHhre8Y2DVczSOFqIH4Ejk0IqGPcWWfkvKy1JoGqSO/G
         +DHvQXFRi70P4i2hhWtPjfOLXWqj4EiqODTyXsJrf/hb2KrmgPxFYZOpV08Djb8gUu
         C8q9/l6/8I0FA==
From:   Jonathan Corbet <corbet@lwn.net>
To:     Armin Wolf <W_Armin@gmx.de>, pali@kernel.org
Cc:     jdelvare@suse.com, linux@roeck-us.net, linux-doc@vger.kernel.org,
        linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/4] docs: hwmon: dell-smm-hwmon.rst: Replace ascii
 table with flat-table
In-Reply-To: <20211228153709.18317-3-W_Armin@gmx.de>
References: <20211228153709.18317-1-W_Armin@gmx.de>
 <20211228153709.18317-3-W_Armin@gmx.de>
Date:   Wed, 29 Dec 2021 08:23:38 -0700
Message-ID: <87k0fnbfk5.fsf@meer.lwn.net>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Armin Wolf <W_Armin@gmx.de> writes:

> flat-table is recommended over ascii art tables.
>
> Signed-off-by: Armin Wolf <W_Armin@gmx.de>
> ---
>  Documentation/hwmon/dell-smm-hwmon.rst | 60 +++++++++++++++++++-------
>  1 file changed, 44 insertions(+), 16 deletions(-)

FWIW, I totally disagree with that recommendation and should really just
take it out.  This patch makes it clear why: the new table is almost
entirely unreadable in the plain-text form.

Thanks,

jon
