Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 11F3350BC92
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Apr 2022 18:05:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232195AbiDVQI0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Apr 2022 12:08:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1381781AbiDVQIR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Apr 2022 12:08:17 -0400
X-Greylist: delayed 6962 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Fri, 22 Apr 2022 09:05:22 PDT
Received: from relay2.mymailcheap.com (relay2.mymailcheap.com [217.182.66.162])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC82F366AC
        for <linux-kernel@vger.kernel.org>; Fri, 22 Apr 2022 09:05:22 -0700 (PDT)
Received: from filter1.mymailcheap.com (filter1.mymailcheap.com [149.56.130.247])
        by relay2.mymailcheap.com (Postfix) with ESMTPS id 75D77401F1;
        Fri, 22 Apr 2022 18:05:20 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by filter1.mymailcheap.com (Postfix) with ESMTP id CF2632A2AE;
        Fri, 22 Apr 2022 16:05:19 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at filter1.mymailcheap.com
Received: from filter1.mymailcheap.com ([127.0.0.1])
        by localhost (filter1.mymailcheap.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id JWSIRcwiyJko; Fri, 22 Apr 2022 16:05:18 +0000 (UTC)
Received: from mail20.mymailcheap.com (mail20.mymailcheap.com [51.83.111.147])
        (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by filter1.mymailcheap.com (Postfix) with ESMTPS;
        Fri, 22 Apr 2022 16:05:18 +0000 (UTC)
Received: from [172.16.2.1] (unknown [121.33.113.197])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by mail20.mymailcheap.com (Postfix) with ESMTPSA id 2BD37401C2;
        Fri, 22 Apr 2022 16:05:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=aosc.io; s=default;
        t=1650643518; bh=eSCJW22OL39yu1fNYYsjsin+Of6eOz171PLc8jDmgmc=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=pOh9wMbrjj3DZf5iJcy4UlxJwlXf6AewbaBHOM91h1M4yHOcMDj3BH5zD4prUYnjJ
         n9ak1lxM2xvVr094vVga2zQou5uJeW31zezwdL3RgMwgG0oRwc9tGm2qnlqXnn7Njc
         ScBdQHwwE5N+qfhzCbkXA4hu/JKVuvc0L2bxpX+c=
Message-ID: <07133d7ded3a9059f89d668f14e923b3d1bddd43.camel@aosc.io>
Subject: Re: [PATCH 0/3] btrtl: try to use OF machine compatible as config
 postfix
From:   Icenowy Zheng <icenowy@aosc.io>
To:     Marcel Holtmann <marcel@holtmann.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc:     linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-sunxi@lists.linux.dev
Date:   Sat, 23 Apr 2022 00:05:09 +0800
In-Reply-To: <BYAPR20MB2472590CD7F6385C0E002763BCF79@BYAPR20MB2472.namprd20.prod.outlook.com>
References: <BYAPR20MB2472590CD7F6385C0E002763BCF79@BYAPR20MB2472.namprd20.prod.outlook.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.40.4 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,T_SPF_PERMERROR
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

在 2022-04-23星期六的 00:02 +0800，icenowy@outlook.com写道：
> From: Icenowy Zheng <icenowy@aosc.io>
> 

Sorry, but the original commiter email of patches inside this patchset
is no longer accessible.

If possible, please send reviews to this aosc.io address.

> Currently for OF machines there's no way to specify a machine-
> specific
> btrtl config file.
> 
> Try to use OF machine compatible string as config postfix, in a
> similar
> manner with brcmfmac driver (which needs machine-specific config
> files
> too).
> 
> Icenowy Zheng (3):
>   Bluetooth: btrtl: try config w/o postfix if postfixed one failed to
>     load
>   Bluetooth: btrtl: use board DT compatible string as config postfix
>   Bluetooth: btrtl: allow longer config file name
> 
>  drivers/bluetooth/btrtl.c  |  8 +++++++-
>  drivers/bluetooth/hci_h5.c | 27 +++++++++++++++++++++++++++
>  2 files changed, 34 insertions(+), 1 deletion(-)
> 


