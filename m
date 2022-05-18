Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C550B52C1E8
	for <lists+linux-kernel@lfdr.de>; Wed, 18 May 2022 20:09:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241308AbiERSHG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 May 2022 14:07:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232312AbiERSG4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 May 2022 14:06:56 -0400
Received: from mx1.molgen.mpg.de (mx3.molgen.mpg.de [141.14.17.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 777D1ABF7B;
        Wed, 18 May 2022 11:06:53 -0700 (PDT)
Received: from [172.24.65.115] (edu241124.nat.uni-leipzig.de [139.18.241.124])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: pmenzel)
        by mx.molgen.mpg.de (Postfix) with ESMTPSA id 8622061EA192A;
        Wed, 18 May 2022 20:06:49 +0200 (CEST)
Message-ID: <82e9a41c-552a-07e2-7caa-a14913cd34f4@molgen.mpg.de>
Date:   Wed, 18 May 2022 20:06:48 +0200
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
 <dff3d94c-93be-2b31-35c6-35a7886f3680@molgen.mpg.de>
 <8fc40ebb2fbcecb1ab2f5ea156bf9ec10aff06bf.camel@linux.intel.com>
From:   Paul Menzel <pmenzel@molgen.mpg.de>
In-Reply-To: <8fc40ebb2fbcecb1ab2f5ea156bf9ec10aff06bf.camel@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.3 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dear Srinivas,


Am 18.05.22 um 17:39 schrieb srinivas pandruvada:

> Attached a diff. Please use git apply and build kernel. And attach
> dmesg. I want to see where did it fail.

As written, the device is used in production by a user, so I am not 
sure, if I can get the device to test self-built Linux kernel images to 
debug this issue. It would really be better to get access to such a 
device from Dell or in some Intel lab.


Kind regards,

Paul
