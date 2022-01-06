Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9D5EF486D39
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jan 2022 23:29:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245122AbiAFW3j (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Jan 2022 17:29:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245095AbiAFW3i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jan 2022 17:29:38 -0500
Received: from ms.lwn.net (ms.lwn.net [IPv6:2600:3c01:e000:3a1::42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51609C061245;
        Thu,  6 Jan 2022 14:29:38 -0800 (PST)
Received: from localhost (unknown [IPv6:2601:281:8300:104d::5f6])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id CF7564A6;
        Thu,  6 Jan 2022 22:29:37 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net CF7564A6
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
        t=1641508178; bh=5nihu8RlJCQgeS4a5geT49tU31i3B7MpQB0TVfiDUOY=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=KQvFzyypLpXIPoRAgZMjqUPsZHFLxPUOCbIiJTMs1oJrg8m/mXSQehmILpG/7pH4S
         C5FcAC+NBE5oRrzWJgPLVuul634UCd/LYuT2B5Cj3186neritEkwhEcILiTVR23QVW
         5P6Se7kw60juw8tHqXmISJQlheDTBV5MqDVb/E/9y66jUtAKmSE8sNr47HLLBIwk5C
         ksvQZxBCUBx97JPCP7VxOgDHl2Sqq/AoUhZQi/3wmEQOBb6Tv1oT2WE60Yb6P09q//
         z+7JpmUE8lnJUVySaw+CT0hHMSkm66QSh3ZFun6/Sbs3y9qafH6gnZ8OYi6R0F1p+u
         Ey41H2lnAlKMg==
From:   Jonathan Corbet <corbet@lwn.net>
To:     Thorsten Leemhuis <linux@leemhuis.info>, linux-doc@vger.kernel.org
Cc:     workflows@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Konstantin Ryabitsev <konstantin@linuxfoundation.org>,
        Randy Dunlap <rdunlap@infradead.org>
Subject: Re: [PATCH v2] docs: 5.Posting.rst: describe Fixes: and Link: tags
In-Reply-To: <c4a5f5e25fa84b26fd383bba6eafde4ab57c9de7.1641314856.git.linux@leemhuis.info>
References: <c4a5f5e25fa84b26fd383bba6eafde4ab57c9de7.1641314856.git.linux@leemhuis.info>
Date:   Thu, 06 Jan 2022 15:29:44 -0700
Message-ID: <87bl0opkfb.fsf@meer.lwn.net>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thorsten Leemhuis <linux@leemhuis.info> writes:

> Explain Fixes: and Link: tags in Documentation/process/5.Posting.rst,
> which are missing in this file for unknown reasons and only described in
> Documentation/process/submitting-patches.rst.
>
> Signed-off-by: Thorsten Leemhuis <linux@leemhuis.info>
> CC: Konstantin Ryabitsev <konstantin@linuxfoundation.org>

Applied, thanks.

jon
