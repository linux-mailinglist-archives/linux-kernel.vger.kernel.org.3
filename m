Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B45964DA8E3
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Mar 2022 04:29:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353438AbiCPDa1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Mar 2022 23:30:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244144AbiCPDa0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Mar 2022 23:30:26 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62672396BE
        for <linux-kernel@vger.kernel.org>; Tue, 15 Mar 2022 20:29:11 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id CB5C9B81A07
        for <linux-kernel@vger.kernel.org>; Wed, 16 Mar 2022 03:29:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 79CB8C340E8;
        Wed, 16 Mar 2022 03:29:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1647401348;
        bh=aIceSeELNkeFGeC2kSc1k8qFifJ8gVB3BT8bdETjyG0=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=p8UCyAH3H6HpPCCfMoenlagaKEaxQ4xINiKDt7oXB0DqySoEvAONKee1o1nW6t9KT
         +KD/Fxc3c1Ykl9T4zijh0Zaooi4pmboBXFeH8mYS1emOhwjHJTxf39n7rnkkgnJpk9
         vobAjtTA4G+EOUSkHkrBcethWMAAYiYEnN+HsJFmhOxSgrWMrzYhaRbUohyOMv331W
         RTmMV5h6ViAP6mTSwfTpFBlKuGIBWFeOdjmQM14bA2VVQGypUmrxjW+siaKS/wJsnG
         ZZLRk2+ykXj2Mt9YpzUhAxjkRpBA/zUpAHxhJuiBJao+rV+UKB89hpYv6owsTtA6Qi
         5OvexvwoCmzQA==
Message-ID: <fd70cca5-f6cc-9544-9c30-3bed764154a0@kernel.org>
Date:   Wed, 16 Mar 2022 11:29:04 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.2
Subject: Re: [PATCH 2/2] erofs: support inode lookup with metabuf
Content-Language: en-US
To:     Gao Xiang <hsiangkao@linux.alibaba.com>,
        linux-erofs@lists.ozlabs.org
Cc:     LKML <linux-kernel@vger.kernel.org>
References: <20220316012246.95131-1-hsiangkao@linux.alibaba.com>
 <20220316012246.95131-2-hsiangkao@linux.alibaba.com>
From:   Chao Yu <chao@kernel.org>
In-Reply-To: <20220316012246.95131-2-hsiangkao@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-8.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022/3/16 9:22, Gao Xiang wrote:
> This converts the remaining inode lookup part by using metabuf in a
> straight-forward way. Except that it doesn't use kmap_atomic()
> anymore since we now have to maintain two metabuf together.
> 
> After this patch, all uncompressed paths are handled with metabuf
> instead of page structure.
> 
> Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>

Reviewed-by: Chao Yu <chao@kernel.org>

Thanks,
