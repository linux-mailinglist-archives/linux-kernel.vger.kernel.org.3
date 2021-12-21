Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 57CC247C0E6
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Dec 2021 14:41:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235418AbhLUNlR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Dec 2021 08:41:17 -0500
Received: from mxout70.expurgate.net ([91.198.224.70]:11310 "EHLO
        mxout70.expurgate.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233952AbhLUNlQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Dec 2021 08:41:16 -0500
Received: from [127.0.0.1] (helo=localhost)
        by relay.expurgate.net with smtp (Exim 4.92)
        (envelope-from <fe@dev.tdt.de>)
        id 1mzfOB-000URt-Sj; Tue, 21 Dec 2021 14:41:11 +0100
Received: from [195.243.126.94] (helo=securemail.tdt.de)
        by relay.expurgate.net with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <fe@dev.tdt.de>)
        id 1mzfOA-000UVt-TI; Tue, 21 Dec 2021 14:41:11 +0100
Received: from securemail.tdt.de (localhost [127.0.0.1])
        by securemail.tdt.de (Postfix) with ESMTP id 90A3F240041;
        Tue, 21 Dec 2021 14:41:10 +0100 (CET)
Received: from mail.dev.tdt.de (unknown [10.2.4.42])
        by securemail.tdt.de (Postfix) with ESMTP id 1D741240040;
        Tue, 21 Dec 2021 14:41:10 +0100 (CET)
Received: from localhost.localdomain (unknown [10.2.3.40])
        by mail.dev.tdt.de (Postfix) with ESMTPSA id 987E920331;
        Tue, 21 Dec 2021 14:41:02 +0100 (CET)
From:   Florian Eckert <fe@dev.tdt.de>
To:     pavel@ucw.cz, robh+dt@kernel.org
Cc:     Eckert.Florian@googlemail.com, linux-kernel@vger.kernel.org,
        linux-leds@vger.kernel.org, devicetree@vger.kernel.org,
        Florian Eckert <fe@dev.tdt.de>
Subject: [PATCH v2 0/2] leds: add ktd20xx LED driver support
Date:   Tue, 21 Dec 2021 14:40:50 +0100
Message-ID: <20211221134052.22387-1-fe@dev.tdt.de>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
X-Spam-Status: No, score=-1.0 required=5.0 tests=ALL_TRUSTED autolearn=ham
        autolearn_force=no version=3.4.2
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on mail.dev.tdt.de
Content-Transfer-Encoding: quoted-printable
X-purgate-type: clean
X-purgate: clean
X-purgate-ID: 151534::1640094071-0001D852-ED5A8F86/0/0
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Introducing the KTD2061/58/59/60 RGB LED drivers. The difference in
these are the address numbers on the I2C bus that the device listens to.

Due to the hardware limitation, we can only set 7 colors and the color
black (LED off) for each LED independently and not the full RGB range.

v1: Inital send
v2: Remove variant 1 from source

Florian Eckert (2):
  leds: ktd20xx: Extension of the KTD20xx family of LED drivers from
    Kinetic
  dt: bindings: KTD20xx: Introduce the ktd20xx family of RGB drivers

 .../bindings/leds/leds-ktd20xx.yaml           | 130 ++++
 MAINTAINERS                                   |   7 +
 drivers/leds/Kconfig                          |  13 +
 drivers/leds/Makefile                         |   1 +
 drivers/leds/leds-ktd20xx.c                   | 614 ++++++++++++++++++
 5 files changed, 765 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/leds/leds-ktd20xx.y=
aml
 create mode 100644 drivers/leds/leds-ktd20xx.c

--=20
2.20.1

