Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1274759ED7B
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Aug 2022 22:39:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229896AbiHWUji (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Aug 2022 16:39:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229602AbiHWUjH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Aug 2022 16:39:07 -0400
Received: from relay8-d.mail.gandi.net (relay8-d.mail.gandi.net [217.70.183.201])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F4042C46;
        Tue, 23 Aug 2022 13:26:29 -0700 (PDT)
Received: (Authenticated sender: alexandre.belloni@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id 0E66D1BF205;
        Tue, 23 Aug 2022 20:26:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1661286388;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ed9iH3VFoFHKfhjc2nySTLKMJ8dZdb4tzbXkI6uSJY8=;
        b=NzsO0gj1x51iUw9WHQ6Bnz159kLGX7PkJsRKWCZypp+4eDG1LPMU+0kWP3h5GzGVN9Ar3k
        pjZ7qQvnWpRdLRDWe6wFSAB24/hjc/1Xx9uHQSppllHk4BWucQOBSZMfx+SsK4HLY6HSwv
        csZeMHdutp9je8BAmjAx8razoEfQzKs21KxhzzhV637SOT1gweCZ6PpKPcpckbGCpG9LFt
        S4sL8Zf2w5sD0tuHcBc7WAW6IQoYb/PZXQdxVsNXHdMbWHjMk2d0ItGrLBCA2qjial/bBX
        4HkRfiS3B7NCVd/b2zEWrgZsp3EElAHu0pgb9mzl45e+KQAhCQPPauC8PIw2hA==
Date:   Tue, 23 Aug 2022 22:26:27 +0200
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     a.zummo@towertech.it, bb@ti.com
Cc:     linux-kernel@vger.kernel.org, linux-rtc@vger.kernel.org, nm@ti.com
Subject: Re: [PATCH 1/2] rtc: k3: wait until the unlock field is not zero
Message-ID: <166128635878.2842107.6230313142974608612.b4-ty@bootlin.com>
References: <20220816173312.23243-1-bb@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220816173312.23243-1-bb@ti.com>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 16 Aug 2022 12:33:11 -0500, Bryan Brattlof wrote:
> After writing the magic words to the KICK0 and KICK1 registers, we must
> wait for a 1 in the unlock field of the general control register to
> signify when the rtc device is in an unlocked state.
> 
> 

Applied, thanks!

[1/2] rtc: k3: wait until the unlock field is not zero
      commit: f2c5671a64d2a79341e8ee45d5933f6a76960189
[2/2] rtc: k3: detect SoC to determine erratum fix
      commit: 1e2585b49d849196f359bbf86677943fe2d80afe

Best regards,

-- 
Alexandre Belloni, co-owner and COO, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
