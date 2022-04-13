Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D1E0A4FEFBF
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Apr 2022 08:22:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232226AbiDMGXy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Apr 2022 02:23:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230106AbiDMGXw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Apr 2022 02:23:52 -0400
Received: from mo4-p00-ob.smtp.rzone.de (mo4-p00-ob.smtp.rzone.de [85.215.255.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 594BD4B43C
        for <linux-kernel@vger.kernel.org>; Tue, 12 Apr 2022 23:21:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1649830881;
    s=strato-dkim-0002; d=goldelico.com;
    h=To:References:Message-Id:Cc:Date:In-Reply-To:From:Subject:Cc:Date:
    From:Subject:Sender;
    bh=LJRvFamIEYQrczzXgDWMZzfEL7kHNDOQt0HO5Y0yIQ4=;
    b=b4hD/fiHVKW3HxPLVZqDbdeae9euBHsNfH7NnAAxDsLLv1jkX6S71unk2GvRbN9CoA
    0ycy4YvxVAIeLoPed1pCEiaQoyTMLX047MRVJxPsAVKXuQ2y8VNxyhOasJsUgMXYraOo
    3AG/TMCq+EkW3EbSxJe+3yzm/umDNOHoUmZV3pbMlIC/s3Xw42WQ78mWVZ6p+jZPQApY
    URSGwegJwmo3IAgf+dIMOu0MrrCJqOeVoPF74NsZDdx7PK2gpgPjOPIIFjaaWAyHRIdY
    flgxx7d/lHpih0hqvPJbhOXFKOqwwExZUKN9w35wvIi89Wh1Eh9OhpFPfFxAzMFs9Z0W
    m2pw==
Authentication-Results: strato.com;
    dkim=none
X-RZG-AUTH: ":JGIXVUS7cutRB/49FwqZ7WcJeFKiMgPgp8VKxflSZ1P34KBj4Qpw9iZeHWElw4nvnQ=="
X-RZG-CLASS-ID: mo00
Received: from mbp-13-nikolaus.fritz.box
    by smtp.strato.de (RZmta 47.42.2 DYNA|AUTH)
    with ESMTPSA id k708cfy3D6LK7bg
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (curve X9_62_prime256v1 with 256 ECDH bits, eq. 3072 bits RSA))
        (Client did not present a certificate);
    Wed, 13 Apr 2022 08:21:20 +0200 (CEST)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 12.4 \(3445.104.21\))
Subject: Re: linux-next: Fixes tag needs some work in the omap-fixes tree
From:   "H. Nikolaus Schaller" <hns@goldelico.com>
In-Reply-To: <20220413070201.248a9b11@canb.auug.org.au>
Date:   Wed, 13 Apr 2022 08:21:18 +0200
Cc:     Tony Lindgren <tony@atomide.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Content-Transfer-Encoding: 7bit
Message-Id: <773CBF24-F8B7-481F-BBCE-53C13198FBED@goldelico.com>
References: <20220413070201.248a9b11@canb.auug.org.au>
To:     Stephen Rothwell <sfr@canb.auug.org.au>
X-Mailer: Apple Mail (2.3445.104.21)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Stephen,

> Am 12.04.2022 um 23:02 schrieb Stephen Rothwell <sfr@canb.auug.org.au>:
> 
> Hi all,
> 
> In commit
> 
>  9be24a73de12 ("ARM: dts: Fix mmc order for omap3-gta04")
> 
> Fixes tag
> 
>  Fixes: commit a1ebdb374199 ("ARM: dts: Fix swapped mmc order for omap3")
> 
> has these problem(s):
> 
>  - leading word 'commit' unexpected

Ah, I see.
Diff of patch is good but the commit message needs editing.

What is the procedure to fix this case?

BR and thanks,
Nikolaus
