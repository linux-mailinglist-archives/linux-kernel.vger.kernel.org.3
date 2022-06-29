Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BD46856033C
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Jun 2022 16:38:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233413AbiF2OiW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Jun 2022 10:38:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233305AbiF2OiJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Jun 2022 10:38:09 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 911DE2189;
        Wed, 29 Jun 2022 07:38:08 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 982BF152B;
        Wed, 29 Jun 2022 07:38:08 -0700 (PDT)
Received: from [192.168.122.164] (U203867.austin.arm.com [10.118.30.29])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 40F0E3F792;
        Wed, 29 Jun 2022 07:38:08 -0700 (PDT)
Message-ID: <08505fe6-ae2a-0890-ab11-899eb4d74dc5@arm.com>
Date:   Wed, 29 Jun 2022 09:38:07 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Subject: Re: [PATCH 1/2] Revert "serial: 8250: dw: Move the USR register to
 pdata"
Content-Language: en-US
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     linux-serial@vger.kernel.org, andriy.shevchenko@linux.intel.com,
        jirislaby@kernel.org, miquel.raynal@bootlin.com,
        phil.edworthy@renesas.com, kernel@esmil.dk,
        linux-kernel@vger.kernel.org
References: <20220629000232.3440704-1-jeremy.linton@arm.com>
 <20220629000232.3440704-2-jeremy.linton@arm.com> <YrvsW7RmHRr5zbS3@kroah.com>
From:   Jeremy Linton <jeremy.linton@arm.com>
In-Reply-To: <YrvsW7RmHRr5zbS3@kroah.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 6/29/22 01:08, Greg KH wrote:
> On Tue, Jun 28, 2022 at 07:02:31PM -0500, Jeremy Linton wrote:
>> pdata is only setup by DT machines, leaving ACPI machines
>> with null pdata. Since I don't know the exact mapping of
>> ACPI ID's to dw 8250 variations I can't add pdata to them
>> without possibly breaking something. As such the simplest
>> fix here is probably just to revert this commit.
>>
>> This reverts commit ffd381445eac2aa624e49bab5a811451e8351008.
>> Signed-off-by: Jeremy Linton <jeremy.linton@arm.com>
> 
> Didn't checkpatch complain that you need a blank line before your
> signed-off-by line?

No, it, and I apparently thought that the revert was part of the tagging.

Lets kill this set anyway, as the patch you already have to add pdata to 
ACPI in tty-linus solves all these problems. I guess I missed that 
posting, so sorry about the noise.

Thanks,


