Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BC14548933A
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jan 2022 09:26:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240423AbiAJI0O convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Mon, 10 Jan 2022 03:26:14 -0500
Received: from mail3.swissbit.com ([176.95.1.57]:48684 "EHLO
        mail3.swissbit.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240383AbiAJI0I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jan 2022 03:26:08 -0500
Received: from mail3.swissbit.com (localhost [127.0.0.1])
        by DDEI (Postfix) with ESMTP id 0C241462AA3;
        Mon, 10 Jan 2022 09:26:03 +0100 (CET)
Received: from mail3.swissbit.com (localhost [127.0.0.1])
        by DDEI (Postfix) with ESMTP id E373E462A93;
        Mon, 10 Jan 2022 09:26:02 +0100 (CET)
X-TM-AS-ERS: 10.149.2.84-127.5.254.253
X-TM-AS-SMTP: 1.0 ZXguc3dpc3NiaXQuY29t Y2xvZWhsZUBoeXBlcnN0b25lLmNvbQ==
X-DDEI-TLS-USAGE: Used
Received: from ex.swissbit.com (SBDEEX02.sbitdom.lan [10.149.2.84])
        by mail3.swissbit.com (Postfix) with ESMTPS;
        Mon, 10 Jan 2022 09:26:02 +0100 (CET)
Received: from sbdeex02.sbitdom.lan (10.149.2.84) by sbdeex02.sbitdom.lan
 (10.149.2.84) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.14; Mon, 10 Jan
 2022 09:26:02 +0100
Received: from sbdeex02.sbitdom.lan ([fe80::e0eb:ade8:2d90:1f74]) by
 sbdeex02.sbitdom.lan ([fe80::e0eb:ade8:2d90:1f74%8]) with mapi id
 15.02.0986.014; Mon, 10 Jan 2022 09:26:02 +0100
From:   =?iso-8859-1?Q?Christian_L=F6hle?= <CLoehle@hyperstone.com>
To:     Jonathan Corbet <corbet@lwn.net>,
        "jason.wessel@windriver.com" <jason.wessel@windriver.com>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "daniel.thompson@linaro.org" <daniel.thompson@linaro.org>,
        =?iso-8859-1?Q?Christian_L=F6hle?= <CLoehle@hyperstone.com>
Subject: [PATCHv3] Documentation: kgdb: Replace deprecated remotebaud
Thread-Topic: [PATCHv3] Documentation: kgdb: Replace deprecated remotebaud
Thread-Index: AQHYBfuzQ/xkgkc310q0gpUtO+y3YQ==
Date:   Mon, 10 Jan 2022 08:26:02 +0000
Message-ID: <efa448f3c8074fac9e07e258d327cbae@hyperstone.com>
References: <13287b7914344c7995de27224cd2fa73@hyperstone.com>
 <4050689967ed46baaa3bfadda53a0e73@hyperstone.com>,<87ee5kpki1.fsf@meer.lwn.net>
In-Reply-To: <87ee5kpki1.fsf@meer.lwn.net>
Accept-Language: en-US, de-DE
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.154.1.4]
Content-Type: text/plain;
        charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-TMASE-Version: DDEI-5.1-8.6.1018-26644.006
X-TMASE-Result: 10--1.590300-10.000000
X-TMASE-MatchedRID: BFQSNthdAqJ+wAuSUWlj5BIRh9wkXSlFVFeUPAjsd8YE71b5Svg0gCGu
        zVLLKJdOBjIbat56Enk5suuA6RHmUZzAN0sNcMp5PwKTD1v8YV5MkOX0UoduuXQDcRg9v/E4Jzf
        pn/oR511RU8+vUCslgMpjK4dbPxs8aDAi8sBNMoELbigRnpKlKWxlRJiH4397SNmQ01MKRa3cfM
        7WJ5cTywI/v7yt3viNlL8mYas79H+kIttNw5TROQ==
X-TMASE-SNAP-Result: 1.821001.0001-0-1-22:0,33:0,34:0-0
X-TMASE-INERTIA: 0-0;;;;
X-TMASE-XGENCLOUD: 6b9b5f45-ab67-4eb3-ae6a-58e97cd18256-0-0-200-0
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Using set remotebaud to set the baud rate was deprecated in
gdb-7.7 and completely removed from the command parser in gdb-7.8
(released in 2014). Adopt set serial baud instead.

Change since v2:
  - Add historical example in the documentation

Signed-off-by: Christian Loehle <cloehle@hyperstone.com>
---
 Documentation/dev-tools/kgdb.rst | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/Documentation/dev-tools/kgdb.rst b/Documentation/dev-tools/kgdb.rst
index 43456244651a..d7acb2bdb0ba 100644
--- a/Documentation/dev-tools/kgdb.rst
+++ b/Documentation/dev-tools/kgdb.rst
@@ -557,9 +557,14 @@ Connecting with gdb to a serial port
    Example (using a directly connected port)::
 
            % gdb ./vmlinux
-           (gdb) set remotebaud 115200
+           (gdb) set serial baud 115200
            (gdb) target remote /dev/ttyS0
 
+   Example (using a directly connected port with gdb version < 7.8)::
+
+           % gdb ./vmlinux
+           (gdb) set remotebaud 115200
+           (gdb) target remote /dev/ttyS0
 
    Example (kgdb to a terminal server on TCP port 2012)::
 
-- 
2.34.1
Hyperstone GmbH | Reichenaustr. 39a  | 78467 Konstanz
Managing Director: Dr. Jan Peter Berns.
Commercial register of local courts: Freiburg HRB381782

