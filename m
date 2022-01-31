Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A25624A4F4A
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Jan 2022 20:17:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359402AbiAaTRv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Jan 2022 14:17:51 -0500
Received: from mga03.intel.com ([134.134.136.65]:36381 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1359480AbiAaTRn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Jan 2022 14:17:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1643656663; x=1675192663;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=4d2Dvk/EqIfNbNSb8gHp/KXarzBELGd/XtfFehnQ8Vo=;
  b=fInhTviGeClOvrbKZenOqLPFDkx9oIAdGaLK8eKTZ8fKS/c+PwGbWHSh
   6sH6SQVu+tG4qRUhwsYnq3CBIZi30mFEzQt2XxnKHNtTjpWkMaoUE5q5o
   zO69eEEhFhLoFHq2yJxeZqOhbi+3dSE+khj6A9NCXsl3PNtx0zs2RU+q7
   KoePQlpghlKZwZkDbHPnEU3JQVIB4QpNHRctory9cKXWGZNcnE5fOhfON
   TlwDysuGgoX/8PJw+cr4t5WYSc+Ndzf5VNzseNsHKTKPAKmWeLoa2xTwF
   DeE99d4/FQqI/9MhQHQG7Fh3juitgJKGh/Dc/mtgXvPN0MKzMDVAhmsLy
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10244"; a="247485752"
X-IronPort-AV: E=Sophos;i="5.88,331,1635231600"; 
   d="scan'208";a="247485752"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Jan 2022 11:17:43 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,331,1635231600"; 
   d="scan'208";a="626474236"
Received: from fmsmsx604.amr.corp.intel.com ([10.18.126.84])
  by fmsmga002.fm.intel.com with ESMTP; 31 Jan 2022 11:17:43 -0800
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx604.amr.corp.intel.com (10.18.126.84) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Mon, 31 Jan 2022 11:17:42 -0800
Received: from fmsmsx601.amr.corp.intel.com (10.18.126.81) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Mon, 31 Jan 2022 11:17:42 -0800
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20 via Frontend Transport; Mon, 31 Jan 2022 11:17:42 -0800
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.172)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.20; Mon, 31 Jan 2022 11:17:42 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aT5YKJmu8WGjEZa1ARLZrM6//wRaDw1GYy5E3THyZMaEtN1huTnvipOuzfcbQIgg3oKGW5S+5IVRXYkcEpWeaEx79nF56WC2xT03EU2J0lZiq/BsTbecnXYvXLabwIGjYxVEIZg+82qBUMljwZU0OSXMBUW/dLgs+r239DILeezRykmqBA0CO4zSgsi2hf3KBwsel0KOHVDHy0wdIcXPdlfz3RYh9Ifitnv8FNjs+8hN/Jd37YDsdlWp0haxuIRyKYP/h73qvA1GGncW4WmIm5VZIaX0+0+212hYsBGb20zazevqG+naZ8d9cxYOkpT2dp8C/tOE3aFWxHN0Iq5AkA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nByeo3B/kz/Tf/v2LMuj6HIT4BUVaFVVnzchqqTd3ts=;
 b=fR42CpZF+Stq6OBF5c9d/PRUGezJWZ2B9zMZr9GFPCpYEa+SYYIrGmwk0lnw55JTOdoIlgft+WnNyf+mplxGpYXrwdD/zovKzemT+AayMatdQ99NxNtCLmV3zoVhLYJ5AkXJznmCmgCM5rpoDl63cvxfwFc1PBk2902egNPuNVie0on8DKy80xaW+MJqdrkd/6aI4eldveF1SqZRhnk5z3hB2wOhONcC9bNwDNU1W1UzKy1ToEEiwOp7J8PYMO94QQjkIbCgm08xy3dP+U9RtNsKs5wf5QuRF4G5HB5LJT+0UpR9SNG1ialGhhbymcZDH97K/fCTdce0pGI/8PEX9A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MW5PR11MB5810.namprd11.prod.outlook.com (2603:10b6:303:192::22)
 by BYAPR11MB3846.namprd11.prod.outlook.com (2603:10b6:a03:f5::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4930.19; Mon, 31 Jan
 2022 19:17:40 +0000
Received: from MW5PR11MB5810.namprd11.prod.outlook.com
 ([fe80::1419:964a:8506:5420]) by MW5PR11MB5810.namprd11.prod.outlook.com
 ([fe80::1419:964a:8506:5420%5]) with mapi id 15.20.4930.019; Mon, 31 Jan 2022
 19:17:40 +0000
Message-ID: <6502adba-c91b-cafa-35a5-635636b31075@intel.com>
Date:   Mon, 31 Jan 2022 20:17:33 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Firefox/91.0 Thunderbird/91.5.1
Subject: Re: [PATCH] acpi: require CRC32 to build
Content-Language: en-US
To:     Guenter Roeck <linux@roeck-us.net>,
        Randy Dunlap <rdunlap@infradead.org>,
        <linux-kernel@vger.kernel.org>, <linux-next@vger.kernel.org>
CC:     Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Linus Torvalds <torvalds@linux-foundation.org>
References: <20220130223818.16985-1-rdunlap@infradead.org>
 <f153d3dc-f4c1-9c4b-aac3-da3a696a3313@roeck-us.net>
From:   "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
Organization: Intel Technology Poland Sp. z o. o., KRS 101882, ul. Slowackiego
 173, 80-298 Gdansk
In-Reply-To: <f153d3dc-f4c1-9c4b-aac3-da3a696a3313@roeck-us.net>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR3P281CA0021.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:1c::11) To MW5PR11MB5810.namprd11.prod.outlook.com
 (2603:10b6:303:192::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a1dbb6ed-9e89-4685-64fc-08d9e4ee594b
X-MS-TrafficTypeDiagnostic: BYAPR11MB3846:EE_
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-Microsoft-Antispam-PRVS: <BYAPR11MB3846EF79E1870C5C4CFA2EA9CB259@BYAPR11MB3846.namprd11.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: xiFEb55gNjjMaPQJ6o9DAzy5sKixnNiQXgQePWO3NtMqiTiWfgZ1iYyrcDxX9gFPkRj2AWabo5Lb8WQV0q4olet1MyQ2U0Gca0DVYvqkDS2Qk8ndR2TlHPLe+eBYm7kgJCmKjUgNS54yIfa0vwC2tu35JSCZgMU7vgaMwsWG11JapZJr+bu5NhzX8pOJ9gGtk/qHbAinS3jSiRBOkDFvzccXP4xLbK5ECEZaSoYKXlwL9GBjYnH77t4DwhpA0dJz5GHbZZpoLWOfY9XK67tORFcg4qirZrLBmWLuWlsn+owutkipuJNJVujWq6AciKghuuxWXNwZICT3p4+sYBlJygrTFWHrTsgAOLpNqj9SeJ7OGwtvw/1P7d6YfiBz36Nk1MYRvXrhMUOh0t6jZPTRZN+AKQQtOt6SduBq8meO7Ugu2H4CWNi1Cxem248sMTGL54YNHo55MiY/QsdC/bG8lJVnOU2+BnuPM6Sbx0sXNgk3Eu7EWposfKSlgKnswCvmSbQ4bjdGrv/HwzfspRtS3X8lRLIWmUr6KnzPo+bmX23cy9xuQ5JeBD+/+edLsF6XP6d7TPcLe/F4NnC/vp83q2GQKWIpn9g550AF9fpskX+1QbSixkTLXKvCm5hlPeIFrg7qq5+jdwni7c8mZSQiocneyHcETy6ixC9Yc8+fBKRCRg47YpetbzbmB3g1++wAsUlIr+mchj8GZQd+Y/w8FBnmaMtgMbcuaDXbT3DoKwpz2YJ6JpYiUwzqNGNczRuEVotP6nJbN9B3KebAbFgu2R5KZK6ok4xuCVPH5qo4FSZvc+CWzGNFoLHT6JOZ8J9F
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW5PR11MB5810.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(6512007)(2616005)(26005)(186003)(6486002)(31696002)(84970400001)(86362001)(508600001)(53546011)(36916002)(6506007)(8676002)(8936002)(5660300002)(2906002)(36756003)(31686004)(4326008)(66946007)(66556008)(66476007)(38100700002)(316002)(82960400001)(54906003)(6666004)(110136005)(43740500002)(45980500001)(20210929001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VjVDZ04zUC90TWdIVEEzRHRZRk1LbzFWYkdYRXFkckhIOHJtTi9yRG1ac3Ji?=
 =?utf-8?B?bi90RnFSMVhyREN0RDBvUmJBalhybmQrM2V1a2dhaEI3TlluOEpJejhydFVE?=
 =?utf-8?B?ZmcxUGtBY2JUbnRBSGdlQk9VeXFVNEdrdThPSjJHQVV3V1VXWGhoTi9PcU1X?=
 =?utf-8?B?U0ozYTIxa3F1eTlFVVByTDNMUm9XdFp1TlBGWGhvaVVFWDhtb0FONFVzK1E2?=
 =?utf-8?B?dTJtUlpVY3Nwb2NKL1lZM2RIUGlaQml1c2hoV0tHK0lNUGF5eEJuQUpxdmVC?=
 =?utf-8?B?RmUvV3ROZGora1o3VDVhT2lDWEVyUy9abHlmaWJBblhvaVRnSlcvQWw4YUdt?=
 =?utf-8?B?NGRuaDVEREFvQ0pPM1duQllOK1B6RXdmK0l6VVViUWUvT0VlRkN2KzlJVW41?=
 =?utf-8?B?RlZaT012b2d5czM1KzR1QndGUUx3UXRJWFBNRXc1Z2RUUDdCVEhxclY0VXdT?=
 =?utf-8?B?eE5sd1RuTWpQelhVQUNTZHAzZ2lDM0J5VmVITVJmeE9BU0l0T2xRVHlDcFBF?=
 =?utf-8?B?a2hOWEhkTWVSYkRHZUZBQnZKdk9Ua2FLWGwxUmdhYnhGSmt4U2pJRmt6anRs?=
 =?utf-8?B?cGRhMUh0Mms0M2NINUQyODBMcU5wMVNSMW5UKzQvZVFkeVZyVlVJMkhEaFM0?=
 =?utf-8?B?K0RUVEg2bXg0NlNMRkJycHFwYW4vSk1YTHBZay8zT1QvRit4K0R3YTRUbm5T?=
 =?utf-8?B?UVhxYWhGSHNFNXBDY3BTSFRpQWwzdHJMSCtadEJUY3BJVkhjQjhDajJjelEx?=
 =?utf-8?B?UWlBNGhBclpzRURkbXdOaW8wNG1HMXJFYXBzOU5Fbzl1b2RBcXBLeVEycS9J?=
 =?utf-8?B?RkdZalVHanFmMjdzbGh4UkRzeXR0eTFhdmlPZTNXNVVWZXh0VWJja2IyNXVJ?=
 =?utf-8?B?Tm1oMzlYWkNYck1waG8vWUNCSlVTWG84bGdRWVlzazVsc1VpdG1zSWRuNVV3?=
 =?utf-8?B?M29CalFhY2xpdTRzSEd2QU51RXBOaDNmNnhDb0FURjdFV091TkNzVU80OThu?=
 =?utf-8?B?YXNJSkpzYnZxY1pnU0xJc2J4aGVSb25JNjh1UytxUlRrSmlkSVEzaEZOSVZY?=
 =?utf-8?B?aXJLZTlKRmdNbis4cjdnbXd5Uk44U0lJYUFoWWRRTzY4cVpQdWtjd1Q0Y3U0?=
 =?utf-8?B?Ymx2b3NqeEtyZGdveWRIMk1VWDhUcG1sSFBoT1ZaSzIyVlBYWlR6UWMwa0Rs?=
 =?utf-8?B?R1NJaFRYVFJCZS9laGpRYXF4R0UxN0Rld2JzMGNiYWdDYkRROG5HTzhKb1NG?=
 =?utf-8?B?L1JUM3AwNlQyRHcxRi9BWjA5ZWt2QXY4b3ljWHVmR25QMUVKUUNJZ2t2WmtQ?=
 =?utf-8?B?Tnl0TXk4MGhWbzRDVEVCTzlwczN4cXVkWEZxVXlFdzB3ZGdPVi85ejFMZ0dO?=
 =?utf-8?B?TDE3My9HUmJQNlJKYnVQNU4wY2N6dnJVakttempVbWwvMWRBM0t6ZndpalVO?=
 =?utf-8?B?aThwV2t4bk5kNHB3WkxCM2pVMUhsdDFTbEdEMDNKVFRxNGNZTVBITVNEWmJS?=
 =?utf-8?B?MjkyTytWeVZ2QURsRHR5OVBCWWxoa056dG9uOU5YTm9FckZKaFZER0hxd1Ar?=
 =?utf-8?B?b2YxdWNNRzU5ZXE2R2RCRlN6R1hqV1YyRCtnR2luUlNSRHVlei9EeHA5UHZj?=
 =?utf-8?B?M1l1dm51bDZ6blZtd2dpbzJ6b0svY21pUzNMek9YNHBOZzRGc3BheUpVTXBi?=
 =?utf-8?B?eXNONThRM3R5RURTUDJlVzhkSWdOaW4yNjNmMm9GZmVCYkhnTjFHdjhxaFRo?=
 =?utf-8?B?aldrVWZZYlRWNEg2eFVCaGJHMkxoWHN4aU9qa0E3Y0s2OSs2WnVpT3kwaE92?=
 =?utf-8?B?ZGpzSnBpUmZ5dklDMkpOL2Y4RzhXZGx0Nm8waDcrRGxZc3BLZEtPM1dVWER6?=
 =?utf-8?B?NVlUR3lOWVJUbHZ4RVJNSnlqSkZkdUozRUdObCtrQUtIZ0pnd2h0Mmg4QUlQ?=
 =?utf-8?B?aUtqTlZkcWozVSt2QWRCdEFLTXV2U08xWERtZkxqQnRuN2lYTGFLSzdTUlNU?=
 =?utf-8?B?NktiNEsyM1BSWEtxWEJ2Y3dkbHJLTTgwZ3g2eHNlTlJKYnQ2QTYrMkdNYXhF?=
 =?utf-8?B?bnRMSUZIa3ZPRU5QNkw0RnZ4MmpUM2V2TUNxeFk2M1VuSXNxWGFxaTdTNmdo?=
 =?utf-8?B?dTh5ZEFsVkw3cXBEaWIxR0VIektrNHAwWERNdElLM0pDMDJ0MnlDbE0xcHhZ?=
 =?utf-8?B?U0xBdDE1TlFSdTJxMXZZRWZWdHU3L3FVdEh0NXQyMDlPQmNBSnAwOVc0ck1k?=
 =?utf-8?Q?tldAYrJGmjE4387KRBX3Cz1VtpC4ubIzUNz9VKtZs0=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: a1dbb6ed-9e89-4685-64fc-08d9e4ee594b
X-MS-Exchange-CrossTenant-AuthSource: MW5PR11MB5810.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Jan 2022 19:17:40.3910
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OYvYdHLXRiyQSk1IQbG2TYe+LIk512SPU+fnvGFDIuREnLAjkjqMnP2TolYzVAwFanC1dImSDLjK6ahADMIva5T+LPVZH97wGUNrIyPPtjI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR11MB3846
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/30/2022 11:58 PM, Guenter Roeck wrote:
> On 1/30/22 14:38, Randy Dunlap wrote:
>> ACPI core now requires crc32() but the kernel build can fail when
>> CRC32 is not set/enabled, so select it in the ACPI Kconfig entry.
>>
>> Fixes this build error:
>>
>> ia64-linux-ld: drivers/acpi/scan.o: in function `acpi_store_pld_crc':
>> include/acpi/platform/aclinuxex.h:62: undefined reference to `crc32_le'
>>
>> Fixes: 882c982dada4 ("acpi: Store CRC-32 hash of the _PLD in struct 
>> acpi_device")
>> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
>> Reported-by: Guenter Roeck <linux@roeck-us.net>
>> Cc: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
>> Cc: Heikki Krogerus <heikki.krogerus@linux.intel.com>
>> Cc: Linus Torvalds <torvalds@linux-foundation.org>
>
> Reviewed-by: Guenter Roeck <linux@roeck-us.net>
> Tested-by: Guenter Roeck <linux@roeck-us.net>
>
Applied as 5.17-rc material, thanks!


>> ---
>>   drivers/acpi/Kconfig |    1 +
>>   1 file changed, 1 insertion(+)
>>
>> --- linux-next-20220128.orig/drivers/acpi/Kconfig
>> +++ linux-next-20220128/drivers/acpi/Kconfig
>> @@ -11,6 +11,7 @@ menuconfig ACPI
>>       depends on ARCH_SUPPORTS_ACPI
>>       select PNP
>>       select NLS
>> +    select CRC32
>>       default y if X86
>>       help
>>         Advanced Configuration and Power Interface (ACPI) support for
>

