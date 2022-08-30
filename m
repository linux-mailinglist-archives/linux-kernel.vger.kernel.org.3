Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 369F65A6105
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Aug 2022 12:45:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229732AbiH3Kpb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Aug 2022 06:45:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229944AbiH3Kp0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Aug 2022 06:45:26 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id EF80757577;
        Tue, 30 Aug 2022 03:45:23 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 28AF623A;
        Tue, 30 Aug 2022 03:45:29 -0700 (PDT)
Received: from [10.57.16.5] (unknown [10.57.16.5])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id CB2E53F71A;
        Tue, 30 Aug 2022 03:45:21 -0700 (PDT)
Message-ID: <b545f8fe-f93e-937d-436f-44d2640f4095@arm.com>
Date:   Tue, 30 Aug 2022 11:45:19 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH] docs: scheduler: Update new path for the sysctl knobs
Content-Language: en-US
To:     Jonathan Corbet <corbet@lwn.net>
Cc:     siyanteng@loongson.cn, alexs@kernel.org, peterz@infradead.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20220816121907.841-1-lukasz.luba@arm.com>
 <9fc3d98c-9262-e737-3bfa-ffd2c913428f@arm.com> <87sflfovoq.fsf@meer.lwn.net>
From:   Lukasz Luba <lukasz.luba@arm.com>
In-Reply-To: <87sflfovoq.fsf@meer.lwn.net>
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



On 8/29/22 17:34, Jonathan Corbet wrote:
> Lukasz Luba <lukasz.luba@arm.com> writes:
> 
>> Gentle ping. Could you take this patch, please?
> 
> I was hoping for an ack from the scheduler folks.  It seems correct,
> though, so I've applied it.

Thanks! Yes, it looks like this was just missed during the files
movement in this commit:

8a99b6833c884fa0e79190

Regards,
Lukasz
