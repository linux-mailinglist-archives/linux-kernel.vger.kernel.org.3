Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 14327464D85
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Dec 2021 13:08:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349158AbhLAML4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Dec 2021 07:11:56 -0500
Received: from esa4.hc1455-7.c3s2.iphmx.com ([68.232.139.117]:44516 "EHLO
        esa4.hc1455-7.c3s2.iphmx.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S242864AbhLAMLy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Dec 2021 07:11:54 -0500
X-Greylist: delayed 440 seconds by postgrey-1.27 at vger.kernel.org; Wed, 01 Dec 2021 07:11:54 EST
IronPort-SDR: l9/EMnnbZSbIJ4E7opbUb3BCAZI4mpKAoWiYVcFSaBjVf3XGormK7UVPXjmmhYSPf528c8QMkM
 DUqFSQwwL2U+bNcaPssGA7rjP8kI1f9Y5/e06UzJWHXoaiWd5Pw131f3+PZdX6za8nS3IuNswe
 OkO6Xbk7oU2gxLW4Rlu6OogZsnv371y9bwxTwGbOOkHRvupHjv8686mFZiWSaeH1CLj6jo2CpJ
 82egggdwUzrJdZB0YL27rUUoYADRx9avTXNWiNowU0mDPReBIMLKA3JfEUF9vDyEtt0NNr9PQW
 CWw2d3T7Rdz3ElXffJZeyADK
X-IronPort-AV: E=McAfee;i="6200,9189,10184"; a="54464835"
X-IronPort-AV: E=Sophos;i="5.87,278,1631545200"; 
   d="scan'208";a="54464835"
Received: from unknown (HELO yto-r1.gw.nic.fujitsu.com) ([218.44.52.217])
  by esa4.hc1455-7.c3s2.iphmx.com with ESMTP; 01 Dec 2021 21:01:12 +0900
Received: from yto-m4.gw.nic.fujitsu.com (yto-nat-yto-m4.gw.nic.fujitsu.com [192.168.83.67])
        by yto-r1.gw.nic.fujitsu.com (Postfix) with ESMTP id E85241013BD
        for <linux-kernel@vger.kernel.org>; Wed,  1 Dec 2021 21:01:11 +0900 (JST)
Received: from oym-om4.fujitsu.com (oym-om4.o.css.fujitsu.com [10.85.58.164])
        by yto-m4.gw.nic.fujitsu.com (Postfix) with ESMTP id 35D52C56D6
        for <linux-kernel@vger.kernel.org>; Wed,  1 Dec 2021 21:01:11 +0900 (JST)
Received: from localhost.localdomain (n3235113.np.ts.nmh.cs.fujitsu.co.jp [10.123.235.113])
        by oym-om4.fujitsu.com (Postfix) with ESMTP id F18E14008A297;
        Wed,  1 Dec 2021 21:01:10 +0900 (JST)
From:   Kohei Tarumizu <tarumizu.kohei@fujitsu.com>
To:     linux-kernel@vger.kernel.org, mchehab+huawei@kernel.org,
        will@kernel.org, catalin.marinas@arm.com,
        gregkh@linuxfoundation.org, corbet@lwn.net,
        ionela.voinescu@arm.com, pcc@google.com, bilbao@vt.edu,
        matorola@gmail.com, rafael@kernel.org
Cc:     tarumizu.kohei@fujitsu.com
Subject: [PATCH v2 0/2] docs: document the sysfs ABI for "nohz_full" and "isolated"
Date:   Wed,  1 Dec 2021 20:59:55 +0900
Message-Id: <20211201115957.254224-1-tarumizu.kohei@fujitsu.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add missing documentation of sysfs ABI for "nohz_full" and "isolated".
"nohz_full" was added by commit 6570a9a1ce3a("show nohz_full cpus in
sysfs") and "isolated" was added by commit 59f30abe94bf("show isolated
cpus in sysfs"). However, there is no documentation for these
interface.

Changes since v1[1]:
- Divide into two different entries

[1]https://lore.kernel.org/lkml/20211201071852.3568489-1-tarumizu.kohei@fujitsu.com/

Kohei Tarumizu (2):
  docs: document the sysfs ABI for "nohz_full"
  docs: document the sysfs ABI for "isolated"

 .../ABI/testing/sysfs-devices-system-cpu          | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

-- 
2.27.0

