Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 84E1E559F62
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Jun 2022 19:26:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231801AbiFXRJI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Jun 2022 13:09:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231772AbiFXRJC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jun 2022 13:09:02 -0400
Received: from relay4-d.mail.gandi.net (relay4-d.mail.gandi.net [217.70.183.196])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BFB4B51E7E;
        Fri, 24 Jun 2022 10:09:01 -0700 (PDT)
Received: (Authenticated sender: alexandre.belloni@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id BBE9DE0005;
        Fri, 24 Jun 2022 17:08:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1656090540;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Vu75/Qb+i/F4hmojAa19FfVuxCVN3Y8Kms3HlIXz4Bw=;
        b=EPrBT8fGVuNJl/TAirSVa37usMnguJ0f1Y0xCAG/d96OU78UCw5V15KNdh1kTrqTzhmwRM
        5KkxbWDqBAC262Hmr4xvEWBpm1YlY2uOsVyvSJv2IJL6Bwnzmtm5afkDZF+jTO0ACeyaSv
        1d+WlMjNucOXDEg/loZSQZuHMEZlQ370ElPpojW0jgN3qSAbLz7NN1TMlBJTF459MWJfI1
        fl1yBlNFto30n88gyTf49IaFemdXouxYWDlvx9j9jAoadjyPmQX9eDyUX7isx8z6x3f2xn
        TDD8+4W7iAjcja+49M1ktfCke0ltcy/7sPw5AB+Hmjo3PtzcS4FLDfQ5Hks4Ig==
Date:   Fri, 24 Jun 2022 19:08:58 +0200
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     foss+kernel@0leil.net
Cc:     linux-rtc@vger.kernel.org, quentin.schulz@theobroma-systems.com,
        linux-kernel@vger.kernel.org, a.zummo@towertech.it
Subject: Re: [PATCH] rtc: isl1208: do not advertise update interrupt feature
 if no interrupt specified
Message-ID: <165609051724.27429.18295826165750824603.b4-ty@bootlin.com>
References: <20220523145320.123713-1-foss+kernel@0leil.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220523145320.123713-1-foss+kernel@0leil.net>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 23 May 2022 16:53:20 +0200, Quentin Schulz wrote:
> From: Quentin Schulz <quentin.schulz@theobroma-systems.com>
> 
> If an ISL1208 device does not have an interrupt line routed, the feature
> shouldn't be advertised (it is by default in rtc core) or it'll confuse
> userspace requesting that feature (such as hwclock from util-linux).
> 
> 
> [...]

Applied, thanks!

[1/1] rtc: isl1208: do not advertise update interrupt feature if no interrupt specified
      commit: ddc9c54b6b993bca4aa810402b17a0f42c5744d1

Best regards,

-- 
Alexandre Belloni, co-owner and COO, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
