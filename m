Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E467A554D39
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Jun 2022 16:33:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358104AbiFVOdQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Jun 2022 10:33:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1358158AbiFVOdN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jun 2022 10:33:13 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id D810622537
        for <linux-kernel@vger.kernel.org>; Wed, 22 Jun 2022 07:33:12 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C7540D6E;
        Wed, 22 Jun 2022 07:33:12 -0700 (PDT)
Received: from [10.57.41.243] (unknown [10.57.41.243])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id F0FF23F792;
        Wed, 22 Jun 2022 07:33:11 -0700 (PDT)
Message-ID: <1e206563-4fb6-923c-9a3c-0d068d400ddf@arm.com>
Date:   Wed, 22 Jun 2022 15:33:10 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH] swiotlb: Remove redundant swiotlb_force
Content-Language: en-GB
To:     Christoph Hellwig <hch@lst.de>
Cc:     iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
        Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
References: <20220622142952.320057-1-steven.price@arm.com>
 <20220622143219.GA31314@lst.de>
From:   Steven Price <steven.price@arm.com>
In-Reply-To: <20220622143219.GA31314@lst.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 22/06/2022 15:32, Christoph Hellwig wrote:
> On Wed, Jun 22, 2022 at 03:29:52PM +0100, Steven Price wrote:
>> The variable (and enum) was removed in commit c6af2aa9ffc9 ("swiotlb:
>> make the swiotlb_init interface more useful") but the declaration was
>> left in swiotlb.h. Tidy up by removing the declaration as well.
>>
>> Signed-off-by: Steven Price <steven.price@arm.com>
> 
> I just applied an identical patch from Dongli Zhang a few hours ago.

Ah, I missed that. Sorry for the noise!

Steve
