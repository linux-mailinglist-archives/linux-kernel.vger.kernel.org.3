Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DDDC04B9505
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Feb 2022 01:27:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229700AbiBQAZt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Feb 2022 19:25:49 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:44418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229658AbiBQAZr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Feb 2022 19:25:47 -0500
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25B8D2A97F0;
        Wed, 16 Feb 2022 16:25:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1645057534; x=1676593534;
  h=message-id:date:subject:from:to:cc:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=rRjlcPERtLemxZTi9AJk2v2IBH9SHhB+1lWgjIcQnBA=;
  b=VAjCw1JwywntnjOHoP3rUsTPDIxMMSEFu5fOvo9dVJSn52VT2extNGue
   GOjVGDiCuHulb6I2wCpnzh79XWuuBqH1+A75R29BnffyOleGyZoTu5oYS
   KdamITvg/AUE/WFhNbCDSmWKeZrB3Erwam+5E7Tpp3YuXt1N4rI4IOey6
   LBgKjMXNwt8lqSzUnY5SNGWjVwDOmz3eiUhhUMJsrWhaQl/tJqmbzx74b
   EuVpFX54OjcU27NWdBFuS5mGUuEQn3xnscrxUy+OQI+TGsFnBeOwuKe2o
   0hBTVTHAFO6qp4mVcVLC+PHey0Nv3r5Sg8auq7v6zqyHvshJMvR//HMCx
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10260"; a="314025499"
X-IronPort-AV: E=Sophos;i="5.88,374,1635231600"; 
   d="scan'208";a="314025499"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Feb 2022 16:25:33 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,374,1635231600"; 
   d="scan'208";a="503267009"
Received: from orsmsx606.amr.corp.intel.com ([10.22.229.19])
  by orsmga002.jf.intel.com with ESMTP; 16 Feb 2022 16:25:33 -0800
Received: from orsmsx609.amr.corp.intel.com (10.22.229.22) by
 ORSMSX606.amr.corp.intel.com (10.22.229.19) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Wed, 16 Feb 2022 16:25:33 -0800
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx609.amr.corp.intel.com (10.22.229.22) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20 via Frontend Transport; Wed, 16 Feb 2022 16:25:33 -0800
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.171)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.20; Wed, 16 Feb 2022 16:25:32 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nL8kiwH9bEgQHEydG07bOP0JjmH3e3h3a3BbVjYMAcvUn2KcSX+oPniv7AtEnHG+HQEULY5QiJ5bTgz3Xp6laZf9YrX+sigADJR8i2RZf38nm6v8LM9tR58M3skE8Ae/tMf1VfLsDZ6teb+ZEFalKDQQxZPmoSsVsLyoIGihlYNZtx9aTSbr8DapICtSvoo/JhGZcbsvrHqDr/+D9TgN95krf0bmRvNyssRcv+pvsywbufofSWRh/7gBtWl4oPWrAkKVwTbgefdk6Lc5D703yZPErgt/SdTUz9/Wu0Vc3EiISTViazsQvSiCKGOFH/OnwDemk4NX0QTQI2FDn4VN2g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZvjUK4emAV5ict3ckYulZnbFRkfgSY0Dmd+MLkMbcP8=;
 b=OT2OZX7WqTbh+WhmxAlOg0CECB6h5q3xssy7NXh0kp25awfgau7X/POSmU7uEsyEFln+RnqWSSweSXWhwo2F3zBlkHN4VjuGP8HiV/2biJn+uVBS331LAnrneyYg5jEUiFAQsmvHstcCthcvMTkSNIbdDdQW16Qgmqmw0kkcWA1m9yH+Gn8t10HWVLllzPosrl0BlTRcCQJEaneAqM4gdrGyjTBMiDEGaaJIA8/zwynrclXEUW57RwKToE+YTa9fnN8raj2xaUWRro7xojNRSGU/b8x6XvEl0Wy3SiMiHHAOUcU+o3AUx3ZNEdrKTs4TRfz76Ouk8EXLCumfplAuwg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BN0PR11MB5744.namprd11.prod.outlook.com (2603:10b6:408:166::16)
 by CH0PR11MB5313.namprd11.prod.outlook.com (2603:10b6:610:bc::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4975.11; Thu, 17 Feb
 2022 00:25:29 +0000
Received: from BN0PR11MB5744.namprd11.prod.outlook.com
 ([fe80::55e4:9a32:8e6f:4774]) by BN0PR11MB5744.namprd11.prod.outlook.com
 ([fe80::55e4:9a32:8e6f:4774%4]) with mapi id 15.20.4995.016; Thu, 17 Feb 2022
 00:25:29 +0000
Message-ID: <91fd3b35-b791-af37-6663-9c37055f339e@intel.com>
Date:   Wed, 16 Feb 2022 16:25:24 -0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Firefox/91.0 Thunderbird/91.6.0
Subject: Re: [PATCH V3] x86/sgx: Add poison handling to reclaimer
Content-Language: en-US
From:   Reinette Chatre <reinette.chatre@intel.com>
To:     <tony.luck@intel.com>, <dave.hansen@linux.intel.com>,
        <jarkko@kernel.org>, <tglx@linutronix.de>, <bp@alien8.de>,
        <luto@kernel.org>, <mingo@redhat.com>, <linux-sgx@vger.kernel.org>,
        <x86@kernel.org>
CC:     <linux-kernel@vger.kernel.org>
References: <dcc95eb2aaefb042527ac50d0a50738c7c160dac.1643830353.git.reinette.chatre@intel.com>
In-Reply-To: <dcc95eb2aaefb042527ac50d0a50738c7c160dac.1643830353.git.reinette.chatre@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CO2PR07CA0048.namprd07.prod.outlook.com (2603:10b6:100::16)
 To BN0PR11MB5744.namprd11.prod.outlook.com (2603:10b6:408:166::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: db2f4473-9bd8-4332-65ad-08d9f1ac0007
X-MS-TrafficTypeDiagnostic: CH0PR11MB5313:EE_
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-Microsoft-Antispam-PRVS: <CH0PR11MB53130846591E18C92717FE4DF8369@CH0PR11MB5313.namprd11.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4941;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: zJ6HAiFCnUqR+v+TiHTuYvtOflaCVnMNKNnjoKV8iPg1IGKcjDrn00QQbELiSPt4pTzbSjl6fm0pUBTomt5klZOofvdf29oH6Kq07nIvra3qwHHCXvM9NPFlXbIeOvk9Mhqwn0ezfaVx4ymNjSX5PcAmV27G0mhPFUOCS1Z5EYuVm2GvDeQnA3Kp5VjoAvhWHkpAe4kXISY9QYBKIBi5OwieE7xUrtrNw41pnylVyaAr9+URkk9bzq9/pn78XU42PALdxZDjdny5lxzIDkKBpzcyFUbPbP6xYObq3T+UP+zIwHhEjXwLQCMZucQQk4sMa0CQOzS5BHwkBpL7fH0QbBdftPfgJLVo+ywwgXKELenwfSB29o64AmNXQuLVlhA9kAjo/cXLXyy6azIxF5dFRey7RqdbIuV3O6oBqQvDQrkU3ipCZmP/tsbZ9Qfd72yx859wwnQJiRbSIfTeXPi8R4EaVip/3YEhmPMgtY7n6zQ/HgZK6ncduNpWR5tB3eJjPD7p69kyX1wyNZUQr7pj4GVmXx+rKDakSpjC+6lGDIrvtP2RNCjHV7cI/dMqT03PYB3s+2UMSEGSQ+G/42ekyF63/Kj4qpMFoPsZqQLgpTffXpnkrF3eWeNTsskjVRrcQzR5trrXDJnCOSs0LfIur4o0TB39dlDLhcwGT//cKpmLsudDzo7tX0efksIgrNGBYaei1Pt88/3cwxKicAdTwb41IKkjmFv0BRaQsqw0hrxUeM1PRxAKnw1DJnKwGdFg
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR11MB5744.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(8676002)(66476007)(2616005)(66946007)(44832011)(38100700002)(6486002)(66556008)(2906002)(6512007)(508600001)(4326008)(26005)(186003)(82960400001)(316002)(6506007)(31696002)(31686004)(53546011)(6666004)(83380400001)(5660300002)(86362001)(8936002)(36756003)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?R0p2QmQ1L0NWL2pwUkhJTFJsZVIxRTdTUjNhUjNrbXVwT3pUQVBTSE1TWVJG?=
 =?utf-8?B?RWVWY1Z6MFVPVzFlV0RoODRnZHVhaXBVa2FUUG1lUlRWcHFYeFN3V0RZM09W?=
 =?utf-8?B?TEx2aUZCQnArcllobkI5SVVLWUlXdGhXSHNvc0JnMzFSclFKdWNhdmY2UUww?=
 =?utf-8?B?TkdIcUNmSnIwRjZqaGlrb1VSSlo0SXVnMWJvczRCL2FvYk10ZEJHa3k2REFR?=
 =?utf-8?B?NTJrUVlWSG5oMElzL1FENm9CREhUc1FibDRYMUY3aFhUeEZDWXV0bGxHVW51?=
 =?utf-8?B?amR2VVFBQ05laDNsSVN2cG9kTlNpZFRlSWZYcDZBS0Rzd25UQ2IySVJYVkts?=
 =?utf-8?B?TElydCtjQy9Ka2Ztb2d1dFhPVmNFKzJnUEVNMmpTZGEvU2tNME5mMnJwUEJD?=
 =?utf-8?B?MENSdFlnN0Z6YWRYcHNjL0JHWHdYODlkam13cXV5dllCeGd1bkhNeWlvNW8y?=
 =?utf-8?B?aE94TDBLVTVxTU84ZmlnYnpaZXhqQVhGMkFibUxNUFN6QnRFZmJtRSs2UVg2?=
 =?utf-8?B?M3VJbGpnazdGUUtQVU1KN0N0YmEwMHVmQ0NSaUo4YVpMd0NxcHo1ODdUOTdO?=
 =?utf-8?B?UytiSXpXQkNKcm8vUVVjeFlrNTlaYXh1LzFqb00vaGZOSHlTRG4yVitkVUZJ?=
 =?utf-8?B?QUFQbVFRajNwQUZab0FsY0lGTDBiUUsweHh3aERiNXFqY09PVWJpUjJEaUts?=
 =?utf-8?B?aGoraWFOR000YzBaMzg4Rk1NVElNK0JoOG4xdFM1Z0picWh2NmRWNENGbWky?=
 =?utf-8?B?K3FuWnZxZ1AyMVd6TWxPNStRZk5zQTRtNzdVTUVOdU5GWDR2ZmVXZlI3dlFv?=
 =?utf-8?B?UUdhY3prUU9nckwvWm8xb1JUdnNiQlBGMUYxQTJKczl0dmtvTS8wZWs2T2xB?=
 =?utf-8?B?UEZNd25rQTJRR1JxVmRlYUppQ3JNZ2FoeERhSlNRV2RNY1M1WEJtZDVxNUV1?=
 =?utf-8?B?Y3FuTlN0d0t0Q1JieXp4Yld4d0o3U3FrMGpnb0dYbVBYdkR3d0JVVUR5NVln?=
 =?utf-8?B?ckQ2TDFmaVpoQ3BoWnFyejBDN1hjeEtrY1FyTWtmMDV1c1paYmg5WVFjN1pr?=
 =?utf-8?B?b2xjUWxqTUw3TStYTDV1UGJid2UvMlFERk1vd1p5Tnhycks3SG9XNVd6c3lM?=
 =?utf-8?B?a0FzeU50YUlvYWYxbEVTZTBiTEVVZEFRaGJVZjRYMi9EMWRMRW5pTGluc2Jv?=
 =?utf-8?B?TDZRaHBmMUtsSkVFakxyc2taTlBpWjB2K0xUbGZQQi9PeEIxM1ZVQ2R1SXZn?=
 =?utf-8?B?NnI5WGpFdnFTTWJVcVU5Vm9IVDJUZGNTb2YvbTVsSW0reGRIRzRDdGp3TUQ3?=
 =?utf-8?B?cWRBRERCZzFxQVVNSnBYNEVvTzcxTWxUcllzck43SEx5VytCdTl5anBlcVlX?=
 =?utf-8?B?Mnl2SXpJS1lmQ29sazRTREZyTnh2ak9KazFxajN5T0ZsYkZDQ0VCVk1qNGJR?=
 =?utf-8?B?SWRkQmRKM3RoTThDdWNQSkJGSUhHTDU0RVlDeHhCQk42YmN4N1VvUnJmUHU0?=
 =?utf-8?B?T2c4cit4biszUWYycDRMQ1QzNkdHdkZyZWMxNm1kYnNlL2x1NEFHK2FrcTJG?=
 =?utf-8?B?U05pNTFIa3RFeXpSeVgwQk5xNmtwT3JpaEtFYm45d2Z2UWVPbkU5Y3Zmc1lw?=
 =?utf-8?B?ekdZd0hnT0txdzhTMmxRWGhLaVVsRm1VelBWZUgzcGRhcWxKZW9IL1J6VGNj?=
 =?utf-8?B?Nkc1RzAzQ0hoQ0dRcWNBSEgzRVN3WFNFZFBkT0hjWkkyMHRUazBMN1I4djNP?=
 =?utf-8?B?NWhrK0IyMG5VQUFhSjl6N2V0cmYveTQyb3FCZEhGTVVRaFk4Z3VLVmlYUTg0?=
 =?utf-8?B?SmJNM0ZDc2RtTmtJN2JQN2ZnUmhrMTZYZjRpOUh2ZmlxR1F1NkVwajM3SE1K?=
 =?utf-8?B?VnNVZy92ZGtLa0pubzhLS1lFRjBTT2JuN1NGUTl4ZGZocGdXOG10a2Fpbmla?=
 =?utf-8?B?Q3dFNW1vZVMvc1hoT0tXdVZZQ2Zqd2JubzEwcTVjSytzc2dEcEowOUs1cHV1?=
 =?utf-8?B?Tnp6Smd2dlg5RmJMWXE4QWVuWEpPWTcxdUw2ekRkYkJ5VEh4TnZRdk56M1d4?=
 =?utf-8?B?M2s4d0tDSmxDTGtuaWJocW1lK3VEd1VRUDMvRThBVXZGSGhHdFpjSHNMTDYv?=
 =?utf-8?B?Zm0zazFhK1JnN2FDYjR6TUJuMjRMbXJJQTVMeHpkREVaQm15b2hES1orM3E0?=
 =?utf-8?B?YzZ3dWlaSnBzV29CMzZPNmM5QmFhVStUQnExSTljc2hLaTd3N0ljaVNURjVI?=
 =?utf-8?Q?MeKoWHYyj0kyfNpi7cQFUuZY5iz23PbT7GisSZOBhI=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: db2f4473-9bd8-4332-65ad-08d9f1ac0007
X-MS-Exchange-CrossTenant-AuthSource: BN0PR11MB5744.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Feb 2022 00:25:29.2257
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: H4Z9ilhr8a6Vh2mMifPa810oPljheVedt+PeEyFw25CCZrmz0B+EuhjJOJnkCJUTJbJHjjuXqpZ7sYgvcwBLOrz7oFwSOSxxTeGqe6KgKuk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR11MB5313
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dear Maintainers,

On 2/2/2022 11:41 AM, Reinette Chatre wrote:
> The SGX reclaimer code lacks page poison handling in its main
> free path. This can lead to avoidable machine checks if a
> poisoned page is freed and reallocated instead of being
> isolated.
> 
> A troublesome scenario is:
>  1. Machine check (#MC) occurs (asynchronous, !MF_ACTION_REQUIRED)
>  2. arch_memory_failure() is eventually called
>  3. (SGX) page->poison set to 1
>  4. Page is reclaimed
>  5. Page added to normal free lists by sgx_reclaim_pages()
>     ^ This is the bug (poison pages should be isolated on the
>     sgx_poison_page_list instead)
>  6. Page is reallocated by some innocent enclave, a second (synchronous)
>     in-kernel #MC is induced, probably during EADD instruction.
>     ^ This is the fallout from the bug
> 
> (6) is unfortunate and can be avoided by replacing the open coded
> enclave page freeing code in the reclaimer with sgx_free_epc_page()
> to obtain support for poison page handling that includes placing the
> poisoned page on the correct list.
> 
> Fixes: d6d261bded8a ("x86/sgx: Add new sgx_epc_page flag bit to mark free pages")
> Fixes: 992801ae9243 ("x86/sgx: Initial poison handling for dirty and free pages")
> Reviewed-by: Jarkko Sakkinen <jarkko@kernel.org>
> Signed-off-by: Reinette Chatre <reinette.chatre@intel.com>

Could you please consider this fix for inclusion?

Thank you very much

Reinette
