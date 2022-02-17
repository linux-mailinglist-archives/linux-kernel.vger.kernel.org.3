Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C36804BA336
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Feb 2022 15:42:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241959AbiBQOmY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Feb 2022 09:42:24 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:37654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233259AbiBQOmX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Feb 2022 09:42:23 -0500
Received: from mout-p-201.mailbox.org (mout-p-201.mailbox.org [80.241.56.171])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1EB061EA710;
        Thu, 17 Feb 2022 06:42:08 -0800 (PST)
Received: from smtp102.mailbox.org (smtp102.mailbox.org [IPv6:2001:67c:2050:105:465:1:3:0])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mout-p-201.mailbox.org (Postfix) with ESMTPS id 4JzyG60XHQz9sWB;
        Thu, 17 Feb 2022 15:42:06 +0100 (CET)
X-Virus-Scanned: amavisd-new at heinlein-support.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sylv.io; s=MBO0001;
        t=1645108923;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=gpf50Zv3BHRX4hF0cZ15cmgZdclv11k5Xc52gVV7KaE=;
        b=QiwCXvJlJPBqK0impV023JvyJdC9kHqWKrrMRvStqP2uZ4y8E6I5jq8hAxtn8SwFy/Zxut
        ruaJpewA8a0MNYY5Fp41X6EckDgPEUDAfcc5/8Spyk6zA37HJoSwwZgBn6XRMX2pOcetgH
        iJOwMYVvUraj4pThLV7FNTD4pdsOom9KtwTbRnpbqNxR5Zkg+Kg89F4EcqFhRSrmw27+9y
        TEnToN13IKEJ3ycSkiZNJXJuyBRkEpI2u47bTWJDHHjBysucqdArgQBiAx+P25q06clZSB
        IoQ7CXuNGYK7XDrAtWLbuSDSAOGyAC7112z4zXTbTQgLhPPOwY/m8OK7MDgzSg==
From:   Marcello Sylvester Bauer <sylv@sylv.io>
To:     Guenter Roeck <linux@roeck-us.net>,
        Jean Delvare <jdelvare@suse.com>
Cc:     linux-kernel@vger.kernel.org, linux-hwmon@vger.kernel.org,
        Patrick Rudolph <patrick.rudolph@9elements.com>,
        Marcello Sylvester Bauer <sylv@sylv.io>
Subject: [PATCH v2 0/3] Support XDPE112
Date:   Thu, 17 Feb 2022 15:41:32 +0100
Message-Id: <cover.1645108566.git.sylv@sylv.io>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add support for Infineon Multi-phase XDPE112 family regulator. The main
difference to the XDPE122 family is it uses a different format for
voltage out. Add the required logic to the existing  xdpe12284 driver
accordingly.

Changes in v2:
- Rebase on current hwmon-next branch

Marcello Sylvester Bauer (3):
  dt-bindings: trivial-devices: Add xdpe11280
  hwmon (xdpe12284): Add support for xdpe11280
  hwmon (xdpe12284): Add regulator support

 .../devicetree/bindings/trivial-devices.yaml  |  2 ++
 Documentation/hwmon/xdpe12284.rst             | 10 +++++--
 drivers/hwmon/pmbus/Kconfig                   |  6 ++++
 drivers/hwmon/pmbus/xdpe12284.c               | 28 ++++++++++++++++++-
 4 files changed, 42 insertions(+), 4 deletions(-)

-- 
2.34.1

