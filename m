Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 05AD8485080
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jan 2022 10:58:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239125AbiAEJ6u convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Wed, 5 Jan 2022 04:58:50 -0500
Received: from mail4.swissbit.com ([176.95.1.100]:51806 "EHLO
        mail4.swissbit.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239114AbiAEJ6k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jan 2022 04:58:40 -0500
Received: from mail4.swissbit.com (localhost [127.0.0.1])
        by DDEI (Postfix) with ESMTP id D4934122F5A;
        Wed,  5 Jan 2022 10:58:38 +0100 (CET)
Received: from mail4.swissbit.com (localhost [127.0.0.1])
        by DDEI (Postfix) with ESMTP id C30E11220B4;
        Wed,  5 Jan 2022 10:58:38 +0100 (CET)
X-TM-AS-ERS: 10.149.2.84-127.5.254.253
X-TM-AS-SMTP: 1.0 ZXguc3dpc3NiaXQuY29t Y2xvZWhsZUBoeXBlcnN0b25lLmNvbQ==
X-DDEI-TLS-USAGE: Used
Received: from ex.swissbit.com (SBDEEX02.sbitdom.lan [10.149.2.84])
        by mail4.swissbit.com (Postfix) with ESMTPS;
        Wed,  5 Jan 2022 10:58:38 +0100 (CET)
Received: from sbdeex02.sbitdom.lan (10.149.2.84) by sbdeex02.sbitdom.lan
 (10.149.2.84) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.14; Wed, 5 Jan 2022
 10:58:38 +0100
Received: from sbdeex02.sbitdom.lan ([fe80::e0eb:ade8:2d90:1f74]) by
 sbdeex02.sbitdom.lan ([fe80::e0eb:ade8:2d90:1f74%8]) with mapi id
 15.02.0986.014; Wed, 5 Jan 2022 10:58:38 +0100
From:   =?iso-8859-1?Q?Christian_L=F6hle?= <CLoehle@hyperstone.com>
To:     "jason.wessel@windriver.com" <jason.wessel@windriver.com>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "daniel.thompson@linaro.org" <daniel.thompson@linaro.org>
CC:     "dianders@chromium.org" <dianders@chromium.org>,
        "corbet@lwn.net" <corbet@lwn.net>
Subject: [PATCHv2] Documentation: kgdb: Replace deprecated remotebaud
Thread-Topic: [PATCHv2] Documentation: kgdb: Replace deprecated remotebaud
Thread-Index: AQHYAhrP68jNDNfAGESeJuyhR8BXsQ==
Date:   Wed, 5 Jan 2022 09:58:38 +0000
Message-ID: <4050689967ed46baaa3bfadda53a0e73@hyperstone.com>
References: <13287b7914344c7995de27224cd2fa73@hyperstone.com>
In-Reply-To: <13287b7914344c7995de27224cd2fa73@hyperstone.com>
Accept-Language: en-US, de-DE
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.154.1.4]
Content-Type: text/plain;
        charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-TMASE-Version: DDEI-5.1-8.6.1018-26634.007
X-TMASE-Result: 10--0.454300-10.000000
X-TMASE-MatchedRID: lywBov0pR41+wAuSUWlj5BIRh9wkXSlFVFeUPAjsd8ZbCSrW8+l8cULr
        rcXwOuf4Rjuuru99Q9KPQi9XuOWoOCoJw+vEfUGtv4p3+B4TK3t9LQinZ4QefIFD/hZ+jeim3n8
        eBZjGmUzkwjHXXC/4I7I7zVffJqTz8D0Hf2JT8FAKFoY6SUw56Ho6sQJvhZcTcdAmokxK8CbaWa
        pPJ7+JSH7cGd19dSFd
X-TMASE-SNAP-Result: 1.821001.0001-0-1-22:0,33:0,34:0-0
X-TMASE-INERTIA: 0-0;;;;
X-TMASE-XGENCLOUD: f2581985-86f5-4cef-9e87-1671d902defa-0-0-200-0
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Using set remotebaud to set the baud rate was deprecated in
gdb-7.7 and completely removed from the command parser in gdb-7.8
(released in 2014). Adopt set serial baud instead.

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

