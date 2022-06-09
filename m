Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C9DBE545238
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Jun 2022 18:44:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239239AbiFIQn4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Jun 2022 12:43:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238442AbiFIQnt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jun 2022 12:43:49 -0400
Received: from mx1.molgen.mpg.de (mx3.molgen.mpg.de [141.14.17.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C25B626C2;
        Thu,  9 Jun 2022 09:43:46 -0700 (PDT)
Received: from [192.168.0.2] (ip5f5aedbb.dynamic.kabel-deutschland.de [95.90.237.187])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        (Authenticated sender: pmenzel)
        by mx.molgen.mpg.de (Postfix) with ESMTPSA id 1CABC61EA1928;
        Thu,  9 Jun 2022 18:43:44 +0200 (CEST)
Message-ID: <c3bbbd15-fe41-672d-0e99-bd65a5369e1e@molgen.mpg.de>
Date:   Thu, 9 Jun 2022 18:43:43 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
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
 <dff3d94c-93be-2b31-35c6-35a7886f3680@molgen.mpg.de>
 <8fc40ebb2fbcecb1ab2f5ea156bf9ec10aff06bf.camel@linux.intel.com>
 <82e9a41c-552a-07e2-7caa-a14913cd34f4@molgen.mpg.de>
 <8eb29bb9a817c88e2e9a4a76a10e99bf5504a3b5.camel@linux.intel.com>
From:   Paul Menzel <pmenzel@molgen.mpg.de>
In-Reply-To: <8eb29bb9a817c88e2e9a4a76a10e99bf5504a3b5.camel@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.4 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dear Srinivas,


Am 18.05.22 um 21:55 schrieb srinivas pandruvada:

> Good news, is that I can get to one 9310 system.

Awesome.

> Manufacturer: Dell Inc.
> Product Name: XPS 13 9310
> 
> I had
> "
> bios_date:12/10/2020
> bios_release:1.2
> bios_vendor:Dell Inc.
> bios_version:1.2.5
> "
> 
> Didn't observe any issue with ISH after multiple suspend/resume
> 
> Update to the latest available from Dell website
> 
> BIOS Information
> 	Vendor: Dell Inc.
> 	Version: 3.6.0
> 	Release Date: 03/17/2022
> 	
> 
> Still no issue.
> 
> I am using
> 5.17.7-200.fc35.x86_64
> 
> So suggest to updated to the latest BIOS from Dell website and
> reproduce.

I had access to the system, and I have not seen that ISHTP message since 
May 16th, 2022 so with the old 2.2.0 and current 3.6.0 system firmware. 
But it also was not always present beforehand, so no idea, if something 
special has to be done (like attach a device) to trigger it.

Until the message shows up again, let’s consider the issue fixed though. 
Thank you for your time.


Kind regards,

Paul
