Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0EA2F499D07
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jan 2022 23:15:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1581562AbiAXWMA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jan 2022 17:12:00 -0500
Received: from ip-16.mailobj.net ([213.182.54.16]:43018 "EHLO msg-6.mailo.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1452804AbiAXV0n (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jan 2022 16:26:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=mailoo.org; s=mailo;
        t=1643059589; bh=d7f3LN69ZP8nzrQz/4DmTzxS4PPZq0d31Z5vWwXgLos=;
        h=X-EA-Auth:From:To:Cc:Subject:Date:Message-Id:X-Mailer:
         MIME-Version:Content-Transfer-Encoding;
        b=VwD2erY/IRv3bekeDaNnP5nBFrD1O6g9WQT/x44Twy3JBSkjyv+Vq95QNGMnQKiuF
         09U/EIzY3UvLMfuBTWrmLpPiztLLj0JOpfBfeE66mUmpdDVS5hN1ZV0Ma5d6v73cpJ
         6tLFmA4+mgb/Jk7x7bndG/v5Ou17vD/NVN4aVeS8=
Received: by b-5.in.mailobj.net [192.168.90.15] with ESMTP
        via proxy.mailoo.org [213.182.55.207]
        Mon, 24 Jan 2022 22:26:28 +0100 (CET)
X-EA-Auth: MVlQI9Oc+2TxvC9wELiJ5b1jxxVN/vmW/43V61HWqihpp5JcFb/IZjGPiFPLu5wqkrDo0ASfvYpjAAxK6Nu9GBZ3FQCWFcYi6nmsbxXUdV4=
From:   Vincent Knecht <vincent.knecht@mailoo.org>
To:     dmitry.torokhov@gmail.com, stephan@gerhold.net
Cc:     linux-input@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, phone-devel@vger.kernel.org,
        ~postmarketos/upstreaming@lists.sr.ht,
        Vincent Knecht <vincent.knecht@mailoo.org>
Subject: [PATCH v2 0/5] msg2638: Add support for msg2138 and key events
Date:   Mon, 24 Jan 2022 22:26:06 +0100
Message-Id: <20220124212611.752603-1-vincent.knecht@mailoo.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is mostly a resend of the series sent last november which got no
answer, but with Rob's Acks picked up.

This series:
- moves max fingers number and irqhandler settings in a struct
- adds support for msg2138 touchscreen
- adds support for buttons, which were only seen with msg2138 as of yet

Big thanks to Stephan Gerhold <stephan@gerhold.net> for the help with
deciphering the downstream driver [1] and writing clean and working code.

[1] https://github.com/LineageOS/android_kernel_huawei_msm8916/blob/2f24fa58086a969687434b40f237cb589a1f324f/drivers/input/touchscreen/mstar/msg2138_qc.c

Vincent Knecht (5):
  Input: msg2638 - Set max finger number and irqhandler from driver data
  dt-bindings: input: touchscreen: msg2638: Document msg2138 support
  Input: msg2638 - Add support for msg2138
  dt-bindings: input: touchscreen: msg2638: Document keys support
  Input: msg2638 - Add support for msg2138 key events

 .../input/touchscreen/mstar,msg2638.yaml      |   8 +-
 drivers/input/touchscreen/msg2638.c           | 182 ++++++++++++++++--
 2 files changed, 175 insertions(+), 15 deletions(-)

-- 
2.34.1



