Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 483A0554ABC
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Jun 2022 15:15:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352161AbiFVNPU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Jun 2022 09:15:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354555AbiFVNNP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jun 2022 09:13:15 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id CDA7C22B12
        for <linux-kernel@vger.kernel.org>; Wed, 22 Jun 2022 06:12:44 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 88C9913D5;
        Wed, 22 Jun 2022 06:12:44 -0700 (PDT)
Received: from [10.57.85.1] (unknown [10.57.85.1])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 6B49C3F534;
        Wed, 22 Jun 2022 06:12:43 -0700 (PDT)
Message-ID: <b9439692-c72b-b856-c7c0-e60a863f3e74@arm.com>
Date:   Wed, 22 Jun 2022 14:12:39 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH v2] iommu/dma: Add config for PCI SAC address trick
Content-Language: en-GB
To:     Joerg Roedel <joro@8bytes.org>
Cc:     will@kernel.org, iommu@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, hch@lst.de, john.garry@huawei.com
References: <3f06994f9f370f9d35b2630ab75171ecd2065621.1654782107.git.robin.murphy@arm.com>
 <YrMSJ6AGwn3PxSIH@8bytes.org>
From:   Robin Murphy <robin.murphy@arm.com>
In-Reply-To: <YrMSJ6AGwn3PxSIH@8bytes.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022-06-22 13:59, Joerg Roedel wrote:
> On Thu, Jun 09, 2022 at 04:12:10PM +0100, Robin Murphy wrote:
>> firmware bindings by now. Let's be brave and default it to off in the
> 
> I don't have an overall good feeling about this, but as you said, let's
> be brave. This is applied now to the core branch.
> 
> If it causes too much trouble we can still revert it (and re-revert it
> later, ...)

Even easier, we can just bring back "default X86", or "default y", if 
too many folks object to configuring it manually  :)

Thanks for your bravery!
Robin.
