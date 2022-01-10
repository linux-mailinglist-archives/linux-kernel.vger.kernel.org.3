Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 46DD7489FBA
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jan 2022 19:58:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242778AbiAJS6N (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jan 2022 13:58:13 -0500
Received: from mga07.intel.com ([134.134.136.100]:19965 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S240453AbiAJS6L (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jan 2022 13:58:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1641841091; x=1673377091;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=wq23F3jcXVbRrVTrgbIEhRuy1/ooKJ9LktE1hvRpHyQ=;
  b=defIzemrI4iZd9bYHVouyjXGRn7573BSlbkgvJOEmGTL3WyhjveCc07y
   FKKWLBOmhV6JnSarHkaCN2WhKdW6daPClaRr+yFhW932kGX6MiJZuNx3C
   ZeorpPwaSu9BfqFyFWhjv/Sis+O5sVYK5WMV3oNJDzwIO+h/5NW46SFNf
   phSGl81PMFV6e8H5L43yZQRtCXjuqIeCz6q2qtqRulUUtSEfE6kkhX631
   BfruhOAGMcrkjgGZDXEhutgyOV0qr8hwz50IA2jkMo73gr+eNw2YWhFqP
   4Py3S0bUd+211/NKAlqMzn1z/TVoutl6+BPY6uEKD2F8Od2kxjYFUEIaH
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10223"; a="306653932"
X-IronPort-AV: E=Sophos;i="5.88,277,1635231600"; 
   d="scan'208";a="306653932"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jan 2022 10:58:11 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,277,1635231600"; 
   d="scan'208";a="528391363"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orsmga008.jf.intel.com with ESMTP; 10 Jan 2022 10:58:11 -0800
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Mon, 10 Jan 2022 10:58:10 -0800
Received: from orsmsx609.amr.corp.intel.com (10.22.229.22) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Mon, 10 Jan 2022 10:58:10 -0800
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx609.amr.corp.intel.com (10.22.229.22) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20 via Frontend Transport; Mon, 10 Jan 2022 10:58:10 -0800
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.174)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.20; Mon, 10 Jan 2022 10:58:09 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LgsE47LTidmXHjAG2nX0tXRDRfcznQORFsQ4WsscNdeZVPjeEw0gVTp7cyuek2qfqpgJ1/cwuoDXHCtF0ouqhW4mwIhuKWEQZiQSsn9M5wWGSiBbilpbc/L+0NNeRTzC+gty4wqj1SHZTZ6ovKZJbFSUOQzjxyJxOo0YKlPwnQodmYs/n6t4wv2edIplJddZr4/uQXizyajx+DukEb1IjnyLgXXk1PDtHg7pTaDUYVGtN8kzGHBNpShXlb59WwpWOKbtAKtoUlJ/LmYR5AODIqqoznCZGsp9ReSBaVkixLU5WBxT0usg4NEUORbjxP7MzlR2Yn0w2VCAsYflk74OJw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+YTVmCOkGoiy1lHoxyWYPhnrBqNjFfot7sxkR1CA0Ok=;
 b=V+MCt9WT8WT08YnV96YlTQrjZfPsUGtvvqL5numL4ReEH4paQJuCF1fAMap9I/Vlsb1vziZBJsAGjR/lmqnS8/wRAphrR8GiGaK16ZTAB/acMV/9TybHLDBK6yAvbb8KW9lK11DoWnqywlEXDlx4i09lqvz2rVjMqQyuLJELHcoCgk/VEm4MViFYjnMkd80sury8vrr6uXc2z6K/d8HVtQe+mscNlnRrI81UQz8xoWXB5rnc2PIxLNNAMddoG1Y+4otAF34u6QWnEs63IxAiz3/py2MBrHNs3wFC40du5RvVgC0roACT8Vf5VWxWhBz+9KbtDLsCOLgThWbyRz5r8A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BN6PR11MB4049.namprd11.prod.outlook.com (2603:10b6:405:7f::12)
 by BN7PR11MB2657.namprd11.prod.outlook.com (2603:10b6:406:b1::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4867.11; Mon, 10 Jan
 2022 18:58:07 +0000
Received: from BN6PR11MB4049.namprd11.prod.outlook.com
 ([fe80::cce3:53d5:6124:be26]) by BN6PR11MB4049.namprd11.prod.outlook.com
 ([fe80::cce3:53d5:6124:be26%4]) with mapi id 15.20.4867.012; Mon, 10 Jan 2022
 18:58:07 +0000
Message-ID: <ae765e9d-b3dc-0047-f080-e2d059b3821a@intel.com>
Date:   Mon, 10 Jan 2022 19:58:01 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Firefox/91.0 Thunderbird/91.3.0
Subject: Re: [PATCH 1/5] ASoC: sh: rz-ssi: Drop calling rz_ssi_pio_recv()
 recursively
Content-Language: en-US
To:     Pavel Machek <pavel@denx.de>,
        "Lad, Prabhakar" <prabhakar.csengg@gmail.com>
CC:     Biju Das <biju.das.jz@bp.renesas.com>,
        Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        alsa-devel <alsa-devel@alsa-project.org>,
        LKML <linux-kernel@vger.kernel.org>
References: <20220110094711.8574-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20220110094711.8574-2-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <2f338a37-f2ca-33e4-284e-5d263f7b93da@intel.com>
 <CA+V-a8vz25B=cw_C4YMBRdDxeq7mi8Zc+noqpdHqfMP8eNHYFg@mail.gmail.com>
 <20220110184418.GE3396@duo.ucw.cz>
From:   Cezary Rojewski <cezary.rojewski@intel.com>
In-Reply-To: <20220110184418.GE3396@duo.ucw.cz>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AS9PR06CA0041.eurprd06.prod.outlook.com
 (2603:10a6:20b:463::16) To BN6PR11MB4049.namprd11.prod.outlook.com
 (2603:10b6:405:7f::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 7a5d3c97-8bb4-46ce-de31-08d9d46b2387
X-MS-TrafficTypeDiagnostic: BN7PR11MB2657:EE_
X-Microsoft-Antispam-PRVS: <BN7PR11MB2657FC95D2498FB21ECB0E7CE3509@BN7PR11MB2657.namprd11.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1148;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: pqnBwBUWlODzw+sZjkq9BU90+s2T+AhUJK3SpOfmBH8jCrmfMtlkNATP4YVZjiJt14aLdkU2CgnMTn9UhQPsuAiwGJPfTSpRnCtr04KzkqIHUBp5ZJgDretDtwIayZUAMerUi+31MhqWTReypYsIQiyEOxodd3bCMJrG9wAcSRXQKgBRpHzduIEqx3QLlg10cMP9XHTxJyJZ1RqkSIVUIMoObTSJNEr8vpVHeNBzFob4/0As1G+U4uGK900MbJYSbJnxKfvsSlkGYX8iTORatPbpoHiaF9MK8oOJ2ENzb8nztpXFBj3aJiYwsNj+FrC/jmLX6sRrmoIl/aS74jEtcGuDopvyvO4PZEq7duFaXY/8fIcRENXz7DdjcFpNzzC1bdmwiQRxWgx3BWwef1OvmVHnBbD1EN06ygHvoA6MX9b43pRv5CBfL52ZHD8w1srYYQbXFLzi7PwS0UlFVPVNzGEkWlBSdn6TWxNTP3nLE/w9WsvoDTataTBZIPxzY+Y4JY9qH4jt0dqouyRHzDAMJke1Y4f690U1ueOQaxqy6kQs9C5HyWyWcrcExQv+5OiQ4FLU1IkXGLcadANJfkOOSI5DMvXukHNz7Dxg8C4T80oydsAGk2H5eJl7NV9QjSnsY1IbQer2ZyGAIMCRDH5jkREMYXuEuxx4v+6F07JgCvL5ZcPv5bTXZzhcyLGds1Shp162rDKK8Gv3GscHvPnPons9LRztLZp4c+C1efT0xFk=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN6PR11MB4049.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(8676002)(2616005)(31686004)(2906002)(8936002)(5660300002)(38100700002)(508600001)(54906003)(83380400001)(6666004)(82960400001)(4326008)(110136005)(31696002)(86362001)(36756003)(186003)(53546011)(26005)(6506007)(316002)(6486002)(66476007)(66946007)(7416002)(66556008)(6512007)(44832011)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?V0NLYWR5bjZUbHhNU3EyVTgyZ3V0YWdnTWU4Ui81a29jRW9RMkE1V0U5cVNE?=
 =?utf-8?B?SkJkL2RsVjk3OGJTYWRYY251Z3JiMFpRMGo5Mkp3U25yUHI2NS84ekc1TXhh?=
 =?utf-8?B?QWtRNGpxK0FsMDh2RndnUVV3alhITlg2K09UZU1lZWtTa1JQS2FFaEx0Y0dL?=
 =?utf-8?B?REpQYXIyTjNaOEhDT1RsTlM2NEh3V1Y0azRvUTNhWjdndThkOW5wODYwc0RM?=
 =?utf-8?B?b2xMcWpubDVhODR5dUV1M3Q0bWxzS2NtU0kwRE5PYkZmQmxmSkd2YmhoQnRy?=
 =?utf-8?B?QWo5WmVYRnVtdUQzNEFrOHFwZG51aHBpbmZWbFBqeUV3aHVpUFBIUlFYMVlJ?=
 =?utf-8?B?UVQ4WWdoc0FjY3JoaE9JY2F0MEpXQ0M3S2lTUk9Ia0pnMHliVnFhYnNwNUE0?=
 =?utf-8?B?eWtPViszdngvQ0YrZTRvb3lSOTNDNTd2N0cwYXlPSEk1cjZuVVFXRVFoRFk3?=
 =?utf-8?B?bXVmeDlJR3V4ZXNHd2c5Z3NDOWw5cUtrTXAyNEY3Mzg5Vnl1S0wrMFV3UG0x?=
 =?utf-8?B?bjVUc3NmUUwxWWQwekZmeVBSYmFUWHhPbHl1MmJna3hRQVVMWkhCQWp2cmJn?=
 =?utf-8?B?YnF2TkJ1ekhMU0JrRXZFNzMrNWZxVm90REx2OVFNWGEyUkh5VkxIdGpua3My?=
 =?utf-8?B?blRtZnZ1RU5FcFZzOXkrVjQ5MHB5MzVybUtVRjJBQXNKZzIvaE1mMVJoUW5Z?=
 =?utf-8?B?OUxnNFo2M3BDVzNUV0hhb0JNRjQ5SGhQeVlTZ2hTTzVGT01RdHlycnQyM296?=
 =?utf-8?B?Zm56Q21HYk1iZDZpQnQ2d2FKTWpEUXUxaWRNVnVvb1F4RUVXSVY2ZmNkM1V2?=
 =?utf-8?B?bEJveVBkUm5BUlM2MUR2bzhzQlJkYzU0MGoxY3BEOENOb0JLeElaQjIwbU5q?=
 =?utf-8?B?d2hXd3lTOENDNnJZdVl5dTZheEl0cjZDSUxHTE5DSWttcklXcGlXWnZUbU0y?=
 =?utf-8?B?VGVJNDhvOEFBd2VWNjlVSnVhYndIOEhSa051VlJBMFIxZGhsVThwbytlemVO?=
 =?utf-8?B?aWVYellPNzBlekxDR05aT2Z4MElEVjNEQnBxTTYwbjlGV25ZY1hyMVkrSklh?=
 =?utf-8?B?cmVoak52MjVoWlliZlRKaGZhYm9MclplYmdBbmtXQVRRTWMwRlRiTEpvVGlT?=
 =?utf-8?B?OGRrRzIxc0FscjdONnhBQkdqL0VUdDNoTFlGVklVTWQ3Y3BLdmVwTy9ZVW9l?=
 =?utf-8?B?ZmNDc1l2aVRodmU3ZFBWcFpuTEFZOXVGZ0ZsUnZRVXhNNXRlWlNBWDVkQXov?=
 =?utf-8?B?ZlFISHk2SzJVOTFEYm9JQmZ4NG1VQjNVRVVNMDVJTWkrRzVjODl6eW1PM2E1?=
 =?utf-8?B?UHlDZFZkOHlORk9DYmY3YUkvRVk1a3g2S2NYK0doZUN0TlJtUS9GMmh0Y09t?=
 =?utf-8?B?SXFoRjRqWUtvaEdocjVPUGdDUC82UXZrOVp2bXlURXdXVW44bjhPL21PUUJv?=
 =?utf-8?B?bTFyNUpScHRJdGQxdUNoeTJnRndZa1NjL1pGa3NLS2VNUFVFaGgyYmt6VjJH?=
 =?utf-8?B?bUVZSC8xY0l0Y3o4dWs4akcyR3dZd1dIcWhPZDgvS3h2d0Z6eEhad2FwbmlT?=
 =?utf-8?B?blVoYVlKcW9MenhHMkp4Z05hTEhhYUtXZEFpcTBHR0N2eVkva09DTlRPQ1M2?=
 =?utf-8?B?cFJid0NabE80NkUzWSsvdzV2NHgvcjViTVl2cklTb01IQXpKN0xBRmF5aGd2?=
 =?utf-8?B?cEUyNEpGT2ZwVCtvQ0JXWFRFYTkySWdMSHp5eGRUUUx3STZUZk1idndFbW4y?=
 =?utf-8?B?anFjbkd1MnliaXVINUF6ZlBucW10SlE4VndIQU5WTTVmNy83c3pjdHhLc01z?=
 =?utf-8?B?S2cvdkdSTXNhb25VTk5GL2U0Wk14KzlVN3V5ZDUxUUxyamNDVVhBRUNoWDVH?=
 =?utf-8?B?M3RqeDBoYUpRWi9GQkNNN2VrSStuN3hTWldteWx5OGNyUkJ2bm9valpmN3Uy?=
 =?utf-8?B?WGNIenJqUHc4RjVJOGFpOEVjRFVIWUM5MlA5WXFCNktoaTJVQWZUblR2S3ZI?=
 =?utf-8?B?NU1Ydk4vUUpyYkl2YzFFSTM3ZXA3OEZjZm1YbzhRMVVibS93ZVJJYks1U3Ez?=
 =?utf-8?B?RWNPNjZtSHl2YWlEN3hMUVJxd1hKSlFLQlFvMTNLMEFXbkVvbDB1SXJkcThD?=
 =?utf-8?B?VUtnSDdON1cxbFNzcnJqVm9IQnRXQy9qOGI3Z0J6SjNMWW1zbXpkVDNvZUMr?=
 =?utf-8?B?ZjlKS2E1V0xITFQrNTZvOVdpNkNpeVV0djFKbXRGbFUyeXRreVhwQTdLVEtw?=
 =?utf-8?B?RW1YUjg0NFUrNmJhOEUxSGw5OFh3PT0=?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 7a5d3c97-8bb4-46ce-de31-08d9d46b2387
X-MS-Exchange-CrossTenant-AuthSource: BN6PR11MB4049.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jan 2022 18:58:07.5430
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3uM5PiTMlyURWM5HcjTe3FgJqAub0q13AO/k03noaAOgj1QDI/K6Bqv6gtgvphiRvxx9BZpHEmOjKhA0BUhljq5xXjfPm0Q+JWDcjfqYiwA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN7PR11MB2657
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022-01-10 7:44 PM, Pavel Machek wrote:
> Hi!
> 
>>> On 2022-01-10 10:47 AM, Lad Prabhakar wrote:
>>>> Instead of recursively calling rz_ssi_pio_recv() use a while loop
>>>> to read the samples from RX fifo.
>>>
>>> Recursion and loops are means for doing something repeatedly. Could you
>>> specify _why_ such change was made i.e. the conversion from one method
>>> into the other? I bet the code is not being changed for the sake of
>>> changing it, the reason is simply missing in the commit message.
>>>
>> I had feedback from Pavel "recursion is unwelcome in kernel due to
>> limited stack use." which I did agree with as a result I have come up
>> with this patch. Also to add this driver will later be used on Renesas
>> RZ/A2 SoC's which runs with limited memory.

...

> 
> Yes, loop is better.
> 
> I'd actually do while(true) and avoid using the done variable.
> 
>      if (!(!frames_left && fifo_samples >= runtime->channels))
>                break;
> 
> will do the trick. Better yet, do
> 
>      if (frames_left || fifo_samples < runtime->channels)
>                break;
> 
> because double negation is quite confusing and looks like typo.

You could achieve similar results by enlisting do-while loop. That's my 
proposal.


Regards,
Czarek
