Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 16D644F00C2
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Apr 2022 12:45:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354451AbiDBKqw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 2 Apr 2022 06:46:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235134AbiDBKqv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Apr 2022 06:46:51 -0400
Received: from gnuweeb.org (gnuweeb.org [51.81.211.47])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB16F10A976
        for <linux-kernel@vger.kernel.org>; Sat,  2 Apr 2022 03:44:58 -0700 (PDT)
Received: from [192.168.165.80] (unknown [182.2.36.61])
        by gnuweeb.org (Postfix) with ESMTPSA id 91E3B7E356;
        Sat,  2 Apr 2022 10:44:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gnuweeb.org;
        s=default; t=1648896298;
        bh=Fj/zOc2m5wPgUFQ7ymabonXvdGcHFYpQV8ZRUFwpB2o=;
        h=Date:To:Cc:References:From:Subject:In-Reply-To:From;
        b=FfPuMaGV3YewdDb3emorhUmC8cEIVXmjoEcs0MqlYBbSpSDT0m60J9nG18WQrc8xY
         oMzAFNjMAxJMmlga4EthkNgprcquvCQP6MSSuKewv+YpxvH2fJ4WS6a+uMvAYTmxq/
         CCdbb7P3fDA1JbLQ9LbeJKIFkIseVClMPb52EYQeIS5/k88B9h6kCMtoM7g7OtK1oL
         IcJZ1c3xHjbcMjfD3n2+jDnkEE/SEyFXNqEBrZZW/lk+5YMxFsUfUBIWZEUALG4brs
         0slMALKJ3IHHmJcqBEdpbSgPNQQ7xXeZWTI3avj2E0rHKmVun1QZU2ol3dFaFrKK/6
         fw/CpD4PAb2zQ==
Message-ID: <60274552-dc33-e9ff-3fd8-d4d743a6f577@gnuweeb.org>
Date:   Sat, 2 Apr 2022 17:44:49 +0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Content-Language: en-US
To:     Marc Zyngier <maz@kernel.org>
Cc:     kernel test robot <lkp@intel.com>, llvm@lists.linux.dev,
        kbuild-all@lists.01.org,
        GNU/Weeb Mailing List <gwml@vger.gnuweeb.org>,
        linux-kernel@vger.kernel.org, Quentin Perret <qperret@google.com>,
        Alexandru Elisei <alexandru.elisei@arm.com>,
        Will Deacon <willdeacon@google.com>
References: <202204021112.ErKMELRr-lkp@intel.com>
 <87r16fbzaq.wl-maz@kernel.org>
 <9fa2454e-aef5-c879-eb0d-2eb23e603b55@gnuweeb.org>
 <87pmlzbyff.wl-maz@kernel.org>
From:   Ammar Faizi <ammarfaizi2@gnuweeb.org>
Subject: Re:
 [ammarfaizi2-block:google/android/kernel/common/android12-5.10-2022-03
 199/9999] arch/arm64/kvm/perf.c:58:36: error: implicit declaration of
 function 'perf_num_counters'
In-Reply-To: <87pmlzbyff.wl-maz@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Marc,

On 4/2/22 4:57 PM, Marc Zyngier wrote:
> It doesn't bother me at all, and you shouldn't stop pushing stuff that
> is useful to you. My objection is to the testing of random trees and
> spamming of random people, specially when it is pretty obvious that
> the tree isn't targeting upstream Linux.
> 
> You really shouldn't change anything in your workflow on my account.

I sent a PR to lkp-tests to make the build error report private for my
google/android/.* branches. Should be good now.

https://github.com/intel/lkp-tests/pull/130

Thanks!

-- 
Ammar Faizi
