Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 07A125AA9D2
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Sep 2022 10:20:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235711AbiIBIUy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Sep 2022 04:20:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235512AbiIBIUw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Sep 2022 04:20:52 -0400
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CCE074C634;
        Fri,  2 Sep 2022 01:20:50 -0700 (PDT)
Received: by mail-lf1-x12c.google.com with SMTP id br21so2304864lfb.0;
        Fri, 02 Sep 2022 01:20:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date;
        bh=k9HeV9s5RJqmOoAs4X6mfRUQcnflr2D6WhL4YEXe9A8=;
        b=C/nkcPUsOieObthxNg9fCVGaYuhWDiMK5eOiprrNB1lSd9ZfCXTS7+7kbtdU2eiu5u
         X2dMHujTgiYccI0Soqg82ZSrVJLoLqY464DSDjSjgReJTpVwqyyK3qnaf74mzBvRuro6
         zUFXiWhW9+1ib8U8Wi1bNsUsZVW9YVbElDkfxmffuIa5JPDlSVWoI2xhWZ+CpkOZaVus
         dvZ67ruo7uYKrxGdB8Lswt77BYmUYdZTYvUjowLjCO6sIAZASfFA8FioVROnRZz6UAup
         shBUjr2U66MjpPLyT0S3wxRSUgFrxpCEYlF7+TepE3boPZ3SDXSsgPg/ig4kqqkNHTMn
         KXsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date;
        bh=k9HeV9s5RJqmOoAs4X6mfRUQcnflr2D6WhL4YEXe9A8=;
        b=EdIxa74jBErjcjt5RgVYE0a+upPGFZMKAv6ZJE1Y3TqeRd/+ZMBIoirj5n0cHwYql2
         LxpRvryK+TIDVZ3CX6iUwJCIWFlMBZlO2J1wDLiBkBNbhkHqZokm5p+OBkIa5hxdnZSw
         ozRivxXywmGmtI1vXtPQGv0qD24lCEvVpZW/I9ycUEZx1FNE66V/5GXmlyPlRi3bmcce
         6xEGwrCiVbx6NNbqtPPTMXEpgvWoEiru1FRUXofGicqHG5T2rGHYRr9RTqfSSdjGNCgo
         s3Ot1PNwnQKSZ1F1/DZRigf8qK2eflcpKD4RF3GVRvJ2LZnygWr+7z4jic8eIweY4T+l
         o75A==
X-Gm-Message-State: ACgBeo2F9+96kq6Ao7feKukvmNCi948KEmF/1SCz7Y9LMYiNvuzP5qtH
        rBdfbKAmW/yGx9kBi6nBS0v0PF0eTbM=
X-Google-Smtp-Source: AA6agR4qxy7JuL5Kj2d2iLY3PqQ6Ytyr9gp5BBvPFzA4Fwtv18UaRFvaYnZ8kUMuZtPxZeD1cy0+hw==
X-Received: by 2002:a05:6512:31c5:b0:48b:38cf:51f8 with SMTP id j5-20020a05651231c500b0048b38cf51f8mr12591310lfe.315.1662106849025;
        Fri, 02 Sep 2022 01:20:49 -0700 (PDT)
Received: from localhost.localdomain (82-209-154-112.cust.bredband2.com. [82.209.154.112])
        by smtp.gmail.com with ESMTPSA id a27-20020a05651c031b00b00263630ab29dsm108828ljp.118.2022.09.02.01.20.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Sep 2022 01:20:48 -0700 (PDT)
From:   Marcus Folkesson <marcus.folkesson@gmail.com>
To:     benjamin.tissoires@redhat.com, jikos@kernel.org,
        marcus.folkesson@gmail.com
Cc:     linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 0/1] VRC-2 Car Controller
Date:   Fri,  2 Sep 2022 10:25:51 +0200
Message-Id: <20220902082552.2433744-1-marcus.folkesson@gmail.com>
X-Mailer: git-send-email 2.37.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

The device creates two USB endpoints where on of those represent the X/Y
axis as 16 buttons which is not.. quite right.
So get rid of that endpoint.

Also fix the report descriptor for the other endpoint.

Output from hid-recorder:
#  X:     32 | Y:   1001 | # 
E: 000105.808008 7 20 00 e9 03 00 00 00

Link to previous discussion:
https://lore.kernel.org/all/CAO-hwJL-3vAzywjeUsopsRSJX6j-maC5R75ekxZg-W_oKDqYYw@mail.gmail.com/


v2:
- Remove .remove
- Change help text in Kconfig
- Remove redundant check for USB endpoint in vrc2_report_fixup

Marcus Folkesson (1):
  HID: Add driver for VRC-2 Car Controller

 MAINTAINERS            |  6 +++
 drivers/hid/Kconfig    | 10 +++++
 drivers/hid/Makefile   |  1 +
 drivers/hid/hid-vrc2.c | 91 ++++++++++++++++++++++++++++++++++++++++++
 4 files changed, 108 insertions(+)
 create mode 100644 drivers/hid/hid-vrc2.c

-- 
2.37.1

