Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 29D39473A00
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Dec 2021 02:01:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236883AbhLNBBh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Dec 2021 20:01:37 -0500
Received: from mga06.intel.com ([134.134.136.31]:19716 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232173AbhLNBBg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Dec 2021 20:01:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1639443696; x=1670979696;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=5uDGe9wzNLo1NkxzgoszE/PoP+tXOQAQHadrDIs2r2s=;
  b=GY72o72gwu202PwzQY0x1SzJ5tcN/4NwfwTSITvMLzMXN2iTBjr37lNu
   umHaVmDzYDHnukhCPXfbx11QC1daMLc3gJcOIaIQWJKl7j67F3IKgD0NF
   dnvmiH5vFRFOyoaHIe1P/uFQOsoHoSOuwNnxhNtu3jABil87bboDHT2Mg
   b1DtOidKsIaQBDjoEqQdDN8lGRwPhAoAbUQZtzl6aCYslZ39YqMGJ+PpD
   zS1m+SRx2tYc5VZ7arCEMbFdU+s/4XabWLzfavN0S4Skee5xyFLAHm6gQ
   W4Tz8mt9E+Py/7vyucI4Hpy2MEzeM6Z9qoe7FbHwi0bFrK+BmJ1oGD0Fs
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10197"; a="299647490"
X-IronPort-AV: E=Sophos;i="5.88,203,1635231600"; 
   d="scan'208";a="299647490"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Dec 2021 17:01:35 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,203,1635231600"; 
   d="scan'208";a="505149513"
Received: from fmsmsx606.amr.corp.intel.com ([10.18.126.86])
  by orsmga007.jf.intel.com with ESMTP; 13 Dec 2021 17:01:35 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx606.amr.corp.intel.com (10.18.126.86) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Mon, 13 Dec 2021 17:01:34 -0800
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Mon, 13 Dec 2021 17:01:34 -0800
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20 via Frontend Transport; Mon, 13 Dec 2021 17:01:34 -0800
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (104.47.73.40) by
 edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.20; Mon, 13 Dec 2021 17:01:34 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DhxHBKaG+pOOQ1IP4luLniLXT3Itu+PSbTXsek4Skg9hE7yfdARolKIetmCFyHR+m0gydV7A7cgfu763RW8UgVrQy5Zr/HaTf3oCHQLPwjHLN6aeIzwfX0tChWH9TezDsvOBfJHubZGfZ+2n+PpkTc4oOMQRZukaZjmjJFBpgqTDUsHRAByjJR/sYNFEVKU4XUHqZMVG/QDRBz9IfhBZ0PA1RpUxQxAja9pgw0Ej7rvfmJfjBIENAOB+l5jjCR9+yTW+SYbzCK71KeAhqqm7qlU2/UMENxo9Cy8g+xaVlQbRLS0LD0M8zgT6yDT5TMS5YLeahSIh92MmnKQ4BJU6ew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5uDGe9wzNLo1NkxzgoszE/PoP+tXOQAQHadrDIs2r2s=;
 b=leDvgZ1T/dAPcv3seTC5oyg5NXFQD+aQ0eQxqvkCLik6q3hbUhNtz+2EjbSuod7Dc8AvCLdHZdeJgozejY+p43IvBKQQ44BchyPp2L16mqZqVuIMB8tYCe6lcoIGrZ0CnB4SipYcofq56WeyEWEw7bUOuveKqCS3nnTGpAgg9hKjFKpfS76w/dQrZGvST2xHx0+QZimHPkeTi2tWITWWQJP+oIH7TjkpTsWoG80ujzRomDWzXZveiGU+vBZylnZD4TiAMwosnTNphkJPvsqbBdbzmg2fm02LfPbO5fo/I+aewwmqA1d+ZOTVmbe9GZhzWB8P8MqqUfXupJBX2wVAvw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5uDGe9wzNLo1NkxzgoszE/PoP+tXOQAQHadrDIs2r2s=;
 b=hZZi1cfdU13AuPdTnSgdaRph+ZkQD5hMG3CxsYl3N+fIvVFI86rTbv1f4mwKU+z1CKYdkna1VSAxmdzTqJ9/lZ7g+JxzwK2MWwLTxR+Mb01GDcPLy6EcN8AB7pP+HkbOmYNQo0doar0QnHdKWVswAcdhSJnJyXUC9598cQxc4ak=
Received: from PH0PR11MB4855.namprd11.prod.outlook.com (2603:10b6:510:41::12)
 by PH0PR11MB5079.namprd11.prod.outlook.com (2603:10b6:510:3d::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4778.17; Tue, 14 Dec
 2021 01:01:33 +0000
Received: from PH0PR11MB4855.namprd11.prod.outlook.com
 ([fe80::38cc:22c0:928a:95b7]) by PH0PR11MB4855.namprd11.prod.outlook.com
 ([fe80::38cc:22c0:928a:95b7%6]) with mapi id 15.20.4778.018; Tue, 14 Dec 2021
 01:01:33 +0000
From:   "Bae, Chang Seok" <chang.seok.bae@intel.com>
To:     Thomas Gleixner <tglx@linutronix.de>
CC:     LKML <linux-kernel@vger.kernel.org>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        "ebiederm@xmission.com" <ebiederm@xmission.com>,
        "oleg@redhat.com" <oleg@redhat.com>, "bp@alien8.de" <bp@alien8.de>,
        "x86@kernel.org" <x86@kernel.org>
Subject: Re: [PATCH v2] signal: Skip the altstack update when not needed
Thread-Topic: [PATCH v2] signal: Skip the altstack update when not needed
Thread-Index: AQHX7hoBdqTG42NSTEeQRLqmNoRVxaww87yAgAA8U4A=
Date:   Tue, 14 Dec 2021 01:01:32 +0000
Message-ID: <637074F6-9595-4680-BC98-350EA5BE4B5D@intel.com>
References: <87pmq0tcxa.ffs@tglx>
In-Reply-To: <87pmq0tcxa.ffs@tglx>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3608.120.23.2.7)
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: a6dc67da-afb7-41e6-7beb-08d9be9d4547
x-ms-traffictypediagnostic: PH0PR11MB5079:EE_
x-microsoft-antispam-prvs: <PH0PR11MB5079A6CADD67D087D51322BBD8759@PH0PR11MB5079.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:3383;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: NuE2iugKUQ697pownn2H79NYbAQLkuS8042cxYXLGLqyscHVqS0Oe+rETJ+S4LZoUqU6La2KUUz2+n+9/5CudiQLhnE3jlTvKxFdGJ0BZ6gLm0Mj8WJbYrX5ZwzIljnH04mCbx0yJ6ktI/9lXziNyu4EsLRcRRWoBDaDk+jc74JhsYa0/xRpr5CA88z3FTP3zt9CO7qbcc1ok1QoCQkTbaFtdSCGxQ5+nIpHiR1iKDldTGayd68tPN0WE/W9mTW0aaRuOI0yOlkERvH1QCTdab99wStt3saH3SFn0p51KzQOO1tRng4I4B/UVJC9d9Qw26UNw6jeSNBUcPrnyiVuZbS/k9iGkptM8q0Gp5Ah3aWM7HEWOqaet/D7mBT0Uji2ozPa+mdPh3On5k1nBKjP9luo08VOIyk4i7UtwdBbxW0PPY5ySgWoelk1Ox8DWTZ8vIJh2oG1BIqj5u4gGjicbG6XopFDB6JcsNi2Pkxv+9yO2M+FYO/5zgsouONcIk/AnQyc7+qFq6OIx31zwRhghFbqXez/E48f0WRPGMOUbcwa3gl9QWQn7xZpnoaePje9Cllh16mk4j9TRcyfqoyml4P0pmHH/BJR47ruD20w7JgPRtpHjXUXxZZhmYUWISNc358CLnL4BYCJJtJxcM6WQmVeqH/juY2E2QS0S9c0jwarV6AT2HJLpHyPRnuL+kw4ZfiA1jaUTDXqKlwzcLOSRjTM1qmbamWHpFudyzNSpsSiJHqAmRK33A34ALX8nMIK
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB4855.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(558084003)(82960400001)(54906003)(76116006)(66446008)(8676002)(6916009)(6486002)(33656002)(5660300002)(26005)(316002)(2906002)(186003)(64756008)(71200400001)(66476007)(53546011)(6512007)(4326008)(508600001)(122000001)(2616005)(66946007)(38070700005)(6506007)(36756003)(86362001)(66556008)(8936002)(38100700002)(45980500001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?mrqYsoh7mtCHnR4GXZogHhiHFQW6lRSt1JjoSvKSf6iHrwbvn3Oo3YT6pzpP?=
 =?us-ascii?Q?GFblbYE5Nt7oCI5TCPUXyYoJfAxKaz4nk6P03Eo0zbPcebYKJx8pxcVV5xR9?=
 =?us-ascii?Q?Xz9KVqMoPK6MLT3k7BI51d7l/YIpIWlpMGp7MYfjIzzA7tvJAZySgWhda8aI?=
 =?us-ascii?Q?wX/7ZQKgV6TWvHEV2mz7uHJol2njJgOCvRja+oE69kgfa1RgBELJbLCWE/Dq?=
 =?us-ascii?Q?qQeI19+rd+zYLkNQ9PSdQHXuF5iewsGTe/tFSE1ordNCbeBOJfOpMciGIP0v?=
 =?us-ascii?Q?l4FhCG9xTuQSdZypRwmcV81ON3rqTdxQRG7YUbBv/5BYZLOmj6bSDrqWS6Hs?=
 =?us-ascii?Q?61sKFzEusO3XAaxfqFTIMydDYWfTjbHvZ/jmfvSucZzHFCg/LH6crtI6Ryia?=
 =?us-ascii?Q?6iYKbXr9oWRoW7e569inSCKf0xcN7L433r1VyIedpWK7ZfXkpNryZmVpC7fi?=
 =?us-ascii?Q?c5ttDWqmLB49wNFo4jmBNqudfUdek73O/1Hy1ZEJowYXSjarBN87IdyVSW8/?=
 =?us-ascii?Q?ch/zMBg0IqLBuMM3EmPkjUrEF+H2x+tQ/wX3xf0zwmXAxrjfs/kAAbL6xtTZ?=
 =?us-ascii?Q?6iJZaLdAtN3ln6lE2MUrRbNaot0Pi60jl2wRZesZnjzQW7kypa41gBtzWLRy?=
 =?us-ascii?Q?zVHPZDYqkTQ2d1OXjertYLniPk1lO0o0mRq/3LPfqQ4jKThgRJI9wFnwz0xs?=
 =?us-ascii?Q?YjUds7CRvsaNAW21cSgpbuYJJSr1j2RlVhjIGn6kknrLbo28e7i5xOga2Wq6?=
 =?us-ascii?Q?2Lyf5kPuzPp2KV2EdT7cUg7b8a+jO9mRuFBvxKRWbc+bG94NUCucUJ72/0bd?=
 =?us-ascii?Q?Di+WfwUCCOdf3vkzlxi+vdQH5fn2nsu16ghu3avv8mcuB5s3fe78UJfgZpt0?=
 =?us-ascii?Q?rnLl3kNxubMAstEzmlu6YaJPwIbjM7pRLeoY3aXMKzw62tVbnBiFcoM1bs0U?=
 =?us-ascii?Q?vr+7rw7zR7k1zZnBNc4hQLUi5bq2uM+9DeSbFUcpldpTKkebHuJ9WpvbDujt?=
 =?us-ascii?Q?bIwU1OOYO9wiQEiy/F7uLk3FXSoaMYYzMi79lSzdCWKQHEcL+LKECcYJW8eC?=
 =?us-ascii?Q?pBdfxKvqT2m+9tM4y5DgRadvhEeLAjP+/1uIrwAbbxDhixq9VdBL2wy4yloN?=
 =?us-ascii?Q?4/4hD5lqToLiV9lNE5OvinT9sAQ/ZB90YL17kuurcu9mymzHhzKf0Pz4w2cw?=
 =?us-ascii?Q?LPPB++HUd1kg17DsuoCDb30R83p5xojxMnd510KBtE+IPIed5JY0X/XRupQa?=
 =?us-ascii?Q?w9GlnXSN7W7xzqGkzJJYH/OSRySF5Jd9a0zGLGOcy7uunmGt0txt9AqnRxpH?=
 =?us-ascii?Q?n0QKrA6NAeYEFRgMzOlOBGkR1PdjScvaeLCYqrz3ubpV5ca/jDw+7YZ1XeLg?=
 =?us-ascii?Q?tQqcYjRipKdhm77ZQ4poFzw6RrsfDNbIg4nH1CwDlhPC83zOcJq6OPjmEKgZ?=
 =?us-ascii?Q?FS8J9VjEyZILGNgNEeIR0X78DY5TZIn0QCAj9QKu7P207w22mcUwPwp5NJgm?=
 =?us-ascii?Q?AbxVVDR0hn/jCx9g1WS0F9XuUaaxm7Bht2B3vGPZ6y+B6Lyl3lqeyF+KrD7X?=
 =?us-ascii?Q?MeGUdVwqSaM/xRkmRpnHXX0O3muIG8noa3TbVgM5t3qOsmvIq1HcE8zKy+g1?=
 =?us-ascii?Q?ceHz2f6OjAbj8CBcAyLYF/77f2gUC/WvoPZ96b8fxPmdymnrffm5VhnuTvtv?=
 =?us-ascii?Q?//3KkpQhMJg6dpHygZZ9ntOeuQc=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <7765C1F910E11946BE6C5EECADD4AA94@namprd11.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB4855.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a6dc67da-afb7-41e6-7beb-08d9be9d4547
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Dec 2021 01:01:32.9997
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 4SLnHb4iB0WRRsO+IuB3kJTGZURFFPxNZ1+mOi4HNSO8a3WLVbBWrCKokSeMxaw8qoE9ea5zO0Q0RIRuezVDQPrpm5liCDthjLAdPzanZDA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB5079
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Dec 13, 2021, at 13:25, Thomas Gleixner <tglx@linutronix.de> wrote:
>=20
> Reviewed-by: Thomas Gleixner <tglx@linutronix.de>

Thanks!
Chang
