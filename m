Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4BE99558A08
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Jun 2022 22:29:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229830AbiFWU3T (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Jun 2022 16:29:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229449AbiFWU3S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jun 2022 16:29:18 -0400
X-Greylist: delayed 65 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Thu, 23 Jun 2022 13:29:16 PDT
Received: from relay.uni-heidelberg.de (relay.uni-heidelberg.de [129.206.100.212])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5587053A7A
        for <linux-kernel@vger.kernel.org>; Thu, 23 Jun 2022 13:29:16 -0700 (PDT)
X-IPAS-Result: =?us-ascii?q?A2CDBQCJzLRiffxkzoFagliZCwEBAQaMbQOBBoYWiieCB?=
 =?us-ascii?q?wEBAQEBAQEBAQlCBAEBQIoPJzYHDgECBAEBAQEDAgMBAQEBAQEDAQEGAQEBA?=
 =?us-ascii?q?QEHBBQBASM8J4V1hnsBRoRLAYJnATOtcIEBhlkBgT+BZYE9iVaGX4EQhA9uh?=
 =?us-ascii?q?RGFbgSZQwoDCQQHBUYXEk4xIQJFCxwBCAYGBwEIAQUIKAQCAQEBBgUYFAEDA?=
 =?us-ascii?q?QETEgUTDAcoChICEgwKGwcHAwsFMg0CDgcBAQwPAQIPAwECEQEHAgkSCAYPK?=
 =?us-ascii?q?wgDAQEDAQcBAgIDIAsCAxYJBwgCAQIFAgIBAw8BCAocEhAUAgQNBB4JAggBA?=
 =?us-ascii?q?hkeLAcCAgQOAyMdCAsKAw4DBAMBEAIYBwIBFQEFAgQIBAEDBgMIFRkBDScEB?=
 =?us-ascii?q?wMSAg0BBgECBgEBBQUBAxgIAxQDBQECCAMWBwECIQUKJgkEDQMBIhsCAwMBB?=
 =?us-ascii?q?BsKAgECAgUWBQIBAQIDAgYVBgICPy8RHQ0IBAgECRIcIwECDAEEAQIHLwUEL?=
 =?us-ascii?q?QIBAR4EBQEFDwIIAQEWAgYEAwICAwEBAgEWAhAIAggnFwcTMxkBBTcUDg8BA?=
 =?us-ascii?q?wYIGRwiBwkHBQYWAw4VJx4pBQcREhsPBA0NCjQgFiQBAQ4FAwESGREOBxQKU?=
 =?us-ascii?q?yYiFRAGASsYAwQBAwMCBh4BAgMlAhkFASIdGZsKexOCKhWSfa5uB4NREAGgB?=
 =?us-ascii?q?y2DY5J/ApIAlnCiE1qETjWBMwGCDU0jgzlQGQ+NdgGOe4EuAgYLAQEDCY8BA?=
 =?us-ascii?q?QE?=
IronPort-Data: A9a23:ZgOGKa6GBcnNptF80WCAxQxRtLHHchMFZxGqfqrLsTDasY5as4F+v
 msXC2mAb/rbMDT9L94gYYqx9kkD7MXcm99mGgdurik8Zn8b8sCt6faxdxqvZXPMcqUvb67FA
 +E2MISowBUcFyeEzvuVGuG96yE6j8lkf5KkYAL+EngZqTRMFWFw03qPp8Zj2tQy2YbjWFvX0
 T/Pi5S31GGNimYc3l08tvrrRCNH5JwebxtB4zTSzdgS1LPvvyF94KA3fMldHFOgKmVgJdNWc
 s6YpF2PEsM1yD92Yj+tuu6TnkTn2dc+NyDW4pZdc/DKbhSvOkXe345jXMfwZ3u7hB2GlpdL8
 fR2l6XgSBwpDPDrheMeDBZHRnQW0a1uoNcrIFC6uM2XlxSAbn3thvVjDU07OYcV4OkxDWwmG
 f4wcWpcKErb2aTvmOr9ELQ27iggBJCD0Ic3oXpgyTzBFfs8aYvfXqmM+NlZmTc9h8xDGfzTf
 cVfZTcHgBHoOkMSYgZPWM1i9AuuribEThN2i1WonrBtoEz2zTAg6+O8YMWAL7RmQu0OwhjE/
 Duel4jjOTkVLtGQyjqt9nOqm//Bmj79VIsOFbq+sPlwjzW7wm0VFQ1TTkeyrvi/hWa6WslDM
 AoQ+ywzve4++VLDZtemRBa45nGFojYbRsZUFOo5rgqKz8L85wefG3hBTTNbbtEinNE5SCZs1
 VKTmd7tQzt1v9WopWm1876VqWvrfzUTLCoCaC4IQA8P7sPs5o0+5v7Scjp9OKG8yefMOArS+
 mCLtygM2pIOis1U2LruqDgrnAmQjpTOSwc04CDeUWSk8h51aeaZi2qAtAezARFocdfxc7WRg
 JQXs5TPsLlWUvlhgATdHrVVRdlF8t7YaGW0vLJ5I3U23xiAk5JJVaBd4T1zIE1kKMlsldTBP
 h6K41s5CHN7FnKmYKkyXCllEdg2wK3qGM7qPs04g/JLa5l1LFbB4SdvIE6d3mzglEIhi655N
 ZrznSeQ4ZQyV/QPINmeHrl1PVoXKsYWnj+7qXfTk03P7FZmTCTJIYrpyXPXBgzD0IuKoR/O7
 /FUPNaQxhNUXYXWO3eKr9ZLfAhQfCBgXvgaTvC7kMbdeGKK/0l/VZfsLU8JJNQNc1l9zL+Zo
 y/kBCe0NnKm3SGZdW1mlUyPmJu0Acgj9ytjVcDdFVyl32c+bM6y6qYBeoEsfKU2vOpu0eFzV
 fptRilzKqsnd9gzwBxDNsOVhNI5K3yWafemZXfNjM4XI8U9HWQkO7bMImPSycX5Jnvo5Jpm/
 uP4vu4ZKLJaLzlf4A/tQKrH5zuMUbI1xYqeg2OgzgFvRXjR
IronPort-HdrOrdr: A9a23:5WGk0617c1xrBZt0dD5MTgqjBKkkLtp133Aq2lEZdPWaSKClfq
 eV7ZYmPHDP5gr5NEtLpTniAtjifZqjz/9ICOAqVN/IYOCMggSVxe9ZgLcKuweBJxHD
X-IronPort-Anti-Spam-Filtered: true
Received: from mail01.uni-heidelberg.de ([129.206.100.252])
  by relay.uni-heidelberg.de with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 23 Jun 2022 22:27:59 +0200
Received: from localhost (ip-037-209-006-204.um11.pools.vodafone-ip.de [37.209.6.204])
        (Authenticated sender: ln194)
        by mail01.uni-heidelberg.de (Postfix) with ESMTPSA id 3CF02300719FC;
        Thu, 23 Jun 2022 22:27:58 +0200 (CEST)
From:   Felix Schlepper <f3sch.git@outlook.com>
To:     gregkh@linuxfoundation.org
Cc:     linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Felix Schlepper <f3sch.git@outlook.com>
Subject: [PATCH v4 0/3] Staging: rtl8192e: Safer allocation and cleaner error handling
Date:   Thu, 23 Jun 2022 22:27:52 +0200
Message-Id: <cover.1655975970.git.f3sch.git@outlook.com>
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


v2:
  - replaced kmalloc with kzalloc against memory initialization defects,
    thus also removing a memset
  - made error handling more consistent

v3:
  - Split into smaller commits so that it's easier to review

v4:
  - clearer commit messages
  - added missing kfree

Felix Schlepper (3):
  Staging: rtl8192e: Use struct_size
  Staging: rtl8192e: Using kzalloc and delete memset
  Staging: rtl8192e: Cleaning up error handling

 drivers/staging/rtl8192e/rtllib_tx.c | 24 +++++++++++-------------
 1 file changed, 11 insertions(+), 13 deletions(-)

--
2.36.1
