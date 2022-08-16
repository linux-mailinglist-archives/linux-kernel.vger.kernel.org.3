Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 62C6D595498
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Aug 2022 10:09:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232197AbiHPIIv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Aug 2022 04:08:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232080AbiHPII1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Aug 2022 04:08:27 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 211D9119451
        for <linux-kernel@vger.kernel.org>; Mon, 15 Aug 2022 22:31:44 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id D298BB8112E
        for <linux-kernel@vger.kernel.org>; Tue, 16 Aug 2022 05:31:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B0514C433C1;
        Tue, 16 Aug 2022 05:31:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1660627901;
        bh=FcEQ4/l4VGQcro7YhMLuFZtIMXbfZJhx8EZh+f/C4VQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=qmIiD6hNpvomayCmbRC3P3RgyccEEHTRS3e6uBrh8IjeUyrWrZPDQZJU93M+aYg06
         ykOll+dTTqf7lo6CCVVI59gcJoXLNdTdsSL6bJJWc0Wem3DTm6Q3zDuKLbMZjmjoK2
         4TaYrS+FAAtU/W1vyI1uwbrhWwhs0S3hBTViYoNM=
Date:   Tue, 16 Aug 2022 07:31:36 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     mawupeng <mawupeng1@huawei.com>
Cc:     rppt@linux.vnet.ibm.com, hughd@google.com, aarcange@redhat.com,
        hannes@cmpxchg.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, wangkefeng.wang@huawei.com,
        willy@infradead.org
Subject: Re: [PATCH stable 4.14,4.19 1/1] mm: Fix page counter mismatch in
 shmem_mfill_atomic_pte
Message-ID: <YvsruBZBP+KpEBdb@kroah.com>
References: <20220802013251.3022141-1-mawupeng1@huawei.com>
 <09129cd3-7363-3079-bd57-dde9c73684f1@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <09129cd3-7363-3079-bd57-dde9c73684f1@huawei.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 16, 2022 at 11:27:08AM +0800, mawupeng wrote:
> Cc Greg

Cc Greg for what?  I have no context here at all as to what you want me
to do...

totally confused,

greg k-h
