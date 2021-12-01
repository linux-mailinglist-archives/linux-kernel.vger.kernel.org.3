Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C0EA846523F
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Dec 2021 16:59:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351267AbhLAQCX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Dec 2021 11:02:23 -0500
Received: from mx3.molgen.mpg.de ([141.14.17.11]:58743 "EHLO mx1.molgen.mpg.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1351236AbhLAQCW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Dec 2021 11:02:22 -0500
Received: from [192.168.0.2] (ip5f5aea80.dynamic.kabel-deutschland.de [95.90.234.128])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        (Authenticated sender: pmenzel)
        by mx.molgen.mpg.de (Postfix) with ESMTPSA id D7F7061E5FE02;
        Wed,  1 Dec 2021 16:58:58 +0100 (CET)
Message-ID: <4ea0c5b7-3ccd-d6a1-c7a5-edd7034e6522@molgen.mpg.de>
Date:   Wed, 1 Dec 2021 16:58:58 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.2
Subject: Re: [PATCH v2] hwmon: (pmbus_core) Check adapter PEC support
Content-Language: en-US
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     Jean Delvare <jdelvare@suse.com>,
        Madhava Reddy Siddareddygari <msiddare@cisco.com>,
        linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20210605052700.541455-1-pmenzel@molgen.mpg.de>
 <20210606125012.GA2887349@roeck-us.net>
From:   Paul Menzel <pmenzel@molgen.mpg.de>
In-Reply-To: <20210606125012.GA2887349@roeck-us.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dear Guenter,


Am 06.06.21 um 14:50 schrieb Guenter Roeck:
> On Sat, Jun 05, 2021 at 07:27:02AM +0200, Paul Menzel wrote:
>> From: Madhava Reddy Siddareddygari <msiddare@cisco.com>
>>
>> Currently, for Packet Error Checking (PEC) only the controller
>> is checked for support. This causes problems on the cisco-8000
>> platform where a SMBUS transaction errors are observed. This is
>> because PEC has to be enabled only if both controller and
>> adapter support it.
>>
>> Added code to check PEC capability for adapter and enable it
>> only if both controller and adapter supports PEC.
>>
>> Signed-off-by: Madhava Reddy Siddareddygari <msiddare@cisco.com>
>> [Upstream from SONiC https://github.com/Azure/sonic-linux-kernel/pull/215]
>> Signed-off-by: Paul Menzel <pmenzel@molgen.mpg.de>
> 
> Applied.

Thank you very much. Would it be alright, if I asked the stable series 
maintainers to backport this patch to the Linux 5.10 LTS series?


Kind regards,

Paul
