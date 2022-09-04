Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 495475AC3A8
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Sep 2022 11:43:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233505AbiIDJnS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 4 Sep 2022 05:43:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229754AbiIDJnQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 4 Sep 2022 05:43:16 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1D6143315
        for <linux-kernel@vger.kernel.org>; Sun,  4 Sep 2022 02:43:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1662284594; x=1693820594;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=zrMRAFffj7oYDyc6aUL90hxGQClRONQUMBHjGh044yM=;
  b=FYvgoxFhAg7McxSrinHlgHc8qZpU2FKa/68+0mRwu4pH+f0Rdk+moTmA
   3FS/Ly7dpoXN+GqyOyIGdM8KfzfVQsQZe41cI1W/y02ZYZWWu8xE5tR93
   9GnRNTbHKE6j7oJEAIyUz/FzUzdZCZuIhH7JZTCb3ugcwEi0lJpExTtrK
   YtTVtNMccdzoaEh5hOU+SATpcZwDyOvkhjcXQ8YptYlaF0uC0x11blGEd
   bwOXzGmP5glypv0qoU8od20PEGjE8DGxmeX5+PlHFYeAG5g0fJux3eSgz
   wVhHE6x2H0omIlS+59YFDNlf5T78dSt0FqzjxZQno0JcqUZomEpkJWIJd
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10459"; a="279243806"
X-IronPort-AV: E=Sophos;i="5.93,289,1654585200"; 
   d="scan'208";a="279243806"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Sep 2022 02:43:14 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,289,1654585200"; 
   d="scan'208";a="789098485"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by orsmga005.jf.intel.com with ESMTP; 04 Sep 2022 02:43:14 -0700
Received: from orsmsx602.amr.corp.intel.com (10.22.229.15) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Sun, 4 Sep 2022 02:43:13 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31 via Frontend Transport; Sun, 4 Sep 2022 02:43:13 -0700
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (104.47.73.173)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.31; Sun, 4 Sep 2022 02:43:13 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PLSMWfwZMKgRfIX0p4qYgYY2DPwjlL/pm6lo4I4x82vkY4BzX0x0l/t2Pzk+9USmTMvSNpF1Ad4atE/TwrPv3G2g/GQ1yJwiHYWH64b4ttwH7KxyrP8jkzaEW9hIvVrtHuLrzF66KCdIvIpyy7H9vH2eQfzR8fz6j4gTT15RGyst+3k1nqR+xtseWEjTynToMvnOUGR2LLe1M3f8c+k7RPe8Hx2oXEzN4ne0go/EIu1RBhcBCNYybo6tBnj/uRiLDrLzKV+Z68bBV+3olDj2G5zGAl5lbSdAUAihCWmLyaXBWXVvShBq6xRk8kKJgwXGQxuK7tN89VpAj8doYZ+O1A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vsumifRNW6O6GZSJxvTMP2SmgsafQFYdgfm/Y3OL6Mg=;
 b=GAgWzfDY+l3tQNLd+9e92TBgkZXXm6fcXnnesAxWWI3ydnqOCrG6iBNtTsIY3xFpSR3eWhH1fwT425RhaDoD440U7uEsYtvSwlGp87J2U71deDLdgf7Kz6b+wQq//ReY3KOS5hXmgDyD2L6K/ZvPOp/gj2ZYabP0EAsoyUBIwMoAsOjsmbIUfRnCSWimbRjLCwAG2WL3tiGX0DHL7wKUb6OF+KhjhtfVV1i32yxl3YquzqXzPsJculHiJJQNywk0YUKrVwED6OBALk7nDUA328TLhUUC7q9T3q/+FDV4zFVPE4A+LGdl0vf6x+ra/MaA8JaFvNFzGkB8j8R1ZafpTA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MN0PR11MB6304.namprd11.prod.outlook.com (2603:10b6:208:3c0::7)
 by CH2PR11MB4406.namprd11.prod.outlook.com (2603:10b6:610:43::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5588.12; Sun, 4 Sep
 2022 09:43:12 +0000
Received: from MN0PR11MB6304.namprd11.prod.outlook.com
 ([fe80::4c8f:1e3c:5288:d77e]) by MN0PR11MB6304.namprd11.prod.outlook.com
 ([fe80::4c8f:1e3c:5288:d77e%7]) with mapi id 15.20.5588.015; Sun, 4 Sep 2022
 09:43:12 +0000
Date:   Sun, 4 Sep 2022 17:42:33 +0800
From:   Feng Tang <feng.tang@intel.com>
To:     Hyeonggon Yoo <42.hyeyoo@gmail.com>
CC:     Andrew Morton <akpm@linux-foundation.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        "Dmitry Vyukov" <dvyukov@google.com>,
        "Hansen, Dave" <dave.hansen@intel.com>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        "John Garry" <john.garry@huawei.com>,
        Kefeng Wang <wangkefeng.wang@huawei.com>
Subject: Re: [PATCH v4 1/4] mm/slub: enable debugging memory wasting of
 kmalloc
Message-ID: <YxRzCX8WqOv3KESJ@feng-clx>
References: <20220829075618.69069-1-feng.tang@intel.com>
 <20220829075618.69069-2-feng.tang@intel.com>
 <YxC7Kda5g/aEqarm@hyeyoo>
 <YxGfkdvJcNJma/88@feng-clx>
 <YxRp5uz9KSY0S9id@hyeyoo>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <YxRp5uz9KSY0S9id@hyeyoo>
X-ClientProxiedBy: SG2PR02CA0083.apcprd02.prod.outlook.com
 (2603:1096:4:90::23) To MN0PR11MB6304.namprd11.prod.outlook.com
 (2603:10b6:208:3c0::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 6e5ebe9a-dc70-4770-f26c-08da8e59e1ae
X-MS-TrafficTypeDiagnostic: CH2PR11MB4406:EE_
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: CyJaJYcQACn7BgHuqYrivZVbj+QdGc1YScbzRyDpp1rUABxt4y/KWMSvLTIRO2aEfRjcBk0Td/gxozSLGUK/BFEv+PUWd3ic5TvzKzPDc1d1XOApLbZBbLQI+lq3X6JrpPJIPB//+PgsnMdbvnS/qLLqhOiKMoYtS0b3F79TUd18YYyoM8w4pbGm1z4vKGTjhZXtEsdeG9EGS4FaUCNoyBXdsjEAXFIcHB64YX8rIGDLhExmFg/fZxdLhDb7Kq0B2VvOh6QHuU31ZrdDVuPEi6RrrszG7wEwEfxI9DB/SiIklJeEhUf5ilQ6IB8sggl8j3DyzuWsgj5fFIl89QQR2OFaFOJK4aECJCB90uB1ErYWuA416OVObJ+Yq2KqiKWs2izmPp25O8tqJKTkjDqk0+OQDI3zcS4Re8bvI9LI3I5Q9TEb3unZkSnLXd/KIiakLJdxAH8oxfwkU0b1geZfUqIUTxfp/MUV1umZhaX4IQ8EAsrmG+SqN7T2qifMsJ0KPh4+BJAz9JVgDKRGVAIdfiptLZJpYnJoDPGQj7VeEl/dvO5sqmTrz5RBBoPr0wXnehg6JhWoDoTQH2gbLl2lE9F22kxp7bQkmSbAAFu/SSE7Bjd81ZZhwM+DroD2PgS2rDBJkr56S05Q8svzJpS3yUVI3O9PILaFWsqN9BwB6Zs+X8U/39vv1ZdxhBq0rtLb
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR11MB6304.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(7916004)(366004)(376002)(136003)(346002)(396003)(39860400002)(6506007)(478600001)(6486002)(38100700002)(86362001)(41300700001)(83380400001)(6666004)(186003)(9686003)(6512007)(26005)(8936002)(2906002)(44832011)(5660300002)(7416002)(316002)(54906003)(82960400001)(6916009)(33716001)(4326008)(66946007)(66556008)(66476007)(8676002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?ATUYQBK8lNJBUeARI53CZMmnCu2DqYNE4pmTGk/2fShrfJf8w4S5rmuon8Ad?=
 =?us-ascii?Q?i2JH4C63VswgHMwdDSTyAg0SssQlxwtzQe9wRerFguyO5vbaD+1qPUoG6afK?=
 =?us-ascii?Q?jHZJAqyHEuX7ljQPJFDan9c3ZeE8nVeNnU8MCCvgQ1iSoq8n5HfN3T0D1bto?=
 =?us-ascii?Q?7YJrWc4G7hL8qYf1fZ4TUxDn9IFw+VpCplImUnIvR6rmIWJwpSRwNFh3G9B1?=
 =?us-ascii?Q?8ocr+hQBLNpumMtHtiEHzX5wBuGYJYRdRJJCZtQxVDoQ7QrC9z4ZJhe08Nm9?=
 =?us-ascii?Q?IdD/V9aO7xdv3wCiW553tQooKOSnzfLkuNF+w+RE8ipf7xdw0u5sJSbwXN39?=
 =?us-ascii?Q?1arpyaJNeoGLIYyGjyMgKCmSXOttLDoj4jIhccnBG6eOQgEJMjVRbFyqS5KS?=
 =?us-ascii?Q?VgbkBrD54uz9HMwucAfyIuWlN4+NuvhkVAxDWocuvJrInPrmaal/jm02ykYR?=
 =?us-ascii?Q?yu3DTppDm52IBcwcU2/vtLYnjNIi94/8nw6Hvpv8B6o7UTZGq3oRppoO8TxF?=
 =?us-ascii?Q?74LkRwas0Vz7FQ6IpB1cBldLayDLbbpMs8kV0Z4piucqkcDaD+93Cjp0LmTE?=
 =?us-ascii?Q?R2k99i0gfokCCmNkS/vuBl7HVLk9kXVwpMlXn2ROyFl9YcOZ/4jKxFckgrRj?=
 =?us-ascii?Q?QN8G9umkiYyOY/vaxKxaAQJ49TsbY2GT5LwnULIfIe6+ckOy2EEhPHOT0M0k?=
 =?us-ascii?Q?2LBocjOuDwmTkWJg8LBgjh7kdQU0LXzvg+MNQ1a3ojbU07lk6G8Qap0FiKpp?=
 =?us-ascii?Q?iCeqAttI2vQ40rHVWIIXSfNavWiwBpWh4C7DmYhMbGjMMLQaCsgo79JFSKtf?=
 =?us-ascii?Q?RQgb+idKggz5XJleivOVknLq2CV6qMcML06l+fZKJtLpwF0U138PrYbhMVZC?=
 =?us-ascii?Q?xS6W3V5tiyaVRZZDzI9s5wCCcuJn0mxBqqXZE5SlHMIT4xvcbraGqHWOGya9?=
 =?us-ascii?Q?fmJ9YQzyU/1Zyu9e96CEbIDuEi4NcgXJRqB3BXwgsiZXeb9otAscputdDyby?=
 =?us-ascii?Q?aZZ1qMHTXHXVrFJtR0XWT+fUKFaA6Yj21KtneP3uZo7Xt7ilyrcfBgwuN/FC?=
 =?us-ascii?Q?G7/kGjQsBFpLBQosBnqNf8IR0YafyVGXUhMFeHxh6SrxQPAUIPA+iojzKjqM?=
 =?us-ascii?Q?f73eRL+S8s1WNjLlSPJLJ3vfiqvT8yfip/jloPsx4j+fny4DOBsFdbsPClR9?=
 =?us-ascii?Q?/QhEO8CqIYUBUEWg1vkQnE+iJyOeNSvNkAINlIISKoor8t6cOves+BBnFN6q?=
 =?us-ascii?Q?qH+/UPx833quWNK3M6kOURsv4Od0x1zt9UkISlUXKYe9GEwY9kDyyX6GqvIh?=
 =?us-ascii?Q?dT8kUuqplM058O9GMvdfNeUkhXBoqoZt2PdR9HedcONZZT8cw2XB86SEiaeN?=
 =?us-ascii?Q?fLvJgCaRJuO9/GpGmDBy1pKC3vJrbJLm0mV+gMcXqz54sj0J9dQyiSZ6973p?=
 =?us-ascii?Q?g5K8/4BkhwXOB994RAkOS2fOYcb8kcdZByMa9HtSDgt3TFCV/8+DCeH+un9p?=
 =?us-ascii?Q?XkqEi+lJYuNwFl8CE3pnfIwwdUiuUCyz3NUxucrkP5bLcTvaJ7uwGaN/16PD?=
 =?us-ascii?Q?1B1EaptnLBSkYKf8o+5kiqOT6njc2doauXa19V4D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 6e5ebe9a-dc70-4770-f26c-08da8e59e1ae
X-MS-Exchange-CrossTenant-AuthSource: MN0PR11MB6304.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Sep 2022 09:43:11.7481
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NOXewKdUiODZF4OtPVVzhyBwId8MAbZK4nHjvczziZzrpgRgV5dkZG4nfMvizaW6ZmpP0TehDUdfL2e+DaK7Jg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR11MB4406
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Sep 04, 2022 at 05:03:34PM +0800, Hyeonggon Yoo wrote:
[...]
> > > 
> > > This patch is okay but with patch 4, init_object() initializes redzone/poison area
> > > using s->object_size, and init_kmalloc_object() fixes redzone/poison area using orig_size.
> > > Why not do it in init_object() in the first time?
> > > 
> > > Also, updating redzone/poison area after alloc_single_from_new_slab()
> > > (outside list_lock, after adding slab to list) will introduce races with validation.
> > > 
> > > So I think doing set_orig_size()/init_kmalloc_object() in alloc_debug_processing() would make more sense.
> > 
> > Yes, this makes sense, and in v3, kmalloc redzone/poison setup was
> > done in alloc_debug_processing() (through init_object()). When
> > rebasing to v4, I met the classical problem: how to pass 'orig_size'
> > parameter :)
> > 
> > In latest 'for-next' branch, one call path for alloc_debug_processing()
> > is
> >   ___slab_alloc
> >     get_partial
> >       get_any_partial
> >         get_partial_node
> >           alloc_debug_processing
> > 
> > Adding 'orig_size' paramter to all these function looks horrible, and
> > I couldn't figure out a good way and chosed to put those ops after
> > 'set_track()'
> 
> IMO adding a parameter to them isn't too horrible...
> I don't see better solution than adding a parameter with current implementation.
> (Yeah, the code is quite complicated...)
> 
> It won't affect performance to meaningful degree as most of
> allocations will be served from cpu slab or percpu partial list. 

Thanks for the suggestion! I'm fine with it and just afraid other
developers may dislike the extra parameter. 

The race condition you mentioned is a valid concern, and I have thought
about it, one way is moving the set_orig_size() after the redzone/poision
setup, and in 'check_object()' we can detect whether the 'orig_size' is
set, and skip that check if it's not set yet. As the manual validate_slab
triggered from sysfs interface is a rare debug activity, I think skipping
one object shouldn't hurt much.

Thanks,
Feng

> -- 
> Thanks,
> Hyeonggon
> 
