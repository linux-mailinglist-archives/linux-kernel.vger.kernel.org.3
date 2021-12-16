Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9207347690D
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Dec 2021 05:32:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233519AbhLPEb2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Dec 2021 23:31:28 -0500
Received: from mail-bn8nam12on2068.outbound.protection.outlook.com ([40.107.237.68]:59133
        "EHLO NAM12-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S230222AbhLPEb0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Dec 2021 23:31:26 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bfjLzqCn5sf5+nvdFWKsJ8rMXOXFOAwQuZTvepO8L/1QUQiBZWkcwaD5mlsiZHzFXB+Wx0Gfd0WsAcFxjvnYOZE/kYMHSaWUwnhgaPhVBWe/y2DB2YxsdZKNtN7mcr0TMxmWTIKHFiwzbzZ3EdNswFbMOEjS+jjMrzRAvKBDmfD3Ew0B/WSUr8YNET6pWTw8GZc+1ltRJseCPBT2y2cufS1DwvqlXOTtk8DnFNG9ulfXAllyoSmSopLY0ZRnc71UZ7L6h3V+4llovb9+wNYFJ0fSBVGWzdHUuTRFAk2CLcme3bbsMBJ4KJYNB4FZB2FZ1C3pau1iQDqmoU0IPefx/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xx+s/C8Asdym+kWWGTDnDcMZ0e7QZd+Ft0rtBd836iA=;
 b=iu7ZtJ/B9BCJMqVrJMw7lDBoc7I+z1t1fIy9p+klOVzN6QuBEODYnkUAiKRRmU6MhMaw6JmaWUcHX5Kf4yxr7oBOwDAFDoKMmV+cfPXcC+GqZgd6gd6rWoN0/6UdRpOVU7uHaFNBBHD4Y0RJbotHU6bn1ctEHngL8W2KtitjejHTJ0kKX0eGqBFOewwI1gVCHlBOfy/xXqEIaZLWii9LjO058t0U+FAx5DIatVZx1tbuyJ5ud1rlw8L8ObSuuilsgGxujeqQ6+dPbx+MoVvhraMJobwTZNJr9/F7tBX5RZgw2IStEIRU5ImoHyudfPfaf0UrQ8bQIFrNHvm+9IHEPA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xx+s/C8Asdym+kWWGTDnDcMZ0e7QZd+Ft0rtBd836iA=;
 b=luePOb3V19FCxHdIdOKeRWgX9fqT2+N4zAsuWSM/kAuAWXaGfhAq4EvTl6B9kJofu/0aU+MSTZpvSiUFzDXCjLr2r1IutsbR6wBO2d4EuDjHoHjjt8xFUPWwQcVMwejJagqb5F1Vj23xmHryNPqRX6Sg85ASke9yi2pqy/rKZeY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB4188.namprd12.prod.outlook.com (2603:10b6:5:215::18)
 by DM6PR12MB4281.namprd12.prod.outlook.com (2603:10b6:5:21e::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4778.14; Thu, 16 Dec
 2021 04:31:24 +0000
Received: from DM6PR12MB4188.namprd12.prod.outlook.com
 ([fe80::76:8f86:a56f:38d0]) by DM6PR12MB4188.namprd12.prod.outlook.com
 ([fe80::76:8f86:a56f:38d0%7]) with mapi id 15.20.4801.014; Thu, 16 Dec 2021
 04:31:23 +0000
Message-ID: <abd2400e-f47f-b1b2-2f69-deb1e194313f@amd.com>
Date:   Thu, 16 Dec 2021 10:01:11 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.2
Subject: Re: [PATCH] usb: xhci: Extend support for runtime power management
 for AMD's Yellow carp.
Content-Language: en-US
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     mathias.nyman@intel.com, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20211215093216.1839065-1-Nehal-Bakulchandra.shah@amd.com>
 <YbpuZV5qcF04PHt8@kroah.com>
From:   "Shah, Nehal-bakulchandra" <nehal-bakulchandra.shah@amd.com>
In-Reply-To: <YbpuZV5qcF04PHt8@kroah.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN1PR01CA0108.INDPRD01.PROD.OUTLOOK.COM (2603:1096:c00::24)
 To DM6PR12MB4188.namprd12.prod.outlook.com (2603:10b6:5:215::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 01fe5e8a-7a4f-4797-c9d9-08d9c04cea84
X-MS-TrafficTypeDiagnostic: DM6PR12MB4281:EE_
X-Microsoft-Antispam-PRVS: <DM6PR12MB42815D6BBA3DF6FF23ADEC5DA0779@DM6PR12MB4281.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4125;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: bpqXQJIrnrq/nTlF3oELFdrYtPFmO3xT1yVIi8AnjaoFOLPDTyzcintgyfuGY2VHo94m0D8b5PtE8ANu4CuhJYYrkvf9ZMHLgMY8b4YEqBzh2111Adlgy5A344B0x/KChZ5Pwntgw7kV4ex/gNUPqVozvTiTQS/ivbBZXoxEm0v7xQgshhsXtCcU8sDRJW+0CixZTjZlST2S0r4ySLPciCfTcfE7+sWGx5lBYuGVYl0JfOs+0nNd7rEeX4+wyquOjU+P8QqwvBhouwDBAM/wD8TYRkz29Sw9S/g07nLrU5QK0FSq0/gLKj/YQa8tS9r8iu+ABRmoo2XJAj4FDHkeekVo+eWUa0ybgeTIGf5t75UnM0aykKTIttAtrYkh5In29v25g894T4pgZF/EQ3pK9AQfXaD8C6cEIZuLqlFWF7etKFk7WmSYzewjxVHTscs4ANnSsZqoiISeLnAjSMgLGZuznJ3gCRx7Yee7gRhJY/F0xUrJK5YuJoIcQfbew7l85zQKudyUCuA3QB1+Ktdiv+xw2l/GNgjPPisodF7GnModptzPswiNaG+SmlmF6kFKZTPiYTAMAjgTE536kdgeywXQJ/ypSsjj4KbdivCZnf3EbaLjUv0nZ7wxsxA1lakc1sah3lx5rM2FIptwjD4uc4BV/QLVWJTMiW32tkKBJCmHSR/oHOKDI/e7Cc38Suv4HWAuoSt22a3jxEsEhl32RPoaLIu1HhgDtp6YauNY6KA=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB4188.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(26005)(186003)(83380400001)(66556008)(6506007)(38100700002)(6512007)(6486002)(2616005)(31686004)(66476007)(8936002)(86362001)(66946007)(508600001)(2906002)(5660300002)(4744005)(31696002)(6666004)(6916009)(4326008)(316002)(36756003)(53546011)(8676002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NDFOQUd5Y3dsTmNreDV0bXZ6ZW1OdDFZeTVXSUlzc0ZtdEtrQmdjQ09tZ1d1?=
 =?utf-8?B?ZjE4Tlp2R0k4ai9MU2hPcERoRklYNGpQUmZMbXRhYjZGNEI1N2VRdXI0b0V6?=
 =?utf-8?B?dzhaQnZQMGx2MmFncHVhNWdtV0h2c2tWUUZwUEJwaXA4dkw0eVI1M1NGVXhR?=
 =?utf-8?B?d2ozQjMwRTJXVWZxYkFNVy9Jd3o1R3NxcVk1VmI3MkJQaXQxUStvckhnWVJa?=
 =?utf-8?B?dHBUUGNud3BzM3RyNVA0bHVCMEhWTnMvWkh0Z2RtRTZTOEZqT3lUc2FwY01u?=
 =?utf-8?B?V0xpRUpQVE84S2pEeDFMRUQrQjFVVUtrSXVGbEZhUFJpYk1HaFl4aE5Oekg0?=
 =?utf-8?B?QzVzZEZuYS8zQ05ZY1FKcHQ2YXBPUVptMndXVHFqVkJVTmJ2R2hjK0J4Tzdl?=
 =?utf-8?B?YTFlNjRwU2UrS3NteG5hSVo2MGQ1VGUxSWVKLzdiczBMREQyU1RLbkw4UFUr?=
 =?utf-8?B?WTB3N0gxWHVOQ1dJYjczQ1lnRWhyS1RMM1MvY2pYZHNVZVlRd3VlMkZCVGNi?=
 =?utf-8?B?c2lnM0JnYWJIU2w5OUhqUHpPK3EvYTAxWmoxSnJQenhrbHVJd1p1WDBYbHhn?=
 =?utf-8?B?U0k1MnRoS0lyaTRhcDY0UDJoMjJEdGFwYStETnYwK1BzU05TeC9reWdJclFJ?=
 =?utf-8?B?aUI2K0lFSytiY2RUeWxwbDJ0YThCL0Q0TGduZ1kwUFVxUVRWY3VWajVYQWFL?=
 =?utf-8?B?bWI2dHJ4RlhxcHdHUWo2SE1hTlR0bE84NFBrZGtSR3lGc0Irb2tOUktxc1Y0?=
 =?utf-8?B?RlI4ZkJjUjVaUnBlMGhBTksrVTRmbUFhcGJ4MVh6WUpZeUpzT1VCT1B2Wlcx?=
 =?utf-8?B?ZWZaaFhWY1UyblZjb0VUTWpsVDJheEFxQ0l4cTRvV2t5dXdyS3pRMWdMRDNF?=
 =?utf-8?B?VEhkOXBCc216Z3UzSUhVbmJMM1VFRGtBY3VZZzdlRi9sVHZ0NjJyM2diSkUz?=
 =?utf-8?B?TTBCclN0c0poV2Z1MU44U245SE9YUWRRQ3REVnFNSC9QOE0wblZybUVWcHVS?=
 =?utf-8?B?KzJYT2ZabHo5dWE0eUlOZ0RKWXMwRk04RXBhcUlPMiswc0Qzem5kR0dWempj?=
 =?utf-8?B?T3c1WXFzVkVRNkxLdnhIQ0tCZ3M1U2VBLzJpcWYzd0dTL2MxNTVqcTJFN211?=
 =?utf-8?B?N2dwQU1tdldqNHgzUStYeFFUMEN2WUdwY0M2YVo3anJBd0xyVjZiOW16cmZP?=
 =?utf-8?B?a3pVS2JHL01mVUNTZ3hCM0NxMlpiTHNwYTFVd1Nza1BrdGFFWUZuZ0N2ak41?=
 =?utf-8?B?N2kyWjI1RStqU1AwRkE1RktYR2gvK0UzOFBVQmcyTU9FNjdOR0RKUk5Ta1BD?=
 =?utf-8?B?T3BJTVNTaGpzZ2lJbDVPd1JKWW14QjZqT3NHdUFzSGpaMWhVc0hPeWhWNUpa?=
 =?utf-8?B?ajFnejE3NUlEUG13ci9yWUd2SHJycStpTUMvOGdudmpmN2tlRVNaZnFTb1Vl?=
 =?utf-8?B?NHd0NVFCSFU3VkJQU09YVmpWc1VIWlIxREZkSDd4S1FoSml1aHZvVDV4Ulkx?=
 =?utf-8?B?VGtCZGZ5UGVlOWptR3RyaUt1ekhTYTZKK2FZbGkwNTdBUGsrc0ZKcTMwSUh1?=
 =?utf-8?B?R291MmRTMDZGR3FQeDRybDdSQ0IrMlZId2hFTmI2QVhpOUZidHZwdDJDYnhL?=
 =?utf-8?B?U3RZbS9tcHQ3NWpSU2lTVDdySllpTGYyblc5UzBhT0F0MnppS3c5WElJWGR2?=
 =?utf-8?B?QTdIVnBHN2YrUzk3ejY3Wk4rdkJhQVhrSHUxWjlNaDQwZUdHdjVUSmVpNHZC?=
 =?utf-8?B?VnRKaEwwTkhIaE1ycE1GeVRLaGhBYWtVZEFrM1ZlVDJqQkVZckdwU3dBZU5V?=
 =?utf-8?B?bzNEOVp0UGRoRXRSZG13ZTI3bXN4VU50VnJOSGk4TnlUUjZNa1ljNWhjdmlm?=
 =?utf-8?B?MnpBV3dnY0tOUG1lYTBHcU52eGd3U2hMUnViWG5IWUZWNStWNzlHVm9PZm91?=
 =?utf-8?B?VGVmTFpKL0JndGtWMVJLeTBDelV2OTFBdzZIc1B2cTBXMXpNUHBtdG9OdEhL?=
 =?utf-8?B?SDdheHVKTFRUd0E2QmozRHpOem5aeXRUNHR4MGFpU0NsYW52aU1tbmY1UGhH?=
 =?utf-8?B?NHdub2llNlY3UVpQYVpkcTRpb1krTGVQZkplelMzVzM5YkNkZzNjRGhBeVdl?=
 =?utf-8?Q?m0FI=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 01fe5e8a-7a4f-4797-c9d9-08d9c04cea84
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4188.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Dec 2021 04:31:23.8003
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wLnydg4H7WPe5FgG3adWFMYiOCTkKqXLacxUH48FfMk6B1CDH4bTP3ifa45wRt5z
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4281
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Greg
On 12/16/2021 4:08 AM, Greg KH wrote:
> On Wed, Dec 15, 2021 at 03:02:16PM +0530, Nehal Bakulchandra Shah wrote:
>> AMD's Yellow Carp platform has few more XHCI controllers,
>> enable the runtime power management support for the same.
>>
>> Signed-off-by: Nehal Bakulchandra Shah <Nehal-Bakulchandra.shah@amd.com>
>> ---
>>   drivers/usb/host/xhci-pci.c | 6 +++++-
>>   1 file changed, 5 insertions(+), 1 deletion(-)
> 
> Mathias, I can take this now, no need to add it to your queue.
> 
> thanks,
> 
> greg k-h
> 

Thanks
Nehal
