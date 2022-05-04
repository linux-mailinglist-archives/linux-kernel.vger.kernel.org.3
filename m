Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 57CD1519830
	for <lists+linux-kernel@lfdr.de>; Wed,  4 May 2022 09:29:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345455AbiEDHdC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 May 2022 03:33:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345428AbiEDHcy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 May 2022 03:32:54 -0400
Received: from gnuweeb.org (gnuweeb.org [51.81.211.47])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12C3123168
        for <linux-kernel@vger.kernel.org>; Wed,  4 May 2022 00:29:18 -0700 (PDT)
Received: from [192.168.83.80] (unknown [182.2.74.109])
        by gnuweeb.org (Postfix) with ESMTPSA id 067C57E7DF;
        Wed,  4 May 2022 07:29:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gnuweeb.org;
        s=default; t=1651649357;
        bh=0jCTxyJFrW91G2WoOFPhse6MeV195g1T/fnwYvdmDWI=;
        h=Date:To:Cc:References:From:Subject:In-Reply-To:From;
        b=TTUYmlWo7inPfQAC3SmM8ijAmdgEUu0mJXKlOZK3Dq/riHvkmEcDCfjVP7m7hc36o
         HHxYmbTq3EkSlK4oJ00IhKUPSbZTN/8JHDC+0g8rR7/WgCEbfLvc1ciGhwS19Hzzrx
         GWT2kvCSgeVF3bfZ+Wb7FL93sPl47FRNImLoOTIwigRiT72WtA5KlqFz3uhUr2Gytc
         ojP6X0LuiUZxBvxCN/i5k+d3RFG67b+zcgTula8JcYXOOPmZW3Enn+nsD0aCmdnt11
         pIUbNGBvia4M+QVXB3PkLvWNuKh23teGuaLEoFa2QmkRnoKkfoCH/A84470m/+KWG8
         yKgMVWHgwkXzg==
Message-ID: <64cbe8c1-a93f-1aad-2629-9feb6ee7a20e@gnuweeb.org>
Date:   Wed, 4 May 2022 14:29:10 +0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Content-Language: en-US
To:     kernel test robot <oliver.sang@intel.com>,
        Jens Axboe <axboe@kernel.dk>
Cc:     lkp@lists.01.org, lkp@intel.com, ltp@lists.linux.it,
        LKML <linux-kernel@vger.kernel.org>
References: <20220504060305.GF30775@xsang-OptiPlex-9020>
From:   Ammar Faizi <ammarfaizi2@gnuweeb.org>
Subject: Re: [net] 5aa32dd9bd: INFO:task_blocked_for_more_than#seconds
In-Reply-To: <20220504060305.GF30775@xsang-OptiPlex-9020>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/4/22 1:03 PM, kernel test robot wrote:
> 
> 
> Greeting,
> 
> FYI, we noticed the following commit (built with gcc-11):
> 
> commit: 5aa32dd9bdb57e4a26143216df5e90f5e5c3dd2c ("net: add support for fast socket release")
> https://github.com/ammarfaizi2/linux-block axboe/linux-block/sock-nolock.2
> 
> in testcase: ltp
> version: ltp-x86_64-14c1f76-1_20220430
> with following parameters:
> 
> 	test: cve
> 	ucode: 0x28
> 
> test-description: The LTP testsuite contains a collection of tools for testing the Linux kernel and related features.
> test-url: http://linux-test-project.github.io/
> 
> 
> on test machine: 8 threads 1 sockets Intel(R) Core(TM) i7-4770 CPU @ 3.40GHz with 16G memory
> 
> caused below changes (please refer to attached dmesg/kmsg for entire log/backtrace):

Hello,

Thank you for the testing effort. But it's an abandoned branch, please stop
testing branch: axboe/linux-block/sock-nolock.2.

As Jens has said previously here:
https://lore.kernel.org/lkml/f8de18da-e6ae-e82c-c6eb-6f4de6ce8e98@kernel.dk

=========================================
On Sat, 30 Apr 2022 at 08:58:21 -0600, Jens Axboe wrote:
> 
> Please just stop testing that branch, it's been abandoned.
> 
> -- 
> Jens Axboe
=========================================

-- 
Ammar Faizi
