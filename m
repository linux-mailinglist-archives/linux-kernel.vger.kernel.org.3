Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E33EE4B9D03
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Feb 2022 11:26:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239238AbiBQKZK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Feb 2022 05:25:10 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:33086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239140AbiBQKYf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Feb 2022 05:24:35 -0500
Received: from mout-p-103.mailbox.org (mout-p-103.mailbox.org [80.241.56.161])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C00A279090;
        Thu, 17 Feb 2022 02:24:18 -0800 (PST)
Received: from smtp202.mailbox.org (smtp202.mailbox.org [80.241.60.245])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mout-p-103.mailbox.org (Postfix) with ESMTPS id 4JzrXc6gntz9sTV;
        Thu, 17 Feb 2022 11:24:16 +0100 (CET)
X-Virus-Scanned: amavisd-new at heinlein-support.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sylv.io; s=MBO0001;
        t=1645093454;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=fo3qvYTrTvu52KgG3zQhf7RwrPK7JjegLI2zgmD/Wyk=;
        b=bkBarlCEpLt9N9lNRLAauN7cpbkIC2bs/SVEuuyH582RDJWX6M9uLlshCKSSsXzxaaMtr4
        jaIxqiC2XxKedjOFVnXO1QzHtp57/2P2j0vwkUGTRAxOeEbZQnbubSdFyxwXPSymh/FO5N
        m4wSayAlj/GZphWaLvNbtXsWULplAZ+1Sd+P6dmnBKgxJ5ERmj2IbO4v2lGyNtdowG9vGY
        R23dTWAEwXTebK5zK+kUBrxDvXt9H91ACpE7LMW+/RThXir4LIp/vdHx4rAiSL8vXFeb44
        8PYViSpCjMww/TL+5ZQqW34TrPWFW3Ut4IUFw2bSdw5oXzxqg8OU5PuzWTAIFQ==
From:   Marcello Sylvester Bauer <sylv@sylv.io>
To:     Guenter Roeck <linux@roeck-us.net>,
        Jean Delvare <jdelvare@suse.com>
Cc:     linux-kernel@vger.kernel.org, linux-hwmon@vger.kernel.org,
        Patrick Rudolph <patrick.rudolph@9elements.com>,
        Marcello Sylvester Bauer <sylv@sylv.io>
Subject: [PATCH v1 0/1] Add supply into PWBUS_REGULATOR macro
Date:   Thu, 17 Feb 2022 11:23:48 +0100
Message-Id: <cover.1645092563.git.sylv@sylv.io>
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

Hi,

I would like to extend the PWBUS_REGULATOR macro to be able to define
a vin-supply. This makes it possible to regulate the voltage input
supply and even turn it off, if not required.

Thanks,
Marcello

Marcello Sylvester Bauer (1):
  hwmon: (pmbus) Add regulator supply into macro

 drivers/hwmon/pmbus/pmbus.h | 1 +
 1 file changed, 1 insertion(+)

-- 
2.34.1

