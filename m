Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4FECF460F7D
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Nov 2021 08:41:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240406AbhK2HpM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Nov 2021 02:45:12 -0500
Received: from esa3.hgst.iphmx.com ([216.71.153.141]:27498 "EHLO
        esa3.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239425AbhK2HnI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Nov 2021 02:43:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1638171589; x=1669707589;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=kpZWgy1AvFSueydV91dF3ihwnnO96kRS+RploxrBq2w=;
  b=kckjnKBJeaByqsgHOnAMSxqXTdKj489x0pJESrWUUI3JPkIyCHfWX0lG
   yaPDnb2TqrHw+frkK8dYnh9elJi+05/WZZQ0NMTV8gpgRUIx73NsOf6PO
   Ai9UbGDsdrDsQ2AN+9IRladuwtuY96+G6oN7e9UMKAr+xIDIZhshSa9qA
   KLQ1KdLZT0BY4kJeFU36NFfkujfvdyCsy7da0oweSjzcr+HgmHz8RUVyw
   I4SLXPtSk1u/S/vBcYyW9MQJd+CGa8HKbAPo1NNGJagaSCNB1zg9XMdx6
   MP92MXUj0g8S1Ltp6D0EJ0PkKkIXYlM3FWNKfz4XOwSm1vyJncQNA62ij
   w==;
X-IronPort-AV: E=Sophos;i="5.87,272,1631548800"; 
   d="scan'208";a="191724029"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 29 Nov 2021 15:39:49 +0800
IronPort-SDR: KcsvTHugCrOomfd2YrBgoAe7O1rMxMCRnfLKcjUlqUO1/KHVgZ6xQKGOMkt/48BhyNDszbjv8v
 ubaOkborBUFTENigMAqEmTAujnrnG5pPUfI2rKCVK59gKp20v0wS17nCx2WMXWiF555T9d4c7d
 2iixDpC08c0qQuOjQeyPDCQwb3p1NLzAuBFy/C9iJyf3600t7rcMLK9616UZVQYYgVswzICFue
 rsNQbHxFA3UQ079y12sscYWFIMbh+Z/DkeqHruas94gd9PGvUqw4ceacilNWKPQIMzBrizDkcf
 v7VOy5wAU82FM7/CxY0sXSYJ
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Nov 2021 23:14:37 -0800
IronPort-SDR: OLWsrvPw7pZ6e5I1hKxn1XDm8uMBBD2ByWFYsPKzNwX3Md7emjpCG5VSRtdU2eniFY33uPP0ak
 VswlOzZIpSVLmzYQ669AfImxPV+dv0x7jP2iwxpc6owvfTJa6S7GFzFCSImZs8ajmHYHrtsWRh
 rVBARW/12SD5uHp/CaRSvlYpPB8suxgxaqcXKLbQw6b0OOf2a2oCgt4wQbEMTHmbi09wIZr5tg
 O/vKTZFiFDRYUSI8FeAghhCUZKzMhD84x2ua9u4VEWNbDQAe4NCPgefQO758kfzYurQLA8VCs/
 moc=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Nov 2021 23:39:51 -0800
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4J2cgp66lpz1RtVm
        for <linux-kernel@vger.kernel.org>; Sun, 28 Nov 2021 23:39:50 -0800 (PST)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:references:to:content-language
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1638171590; x=1640763591; bh=kpZWgy1AvFSueydV91dF3ihwnnO96kRS+Rp
        loxrBq2w=; b=FWvkO9gBPmVQ4jTCbbuSMl0QwYB4RKZcJnKxaY0kUOGm6D50gJ9
        2z8G8g96BrbAJtAIBmrA0luIQomgLHaRpFtDzAawRAuUCvgu9csamV8wYUaU1Fds
        RJdt8D8G/pKc9hIYiigHkplvCyLyI9u4YjMRgO6ios1wrB2bIFPMUb3pue9Uoac/
        RHsyCPDPbmUODc6F4ni3k1DPm1HDYeuXSZ0ZFyHmYpC7BL1WiKoKRrIiTGJL4gyt
        zYBa1hy8nBRVEmEyjkPFu3eHcaewP4ZigaGk9veUaoAks3lkFQMTmqajnYuNBx9E
        DD7xWnoKjiTs5KuMsX4jKBuLetaPlrt91Rw==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id 7_Avg2BPSLp2 for <linux-kernel@vger.kernel.org>;
        Sun, 28 Nov 2021 23:39:50 -0800 (PST)
Received: from [10.225.54.48] (unknown [10.225.54.48])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4J2cgn5SL2z1RtVl;
        Sun, 28 Nov 2021 23:39:49 -0800 (PST)
Message-ID: <6ecc0597-3b2b-d8df-1dd9-38a921c59d9a@opensource.wdc.com>
Date:   Mon, 29 Nov 2021 16:39:48 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.3.2
Subject: Re: PROBLEM: [drivers/ata] Read log page failed (boot error message)
Content-Language: en-US
To:     Nikolay Kyx <knv418@gmail.com>
Cc:     linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
References: <YZABtvQab/M2CCQd@msi.localdomain>
 <14b22c98-dc4c-fe3b-fa20-b3dd78afd5cc@opensource.wdc.com>
 <CAMJR_v6igrNZMzXpio27PpA6rQvo+efAVd2nM5GNg2+agQa9=A@mail.gmail.com>
 <b386bdc4-db27-3160-80ac-ecd9d8d69c9f@opensource.wdc.com>
 <CAMJR_v7Y+o7sFh+ViM-hmZ-AqfEujcTSOYNf8ospvPHuk++wcQ@mail.gmail.com>
 <8e55f354-0522-de56-2c1e-56557888602f@opensource.wdc.com>
 <CAMJR_v4_3npqoTkFYW+2OVDHjj4-9WK70xASK6C1Mqn=S5z2Wg@mail.gmail.com>
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital
In-Reply-To: <CAMJR_v4_3npqoTkFYW+2OVDHjj4-9WK70xASK6C1Mqn=S5z2Wg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2021/11/27 19:34, Nikolay Kyx wrote:
> On Tue, Nov 16, 2021 at 2:44 AM Damien Le Moal
> <damien.lemoal@opensource.wdc.com> wrote:
>> Latest kernel will not even print this warning since not having support for the
>> IDENTIFY DEVICE log page with ATA-9 drives is expected. The patch fixing this
>> will go to stable too.
> While with 5.15.2 + patch there weren't errors from libata, with
> vanilla 5.15.5 (in which patch 'libata: core: add missing
> ata_identify_page_supported() calls'
> was included) there are 2 other (new because it wasn't the case with
> 5.15.4) error messages:
> sd 5:0:0:0: [sda] Asking for cache data failed
> sd 5:0:0:0: [sda] Assuming drive cache: write through
> With the old warning (twice):
> ata6.00: ATA Identify Device Log not supported
> To summarize errors:
> pre-5.15 kernels: no errors from libata.
> 5.15 - 5.15.4 (twice): Read log page 0x08 failed, Emask 0x1
> 5.15.5: Asking for cache data failed; Assuming drive cache: write through
> Same hardware, just upgraded kernel to 5.15.5.
> I still think that my HDD doesn't deserve error messages in dmesg.
> Errors from the storage subsystem can be scary for someone.
> 

Please see:

https://bugzilla.kernel.org/show_bug.cgi?id=215137

Greg already queued up patch c749301ebee82eb5e97dec14b6ab31a4aabe37a6 into 5.15
stable to fix this issue. 5.15.6 will be OK.

-- 
Damien Le Moal
Western Digital Research
