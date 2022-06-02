Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9471D53BF42
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Jun 2022 22:03:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239138AbiFBUCy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Jun 2022 16:02:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238383AbiFBUCb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Jun 2022 16:02:31 -0400
X-Greylist: delayed 64 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Thu, 02 Jun 2022 13:02:30 PDT
Received: from smtp687out9.mel.oss-core.net (smtp687out9.mel.oss-core.net [210.50.216.236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 9B651FC5
        for <linux-kernel@vger.kernel.org>; Thu,  2 Jun 2022 13:02:30 -0700 (PDT)
X-IPAS-Result: =?us-ascii?q?A2AIbgDRFZli/7NplnpaGQEBAQEBATwBAQEBAQEBAQEBA?=
 =?us-ascii?q?QECAQEBAQEBAQEBAQEVCYFGAoE6AgEBAaQ+hxkbgiWHZ4F8CwEBASEwBAEBh?=
 =?us-ascii?q?HgBAYVRJjYHDgECBAEBAQEDAgMBAQEBAQEDAQEGAQEBAQEBBgSBHIUvRoZUI?=
 =?us-ascii?q?AcBgVYBDgEehXUBAaxugTMNdIRZFIIQBAqCc4E7AgEBAQEBiUKFX32BEIFYg?=
 =?us-ascii?q?jgBhX2DQIIuBJJGhCMEGzsDIRUYNBKBIUUsAQgGBgcKBTIGAgwYFAQCExJTH?=
 =?us-ascii?q?QISDAocDlQZDA8DEgMRAQcCCxIIFSwIAwIDCAMCAy4CAxgJBwoDHQgKChISE?=
 =?us-ascii?q?BQCBAYNHgsIAxkfLQkCBA4DQwgLCgMRBAMTGAsWCBAEBgMJLw0oCwMUDwEGA?=
 =?us-ascii?q?wYCBQUBAyADFAMFJwcDIQcLJg0NBCMdAwMFJgMCAhsHAgIDAgYXBgICcQooD?=
 =?us-ascii?q?QgECAQMEB0lEwUCBzEFBC8CHgQFBhEJAhYCBgQFAgQEFgICEggCCCcbBxY2G?=
 =?us-ascii?q?QEFDk8GCwkhHAkgEQUGFgMjcwVIDyk1OQZ8D65SkECeMwqDTgUpB4EJB55JM?=
 =?us-ascii?q?YNjAZcSEQEngVeLVJZoqBKBCQOCC3AVggiBHFAonRCBEAIGCwEBAwmPCgEB?=
IronPort-Data: A9a23:LtxA+qIJ49jhOKGdFE+RW5clxSXFcZb7ZxGr2PjKsXjdYENShDYAm
 mBNWTiAaa6Ma2Gkcohwadnl8xgEsMXXzNNhQVYd+CA2RRqmi+KbXIjFdi8cHM8zwunrFh8PA
 xA2M4GYRCwMo/u1Si6FatANl1ElvU2zbue6Wbes1hxZH1c+En9/0Ug7wYbVv6Yx6TSHK1LV0
 T/Ni5W31G+Ng1aY5UpNtspvADs21BjDkGtwUm4WPJinj3eC/5UhN6/zEInqR5fOria4KcbhL
 wrL5OnREmo0ZH7BAPv9+lrwWhVirrI/oWFih1IOM5VOjCSuqQQW7p8yJtcBan1GjiqxkZdul
 tpTua6vHFJB0q3kwIzxUjFnMgc7H/Jp1pPtCF/i6O77I0/uKiG2hawzVAdvZdBeo7kmaY1N3
 aVwxDQlbxaNgMqzybS3W69ngcFLwMzDbNlH5y8/lmCx4fAOWa3mcZjjwsFh5xQdivtPTK/lf
 vVEdm86BPjHS1gVUrsNM7o6neG1ljz8fidepVa9u6U6+S7QwRZ33byrN8DaEuFmXu0MxBzd/
 z+euj2hX1RDa43Z0iaMtG2mnOjGkSnyXo5UErCksPd36LGO+lEu5NQtfQPTiZGEZoSWArqz9
 2R8FvISkJUP
IronPort-HdrOrdr: A9a23:9fYsm6P9BzN1F8BcTqKjsMiBIKoaSvp037BN7S9MoH1uHvBw+P
 rOoB1273TJYUgqOE3I8OroUJVoJ0mzyXcf2+Ms1NmZMTXbhA==
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="5.91,272,1647262800"; 
   d="scan'208";a="82056739"
Received: from 122-150-105-179.sta.wbroadband.net.au (HELO WIN-J7GFDBAO51J) ([122.150.105.179])
  by smtp687.mel.oss-core.net with ESMTP; 03 Jun 2022 06:01:23 +1000
From:   "Martin Otamori" <info@mandy.com>
Subject: Acknowledge this message
To:     <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Reply-To: <okkmart68@gmail.com>
Date:   Thu, 2 Jun 2022 13:01:20 -0700
Message-Id: <021920220601131F0DDFDF5E-91A9E3996D@mandy.com>
X-Spam-Status: Yes, score=7.8 required=5.0 tests=BAYES_50,
        FREEMAIL_FORGED_REPLYTO,FREEMAIL_REPLYTO_END_DIGIT,
        RCVD_IN_BL_SPAMCOP_NET,RCVD_IN_DNSWL_LOW,RCVD_IN_SBL_CSS,SPF_HELO_NONE,
        SPF_SOFTFAIL,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Report: *  1.3 RCVD_IN_BL_SPAMCOP_NET RBL: Received via a relay in
        *      bl.spamcop.net
        *      [Blocked - see <https://www.spamcop.net/bl.shtml?122.150.105.179>]
        * -0.7 RCVD_IN_DNSWL_LOW RBL: Sender listed at https://www.dnswl.org/,
        *       low trust
        *      [210.50.216.236 listed in list.dnswl.org]
        *  3.3 RCVD_IN_SBL_CSS RBL: Received via a relay in Spamhaus SBL-CSS
        *      [122.150.105.179 listed in zen.spamhaus.org]
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.5000]
        *  0.7 SPF_SOFTFAIL SPF: sender does not match SPF record (softfail)
        *  0.2 FREEMAIL_REPLYTO_END_DIGIT Reply-To freemail username ends in
        *      digit
        *      [okkmart68[at]gmail.com]
        *  0.0 SPF_HELO_NONE SPF: HELO does not publish an SPF Record
        * -0.0 T_SCC_BODY_TEXT_LINE No description available.
        *  2.1 FREEMAIL_FORGED_REPLYTO Freemail in Reply-To, but not From
X-Spam-Level: *******
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I will give you more details as soon as you acknowledge this message.
Thank you.
Martin Otamori.

