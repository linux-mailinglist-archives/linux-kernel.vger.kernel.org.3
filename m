Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9D8A7581509
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Jul 2022 16:23:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239137AbiGZOW6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Jul 2022 10:22:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234137AbiGZOWy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jul 2022 10:22:54 -0400
Received: from relay11.mail.gandi.net (relay11.mail.gandi.net [IPv6:2001:4b98:dc4:8::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9DB561D32D;
        Tue, 26 Jul 2022 07:22:53 -0700 (PDT)
Received: (Authenticated sender: alexandre.belloni@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id 5C58310000A;
        Tue, 26 Jul 2022 14:22:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1658845372;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=kmoRPsvsm8/UPlpLddpkV5iEJSN+p+fT8s/uaK/xzVM=;
        b=kpsD3BJVPq0forflOECwiASHDS+dUHl45KSWX/FSmavM0AJBcnnOYQ1S6pQnV3iw0ulHwS
        e79IuE8LaSAml2eD8DGR4l7BUTndzWkvgszyjJcS6A8YPJuNZXy/0H4bgvW6mABel4+kLf
        9lSlZC9ZMsNWnp6Oz07XcygRWx91+cWHlkXCWGbT4rkBzl7Bc4x5LqUTR/U+7iT1MKZZXz
        fTD3mgPHjrlITLFfouTC7cotwjQKj0hYlTC7GraRMui/B2opQ0QDvJi3mp13ZwFJ49bpHS
        HiHExpNuWKrRPp744tozPKbFuNDZLQ/GrBB7fDQ6I3MSTHQtpvVrhvBJqvz+eA==
Date:   Tue, 26 Jul 2022 16:22:50 +0200
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     lewis.hanly@microchip.com, conor.dooley@microchip.com,
        trix@redhat.com, daire.mcnamara@microchip.com, a.zummo@towertech.it
Cc:     linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-rtc@vger.kernel.org
Subject: Re: [PATCH] rtc: remove 'pending' variable from
 mpfs_rtc_wakeup_irq_handler()
Message-ID: <165884535076.3156642.16325816554140473959.b4-ty@bootlin.com>
References: <20220627205943.2075043-1-trix@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220627205943.2075043-1-trix@redhat.com>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 27 Jun 2022 16:59:43 -0400, Tom Rix wrote:
> cppcheck reports
> [drivers/rtc/rtc-mpfs.c:219]: (style) Variable 'pending' is assigned a value that is never used.
> 
> The fetched CONTROL_REG stored in pending is unused and partially
> duplicates the functionality of the later call to mpfs_rtc_clear().  This looks
> like leftover development code, so remove pending.
> 
> [...]

Applied, thanks!

[1/1] rtc: remove 'pending' variable from mpfs_rtc_wakeup_irq_handler()
      commit: 3fa0cb37bda9d45d3c6f07e67051e7118d3ffe63

Best regards,

-- 
Alexandre Belloni, co-owner and COO, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
