Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3325A526D04
	for <lists+linux-kernel@lfdr.de>; Sat, 14 May 2022 00:42:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1382425AbiEMWmW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 May 2022 18:42:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1384829AbiEMWmQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 May 2022 18:42:16 -0400
Received: from angie.orcam.me.uk (angie.orcam.me.uk [IPv6:2001:4190:8020::34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 358812B266;
        Fri, 13 May 2022 15:42:10 -0700 (PDT)
Received: by angie.orcam.me.uk (Postfix, from userid 500)
        id 9295092009E; Sat, 14 May 2022 00:42:08 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by angie.orcam.me.uk (Postfix) with ESMTP id 8B68892009B;
        Fri, 13 May 2022 23:42:08 +0100 (BST)
Date:   Fri, 13 May 2022 23:42:08 +0100 (BST)
From:   "Maciej W. Rozycki" <macro@orcam.me.uk>
To:     Jonathan Corbet <corbet@lwn.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>
cc:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-next@vger.kernel.org
Subject: [PATCH 2/3] Documentation: Reformat Oxford Semiconductor PCIe
 (Tornado) 950
In-Reply-To: <alpine.DEB.2.21.2205131712410.10656@angie.orcam.me.uk>
Message-ID: <alpine.DEB.2.21.2205131721110.10656@angie.orcam.me.uk>
References: <alpine.DEB.2.21.2205131712410.10656@angie.orcam.me.uk>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Reformat Oxford Semiconductor PCIe (Tornado) 950 description in terms of 
reStructuredText markup, fixing warnings with `make htmldocs'.  While at 
it remove typos: s/the the/the/ and s/the/then/ in lines changed anyway.

Signed-off-by: Maciej W. Rozycki <macro@orcam.me.uk>
---
 Documentation/misc-devices/oxsemi-tornado.rst |  136 +++++++++++++-------------
 1 file changed, 69 insertions(+), 67 deletions(-)

linux-doc-oxsemi-tornado-fix.diff
Index: linux-macro/Documentation/misc-devices/oxsemi-tornado.rst
===================================================================
--- linux-macro.orig/Documentation/misc-devices/oxsemi-tornado.rst
+++ linux-macro/Documentation/misc-devices/oxsemi-tornado.rst
@@ -24,15 +24,15 @@ used for the divisor to obtain the reque
 is unaware of the extra clock controls available.
 
 The oversampling rate is programmed with the TCR register and the clock
-prescaler is programmed with the CPR/CPR2 register pair[1][2][3][4].
-To switch away from the default value of 33.875 for the prescaler the
-the enhanced mode has to be explicitly enabled though, by setting bit 4
-of the EFR.  In that mode setting bit 7 in the MCR enables the prescaler
-or otherwise it is bypassed as if the value of 1 was used.  Additionally
-writing any value to CPR clears CPR2 for compatibility with old software
-written for older conventional PCI Oxford Semiconductor devices that do
-not have the extra prescaler's 9th bit in CPR2, so the CPR/CPR2 register
-pair has to be programmed in the right order.
+prescaler is programmed with the CPR/CPR2 register pair [OX200]_ [OX952]_
+[OX954]_ [OX958]_.  To switch away from the default value of 33.875 for
+the prescaler the enhanced mode has to be explicitly enabled though, by
+setting bit 4 of the EFR.  In that mode setting bit 7 in the MCR enables
+the prescaler or otherwise it is bypassed as if the value of 1 was used.
+Additionally writing any value to CPR clears CPR2 for compatibility with
+old software written for older conventional PCI Oxford Semiconductor
+devices that do not have the extra prescaler's 9th bit in CPR2, so the
+CPR/CPR2 register pair has to be programmed in the right order.
 
 By using these parameters rates from 15625000bps down to 1bps can be
 obtained, with either exact or highly-accurate actual bit rates for
@@ -43,48 +43,50 @@ Here are the figures for the standard an
 the requested rate (r), the actual rate yielded (a) and its deviation
 from the requested rate (d), and the values of the oversampling rate
 (tcr), the clock prescaler (cpr) and the divisor (div) produced by the
-new `get_divisor' handler:
+new ``get_divisor`` handler:
 
-r: 15625000, a: 15625000.00, d:  0.0000%, tcr:  4, cpr:  1.000, div:     1
-r: 12500000, a: 12500000.00, d:  0.0000%, tcr:  5, cpr:  1.000, div:     1
-r: 10416666, a: 10416666.67, d:  0.0000%, tcr:  6, cpr:  1.000, div:     1
-r:  8928571, a:  8928571.43, d:  0.0000%, tcr:  7, cpr:  1.000, div:     1
-r:  7812500, a:  7812500.00, d:  0.0000%, tcr:  8, cpr:  1.000, div:     1
-r:  4000000, a:  4000000.00, d:  0.0000%, tcr:  5, cpr:  3.125, div:     1
-r:  3686400, a:  3676470.59, d: -0.2694%, tcr:  8, cpr:  2.125, div:     1
-r:  3500000, a:  3496503.50, d: -0.0999%, tcr: 13, cpr:  1.375, div:     1
-r:  3000000, a:  2976190.48, d: -0.7937%, tcr: 14, cpr:  1.500, div:     1
-r:  2500000, a:  2500000.00, d:  0.0000%, tcr: 10, cpr:  2.500, div:     1
-r:  2000000, a:  2000000.00, d:  0.0000%, tcr: 10, cpr:  3.125, div:     1
-r:  1843200, a:  1838235.29, d: -0.2694%, tcr: 16, cpr:  2.125, div:     1
-r:  1500000, a:  1492537.31, d: -0.4975%, tcr:  5, cpr:  8.375, div:     1
-r:  1152000, a:  1152073.73, d:  0.0064%, tcr: 14, cpr:  3.875, div:     1
-r:   921600, a:   919117.65, d: -0.2694%, tcr: 16, cpr:  2.125, div:     2
-r:   576000, a:   576036.87, d:  0.0064%, tcr: 14, cpr:  3.875, div:     2
-r:   460800, a:   460829.49, d:  0.0064%, tcr:  7, cpr:  3.875, div:     5
-r:   230400, a:   230414.75, d:  0.0064%, tcr: 14, cpr:  3.875, div:     5
-r:   115200, a:   115207.37, d:  0.0064%, tcr: 14, cpr:  1.250, div:    31
-r:    57600, a:    57603.69, d:  0.0064%, tcr:  8, cpr:  3.875, div:    35
-r:    38400, a:    38402.46, d:  0.0064%, tcr: 14, cpr:  3.875, div:    30
-r:    19200, a:    19201.23, d:  0.0064%, tcr:  8, cpr:  3.875, div:   105
-r:     9600, a:     9600.06, d:  0.0006%, tcr:  9, cpr:  1.125, div:   643
-r:     4800, a:     4799.98, d: -0.0004%, tcr:  7, cpr:  2.875, div:   647
-r:     2400, a:     2400.02, d:  0.0008%, tcr:  9, cpr:  2.250, div:  1286
-r:     1200, a:     1200.00, d:  0.0000%, tcr: 14, cpr:  2.875, div:  1294
-r:      300, a:      300.00, d:  0.0000%, tcr: 11, cpr:  2.625, div:  7215
-r:      200, a:      200.00, d:  0.0000%, tcr: 16, cpr:  1.250, div: 15625
-r:      150, a:      150.00, d:  0.0000%, tcr: 13, cpr:  2.250, div: 14245
-r:      134, a:      134.00, d:  0.0000%, tcr: 11, cpr:  2.625, div: 16153
-r:      110, a:      110.00, d:  0.0000%, tcr: 12, cpr:  1.000, div: 47348
-r:       75, a:       75.00, d:  0.0000%, tcr:  4, cpr:  5.875, div: 35461
-r:       50, a:       50.00, d:  0.0000%, tcr: 16, cpr:  1.250, div: 62500
-r:       25, a:       25.00, d:  0.0000%, tcr: 16, cpr:  2.500, div: 62500
-r:        4, a:        4.00, d:  0.0000%, tcr: 16, cpr: 20.000, div: 48828
-r:        2, a:        2.00, d:  0.0000%, tcr: 16, cpr: 40.000, div: 48828
-r:        1, a:        1.00, d:  0.0000%, tcr: 16, cpr: 63.875, div: 61154
+::
+
+ r: 15625000, a: 15625000.00, d:  0.0000%, tcr:  4, cpr:  1.000, div:     1
+ r: 12500000, a: 12500000.00, d:  0.0000%, tcr:  5, cpr:  1.000, div:     1
+ r: 10416666, a: 10416666.67, d:  0.0000%, tcr:  6, cpr:  1.000, div:     1
+ r:  8928571, a:  8928571.43, d:  0.0000%, tcr:  7, cpr:  1.000, div:     1
+ r:  7812500, a:  7812500.00, d:  0.0000%, tcr:  8, cpr:  1.000, div:     1
+ r:  4000000, a:  4000000.00, d:  0.0000%, tcr:  5, cpr:  3.125, div:     1
+ r:  3686400, a:  3676470.59, d: -0.2694%, tcr:  8, cpr:  2.125, div:     1
+ r:  3500000, a:  3496503.50, d: -0.0999%, tcr: 13, cpr:  1.375, div:     1
+ r:  3000000, a:  2976190.48, d: -0.7937%, tcr: 14, cpr:  1.500, div:     1
+ r:  2500000, a:  2500000.00, d:  0.0000%, tcr: 10, cpr:  2.500, div:     1
+ r:  2000000, a:  2000000.00, d:  0.0000%, tcr: 10, cpr:  3.125, div:     1
+ r:  1843200, a:  1838235.29, d: -0.2694%, tcr: 16, cpr:  2.125, div:     1
+ r:  1500000, a:  1492537.31, d: -0.4975%, tcr:  5, cpr:  8.375, div:     1
+ r:  1152000, a:  1152073.73, d:  0.0064%, tcr: 14, cpr:  3.875, div:     1
+ r:   921600, a:   919117.65, d: -0.2694%, tcr: 16, cpr:  2.125, div:     2
+ r:   576000, a:   576036.87, d:  0.0064%, tcr: 14, cpr:  3.875, div:     2
+ r:   460800, a:   460829.49, d:  0.0064%, tcr:  7, cpr:  3.875, div:     5
+ r:   230400, a:   230414.75, d:  0.0064%, tcr: 14, cpr:  3.875, div:     5
+ r:   115200, a:   115207.37, d:  0.0064%, tcr: 14, cpr:  1.250, div:    31
+ r:    57600, a:    57603.69, d:  0.0064%, tcr:  8, cpr:  3.875, div:    35
+ r:    38400, a:    38402.46, d:  0.0064%, tcr: 14, cpr:  3.875, div:    30
+ r:    19200, a:    19201.23, d:  0.0064%, tcr:  8, cpr:  3.875, div:   105
+ r:     9600, a:     9600.06, d:  0.0006%, tcr:  9, cpr:  1.125, div:   643
+ r:     4800, a:     4799.98, d: -0.0004%, tcr:  7, cpr:  2.875, div:   647
+ r:     2400, a:     2400.02, d:  0.0008%, tcr:  9, cpr:  2.250, div:  1286
+ r:     1200, a:     1200.00, d:  0.0000%, tcr: 14, cpr:  2.875, div:  1294
+ r:      300, a:      300.00, d:  0.0000%, tcr: 11, cpr:  2.625, div:  7215
+ r:      200, a:      200.00, d:  0.0000%, tcr: 16, cpr:  1.250, div: 15625
+ r:      150, a:      150.00, d:  0.0000%, tcr: 13, cpr:  2.250, div: 14245
+ r:      134, a:      134.00, d:  0.0000%, tcr: 11, cpr:  2.625, div: 16153
+ r:      110, a:      110.00, d:  0.0000%, tcr: 12, cpr:  1.000, div: 47348
+ r:       75, a:       75.00, d:  0.0000%, tcr:  4, cpr:  5.875, div: 35461
+ r:       50, a:       50.00, d:  0.0000%, tcr: 16, cpr:  1.250, div: 62500
+ r:       25, a:       25.00, d:  0.0000%, tcr: 16, cpr:  2.500, div: 62500
+ r:        4, a:        4.00, d:  0.0000%, tcr: 16, cpr: 20.000, div: 48828
+ r:        2, a:        2.00, d:  0.0000%, tcr: 16, cpr: 40.000, div: 48828
+ r:        1, a:        1.00, d:  0.0000%, tcr: 16, cpr: 63.875, div: 61154
 
 With the baud base set to 15625000 and the unsigned 16-bit UART_DIV_MAX
-limitation imposed by `serial8250_get_baud_rate' standard baud rates
+limitation imposed by ``serial8250_get_baud_rate`` standard baud rates
 below 300bps become unavailable in the regular way, e.g. the rate of
 200bps requires the baud base to be divided by 78125 and that is beyond
 the unsigned 16-bit range.  The historic spd_cust feature can still be
@@ -92,15 +94,17 @@ used by encoding the values for, the pre
 and the clock divisor (DLM/DLL) as follows to obtain such rates if so
 required:
 
- 31 29 28             20 19   16 15                            0
-+-----+-----------------+-------+-------------------------------+
-|0 0 0|    CPR2:CPR     |  TCR  |            DLM:DLL            |
-+-----+-----------------+-------+-------------------------------+
+::
 
-Use a value such encoded for the `custom_divisor' field along with the
-ASYNC_SPD_CUST flag set in the `flags' field in `struct serial_struct'
+  31 29 28             20 19   16 15                            0
+ +-----+-----------------+-------+-------------------------------+
+ |0 0 0|    CPR2:CPR     |  TCR  |            DLM:DLL            |
+ +-----+-----------------+-------+-------------------------------+
+
+Use a value such encoded for the ``custom_divisor`` field along with the
+ASYNC_SPD_CUST flag set in the ``flags`` field in ``struct serial_struct``
 passed with the TIOCSSERIAL ioctl(2), such as with the setserial(8)
-utility and its `divisor' and `spd_cust' parameters, and the select
+utility and its ``divisor`` and ``spd_cust`` parameters, and then select
 the baud rate of 38400bps.  Note that the value of 0 in TCR sets the
 oversampling rate to 16 and prescaler values below 1 in CPR2/CPR are
 clamped by the driver to 1.
@@ -111,19 +115,17 @@ the oversampling rate and the clock divi
 respectively.  These parameters will set the baud rate for the serial
 port to 62500000 / 62.500 / 1250 / 16 = 50bps.
 
-References:
-
-[1] "OXPCIe200 PCI Express Multi-Port Bridge", Oxford Semiconductor,
-    Inc., DS-0045, 10 Nov 2008, Section "950 Mode", pp. 64-65
+Maciej W. Rozycki  <macro@orcam.me.uk>
 
-[2] "OXPCIe952 PCI Express Bridge to Dual Serial & Parallel Port",
-    Oxford Semiconductor, Inc., DS-0046, Mar 06 08, Section "950 Mode",
-    p. 20
+.. [OX200] "OXPCIe200 PCI Express Multi-Port Bridge", Oxford Semiconductor,
+   Inc., DS-0045, 10 Nov 2008, Section "950 Mode", pp. 64-65
 
-[3] "OXPCIe954 PCI Express Bridge to Quad Serial Port", Oxford
-    Semiconductor, Inc., DS-0047, Feb 08, Section "950 Mode", p. 20
+.. [OX952] "OXPCIe952 PCI Express Bridge to Dual Serial & Parallel Port",
+   Oxford Semiconductor, Inc., DS-0046, Mar 06 08, Section "950 Mode",
+   p. 20
 
-[4] "OXPCIe958 PCI Express Bridge to Octal Serial Port", Oxford
-    Semiconductor, Inc., DS-0048, Feb 08, Section "950 Mode", p. 20
+.. [OX954] "OXPCIe954 PCI Express Bridge to Quad Serial Port", Oxford
+   Semiconductor, Inc., DS-0047, Feb 08, Section "950 Mode", p. 20
 
-Maciej W. Rozycki  <macro@orcam.me.uk>
+.. [OX958] "OXPCIe958 PCI Express Bridge to Octal Serial Port", Oxford
+   Semiconductor, Inc., DS-0048, Feb 08, Section "950 Mode", p. 20
