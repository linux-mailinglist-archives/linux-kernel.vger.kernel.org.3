Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C111856C823
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Jul 2022 10:48:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229534AbiGIIqH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 9 Jul 2022 04:46:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229469AbiGIIqF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Jul 2022 04:46:05 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A8A24E606
        for <linux-kernel@vger.kernel.org>; Sat,  9 Jul 2022 01:46:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1657356363; x=1688892363;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=Lp4q9RcQ55HqjoyiBV+GsIBJzFmQt5Els5GI9tCSSds=;
  b=gSRn+sKG7uS/yJ5/9TGhBJuql/PFTQjJ/qt1MjJyixrIEriyey2Ow/cd
   Kzs0gNdFI/bquTneW4t4ICDDPFdGHRwCPMuJdXHhD02nidbnDib9s8SCM
   V4RlZ2syToH0bE2tGVg1X+djF8QpeuqeQBNDcUUi6pAyEaOGr5Nxu0/4Q
   YTAaiyVvyP3fXcQQc0eGw5ocH7ZRM49e/Rp+xnwf8Ss193mBZHQ99R7+4
   ver0FZNVcSQH+90QSGxWF4ob+YDR+MBf8TEVhKQprTFnOUhZ6Le2H9iCp
   wcSDtw/xyAXE809dxfz9gnCVlnayqEbNc8K+lTQ5FllUMvvX6rq9npYE7
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10402"; a="264197611"
X-IronPort-AV: E=Sophos;i="5.92,258,1650956400"; 
   d="scan'208";a="264197611"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jul 2022 01:46:02 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,258,1650956400"; 
   d="scan'208";a="651849067"
Received: from orsmsx605.amr.corp.intel.com ([10.22.229.18])
  by fmsmga008.fm.intel.com with ESMTP; 09 Jul 2022 01:46:02 -0700
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX605.amr.corp.intel.com (10.22.229.18) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27; Sat, 9 Jul 2022 01:46:01 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27 via Frontend Transport; Sat, 9 Jul 2022 01:46:01 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.101)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.27; Sat, 9 Jul 2022 01:46:01 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RaWT9Xw1AOm4rhO+/KyAGGMnAF72WfR9AhPRBKlgBdjzQbwzXMOVeyaj8gSrXdnymP2/mkrZr7ilBc9Fz9ncteTVzUlQtWJFmywtTBIrmVZX85TPjp8NgPu2oik21SVxydSlz2elrJfqV38mkUNYPXNC9fsRjt87z33RWEghPWhmh4/clCOa8g/bf4v6Gfd2lZgfzfngVhqUm9zHUWFPFlEqtyXn+DXCMjP7TNM/ZNqdhAqL+XZvayyUEmTVtqcefYn64tPtkgsgUN8jHkORS8cN9BPrXyLmR7mQIlrV3EEMlLhsS8lWZHfCM0WpYdWHW5rky1FNxUYilu/FxAdQYA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EoH5w1YeMAnJ+6OEtJ9nZpshgpfRg++4hv0m5QwXhWA=;
 b=ijUqFrk7ye/zAmkSSvDIfcM09Jc8P1WfIRTnpn+OXJaRo+PqM4nzfvBbDaLk9ToUtDVtaW4/kzfbFJUaKNxpqBcaA35oVKvcKPIvnnOHLCkQhzQNi8ld8g+qy3lXhlT4ZOIsO9WMXt5P9jftyX9GHufpGbAspNWtA5uGOXuR8d0vQXIG8ih8G20zgROjxmpeaFWUK2HXYffAgVNqvP9ymAe0RuU/Zl1oHsziS9a7S3TBcjGJad2QVIAow8SgI5PWT8tIgDmcLH0TIo1HZbMmvbHj7ZXkdDILq7IRFvl3BbWu9bJKcR3G6LJSD3qBh44Yst1FFRbs6KzLSsNXQM0xQA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB6375.namprd11.prod.outlook.com (2603:10b6:8:c9::21) by
 CO1PR11MB4820.namprd11.prod.outlook.com (2603:10b6:303:6f::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5417.21; Sat, 9 Jul 2022 08:46:00 +0000
Received: from DS0PR11MB6375.namprd11.prod.outlook.com
 ([fe80::8b5:ae20:1c12:421b]) by DS0PR11MB6375.namprd11.prod.outlook.com
 ([fe80::8b5:ae20:1c12:421b%7]) with mapi id 15.20.5417.020; Sat, 9 Jul 2022
 08:45:59 +0000
Message-ID: <c19ed4a6-6a96-b4a4-0f5a-7ca1dba925d1@intel.com>
Date:   Sat, 9 Jul 2022 10:45:49 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Firefox/91.0 Thunderbird/91.11.0
Subject: Re: [PATCH 1/2] lib/string_helpers: Introduce strsplit_u32()
Content-Language: en-US
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
CC:     =?UTF-8?Q?P=c3=a9ter_Ujfalusi?= <peter.ujfalusi@linux.intel.com>,
        "Andy Shevchenko" <andy@kernel.org>,
        Mark Brown <broonie@kernel.org>,
        "ALSA Development Mailing List" <alsa-devel@alsa-project.org>,
        Takashi Iwai <tiwai@suse.com>,
        Jaroslav Kysela <perex@perex.cz>,
        <amadeuszx.slawinski@linux.intel.com>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Ranjani Sridharan <ranjani.sridharan@linux.intel.com>,
        "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        "Kai Vehmanen" <kai.vehmanen@linux.intel.com>,
        Bard Liao <yung-chuan.liao@linux.intel.com>
References: <20220707091301.1282291-1-cezary.rojewski@intel.com>
 <CAHp75VceKBoxXVPP4dRYb8LQqHMMDHFp6-E2iuZ-h2RTK8PWQQ@mail.gmail.com>
 <e0c7d254-ace3-625c-cc83-52ca0b45e9fc@intel.com>
 <CAHp75VckU2ZraLJ-frjWXjUu9pFW+-XmWgTbYqUXOUNAD-1HGA@mail.gmail.com>
 <6c8e4104-2239-a188-649d-585f059cabdd@intel.com>
 <YsgjdKEtE7pMDTnZ@smile.fi.intel.com>
 <a73b3ec0-5abb-ddfd-414b-b9807f05413e@linux.intel.com>
 <CAHp75Vd4D0KF7ik+aMOwv-+bofWja_tDe4YUmihQBF+RiHZTmA@mail.gmail.com>
 <e2fe6351-f9ee-48eb-ad7f-280249f7f3f7@intel.com>
 <CAHp75VfvN-iJTpgg6JeKhOqJLhtYSieo7d7SOCBoUu-81FtSqg@mail.gmail.com>
From:   Cezary Rojewski <cezary.rojewski@intel.com>
In-Reply-To: <CAHp75VfvN-iJTpgg6JeKhOqJLhtYSieo7d7SOCBoUu-81FtSqg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR0P281CA0107.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a8::20) To DS0PR11MB6375.namprd11.prod.outlook.com
 (2603:10b6:8:c9::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 8ab20c4e-f651-46af-a274-08da61877283
X-MS-TrafficTypeDiagnostic: CO1PR11MB4820:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: a0HAaXpTT13nwp9Hpiy28aPaEaENT3x6mC6DJex7/2w1DIQJdUMk/2A+m+PV9FB/LHz+1NTFuZlE3ZDusTom3nxNM+eTunGFla7yrPVDSsSbllcEtjKuEkSpI4E9enF1uOGiC86gEtI3V02TL6Cns5QH1dsQHv4NI0l10BkwE3fPuoqWYWdd40bbu8xLdXAAH8yJVs9paPUjGUtQaHO/pUXOeC+GOC7dHAX0jRW20oT23N87+BcwQH1nycNfGsDru65c/iPQ4rFlcNmKyxvGVrABy8Be6wqkRPyRgU5DfbLgyyKujKG5BghV/wcAbqRDaJWBly5bHO7pHPqpXKLqHrnyiD3ZEeupAB32MgQYN2MV4wCPv1AC4uA/xfXhsPMio78LNjHyDBI4nIZ2CE+874yMJ86eO/oCqG3aPcB8mZAR1pM8h1i/8r/pXQn8XBvIDsRxE6eLftwG0nDEkYI+EsG2uY841qxzTB4c+9K8GxshnIuCKit1GEQprYrWHJ8vyLuSEDLrZ8LjNV8BxbzUUyv2tMyVM4qoeIQ9qS+FwumJ8iF2C1fNA4vyxgbVoPgyY9peCdqyTOQZYfVOydVTRoojEFM7OU+vNZugWXn5Hq2/TbLirBTm/Kx2b0s+2jbExF2WumM54oIY34K398pZL3L7jyGP6UeNaIHrD53IwHwIJHkEFZHpAc8xNrgDFAZL/H1H0iqDn6V5biE8xK3Bf9KmkfY1y/7VBoLY2dr/YVPq8l0Rbg5E5guqISbY1FIVnQ9EHprmnbRDrHh66XlLJzNJInFfhZTaVHAXnGhYLHu6GrWt5rJZwHiVCAcvCb+7K8MU0NIDtb3UMzM284C3R/9eEwVHwcf2I5ZVPopm2TU=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB6375.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(39860400002)(396003)(346002)(366004)(136003)(376002)(6666004)(82960400001)(31686004)(41300700001)(5660300002)(8936002)(53546011)(36756003)(6506007)(26005)(2906002)(6512007)(7416002)(44832011)(38100700002)(478600001)(6916009)(54906003)(6486002)(2616005)(186003)(316002)(31696002)(86362001)(66556008)(66476007)(8676002)(4326008)(66946007)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?eFVHTkhVNXNXSE9OV0hkcEUrcFpKQ05tOEpCRXBadmRqbi9oUUNOUHk5Nitr?=
 =?utf-8?B?eTFQdmgreGs5aWZYWHJHb1VPZlRpKy90a0VvSCtqMnlYTGJySjE5S2kyenpR?=
 =?utf-8?B?SCt6UWc2ZStOVFBweVZYTDNZNUFVdW0vTUlPazFoUkdwR3JvckFQVU9qT1Rw?=
 =?utf-8?B?U1R5NE4zYXB2MlBjdjgvc3E1VitpempwT1FFekFEMUpuSHpMeXlWRVhOSjVV?=
 =?utf-8?B?UGR0Y1Fwc2JVWjc4YW45TWI4amZOT25Sekx0eGs2TFRUNDdPMTRQbkMvNzBI?=
 =?utf-8?B?VXFCckF3SzNtNjFZQ1J5UlZLMWVhZTg1UTJoWHorUkFOSkl3OW5RR1JTMERG?=
 =?utf-8?B?Q0k1K1pUM09FNEFuUlY0WjV2M1RCNXBZTUhpdXd6UWlFeCtqVjNjM2hXSEtH?=
 =?utf-8?B?RVZEbk13VzRBeVdKVCtjTkNxOFdsQmVvbStxZDdOUm1mTG1MRDNtK1Vmdkh6?=
 =?utf-8?B?RVRZdTlEYUU3a2E3Q1dtRkxrdHN6SVhZaDdCY2s0dVBzMXBoMzVLNzM2Tmln?=
 =?utf-8?B?T2wwWk15QTlxUFdIam9PNTFhbUlCN1BGMU82SytrRXFtc0tEZ0hOQ3ljSHFr?=
 =?utf-8?B?WWEzSTMzUHBNK2JiZmRxakVxRDBWTThzWFlaZGloNzBwK2ZqWkR1MWs1ZjRV?=
 =?utf-8?B?clJzQ2h1TTVuWGlCaTRYRE1tUXVhVU5GUWJmZS9nc1NsMHVHSDhiMitMcGR6?=
 =?utf-8?B?cjduclNvcFJOY2NlQTJSOE5MRS83N3NHU2s2ZUZieWh2RzZNaG55aTB5bmE5?=
 =?utf-8?B?bFc1bFR6QmVPTTVzSFJNcE4yc1ZwOHVMQzBqQ3Z1UEszdkhLZ3plNGQyc0pZ?=
 =?utf-8?B?K29KN0l6TGdLNEI4MFBHdjhzcE5CWUk2VE50ZVFNemdQcmR3ajhjVzRyTC9F?=
 =?utf-8?B?Mm12SHRXTGlXMUxScGIyYlNYMUVDTFRseHo2MnAwUGRZZ1A4Nkh1emx1aGhX?=
 =?utf-8?B?TW1EajlJdFhzOTY2azR2YWtTSmVlTDhSYllkbm1VUDNJb0gvRStRcXdRaUs2?=
 =?utf-8?B?Sm1Yb1ZYSUZJQUoyaEtHanNqZ09oTlA5U0tpemRFRnhqbjRPdXRjQ2xrUnR2?=
 =?utf-8?B?eGFsSkJVSGdoNlJNbnY4YTlWK1c4ZmJrZ3dTeFhERDNPZGtwVkFIb2VHYVhm?=
 =?utf-8?B?bHE1S1RtZ01tajdSejkxRjV6ZVZkandyQkdqTE5xODAvamx2TVVQbHVmdGUy?=
 =?utf-8?B?Yndmd3dGcnVXTTVEWWZDNmtzMXNKN2c3YW1TOGdMSGIzZDhscFltNnpWcjFm?=
 =?utf-8?B?SjRxRkFGbmdVNUNGNFhGbGlFNktNVFU5cjB0MEViYlhhODBlTE5YQUFxVU0w?=
 =?utf-8?B?Z0ZpRnZLYjlzbmtzVit4aXEzNVFhaEp0czhHS096Q09KQVFDVmhESzVDMXBR?=
 =?utf-8?B?TU4wR01DYVd6R0wwZWFwZnQ1T1hZSUg2K3lRYkVtLyt1TDhsZWh2V1BRUmNO?=
 =?utf-8?B?VGlNS1BaSHlMTVNzUUNiUk8zVCtQVmxSTHEzZVJCayt2YWFPaGxJeEpyTCtr?=
 =?utf-8?B?MkcrUHVvQ1pVV1haMXVQREFXbEU3Y20yMzR3MnFqQ3JvZnZHRFduTEJmSFBZ?=
 =?utf-8?B?UWhvN2tZSHg5cCsweWJpUVluaDl3T3htWG9iNG5TaEVhYTlqdE96WktBQWJl?=
 =?utf-8?B?S28zQ21kTFkxdjhQS3FENjEyQnpWOXcwb1N6eHlLTldWMDZ1MlJ4NVhDdks0?=
 =?utf-8?B?OEViOTVmYTI3amIvRzBRUTZINXB3REMrdVE1a0p4dXlvSTBNbDhNblY0YWpq?=
 =?utf-8?B?U0VQMlMwRGVjaFNJZ3ZYRXBWWU1XWjVxZjhSSmZGNjY1L3NmUjJkZzJmZith?=
 =?utf-8?B?UHB4dHVRbzlSRXVYcEZINFg1WnJnaVh5ZzRveDVpRHRyVjErSlgzeXJtUUp6?=
 =?utf-8?B?WlNGMldiL3U1amw3TzdoczRwdUt5ckRwZitOK1lxTnFNbThkZWxqR3ZkSGd6?=
 =?utf-8?B?bnBnMG16WEl5SkJ6M2R3b2ZhQ0E1bUxOQ2dCT0hIa1BpTmxkOEpvNjZ1ajdl?=
 =?utf-8?B?S25iSHRJV2U1UWJZNjNZeU5EdERuSWFncHBpdnNEbXFVOTFLUFBsM3JVampv?=
 =?utf-8?B?TVBibzhFQWtKWERMeHFReFN0UkR2MjdZMVQ5US9tU0pCenRzc0ZzWlo1RHhr?=
 =?utf-8?B?ZDE0VXNLYXZSM0M1ZHgzTlpRVkMrZCs4Z2dVQlJsdVhXMU9WWUJrTTlOaDFv?=
 =?utf-8?B?cFE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 8ab20c4e-f651-46af-a274-08da61877283
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB6375.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jul 2022 08:45:59.7929
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: j71mHH5ifZlZjTfOcsDrN/JNC0dhNVgpq4U7D4eeuIuktQC9Xt/Mv5NSeFqqdJzOY+KSCpeXm5kvp7RBxIrRr2gx2iybn3OY1DIwIOKzcNc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR11MB4820
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-5.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022-07-08 6:49 PM, Andy Shevchenko wrote:
> On Fri, Jul 8, 2022 at 6:32 PM Cezary Rojewski
> <cezary.rojewski@intel.com> wrote:
>>
>> On 2022-07-08 5:25 PM, Andy Shevchenko wrote:
>>> On Fri, Jul 8, 2022 at 2:34 PM Péter Ujfalusi
>>> <peter.ujfalusi@linux.intel.com> wrote:
> 
>> A long shot, but what if we were to modify get_options() so it takes
>> additional element-size parameter instead?
> 
> But why? int / unsigned int, u32 / s32  are all compatible in the current cases.

I'd like to avoid any additional operations, so that the retrieved 
payload can be provided to the IPC handler directly. The IPC handlers 
for AudioDSP drivers are expecting payload in u32s.

// u32 **tkns, size_t *num_tkns as foo() arguments
// u32 *ints, int nints as locals

	get_options(buf, 0, &nints);
	if (!nints) {
		ret = -ENOENT;
		goto free_buf;
	}

	ints = kcalloc(nints + 1, sizeof(*ints), GFP_KERNEL);
	if (!ints) {
		ret = -ENOMEM;
		goto free_buf;
	}

	get_num_options(buf, nints + 1, ints, sizeof(*ints));

	*tkns = ints;
	*num_tkns = nints;

No additional operations in between. The intermediate IPC handler can 
later refer to the actual payload via &tkns[1] before passing it to the 
generic one.

Casting int array into u32 array does not feel right, or perhaps I'm 
missing something like in the doc case.


Regards,
Czarek
