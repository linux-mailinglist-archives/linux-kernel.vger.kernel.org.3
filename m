Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 12EA7573D1E
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Jul 2022 21:30:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236584AbiGMTa1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Jul 2022 15:30:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229959AbiGMTaZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jul 2022 15:30:25 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 885DC2A42C;
        Wed, 13 Jul 2022 12:30:24 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 362D1B82141;
        Wed, 13 Jul 2022 19:30:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0AA86C34114;
        Wed, 13 Jul 2022 19:30:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1657740621;
        bh=lH674i9I/fJ6z5VVQUS6ILb0EbbvI8BmEJfY9b/Tpds=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=QX2vj23qOnvDi45ISYUAqy3Baq466mPPVvU+hUPwn2BmuHoiJgEhFE+KXQfrnOmnl
         EvkMkVzMFU/mT7MgdwDaRfi4LOlVKOpSTYHSiiIH9ALgF8/w9Q1GGPKogp0A8j/zF6
         Q7Pwydlh8sgajBlCysvFpkKAXPiMUWt27u2uo0rL8EPIKbj8wWUFKle+BJSYcO6C2H
         IuG2s7yC/o/fiojnHQsJR1WVf82f1SBUS9GALofbhH49w6t6lTO3Oq9oq5xsVzJlmt
         24kxoasHDqxHaKSykMSbsngpaRTrkQD2Jx4Q6djeGEmqG5CcJhEmzF7ker1Nf3WZOi
         oT0Gr9wMJE9VQ==
Message-ID: <b63f548d-16f4-8aa1-20b0-971d21f55a3e@kernel.org>
Date:   Wed, 13 Jul 2022 21:30:14 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH V4 14/20] Documentation/rv: Add a basic documentation
Content-Language: en-US
To:     Bagas Sanjaya <bagasdotme@gmail.com>
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Jonathan Corbet <corbet@lwn.net>,
        Ingo Molnar <mingo@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Will Deacon <will@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Marco Elver <elver@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Shuah Khan <skhan@linuxfoundation.org>,
        Gabriele Paoloni <gpaoloni@redhat.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Clark Williams <williams@redhat.com>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-trace-devel@vger.kernel.org
References: <cover.1655368610.git.bristot@kernel.org>
 <575554f7bebc0278dd3dfad056d4438c2fbab7b3.1655368610.git.bristot@kernel.org>
 <YrvIfPPvV7yXrpCf@debian.me>
From:   Daniel Bristot de Oliveira <bristot@kernel.org>
In-Reply-To: <YrvIfPPvV7yXrpCf@debian.me>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/29/22 05:35, Bagas Sanjaya wrote:
>> +  DE OLIVEIRA, Daniel Bristot, et al. *Automata-based formal analysis and
>> +  verification of the real-time Linux kernel.* Ph.D. Thesis, 2020.
>> +
> Shouldn't these references be formatted citations reference syntax?

I improved them, but there is no single syntax. In practice, people find the
BibTeX "citation" from the place where the paper was published and let the
venue template do its work, formatting it properly (don't ask me what people
using word use... I just know that many people have a bad first impression of
papers made on word haha).
> 
>> +For example::
>> +
>> +   [root@f32 rv]# cat available_monitors
>> +   wip
>> +   wwnr
>> +
> I think the prompt should be just `#` (without username and host).

Fixed!

Thanks.
-- Daniel

> Thanks.

