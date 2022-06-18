Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BAF2A55018F
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Jun 2022 03:09:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1381373AbiFRBJA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Jun 2022 21:09:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236606AbiFRBI6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jun 2022 21:08:58 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 613156A028;
        Fri, 17 Jun 2022 18:08:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1655514537; x=1687050537;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=aDOBZGX00iw2ZRp48m7RKeqSsROCsQvFnTwm59Xhe/E=;
  b=Xdi6hhCtyBFepBuqO2G2GTGu0zpXEfNdKKRpDFecuV2U4+oI5grdoaIm
   Mabp5ujeUVKbWfQX6PsnWPN+U8OALdE5MFLUdko6mNZlFLB3AnLEI2Fky
   7eepYvHvKmpjbFs1oLZuX/NqJt3lGO5hNB8TT4K0i4d5HTRJE1g0OJLBZ
   4y3lhiT7QgSiaEbs62//0NNF0ADC4Tt5EvQKZt/9i29e6eC7cXvDs9nu0
   2NZEb7xRcRSCMvlo9rrUB8Kfs61Po/t+K2R3MkNiqQ/AQKidOaRuW9Xc7
   QQ4Bcu6bbCve+v4lbkTlwymBeHkpyM1xrevHYf+umc14QvQyJW2OTOVu7
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10380"; a="277166333"
X-IronPort-AV: E=Sophos;i="5.92,306,1650956400"; 
   d="scan'208";a="277166333"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jun 2022 18:08:57 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,306,1650956400"; 
   d="scan'208";a="537010650"
Received: from orsmsx604.amr.corp.intel.com ([10.22.229.17])
  by orsmga003.jf.intel.com with ESMTP; 17 Jun 2022 18:08:56 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX604.amr.corp.intel.com (10.22.229.17) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27; Fri, 17 Jun 2022 18:08:56 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27 via Frontend Transport; Fri, 17 Jun 2022 18:08:56 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.168)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.27; Fri, 17 Jun 2022 18:08:56 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HOcNhPlQqEta5pXOLaUJFWJsT9qwfufNvIdFZ0p4Z9VUdw6BjHdbmEc7fYNw/kyE0EIwgQPpB7wKL8cQOHedg6TUjLpDYoOBDvGgxR2Pg6qH3Jyb8losu1AEcFPzFDkCeIcEXlWfnoJOmnAMuNLLn1A9qRuimQ7sRkoqOGQlj1FL2xh+d3PI48MkO/PnI6cNSOxOnRGMFyZqa7bimNpZANf0FxOwlOyOwk9wxHT1hkfXhGxozgjQjIk69XhjEwe98bIBUUwh3OX0U+05SzhVFYabRPiLuC7F38EiJn9vcm14r5FLBLH7Ubm+kuhdSRR6dYHpFDjwK5AZ+BgJGSiFqQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wJpuUZNLfbGMU4/srISeOSGtYmlMP1KluWg1HE6isEs=;
 b=juOU6odWLi9rKVnZ8qgJ1a98i4DaMsg8gpDw8E+h4xlWxpCQ2Lddb0oxxaIx/CNbKucKVUNvxE2N43dnGX7wisTGWeQwms6x8uUS59tfzT0qvscFsNRBGN6YKjZVDAdmiCKYxOpxFsn1paxbnLyL+XbV6uImuwliH6Qm22I8+s32UJzlB7Tjt2U+zI+4OfMa9/Re6qV0ZhY5CWD5SrvkgFe8PSsPYfARmA2eRq5mTqfiLqVAGB5nTk21NZhCKscolYG1sHNwVt56pNjUn/TmCW9zeyw+Nf1ua3gABPWGtsTly1palwhjYRMo0Bq7J3WOIvQD3fMk1+rLpge3hlx8eA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MWHPR1101MB2126.namprd11.prod.outlook.com
 (2603:10b6:301:50::20) by CY4PR1101MB2200.namprd11.prod.outlook.com
 (2603:10b6:910:19::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5353.15; Sat, 18 Jun
 2022 01:08:53 +0000
Received: from MWHPR1101MB2126.namprd11.prod.outlook.com
 ([fe80::f50c:6e72:c8aa:8dbf]) by MWHPR1101MB2126.namprd11.prod.outlook.com
 ([fe80::f50c:6e72:c8aa:8dbf%7]) with mapi id 15.20.5332.023; Sat, 18 Jun 2022
 01:08:53 +0000
Date:   Fri, 17 Jun 2022 18:08:52 -0700
From:   Dan Williams <dan.j.williams@intel.com>
To:     Alison Schofield <alison.schofield@intel.com>,
        "Williams, Dan J" <dan.j.williams@intel.com>
CC:     "Weiny, Ira" <ira.weiny@intel.com>,
        "Verma, Vishal L" <vishal.l.verma@intel.com>,
        Ben Widawsky <bwidawsk@kernel.org>,
        "Steven Rostedt" <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>,
        "linux-cxl@vger.kernel.org" <linux-cxl@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 3/3] cxl/core: Add sysfs attribute get_poison for list
 retrieval
Message-ID: <62ad25a4146fd_899b32948c@dwillia2-xfh.notmuch>
References: <cover.1655250669.git.alison.schofield@intel.com>
 <57644934bb7af8e1c692735f53c2c415a1ba16d1.1655250669.git.alison.schofield@intel.com>
 <62accb0345de2_81c5e29454@dwillia2-xfh.notmuch>
 <20220618002121.GA1533961@alison-desk>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20220618002121.GA1533961@alison-desk>
X-ClientProxiedBy: MWHPR11CA0042.namprd11.prod.outlook.com
 (2603:10b6:300:115::28) To MWHPR1101MB2126.namprd11.prod.outlook.com
 (2603:10b6:301:50::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d07bfe97-f7af-488c-a6c5-08da50c71c71
X-MS-TrafficTypeDiagnostic: CY4PR1101MB2200:EE_
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-Microsoft-Antispam-PRVS: <CY4PR1101MB22005C4C08B9BC5A744C0DCAC6AE9@CY4PR1101MB2200.namprd11.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 6AhU+HvTITnf8CRbPWhHiKKJvm2xfNHzpfQxiHTsMi/uypx95LUrkRkqNUaRmjSr5auyCwn2Q8pHwlnB8UW9BJhcN90iPOGymOSsGp+r6LShyqT0Wk+GTmJyQ1O2s2CZbtU26OsuzDNkKek+4S2w5C4QQb5kiKH7OZhC9OdJ/YDGHNR5ks/yLrjhmDBBSs3KlTBCgsNakou8C33U4DnPuVy9R0OgKhOjSDn322FTAVoloKxFKgtu+0301Ll08gmGuZJx87BFxJq8Ms+40Sy9qJOjrmnyGQeMqb57w5U/qOLL7/v5lTpMWEW3pO1t7kxoPlblmyQMZcFUlO4gJ+32LQQ90cMYl993IdIwOSLzhlr5chlqvU+NxzmxLOH89GdPOSc3hzWyed1j5tR/Ew7V5Wm+g37Z2k7s+/RDUHgJhw+DhERudjXUDDfIxdUTN0QIAGTYLlKuTiV15DPEVFycd2yj/PmxDa0JylOVY+Oic2Hb6BHKOhWjix10dB1NfLC2KJBXHyf2519U4r8+Cim2hGRAXFn1ouAh9IhT1JxrA5+7CnmbU2qanGe803sXEACxoL10n76filCqe0mW0ZLOh+7vrJwSwW1jpRJUMaBaFs9oe7qVEfrTebDl7+KvpPa51wFdlYHx4nDiR5BgYKcAhQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1101MB2126.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(366004)(8936002)(6512007)(9686003)(186003)(6486002)(38100700002)(5660300002)(66946007)(498600001)(54906003)(83380400001)(86362001)(2906002)(66556008)(8676002)(66476007)(82960400001)(26005)(110136005)(316002)(4326008)(6506007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?/vws8Wlm3eUPV2BTtJblwM8M2yn71Tmk/3VSs2rPMCjMAy5elxlbViPePKR2?=
 =?us-ascii?Q?xj5RleCwylQCfEqdK+TtAnf2o6gAqTnDA7fEdPuwa8xm9LK9HDHd31bNHF/D?=
 =?us-ascii?Q?9tik1PDc23+wQ5MBAMZW6KueBj4e+7ff88dY3zQ2YDRO52jyOYHKQCYcSasu?=
 =?us-ascii?Q?WrL+f3uwQzeHYphn7i06Wd5Wmils4p6Y6HFI9hw8L93ugEJTctHp/mEHKC09?=
 =?us-ascii?Q?0UD1sl9IbngphfLW3vGW4lVyqyhFvFbfOBsjSb0wpeWATEXOKGOuOu6rkp48?=
 =?us-ascii?Q?uUFsJwxikXkcpx7RsbpZDNjTUGF8NRZesWKWbo85laxUs5qcS/dlX4vZYpU6?=
 =?us-ascii?Q?vRVQIniNLT5N22TEsss4ddLxPNaDK0oyj7PYFbxm434b43Q8Qn7OMb9u1/Zo?=
 =?us-ascii?Q?X5AiMczOZShcRlcILEXaiuN5Md4HsUIVnMrAVRe+iZD/ZdKPLn0QWaiQ4anK?=
 =?us-ascii?Q?t/+ZSNYNga8ia1dEIkUfCAl5YkZ7a1ZMDERo8i5pmEb8O/QTOoJfgxdUGnKS?=
 =?us-ascii?Q?XwvkKkfvRJNhVYujycPAQvahQOGRqhzbBYYuH5/eQbdUYzcQHz7dpF7+SNBE?=
 =?us-ascii?Q?R9C3mn0ssG2abZIcdX9ZIdTYutDjhiIvsNKkFFMojAot8EEJqBNPiGr7KMhw?=
 =?us-ascii?Q?dsgJ+/EljgaEywhLABBd0apS4aIBh7cQjUrNiNtdbyMDBdI/L9/tRA2OqRqn?=
 =?us-ascii?Q?ZqcuFCayU5HMoLZWYkrkWS2b1FjfWEnheTZUouvm9yc5G56QVRUpJfq5a3sk?=
 =?us-ascii?Q?x7qNdJpjreMBFDapwMjc2wq5oK9Wwq2s5uI6iiTeWKfY89b4no29VHahIqNb?=
 =?us-ascii?Q?AAxQ5NHLrAq3sttNbsFZmNOGx/7LbhYVpIRfoajWYo1/JS4/tn5V5XH8nHJb?=
 =?us-ascii?Q?hu0biiAzF1ulZpjR4mMLk04wUFTUw0K4DM3+KSd3+L/zaBXKw6a2+FEFZnp5?=
 =?us-ascii?Q?t5wQw0dlVIuaREGoue3Kun6jzyD5dbLq5yW7KnGXvYYY+xq3H57nJoNachdR?=
 =?us-ascii?Q?SV6MBOXG1hycwicZRRDOaYMjorZ4ZMzWUKNvHjnCLE9nVKnQWZO+f9nFQtJe?=
 =?us-ascii?Q?cw5zhTkk6gQ0XC2PCGp3F+25VTStKYIMxN/w+4Rv54aZRXu/AQS2nskEOFOz?=
 =?us-ascii?Q?PrhA3ZWcUZWnuwHfXV78v4E7jAXKzTxM0R4GZ00/46f+PGSxW8hnI4dQNFi3?=
 =?us-ascii?Q?IxOacucB7VozZCjdW7djGYODsmOmBL1SzCWvYr2RxQe9cbpgaIDiiVWv9nOf?=
 =?us-ascii?Q?zqJgFenF85FyM56X8+Z18JEPQOx+xaAAYQ/9T3hNwHk4nZwN8Q69VsWhRQqp?=
 =?us-ascii?Q?jPeOZowE3bzWsvlr0wkAS3+oBdKIDwtFqjpbDrIJvm/Cjj6LKZHVifcm0Qff?=
 =?us-ascii?Q?buV01aZ4AWQQ3Pw7TlQ0DLnuj/8EaxAdt2TGH8ksw6f4iVS4aHFMDSJpgebX?=
 =?us-ascii?Q?D5c8tN34paVAdIrTXFM1yNFr5lHcckUxpXsOFCmF8+324B7s9dEAE3645jVU?=
 =?us-ascii?Q?9WPMo6eZx6mBjdNfw9ZUyur3t0DYLGfeQOR4uFRRrcNN+dd3w5aIxEwzspZx?=
 =?us-ascii?Q?nyNutWw5C3n7gw2NMWf86Z/F6YDSucqzhA1/551ZH4KnqqfEldeT/YrAMDnx?=
 =?us-ascii?Q?n4KI13F0iMwHrRM1X+hiPAbfeYP42vUsowuEJwfONq9im0CC6modWC4MvEuy?=
 =?us-ascii?Q?CdZ1Hs+cAdcRDLbiek0+3vEDTB3YcEwRRyUy7CPNjop3yyPqEUdw1zcOzIQq?=
 =?us-ascii?Q?RTFlZrWCDKK8MoBqFB58dCIPPvw9EP0=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: d07bfe97-f7af-488c-a6c5-08da50c71c71
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1101MB2126.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jun 2022 01:08:53.4145
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: AxMlZj8QMy/9UYNhpgG8LWGv/4bp+b+WlKL0cVUCoZp/bENOQL2PAiSrNNIKXwHKr+RxDLxiLqy8qx+FRmkn2FvWME+ktS0l/PXVjETSw18=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR1101MB2200
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Alison Schofield wrote:
> On Fri, Jun 17, 2022 at 11:42:11AM -0700, Dan Williams wrote:
> > alison.schofield@ wrote:
> > > From: Alison Schofield <alison.schofield@intel.com>
> > > 
> > > The sysfs attribute, get_poison, allows user space to request the
> > > retrieval of a CXL devices poison list for its persistent memory.
> > 
> > If the device supports get poison list for volatile memory, just grab
> > that too. With the "to be released soon" region patches userspace can
> > trivially translate DPA addresses to media type.
> > 
> 
> Dan,
> 
> The only way I know to discover if the device supports poison list for
> volatile is to do the get_poison_list on the volatile range and see
> what happens. Am I missing a capability setting somewhere?

If someone executes "echo 1 > trace_poison_list" I expect that the
driver does:

get_poison_list(volatile_range);
get_poison_list(pmem_range);

...and if scanning the volatile partition ends in error then that just
means no error records appear. When the error is "Invalid Physical
Address" the driver can just remember that's a permanent error and never
try again. So it's more like:

if (volatile_range_valid) {
	if (get_poison_list(volatile_range) == INVALID_PHYS_ADDR)
		volatile_range_valid = false;
}
get_poison_list(pmem_range);

...but that's probably overkill since get_poison_list() is cheap. Just
treat it like the zero error records case.

In the to be released region provisioning patches there is a DPA
resource tree partitioned by DPA mode type, so the poison list code
probably wants to do something like:

down_read(&cxl_dpa_rwsem);
for (p = cxlds->dpa_res.child; p; p = p->sibling)
	get_poison_list(p->start, resource_size(p));
up_read(&cxl_dpa_rwsem);
