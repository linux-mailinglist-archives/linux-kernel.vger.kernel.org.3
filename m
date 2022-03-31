Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C419E4ED0FE
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Mar 2022 02:45:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349130AbiCaArS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Mar 2022 20:47:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229487AbiCaArR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Mar 2022 20:47:17 -0400
Received: from esa5.hc1455-7.c3s2.iphmx.com (esa5.hc1455-7.c3s2.iphmx.com [68.232.139.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9738755BE3
        for <linux-kernel@vger.kernel.org>; Wed, 30 Mar 2022 17:45:30 -0700 (PDT)
X-IronPort-AV: E=McAfee;i="6200,9189,10302"; a="67641377"
X-IronPort-AV: E=Sophos;i="5.90,223,1643641200"; 
   d="scan'208";a="67641377"
Received: from unknown (HELO yto-r2.gw.nic.fujitsu.com) ([218.44.52.218])
  by esa5.hc1455-7.c3s2.iphmx.com with ESMTP; 31 Mar 2022 09:45:28 +0900
Received: from yto-m1.gw.nic.fujitsu.com (yto-nat-yto-m1.gw.nic.fujitsu.com [192.168.83.64])
        by yto-r2.gw.nic.fujitsu.com (Postfix) with ESMTP id D1DFEC68AE
        for <linux-kernel@vger.kernel.org>; Thu, 31 Mar 2022 09:45:27 +0900 (JST)
Received: from m3003.s.css.fujitsu.com (m3003.s.css.fujitsu.com [10.128.233.114])
        by yto-m1.gw.nic.fujitsu.com (Postfix) with ESMTP id 2C9FFD085A
        for <linux-kernel@vger.kernel.org>; Thu, 31 Mar 2022 09:45:27 +0900 (JST)
Received: from localhost.localdomain (unknown [10.125.5.220])
        by m3003.s.css.fujitsu.com (Postfix) with ESMTP id 05EF120433B9;
        Thu, 31 Mar 2022 09:45:27 +0900 (JST)
From:   Rei Yamamoto <yamamoto.rei@jp.fujitsu.com>
To:     tglx@linutronix.de
Cc:     linux-kernel@vger.kernel.org, ming.lei@redhat.com,
        yamamoto.rei@jp.fujitsu.com
Subject: Re: [PATCH v3] irq: consider cpus on nodes are unbalanced
Date:   Thu, 31 Mar 2022 09:24:57 +0900
Message-Id: <20220331002457.10645-1-yamamoto.rei@jp.fujitsu.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <87zgl7m41c.ffs@tglx>
References: <87zgl7m41c.ffs@tglx>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 31 2022 at 01:09:03 +0200 Thomas Gleixner wrote:
> On Wed, Mar 30 2022 at 13:42, Rei Yamamoto wrote:
>> On Thu, Feb 10, 2022 at 12:10:18PM +0800, Ming Lei wrote:
>>> On Thu, Feb 10, 2022 at 12:10:53PM +0900, Rei Yamamoto wrote:
>>
>> Could you pick this patch up?
>
> Which patch? Whatever that patch is, it did neither arrive in my inbox nor in a public archive:
>
>    https://lore.kernel.org/all/20220210031053.5352-1-yamamoto.rei@jp.fujitsu.com/

Certainly the patch did not seem to arrive.
I will send the patch ,which I want you to pick up, as v4.

Thanks, 
Rei
