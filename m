Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E5B2851410A
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Apr 2022 05:48:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236455AbiD2DgW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Apr 2022 23:36:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236224AbiD2DgU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Apr 2022 23:36:20 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 704FD9680B
        for <linux-kernel@vger.kernel.org>; Thu, 28 Apr 2022 20:33:04 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 3E86311FB;
        Thu, 28 Apr 2022 20:33:04 -0700 (PDT)
Received: from [192.168.225.246] (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id A868C3F73B;
        Thu, 28 Apr 2022 20:33:02 -0700 (PDT)
Message-ID: <16a353ea-0e99-520d-4790-9442a7313142@arm.com>
Date:   Fri, 29 Apr 2022 09:03:58 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH] xtensa: enable ARCH_HAS_DEBUG_VM_PGTABLE
Content-Language: en-US
To:     Max Filippov <jcmvbkbc@gmail.com>
Cc:     "open list:TENSILICA XTENSA PORT (xtensa)" 
        <linux-xtensa@linux-xtensa.org>, Chris Zankel <chris@zankel.net>,
        LKML <linux-kernel@vger.kernel.org>
References: <20220425180540.880632-1-jcmvbkbc@gmail.com>
 <63deb092-4002-d798-410e-1db2081f0ef8@arm.com>
 <CAMo8BfKe0WLOaCiDopyr-JH6JSG2X0FTMDgON=KynKdyYt4L7A@mail.gmail.com>
From:   Anshuman Khandual <anshuman.khandual@arm.com>
In-Reply-To: <CAMo8BfKe0WLOaCiDopyr-JH6JSG2X0FTMDgON=KynKdyYt4L7A@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 4/26/22 18:12, Max Filippov wrote:
> Anshuman,
> 
> On Mon, Apr 25, 2022 at 11:07 PM Anshuman Khandual
> <anshuman.khandual@arm.com> wrote:
>> Thanks for the patch. Just wondering if you ran with different config
>> options (which might impact test case selection) on/off during testing ?
> 
> I went through the code in the mm/debug_vm_pgtable.c and saw that most
> variations are related to the huge page support which xtensa doesn't have.
> I've tested it with and without CMA.
> I haven't found anything else interesting that I could tweak -- have I missed
> anything?

I dont think so, but thanks for confirming.
