Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EC5B647E872
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Dec 2021 20:43:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350112AbhLWTm7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Dec 2021 14:42:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244856AbhLWTm6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Dec 2021 14:42:58 -0500
Received: from ms.lwn.net (ms.lwn.net [IPv6:2600:3c01:e000:3a1::42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C730C061401;
        Thu, 23 Dec 2021 11:42:58 -0800 (PST)
Received: from localhost (unknown [IPv6:2601:281:8300:104d::5f6])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id F07E96A2;
        Thu, 23 Dec 2021 19:42:57 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net F07E96A2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
        t=1640288578; bh=PJV/bq5x8wkVijX5HAMsOC0RPW3ghq1DWO8+dyh0Slg=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=VR4oeUV3ZziW8aAy7nrkWHiFx7QAGI4XPR0VDY6Ckrn5YOT7MxZINYTO4e0W4NA6y
         KECVpA2weKrKMQSO39SFQsOUOKZzHp46WKGcp8fM2vpUwn5UE39bMYdyhCGlwPdreX
         qQJ3GQ1ZpPSnEQnSxEEStMsU9k29l4CQnRGbkd3xO/SH1Kf3klr2s0ItCz4RqCopmh
         FTvBD4Q02x6k50xc3LqAgEXCzzzFo++fCMhDzSnqcfm529sIKabFQ+ooynAoaO+f0I
         9PVjK9p96vJX32TWJQ+7+9Ee7hfE4MCC24wX7/gJLK/pewf4Nyh/TBmRLkFfgCNz5o
         RtF7h3/+VbtTA==
From:   Jonathan Corbet <corbet@lwn.net>
To:     Randy Dunlap <rdunlap@infradead.org>, linux-kernel@vger.kernel.org
Cc:     Randy Dunlap <rdunlap@infradead.org>, linux-doc@vger.kernel.org
Subject: Re: [PATCH] Documentation/sphinx: fix typos of "its"
In-Reply-To: <20211222062354.23224-1-rdunlap@infradead.org>
References: <20211222062354.23224-1-rdunlap@infradead.org>
Date:   Thu, 23 Dec 2021 12:42:57 -0700
Message-ID: <878rwbf6pq.fsf@meer.lwn.net>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Randy Dunlap <rdunlap@infradead.org> writes:

> Use "its" for possessive form instead of the contraction "it's".
>
> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
> Cc: Jonathan Corbet <corbet@lwn.net>
> Cc: linux-doc@vger.kernel.org
> ---
>  Documentation/sphinx/kernel_abi.py  |    2 +-
>  Documentation/sphinx/kernel_feat.py |    2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)

Applied, thanks.

jon
