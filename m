Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 97729543F34
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Jun 2022 00:35:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236599AbiFHWfd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Jun 2022 18:35:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233140AbiFHWfb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jun 2022 18:35:31 -0400
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92E371CE79E
        for <linux-kernel@vger.kernel.org>; Wed,  8 Jun 2022 15:35:27 -0700 (PDT)
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 258MZJME095985;
        Wed, 8 Jun 2022 17:35:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1654727719;
        bh=RKrbnWn7mMyE8oty0ux1KDFfz8QMiK+3kqPuK+AigMI=;
        h=Date:Subject:To:CC:References:From:In-Reply-To;
        b=XpXeuYvGB80rAYqWTOlqEtYDoOLyoVOy/oZAGNnx7Rs2wMeoyfoZqcEg04coLfKnI
         1kw5iQiJAoSgUaYvoWqXZP1ND6Fx/lIKRv94gujvcSCIHXtmLiWMVtO3tt/NrToIHR
         7HRV6/xcDeFeTA6q5XAdUgs96mEIfH7T5Jw4n4nw=
Received: from DFLE108.ent.ti.com (dfle108.ent.ti.com [10.64.6.29])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 258MZJHv046214
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 8 Jun 2022 17:35:19 -0500
Received: from DFLE108.ent.ti.com (10.64.6.29) by DFLE108.ent.ti.com
 (10.64.6.29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14; Wed, 8
 Jun 2022 17:35:19 -0500
Received: from lelv0327.itg.ti.com (10.180.67.183) by DFLE108.ent.ti.com
 (10.64.6.29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14 via
 Frontend Transport; Wed, 8 Jun 2022 17:35:19 -0500
Received: from [10.250.32.110] (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 258MZIb8109531;
        Wed, 8 Jun 2022 17:35:19 -0500
Message-ID: <32a53ead-c5ec-bb7e-abd1-8bfc1bf67959@ti.com>
Date:   Wed, 8 Jun 2022 17:35:18 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH v2 2/2] tee: remove flags TEE_IOCTL_SHM_MAPPED and
 TEE_IOCTL_SHM_DMA_BUF
Content-Language: en-US
To:     Eugene Syromiatnikov <esyr@redhat.com>
CC:     Jens Wiklander <jens.wiklander@linaro.org>,
        Sumit Garg <sumit.garg@linaro.org>,
        <op-tee@lists.trustedfirmware.org>, <linux-kernel@vger.kernel.org>,
        <ldv@strace.io>
References: <20220425141617.23925-1-afd@ti.com>
 <20220425141617.23925-2-afd@ti.com>
 <20220608135116.GA27854@asgard.redhat.com>
From:   Andrew Davis <afd@ti.com>
In-Reply-To: <20220608135116.GA27854@asgard.redhat.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-6.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/8/22 8:52 AM, Eugene Syromiatnikov wrote:
> On Mon, Apr 25, 2022 at 09:16:17AM -0500, Andrew Davis wrote:
>> These look to be leftover from an early edition of this driver. Userspace
>> does not need this information. Checking all users of this that I have
>> access to I have verified no one is using them.
> 
> This change has broken build of strace's test suite against the latest kernel
> headers[1];  the usage prety much shows up in the Debian's code search[2].
> 
> [1] https://github.com/strace/strace/runs/6794205205?check_suite_focus=true#step:4:3862
> [2] https://codesearch.debian.net/search?q=TEE_IOCTL_SHM_MAPPED+package%3A%5CQstrace%5CE&literal=1
> 

Thanks for the headsup, I've sent a patch to fix strace tests.

Andrew

>> They leak internal use flags out to userspace. Even more they are not
>> correct anymore after a45ea4efa358. Lets drop these flags before
>> someone does try to use them for something and they become ABI.
> 
