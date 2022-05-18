Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3FC3652BC52
	for <lists+linux-kernel@lfdr.de>; Wed, 18 May 2022 16:16:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237693AbiERNZG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 May 2022 09:25:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237691AbiERNZC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 May 2022 09:25:02 -0400
Received: from relay3-d.mail.gandi.net (relay3-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::223])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD1F61B0911;
        Wed, 18 May 2022 06:24:59 -0700 (PDT)
Received: (Authenticated sender: alexandre.belloni@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id 56A0260005;
        Wed, 18 May 2022 13:24:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1652880295;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=I+vBBqAryfNnRsKHLkdVyxuYm6KZkxcFZQ2pJ+ICG/c=;
        b=Y6jKx3YUXougK2qgJSvp4D98iFDO+B9IkH2ec4ep7td/2iYWdpnf7YDyf5MJhXN2Fh/LB/
        KSocaZc7Y6lPyjVmKMA8ZpPJ0Rsn93XAUVyYx3I63bXNgw+e8F4sHeqeJeDHgENQOlVJrk
        fdEstXKVpQ+BA6u1xWwQgqtN+Y8RKZWBSgP9eIUWzrbxMPONfab8crb+QJrqwjektr+7kl
        LiYxAXh+NQQrwJwa95kT+O80BDao1Fi9SV3YXPiCPkUsbDFeiVSkMW5fNM5uSMQ2yTTmab
        Cz8HKFzXNUXhK3Ek47r7xQJ4+myf5ILxW5813IN5kAL7PargaZ9juAp/YudBZA==
Date:   Wed, 18 May 2022 15:24:55 +0200
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     Yuan Can <yuancan@huawei.com>, linux-rtc@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, a.zummo@towertech.it,
        linkmauve@linkmauve.fr
Subject: Re: [PATCH] rtc: gamecube: Add missing iounmap in
 gamecube_rtc_read_offset_from_sram
Message-ID: <165288028162.357572.5433304952248720722.b4-ty@bootlin.com>
References: <20220511071354.46202-1-yuancan@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220511071354.46202-1-yuancan@huawei.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 11 May 2022 07:13:54 +0000, Yuan Can wrote:
> The hw_srnprot needs to be unmapped when gamecube_rtc_read_offset_from_sram returns.
> 
> 

Applied, thanks!

[1/1] rtc: gamecube: Add missing iounmap in gamecube_rtc_read_offset_from_sram
      commit: 6ddabcb106280db0f7344850adfce3dd6b171cbd

Best regards,

-- 
Alexandre Belloni, co-owner and COO, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
