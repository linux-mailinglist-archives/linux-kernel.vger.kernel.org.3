Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A25505A51E2
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Aug 2022 18:34:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230011AbiH2Qeg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Aug 2022 12:34:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230204AbiH2Qec (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Aug 2022 12:34:32 -0400
Received: from ms.lwn.net (ms.lwn.net [45.79.88.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3A8E9A697;
        Mon, 29 Aug 2022 09:34:30 -0700 (PDT)
Received: from localhost (unknown [IPv6:2601:281:8300:73:8b7:7001:c8aa:b65f])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id 396C62E0;
        Mon, 29 Aug 2022 16:34:30 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net 396C62E0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
        t=1661790870; bh=Plhxlb0bFXzqfP7cISMMDniN9J37OEISFCRf7a0RZdE=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=VUT+PEWn3haBhNKQxGvBDjvz0tYPi9aKTvGQr5TObnscuhKGtMerXwlgJbGzdgauQ
         /xec5O+yht9HRmYJ+UyQkm2ehM4RRw4vfMNh7d4ElLHgoEVWuCMmrIj1RoNVqoe+4E
         YwfBoP1owQ1X5xQkMpuJ4+wNkhalCBbM+NoIq9BCHc51LJEjZ/ffT2IDkUdwa0jK4Z
         6+4vT61pzu2w16NIju9Ka9VDYH/lRZ+e9fMauLI0XItk35VzcVvHJprHyytD71XFZd
         a9XjJ7TUCXJi7yARC6FZgY05b5CMcs6CoJW82Aq3DwIUM22i/lH0mEh36JH3QY3n/3
         apG7RInMzE2Qg==
From:   Jonathan Corbet <corbet@lwn.net>
To:     Lukasz Luba <lukasz.luba@arm.com>
Cc:     siyanteng@loongson.cn, alexs@kernel.org, peterz@infradead.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] docs: scheduler: Update new path for the sysctl knobs
In-Reply-To: <9fc3d98c-9262-e737-3bfa-ffd2c913428f@arm.com>
References: <20220816121907.841-1-lukasz.luba@arm.com>
 <9fc3d98c-9262-e737-3bfa-ffd2c913428f@arm.com>
Date:   Mon, 29 Aug 2022 10:34:29 -0600
Message-ID: <87sflfovoq.fsf@meer.lwn.net>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Lukasz Luba <lukasz.luba@arm.com> writes:

> Gentle ping. Could you take this patch, please?

I was hoping for an ack from the scheduler folks.  It seems correct,
though, so I've applied it.

Thanks,

jon
