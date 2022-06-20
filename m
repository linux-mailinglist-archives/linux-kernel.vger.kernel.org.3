Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ED95D55263B
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Jun 2022 23:06:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238539AbiFTVGB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Jun 2022 17:06:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229608AbiFTVF4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jun 2022 17:05:56 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7BFEF18B28;
        Mon, 20 Jun 2022 14:05:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=Content-Transfer-Encoding:Content-Type
        :In-Reply-To:References:Cc:To:From:Subject:MIME-Version:Date:Message-ID:
        Sender:Reply-To:Content-ID:Content-Description;
        bh=X83mWqW5bf8hFIHGGA3ZSZcUTi1ne9r912suniNWOJA=; b=OzS237e63TWn5zMXqEULtD15bv
        i8ToUFT2ZFKPVbynvRJgv00g8nM/xQ+7EGHiphyttTkbcqzGCeAXzVbxUwSvwb6eOlJ6Y0fJPem+X
        oSUgsBE3F9G41j7aQkJryd5ujG6Xn0FW+33ASSkE9UmtjvqhZnfLyq2eSUtG7a8yoNIFmaJa/Beiv
        PR2jRpu5f7qLEMaCVIfn7sv+6FNRHWyCL/jmpuVNuWNtZvlmOhLPXOnbc33eh7v5jUwtiSmZ8XTn3
        0ztjYDw630NhOqJ4UpPVUYXQbLHIJUiS1dTa3vVhfAqhkLSHbbF1+LJXkCt2J2c0b+J/ojwTWja90
        tsZQ1yOA==;
Received: from [2601:1c0:6280:3f0::aa0b]
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1o3OYC-009uzU-7R; Mon, 20 Jun 2022 21:04:21 +0000
Message-ID: <99f33d38-3e93-f6f6-a583-0fee649935de@infradead.org>
Date:   Mon, 20 Jun 2022 14:02:07 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: linux-next: Tree for Jun 20 (kernel/trace/trace_uprobe.o)
Content-Language: en-US
From:   Randy Dunlap <rdunlap@infradead.org>
To:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Delyan Kratunov <delyank@fb.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@redhat.com>,
        Steven Rostedt <rostedt@goodmis.org>
References: <20220620184224.48898daa@canb.auug.org.au>
 <2de99180-7d55-2fdf-134d-33198c27cc58@infradead.org>
In-Reply-To: <2de99180-7d55-2fdf-134d-33198c27cc58@infradead.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[adding Delyan]

On 6/20/22 13:47, Randy Dunlap wrote:
> 
> 
> On 6/20/22 01:42, Stephen Rothwell wrote:
>> Hi all,
>>
>> Changes since 20220617:
>>
> 
> on i386:

When BPF is not set/enabled:

> 
> ld: kernel/trace/trace_uprobe.o:(__jump_table+0x8): undefined reference to `bpf_stats_enabled_key'
> 
> 
> Full randconfig file is attached.
> 

-- 
~Randy
