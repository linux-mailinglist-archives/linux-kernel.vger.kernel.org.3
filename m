Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6A59157C237
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Jul 2022 04:25:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231659AbiGUCZb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Jul 2022 22:25:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229608AbiGUCZ2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jul 2022 22:25:28 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id AE7D5DF1C
        for <linux-kernel@vger.kernel.org>; Wed, 20 Jul 2022 19:25:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1658370322;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=16oa1YEsnvG3ajQWYaMzBvuYE8agLJ+BSw/vbUcX1K8=;
        b=fBDE/MCHhbX5wVSTbIuvMwejYZ9wopiAhSHr4Ld8vw26AQmY3+KDJL/cR6ON5OWuhmjB/O
        itHzW9KW5vNjqfwhdRNAmRxiiIaMKcbJez0Yn/7E/MfUOiJTTTIKloltGZHwoZWVaD/61D
        cYwL6+qkPNP0PpJr0qP6+qJW2ZS/qfs=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-365-YvroFOYOP125nJ4dKrlmfg-1; Wed, 20 Jul 2022 22:25:18 -0400
X-MC-Unique: YvroFOYOP125nJ4dKrlmfg-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com [10.11.54.2])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id ACECB3802B95;
        Thu, 21 Jul 2022 02:25:17 +0000 (UTC)
Received: from [10.22.8.36] (unknown [10.22.8.36])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 675AA403D0DB;
        Thu, 21 Jul 2022 02:25:17 +0000 (UTC)
Message-ID: <62de0805-a6ec-f2a1-00f2-1b24a95c72f0@redhat.com>
Date:   Wed, 20 Jul 2022 22:25:17 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH RFC] rtmutex: Fix BUG_ON at kernel/locking/rtmutex.c:1331!
Content-Language: en-US
To:     "yuxin.ye" <yeyuxin0925@gmail.com>, linux-rt-users@vger.kernel.org,
        peterz@infradead.org, mingo@redhat.com, will@kernel.org,
        boqun.feng@gmail.com
Cc:     linux-kernel@vger.kernel.org
References: <20220720072806.43445-1-yeyuxin0925@gmail.com>
From:   Waiman Long <longman@redhat.com>
In-Reply-To: <20220720072806.43445-1-yeyuxin0925@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.84 on 10.11.54.2
X-Spam-Status: No, score=-3.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/20/22 03:28, yuxin.ye wrote:
> before rt_mutex_adjust_prio_chain(),unlock lock->wait_lock will cause
> BUG_ON at kernel/locking/rtmutex.c:1331:

The current upstream kernel/locking/rtmutex.c has no BUG_ON() call. 
Which version of the kernel are you using?

Cheers,
Longman

