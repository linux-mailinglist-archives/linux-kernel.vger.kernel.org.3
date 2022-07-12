Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5B26C57127A
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Jul 2022 08:50:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232127AbiGLGuN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Jul 2022 02:50:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229709AbiGLGuL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jul 2022 02:50:11 -0400
Received: from esa2.hgst.iphmx.com (esa2.hgst.iphmx.com [68.232.143.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 904D521829
        for <linux-kernel@vger.kernel.org>; Mon, 11 Jul 2022 23:50:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1657608610; x=1689144610;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=E/Mk4qkDcQFufbYbRlBTp8+sygDcOGBL1lOnGvnDcHk=;
  b=MiwT1P5tkXzlxX0fbhXeza+5AZas9ZRK5nSTfm5/AEdwLJMKBse50yh5
   PianmHUuxXx94+J7+k07BJp+rQnOqts3LRTD6NbZzSgiduYPxnpKeMNjM
   8XX4zsZJpaEiqQBZoZ5yBtEUs6oB6rtxOLfQmfIv5o5kCvcb4RNS94ZUz
   9W/xWy4SrVxC5j8OIQCa9wtN/Lsvmzj9Q3ioQ/8v8mWp3lXKxeaYY+BSd
   7b5hesCcKqF3MEv3dZ96xmkKHZBkd+1/8A5ogfz6HgnZn/dIzQJ724ZfB
   BTh+jSAzRdiDrexljrbAK6jruhKzOEzAhLJrqDLVh5u3sOlJV18VluqjS
   A==;
X-IronPort-AV: E=Sophos;i="5.92,265,1650902400"; 
   d="scan'208";a="309791857"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 12 Jul 2022 14:50:09 +0800
IronPort-SDR: fLZHmXEhh1aVBpp4eY/YVx3Q1Cu3iOYo3165j1TBTE8/Q3d2xC5L0fY1RGUzpkBTOc9uZG9K/4
 kZ3+c+gb06l1FxNykKshAap5EdBTvYAA5beDhIOoug57EZv61EnHdlb+lo79LZ22wvwBzAoO7z
 3FfiGI974Ha9jyfMEwv2K6mVMjjXbGxc7gUvH7qRFe3QS9YRZjeDW6gyT9vzAdBkQEQIvoLA4p
 YmeUhL2j7XC9O+HU07cPQaxeeN8CVHiHUVZcZ3p0t73wj4AZ5eYA6fG3XKqMfB3Aa6ukvvZp/L
 z6ajmH+9ZBXupEYScRLxRvtq
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 11 Jul 2022 23:11:46 -0700
IronPort-SDR: 71ZmJEGjGqqRid+eupUST0MgjX7tvVQb4RMKsDcPvo4xou6m6mxFDQip8mZ+xyfa9HO9579/pq
 DMAOcyiDBIp9A/oGogum0B6jrfEOCbdX6cv0Uash/YX+60D1JP3cDhTM5SOwMqZYQ+KL7AD6hI
 0Bz3+CgtT7lrPezO0iydp9WSOWRVg5NogycNXFdRSw5dNMQCU31BhCuEVwMoc/qO638tRAcLN+
 xmP9ncqtQvghc2j7ciihVzlU4AIlw8PZqgJml1Mi/PbR71wX4qQsEQaUHVLsHIenonkqRDRPe5
 XkI=
WDCIronportException: Internal
Received: from unknown (HELO redsun91.ssa.fujisawa.hgst.com) ([10.149.66.72])
  by uls-op-cesaip02.wdc.com with ESMTP; 11 Jul 2022 23:50:09 -0700
From:   Johannes Thumshirn <johannes.thumshirn@wdc.com>
To:     Greg Kroah-Hartmann <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, Johannes Thumshirn <jth@kernel.org>
Subject: [PATCH 0/1] drivers: mcb: updates for 5.20
Date:   Mon, 11 Jul 2022 23:50:07 -0700
Message-Id: <cover.1657607743.git.johannes.thumshirn@wdc.com>
X-Mailer: git-send-email 2.35.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Greg,

Here's one patch for drivers/mcb aimed at 5.20. It's a simple change from
ida_simple_get()/ida_simple_remove() to ida_alloc() and ida_free() from keliu.

Thanks,
	Johannes


keliu (1):
  drivers: mcb: directly use ida_alloc()/free()

 drivers/mcb/mcb-core.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

-- 
2.35.3

