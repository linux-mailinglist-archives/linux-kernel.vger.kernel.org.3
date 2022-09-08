Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CCF5C5B14DB
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Sep 2022 08:42:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230181AbiIHGl5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Sep 2022 02:41:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229552AbiIHGly (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Sep 2022 02:41:54 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83653CD50C;
        Wed,  7 Sep 2022 23:41:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1662619313; x=1694155313;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=NHbZPGIKxJq9KeWbVA5s+v/vDb5yy1X7koGuc8LCpZw=;
  b=cfrTeB+rQHpOI2A0o63hQf9R93zvpwwLsWX2MhHJ8lI063OIst8jRaUq
   4PrgdnJqJijsDOJvWpVs9+JYAYTFyWRiGiVronMcHq451CC4iQA285HHF
   PYWyji5oy8PhNkX7gzpd1rg97FaYl8Q8XsH0JHSo2w136K6ACZnnfBmNa
   8Z3Bzs//zhwpPPSOv5RoSxwuaCwJpd805DZIeJcrNuZ59wLpakVORjuDZ
   753MXhwCwIobC9e3PLwOmdLU3kA68jN1Pg2NLx1fVlIoxLQPgWV3R3Qtf
   0+2Hi7asFO6PBwdc0amnxfhPMU3NWzmk7FSWQqYOrKuyFJS2rjrZEzS7l
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10463"; a="383378375"
X-IronPort-AV: E=Sophos;i="5.93,299,1654585200"; 
   d="scan'208";a="383378375"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Sep 2022 23:41:53 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,299,1654585200"; 
   d="scan'208";a="703892543"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by FMSMGA003.fm.intel.com with ESMTP; 07 Sep 2022 23:41:53 -0700
Received: from orsmsx609.amr.corp.intel.com (10.22.229.22) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Wed, 7 Sep 2022 23:41:52 -0700
Received: from orsmsx603.amr.corp.intel.com (10.22.229.16) by
 ORSMSX609.amr.corp.intel.com (10.22.229.22) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Wed, 7 Sep 2022 23:41:52 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31 via Frontend Transport; Wed, 7 Sep 2022 23:41:52 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.49) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.31; Wed, 7 Sep 2022 23:41:51 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LQpFXUisWTIwoXNWtEadQ1NdfqyGQOMtASzdnGkAO3adVRvTZEAzCUUMshfWUq1UaWZzbV8OrbDqJqTLBylLxWDZJ7SokrEaHQx+TncQ/njVYORIb/+OALu3XIvnj+tOxiwXdUt363BgQ2nHXNXBhVJe7U/+gCUXZPUEFtajHTpy9r4IeeKPQv1J+4kXqhwzwg9POHk8Ps3/8dg1jjdD4B5LuyI0XxeqpFOqVQqoS405M4fylRjQgStDTbcad+xEn4FMAqJda/9hG8fv3ecTzdIkxoqI9CVNkx11daSxId9AREOWQA52D9oyg83hdfVF15ZiyPuYwteRXtYs0Pj2Tg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YG1iFrpdPRJAOlzlWZbuYxlSsmgWxjvlBBefRtxIe/0=;
 b=QFGVCxgXf9xWINiPJpvhEPyHgBAOIh8hLs7Knrgxu/RFrQ2MtgKeHVQJAgXx/e9sQmdl1za6zygqTXEA7E1mmumfj6XM4O1f1Hd7Lcpwhm8myarmLP/NDP8ePYeNKkdTDMUDuRkODMWdb9rHIO9HwfBJusZP5sp1xm4UuZKFl+bKGIHX/451FJ/KDJkXazX6yKxeJIpnhD7cf+QY8TOaDgEm1JnN+MPS/LikxlMcZ+mCg2maM9E614DTKvikR1KigNi4GEL4yLUJi5T3TDeZ2wuQ2RPHlh9V+zRKXQ7KK8AU71/CAD1mk4e7xhjfwFbDTaKUdbFygCnY73KdT7tm5A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MWHPR1101MB2126.namprd11.prod.outlook.com
 (2603:10b6:301:50::20) by BYAPR11MB3173.namprd11.prod.outlook.com
 (2603:10b6:a03:1d::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5588.14; Thu, 8 Sep
 2022 06:41:49 +0000
Received: from MWHPR1101MB2126.namprd11.prod.outlook.com
 ([fe80::9847:345e:4c5b:ca12]) by MWHPR1101MB2126.namprd11.prod.outlook.com
 ([fe80::9847:345e:4c5b:ca12%6]) with mapi id 15.20.5588.017; Thu, 8 Sep 2022
 06:41:49 +0000
Date:   Wed, 7 Sep 2022 23:41:47 -0700
From:   Dan Williams <dan.j.williams@intel.com>
To:     Robert Richter <rrichter@amd.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
CC:     Alison Schofield <alison.schofield@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Ben Widawsky <bwidawsk@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        <linux-cxl@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Len Brown <lenb@kernel.org>
Subject: Re: [PATCH 00/15] cxl: Add support for Restricted CXL hosts (RCD
 mode)
Message-ID: <63198eab19be2_5801629439@dwillia2-xfh.jf.intel.com.notmuch>
References: <20220831081603.3415-1-rrichter@amd.com>
 <20220831132329.00007c46@huawei.com>
 <YxBrAH1EZI8kuQdi@rric.localdomain>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <YxBrAH1EZI8kuQdi@rric.localdomain>
X-ClientProxiedBy: SJ0PR03CA0166.namprd03.prod.outlook.com
 (2603:10b6:a03:338::21) To MWHPR1101MB2126.namprd11.prod.outlook.com
 (2603:10b6:301:50::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 74dbc6fa-15e6-44fb-a767-08da9165350e
X-MS-TrafficTypeDiagnostic: BYAPR11MB3173:EE_
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: C+16OKSo9U3A6vgvP38YDZdFX2ByIeVa03CEclR4TAXVR7z1Mj5R59Ipw4r+4jhUmarMMtMFbSjDC6gfIL4L8+aLVo+s0KoW0Wuh5y9AN0YQTZSg8/7Rp3Hhiijj8dY7kw8QET84n1de/kM8JwOrHDil+++62PgLxTDvGJzm/z3WTBq5MhH4zX1RzF2vis9t3N5fr4b+b6++V/lK1aCDICs3E3eGN99228Vqn+OnC0o+vviafw+yR8g9hbIhcdXgmFXgBhiZ0lfYnp7xfWuAk4DPIAuGsbBQXha1HLeQQLZINcNVLFnK9H9LPnRmitiQEvJnQ9fSNqYN/8dv70+R25RkVuNN29dsl/sJVmIs8y8TCmyZmBn0/9nygxPVdoUcrdzm9WBctd9jRbQp74sQyUNHvPdAOuFjQTOQboIOHmlNsNO/T4Inw2uo4tq8OnEVqtNsj/OSrqKGQySXSoAEgL51aFBTAlMzYD7wHEzTTrgIi/Yo7Gs0Mcr9lecd+sLwfkgxBWekaUaRFcw9rdiKCp6hRDq+vwJH8c3eGPpRLcatAtg5uM1CRrHXgFJQsAtwB9qeQ3De9N6qB5i46QXHl2AoeRmBxHfGJlCxJMT7QtRlV2hLxhtttn/bOzKS8E9Uu5NFRvYssVDh6M2j7PK0BhOhlbKw7x/iybtMF07bWa5cOYQHN0WYMsUosILwyf97WkKtVqnUbgAVWf7MiFgM19Py6Iye+GldwQDXa4k030A+uUstqhOmtY3AiHq17OC04y4MgYjUWj5/ZHkNG14SMg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1101MB2126.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(396003)(136003)(39860400002)(346002)(366004)(376002)(478600001)(86362001)(41300700001)(26005)(9686003)(6506007)(5660300002)(6512007)(2906002)(8936002)(38100700002)(53546011)(186003)(82960400001)(83380400001)(4326008)(66946007)(8676002)(54906003)(66476007)(966005)(66556008)(110136005)(316002)(6486002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?CQ3QByaEG0Y95bRDWicRYBTxUSZymmfu2yNXjJIVAntTMesswCM0ZMH5fzrr?=
 =?us-ascii?Q?6rqsuD/Le20TTSB4DL7c0DN+Qw9wAU6FSf9JArE7tKITeJEfKFQtjVHu/dXE?=
 =?us-ascii?Q?yFabXEykK35rDZCxNqmxhNd4eKIHnOonQiHoXKXSOuo4dC4ImJUyfsjduQwB?=
 =?us-ascii?Q?Ei/LpAaAAXwwF9c2mLnepeGKgBHPZHKpNWMEp+5RIB9sLHarR5LvEZ0uH5Sc?=
 =?us-ascii?Q?9l7eaDpe5cgiQTaVaTuKF2cOoep3yGzk0f/mIFlYX7emRsWYcnsD2M6/kv1p?=
 =?us-ascii?Q?lW5QGRmP5WI+/XflADE1h+5Gpvs/9NxvuhBr4eyFd1fGxtp38loYVa9uQOys?=
 =?us-ascii?Q?eiawXJBDwFQAIPOa7VapYT0rRDSdGyahOiQpzlKWGWokWeNzTSRoMzt6Caou?=
 =?us-ascii?Q?mn1cjoWWdEyAJApdSyAi52y/1uEtcrO/mVpobgT7acAQ5ccnwbZ325xNiBga?=
 =?us-ascii?Q?C3/AXlbXDk44HLiHkL92XEhb+FGFz6LfeC6xAy5vkGFbqCDzYvB6NObDM8In?=
 =?us-ascii?Q?bJR1E/k7YPkr2ltsG7miiLeac4gOqzcin8VeZLWkuM0P1uLTSYU85fZpXb7W?=
 =?us-ascii?Q?zp/JxIU8sKyFwFRh/lPFctiD+WNR6vx+1DJV1EEo0AWV3MzVL0Pk3BDaiG5U?=
 =?us-ascii?Q?oOg+KBb9gZuiRK4lqpjmbbXoAjlAEaONe1Idr++Z2gjKjfQ+gUQU75dY9S5i?=
 =?us-ascii?Q?yl3YdkNMYdvXF2BHnVaXniPnJWo+rCQ1ajxnzrUBR1vzcnNNRB0BZwelSfSa?=
 =?us-ascii?Q?MFxr1/fg/xD3EojkASh1FbB41u1yn9Mqg4atePsoscOMShdIh0mPyjJ/77+y?=
 =?us-ascii?Q?aUpa+oay6vk/u3RhJ7uvJHKr1H1rdS7EbjJQ5inzy/EiRRBLgADvsH4GAK+w?=
 =?us-ascii?Q?NJwQiwP7JEMoeN0S746vy3IJvDGGJsIKSfHZW2cROLIQNTMUD9aGXFLcP81O?=
 =?us-ascii?Q?iDJx/5umvNVfbPQwzoc6lApWW7qBOyPj1DuaIKgpc9Ie4Sg2rMG3IC3TXGXY?=
 =?us-ascii?Q?5MYPwiseBK3Pnlhhs0dRyoyHplP03MfbEuJ5bUaAmnbIkxOUnUh0oDHJZy0G?=
 =?us-ascii?Q?8O0vhz0GXIhKQy7ilsJVws83nlXNfYTFSqlmlbtiqjoWQTP3V+Qq9qdBiHVt?=
 =?us-ascii?Q?rlNbjq9dT1th9AhUGn6WcF2efVe8Qur62xFwTUoJ4c7EzRNXNBR4uJH5nKXT?=
 =?us-ascii?Q?viW5R+VHSfFCa4weE17o/Z6h/qEmto3Xi4WxgwDcOl7lSk2y2uha3B3JYwlO?=
 =?us-ascii?Q?7vpLjGJ1WER1zH9c/FDYOHchqDLrK4SK3to5Abh5GgFT+FcifZrMQqWMZkeV?=
 =?us-ascii?Q?CRIdkT+eP813rgfBcbtDVEIfbHJ2pPF/Q0WEkE6lyAvgoIl1Htaqiow57rPA?=
 =?us-ascii?Q?AGz3c2BY2kQiIYK6hkLB6iiyYlU9zGwSJNaW+zXE7h2wrpMjLAjExWI0EJfO?=
 =?us-ascii?Q?oEHL+0d5PBlWj+MqVjqhmuqrNaUIbc5FHGq6Cppe2Ca90TvdgVd9NOIia1WF?=
 =?us-ascii?Q?yfqw/ox8OB/vLWLGMEio8fMmtxrS0hdX8azrRmMvJDRlSt2n1Sp0zXtS3Tkx?=
 =?us-ascii?Q?uqLqKdAEA101QUluY7VJACGBpTM+SRw/k0ve07mRXdymqq1KoV+gPNGxN5UH?=
 =?us-ascii?Q?Xw=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 74dbc6fa-15e6-44fb-a767-08da9165350e
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1101MB2126.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Sep 2022 06:41:49.6567
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: joGB3Z6AaZ3y7T9MYuJQhpJO7H9IOOxHAW/s2EBXVxliFGdXNk1fFJSlp+ggMPe4AZZ8SRvlJG6JpXcP9rvXxuW27tHshDa6GTL6mtvwGgY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR11MB3173
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Robert Richter wrote:
> Jonathan,
> 
> On 31.08.22 13:23:29, Jonathan Cameron wrote:
> > On Wed, 31 Aug 2022 10:15:48 +0200
> > Robert Richter <rrichter@amd.com> wrote:
> > 
> > > In Restricted CXL Device (RCD) mode (formerly referred to as CXL 1.1)
> > > the PCIe enumeration hierarchy is different from CXL VH Enumeration
> > > (formerly referred to as 2.0, for both modes see CXL spec 3.0: 9.11
> > > and 9.12, [1]). This series adds support for RCD mode. It implements
> > > the detection of Restricted CXL Hosts (RCHs) and its corresponding
> > > Restricted CXL Devices (RCDs). It does the necessary enumeration of
> > > ports and connects the endpoints. With all the plumbing an RCH/RCD
> > > pair is registered at the Linux CXL bus and becomes visible in sysfs
> > > in the same way as CXL VH hosts and devices do already. RCDs are
> > > brought up as CXL endpoints and bound to subsequent drivers such as
> > > cxl_mem.
> > > 
> > > For CXL VH the host driver (cxl_acpi) starts host bridge discovery
> > > once the ACPI0017 CXL root device is detected and then searches for
> > > ACPI0016 host bridges to enable CXL. In RCD mode an ACPI0017 device
> > > might not necessarily exist and the host bridge can have a standard
> > > PCIe host bridge PNP0A08 ID, there aren't any CXL port or switches in
> > > the PCIe hierarchy visible. As such the RCD mode enumeration and host
> > > discovery is very different from CXL VH. See patch #5 for
> > > implementation details.
> > > 
> > > This implementation expects the host's downstream and upstream port
> > > RCRBs base address being reported by firmware using the optional CEDT
> > > CHBS entry of the host bridge (see CXL spec 3.0, 9.17.1.2).
> > > 
> > > RCD mode does not support hot-plug, so host discovery is at boot time
> > > only.
> > > 
> > > Patches #1 to #4 are prerequisites of the series with fixes needed and
> > > a rework of debug messages for port enumeration. Those are general
> > > patches and could be applied earlier and independently from the rest
> > > assuming there are no objections with them. Patches #5 to #15 contain
> > > the actual implementation of RCD mode support.
> > > 
> > > [1] https://www.computeexpresslink.org/spec-landing
> > 
> > Hi Robert,
> > 
> > I'm curious on the aims of this work.  Given expectation for RCDs is often
> > that the host firmware has set them up before the OS loads, what functionality
> > do you want to gain by mapping these into the CXL 2.0+ focused infrastructure?
> > 
> > When I did some analysis a while back on CXL 1.1 I was pretty much assuming
> > that there was no real reason to let the OS know about it because it
> > couldn't do much of any use with the information.  There are some corners
> > like RAS where it might be useful or perhaps to enable some of the CXL 3.0
> > features that are allowed to be EP only and so could be relevant for
> > an older host (e.g. CPMUs).
> 
> though CXL RCD works with a legacy kernel or without any CXL
> functionality added, a CXL aware kernel can be useful also for RCD
> mode. RAS is a topic here but also gathering device information such
> as status or topology. Everything where access to the component
> register block or mailbox interface is required.

Unless the BIOS is going actively enable the standard CXL topology with
ACPI0017 then I think it should be hands off for the OS. The maintenance
burden of some of the hack to work around missing BIOS descriptions is
non-trivial, and it is still early days to encourage BIOS vendors to
enable what is needed and set end user expectations that these
pre-requisites exist.

As far as I can see this enabling adds an additional CXL "root" device
and I do not think userspace should need to care if a CXL 2.0 device is
attached to an RCH or not.

> Another plus, the CXL hierarchy becomes visible for RCD mode in sysfs
> and the device hierarchy.
> 
> Reusing the existing infrastructure for this makes sense. Many
> features overlap in both modes (e.g. RAS, mailbox again, or topology
> information).

RAS only if OS first is supported by the BIOS. Mailbox support happens
with or without a CXL root device. The topology information is certainly
important in OS first error handling, but if its firmware first its
going to have its own FRU id scheme. Much of the common case topology
information for the RCH case (like which RCIEP is hosting which CXL address
range) is covered by this pending lspci update:

https://github.com/pciutils/pciutils/pull/59:

...although that needs some help to get over the goal line.

Otherwise the topology information is mostly for describing all the
degrees of freedom of a full blown CXL 2.0 topoloy with host bridge and
switch interleaving.
