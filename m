Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5203552B124
	for <lists+linux-kernel@lfdr.de>; Wed, 18 May 2022 06:13:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229708AbiEREJw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 May 2022 00:09:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229631AbiEREJK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 May 2022 00:09:10 -0400
Received: from mx1.molgen.mpg.de (mx3.molgen.mpg.de [141.14.17.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA9FD154B03;
        Tue, 17 May 2022 21:07:36 -0700 (PDT)
Received: from [172.24.65.115] (edu241124.nat.uni-leipzig.de [139.18.241.124])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        (Authenticated sender: pmenzel)
        by mx.molgen.mpg.de (Postfix) with ESMTPSA id EC97161EA192A;
        Wed, 18 May 2022 06:07:34 +0200 (CEST)
Message-ID: <dff3d94c-93be-2b31-35c6-35a7886f3680@molgen.mpg.de>
Date:   Wed, 18 May 2022 06:07:34 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Subject: Re: hid-sensor-hub 001F:8087:0AC2.0002: timeout waiting for response
 from ISHTP device
Content-Language: en-US
To:     Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Cc:     Jiri Kosina <jikos@kernel.org>, Even Xu <even.xu@intel.com>,
        Zhang Lixu <lixu.zhang@intel.com>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        linux-input@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        Dell.Client.Kernel@dell.com
References: <289be79b-8fbb-d171-a1e5-5d8218dff39d@molgen.mpg.de>
 <8833ba2600208a05940943636a3bd8b6af6a9fe4.camel@linux.intel.com>
From:   Paul Menzel <pmenzel@molgen.mpg.de>
In-Reply-To: <8833ba2600208a05940943636a3bd8b6af6a9fe4.camel@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-6.3 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dear Srinivas,


Thank you for your reply.

Am 13.05.22 um 01:07 schrieb srinivas pandruvada:

> On Thu, 2022-05-12 at 17:01 +0200, Paul Menzel wrote:

>> On the Dell XPS 13 9310, firmware 2.2.0 04/06/2021, with Debian
>> sid/unstable, Linux 5.17.3 logs a lot of the messages below:
>>
>>       timeout waiting for response from ISHTP device
>>
>> Please find the output of `dmesg` attached.
>>
> It seems that sensor FW is not responding after resume.
> 
> What is
> # cat /sys/power/mem_sleep

     $ cat /sys/power/mem_sleep
     [s2idle]


Kind regards,

Paul


PS: I think, Intel should have a Dell XPS 13 9310 available in some test 
labs. If not, Dell (Cc) should be able to provide access to one.
