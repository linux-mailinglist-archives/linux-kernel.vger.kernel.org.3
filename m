Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 17B0A463E02
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Nov 2021 19:49:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235004AbhK3SwV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Nov 2021 13:52:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235446AbhK3Svu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Nov 2021 13:51:50 -0500
Received: from mx.msync.work (mx.msync.work [IPv6:2a01:4f9:2b:2dc2::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EEBE9C061574
        for <linux-kernel@vger.kernel.org>; Tue, 30 Nov 2021 10:48:29 -0800 (PST)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id C5E601DE666;
        Tue, 30 Nov 2021 18:48:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lexina.in; s=dkim;
        t=1638298105; h=from:subject:date:message-id:to:cc:mime-version:content-type:
         content-transfer-encoding:content-language:in-reply-to:references;
        bh=2K089Pbd0oSMczdLCEfwYn+aFTao6UTxexX29vUAZ4k=;
        b=GDK6LiPto1hQd0z2ydVWtojuhoFlliIE5f9Hvkz+wCozJ3G48kGqwBwaedjDGcY77e/MaW
        9eDHb4L7vy1TGLg4Ggg9J0awigaKmRfFmlYpyybVbxKlSzBYyFe9OwNnOgtEYQ66/PWXqq
        WLLNXy1r2rvPnAoI+DGJdX0IbFWt+FRQOdeAXJbP/cYS5f45psBhLORBYqp9PGXCkTIkVJ
        hRLj6VGkbYeOTTo4fNGeAB94XmN4ErsLMp0j/whMc0lEQKuotUfSJXIZKPwB9FSpBGGiDp
        GfT3hDZBxRwI4SKoSkr25Be/pVeGCUeWRu4gAb9iFA/Zpxxq5UDuMdnTGCgakA==
Message-ID: <2ee1dea9-df39-ee76-4079-0ded15ed43c7@lexina.in>
Date:   Tue, 30 Nov 2021 21:48:22 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.2
Subject: Re: [PATCH] arm64: meson: fix dts for JetHub D1
Content-Language: ru
To:     Neil Armstrong <narmstrong@baylibre.com>,
        Kevin Hilman <khilman@baylibre.com>
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org
References: <20211125130246.1086627-1-adeep@lexina.in>
 <163826896367.1309037.1000352899984422910.b4-ty@baylibre.com>
From:   Vyacheslav <adeep@lexina.in>
In-Reply-To: <163826896367.1309037.1000352899984422910.b4-ty@baylibre.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



30.11.2021 13:43, Neil Armstrong пишет:
> Hi,
> 
> On Thu, 25 Nov 2021 16:02:47 +0300, Vyacheslav Bocharov wrote:
>> Fix misplace of cpu_cooling_maps for JetHub D1, move it to right place.
>>
>>
> 
> Thanks, Applied to https://git.kernel.org/pub/scm/linux/kernel/git/amlogic/linux.git (v5.17/dt64)
Thanks. Could the patch get into 5.16?

> 
> [1/1] arm64: meson: fix dts for JetHub D1
>        https://git.kernel.org/amlogic/c/03caf87822220b4e22c349d170881d122df0b349
> 
