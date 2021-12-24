Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3055147EAAF
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Dec 2021 03:56:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351043AbhLXC4M (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Dec 2021 21:56:12 -0500
Received: from esa6.hc1455-7.c3s2.iphmx.com ([68.232.139.139]:39529 "EHLO
        esa6.hc1455-7.c3s2.iphmx.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1351000AbhLXC4K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Dec 2021 21:56:10 -0500
IronPort-SDR: WTAAOhs+h3RjWQoh9Zzsu8ClJj8JhsgwM63K5obUFAgMkzfZW9w9t+t5QUG2IdkWonPv2TWm+2
 XhHvyL5xdkWk661n201wAr/pYVe1gCfqUsry6F/peRVgLtGHBEWTOS8JsG5N58qmAJ6Q7WdtuT
 l5dRScP94pgFTPaXkz3wR2uLpCrI9agZienM7hSd/MIHKPFjElbvW5+Z90qjlVHbhLWKFvGKzf
 7KWvxmqwFEn53vIg705xG5w1vw2RJLGWuqaFtM2DK+Y36xkxMISzKgTDoUAKi3vML9TZCWpSNA
 5HiHK4jBm9Ac6pwG00nOWu7Z
X-IronPort-AV: E=McAfee;i="6200,9189,10207"; a="57672820"
X-IronPort-AV: E=Sophos;i="5.88,231,1635174000"; 
   d="scan'208";a="57672820"
Received: from unknown (HELO yto-r3.gw.nic.fujitsu.com) ([218.44.52.219])
  by esa6.hc1455-7.c3s2.iphmx.com with ESMTP; 24 Dec 2021 11:56:09 +0900
Received: from yto-m2.gw.nic.fujitsu.com (yto-nat-yto-m2.gw.nic.fujitsu.com [192.168.83.65])
        by yto-r3.gw.nic.fujitsu.com (Postfix) with ESMTP id 139706DAE5
        for <linux-kernel@vger.kernel.org>; Fri, 24 Dec 2021 11:56:08 +0900 (JST)
Received: from m3050.s.css.fujitsu.com (msm.b.css.fujitsu.com [10.134.21.208])
        by yto-m2.gw.nic.fujitsu.com (Postfix) with ESMTP id 53EB7F36DE
        for <linux-kernel@vger.kernel.org>; Fri, 24 Dec 2021 11:56:07 +0900 (JST)
Received: from localhost.localdomain (unknown [10.125.5.220])
        by m3050.s.css.fujitsu.com (Postfix) with ESMTP id 2C90DB5;
        Fri, 24 Dec 2021 11:56:07 +0900 (JST)
From:   Rei Yamamoto <yamamoto.rei@jp.fujitsu.com>
To:     tglx@linutronix.de
Cc:     linux-kernel@vger.kernel.org, geert+renesas@glider.be,
        yamamoto.rei@jp.fujitsu.com
Subject: [RFC] hrtimer: About the warning message in hrtimer_interrupt()
Date:   Fri, 24 Dec 2021 11:39:24 +0900
Message-Id: <20211224023924.91851-1-yamamoto.rei@jp.fujitsu.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When the following warning message of hrtimer_interrupt() is output,
I often ignore it because I don't know what I should do.
-----
kernel/time/hrtimer.c
void hrtimer_interrupt(struct clock_event_device *dev)
{
:
        pr_warn_once("hrtimer: interrupt took %llu ns\n", 
		      ktime_to_ns(delta));
-----

What is the intention of this message?
What action should be required for this warning?
