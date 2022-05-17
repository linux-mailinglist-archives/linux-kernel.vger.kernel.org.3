Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E2FFE5298ED
	for <lists+linux-kernel@lfdr.de>; Tue, 17 May 2022 06:56:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236571AbiEQE4u (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 May 2022 00:56:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233459AbiEQE4q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 May 2022 00:56:46 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 00EC4344ED
        for <linux-kernel@vger.kernel.org>; Mon, 16 May 2022 21:56:44 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 4FC0BED1;
        Mon, 16 May 2022 21:56:44 -0700 (PDT)
Received: from [10.162.43.9] (unknown [10.162.43.9])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 45C033F718;
        Mon, 16 May 2022 21:56:40 -0700 (PDT)
Message-ID: <d6bfc5b4-50f5-12ea-52a2-293baca513d6@arm.com>
Date:   Tue, 17 May 2022 10:26:37 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH] x86: removed P*D_PAGE_MASK and P*D_PAGE_SIZE
Content-Language: en-US
To:     Pasha Tatashin <pasha.tatashin@soleen.com>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com,
        luto@kernel.org, peterz@infradead.org, logang@deltatee.com
References: <20220516185202.604654-1-tatashin@google.com>
From:   Anshuman Khandual <anshuman.khandual@arm.com>
In-Reply-To: <20220516185202.604654-1-tatashin@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.3 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 5/17/22 00:22, Pasha Tatashin wrote:
> From: Pasha Tatashin <pasha.tatashin@soleen.com>
> 
> Other architectures and the common mm/ use P*D_MASK, and P*D_SIZE.
> Remove the duplicated P*D_PAGE_MASK and P*D_PAGE_SIZE which are only
> used in x86/*.
> 
> Signed-off-by: Pasha Tatashin <pasha.tatashin@soleen.com>
> ---
> 
> Applies against next-20220516 that contains:
> mm: page_table_check: using PxD_SIZE instead of PxD_PAGE_SIZ

Right, had discussed about this earlier during the page table check series.
Does make sense to use standard PMD_SIZE/PUD_SIZE like other platforms and
also the generic MM.

FWIW

Reviewed-by: Anshuman Khandual <anshuman.khandual@arm.com>
