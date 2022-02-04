Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 71AFF4AA2E0
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Feb 2022 23:10:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345816AbiBDWKI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Feb 2022 17:10:08 -0500
Received: from mga14.intel.com ([192.55.52.115]:15555 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S241261AbiBDWKE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Feb 2022 17:10:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1644012604; x=1675548604;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=6wn2m+1QcPbVVtzTjlPwOAEauFZw2HN9R5qVS2jNRyw=;
  b=aVREN2qIPg7H3daWfrLF3S4P5JkK2AHHDwZ+e2q8VlYlBphIDcWj5ITQ
   vGdoaXq3+E5rjCmiqUNZiq1ysigcOuDHSmJSUjg/2KBalCdxfjLklXdQs
   aPzOlf5clQm7+XgK0QxgrfNWBVlRMGhtc/37yyD4z/3VyrySaThA+JoQk
   /437Im126bnIwTWFeEpiVCYiqkJ2Ue8+bRrYR2e+7G0kDf8DRtRAVE03B
   MP0KqU7wMMEQWubWl8tCxfidSu6VvSGreVqlo1EedmLhrfK+qczpwSxOR
   vWF8v/A4Os4EUZhGRP5+gZy4ktoxLaMyhHF9iKCKQ0p7QORz5YunYciLZ
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10248"; a="248665746"
X-IronPort-AV: E=Sophos;i="5.88,344,1635231600"; 
   d="scan'208";a="248665746"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Feb 2022 14:10:04 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,344,1635231600"; 
   d="scan'208";a="480968823"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orsmga003.jf.intel.com with ESMTP; 04 Feb 2022 14:10:04 -0800
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Fri, 4 Feb 2022 14:10:03 -0800
Received: from orsmsx608.amr.corp.intel.com (10.22.229.21) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Fri, 4 Feb 2022 14:10:03 -0800
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx608.amr.corp.intel.com (10.22.229.21) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20 via Frontend Transport; Fri, 4 Feb 2022 14:10:03 -0800
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.173)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.20; Fri, 4 Feb 2022 14:10:03 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XvELEOs27u8p9z2rm7Ux7k0d+jzVx0el0YTiAKdHfwjSpevjZQnpI71Qlnm+KQAVZf4WshpsTg9ZLHJTkW1w4x4GDsO1lHk9GmM/w4e65bWd0mu8MzTxzU6Wd9jRSRxqj8sp9b8fq3/aqVCAhBAYDc/ZfVPwgLsJkdbYUcOtFZz9xx727S+TvIwdFtWYFPma5sv0055+XVNXv0DLfXYGdMveeSAZDc028aqQnLFsglRe3fsJBJgbJ57JKF/mTFpO/+xUKtxxbOsFrrb/jEaqDXTUUKSOF1BiQoBF0Fd1xSvKa+0xkkyzhY62H6XNi9hUCc5qtH9Eftao1B3uHeoF5A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6qcvoyPvltwPQlhdErsk7t5mpfRKx5g5emkzb1MWiVc=;
 b=WhqkH1lYiHM9wa3jB5maCvA6IZy80w5stNm5V4ta/9NlVDRJTvT8gD7uWnWRrqaIYvEFg9h593t4AvNpUlCsRahpgyit+krQRaBHaAs5cWUaznQXHacaic2yCno2obrSTu2PJkiVT/yjH+GP+/lGGbXY3MvY417AyN6TdqTx2dMNeIiRWnH2C0qb37bpuBX6Oc/rg/GcvvFtJjPzI7b81APhkQOApR6Fc2OKW5Ew/ouRFHXO6a613j4Ij7WHatupMzL6Bokx2V6kFNjNSuG+M4eDMNjafJVMNKYvvPv9tg3MSOkJmJjgZAYEN9qyPj4+h+CJxQD7VyscWEfrlljyKg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
Received: from BYAPR11MB2647.namprd11.prod.outlook.com (2603:10b6:a02:be::12)
 by DM6PR11MB4041.namprd11.prod.outlook.com (2603:10b6:5:195::30) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4951.14; Fri, 4 Feb
 2022 22:09:58 +0000
Received: from BYAPR11MB2647.namprd11.prod.outlook.com
 ([fe80::e58a:3a14:d77e:cfe1]) by BYAPR11MB2647.namprd11.prod.outlook.com
 ([fe80::e58a:3a14:d77e:cfe1%3]) with mapi id 15.20.4951.017; Fri, 4 Feb 2022
 22:09:58 +0000
From:   "Yamahata, Isaku" <isaku.yamahata@intel.com>
To:     Thomas Gleixner <tglx@linutronix.de>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "bp@alien8.de" <bp@alien8.de>,
        "Hansen, Dave" <dave.hansen@intel.com>,
        "Lutomirski, Andy" <luto@kernel.org>,
        "peterz@infradead.org" <peterz@infradead.org>
CC:     "sathyanarayanan.kuppuswamy@linux.intel.com" 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        "aarcange@redhat.com" <aarcange@redhat.com>,
        "ak@linux.intel.com" <ak@linux.intel.com>,
        "Williams, Dan J" <dan.j.williams@intel.com>,
        "david@redhat.com" <david@redhat.com>,
        "hpa@zytor.com" <hpa@zytor.com>, "Gross, Jurgen" <jgross@suse.com>,
        "jmattson@google.com" <jmattson@google.com>,
        "joro@8bytes.org" <joro@8bytes.org>,
        "Poimboe, Josh" <jpoimboe@redhat.com>,
        "knsathya@kernel.org" <knsathya@kernel.org>,
        "pbonzini@redhat.com" <pbonzini@redhat.com>,
        "sdeep@vmware.com" <sdeep@vmware.com>,
        "Christopherson,, Sean" <seanjc@google.com>,
        "Luck, Tony" <tony.luck@intel.com>,
        "vkuznets@redhat.com" <vkuznets@redhat.com>,
        "wanpengli@tencent.com" <wanpengli@tencent.com>,
        "x86@kernel.org" <x86@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        "Yamahata, Isaku" <isaku.yamahata@intel.com>
Subject: RE: [PATCHv2 26/29] x86/tdx: ioapic: Add shared bit for IOAPIC base
 address
Thread-Topic: [PATCHv2 26/29] x86/tdx: ioapic: Add shared bit for IOAPIC base
 address
Thread-Index: AQHYETNpIDxA5Tu5KEmB7cgjSERHHqx/h0wAgAR4eQA=
Date:   Fri, 4 Feb 2022 22:09:58 +0000
Message-ID: <BYAPR11MB26472C6C7699265971A5EDAE8C299@BYAPR11MB2647.namprd11.prod.outlook.com>
References: <20220124150215.36893-1-kirill.shutemov@linux.intel.com>
 <20220124150215.36893-27-kirill.shutemov@linux.intel.com>
 <871r0mvyqr.ffs@tglx>
In-Reply-To: <871r0mvyqr.ffs@tglx>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-product: dlpe-windows
dlp-reaction: no-action
dlp-version: 11.6.200.16
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 0fa91665-ced6-4e6b-b5aa-08d9e82b1506
x-ms-traffictypediagnostic: DM6PR11MB4041:EE_
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr,ExtFwd
x-microsoft-antispam-prvs: <DM6PR11MB4041E4CE56082570BE9B434D8C299@DM6PR11MB4041.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: zgLo+ciS7ybwKJJjJ8q11dlDbVo1CuDM7R6EWAJupv5I2Zstoj7dcd0hgPPpN2fCt9AYj21ubLHSHzl8lQbUkw6tbKESbyq3rcGlsQ8eEHtppEZ3gyZTZUz315/MuQPTkiD/j6Ngv9MXn9rOfnUfAPI+kqDc+WxV/nnd6VskBMmEqrcx6Y9oVKHIYMEn23m8DUH7L5/3boHbmIRgr3JpUw7X8D2l+ZyDxnhEcWSpAnE5v2HvhaFAMtollqfFqyyVa+5n8qb5wCYXitOZTxHE7eQqfY+SZtfhsYpPsLJFpGdSBFNpaXALlOZwAsJAn774ZIw9ebJ56o+qvPoAGbjxhbQdxlgSVqyy7z61fzTAlmxo/FYfUWs09CRBk8yvSsL8mgYYGLRTdTK6QouROsZxtQGpSTixtFIE3xDwEPoOkmHH0loF4ySB+UmpUMqcgZ6JASqOdyCeIYdmrl6XMnpfICly0SbbPemV2RF4o/l2rBFCGZqmf0RGK6iao1f4IGKnFfbUvAgEzUlFVJ/OJ4bxcnzKbfAdpizNV5ZIM56vQjxYwytN9MSUTEp1mzFO4rDL/GIkQgqLoK7CZ2sc1S3CaTEBGmrjc2qUqwAgqgGDS8fQVnFvCTAHRvvkiioQQLoMk1Z67f69WYK0M3ujBEo/eNMqkqg0+GSHuJVpmQGPJ//DTddnJlQk7DzTixBDKzNQUitMp3UaQvnkO7bviahF6Q==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR11MB2647.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(76116006)(316002)(66946007)(38100700002)(55016003)(86362001)(71200400001)(82960400001)(5660300002)(8936002)(8676002)(186003)(26005)(6506007)(38070700005)(110136005)(33656002)(4326008)(508600001)(54906003)(66556008)(66446008)(7696005)(52536014)(7416002)(122000001)(9686003)(4744005)(66476007)(64756008)(2906002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?IMwum/DM+hcnhzxhCR9CO2cZK1YkLplJlbtcDW+ytmjuDr84r9ukNL5unHnK?=
 =?us-ascii?Q?V0RrRNfQxSNxpBCSug8gR9gP2WKBmvxK2xeryhCL8KucrQfVRRhZbi40FNDN?=
 =?us-ascii?Q?2qlcig95Bcyg7bbQTj4A42vNoWgtGB+/BVSPqYvOlr/AShRBxlZODBaoFaMz?=
 =?us-ascii?Q?2TtGOyv9FiMQURrPToxkbcMaJ1DiiV3HjJiwe/krr+lYcwfEza0/ghzml6CL?=
 =?us-ascii?Q?bSCCOACb9g9RoqVH5SaZLj5wAFUE9X0pBpT9qyiK9pDfHRAd+OoStWueJHKW?=
 =?us-ascii?Q?0jkSeUQ3xaN+j9XjBDQOvrele5HnsQJCPqDhrAhIckw0XrcC6hZp1M8122mA?=
 =?us-ascii?Q?7/y2ivIK7PJTPLzfAJ/1TzBejfDr0J1H0pxFVS2NFTrma2HdBPQTPwUqlx8T?=
 =?us-ascii?Q?bEMdSu9RIez+4fYpAsWsOc74FsyrRr1DxxikM5sl1lct7D0VJ3+uBKk/SUk4?=
 =?us-ascii?Q?i/fDtaImLnsNwgR03rokUhyDhTXpaavALLf/uk3WXtC3+utQBp34Myc7RoMB?=
 =?us-ascii?Q?PZ3w79YD68GhANp/4PuiMZ/Asjx5CWtENr+f+5zK1DXtICDb7IeiBYueW1vX?=
 =?us-ascii?Q?uWVnV/aHrVd5wX1rvAItc39PfElMduHI4Ggp3dKHPkmOce6Bsan71aUA2WZU?=
 =?us-ascii?Q?ZjV71ttU2QSBd7sELZK9Z5iNVLfRs7RZEe4PUvGxNjcGHFgVuqlrJJUxOyuC?=
 =?us-ascii?Q?S3yWONWsK3K0Fsnxf3YbE/Us9pDUbJaUgkl7Of2JX+POYQsQuKnSZYBXHMRD?=
 =?us-ascii?Q?6cq4m50QDYiC0ZK6/9qxrzraA4ktrsp95THnzgwjknAlxG4903/jRNEZG2sy?=
 =?us-ascii?Q?TxnchZDrGrr7lRP0ijHATOCONtgtQdg4layjp7/GWJnTUs/A4hGHDtBf5DRO?=
 =?us-ascii?Q?+5Z/6vvhUZdPItJoPJpIBfa+5DcHrH/QyLSFpw7asg7zsRpacnxkKxRBIhO4?=
 =?us-ascii?Q?5Sq4OfVwjYPbzdJ+KB2IS30UeXhlz5OrSLr3mJVffOCsr4LQ7MPWYwZIc4zo?=
 =?us-ascii?Q?z1A+jgVOoKUTywiztpD2L+1dhcIvZVqGQvzXWbr2pbeCL1H+22oK5+ciWI5m?=
 =?us-ascii?Q?D3GbhQvCBMc7Mj3LLXZxBM/Qr4eCdLhbYghhy+MkKB8wlJBtmRjb+ptxSJeV?=
 =?us-ascii?Q?sYjQZxaCxP7ElNAheoDoZT2poR6QzmM8szfZ/noSzZa0npKpNWskHTX8T2h7?=
 =?us-ascii?Q?D37D5vZvuPgSXDnapx8yV6g5g+UJf0R7nZmWOKCP4mss03p9D4Bk8bycRMFJ?=
 =?us-ascii?Q?ZwMCLVK0bUcpoYUqDgH02EsnG6Q58Gr3fJeh0Symn1lAvTXyxQtWUlZcn3dX?=
 =?us-ascii?Q?jSR3dKr0cSL8gy2735nLzfVr8auHfIl6J0JGSU81oEwEVjFRSDzXBulfyDTJ?=
 =?us-ascii?Q?1DxrDmsrNuFNk4MgEFi+bbB4tc8Io6NUnFljlkiCf1de+iyvKNkUJFwgp3RK?=
 =?us-ascii?Q?Xfx9NjsODAfEd305/x7tc+wtgdF+M8h+QJ4zXhNLq4CS5KfNcSYGqoLZ+eDe?=
 =?us-ascii?Q?mA1RsYI0/8Mba9n5OHMF7w6pLcQkOY1qCl6qdZNB3ntHZoDUs0wPLn9al1ud?=
 =?us-ascii?Q?Z1r8iFDhELXtz3Zbug/75thqOjQlVZoP9eYDmjkMGCdr7+22j8bRDas6kkz6?=
 =?us-ascii?Q?kvKDxeRsXuGQq69ugKUDa1Iv34KbUo5+at2vMgGs3pH9J9o6EzNWN4/0lhxH?=
 =?us-ascii?Q?28c5PA=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR11MB2647.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0fa91665-ced6-4e6b-b5aa-08d9e82b1506
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Feb 2022 22:09:58.2228
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: tQPiplhg4PCZG3HcVMDe9YwPY7MjVjwsYEbcUggqCT8FuH/xWm7qqH4+HENJAq/otgxLDD6lp60pgpgZEnyjcOnRn7wNXNlaqujHzi73hpo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR11MB4041
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> > ioremap()-created mappings such as virtio will be marked as
> > shared. However, the IOAPIC code does not use ioremap() and instead
> > uses the fixmap mechanism.
> >
> > Introduce a special fixmap helper just for the IOAPIC code.  Ensure
> > that it marks IOAPIC pages as "shared".  This replaces
> > set_fixmap_nocache() with __set_fixmap() since __set_fixmap()
> > allows custom 'prot' values.
>=20
> Why is this a TDX only issue and SEV does not suffer from that?

The bit meaning is opposite.=20
TDX: set: shared, cleared: private
SEV: set: private, cleared: shared

Without this patch, it happens to work for SEV. (or any emulated MMIO can w=
ork)
But for TDX, IOAPIC emulation doesn't work.

Thanks,
Isaku Yamahata
