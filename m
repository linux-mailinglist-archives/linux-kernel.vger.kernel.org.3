Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BA8D54C9EE1
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Mar 2022 09:06:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239959AbiCBIHQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Mar 2022 03:07:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229518AbiCBIHP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Mar 2022 03:07:15 -0500
Received: from mx1.molgen.mpg.de (mx3.molgen.mpg.de [141.14.17.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71754B7169;
        Wed,  2 Mar 2022 00:06:32 -0800 (PST)
Received: from [192.168.0.2] (ip5f5aee50.dynamic.kabel-deutschland.de [95.90.238.80])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        (Authenticated sender: pmenzel)
        by mx.molgen.mpg.de (Postfix) with ESMTPSA id 0730661EA1928;
        Wed,  2 Mar 2022 09:06:30 +0100 (CET)
Message-ID: <1265b92e-3074-0a58-eb0b-1b7d371c7222@molgen.mpg.de>
Date:   Wed, 2 Mar 2022 09:06:29 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
Subject: Re: [PATCH 1/4] acpi: exsystem: Add units to time variable names
Content-Language: en-US
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Robert Moore <robert.moore@intel.com>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org,
        devel@acpica.org, LKML <linux-kernel@vger.kernel.org>
References: <20220224113807.91771-1-pmenzel@molgen.mpg.de>
 <CAJZ5v0iCwJ10gM0+LsOMU9X3X4ToN_OHBW=9vVsfEP3+cRpudQ@mail.gmail.com>
From:   Paul Menzel <pmenzel@molgen.mpg.de>
In-Reply-To: <CAJZ5v0iCwJ10gM0+LsOMU9X3X4ToN_OHBW=9vVsfEP3+cRpudQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dear Rafael,


Am 01.03.22 um 20:40 schrieb Rafael J. Wysocki:
> On Thu, Feb 24, 2022 at 12:38 PM Paul Menzel <pmenzel@molgen.mpg.de> wrote:
>>
>> `how_long` uses different units in both functions, so make it more
>> clear, what unit they expect.
>>
>> Signed-off-by: Paul Menzel <pmenzel@molgen.mpg.de>
>> ---
>>   drivers/acpi/acpica/exsystem.c | 20 ++++++++++----------
> 
> As ACPICA material, this should be submitted to the upstream project
> via https://github.com/acpica/acpica/.
> 
> This applies to the other patches in the series too.

Thank you for the hint. Done [1].

[…]


Kind regards,

Paul


PS: I should have read [2] before manually porting my patches from Linux 
to ACPICA.


[1]: https://github.com/acpica/acpica/pull/754
[2]: Documentation/driver-api/acpi/linuxized-acpica.rst
