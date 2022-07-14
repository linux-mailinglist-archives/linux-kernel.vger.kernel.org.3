Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6874D574C16
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Jul 2022 13:28:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238843AbiGNL2L (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Jul 2022 07:28:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238854AbiGNL2A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jul 2022 07:28:00 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40B8057E2E
        for <linux-kernel@vger.kernel.org>; Thu, 14 Jul 2022 04:27:56 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id E3048B8239B
        for <linux-kernel@vger.kernel.org>; Thu, 14 Jul 2022 11:27:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2C071C34115;
        Thu, 14 Jul 2022 11:27:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1657798073;
        bh=xSumGVZMSb75TlWyVR1tNpXOiF+aSuDUJCzx03HJzvw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=WNRL5OmW5HFDRmnuNCMF4GdvoWRji8V1I0awDRou83Lc0jvX0x9wYzBl+a4/j8lHc
         3Xp9s1aOhr7SpNfQvsn11tBdWl5fqV7AcGNTV3rr6iChfxLUa1PfJTegBuZ2VfTZWf
         LomKtVF1jTBITEzo3wam+AoJNhKES8MTrKDoH+FOdaxRnxonQJ5128lgilUnuQ2hcC
         iPWnt1ztO/PsEEREEhGowsjfQ1DEbYv+dcrW+vq9l1lCjDfojjqEXw89lLm3lA7CiU
         n3gixrsI4ckZWD9uTmMwpuYYKPhZUhwuhE16DUaqK3HbHpdzzeidGpEvzm+dTlsuDG
         aH1fWt5wTsjjw==
From:   Lee Jones <lee@kernel.org>
To:     lee.jones@linaro.org
Cc:     linux-kernel@vger.kernel.org, Lee Jones <lee@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Subject: [PATCH 4/8] docs: ABI: sysfs-class-pwm: Update Lee Jones' email address
Date:   Thu, 14 Jul 2022 12:25:29 +0100
Message-Id: <20220714112533.539910-5-lee@kernel.org>
X-Mailer: git-send-email 2.37.0.144.g8ac04bfd2-goog
In-Reply-To: <20220714112533.539910-1-lee@kernel.org>
References: <20220714112533.539910-1-lee@kernel.org>
MIME-Version: 1.0
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

Going forward, I'll be using my kernel.org for upstream work.

Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Signed-off-by: Lee Jones <lee.jones@linaro.org>
Signed-off-by: Lee Jones <lee@kernel.org>
---
 Documentation/ABI/testing/sysfs-class-pwm | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/ABI/testing/sysfs-class-pwm b/Documentation/ABI/testing/sysfs-class-pwm
index 3d65285bcd5f6..0638c94d01eff 100644
--- a/Documentation/ABI/testing/sysfs-class-pwm
+++ b/Documentation/ABI/testing/sysfs-class-pwm
@@ -81,7 +81,7 @@ Description:
 What:		/sys/class/pwm/pwmchip<N>/pwmX/capture
 Date:		June 2016
 KernelVersion:	4.8
-Contact:	Lee Jones <lee.jones@linaro.org>
+Contact:	Lee Jones <lee@kernel.org>
 Description:
 		Capture information about a PWM signal. The output format is a
 		pair unsigned integers (period and duty cycle), separated by a
-- 
2.37.0.144.g8ac04bfd2-goog

