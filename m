Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1D8D1562FE4
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Jul 2022 11:26:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235962AbiGAJZl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Jul 2022 05:25:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235059AbiGAJZC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Jul 2022 05:25:02 -0400
Received: from relay.uni-heidelberg.de (relay.uni-heidelberg.de [129.206.100.212])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F4DC70E4F
        for <linux-kernel@vger.kernel.org>; Fri,  1 Jul 2022 02:25:00 -0700 (PDT)
X-IPAS-Result: =?us-ascii?q?A2DLBQDZvL5iffxkzoFahX2BV5QQAwaBQoswgQmFaS2ML?=
 =?us-ascii?q?gEBAQEBAQEBAQkvEwQBAUCKESc4EwECBAEBAQEDAgMBAQEBAQEDAQEGAQEBA?=
 =?us-ascii?q?QEHBBQBASM8J4VoDYZ7AUaESwEDgmQBM65agQGGWgGBP4FlgT2JXIUggUCBE?=
 =?us-ascii?q?IR9hRGFbgSaTwoDCQQHBUYXEk4xIQJFCxwBCAYGBwEIAQUIKAQCAQEBBgUYF?=
 =?us-ascii?q?AEDAQETEgUTDAcoChICEgwKGwcHAwsFMg0CDgcBAQwPAQIPAwECEQEHAgkSC?=
 =?us-ascii?q?AYPKwgDAQEDAQcBAgIDIAsCAxYJBwgCAQIFAgIBAw8BCAocEhAUAgQNBB4JA?=
 =?us-ascii?q?ggBAhkeLAcCAgQOAyMdCAsKAw4DBAMBEAIYBwIBFQEFAgQIBAEDBgMIFRkBD?=
 =?us-ascii?q?ScEBwMSAg0BBgECBgEBBQUBAxgIAxQDBQECCAMWBwECIQUKJgkEDQMBIhsCA?=
 =?us-ascii?q?wMBBBsKAgECAgUWBQIBAQIDAgYVBgICPy8RHQ0IBAgECRIcIwECDAEEAQIHL?=
 =?us-ascii?q?wUELQIBAR4EBQEFDwIIAQEWAgYEAwICAwEBAgEWAhAIAggnFwcTMxkBBTcUD?=
 =?us-ascii?q?g8BAwYIGRwiBwkHBQYWAwwVJx4pBQcREhsPBA0NCjQgFiQBAQ4FAwESGREOB?=
 =?us-ascii?q?xQKUyYhFRAGASsWAwQBAwMCBhoBAgMiAhALCRUCBCEICQMWBiILHAUBIh0Zn?=
 =?us-ascii?q?BhaNE5ZgQKSaSqDDatmB4NREAGLEJR5LYVFkR0CkgAtlkaiQDSETzWBQ4F+T?=
 =?us-ascii?q?SODOAlIGQ+NdgGJXYUeczsCBgsBAQMJjwUBAQ?=
IronPort-Data: A9a23:ALSo66lz8Z35zEQJVgRyjN/o5gwZJkRdPkR7XQ2eYbSJt1+Wr1Gzt
 xJMD2vUPvyPM2Knf91ybYTj8UIP65/VyIUxTlRv+Xs3EltH+JHPbTi7Bh6tYHnCcJGroGGLT
 Sk6QoOdRCzhZiaE/n9BCpC48T8kk/vgqoPUUIYoAAgpLeNfYHpn2EgLd9IR2NYy24DmW1rV4
 LsenuWGULOb828sWo4rw//bwP9flKyaVOQw5wFWiVhj5TcyplFNZH4tDfjZw0jQGuG4KtWHq
 9Prl9lVyI95EyAFUbtJmp6jGqEDryW70QKm0hK6UID66vROS7BbPqsTbJIhhUlrZzqhu+5v9
 YREu6OMUxYRF63C398HTihCOnQrVUFG0OevzXmXtMWSyxWfNWbqwrBuAUA6MIkS9/x4R21Dn
 RAaAGlXP1bZ37zwmerjDLMx3KzPL+GyVG8bkmprzTXUFe4rW7jYX7jGo8Je3XIwi8FCEPLUa
 tAWLzZiBPjFS0QRZA9OUMxkxo9EgFHccwIHkAm3+5A0wFH891Mp3LX1bNfaL4niqcJ9xRrG+
 jifpwwVGCoyK96EziaM2n2pj+7L2yj8Xeo6G6e1+f1qqFmSwHEDBhoLU1eyvfi+jAi5Qd03A
 0gV/Dc+6LMu/UOqSNbVWxyjvGXCuh8aRsoWH+AkgCmDkbHf40CWB3QsSSNdbNsht4k9QjlC/
 luImc75QD9iqruYTVqD+bqO6zC/Iy4YKSkFfyBscOcey9zqoYVr11TSSNcmEKO0gtDxEzzqz
 HaGoUDSmon/k+Yv6buGrFnJvA62t6DgTgBy3R/Kb3iMu1YRiJGeW6Sk7l3S7PBlJYmfT0Wcs
 HVspyR4xL1RZX1qvHHdKNjhDI1F9N7ZYWGF2QEH840Jp2r9oyfLkZV4vWkmTHqFJProbhfFT
 Sc/Uytx6Z5fMX+gYLV4C25aI5p7lPK4fTgJftrdYtdIJ6faoBWb4Cxrb0OK0AjQfKUElKg+P
 c/CN9uqDDMaBKVrwT68Sv0Sl7Mmrszf+Y8xbc6rp/hE+ePADJJwdVvjGADeBgzexP/cyDg5C
 /4Fa6O3J+x3CYUSmBX//48JNkwtJnMmH53woME/Xrfdf1Q4QTpxUKOKmu9Jl2lZc0J9yLygE
 paVBBIw9bYDrSOWQel3Qio7Oe6xBMgXQYwTbHF1Zj5EJETPka70sPlDLcJvFVXW3OZuyeFpQ
 rEYfcSeD+5USyjWszIQcYb6to8KSfhYrV3mAsZRWxBhJMQIb1KSpbfZkv7HrnRm4tyf6ZBj+
 dVNF2rzHfI+euiVJJaON6nykQLu1ZXf8corN3b1zhBoUB2E2OBXx+bZ1Zfb/+lkxc3/+wan
IronPort-HdrOrdr: A9a23:1VIEpagXXchxcfUBGatgRM5TdXBQXhYji2hC6mlwRA09TyXBrb
 HVoBwavSWE6gr5K0tQ5OxoWZPwME80mqQFh7X5UY3DYOCighrSEGgA1/qT/9SDIVyGygc178
 4JGMUTZ7OQMbE5t7eD3ODSKadE/DDzytHOuQ6o9QYIcegFUdAC0+4zMHfmLqQ/fng4ObMJUL
 6nzo58hwPIQx4qhqjXPAh3YwHsnay0qK7b
X-IronPort-Anti-Spam-Filtered: true
Received: from mail01.uni-heidelberg.de ([129.206.100.252])
  by relay.uni-heidelberg.de with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 01 Jul 2022 11:24:59 +0200
Received: from localhost (ip-037-209-006-204.um11.pools.vodafone-ip.de [37.209.6.204])
        (Authenticated sender: ln194)
        by mail01.uni-heidelberg.de (Postfix) with ESMTPSA id 2577F300719FC;
        Fri,  1 Jul 2022 11:24:58 +0200 (CEST)
From:   Felix Schlepper <f3sch.git@outlook.com>
To:     gregkh@linuxfoundation.org
Cc:     linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        wjsota@gmail.com, Felix Schlepper <f3sch.git@outlook.com>
Subject: [PATCH v3 0/6] Staging: rtl8192e: rtllib_wx
Date:   Fri,  1 Jul 2022 11:24:48 +0200
Message-Id: <cover.1656667089.git.f3sch.git@outlook.com>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.7 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series addresses some issues raised by chechpatch.pl
and some very minor refactoring.

v2:
    - The first version, only addressed coding style issues.
      Now, I additionally refactored rtllib_modes and its uses, since
      there is no need to use string formatting.
    - Logically separated one assignement into two. So we dont have
      'fixed' = 'disabled', which was silly.

v3:
    - Fixed a checkpatch.pl warning, which was introduced with patch 1/6.

Felix Schlepper (6):
  Staging: rtl8192e: Refactored rtllib_modes
  Staging: rtl8192e: Avoid multiple assignments
  Staging: rtl8192e: Remove unnecessary parentheses
  Staging: rtl8192e: Added braces around else
  Staging: rtl8192e: Remove unnecessary blank line
  Staging: rtl8192e: Added spaces around '+'

 drivers/staging/rtl8192e/rtllib_wx.c | 37 +++++++++++-----------------
 1 file changed, 15 insertions(+), 22 deletions(-)

-- 
2.36.1

