Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9FA9648464E
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jan 2022 17:57:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235584AbiADQ44 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Tue, 4 Jan 2022 11:56:56 -0500
Received: from mail4.swissbit.com ([176.95.1.100]:50810 "EHLO
        mail4.swissbit.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234144AbiADQ4z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jan 2022 11:56:55 -0500
Received: from mail4.swissbit.com (localhost [127.0.0.1])
        by DDEI (Postfix) with ESMTP id 3E824123165;
        Tue,  4 Jan 2022 17:56:53 +0100 (CET)
Received: from mail4.swissbit.com (localhost [127.0.0.1])
        by DDEI (Postfix) with ESMTP id 269E91230C5;
        Tue,  4 Jan 2022 17:56:53 +0100 (CET)
X-TM-AS-ERS: 10.149.2.84-127.5.254.253
X-TM-AS-SMTP: 1.0 ZXguc3dpc3NiaXQuY29t Y2xvZWhsZUBoeXBlcnN0b25lLmNvbQ==
X-DDEI-TLS-USAGE: Used
Received: from ex.swissbit.com (SBDEEX02.sbitdom.lan [10.149.2.84])
        by mail4.swissbit.com (Postfix) with ESMTPS;
        Tue,  4 Jan 2022 17:56:53 +0100 (CET)
Received: from sbdeex02.sbitdom.lan (10.149.2.84) by sbdeex02.sbitdom.lan
 (10.149.2.84) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.14; Tue, 4 Jan 2022
 17:56:51 +0100
Received: from sbdeex02.sbitdom.lan ([fe80::e0eb:ade8:2d90:1f74]) by
 sbdeex02.sbitdom.lan ([fe80::e0eb:ade8:2d90:1f74%8]) with mapi id
 15.02.0986.014; Tue, 4 Jan 2022 17:56:51 +0100
From:   =?iso-8859-1?Q?Christian_L=F6hle?= <CLoehle@hyperstone.com>
To:     "jason.wessel@windriver.com" <jason.wessel@windriver.com>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        =?iso-8859-1?Q?Christian_L=F6hle?= <CLoehle@hyperstone.com>
CC:     "daniel.thompson@linaro.org" <daniel.thompson@linaro.org>,
        "dianders@chromium.org" <dianders@chromium.org>,
        "corbet@lwn.net" <corbet@lwn.net>
Subject: [PATCH] Documentation: kgdb: Replace deprecated remotebaud
Thread-Topic: [PATCH] Documentation: kgdb: Replace deprecated remotebaud
Thread-Index: AQHYAYs+Ib/SRJEe7kagqhs3fpXf8A==
Date:   Tue, 4 Jan 2022 16:56:51 +0000
Message-ID: <13287b7914344c7995de27224cd2fa73@hyperstone.com>
Accept-Language: en-US, de-DE
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.154.1.4]
Content-Type: text/plain;
        charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-TMASE-Version: DDEI-5.1-8.6.1018-26634.001
X-TMASE-Result: 10--1.028000-10.000000
X-TMASE-MatchedRID: BFQSNthdAqJjFNgY8SnxHAvze7pC53SADibuessoYDZbCSrW8+l8cR/p
        oFKGNxRgsAW6Ufavh1u4XjarCGCNGyxppiUy9o4cA9lly13c/gEohvgDyt5zb4sjejIjbRAxo8W
        MkQWv6iUsOwD+dG3DyR34VqVOU/8EavP8b9lJtWr6C0ePs7A07SjXf4udBIoMGH4SZnl9Tbgc7c
        DiVnHAmGOJXKrqfMjz9ZGwl/yz0nZWXGvUUmKP2w==
X-TMASE-SNAP-Result: 1.821001.0001-0-1-22:0,33:0,34:0-0
X-TMASE-INERTIA: 0-0;;;;
X-TMASE-XGENCLOUD: 6c6567be-f0b5-415d-b386-9080bec47409-0-0-200-0
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The gdb remotebaud to set baudrate has been replaced in favor of
set serial baud many years ago.

Signed-off-by: Christian Loehle <cloehle@hyperstone.com>
---
 Documentation/dev-tools/kgdb.rst | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/dev-tools/kgdb.rst b/Documentation/dev-tools/kgdb.rst
index 43456244651a..7c90e111b364 100644
--- a/Documentation/dev-tools/kgdb.rst
+++ b/Documentation/dev-tools/kgdb.rst
@@ -557,7 +557,7 @@ Connecting with gdb to a serial port
    Example (using a directly connected port)::
 
            % gdb ./vmlinux
-           (gdb) set remotebaud 115200
+           (gdb) set serial baud 115200
            (gdb) target remote /dev/ttyS0
 
 
-- 
2.34.1
Hyperstone GmbH | Reichenaustr. 39a  | 78467 Konstanz
Managing Director: Dr. Jan Peter Berns.
Commercial register of local courts: Freiburg HRB381782

