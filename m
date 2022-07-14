Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 73E01574C09
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Jul 2022 13:27:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238822AbiGNL14 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Jul 2022 07:27:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238788AbiGNL1y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jul 2022 07:27:54 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E90FF59242
        for <linux-kernel@vger.kernel.org>; Thu, 14 Jul 2022 04:27:50 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id D9A64CE24F8
        for <linux-kernel@vger.kernel.org>; Thu, 14 Jul 2022 11:27:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CD0AEC34114;
        Thu, 14 Jul 2022 11:27:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1657798066;
        bh=r300ADN83adpi7ob1ILvXoyqeuTqv9YFNj0/IiJ4gks=;
        h=From:To:Cc:Subject:Date:From;
        b=MDqyGxZ2H87+qo/lT9mjTtB+oYbtdvTzbyraEFJ6C8OmEGBeAYI9Y6Y674lk+h+nV
         b8KVW11f+T3l4GRFteev4I2AkVRwmRQO4pd403xDHZJJtrWB/iP+ad0aTZx8LNpfuW
         OJob3b+ttMjo2TEnA24/MrbMXV0h8TpoKVzeoo+Yof+M2Dn3GpLMNxM4E3RO16okwa
         B/pbAp5u+hLQsDhJZb4nmUdSpbFe1ubF8LjHNC8LsZ3LHu6Z8OtvkDFyXJPpXHLHCt
         IUby5Wr1DZ8LeVLZ63CDqpm3W4mphiiddqIk2EDOfx2Tk24iaWVXMEG82ncyUhbNnX
         sFcU2osSQ/ngg==
From:   Lee Jones <lee@kernel.org>
To:     lee.jones@linaro.org
Cc:     linux-kernel@vger.kernel.org, Lee Jones <lee@kernel.org>
Subject: [PATCH 0/8] MAINTAINERS and Docs: Use Lee Jones' kernel.org address going forward
Date:   Thu, 14 Jul 2022 12:25:25 +0100
Message-Id: <20220714112533.539910-1-lee@kernel.org>
X-Mailer: git-send-email 2.37.0.144.g8ac04bfd2-goog
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Moving over to my kernel.org address for upstream work.

Also remove myself from PWM.  Nothing left to do here.

Lee Jones (8):
  MAINTAINERS: Use Lee Jones' kernel.org address for MFD submissions
  MAINTAINERS: Use Lee Jones' kernel.org address for Syscon submissions
  MAINTAINERS: Remove myself as PWM maintainer
  docs: ABI: sysfs-class-pwm: Update Lee Jones' email address
  docs: ABI: sysfs-devices-soc: Update Lee Jones' email address
  dt-bindings: backlight: Update Lee Jones' email address
  dt-bindings: mfd: syscon: Update Lee Jones' email address
  dt-bindings: regulator: pwm: Update Lee Jones' email address

 Documentation/ABI/testing/sysfs-class-pwm          |  2 +-
 Documentation/ABI/testing/sysfs-devices-soc        | 14 +++++++-------
 .../devicetree/bindings/leds/backlight/common.yaml |  2 +-
 .../bindings/leds/backlight/gpio-backlight.yaml    |  2 +-
 .../bindings/leds/backlight/led-backlight.yaml     |  2 +-
 .../bindings/leds/backlight/lm3630a-backlight.yaml |  2 +-
 .../bindings/leds/backlight/pwm-backlight.yaml     |  2 +-
 Documentation/devicetree/bindings/mfd/syscon.yaml  |  2 +-
 .../bindings/regulator/pwm-regulator.yaml          |  2 +-
 MAINTAINERS                                        |  5 ++---
 10 files changed, 17 insertions(+), 18 deletions(-)

-- 
2.37.0.144.g8ac04bfd2-goog

