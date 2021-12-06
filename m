Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F25FA469557
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Dec 2021 12:58:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242805AbhLFMBg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Dec 2021 07:01:36 -0500
Received: from esa3.hgst.iphmx.com ([216.71.153.141]:11374 "EHLO
        esa3.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242590AbhLFMBe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Dec 2021 07:01:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1638791886; x=1670327886;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=JLsPtMRwUyoWIb/S1MOjGwHtvTz17PsU2F+I+ND0T48=;
  b=TidxbIEVOKwh7kXWolAYXE/Qgxm8hizQYUa+2rbLhtb/3mxI5pkSx5rv
   KdXuOmd8mjoYuY+0OMpP2PQPNI0+A/YwsApTuKVeITEPetRfNR34pVvnE
   9m3T7GHn7uNr6ULt3IW5pz4wvaLoDPHcmSzfEmADpkVerM8QBMtETskzT
   EJHuXzr+iFmgTP3ptdaIat42RUJM/hMIRfe7HycYCZfB8vKnZCV8p8fqx
   pAk2e93EctIguGcGL7dXwYra4DnoiQaAkTTqf+RStReOjhN13eoe9o5Th
   k8vAQ9OiCFyJYhdt7bd+CO+jQKZOb0H7W9IAhfo2Uco49t4SXcR9he/qd
   A==;
X-IronPort-AV: E=Sophos;i="5.87,291,1631548800"; 
   d="scan'208";a="192335995"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 06 Dec 2021 19:58:05 +0800
IronPort-SDR: eB550pYQ2IA9IiOVlU9PsQyIPxXw++0LQXhWSDsyCqD06N6yIpoBgb6KoVYvtm3bDxeYak239m
 YZDUF6oMNqVRiPaZwSHtUkN4fVfTrM9N/M1QZ1Ducn8ZeOxsnsoH05oUKgyYFRypbBdw90CSjQ
 yQzO9zirXiyqsSdGxcLrNCJDFwvUfqpCHZ/ml82ReG5QM6cmjmnrHvFTHlGglMIr140M14ZGiG
 w1tAr7TFye3+3SwFV1yohRgiO2ocSipfzzZZb0EWohw9iMbOMQMqpYY8tIuiNbRylG+evmOYp/
 5B4EeagtoGIozcOvq74nm6+e
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Dec 2021 03:32:43 -0800
IronPort-SDR: JRp8c7dZm9mdtSrNxkLUDPLcrwZe2lv2839afQLY1fEXNc3rnAxn7MDNf/cEq7EjceQiKS3Nql
 tS4RhO82E/zVrNlzCb/trn0hCzr9pJ/Y4Q6JQ5cebDhvyiTT7hpsspVmCQlTxcSWG9WlIUTBbn
 +4L5rPCzpaasEvc3fV7V7ls4TUBDtdnI6SH2zEwo5KltI7CDCrBZcqpczSQjgK3BBiobC5PtBr
 t2h7euTdAx+kVJsPq8Cb8/G4uwGWXTBEC9jc+czjZAoSRcRAO+nL4nIlAQTLJdI+C5mp75iWxK
 UM0=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Dec 2021 03:58:04 -0800
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4J724V5LMWz1Rwns
        for <linux-kernel@vger.kernel.org>; Mon,  6 Dec 2021 03:58:02 -0800 (PST)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:references:to:content-language
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1638791881; x=1641383882; bh=JLsPtMRwUyoWIb/S1MOjGwHtvTz17PsU2F+
        I+ND0T48=; b=KHuS9w9VVNTRTQs/HK84M3/UJxkpE7spResPSul5I5VI7bB1hqU
        5ldgtm0wcz4TsLl7+TVTnEsX/CLILntNe6zDvOzuDHJqbsB+w8g29SeMxbfvw0pj
        y9zyVN3NsbButJGHSlMl/NcScTZ9788ftGAYBVhXS2HpMdJkYDOvI4s/4/iBEG83
        FfXh8D5c5aae+zN+w/Dv2mbQqzzMthxmDxaZf/tKlDDB9p+wgtBfZxjrtfjGrw9Y
        jDXCT0tyftXLcZbDWbMOxscjGfD3t4kYnFo4NCCmSdQL5K/PJ69oUhAtGyTBANJY
        zPd0Mq0SskKP6l5ruzMX3ZxUvQt3zCbTLzg==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id EUnz3CgApOQR for <linux-kernel@vger.kernel.org>;
        Mon,  6 Dec 2021 03:58:01 -0800 (PST)
Received: from [10.225.54.48] (unknown [10.225.54.48])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4J724S3TDvz1RtVG;
        Mon,  6 Dec 2021 03:58:00 -0800 (PST)
Message-ID: <8dfe634c-7466-dca3-6838-b305b2eb465a@opensource.wdc.com>
Date:   Mon, 6 Dec 2021 20:57:58 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.3.2
Subject: Re: Need help to debug ata errors
Content-Language: en-US
To:     Ayan Kumar Halder <ayan.kumar.halder@xilinx.com>,
        linux-ide@vger.kernel.org
Cc:     axboe@kernel.dk, linux-kernel@vger.kernel.org,
        Stefano Stabellini <sstabellini@kernel.org>,
        Stefano Stabellini <stefano.stabellini@xilinx.com>
References: <df61e958-7bd6-94df-0da2-56aa1084350d@xilinx.com>
 <022c3fad-ca0b-50c9-79f7-2bfa3de75a0d@opensource.wdc.com>
 <3aba2b93-9440-e581-61aa-76161f55563f@xilinx.com>
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital
In-Reply-To: <3aba2b93-9440-e581-61aa-76161f55563f@xilinx.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2021/12/06 20:18, Ayan Kumar Halder wrote:
> Hi Damien,
> 
> Thanks a lot for your inputs.
> 
> On 06/12/2021 00:12, Damien Le Moal wrote:
>> On 2021/12/03 20:11, Ayan Kumar Halder wrote:
>>> Hi All,
>>>
>>> I am trying to run linux as a DomU guest on Xen with AHCI assigned to it.
>>> I can confirm that SATA works (ie able to detect sdb) as a Dom0 guest.
>>> However, it does not work as a DomU guest.
>>>
>>> Hardware :- ZCU102 board and it has two sata ports
>>> Kernel :- 5.10
>>>
>>> I have enabled the debug logs in drivers/ata
>>>
>>> 1. Logs from dom0 (where SATA works) https://pastebin.com/2BhMDq47
>>> 2. Logs from domU (where SATA does not work) https://pastebin.com/fE8WZnZ0
>>>
>>> Can some help me to answer these questions
>>> 1. What does this mean "1st FIS failed" ?
>>>
>>> 2. In the dom0 logs, PORT_SCR_ERR = 0x41d0002 whereas in domU logs,
>>> PORT_SCR_ERR = 0. Does it give some hints ?
>>>
>>> 3. Any other issues or hints to debug this ?
>>>
>>> I can confirm that in domU scenario, we do not get any interrupts from
>>> the device. What might be going wrong here ?
>>
>> That would be the first thing to check since without interrupts you will not get
>> any command completion. Commands will timeout and probe will not work.
>> And this IRQ problem is Xen territory, not ata.
> 
> I am actually debugging the interrupts from the Xen's side. I can 
> confirm that do_IRQ() (Xen's irq handler) does not receive AHCI 
> interrupts. It does get invoked for interrupts from serial and other 
> devices.
> 
> I have seen commands being timed out which is due to the iRQ issue. But 
> suprisingly, ahci probe is successful.

That cannot be. Without any interrupt, there will be no command completion.
Command that timeout are retried. So you may have seen timeouts because the
platform or device is very slow to respond, but you must be getting interrupts
if you get a good device probe. Otherwise, you would not see any disk connected
to your ports.

>>
>> The 1st FIS failed error may be due to some problems with AHCI PCI bar/register
>> accesses, which may not be working. This I think points again to Xen setup with
>> domU, which may not have the necessary access rights to get IRQ and PCI bar
>> accesses ? (I have no experience with Xen)
> 
> This is the device tree https://pastebin.com/HtdLx63v . I think it is 
> not related to PCI bus. Please correct me if mistaken.

Well, since you have an ahci node, I do not think that adapter is behind the PCI
bus :) It is a child of the axi bus. Not familiar with that type of setup...
Are you sure all properties of the ahci node are correct ?

> I have the necessary debug support from Xen. Can you let me know what 
> bits I can debug from SATA side (for eg reading a particular register) 
> which will confirm if SATA has been programmed correctly or not ?

The device probe with domU should be no different than what it is with dom0, I
think. Again, I do not have experience with Xen, so not entirely sure.

Note that from the dmesg you sent, for the working case, the port seems to be
awfully slow to link up. Not sure if that is normal for this platform.


-- 
Damien Le Moal
Western Digital Research
