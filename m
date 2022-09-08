Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E67175B299B
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Sep 2022 00:53:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229771AbiIHWv7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Sep 2022 18:51:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229505AbiIHWv4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Sep 2022 18:51:56 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1BA99F9FA9;
        Thu,  8 Sep 2022 15:51:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1662677516; x=1694213516;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=wcR2TtMAra+e5KBv11nyUEwWD4iLInVrFcyt7sot920=;
  b=boCxe9ZkLCpLbmjfu/1nsQtPUfUVp1DTxWpQVtE5OmRXaODuRPu0QuiK
   rj9m9VIFauclH3hlmtzhFGX2bbZ4NEGoebddC7JaVsp3KgyE/e/1XW2YW
   2QAwZmSYMMTen2QMW1llos3bF4B9skcUqlbyXTroKsSO9PWcWcWs46MzQ
   zzRA2pkep1GlrRHvZKxTaBrhB6audWOHblklmdW2vDcVtXJyYeJr6Kx1Y
   xpzsr3GiGNLc8m4OxIeOhamsM90HdSjV1XHnHw1b4PcokwZ0st4nCEauF
   P5/bk6bB3exPyZbxTBGsNaXmO81EX49tUTM1pPOA+G/CW8E7td0NR5AHM
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10464"; a="297342280"
X-IronPort-AV: E=Sophos;i="5.93,300,1654585200"; 
   d="scan'208";a="297342280"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Sep 2022 15:51:55 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,300,1654585200"; 
   d="scan'208";a="648222805"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by orsmga001.jf.intel.com with ESMTP; 08 Sep 2022 15:51:55 -0700
Received: from orsmsx608.amr.corp.intel.com (10.22.229.21) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Thu, 8 Sep 2022 15:51:55 -0700
Received: from orsmsx607.amr.corp.intel.com (10.22.229.20) by
 ORSMSX608.amr.corp.intel.com (10.22.229.21) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Thu, 8 Sep 2022 15:51:54 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx607.amr.corp.intel.com (10.22.229.20) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31 via Frontend Transport; Thu, 8 Sep 2022 15:51:54 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.104)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.31; Thu, 8 Sep 2022 15:51:54 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JJMOLRlOv1VWwG8EActVdHXoKApVaWM3KFXmczbLMNIKLfP5H710ukvJfrupyTqTfdHXDMV1les3pSJvRrB4oQciLO+cN7g8Wg+Yt16jQgmG7HyIOM+kTRnIKSGaIx/gEY2zmttwKuE+g8DBGTPS00POfSa/sza6zfP/nXwljSbzeh4up0w0o59s+ZGv6SW5eZqnYy1wrU67MtJjQ2Hj52o0vN8LbYhgnDRsLur9LyCoNiljzH0JGEBWYd7a7GQUgzWYDTiB+WHJnbPcxuA1hYwJl/ww0pDZx4ayNxSS8bpJ8PeRYRCiBp2yiWYvImTalClaGZw3UgmmbP7yxWjdow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yzw3wJ4LjxPbRXQcy7jlX2T2yw9Ky8WjfOdK2eGkLAw=;
 b=GOTLRjYBacb59Wyt8l6pQ8/q+5xu6dUj+Rtyi4AVU/1LvuQf8QGTdsNS9tsF39oaZ7MnpTx2K+IKHlmfj7CiHKu+Ra2TpJt0+UmllOl7CJlqo0QZ1rNVAMXNN6pUSHwniOzxz1ayuSjl5HWA/AMWMzwV+w2xJKJfQBx3ZlOv2rbMInaL99iDMIEdx5irFQqxudAB0i+EEsis2IUpn31JfAkCydzJNWDTd01FXxaiTuKa5l94A6x8dDSToiIIoqn9KVWoIBy2jn6ihYpAuviq/IpsNAQfvUC1r1bx8KfdX2xLxOLaRvyp/3O1rV1yv0hDQux2w6pl5cmHUdMPzmJPXQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MWHPR1101MB2126.namprd11.prod.outlook.com
 (2603:10b6:301:50::20) by SN6PR11MB3245.namprd11.prod.outlook.com
 (2603:10b6:805:be::32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5588.18; Thu, 8 Sep
 2022 22:51:53 +0000
Received: from MWHPR1101MB2126.namprd11.prod.outlook.com
 ([fe80::9847:345e:4c5b:ca12]) by MWHPR1101MB2126.namprd11.prod.outlook.com
 ([fe80::9847:345e:4c5b:ca12%6]) with mapi id 15.20.5588.017; Thu, 8 Sep 2022
 22:51:53 +0000
Date:   Thu, 8 Sep 2022 15:51:50 -0700
From:   Dan Williams <dan.j.williams@intel.com>
To:     Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Dan Williams <dan.j.williams@intel.com>
CC:     Andrew Morton <akpm@linux-foundation.org>,
        Davidlohr Bueso <dave@stgolabs.net>, <x86@kernel.org>,
        <nvdimm@lists.linux.dev>, <linux-cxl@vger.kernel.org>,
        <peterz@infradead.org>, <bp@alien8.de>, <dave.jiang@intel.com>,
        <vishal.l.verma@intel.com>, <ira.weiny@intel.com>,
        <a.manzanares@samsung.com>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH -next] memregion: Add arch_flush_memregion() interface
Message-ID: <631a7206afc2_166f29413@dwillia2-xfh.jf.intel.com.notmuch>
References: <20220829212918.4039240-1-dave@stgolabs.net>
 <20220907153016.f7cd4f42a337fedae8319f28@linux-foundation.org>
 <631940536d040_2736529437@dwillia2-xfh.jf.intel.com.notmuch>
 <20220908141319.00000f01@huawei.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20220908141319.00000f01@huawei.com>
X-ClientProxiedBy: SJ0PR05CA0181.namprd05.prod.outlook.com
 (2603:10b6:a03:330::6) To MWHPR1101MB2126.namprd11.prod.outlook.com
 (2603:10b6:301:50::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 6097e4fc-6926-4312-695d-08da91ecb8d6
X-MS-TrafficTypeDiagnostic: SN6PR11MB3245:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: lmDFPhALjNY56VUZoSem01JVJuWj+BV1TFXlwlHR+RTGYmpPK1kJyUJYfWEo1x2iKiAa2weHukD60FOXWB27wZFXRXtle55OafpvSj2oqjxwl8I1JDFNfIq+h5hrGSeG69KDdDrU/HIrLjJfjN7NFzBWBbFtYaGxGCZhUfkew3k50LP3GddsNgkjEdF5CK4KVYgfk4k6p7QmqemiyQJQRXDItkbIDN1TTsF9fBbfcZPl4RikSffOAI2wlczM1KWPE1SesvA2HrurOp8paaql9cxwvQUBElOVRf37yaOvYplzUjHybZDrUMxb/B70JkNaNBDxqC752j7BslMC2AYxQcPLCS+y+AYnqdW6Lqsp8cA9YozDN4jChCy5jjKn2UaLjPnUplCfUhMSap1nNe9Qk2PszEY8mcpynMvShJNz5PE1ku36IxVMPWApYla3qxINfWCNsPOay6nOPtc1ieKKRV7BbVKJyAtGOQlkDv7KKduPcgk5yCUPOllcGmPDtOGxSw4mjB/7omS0c6JYzYE7l88vv4Yi/TlMQNuRgIXkfh0I6uvA0O0sE0s8H/AB+16yK3FQr5xjAPS3G/MrDSnG6ey3aSf/9xwNdhPiSK0ynUG5SWZIM+iXtahR1akAqr3RoCqCbd7naPzSOmGeowdmTYCt5CMJFZXsoseJIOYutEqUF4KCd8U2vKLfeYvmZsv5Nz3swwiSCdC53pc+c3kNTA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1101MB2126.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(136003)(366004)(396003)(346002)(376002)(39860400002)(54906003)(478600001)(316002)(110136005)(6506007)(6512007)(9686003)(26005)(8936002)(2906002)(5660300002)(7416002)(86362001)(66476007)(66556008)(4326008)(8676002)(83380400001)(66946007)(186003)(41300700001)(82960400001)(38100700002)(6486002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?wRrRTFeMZKvYqqMKseFiPVxNO+R2RE1w48tRo8Y+X1vmpcsUqC4fqtrfMn82?=
 =?us-ascii?Q?ars9w0SIYiPaojZJwQWKGJtstmYbGnQo5lGr9f/lZiBJts4LXKmprxDcIH4q?=
 =?us-ascii?Q?UD+gMqdCYMB9Gmx+ymiIdIwmJedc7OIlfImk8dV38d1SIxO/4hfjAzSFfDFq?=
 =?us-ascii?Q?UuLUtowSuuNbfQvfb6BNn1JbT7VB2Yqd1eOpJE5to1cVftjk37VRf5GFGc2w?=
 =?us-ascii?Q?V0NKXZNPHeSfBQex7Uvqt6Wk3A1d5/zBLajCYFov/6AyW8Yp8RFZeTNQfP0+?=
 =?us-ascii?Q?yxShc1nwY92CA4XJmW6L+aOFrEVpIaaGYmCuIL1hBDJQR8zRGaMZChV2w1mZ?=
 =?us-ascii?Q?IGFp7Y+xVXBH5BLT51r1o6b/nTUNYiaazNhwPsrKxLX9/cRmIHt7S5fVjlwJ?=
 =?us-ascii?Q?r2Pub4UEZRI6fQL4+rx6HWthFtJ89Lzre4c+v/8Ohz0eKYg2zzcX49R8vEu7?=
 =?us-ascii?Q?lCtHrGViGVFecRBW2zdlLYJebSGgBIXUoVhpQaSqaMxyFHnyO3/lm7dNu2tY?=
 =?us-ascii?Q?n8B46yi/e2MILQSYliab3J0xKZ92sLjlP8bFoAGQn+IyiEis7WlBzcYDOT3d?=
 =?us-ascii?Q?54oA/K+Mk70GSwHb8dsr4WPbz+sTs6dmo91wPFDKppF6Qk3582MM2LIW0fOJ?=
 =?us-ascii?Q?dkEp3DaP/86wwguMPXpM9bV3oo9nKWeOMlW7vKZb6gedgdo3Hm9PHjaIdaax?=
 =?us-ascii?Q?zTkBxuS2m0BsqAOY/uhfZF7U2yprZ8BDpiGTe7kPTwgbVp5lWIWHvOacNdKO?=
 =?us-ascii?Q?Mfmep9/sk8e3TCpqQpErv2tG8VkrwH/wlp1ijBEVeoHZNhYgHh0tpiYfkuXR?=
 =?us-ascii?Q?chh3RZJiVBKXuZ98WohBSXXrzj1CQrPWOHA4+iyNKI6LlnWAY2qMx+Ai6bns?=
 =?us-ascii?Q?uf13+TjrDttTpzeNSI4XznELjYDsrV/IUSpmxaqeDqz7UbhpRrAU2SU96Xaz?=
 =?us-ascii?Q?9+1g1U4kp1vMBvfLOpgpP/syPT2IYpySKh6cFXAKtB/oLy5LPGVK6LUq7IEC?=
 =?us-ascii?Q?O+IegBY96GWetjXF9sYrlNFzA9HyZmDL+11PFS4B+R39MvgbdTmn2WeSbIOY?=
 =?us-ascii?Q?Y8N0JYIUYCchsHonwpZ5KHRUokZg2auv2YePNTLZXfTMeDnlM38iD5UJSKD7?=
 =?us-ascii?Q?3l8Pnw+lT3eO7U58Mzhi60/eKaQ7Vb+gXSM1NuL28ylEPvIu4tyqKQDin6OT?=
 =?us-ascii?Q?zY4ZsH2JNn7Lrrmdou3FhO99tBzumkdmCHOeIra2yQM2ofgFSPw7lhYglXHW?=
 =?us-ascii?Q?pVuiVnXLVO/qj+t9ccvkfu8DxIuJ97HYMk4CXzk1BTeqTZjzDbnHPIrxhwR2?=
 =?us-ascii?Q?2pMfG2q9YQiVUi9z1+c1soMnjC569We/UsYXovgfxj66BIYKY58YziFRG3Dm?=
 =?us-ascii?Q?+hN33R2ONmaT+kl/oDBfc07581g5bsGvWq0r7LeNXBNaLXPK3gP5pas9fM8c?=
 =?us-ascii?Q?zoBZwTO3ynQmY6eskcq7SmCCbbrQrkBWQscz2Lg/fBAp8r0vQkIfQNtb9sv8?=
 =?us-ascii?Q?mSrALB8BICijm9GZ1ONAn0xEE1VNKD5hseodWWhdbupAMTuj147SXIOVv5rf?=
 =?us-ascii?Q?zlBtmt9JzijGpwcrSIieUstBU0PIZfaBLyTfl/hVBA0TuNZx6inCa/9GtkRH?=
 =?us-ascii?Q?yQ=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 6097e4fc-6926-4312-695d-08da91ecb8d6
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1101MB2126.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Sep 2022 22:51:52.7746
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mDNc+atoRR1mpWeSY9hBTUK3jomqjE5TGnB2suKybnNN8JSVc6DOAqhriywF2iDzV1gMXaStxydB4UIChGAHMBFjhW6omtK9HGLlAWMAKTQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR11MB3245
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Jonathan Cameron wrote:
> On Wed, 7 Sep 2022 18:07:31 -0700
> Dan Williams <dan.j.williams@intel.com> wrote:
> 
> > Andrew Morton wrote:
> > > I really dislike the term "flush".  Sometimes it means writeback,
> > > sometimes it means invalidate.  Perhaps at other times it means
> > > both.
> > > 
> > > Can we please be very clear in comments and changelogs about exactly
> > > what this "flush" does.   With bonus points for being more specific in the 
> > > function naming?
> > >   
> > 
> > That's a good point, "flush" has been cargo-culted along in Linux's
> > cache management APIs to mean write-back-and-invalidate. In this case I
> > think this API is purely about invalidate. It just so happens that x86
> > has not historically had a global invalidate instruction readily
> > available which leads to the overuse of wbinvd.
> > 
> > It would be nice to make clear that this API is purely about
> > invalidating any data cached for a physical address impacted by address
> > space management event (secure erase / new region provision). Write-back
> > is an unnecessary side-effect.
> > 
> > So how about:
> > 
> > s/arch_flush_memregion/cpu_cache_invalidate_memregion/?
> 
> Want to indicate it 'might' write back perhaps?
> So could be invalidate or clean and invalidate (using arm ARM terms just to add
> to the confusion ;)
> 
> Feels like there will be potential race conditions where that matters as we might
> force stale data to be written back.
> 
> Perhaps a comment is enough for that. Anyone have the "famous last words" feeling?

Is "invalidate" not clear that write-back is optional? Maybe not.

Also, I realized that we tried to include the address range to allow for
the possibility of flushing by virtual address range, but that
overcomplicates the use. I.e. if someone issue secure erase and the
region association is not established does that mean that mean that the
cache invalidation is not needed? It could be the case that someone
disables a device, does the secure erase, and then reattaches to the
same region. The cache invalidation is needed, but at the time of the
secure erase the HPA was unknown.

All this to say that I feel the bikeshedding will need to continue until
morale improves.

I notice that the DMA API uses 'sync' to indicate, "make this memory
consistent/coherent for the CPU or the device", so how about an API like

    memregion_sync_for_cpu(int res_desc)

...where the @res_desc would be IORES_DESC_CXL for all CXL and
IORES_DESC_PERSISTENT_MEMORY for the current nvdimm use case.
