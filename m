Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8C7EC487061
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jan 2022 03:30:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345128AbiAGCaj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Jan 2022 21:30:39 -0500
Received: from mga06.intel.com ([134.134.136.31]:48532 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1344503AbiAGCai (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jan 2022 21:30:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1641522638; x=1673058638;
  h=message-id:date:subject:references:to:cc:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=Ofje+IF9PA0F5eQ3vTbJwRRC2TtkLrypHzMSKncPATY=;
  b=nsgGTWUQwfrxNZpWoR0qE14+o59ZS/VXGse38q8/Xr9XEK4RgrodoF8t
   Gsj4Qs8ZBdad9+AzCXcZWvNqZnC1Kf1drNVrO4KSFKPDqiALv8TX7/06d
   iRayRxJjAZylpelahQR6g28T0RR4/2RIa/BR9fftAGULlqPR/XLi3OwNj
   AgVxAG2NUHFSWpDBIDuQ2B6eVVAiivAsIzYJDMk1nCH1v/DHUJ8WrYcrC
   Ek3SLuUHUVN7E8Bz82LMnYje1Vbt7BnXTlnK2+J69GzOjv7p9W361FneC
   Q2m75n9L104TmQ8de7tF4eb87bIhkMEgaAU0ZWxdpu/CWYIarp8Jc2mIE
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10219"; a="303539909"
X-IronPort-AV: E=Sophos;i="5.88,268,1635231600"; 
   d="scan'208";a="303539909"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jan 2022 18:30:38 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,268,1635231600"; 
   d="scan'208";a="621743790"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orsmga004.jf.intel.com with ESMTP; 06 Jan 2022 18:30:38 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Thu, 6 Jan 2022 18:30:37 -0800
Received: from fmsmsx604.amr.corp.intel.com (10.18.126.84) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Thu, 6 Jan 2022 18:30:37 -0800
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx604.amr.corp.intel.com (10.18.126.84) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20 via Frontend Transport; Thu, 6 Jan 2022 18:30:37 -0800
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (104.47.74.45) by
 edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.20; Thu, 6 Jan 2022 18:30:37 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=j2PJqjKofME6SciXZbMq9LjjG4unEqtFOa2UTF+ln7UlEQFgdAEeni8SVY3RmXXtxATUS42CdO1G7sw1g0TTU0BfoStwdeFaMwEn7uspcaE18q/p0QxdNK0iYA8tQjJK2P6mQyjrFUD1heNVHJOcPumGxJ8AyJ3wMo0iHr5v48+TtNU/RfsW+KVkeJfFL1gdbDJ6aOO2GKFmxWd7/nWHPA0/isVZyCHihyh3XDXd/5Ant/6eeQlNPDL45knQdyuy1bFS6ZdsVn1Jqzdxpg3jK9hZ5dRGKWTUCmgHIp/JMVWTZWi9JU3wig/3+SZgrmkRO5M7tTvQ/Zhn5zOPsVp5bg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fwHuQNHRQQYmdYoOnofTsAwOj2ahzo9iDdtYv/Bqog4=;
 b=lHfZBLR6/3fkWNWDgT9h1j7PB2q8Cl/Z5pdQ9w46SKdqUABrFYnyto8ZoIBD5PiKbSBcuYY/5rpRAzkNy0OiI7312fAevandQ+QOg9iazamRZMoX8jm9FI0lowMVHaDDqT1d30Ye803PNnIMrbWCBhi40FCaIiMRYe4PQ1Av1l4G2aobbxmUbqsn8FlKeQj08Z8SQXn7WRZss/4TgIL5A7JcXKlxNlVGW9OXYaWhpK5KFzNKB+QEADs/yFWoSgH7Lk/WhceUnNoD4qQDmA4P0D3tV6ThHWzLyeE8paGBtilyONqUj6oP3CNX+cPYAet7oTksT5+fQ7TQ/BpWtdfhaA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ0PR11MB5598.namprd11.prod.outlook.com (2603:10b6:a03:304::12)
 by SJ0PR11MB5598.namprd11.prod.outlook.com (2603:10b6:a03:304::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4844.14; Fri, 7 Jan
 2022 02:30:35 +0000
Received: from SJ0PR11MB5598.namprd11.prod.outlook.com
 ([fe80::741a:c47f:a4:bff5]) by SJ0PR11MB5598.namprd11.prod.outlook.com
 ([fe80::741a:c47f:a4:bff5%6]) with mapi id 15.20.4844.017; Fri, 7 Jan 2022
 02:30:35 +0000
Message-ID: <d051ea77-5f63-5c79-6a14-9052b22399d4@intel.com>
Date:   Fri, 7 Jan 2022 10:30:29 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Firefox/91.0 Thunderbird/91.4.1
Subject: drivers/net/amt.c:580:3: warning: Non-boolean value returned from
 function returning bool [returnNonBoolInBooleanFunction]
References: <202201041659.XKg3OOUG-lkp@intel.com>
Content-Language: en-US
To:     Taehee Yoo <ap420073@gmail.com>
CC:     <kbuild-all@lists.01.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
From:   kernel test robot <yujie.liu@intel.com>
In-Reply-To: <202201041659.XKg3OOUG-lkp@intel.com>
X-Forwarded-Message-Id: <202201041659.XKg3OOUG-lkp@intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: HK2PR04CA0063.apcprd04.prod.outlook.com
 (2603:1096:202:14::31) To SJ0PR11MB5598.namprd11.prod.outlook.com
 (2603:10b6:a03:304::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 6333ea58-f6d5-43fa-1b5f-08d9d185af3e
X-MS-TrafficTypeDiagnostic: SJ0PR11MB5598:EE_
X-Microsoft-Antispam-PRVS: <SJ0PR11MB559875AC13BA439663EAEE3EFB4D9@SJ0PR11MB5598.namprd11.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:13;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Gx0NrfhO+7Dj00ai0M46uuV/VGVHZ2SnJHxyp4QoXT+wgSAFrG9LyTqQ95vxocPyDNhFOT8N1U2Sbr6SLxlHmp1GIQyURlMb/huACKGue2EQfJamm0ONycBjzoYb69vJA0+LTnned+WhQRjGePcIC5l2FWI6VKFO8BtCX+5ydT//iNC4l14eTsS/3D+PelLzxW8S0K8te2TdFg44fVS3aLiEDW0ZooKCx1gHJzcZw9aYEe6VArTdFfcLGovp7dt9/hyKPXSSAXUqQXyIlAO9K34WMC1GSmetd73PbGb8MyVYDnCInAVkaIRfoRJsiMKT7mWMn4a+mBKi3oJTDv5Lgf3snd7PplK2k5JVW2ik02vQ/pKkMxYFosBYZ4qdVTuqM1meDRptYllpV+0U5vWTdTdofE8hAWvDuVZNW8IxwwclqRWuDnWBlm4toukzCXDK815x/ygUW7FUrHzJtsSOYBLrwBZnPoFzqB2SuIyNMpXWkS5TgXy2Pxhymmc9Wam9+wSWfMT68C7ByNHYOReJz2gyM5hzZA5bgYE1DixF6BZee1HqpmWr/+LHUvBeZfVzTlS3ZhNgMd+zOSsQ/KL6neKXJlJNChLraudNiejzNTDCRhJwAcMvws919z62LG0EB8i927UUkDe7HMrVlZRV3jTlu9q86O53ikp7UDQR4tOK52iNGMm3dcMckKsxHLw3cEAflTh8QWfjn436mO4vhW3owWZ5B5+cZnGKQKIgW68LmK3oEXUhTdOpUB4Tv23a1rbVxJZ0ppGRIfZR4yvLDZanmiVaUmQGxwWqNLHMCjZUSk5UPIJg7S0qPHdAkW8YWJJQ7Epyb0gYOj40OI5cLKqDp8mtRVEEYxhMrsrkk0M=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR11MB5598.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(6029001)(366004)(186003)(8936002)(38100700002)(8676002)(2616005)(316002)(26005)(4326008)(4001150100001)(6916009)(6666004)(508600001)(31696002)(5660300002)(966005)(6486002)(66946007)(30864003)(66556008)(6506007)(66476007)(6512007)(2906002)(31686004)(86362001)(83380400001)(36756003)(82960400001)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?aUthc0RiSUUyZkZFWk9rQzlXTk5PRktHNHdtNm1CNzc3c0crZlVwak9MMUtT?=
 =?utf-8?B?L1dNYXhVdEhCQTNVNlFwdGUyZ0VCTGlFbk85SU9kd3Z3bXk2aEc0dWJLUnFL?=
 =?utf-8?B?UmlOK2Y4eG5yejZKUGpac2g3eHkyb0syVVExTUdXUG54L0s2aWdCc0oyNmFj?=
 =?utf-8?B?aDhGcmU0bVVacENwc1FOazlMWDc2a3paeS9yOVhWQ0hNc085Njh1aVpVZjB3?=
 =?utf-8?B?b2NUZnlmQmFQVWNpd05qSXA4Nkpjb244dVoyeEd2RERhNGM2TmVuVE1kUlNL?=
 =?utf-8?B?YmhrajVKanplemx2ZEp6cmx3cmZDZTBjbmZkN01RdnowNGVmTjRWaEtxTXd6?=
 =?utf-8?B?R3FvUHgwK2tBWmMrN3hCdEx1TlltOXhlWC95ZldTUzlITU16Z1hWSndyS1Ev?=
 =?utf-8?B?VFJtLzNoT3o3aVBROEQrRHpISGo0ajdQcnZwaElka2dTT25uamtQNHc4d3pi?=
 =?utf-8?B?d0s0MG5rL3YyUWtZNDRyRjhrR21YYTN1Y3hOQmo1ZjZPdEo1V1FRVWp5aTdJ?=
 =?utf-8?B?UGhCTDZKMFpxbDBydmJ4OXlmSjVBUW9KZ1FSeC8xbFJuc1ZiRlNDV25JR2dW?=
 =?utf-8?B?K2kyUHArSEp4TWRpMmw5dW1PSkNIM1ZLckVpeUxkMkdrNG1VU3BwRjA2NEZl?=
 =?utf-8?B?VTFwTXp1dkdTVlZyckswa2dsdmt4SW1HWnNna20rTnQzTHNiUlBRVnBGYzBr?=
 =?utf-8?B?cHBMUUh1ZmswRTBuSjZ3ME1icWJ0UDllMGtCVWVNWDRCcmJLTUpPMlVHYnJ5?=
 =?utf-8?B?bG1LeXBrNkVKTnZYUjM3UWJnQTZZU3hidXlCRThPTUoxaEZVY3VyS2pUUGQ3?=
 =?utf-8?B?cjY3T3JOd1ZPSGV6aVB5b1NYSDBNUTRIR09XRjhWMVNuTUIwWlBTWkRVNHpy?=
 =?utf-8?B?eElpdTF1Sm12MmVMNlJ1d0ZOU0huUU5TYjI0T1BXaE1zZUlyK2VnNWRmKzhm?=
 =?utf-8?B?M3B5MllMTHRvUS9DWmlDUUxIMjdrMXdCS2I5ZzFBQVpFek5DMFE2M0xKN3ow?=
 =?utf-8?B?UjVwWU5LOVlXNnB2bkxObHVUUnVlUUY3SnVvYWJZU3Q3a1lFRjJoZE5nSWR5?=
 =?utf-8?B?UlBqbnhkdG5SUkNpZDJJM3RTTUlrZ0dFY0RJYVcvU3gvRVQxb0VISjZucVYz?=
 =?utf-8?B?bVJ1cFFjU0c4S20zVndPUXhNSXZOT0lqQlBVaW9kS3hQcm8xcDdtVWx0VTJS?=
 =?utf-8?B?OEhYMUpOVW96TnVmQWRpUnRjVytPL0tWTDJUM2ZRN0Z4RnlobEQvQWFrdTI3?=
 =?utf-8?B?a09MMFBGbW96dmt5M3FaaWJCV2VyTEgwS1N3ZnZyaEluRWMwS1lLek9yaFNR?=
 =?utf-8?B?d1FnWEc4cWp5SVU4Z091dGI2K21DRkJxendiOEluSVdhcE1SSDlSSy9NTVNV?=
 =?utf-8?B?MVZFRkp1SGI0Si9JOXpDZHlrY3BRY1hCaUpkdUVDTnd4SzFOa2NBRzJWdWlD?=
 =?utf-8?B?N1NjNDBGUHh0dUJDMm5BcmpLZ2RuNk5BWjNsVFhOZ1BjcmxkVDBHMktmMCtT?=
 =?utf-8?B?QWFxZEZVRS9RaVZYZXFFUHIxSXNxQnU1VzJSaTNnR0FZejZ0UG8wMlhpc0ZL?=
 =?utf-8?B?ZDhFcGk0UnlmWDQrNG1vcXJyL2cyVlV5QytyYTc5dzhYdUdPWlRQQ0lsbHBE?=
 =?utf-8?B?UXhSdFlNcGhDdVkxbEwyNnRXQVlpTTVMUlA3SXRJM0xPeW1ZM2VWQXZsN1Fh?=
 =?utf-8?B?UWliNDEvTHBVd1hSTSs3UEhxTDY3M0VyQ0JHN3NybkJSMTV2WERSKzV6b1pO?=
 =?utf-8?B?azhnbmpyQ0pKRk5RRkhPRFNuL2ZPNU5iemVPaGpNbzIvNjlCNEhjWDNMVWtI?=
 =?utf-8?B?VElDT09CR25rRDdGVXVDa0Q5TWFHV1JId3IvT1ZtNUl6M0JKbEdoWVR4Y1RY?=
 =?utf-8?B?Smg3WlBJOE5LOXQvcHhmbzNFRnpQZzRVUEduWFlVRWdsNWJqZm1oYVk4RmNw?=
 =?utf-8?B?bjdVRUoyOW9SLytVQmhyYkxDNlhhNy9aeFNBZUFlbTB6N0h3SEhtKzY1UGsw?=
 =?utf-8?B?UnUvQVovdzRWR1p6Uy90RVBDTmtjazZFakgyaGJpcTRyQlBzazVnRHZTVjcw?=
 =?utf-8?B?R2NJSkkwTUhVVnkvSndia3ZxVzB2NUNETGhYV1ljRGIyV25WV1B2Q1J6UWVN?=
 =?utf-8?B?SHgvK05xdzNDVVh3TnBqU1FlN0FnU3NMd2FSai84NE9rM0U0MVJtNnRJUzZG?=
 =?utf-8?Q?dvh+m0zbWH6aN84aKW7Mlz0=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 6333ea58-f6d5-43fa-1b5f-08d9d185af3e
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR11MB5598.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jan 2022 02:30:35.4167
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NfKGgvITzkqnZjXIJa1RLZehT1EBFEF4VkQdaYo0TpYaouGRssLkP9ttCGm1u+BfEuhC8v/Rug7C7/cLw+Morw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB5598
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   c9e6606c7fe92b50a02ce51dda82586ebdf99b48
commit: cbc21dc1cfe949e37b2a54c71511579f1899e8d4 amt: add data plane of amt interface
date:   9 weeks ago
compiler: arceb-elf-gcc (GCC) 11.2.0

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>


cppcheck possible warnings: (new ones prefixed by >>, may not real problems)

 >> drivers/net/amt.c:443:16: warning: Variable 'iph' is not assigned a value. [unassignedVariable]
     struct iphdr *iph;
                   ^
 >> drivers/net/amt.c:503:16: warning: Variable 'iph' is not assigned a value. [unassignedVariable]
     struct iphdr *iph;
                   ^
 >> drivers/net/amt.c:580:3: warning: Non-boolean value returned from function returning bool [returnNonBoolInBooleanFunction]
      return -1;
      ^

vim +580 drivers/net/amt.c

cbc21dc1cfe949 Taehee Yoo 2021-10-31  436
cbc21dc1cfe949 Taehee Yoo 2021-10-31  437  static bool amt_send_membership_update(struct amt_dev *amt,
cbc21dc1cfe949 Taehee Yoo 2021-10-31  438  				       struct sk_buff *skb,
cbc21dc1cfe949 Taehee Yoo 2021-10-31  439  				       bool v6)
cbc21dc1cfe949 Taehee Yoo 2021-10-31  440  {
cbc21dc1cfe949 Taehee Yoo 2021-10-31  441  	struct amt_header_membership_update *amtmu;
cbc21dc1cfe949 Taehee Yoo 2021-10-31  442  	struct socket *sock;
cbc21dc1cfe949 Taehee Yoo 2021-10-31 @443  	struct iphdr *iph;
cbc21dc1cfe949 Taehee Yoo 2021-10-31  444  	struct flowi4 fl4;
cbc21dc1cfe949 Taehee Yoo 2021-10-31  445  	struct rtable *rt;
cbc21dc1cfe949 Taehee Yoo 2021-10-31  446  	int err;
cbc21dc1cfe949 Taehee Yoo 2021-10-31  447
cbc21dc1cfe949 Taehee Yoo 2021-10-31  448  	sock = rcu_dereference_bh(amt->sock);
cbc21dc1cfe949 Taehee Yoo 2021-10-31  449  	if (!sock)
cbc21dc1cfe949 Taehee Yoo 2021-10-31  450  		return true;
cbc21dc1cfe949 Taehee Yoo 2021-10-31  451
cbc21dc1cfe949 Taehee Yoo 2021-10-31  452  	err = skb_cow_head(skb, LL_RESERVED_SPACE(amt->dev) + sizeof(*amtmu) +
cbc21dc1cfe949 Taehee Yoo 2021-10-31  453  			   sizeof(*iph) + sizeof(struct udphdr));
cbc21dc1cfe949 Taehee Yoo 2021-10-31  454  	if (err)
cbc21dc1cfe949 Taehee Yoo 2021-10-31  455  		return true;
cbc21dc1cfe949 Taehee Yoo 2021-10-31  456
cbc21dc1cfe949 Taehee Yoo 2021-10-31  457  	skb_reset_inner_headers(skb);
cbc21dc1cfe949 Taehee Yoo 2021-10-31  458  	memset(&fl4, 0, sizeof(struct flowi4));
cbc21dc1cfe949 Taehee Yoo 2021-10-31  459  	fl4.flowi4_oif         = amt->stream_dev->ifindex;
cbc21dc1cfe949 Taehee Yoo 2021-10-31  460  	fl4.daddr              = amt->remote_ip;
cbc21dc1cfe949 Taehee Yoo 2021-10-31  461  	fl4.saddr              = amt->local_ip;
cbc21dc1cfe949 Taehee Yoo 2021-10-31  462  	fl4.flowi4_tos         = AMT_TOS;
cbc21dc1cfe949 Taehee Yoo 2021-10-31  463  	fl4.flowi4_proto       = IPPROTO_UDP;
cbc21dc1cfe949 Taehee Yoo 2021-10-31  464  	rt = ip_route_output_key(amt->net, &fl4);
cbc21dc1cfe949 Taehee Yoo 2021-10-31  465  	if (IS_ERR(rt)) {
cbc21dc1cfe949 Taehee Yoo 2021-10-31  466  		netdev_dbg(amt->dev, "no route to %pI4\n", &amt->remote_ip);
cbc21dc1cfe949 Taehee Yoo 2021-10-31  467  		return true;
cbc21dc1cfe949 Taehee Yoo 2021-10-31  468  	}
cbc21dc1cfe949 Taehee Yoo 2021-10-31  469
cbc21dc1cfe949 Taehee Yoo 2021-10-31  470  	amtmu			= skb_push(skb, sizeof(*amtmu));
cbc21dc1cfe949 Taehee Yoo 2021-10-31  471  	amtmu->version		= 0;
cbc21dc1cfe949 Taehee Yoo 2021-10-31  472  	amtmu->type		= AMT_MSG_MEMBERSHIP_UPDATE;
cbc21dc1cfe949 Taehee Yoo 2021-10-31  473  	amtmu->reserved		= 0;
cbc21dc1cfe949 Taehee Yoo 2021-10-31  474  	amtmu->nonce		= amt->nonce;
cbc21dc1cfe949 Taehee Yoo 2021-10-31  475  	amtmu->response_mac	= amt->mac;
cbc21dc1cfe949 Taehee Yoo 2021-10-31  476
cbc21dc1cfe949 Taehee Yoo 2021-10-31  477  	if (!v6)
cbc21dc1cfe949 Taehee Yoo 2021-10-31  478  		skb_set_inner_protocol(skb, htons(ETH_P_IP));
cbc21dc1cfe949 Taehee Yoo 2021-10-31  479  	else
cbc21dc1cfe949 Taehee Yoo 2021-10-31  480  		skb_set_inner_protocol(skb, htons(ETH_P_IPV6));
cbc21dc1cfe949 Taehee Yoo 2021-10-31  481  	udp_tunnel_xmit_skb(rt, sock->sk, skb,
cbc21dc1cfe949 Taehee Yoo 2021-10-31  482  			    fl4.saddr,
cbc21dc1cfe949 Taehee Yoo 2021-10-31  483  			    fl4.daddr,
cbc21dc1cfe949 Taehee Yoo 2021-10-31  484  			    AMT_TOS,
cbc21dc1cfe949 Taehee Yoo 2021-10-31  485  			    ip4_dst_hoplimit(&rt->dst),
cbc21dc1cfe949 Taehee Yoo 2021-10-31  486  			    0,
cbc21dc1cfe949 Taehee Yoo 2021-10-31  487  			    amt->gw_port,
cbc21dc1cfe949 Taehee Yoo 2021-10-31  488  			    amt->relay_port,
cbc21dc1cfe949 Taehee Yoo 2021-10-31  489  			    false,
cbc21dc1cfe949 Taehee Yoo 2021-10-31  490  			    false);
cbc21dc1cfe949 Taehee Yoo 2021-10-31  491  	amt_update_gw_status(amt, AMT_STATUS_SENT_UPDATE, true);
cbc21dc1cfe949 Taehee Yoo 2021-10-31  492  	return false;
cbc21dc1cfe949 Taehee Yoo 2021-10-31  493  }
cbc21dc1cfe949 Taehee Yoo 2021-10-31  494
cbc21dc1cfe949 Taehee Yoo 2021-10-31  495  static void amt_send_multicast_data(struct amt_dev *amt,
cbc21dc1cfe949 Taehee Yoo 2021-10-31  496  				    const struct sk_buff *oskb,
cbc21dc1cfe949 Taehee Yoo 2021-10-31  497  				    struct amt_tunnel_list *tunnel,
cbc21dc1cfe949 Taehee Yoo 2021-10-31  498  				    bool v6)
cbc21dc1cfe949 Taehee Yoo 2021-10-31  499  {
cbc21dc1cfe949 Taehee Yoo 2021-10-31  500  	struct amt_header_mcast_data *amtmd;
cbc21dc1cfe949 Taehee Yoo 2021-10-31  501  	struct socket *sock;
cbc21dc1cfe949 Taehee Yoo 2021-10-31  502  	struct sk_buff *skb;
cbc21dc1cfe949 Taehee Yoo 2021-10-31 @503  	struct iphdr *iph;
cbc21dc1cfe949 Taehee Yoo 2021-10-31  504  	struct flowi4 fl4;
cbc21dc1cfe949 Taehee Yoo 2021-10-31  505  	struct rtable *rt;
cbc21dc1cfe949 Taehee Yoo 2021-10-31  506
cbc21dc1cfe949 Taehee Yoo 2021-10-31  507  	sock = rcu_dereference_bh(amt->sock);
cbc21dc1cfe949 Taehee Yoo 2021-10-31  508  	if (!sock)
cbc21dc1cfe949 Taehee Yoo 2021-10-31  509  		return;
cbc21dc1cfe949 Taehee Yoo 2021-10-31  510
cbc21dc1cfe949 Taehee Yoo 2021-10-31  511  	skb = skb_copy_expand(oskb, sizeof(*amtmd) + sizeof(*iph) +
cbc21dc1cfe949 Taehee Yoo 2021-10-31  512  			      sizeof(struct udphdr), 0, GFP_ATOMIC);
cbc21dc1cfe949 Taehee Yoo 2021-10-31  513  	if (!skb)
cbc21dc1cfe949 Taehee Yoo 2021-10-31  514  		return;
cbc21dc1cfe949 Taehee Yoo 2021-10-31  515
cbc21dc1cfe949 Taehee Yoo 2021-10-31  516  	skb_reset_inner_headers(skb);
cbc21dc1cfe949 Taehee Yoo 2021-10-31  517  	memset(&fl4, 0, sizeof(struct flowi4));
cbc21dc1cfe949 Taehee Yoo 2021-10-31  518  	fl4.flowi4_oif         = amt->stream_dev->ifindex;
cbc21dc1cfe949 Taehee Yoo 2021-10-31  519  	fl4.daddr              = tunnel->ip4;
cbc21dc1cfe949 Taehee Yoo 2021-10-31  520  	fl4.saddr              = amt->local_ip;
cbc21dc1cfe949 Taehee Yoo 2021-10-31  521  	fl4.flowi4_proto       = IPPROTO_UDP;
cbc21dc1cfe949 Taehee Yoo 2021-10-31  522  	rt = ip_route_output_key(amt->net, &fl4);
cbc21dc1cfe949 Taehee Yoo 2021-10-31  523  	if (IS_ERR(rt)) {
cbc21dc1cfe949 Taehee Yoo 2021-10-31  524  		netdev_dbg(amt->dev, "no route to %pI4\n", &tunnel->ip4);
cbc21dc1cfe949 Taehee Yoo 2021-10-31  525  		kfree_skb(skb);
cbc21dc1cfe949 Taehee Yoo 2021-10-31  526  		return;
cbc21dc1cfe949 Taehee Yoo 2021-10-31  527  	}
cbc21dc1cfe949 Taehee Yoo 2021-10-31  528
cbc21dc1cfe949 Taehee Yoo 2021-10-31  529  	amtmd = skb_push(skb, sizeof(*amtmd));
cbc21dc1cfe949 Taehee Yoo 2021-10-31  530  	amtmd->version = 0;
cbc21dc1cfe949 Taehee Yoo 2021-10-31  531  	amtmd->reserved = 0;
cbc21dc1cfe949 Taehee Yoo 2021-10-31  532  	amtmd->type = AMT_MSG_MULTICAST_DATA;
cbc21dc1cfe949 Taehee Yoo 2021-10-31  533
cbc21dc1cfe949 Taehee Yoo 2021-10-31  534  	if (!v6)
cbc21dc1cfe949 Taehee Yoo 2021-10-31  535  		skb_set_inner_protocol(skb, htons(ETH_P_IP));
cbc21dc1cfe949 Taehee Yoo 2021-10-31  536  	else
cbc21dc1cfe949 Taehee Yoo 2021-10-31  537  		skb_set_inner_protocol(skb, htons(ETH_P_IPV6));
cbc21dc1cfe949 Taehee Yoo 2021-10-31  538  	udp_tunnel_xmit_skb(rt, sock->sk, skb,
cbc21dc1cfe949 Taehee Yoo 2021-10-31  539  			    fl4.saddr,
cbc21dc1cfe949 Taehee Yoo 2021-10-31  540  			    fl4.daddr,
cbc21dc1cfe949 Taehee Yoo 2021-10-31  541  			    AMT_TOS,
cbc21dc1cfe949 Taehee Yoo 2021-10-31  542  			    ip4_dst_hoplimit(&rt->dst),
cbc21dc1cfe949 Taehee Yoo 2021-10-31  543  			    0,
cbc21dc1cfe949 Taehee Yoo 2021-10-31  544  			    amt->relay_port,
cbc21dc1cfe949 Taehee Yoo 2021-10-31  545  			    tunnel->source_port,
cbc21dc1cfe949 Taehee Yoo 2021-10-31  546  			    false,
cbc21dc1cfe949 Taehee Yoo 2021-10-31  547  			    false);
cbc21dc1cfe949 Taehee Yoo 2021-10-31  548  }
cbc21dc1cfe949 Taehee Yoo 2021-10-31  549
cbc21dc1cfe949 Taehee Yoo 2021-10-31  550  static bool amt_send_membership_query(struct amt_dev *amt,
cbc21dc1cfe949 Taehee Yoo 2021-10-31  551  				      struct sk_buff *skb,
cbc21dc1cfe949 Taehee Yoo 2021-10-31  552  				      struct amt_tunnel_list *tunnel,
cbc21dc1cfe949 Taehee Yoo 2021-10-31  553  				      bool v6)
cbc21dc1cfe949 Taehee Yoo 2021-10-31  554  {
cbc21dc1cfe949 Taehee Yoo 2021-10-31  555  	struct amt_header_membership_query *amtmq;
cbc21dc1cfe949 Taehee Yoo 2021-10-31  556  	struct socket *sock;
cbc21dc1cfe949 Taehee Yoo 2021-10-31  557  	struct rtable *rt;
cbc21dc1cfe949 Taehee Yoo 2021-10-31  558  	struct flowi4 fl4;
cbc21dc1cfe949 Taehee Yoo 2021-10-31  559  	int err;
cbc21dc1cfe949 Taehee Yoo 2021-10-31  560
cbc21dc1cfe949 Taehee Yoo 2021-10-31  561  	sock = rcu_dereference_bh(amt->sock);
cbc21dc1cfe949 Taehee Yoo 2021-10-31  562  	if (!sock)
cbc21dc1cfe949 Taehee Yoo 2021-10-31  563  		return true;
cbc21dc1cfe949 Taehee Yoo 2021-10-31  564
cbc21dc1cfe949 Taehee Yoo 2021-10-31  565  	err = skb_cow_head(skb, LL_RESERVED_SPACE(amt->dev) + sizeof(*amtmq) +
cbc21dc1cfe949 Taehee Yoo 2021-10-31  566  			   sizeof(struct iphdr) + sizeof(struct udphdr));
cbc21dc1cfe949 Taehee Yoo 2021-10-31  567  	if (err)
cbc21dc1cfe949 Taehee Yoo 2021-10-31  568  		return true;
cbc21dc1cfe949 Taehee Yoo 2021-10-31  569
cbc21dc1cfe949 Taehee Yoo 2021-10-31  570  	skb_reset_inner_headers(skb);
cbc21dc1cfe949 Taehee Yoo 2021-10-31  571  	memset(&fl4, 0, sizeof(struct flowi4));
cbc21dc1cfe949 Taehee Yoo 2021-10-31  572  	fl4.flowi4_oif         = amt->stream_dev->ifindex;
cbc21dc1cfe949 Taehee Yoo 2021-10-31  573  	fl4.daddr              = tunnel->ip4;
cbc21dc1cfe949 Taehee Yoo 2021-10-31  574  	fl4.saddr              = amt->local_ip;
cbc21dc1cfe949 Taehee Yoo 2021-10-31  575  	fl4.flowi4_tos         = AMT_TOS;
cbc21dc1cfe949 Taehee Yoo 2021-10-31  576  	fl4.flowi4_proto       = IPPROTO_UDP;
cbc21dc1cfe949 Taehee Yoo 2021-10-31  577  	rt = ip_route_output_key(amt->net, &fl4);
cbc21dc1cfe949 Taehee Yoo 2021-10-31  578  	if (IS_ERR(rt)) {
cbc21dc1cfe949 Taehee Yoo 2021-10-31  579  		netdev_dbg(amt->dev, "no route to %pI4\n", &tunnel->ip4);
cbc21dc1cfe949 Taehee Yoo 2021-10-31 @580  		return -1;
cbc21dc1cfe949 Taehee Yoo 2021-10-31  581  	}
cbc21dc1cfe949 Taehee Yoo 2021-10-31  582
cbc21dc1cfe949 Taehee Yoo 2021-10-31  583  	amtmq		= skb_push(skb, sizeof(*amtmq));
cbc21dc1cfe949 Taehee Yoo 2021-10-31  584  	amtmq->version	= 0;
cbc21dc1cfe949 Taehee Yoo 2021-10-31  585  	amtmq->type	= AMT_MSG_MEMBERSHIP_QUERY;
cbc21dc1cfe949 Taehee Yoo 2021-10-31  586  	amtmq->reserved = 0;
cbc21dc1cfe949 Taehee Yoo 2021-10-31  587  	amtmq->l	= 0;
cbc21dc1cfe949 Taehee Yoo 2021-10-31  588  	amtmq->g	= 0;
cbc21dc1cfe949 Taehee Yoo 2021-10-31  589  	amtmq->nonce	= tunnel->nonce;
cbc21dc1cfe949 Taehee Yoo 2021-10-31  590  	amtmq->response_mac = tunnel->mac;
cbc21dc1cfe949 Taehee Yoo 2021-10-31  591
cbc21dc1cfe949 Taehee Yoo 2021-10-31  592  	if (!v6)
cbc21dc1cfe949 Taehee Yoo 2021-10-31  593  		skb_set_inner_protocol(skb, htons(ETH_P_IP));
cbc21dc1cfe949 Taehee Yoo 2021-10-31  594  	else
cbc21dc1cfe949 Taehee Yoo 2021-10-31  595  		skb_set_inner_protocol(skb, htons(ETH_P_IPV6));
cbc21dc1cfe949 Taehee Yoo 2021-10-31  596  	udp_tunnel_xmit_skb(rt, sock->sk, skb,
cbc21dc1cfe949 Taehee Yoo 2021-10-31  597  			    fl4.saddr,
cbc21dc1cfe949 Taehee Yoo 2021-10-31  598  			    fl4.daddr,
cbc21dc1cfe949 Taehee Yoo 2021-10-31  599  			    AMT_TOS,
cbc21dc1cfe949 Taehee Yoo 2021-10-31  600  			    ip4_dst_hoplimit(&rt->dst),
cbc21dc1cfe949 Taehee Yoo 2021-10-31  601  			    0,
cbc21dc1cfe949 Taehee Yoo 2021-10-31  602  			    amt->relay_port,
cbc21dc1cfe949 Taehee Yoo 2021-10-31  603  			    tunnel->source_port,
cbc21dc1cfe949 Taehee Yoo 2021-10-31  604  			    false,
cbc21dc1cfe949 Taehee Yoo 2021-10-31  605  			    false);
cbc21dc1cfe949 Taehee Yoo 2021-10-31  606  	amt_update_relay_status(tunnel, AMT_STATUS_SENT_QUERY, true);
cbc21dc1cfe949 Taehee Yoo 2021-10-31  607  	return false;
cbc21dc1cfe949 Taehee Yoo 2021-10-31  608  }
cbc21dc1cfe949 Taehee Yoo 2021-10-31  609

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
