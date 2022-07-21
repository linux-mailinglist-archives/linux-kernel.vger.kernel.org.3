Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2377E57C202
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Jul 2022 03:53:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231430AbiGUBx0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Jul 2022 21:53:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229906AbiGUBxY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jul 2022 21:53:24 -0400
Received: from out30-43.freemail.mail.aliyun.com (out30-43.freemail.mail.aliyun.com [115.124.30.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E61CC13F05;
        Wed, 20 Jul 2022 18:53:22 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R731e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045170;MF=joseph.qi@linux.alibaba.com;NM=1;PH=DS;RN=7;SR=0;TI=SMTPD_---0VJzMVEo_1658368398;
Received: from 30.227.74.51(mailfrom:joseph.qi@linux.alibaba.com fp:SMTPD_---0VJzMVEo_1658368398)
          by smtp.aliyun-inc.com;
          Thu, 21 Jul 2022 09:53:19 +0800
Message-ID: <20aa3fe4-0ad1-80b6-ca64-b0bcba884b49@linux.alibaba.com>
Date:   Thu, 21 Jul 2022 09:53:18 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.11.0
Subject: Re: [PATCH 2/3] ocfs2: Remove a useless spinlock
Content-Language: en-US
To:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc:     David.Laight@ACULAB.COM, jlbec@evilplan.org,
        kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org,
        mark@fasheh.com, ocfs2-devel@oss.oracle.com
References: <bd6796635e58f9c47cf857573c3b9474a00ce26a.1658224839.git.christophe.jaillet@wanadoo.fr>
 <8ba7004d330cbe5f626539a8a3bff696d0c4285e.1658224839.git.christophe.jaillet@wanadoo.fr>
 <7b644e5d32d74d3d90dfc5b1786ae5b9@AcuMS.aculab.com>
 <29c3fbdd-7695-46c5-bb75-fe358c574ab3@wanadoo.fr>
 <07c924de-78bf-c993-ce73-635af71f4edd@linux.alibaba.com>
 <f313cb6f-de75-2447-eebc-5c240bc243a2@wanadoo.fr>
 <65e6bbcb-2c33-2e43-1826-a62387572310@linux.alibaba.com>
 <a66632a1-9cde-1b3c-afa9-8f63bd4a9cf0@wanadoo.fr>
From:   Joseph Qi <joseph.qi@linux.alibaba.com>
In-Reply-To: <a66632a1-9cde-1b3c-afa9-8f63bd4a9cf0@wanadoo.fr>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-9.9 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
        USER_IN_DEF_SPF_WL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 7/20/22 9:32 PM, Christophe JAILLET wrote:
> Le 20/07/2022 à 11:48, Joseph Qi a écrit :
>>
>> These code are introduced long time ago...
>> Refer to commit b4df6ed8db0c "[PATCH] ocfs2: fix orphan recovery
>> deadlock", I guess it plays a role 'barrier' and make sure test node map
>> is executed prior than signal orphan recovery thread. In other words, to
>> serialize evict inode and orphan recovery.
>>
>> Thanks,
>> Joseph
>>
> 
> Ok, so just leave it as-is.
> 
> Should I resend the serie without this patch, or can 1/3 and 3/3 be applied as-is?
> 

If you don't mind, please resend with my rvb and involve akpm as well.

Thanks,
Joseph
