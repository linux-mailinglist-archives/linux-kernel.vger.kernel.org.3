Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ECE82486E32
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jan 2022 00:59:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343654AbiAFX7l (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Jan 2022 18:59:41 -0500
Received: from esa6.hgst.iphmx.com ([216.71.154.45]:18924 "EHLO
        esa6.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343641AbiAFX7k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jan 2022 18:59:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1641513580; x=1673049580;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=CGRxrRXJyLQDHZtwUobuOfhQN8/+ZhzK98hmu5M2wss=;
  b=FdLv0DT7iGubxar/aOuWbjUSDjQRFIVkzJbV8HaA+nqmGrP4JQqSUJVS
   gSNWM9/50Rlb/0e60ZsF63UR0b7Axsn45lBzHjUjLaFw3euxQZyssQkHX
   UEe4kvEKnQ7Rpg70a2FpYigfb/203yysO7VbJWp4bUReuHaRnf0jIiUCk
   RCn5pfoom9FMDjhyJ7OFNg0a9wUI0O+W19I1cF69EfMtWbXY69FaDnA2w
   YvMYgM4sUCkisxChLCarFe38f/eqKVGttRDruzHhrSOhBK2h1o7j8/8kh
   Pyf4E7GESLrBsGbgJ8/b3NnNnk6+rTDc1FVF/2GrismdURYxArAniJykK
   A==;
X-IronPort-AV: E=Sophos;i="5.88,268,1635177600"; 
   d="scan'208";a="190901260"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 07 Jan 2022 07:59:40 +0800
IronPort-SDR: iUrroAufPJTm6jgyKVRAp+IP9Bv4kULWaMFyKB8u5CRxca9peeTwlUBiPPzm4lFWcltF6iuqU0
 lLbhlSo9iUqK6vOBwtix8oXPKjyJj2R3x+IdMbQ7EFjZ6oNB62xw1MvMuhCK5ejmbdXUE9Qv71
 Rt41zKz9MEfpF4N5BqmRu1HsLlPEVEdIFqolxniCe7K8+ZHPShi7GcI6WjGqrNtkMmfssu13i9
 hf4ieD9a8nHEpY8B31kBG6Y3xi1G/yMq3pzD/xmkgWs9CVY73HSqqmSJxVa1CWGesFuuaAVOBQ
 PZlewFTSCuNNJ2UkCeKNW85s
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jan 2022 15:33:28 -0800
IronPort-SDR: V2EHXLDg8xvDZsOr3/A6NTHDzsVIw4k4B5zLJIHfj9aPayk4d8D7ovXtEy1vC7PUa64WT38/Xr
 gsOlWo+98lMUquviJxQANLlE9pBrSJXQDchoRzkPfdCY8Kw1m+fjTmLb0npht+dOhDbAlDsHjZ
 6ArS0GlsHrmUHbWo+7CNVhn0e2FD/1ezBckz8IyecNSgGp6NYXGA4vQ0IVFYjgTqta6ZdMvomE
 QWnKdg34DVvYB2jJqO8f4Mkogb/YiV19p8O0ElGa0frQulPXE1+7A/pKeLWFld6AnfsGNyIQbN
 XyQ=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jan 2022 15:59:40 -0800
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4JVNcq2kDmz1VSkd
        for <linux-kernel@vger.kernel.org>; Thu,  6 Jan 2022 15:59:39 -0800 (PST)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:references:to:content-language
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1641513578; x=1644105579; bh=CGRxrRXJyLQDHZtwUobuOfhQN8/+ZhzK98h
        mu5M2wss=; b=J58rzMQ3yq+u4f0FtWPAfw4k9B2pIlitFh0RkxggEp21gHqfEXQ
        jiK6TaaOoYj9vdaJ/6ndIdv3GUtZGWEKaHTRxB764nYqqLFsChF93r/hfelzppuf
        KTfokToP13Z4KzM0yLQq5wS8gL8QAId+oGMOfhDfd634wdrnOE86uo95w5gzkkDB
        g2hS8ejvrASszcrYmeC8nrHZdX+n8Tvxfw6K2sT6WVrqdeKqvgyoTU5aJa8rZjiG
        e9FMZ90wTWkr+ayV/afVDWSiUT71NyXjMoGGSkHcn/aeH6V284dpg0gPX5JILtp+
        nzbCl4T954/WEc1BLwuuV1iZfxV3IxQ77+g==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id TzQV8Z3ZbBOH for <linux-kernel@vger.kernel.org>;
        Thu,  6 Jan 2022 15:59:38 -0800 (PST)
Received: from [10.225.54.48] (unknown [10.225.54.48])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4JVNcn0L0Vz1VSkV;
        Thu,  6 Jan 2022 15:59:36 -0800 (PST)
Message-ID: <31ff2ee7-3e49-70bd-3f37-702d4e6c85a5@opensource.wdc.com>
Date:   Fri, 7 Jan 2022 08:59:35 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.4.1
Subject: Re: [PATCH RFT] scsi: pm8001: Fix FW crash for maxcpus=1
Content-Language: en-US
To:     John Garry <john.garry@huawei.com>, Ajish.Koshy@microchip.com,
        jejb@linux.ibm.com, martin.petersen@oracle.com,
        jinpu.wang@cloud.ionos.com, Viswas.G@microchip.com
Cc:     linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
        vishakhavc@google.com, ipylypiv@google.com,
        Ruksar.devadi@microchip.com,
        Vasanthalakshmi.Tharmarajan@microchip.com
References: <1641320780-81620-1-git-send-email-john.garry@huawei.com>
 <d2d3c903-fb91-e218-9e0a-aeb2ff9e401a@opensource.wdc.com>
 <2746563e-28ce-b328-3494-f91ace1599f1@huawei.com>
 <PH0PR11MB5112F9E9BB9F029DB9A67739EC4C9@PH0PR11MB5112.namprd11.prod.outlook.com>
 <c19c2b0b-d502-b393-db8a-cb5c57c00feb@huawei.com>
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital
In-Reply-To: <c19c2b0b-d502-b393-db8a-cb5c57c00feb@huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022/01/07 0:32, John Garry wrote:
> On 06/01/2022 13:03, Ajish.Koshy@microchip.com wrote:
>>>   only a specific vector and, also, why we check at all in
>>> an interrupt handler.
>> Here is my initial understanding so far based on the code
>> and data sheet
>>
>> 1. Controller has the capability to communicate
>> to the host about fatal error condition via configured
>> interrupt vector MSI/MSI-X.
>> 2. This capability is achieved by setting two fields
>>   a. Enable Controller Fatal error notification
>>      Dowrd 0x1C, Bit[0].
>>      1 - Enable; 0 - Disable
>>      Code: pm8001_ha->main_cfg_tbl.pm80xx_tbl.
>>      fatal_err_interrupt = 0x01;
>>   b. Fatal Error Interrupt Vector Dword 0x1C, bit[15:8]
>>      This parameter configures which interrupt vector
>>      is used to notify the host of the fatal error.
>>      Code: /* Update Fatal error interrupt vector */
>>      pm8001_ha->main_cfg_tbl.pm80xx_tbl.
>>      fatal_err_interrupt |=
>>      ((pm8001_ha->max_q_num - 1) << 8);
>>
>> Probably this will be the reason why we check
>> the vector in process_oq() for processing
>> controller fatal error
>>
>> if (vec == (pm8001_ha->max_q_num - 1)) {
>>   
>> Please do let me know if it helped in clarification.
>>
> 
> Sounds reasonable. And we only discover the issue for 8008/8009 now as 
> we have that (pm8001_ha->max_q_num - 1) vector being used for standard IO.
> 
> So let me know of any other issue, otherwise I'll send a v2 with the 
> coding style fixup.

And maybe add comments about the above so that the information does not get lost ?

> 
> Thanks,
> John


-- 
Damien Le Moal
Western Digital Research
