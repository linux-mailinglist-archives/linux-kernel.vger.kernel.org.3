Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F30465321A3
	for <lists+linux-kernel@lfdr.de>; Tue, 24 May 2022 05:37:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233152AbiEXDgM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 May 2022 23:36:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230190AbiEXDgI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 May 2022 23:36:08 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 607C5D53
        for <linux-kernel@vger.kernel.org>; Mon, 23 May 2022 20:36:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1653363363; x=1684899363;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=ViMx7kYiUc2GfffEZdsU7jW+Xl12T7oj5pNftkb4D4o=;
  b=NfTlVGZXEooHGLTR2HkaAvj1KY3A3NoV20LjCFdf8gQngA5jmy6y3TuT
   5XIiMFMOQ9O1+5FBv4j+tIkvRqpn6bvnErA6O3Fgv/2b9aFpAT11/6Hux
   XkUucJkw//bKv1LkankWiQjwio0zC9LyjbcIN7EsowgTpKA201X2mcFH8
   ePraKvzPo235FHpNV0x4rlx+qA8tfDn/Cd1QnIsZ18bN07Agu2AkBten1
   yYw7agGRolcvt2IiEu6QL9tJ052f3q1+V1asYVHp6Zdn18eIPK8ERprqT
   mYzDzZgpMYtNUU+mAueJRY99+KrShP4qXn3XrnFlHcEGzaCTr0v0Zk4nd
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10356"; a="253295123"
X-IronPort-AV: E=Sophos;i="5.91,247,1647327600"; 
   d="scan'208";a="253295123"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 May 2022 20:35:55 -0700
X-IronPort-AV: E=Sophos;i="5.91,247,1647327600"; 
   d="scan'208";a="548287336"
Received: from jiaqingz-mobl.ccr.corp.intel.com (HELO [10.249.169.113]) ([10.249.169.113])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 May 2022 20:35:53 -0700
Message-ID: <91183d9f-a4a2-b237-b097-2ba546f9308c@linux.intel.com>
Date:   Tue, 24 May 2022 11:35:50 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Subject: Re: [PATCH v3] mtd: spi-nor: macronix: Add support for mx66l2g45g
Content-Language: en-US
To:     Michael Walle <michael@walle.cc>
Cc:     linux-mtd@lists.infradead.org,
        Tudor Ambarus <tudor.ambarus@microchip.com>,
        Pratyush Yadav <p.yadav@ti.com>, linux-kernel@vger.kernel.org
References: <20220523150334.1758649-1-jiaqing.zhao@linux.intel.com>
 <e310ab2100f459346ae6cfa77c9ada19@walle.cc>
From:   Jiaqing Zhao <jiaqing.zhao@linux.intel.com>
In-Reply-To: <e310ab2100f459346ae6cfa77c9ada19@walle.cc>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-8.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022-05-24 01:04, Michael Walle wrote:
> Am 2022-05-23 17:03, schrieb Jiaqing Zhao:
>> Macronix mx66l2g45g is a 3V, 2Gbit (256MB) NOR flash that supports
>> x1, x2, and x4 operation modes.
>>
>> Tested read/write/erase with Aspeed AST2600 BMC SoC operating in x2
>> mode at 50MHz, using Aspeed spi-mem driver.
>>
>> Signed-off-by: Jiaqing Zhao <jiaqing.zhao@linux.intel.com>
> 
> Reviewed-by: Michael Walle <michael@walle.cc>
> 
> # is this picked up by b4? link goes to the sfdp dump

May I ask what do you mean by "is this picked up by b4?"

> Link: https://lore.kernel.org/r/2b859cff-2403-0526-f3ae-749920b3fd8b@linux.intel.com
> 
> -michael
