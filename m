Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B0BEF4BE3AA
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Feb 2022 18:57:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356129AbiBULWH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Feb 2022 06:22:07 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:53558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1356142AbiBULUd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Feb 2022 06:20:33 -0500
Received: from mout-p-202.mailbox.org (mout-p-202.mailbox.org [IPv6:2001:67c:2050::465:202])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0026EB84;
        Mon, 21 Feb 2022 03:10:18 -0800 (PST)
Received: from smtp102.mailbox.org (smtp102.mailbox.org [80.241.60.233])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mout-p-202.mailbox.org (Postfix) with ESMTPS id 4K2KMs3QTKz9sTl;
        Mon, 21 Feb 2022 12:10:17 +0100 (CET)
X-Virus-Scanned: amavisd-new at heinlein-support.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sylv.io; s=MBO0001;
        t=1645441815;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=e4UTnxG31OsKXvhGbLIn3zqVzpZWQDRqr7eJQX+6OmQ=;
        b=tTIq0QAN58sgjEvcGw9YR9ZhfkEi8N6H35/LfwnHX5vM1qFIyWQ59H6xRsuS9FnTUTn9MX
        HwH8OG+w3wSEI5ANFtZsO5IadUziUf/7ZEMyqc542UZQPQkOhOXSou5mQXrHEF6bmlbDIK
        U1tz4Q0urGniRFnsu9N8jeEFsEkdvwL2hjmflUw4uFhOYUFEF7skYA3Z/yPQYqMekX4iIp
        dUL2vBc7gXOH2Bc4YTZeS1aj7BhMzRdcZpM6BAOm6Tc09Haqh1tbIDflaOkqNQKdWPwzS5
        +5CGxi+HEZuKNP5orYqTJFt0yR50ozeCEt1O4AD+LSKoZk7V65r1hkJTfwvC3A==
From:   Marcello Sylvester Bauer <sylv@sylv.io>
To:     Guenter Roeck <linux@roeck-us.net>,
        Jean Delvare <jdelvare@suse.com>
Cc:     linux-kernel@vger.kernel.org, linux-hwmon@vger.kernel.org,
        Patrick Rudolph <patrick.rudolph@9elements.com>,
        Marcello Sylvester Bauer <sylv@sylv.io>
Subject: [PATCH v2 0/1] Add supply into PWBUS_REGULATOR macro
Date:   Mon, 21 Feb 2022 12:09:55 +0100
Message-Id: <cover.1645437439.git.sylv@sylv.io>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I would like to extend the PWBUS_REGULATOR macro to be able to define
a vin-supply. This makes it possible to regulate the voltage input
supply and even turn it off, if not required.

Change in v2:
- Adapt commit message.

Marcello Sylvester Bauer (1):
  hwmon: (pmbus) Add regulator supply into macro

 drivers/hwmon/pmbus/pmbus.h | 1 +
 1 file changed, 1 insertion(+)

-- 
2.34.1

