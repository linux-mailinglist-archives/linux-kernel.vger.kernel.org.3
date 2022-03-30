Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 59D894EBB3A
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Mar 2022 08:56:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243479AbiC3G5Y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Mar 2022 02:57:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240712AbiC3G5P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Mar 2022 02:57:15 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57E4CDCA8B
        for <linux-kernel@vger.kernel.org>; Tue, 29 Mar 2022 23:55:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1648623330; x=1680159330;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=hs0WcoYYIjd+xZL3kR3cTduiZIxRWnJOHbxn8WD++cc=;
  b=MXqcvA8OYQ+WnvUEylTdCVdveAXXaWMhJQYUOEBFg+fzU4V4/LHkpMRe
   achHQElaaBLHz2rhywOGo4LLzt9L7HsCp7kW2Qj3TY5UEkZ1wLOFicY+G
   gbnz/QGXLWjl4u2gn4YLIdgAWSMFGqJIXTvZHsgZPWxWfCMG5NH59JFvY
   s7TgEMUd9D8RxS+1zh1RzwvozAJh8UK0RuYUTAUSlyyx0HnhkcgvJEqtf
   RT+kun4oU2J2sTYp8lxNu9rNs1ruzZNyaARJ8GXygjT9EHic3syxmyxIb
   HWM/UeLeizjlwSuZxihtPo7r0aEbxb7o7CkOQZTsp4svEzZO9At+uAEXO
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10301"; a="345898725"
X-IronPort-AV: E=Sophos;i="5.90,222,1643702400"; 
   d="scan'208";a="345898725"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Mar 2022 23:55:30 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,222,1643702400"; 
   d="scan'208";a="546729756"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by orsmga007.jf.intel.com with ESMTP; 29 Mar 2022 23:55:29 -0700
Received: from fmsmsx603.amr.corp.intel.com (10.18.126.83) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27; Tue, 29 Mar 2022 23:55:07 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27 via Frontend Transport; Tue, 29 Mar 2022 23:55:07 -0700
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (104.47.57.45) by
 edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.27; Tue, 29 Mar 2022 23:55:07 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EoXRj7Bl4GZE6v9atmzeCH8Ex9sNkibUJ0Bv9I83KQzOjwc0ayo5eoSCfgZr2S8p9+hwjI2qaCVR8LwoVw8lNpPrAyhubQbblIM+UrZZcaZPACgchko+S8l0pKmfWieTxjO2GYxQbsUd+FfX4BBbvfl/F3Ga5jbXvRB9S6WgG+fm11tZsCvs6i3G761n4emSx2fcFlEJZyYf1Xtw4wxhd2KILVGl7xmq2BUCZSULJYaJd7bb5bna9SgKsuPBY6jdXWhfg72/hvUh+zD8SKq+UltpD3d7C6uONNd+2ppMMkEuTI9OoogiLBY4/ppZf1ZplzKRiT5eO3NXYxmpn9+6+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hs0WcoYYIjd+xZL3kR3cTduiZIxRWnJOHbxn8WD++cc=;
 b=oTybDDBcFnBv6OqpkPgOuOh8iY3FxgYCraGDixJbFP7UttSxMkTkmm9aSag3f/MTzjaZgcqiDGLErQdKv8eNlxhbpkVBO+YaQB9QW62g/8qTi7xSkOsIuOmNLSwaV53pFOFxO2ePL3GPyfhFBWpAU7rDlK2t8OzVNuNh1BeEdQ2LYlCT7ACl66h5pf0tdXOW69luCrT0fZ64+dsaxt+zFehfXQ2wnZlLKykEHs4y1syU+KKkYPXUGXTuZnW8z/xPuU9Jm4d/RXw4baqn7PegdEtMrA5m42P06kuuxLapJ6w03UAFWZmsyqttioONfknZj7czM6sYO84iMsdzEpuVWg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by SA0PR11MB4718.namprd11.prod.outlook.com (2603:10b6:806:98::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5123.18; Wed, 30 Mar
 2022 06:55:00 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::4df7:2fc6:c7cf:ffa0]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::4df7:2fc6:c7cf:ffa0%4]) with mapi id 15.20.5102.023; Wed, 30 Mar 2022
 06:55:00 +0000
From:   "Tian, Kevin" <kevin.tian@intel.com>
To:     Lu Baolu <baolu.lu@linux.intel.com>,
        Joerg Roedel <joro@8bytes.org>,
        Jason Gunthorpe <jgg@nvidia.com>,
        Christoph Hellwig <hch@infradead.org>,
        "Raj, Ashok" <ashok.raj@intel.com>, Will Deacon <will@kernel.org>,
        "Robin Murphy" <robin.murphy@arm.com>,
        Jean-Philippe Brucker <jean-philippe@linaro.com>
CC:     Eric Auger <eric.auger@redhat.com>,
        "Liu, Yi L" <yi.l.liu@intel.com>,
        "Pan, Jacob jun" <jacob.jun.pan@intel.com>,
        "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH RFC v2 02/11] iommu: Add iommu_group_singleton_lockdown()
Thread-Topic: [PATCH RFC v2 02/11] iommu: Add iommu_group_singleton_lockdown()
Thread-Index: AQHYQy+FyOvFomDYNUS+m4eyrODKe6zWBZTwgAFZ8YCAAB+bQA==
Date:   Wed, 30 Mar 2022 06:55:00 +0000
Message-ID: <BN9PR11MB52761EC0B212CB66878076568C1F9@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <20220329053800.3049561-1-baolu.lu@linux.intel.com>
 <20220329053800.3049561-3-baolu.lu@linux.intel.com>
 <BN9PR11MB52760F455B3319789BAB1E0E8C1E9@BN9PR11MB5276.namprd11.prod.outlook.com>
 <9815626e-c42f-81a6-c933-52c1e6f48197@linux.intel.com>
In-Reply-To: <9815626e-c42f-81a6-c933-52c1e6f48197@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 5d0d8834-209a-4285-aa0c-08da121a35ae
x-ms-traffictypediagnostic: SA0PR11MB4718:EE_
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-microsoft-antispam-prvs: <SA0PR11MB47188D7D81AD8B85E84EC9E18C1F9@SA0PR11MB4718.namprd11.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Yd0Bvplfgf2msPDN6VwioVVRLfB85uba3X3KygUqFV+PUgCQbh6c5eDz0B0uaFgKnMI45E53einGfBlSkM8EucpoXDFKI+uG/xqnGR8giFbi+aUbh9uH5+Lhpadv+rZaFPkmFcbLAf5kgbahVmpzQh0riNbzthsx2by9hXsuVcSSu1KneEIIpDRuHX6+ZTFjCpzbbsWZ+V3celF8SDS7B2pozpA0aoHLXXQuusfYpfWPdjM/sikIKqslgKXUE/cd4uapYXW2q1LFlkasITIrEIOBcIKmoTf+rWwPaizQ2hzbfr1WV9QEqfyGhW796HS+bdViTs0/w0aQqsO/xyxqAv6VJU0ebkQlHHMis8ZVmEZNry3glbrQMKiav5jLVABiBZgyxq6j0Se15KQOiWTbLtVRKD4kZ4qMbVxayHVJUhjCOONybEOwDmZtv8AK70Kqo2g92J0EH9pPeKampckamF6p92v8PwV6jtLu0Q79jI1btcTS4SekN3n1Eo3x70SE/FbQTuYSjaHhNl21sXUGKRsEM/kPXdaVEnBaHWuVMQHeYU6yKqSNfNtqdFHO6SAAVXfunOFXji5pnm7kFcYo3Aw4WuLN1bpqnxVZyD3Lmm+VM8JZQx8EFgGJiQtGQfvYRg3KGMeE8riBWpMAluLCHBSjBkJFtCtp13fXjh+rFw79FEYxnhwkMVxoihwT5KnI76i83J6tCYTod8hVdtQzxQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(86362001)(8676002)(9686003)(33656002)(66556008)(54906003)(7696005)(83380400001)(76116006)(66946007)(64756008)(66476007)(66446008)(6506007)(38100700002)(110136005)(316002)(82960400001)(4326008)(5660300002)(186003)(122000001)(26005)(508600001)(52536014)(2906002)(55016003)(71200400001)(38070700005)(7416002)(8936002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?MHcydjVlUkYrbHhsRUd1RHp1dFI5NnF3RUIraVN0d09kV0JBcVZ6bTFObFVj?=
 =?utf-8?B?dnJoQXJIQ0ZmZHN0OGZNdlJPRThaYmJQUmY2bHdBMUY2eUxlaUkrbTlJcXdO?=
 =?utf-8?B?dTh3b0M4NllnZjVoYUp3K3Z6OVlkQys3Kytsb1U3Vm5IQUZsMThxMlpEZE9v?=
 =?utf-8?B?SllhU2pXMk5EVzJRUEZ5dEVmT04wU0g2WHUxZ2ZKaXBuTkhFSktDSyt0WnBM?=
 =?utf-8?B?OHNuaTFscFpyMFFNQ20veFNLaTBaQUZvbVJSR1lCaEM4K3hGMmxHak9UblpE?=
 =?utf-8?B?em8zZU02bzdzY0xFYXJMbFZPYTlOMVArby9leEFZc3M4MmRUdFJjOFNjUmx0?=
 =?utf-8?B?bSs5OEt6K2N5bUxJdFJFRmxyMXQwdWFUenQyZ1IvRkxXZE5aTXFEYWVyTXNF?=
 =?utf-8?B?dkxqMzBaUFJ3cExsbjZWUTFLRk5WN0dhS3VwbmEyMklPc2tTTEZGNzlZVjVR?=
 =?utf-8?B?c3F2RkxtZ1hPUHhCTWlKSXVVV3ZuY240bWVzUkpkS2k4eUx5NUNxU2w5OG5j?=
 =?utf-8?B?azNTWkxTdFpzb0RHWGtLdDF6ZXFQU1RHSG9wWlkrTWd4ZFpKQmRZSnlSVTB0?=
 =?utf-8?B?MkowTUp5R3VHYk5CVHZQTHUzVUx0VnFkKzZSYjl5bk1WbjFOU1VieWxHWGlm?=
 =?utf-8?B?TWY4NE5kdGFEZ2RVU1ZhZjNKajJNVStBUkFDeHI4RXNPcE1zNXQ5VFVSd2JY?=
 =?utf-8?B?U1ZFOW5Vd1dIL1RMRVBZelBDOVgrZjYvSHBaTXJZeXdjWnN0bjBtWWRvZTYy?=
 =?utf-8?B?Z1BwYUt6Qlk2cmJCWFlDQkFybnloTGx3L0phS0pPRGFOYUdFUGlXY3k3Y3Fz?=
 =?utf-8?B?R2pWd1k2Y3lQdFROR0U3TEtoOVdhZm1hUzFlcStyNzMxWWFiUVFCaTZkUjVW?=
 =?utf-8?B?c0dTNDNoNEhLcXVRRVY5U2Y3NUxyT3lPK0hIbGxUR1UwQjhHMkVxYkYwTFps?=
 =?utf-8?B?aW9XSGVEVlJRdXhMVEdqY0pTbmdLeGxZRmFpVEdFaXZxRDJKc1JSNVFSUTI1?=
 =?utf-8?B?RHVwdkllUnFGb2V2NHZ5Rm9tRWpvQTUwREQ5OTh0OWVJcW9oMjVidGtXdkJE?=
 =?utf-8?B?UHZKZHd3TVJnZ3FkYzBlY3NreFl5cEt6Z21DbUNCRkxKV3J4K2RscTRqeEQy?=
 =?utf-8?B?aUJGVGUxUXBrR1o0S0FaT3hqUy9iOWtrTTEvOUVIcnJHN0lPMGFUdGNTcjZ2?=
 =?utf-8?B?eFlxVGgzczZ6c0NWZTc5OGlZdHdJRjZRMElaNHNpVUFRa3hIVVFuSWQxQzQw?=
 =?utf-8?B?SFo2MklhSUZaMnN6RWhmYjlpZXVzdUw4R3loTEwxSE43aVEyZTVkUHFtOG9a?=
 =?utf-8?B?MTR2UWNFWGF1VHJ6K0FUOWdNMUNRRGUzL1M4TTdScFgwTzVoazlnREpkNzVw?=
 =?utf-8?B?Rkx4ZEZMcmhDY295RmdvTVZvTTdxOGRhejVTbndsMGRKRE5pUStYR3Q2cm9j?=
 =?utf-8?B?WFRxS2dSWm5zelhmcVFqZ2I3c0ZVSW5rclpXOGx0Q0tiZUd6YXljQ21RWnFO?=
 =?utf-8?B?TE96Z2hySE9jcEUxbDQvR0FDY0lHQ3JMd0RsQzA4bnkvTnd3TWhrb3VVVmlS?=
 =?utf-8?B?LzJpeWlQZFF0RUtBV29DSEhmcTNEcTNXK2J2MExNd2tRTWdPZVlBL0xLQnJm?=
 =?utf-8?B?bDFxSUVpZ0JuSStJWTNlUk1taFNkeVk0bDVWOUdmdVhTWm9nM2cwczE1N1NS?=
 =?utf-8?B?TnpYN3ZWY3JzckgxalNUNEZScWRTNmhLQ1ZsYVdaZWUwWXpKemxnVWFJVTZr?=
 =?utf-8?B?cUY2NWFheXo2MXExdEhEMWZ0UVRMeElPMmpTdnU2V1QyZ2pILzVpc0NnbGpi?=
 =?utf-8?B?TCtodGlkV1J6aWx5MjdJRldOc2crUHN0dHRUb1YwUjBTazhNRGZ2UEJrNHNx?=
 =?utf-8?B?S1ZoaTZGaFJiTy9henpEdFFlYitQd0YvR1JDdmR0c2d1Sjk3YTR5OGJ1cWRJ?=
 =?utf-8?B?cFlOZjdMQTA1dS95Zm4zeEdpdWFiU1V5Umw0MlN5TStka0kvOGg2ZXBMeFlJ?=
 =?utf-8?B?MWZUUUtsQ0NiRlZETXAxNGdoMjY4STcwaUFKMjBQVE5Fc3JaMVRDTGVFMmU1?=
 =?utf-8?B?UUNxS2hHVGlwV0Z4U2JSbU9PZzVHdXpjRExaYk5MMjI2cGVwR2NMTUk3Vm5Z?=
 =?utf-8?B?YzN5aUlia3J6TitqUFJEcXhRZjVyQVlxUUVWcy9vMzIwcnpLUkV5TUdnbFFL?=
 =?utf-8?B?dW5oR3QrWGRZUXFVTnRERXlEbUNYWmFvTk5ZT08zWG9IYVcrT2NSVHRaR0Fm?=
 =?utf-8?B?MkswbGhZbzE3MC9mcVFqazJtYnpRelZiWWw0NlJNZ24zWTdBK2FXeDNzTWQw?=
 =?utf-8?B?R1dSSEd4cWlJRGYrREdCQlg0cEEvVHB0NXoyQ3k0WG16OFRVQVhUQT09?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR11MB5276.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5d0d8834-209a-4285-aa0c-08da121a35ae
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Mar 2022 06:55:00.4185
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: dOMRWvNs2t0ib/FaAQ8jT6fVXi2IoiNOQ6lQTwL8GOWTdDjwnVtpu+2odT1GORiqbySI9MsYA18+tAFRDIOUnw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR11MB4718
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

PiBGcm9tOiBMdSBCYW9sdSA8YmFvbHUubHVAbGludXguaW50ZWwuY29tPg0KPiBTZW50OiBXZWRu
ZXNkYXksIE1hcmNoIDMwLCAyMDIyIDE6MDAgUE0NCj4gPg0KPiA+IGJ0dyBJJ20gbm90IHN1cmUg
d2hldGhlciB0aGlzIGlzIHdoYXQgU1ZBIHJlcXVpcmVzLiBJSVJDIHRoZSBwcm9ibGVtIHdpdGgN
Cj4gPiBTVkEgaXMgYmVjYXVzZSBQQVNJRCBUTFAgcHJlZml4IGlzIG5vdCBjb3VudGVkIGluIFBD
SSBwYWNrZXQgcm91dGluZyB0aHVzDQo+ID4gYSBETUEgdGFyZ2V0IGFkZHJlc3Mgd2l0aCBQQVNJ
RCBtaWdodCBiZSB0cmVhdGVkIGFzIFAyUCBpZiB0aGUgYWRkcmVzcw0KPiA+IGZhbGxzIGludG8g
dGhlIE1NSU8gQkFSIG9mIG90aGVyIGRldmljZXMgaW4gdGhlIGdyb3VwLiBUaGlzIGlzIHdoeSB0
aGUNCj4gPiBvcmlnaW5hbCBjb2RlIG5lZWRzIHRvIHN0cmljdGx5IGFwcGx5IFNWQSBpbiBhIGdy
b3VwIGNvbnRhaW5pbmcgYSBzaW5nbGUNCj4gPiBkZXZpY2UsIGluc3RlYWQgb2YgYSBncm91cCBh
dHRhY2hlZCBieSBhIHNpbmdsZSBkcml2ZXIsIHVubGVzcyB3ZSB3YW50IHRvDQo+ID4gcmVzZXJ2
ZSB0aG9zZSBNTUlPIHJhbmdlcyBpbiBDUFUgVkEgc3BhY2UuDQo+IA0KPiBZb3UgYXJlIHJpZ2h0
LiBCdXQgSSBkb24ndCB0aGluayB0aGUgSU9NTVUgY29yZSBpcyBhYmxlIHRvIGd1YXJhbnRlZQ0K
PiBhYm92ZSBpbiBhIHBsYXRmb3JtL2RldmljZS1hZ25vc3RpYyB3YXkuIE9yIGFueSBzdWdnZXN0
aW9ucz8NCj4gDQo+IEkgZ3Vlc3MgdGhpcyBzaG91bGQgYmUgc29tZXdoYXQgb2ZmLWxvYWRlZCB0
byB0aGUgZGV2aWNlIGRyaXZlciB3aGljaA0KPiBrbm93cyBkZXRhaWxzIG9mIHRoZSBkZXZpY2Uu
IFRoZSBkZXZpY2UgZHJpdmVyIHNob3VsZCBrbm93IHRoaXMgYW5kDQo+IGd1YXJhbnRlZSBpdCBi
ZWZvcmUgY2FsbGluZw0KPiBpb21tdV9kZXZfZW5hYmxlX2ZlYXR1cmUoZGV2LCBJT01NVV9ERVZf
RkVBVF9TVkEpLg0KDQpIb3cgd291bGQgdGhlIGRldmljZSBkcml2ZXIga25vdyB3aGV0aGVyIFNW
QSByZXF1ZXN0cyBmcm9tIGENCmRldmljZSBtaWdodCBiZSBtaXMtaW50ZXJwcmV0ZWQgYXMgcDJw
IGJ5IHVwc3RyZWFtaW5nIHBvcnRzPw0KDQo+IA0KPiBUaGlzIHBhdGNoIGl0c2VsZiBqdXN0IHJl
cGxhY2VzIHRoZSBleGlzdGluZw0KPiAiaW9tbXVfZ3JvdXBfZGV2aWNlX2NvdW50KGdyb3VwKSAh
PSAxIiBsb2dpYyB3aXRoIGEgbmV3IG9uZSBiYXNlZCBvbiB0aGUNCj4gZ3JvdXAgb3duZXJzaGlw
IGxvZ2lzdGljcy4gVGhlIGZvcm1lciBpcyBvYnZpb3VzbHkgbm90IGZyaWVuZGx5IHRvDQo+IGRl
dmljZSBob3Qgam9pbmVkIGFmdGVyd2FyZC4NCj4gDQoNCklNSE8gdGhpcyByZXBsYWNlbWVudCBj
aGFuZ2VzIHRoZSBzZW1hbnRpY3MgYW5kIGRldmljZSBob3RwbHVnIGlzDQpzb21ldGhpbmcgdGhh
dCB3ZSBtdXN0IGRlYWwgd2l0aC4uLg0KDQpUaGFua3MNCktldmluDQo=
