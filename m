Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9C04353DB1A
	for <lists+linux-kernel@lfdr.de>; Sun,  5 Jun 2022 11:48:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245248AbiFEJst (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 5 Jun 2022 05:48:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245150AbiFEJsq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Jun 2022 05:48:46 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 90A67183A5;
        Sun,  5 Jun 2022 02:48:45 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 1AB5DD6E;
        Sun,  5 Jun 2022 02:48:44 -0700 (PDT)
Received: from [10.163.37.253] (unknown [10.163.37.253])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 241D53F73D;
        Sun,  5 Jun 2022 02:48:35 -0700 (PDT)
Message-ID: <fe3d0b2b-ebfb-0d95-d79b-632d7ed88959@arm.com>
Date:   Sun, 5 Jun 2022 15:18:35 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH 6/6] openrisc/mm: Enable ARCH_HAS_VM_GET_PAGE_PROT
Content-Language: en-US
To:     Stafford Horne <shorne@gmail.com>
Cc:     linux-mm@kvack.org, Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Paul Mackerras <paulus@samba.org>,
        "David S. Miller" <davem@davemloft.net>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Dinh Nguyen <dinguyen@kernel.org>,
        Jonas Bonn <jonas@southpole.se>,
        Andrew Morton <akpm@linux-foundation.org>, x86@kernel.org,
        openrisc@lists.librecores.org, linux-csky@vger.kernel.org,
        linux-mips@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linuxppc-dev@lists.ozlabs.org, sparclinux@vger.kernel.org,
        linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20220603101411.488970-1-anshuman.khandual@arm.com>
 <20220603101411.488970-7-anshuman.khandual@arm.com> <YpxIENWD3gOkFiG2@antec>
From:   Anshuman Khandual <anshuman.khandual@arm.com>
In-Reply-To: <YpxIENWD3gOkFiG2@antec>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-8.1 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 6/5/22 11:37, Stafford Horne wrote:
> On Fri, Jun 03, 2022 at 03:44:11PM +0530, Anshuman Khandual wrote:
>> This defines and exports a platform specific custom vm_get_page_prot() via
>> subscribing ARCH_HAS_VM_GET_PAGE_PROT. Subsequently all __SXXX and __PXXX
>> macros can be dropped which are no longer needed.
>>
>> Cc: Jonas Bonn <jonas@southpole.se>
>> Cc: openrisc@lists.librecores.org
>> Cc: linux-kernel@vger.kernel.org
>> Acked-by: Stafford Horne <shorne@gmail.com>
>> Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
> 
> Is it possible to retract my Acked-by?  I was following the discussion of this
> new function actually being sub optimal.  So as far as I am concerned all these
> architecture patches should be nak'ed.

Sure, alright. I am planning to redo these arch patches via making
the protection_map[] array private to the platforms but possibly
with a common look up function as Christophe had suggested earlier.
