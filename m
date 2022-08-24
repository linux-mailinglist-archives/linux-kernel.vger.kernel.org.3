Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 56A3659FF50
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Aug 2022 18:18:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237869AbiHXQRz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Aug 2022 12:17:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231451AbiHXQRw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Aug 2022 12:17:52 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE99FBF6B;
        Wed, 24 Aug 2022 09:17:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1661357871; x=1692893871;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=wu0pu2sRmux9CIhgZacCdvxCgr9kVqbUM8Zmq1mT+qo=;
  b=UocAChziyuL9MagDf4WaPke/Tm7jj7pFOqyX4nHxBEufV3RumLW8NApH
   FMrJ/RlRRALjcC+ht7dF3iD0t3lZg1ruSiR0ohO4egjee944DTE7BKOkG
   ahfwlYL1pvRZKEpsDGbVoHC9OUWUuwpwINmCVE4NoyBbgA9ptD1+2M9VP
   i1YGppnA/gTinFEhM4R/ssORl0R1Qpcxs+nrhL1cCqnqq3U76aMXmomAP
   O+dzOwjUmWLNohKzTDPsGuIwRUmog/nFjLo1M6LUTkONJUC62Vy5ydDdS
   3WOQD7BmV2cNRxjD/L7SJAYyUCD0V0iZMywPLF6Gz8wMiCqZR0TdelaXR
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10449"; a="294011462"
X-IronPort-AV: E=Sophos;i="5.93,260,1654585200"; 
   d="scan'208";a="294011462"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Aug 2022 09:17:51 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,260,1654585200"; 
   d="scan'208";a="670571785"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmsmga008.fm.intel.com with ESMTP; 24 Aug 2022 09:17:51 -0700
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Wed, 24 Aug 2022 09:17:50 -0700
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Wed, 24 Aug 2022 09:17:50 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31 via Frontend Transport; Wed, 24 Aug 2022 09:17:50 -0700
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (104.47.56.43) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.31; Wed, 24 Aug 2022 09:17:49 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Q2kokY1kbk25um/Sjt0aX7nnwKeeebabhxU3m4KJX0aJxqL3tzf5ixB3A6SY6qhB/rAxn0AM+HjYpmkpePURCnHik7qw3OPrncE30LkCpgFlR15aXJWkVMnDRz6OwM9kZWK2IBw8xfwhXX3dobtb6A4Xcr8gPXOV5ovo1SNfSTLZAto1iAxST7PfnOWagsmWDrQOjAk7Tpr/l+p1SQ0HyadgKV4ZSL7hN8lXy1KJN+ERWahvDo0DB54p1n/EVmZv62l0Brv+Ylo4YfBpGs09xlwm2HhU7Y8zjHLLFYAyvyGxArzLP6CQYmxl36ezRlAHRya+QFD5J2sbvP968tVPdg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6m8j2s9JjC8IVw5hL4bo9g9crbiQ9lifbEBqFDMiVRs=;
 b=GLHu2VGAUqSnA2stStxlUhhLe+9TvKlRRi2UN+e0+fVjqQmzuJn2qeM19ErfGb3ZGycAvPZTmBvZxbb0iz/cBWp4p7J7GFizCLznK9Vhz7zZJejVPexIVSt5bKG/XuhdJYlkGx1FTUpKVLJCOM2st+gcDArOya7Hywiz2z2aOl0Ub+mUrwXuRBfaP+BVnvGGRaN4gqIrSweSudMbfIyGnIF44Yujx6Us5tn5C3oq1wmSVBfc8i5S0eRokuIC0oDcAvyXqdVvIxrspSvVWNgyjElKILK71oOnD3/P3pn1zT0tAUu/b9wMk1+cI1NYU/xxQGSiwcp/iuwx8tefurVvrw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MWHPR1101MB2126.namprd11.prod.outlook.com
 (2603:10b6:301:50::20) by CY4PR1101MB2311.namprd11.prod.outlook.com
 (2603:10b6:910:23::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5566.14; Wed, 24 Aug
 2022 16:17:46 +0000
Received: from MWHPR1101MB2126.namprd11.prod.outlook.com
 ([fe80::9847:345e:4c5b:ca12]) by MWHPR1101MB2126.namprd11.prod.outlook.com
 ([fe80::9847:345e:4c5b:ca12%6]) with mapi id 15.20.5546.024; Wed, 24 Aug 2022
 16:17:46 +0000
Date:   Wed, 24 Aug 2022 09:17:44 -0700
From:   Dan Williams <dan.j.williams@intel.com>
To:     Davidlohr Bueso <dave@stgolabs.net>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
CC:     Adam Manzanares <a.manzanares@samsung.com>,
        "alison.schofield@intel.com" <alison.schofield@intel.com>,
        "vishal.l.verma@intel.com" <vishal.l.verma@intel.com>,
        "ira.weiny@intel.com" <ira.weiny@intel.com>,
        "widawsk@kernel.org" <widawsk@kernel.org>,
        "dan.j.williams@intel.com" <dan.j.williams@intel.com>,
        "linux-cxl@vger.kernel.org" <linux-cxl@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] cxl: Replace HDM decoder granularity magic numbers
Message-ID: <63064f28720cf_1b3229490@dwillia2-xfh.jf.intel.com.notmuch>
References: <CGME20220822170552uscas1p1b1ee530bf38a14806010d65d1b593ab0@uscas1p1.samsung.com>
 <20220822170510.125082-1-a.manzanares@samsung.com>
 <20220822171703.sfizbmn6retpxggi@offworld>
 <20220824104401.00005cd4@huawei.com>
 <20220824153122.2bgths6lnsxlolos@offworld>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20220824153122.2bgths6lnsxlolos@offworld>
X-ClientProxiedBy: SJ0PR13CA0146.namprd13.prod.outlook.com
 (2603:10b6:a03:2c6::31) To MWHPR1101MB2126.namprd11.prod.outlook.com
 (2603:10b6:301:50::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 0eaf3c64-f550-40e2-8b3b-08da85ec2e7a
X-MS-TrafficTypeDiagnostic: CY4PR1101MB2311:EE_
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: pomh2zPiiZqDNULs2NszDLCMzBMwpiKVBsY98Wj2RZKoo4IVKwCN3FxS9s4lkhakq0ggP/VCfu9/aSaVyzMrmI4ghJWcy4RkAfcXS59C4JoDQvAeUPs8aUx2xE0yCYgfRl1GLNi4lq1hXtMBWR3Ly02t88KnXLozKp5JkPFs7aQSFOJwUyf69W51Q4fPkAls2aIJN6LTbhfg7WxpviEJp6KzyupSYMZ1PdN1RfkORqFUG7wYTi9aaOwW/Au191YQzHNM019vw7BqwO/P11EIATtRAUPKjxEEyXGOeQHTHeufVD7GIRbxFpZ73dCLciXk1KwCji141BtyNtLdFwxTFxUCSuqFiGEV+oOUlnRlA+bWNuyihxSOgbHqaT9R2jbdHDFjCDHV7px6CjofZLW47sQ2fRrCjSTs5y2hRJ7UIEH7+P+M3LYe0xVU1AmGQcHIzM/iTs1O0Y0v6zfxq9dmYwABcFwm4faiZnbLnJdsh08PLYEhz0GbozBvBnsSLa95JTOzxUx7+URV+P1h3mi3wfXi/97Rs3Nus4C2d4cP8+7FDiUuvb/VZREd1J+ZgUxGGUxTrUCdb8G1Qo4QUUIQvpjV1ld0DO4NyWsXNTJMfQguHjAhQsiu1t+fa60itZjFiDQl1NixxX2e/s3JwlL4W+DM//qYn4HfZS5DlLkhxemEQv7vX8yMp+mBOUg3JQwKGYkX1Ne+SlEDH4F8e+lyjw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1101MB2126.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(366004)(396003)(376002)(136003)(39860400002)(346002)(26005)(6486002)(9686003)(6506007)(6512007)(83380400001)(478600001)(38100700002)(186003)(4744005)(2906002)(8936002)(5660300002)(41300700001)(66476007)(66556008)(54906003)(86362001)(8676002)(4326008)(110136005)(66946007)(82960400001)(316002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?9iVqrlf9mDzUsGne1n3LFxW0g4KcCzaNF+G1jUodmorx54JbGuYiciKa4JR5?=
 =?us-ascii?Q?9XNAuJ8CgeLGepWUMMI8i+w7fpss0CQtuAwudMINwMUUINg0K+ZCJfvejL0c?=
 =?us-ascii?Q?P6XO2M9L/iojFGuYygOrBMLpmVkzdk4kpxgZwpidHRh9/RyBB9StbrPmGZSr?=
 =?us-ascii?Q?2zmvJ0d2FsXE0u4q058fL0UyBEiI1+CpwtKWPVGe+LK9e7now11pwIRApYaR?=
 =?us-ascii?Q?YDLohMbKEmBATbnVvBD5wIjs90UtUndDmWxUw/ax0Ke+8FDztLQIgbRyZBPg?=
 =?us-ascii?Q?ErP35UXd7Mya+OkALeMpym1HXJKEof1buSf7pM0WGBRrBNTfTwjbQB5Xhr9d?=
 =?us-ascii?Q?lJshjpKhCYMPsF1VJKbVfWZhex6gBahCLoc0G6TD34Hvzypd6cXnOh7nT0pk?=
 =?us-ascii?Q?ybPtG4wMjbQ7HMv11IGq3iBxYyjEJNhSrZKpP1qAJrD47ufrFoF6Ob4KJzEJ?=
 =?us-ascii?Q?bXjrCZFkFp3DjlyyZWX7GH1y/hSWo2FGw4JMy98fhWX5UVRDqoMPva7ZWTjf?=
 =?us-ascii?Q?R1AtFVkOPjo52yuvLnd4sN5MzMxb8qJcfb9iDuqq6pDxuOoNb8fEQhX43u6n?=
 =?us-ascii?Q?bVpgUi+mKynENVG1AJU9k6H+YECjBdOcw9eneryrvhZIZjXjSBX8Qn66A1ZV?=
 =?us-ascii?Q?f4Qweg3Cj4Ilf1BwOhwqFZLqyfpbf8iWu6D04FW5pOSeRhx7y6gCKADXpHos?=
 =?us-ascii?Q?ZCnORcWiTFI28mlHltCfIZ+d4PZ6FWqCVmPA+7TcjRCY4I8OiSy/ARlzBTDk?=
 =?us-ascii?Q?DMmhd+0U9FsuQJfK3OdhznrsYxZAo/43v2RfGjcXwMPlefo8OqN0BFcCcAwY?=
 =?us-ascii?Q?hbzv1oXpWiF/wzmAXQ6yqCSYAGk8gSmDOzulOefG+BnHzkRbBC8NTEZzCtde?=
 =?us-ascii?Q?TVPeclVG9ySoCQrPnZmBFgzEp3zSMQzgHiTORez9i/k1i8+Tr93G9Gj46b8H?=
 =?us-ascii?Q?JiNbqSFlkZQ5vhLQUo/AxC0STjMlv34SyF+5lBWzeJb3umAko8S4G/b1ODai?=
 =?us-ascii?Q?ga6sNNQ26AjhODCqFMHdGoUxUezDqvOsind37cdvefWTPLhglWnf4pXh0Y0x?=
 =?us-ascii?Q?Htp3LLo8NOjqYKNh2NFDh46/bulVIHrFAMyyWgUSn+Wm4Veqt1oeuvg8l5nG?=
 =?us-ascii?Q?xQHd6QP+xFU1ijN0dJJQahyjC8oMiOsNq/MMtrqoLhyYPWsfonyAUb8lRyLY?=
 =?us-ascii?Q?X6JRPuQEDoXdCOCaRluawPwNQ4kBMG+3ibSgoP8JNypR6vxFLcyUiFWbIHBh?=
 =?us-ascii?Q?fixqGpwvzt5R/0Kep3rh5BgeGD2R9+ZriTnv9w1mgGLwEg+arc3M8IcyA4eg?=
 =?us-ascii?Q?Y+CsK31VcutqiknWW28/reO9cVeQ5BOpWYoBXwQdvYtzfHbBPkNFbPARX1Yx?=
 =?us-ascii?Q?DSr2+KkYKiYGvO/wa18Ed9xDDXWGlcS18Eus/oJTv6OHtQpSyqRkXsA9vHJ7?=
 =?us-ascii?Q?swG6gpZI2aAJ4X/FHZeoM4mdMOYs4Fxj5crelOhpVZx1cGZDTqKCWyOb+1xL?=
 =?us-ascii?Q?GwijOUkkvh3l4vOWXrA+bVU8JRFUTy9cM+cbZgm9jtHOPZB2iTAZkgjpTVX1?=
 =?us-ascii?Q?U4VnIPmhwh0DtQkeTfsaYPWFEcflDcdtNHOOEqnGgegoPi9gE9IiK/6aIzIC?=
 =?us-ascii?Q?Ag=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 0eaf3c64-f550-40e2-8b3b-08da85ec2e7a
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1101MB2126.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Aug 2022 16:17:46.6467
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7j59DCYzaLUwLv/5WCISJspbAJwR08a7M+VkM6L0ArzbwQRHITrdQi+2Hi4WD2TJiByq66Ql+xDdbemzDcQIutJ3CkXOj//4w4fIP4xrRRU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR1101MB2311
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Davidlohr Bueso wrote:
> On Wed, 24 Aug 2022, Jonathan Cameron wrote:
> 
> >On Mon, 22 Aug 2022 10:17:03 -0700
> >Davidlohr Bueso <dave@stgolabs.net> wrote:
> 
> >> Actually the whole drivers/cxl/* could use updating the comments for 3.0.
> >
> >Interesting point.  What do we want to do on this?  Most similar
> >cases I've been involved on rely on referring to 'oldest' compatible spec.
> >(this is true for ACPI stuff for example).
> 
> I find it incredibly annoying to reference table or section numbers from old
> specs mention in the code. Unless dealing with specific version things, why
> use old specs at all?
> 
> The main drawback to this is obviously the constant need to update everything,
> so...

I think a happy medium is all new references being 3.0 and touching any
old references and refresh them up to 3.0.

That said if someone wants to do the work to refresh all of them, and
someone else wants to review those updates I would take the patch.
