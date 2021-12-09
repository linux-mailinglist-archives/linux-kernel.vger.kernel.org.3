Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AAE0846F6C6
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Dec 2021 23:27:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232449AbhLIWab (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Dec 2021 17:30:31 -0500
Received: from esa6.hgst.iphmx.com ([216.71.154.45]:27926 "EHLO
        esa6.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230479AbhLIWaa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Dec 2021 17:30:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1639088817; x=1670624817;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=975X2tBKbiQALZA1i/B97FNGR1LMtD4rh57iUWiO0Zw=;
  b=oq4/J47m07dejqhwpEPHjSKYdE3z9bmfEuRFBuxVGdKrNifceMuzvZ+k
   fSYb6laxVl6MA5ICG6jDyRtbzuhj71oF8cnJ04xzrnq78EGLdGOnXXvkb
   rNpu25bANfwfQj04hRMzYMofnG4DAETKnO78i1nrikTE32I2fqqAL+vmJ
   V2r8n6eBLxYid8s/XsSQi/qWdtx2cDN62GjNS2R+0sNLnPBLyWyNveb1c
   DaJBPS6OwHZa4fVrS5aQ8LTMq/p7W6tLf32yXDoWNfoDPPFHA9RoteWjs
   ODK5MqzSiWApQ3aXUmD0jHFsghPNJ9VLqAeZIV3ngmcBtLMNqPG1co98c
   g==;
X-IronPort-AV: E=Sophos;i="5.88,193,1635177600"; 
   d="scan'208";a="188892978"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 10 Dec 2021 06:26:57 +0800
IronPort-SDR: 6kR5lZ9LgxX6R907fMgA4T2femzK+m8S4JCeZsITh7p2agLdaePXD/yDxli3amYyMi/peNOC+L
 A22lvAZUPDf0qUEKC3CtTJUrPVZ9lxSVNqKVJf3M5GLU4B/+XHe8tfItq6n4m6DOdUw7dTUNxD
 fcy5bl+bDZAvuGb/Fq5YqVbxT4jUgbLszdMQPgTMU5GS/Gm4p/O5hVJTSRFe++DH2zKYoyo+Y8
 3yNjz+JX2ev4JqfQ+ajmYFzhBSux05becp9wS0X/vwzlkc2xoiJtkzoSvU6cET4sAZL4AZVj31
 u9nhSaZrhAmDCKqanpipfPqa
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Dec 2021 14:01:29 -0800
IronPort-SDR: qKGAZt8D5VknrWHxDKA9d2pPKXgU6+qbtJgJG5o/4AdrF3rAsgB3ghE21ZPJYUseBjcahamiqJ
 MvY2qyFOaLw5VN5vnnZr/BLAXF+xhd6v6Ciw4cmKDbrOKg2tjPWuVmRCx3M4OqPPTuBoFzDlif
 4JIF+O+6iENWIdVknbwaRHiocZPkmSEIsSExmIiA3TtMoLgZ8AHrPMcAEtA1+IgZXBMy7t81+m
 ShdiqMBY4LeDwN3mURCqD8oqmrVxMIkhEd2WPuC4Znzvjfxik6yMHkHg2WgXnt410UqINtbpjD
 SjY=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Dec 2021 14:26:57 -0800
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4J97tm24gCz1Rvlf
        for <linux-kernel@vger.kernel.org>; Thu,  9 Dec 2021 14:26:56 -0800 (PST)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:references:to:content-language
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1639088815; x=1641680816; bh=975X2tBKbiQALZA1i/B97FNGR1LMtD4rh57
        iUWiO0Zw=; b=LWg8HmILYtwcIy67QMnmFtLckzM5vDZQxuW/0WrAY66BlZTJDSU
        oI5p/edn4uz21hPgYEi325chLddcQTgcaf+tkYps4rpWWTH7tmLorT2zhxkvBLDU
        ibFH68uGrJn374cUokUtPUSCgthUvUW9GkNN4QFnIKT5Wls3MqiVhZtalCFhK9HG
        /DEUJo6woooqeVAUUJSHORsbPegkfgl2ZO9ZRxRH3KeG5eUIxKPKEfCn3RkION/O
        9SQ2pRLuABnDHZbjtCTuo4Vn1qBXronI4QY8oIeMn4fM5Q5l+nmfiVDiTdMwjBFa
        UtHJEdEcmfj9Qz8l5ryqht5Y8mXW+i92y5Q==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id u_vKWzD0-_L9 for <linux-kernel@vger.kernel.org>;
        Thu,  9 Dec 2021 14:26:55 -0800 (PST)
Received: from [10.225.54.48] (unknown [10.225.54.48])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4J97tk19ZWz1RtVG;
        Thu,  9 Dec 2021 14:26:53 -0800 (PST)
Message-ID: <666af6d2-ac0b-9b47-a396-a5028772cf0a@opensource.wdc.com>
Date:   Fri, 10 Dec 2021 07:26:52 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.4.0
Subject: Re: [PATCH] scsi: pm8001: Fix phys_to_virt() usage on dma_addr_t
Content-Language: en-US
To:     Ajish.Koshy@microchip.com, john.garry@huawei.com
Cc:     jinpu.wang@cloud.ionos.com, jejb@linux.ibm.com,
        martin.petersen@oracle.com, Viswas.G@microchip.com,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
        Niklas.Cassel@wdc.com, Vasanthalakshmi.Tharmarajan@microchip.com
References: <1637940933-107862-1-git-send-email-john.garry@huawei.com>
 <PH0PR11MB51123148E4932FE1C64F8052EC669@PH0PR11MB5112.namprd11.prod.outlook.com>
 <a60318ef-dc19-a146-5ac3-16eae38b8c37@huawei.com>
 <Ya4PAu4Xj8UGHEV7@x1-carbon>
 <PH0PR11MB5112E2E7D00D95F32C86677AEC6E9@PH0PR11MB5112.namprd11.prod.outlook.com>
 <6ee6fe1b-e811-cada-0c18-78149c313358@huawei.com>
 <PH0PR11MB51120361EB6F6931CCE023D6EC709@PH0PR11MB5112.namprd11.prod.outlook.com>
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital
In-Reply-To: <PH0PR11MB51120361EB6F6931CCE023D6EC709@PH0PR11MB5112.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2021/12/09 21:04, Ajish.Koshy@microchip.com wrote:
> Hi John,
> 
> Was testing the patch on arm server. Didn't see crash there but observing
> timeouts and error handling getting triggered for drives. But the same code
> works fine on x86.
> 
> At your end do you still face similar situation on arm server ?
> 
> Thanks, Ajish

Please do not top post. It makes it hard to follow the conversation.

Are the drives you are using SATA or SAS ?
Could you post the output of dmesg related to the errors you are seeing ?

> 
> -----Original Message----- From: John Garry <john.garry@huawei.com> Sent:
> Tuesday, December 7, 2021 07:24 PM To: Ajish Koshy - I30923
> <Ajish.Koshy@microchip.com> Cc: jinpu.wang@cloud.ionos.com;
> jejb@linux.ibm.com; martin.petersen@oracle.com; Viswas G - I30667
> <Viswas.G@microchip.com>; linux-scsi@vger.kernel.org;
> linux-kernel@vger.kernel.org; damien.lemoal@opensource.wdc.com;
> Niklas.Cassel@wdc.com; Vasanthalakshmi Tharmarajan - I30664
> <Vasanthalakshmi.Tharmarajan@microchip.com> Subject: Re: [PATCH] scsi:
> pm8001: Fix phys_to_virt() usage on dma_addr_t
> 
> EXTERNAL EMAIL: Do not click links or open attachments unless you know the
> content is safe
> 
> On 07/12/2021 10:36, Ajish.Koshy@microchip.com wrote:
>> Well I could see this kernel panic [  126.843958] RIP:
>> 0010:pm80xx_chip_smp_req+0x1d6/0x2e0 [pm80xx] with respect to existing
>> driver on my current system x86 64bit after enabling the following 2 kernel
>> boot arguments: -intel_iommu=on -iommu.passthrough=0
>> 
> OK, so it seems that it was the kernel which was just not enabling the IOMMU
> previously, which would be consistent with what Niklas mentioned.
> 
> Anyway, please supply reviewed-by and/or tested-by tags so that the SCSI
> maintainers can pick it up.
> 
> I suppose that we should also have:
> 
> Fixes: f5860992db55 ("[SCSI] pm80xx: Added SPCv/ve specific hardware
> functionalities and relevant changes in common files")
> 
> Thanks for testing, John


-- 
Damien Le Moal
Western Digital Research
