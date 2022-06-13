Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EECA3549B5A
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Jun 2022 20:21:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244865AbiFMSVM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Jun 2022 14:21:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240480AbiFMSUu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jun 2022 14:20:50 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 598C82625;
        Mon, 13 Jun 2022 07:24:57 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id B3FAEB81057;
        Mon, 13 Jun 2022 14:24:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 62760C34114;
        Mon, 13 Jun 2022 14:24:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1655130294;
        bh=dPms+2tRdPeMRCtz5LXIpvIE+GN1BU34aLWsVdJu1Vk=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=JBTCOzqCdMJBT8yKGC8YXsLHu1BdhDo6koMJFVf/GILP1HthKupIsCQfoXloEIOq0
         F6GdbxuDQNRYechTnfhIp2MM0jx5V6TMKzgg3fb8KwTSWejdVE37h6TkVq7WpN18+H
         95+3/bl/hWhZpgFGGyAAW2yTcqohBauj82LkNOWCGDw3vcD9rl1chwSZVH0oXYgcxD
         Deg6iXRDclnXIRKwFI5Ch9/KdgT2nO9DDax0hjPbo1AooM4w6UINUUOL7D9dNq3s/T
         4T7c698TqI1jgFynuLEc0c73ZdufT5PxMds8+ccCUfugLdi5EyadZUAg+JW6zHz35T
         QKSOQ5/GIrF6A==
Message-ID: <b72c10cd-c9da-d66f-f3db-f5206ba13f3d@kernel.org>
Date:   Mon, 13 Jun 2022 09:24:52 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [PATCH] firmware: stratix10-svc: remove extraneous asterisk from
 #define comments
Content-Language: en-US
To:     Randy Dunlap <rdunlap@infradead.org>,
        Bagas Sanjaya <bagasdotme@gmail.com>, linux-doc@vger.kernel.org
Cc:     kernel test robot <lkp@intel.com>,
        Ang Tien Sung <tien.sung.ang@intel.com>,
        Richard Gong <richard.gong@intel.com>,
        linux-kernel@vger.kernel.org
References: <202206120445.FeU5wA93-lkp@intel.com>
 <20220612012253.16583-1-bagasdotme@gmail.com>
 <967fa124-5ebc-6b0d-fa1a-27619eb01b8c@infradead.org>
From:   Dinh Nguyen <dinguyen@kernel.org>
In-Reply-To: <967fa124-5ebc-6b0d-fa1a-27619eb01b8c@infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-9.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 6/11/22 20:31, Randy Dunlap wrote:
> Hi,
> 
> On 6/11/22 18:22, Bagas Sanjaya wrote:
>> kernel test robot reported kernel-doc warning:
>>
>>>> include/linux/firmware/intel/stratix10-svc-client.h:19: warning: This comment starts with '/**', but isn't a kernel-doc comment. Refer Documentation/doc-guide/kernel-doc.rst
>>
>> The warning above is because comments above #define statements are prefixed
>> with double asterisk, which kernel-doc script mistook these as actual
>> kernel-doc comment.
>>
>> Remove extraneouse asterisk from these comments.
> 
>           extraneous
> 
>>
>> Link: https://lore.kernel.org/lkml/202206120445.FeU5wA93-lkp@intel.com/
>> Fixes: 88f42ac48b8968 ("firmware: stratix10-svc: Add support for FCS")
>> Reported-by: kernel test robot <lkp@intel.com>
>> Cc: Ang Tien Sung <tien.sung.ang@intel.com>
>> Cc: Richard Gong <richard.gong@intel.com>
>> Cc: Dinh Nguyen <dinguyen@kernel.org>
>> Cc: linux-kernel@vger.kernel.org
>> Signed-off-by: Bagas Sanjaya <bagasdotme@gmail.com>
> 
> Acked-by: Randy Dunlap <rdunlap@infraded.org>
> 
> Thanks.
> 
>> ---
>>   include/linux/firmware/intel/stratix10-svc-client.h | 4 ++--
>>   1 file changed, 2 insertions(+), 2 deletions(-)
>>
>> diff --git a/include/linux/firmware/intel/stratix10-svc-client.h b/include/linux/firmware/intel/stratix10-svc-client.h
>> index 5098dbba138d0f..63927aba0b5699 100644
>> --- a/include/linux/firmware/intel/stratix10-svc-client.h
>> +++ b/include/linux/firmware/intel/stratix10-svc-client.h
>> @@ -15,7 +15,7 @@
>>   #define SVC_CLIENT_FPGA			"fpga"
>>   #define SVC_CLIENT_RSU			"rsu"
>>   #define SVC_CLIENT_FCS			"fcs"
>> -/**
>> +/*
>>    * Status of the sent command, in bit number
>>    *
>>    * SVC_STATUS_OK:
>> @@ -50,7 +50,7 @@
>>   #define SVC_STATUS_ERROR		5
>>   #define SVC_STATUS_NO_SUPPORT		6
>>   #define SVC_STATUS_INVALID_PARAM	7
>> -/**
>> +/*
>>    * Flag bit for COMMAND_RECONFIG
>>    *
>>    * COMMAND_RECONFIG_FLAG_PARTIAL:
>>
>> base-commit: 107da326a0a3e7b6e81557c4225548db670a2647
> 

Applied!

Thanks,
Dinh
