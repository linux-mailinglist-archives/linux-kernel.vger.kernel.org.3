Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2FE26550FCA
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Jun 2022 07:50:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232659AbiFTFuO convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Mon, 20 Jun 2022 01:50:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230115AbiFTFuL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jun 2022 01:50:11 -0400
Received: from mo-csw.securemx.jp (mo-csw1114.securemx.jp [210.130.202.156])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 761A0D10C;
        Sun, 19 Jun 2022 22:50:09 -0700 (PDT)
Received: by mo-csw.securemx.jp (mx-mo-csw1114) id 25K5nO8U013736; Mon, 20 Jun 2022 14:49:25 +0900
X-Iguazu-Qid: 2wHHHyKX1U5nDQEbsD
X-Iguazu-QSIG: v=2; s=0; t=1655704164; q=2wHHHyKX1U5nDQEbsD; m=8IDJ528fAErWSC3XT3EYsl/rupezPOGThb6h8axG8cE=
Received: from imx12-a.toshiba.co.jp (imx12-a.toshiba.co.jp [61.202.160.135])
        by relay.securemx.jp (mx-mr1111) id 25K5nL2Q028269
        (version=TLSv1.2 cipher=AES128-GCM-SHA256 bits=128 verify=NOT);
        Mon, 20 Jun 2022 14:49:21 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dyQHus68FHeJh8eKqVbMJnrqBMG208aRlyQHKVSpUhXJbO+UeNPF39leUY0EcRKUCpWMunPxJuIXp/BCIrXQ8fJAbCsXlVpSU9G5CoaHse2xymwX/E5eNfpSI0IKzDvURJD9kVYmeWttJ1AqFk5jZ/abd8M722JEW0b8mQpk6oCPF6aQyIHTbFHvUM23WdwvjYYLH1IAoQG2UDyk+Ei+f3nBJGMtc6pdSsh/qn4D//atursk24hMO7HaZC1GoOc7vsBHaekXUI2Rdbob2eYcA2cXEnhtuhtd8Ifnsnr1Oyt7TSg22m4ZBopUs4WQB+gl7Kw3mysvWwWTBOcQQSeRGg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VF/UKx/q7MmKplwkKEJeFekjGOi7U7ZnLJ3YUtwLEoc=;
 b=NmV/oh2vf0nSql/65WgfrzMRtqfjfyjs86Umq6SmYOfcgFsZo1t1pIzADyf5RQTFgezyJe0jNQFsqaI0coFLjExLQgIMzV5Y2/zugx7fylbJhT7nFb/QqQu6Awflxym3O+zXGUpCeBlA+lhbwGuPVlQLVToOBNumXbgjSxuJ4UqhALce6wsNKtHqYaT5bnTChSEXfjWz5TZdhr++0RyIHr6HZscKDqoHIeQib0T9gZZS4dw/DweUYphDqt3XMrwjpBoq0OrxB41XEP6nU08vQZhDjHcg/KzGsH2WQrz+4839758D4OnbNSqXvHWRAV/ZhQI2tdpnPsMOn8gYIGBqzQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=toshiba.co.jp; dmarc=pass action=none
 header.from=toshiba.co.jp; dkim=pass header.d=toshiba.co.jp; arc=none
From:   <nobuhiro1.iwamatsu@toshiba.co.jp>
To:     <jgg@nvidia.com>, <baolu.lu@linux.intel.com>
CC:     <joro@8bytes.org>, <will@kernel.org>, <robh+dt@kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <iommu@lists.linux-foundation.org>, <yuji2.ishikawa@toshiba.co.jp>,
        <linux-arm-kernel@lists.infradead.org>
Subject: RE: [PATCH 1/3] iommu: Add Visconti5 IOMMU driver
Thread-Topic: [PATCH 1/3] iommu: Add Visconti5 IOMMU driver
Thread-Index: AQHYb9dH05SFqMkMF0+v2vSGSFgXYa0vIReAgADJMwCAKALTkA==
Date:   Mon, 20 Jun 2022 05:49:13 +0000
X-TSB-HOP2: ON
Message-ID: <TYWPR01MB9420F74E27D8513CD2C2D27592B09@TYWPR01MB9420.jpnprd01.prod.outlook.com>
References: <20220525013147.2215355-1-nobuhiro1.iwamatsu@toshiba.co.jp>
 <20220525013147.2215355-2-nobuhiro1.iwamatsu@toshiba.co.jp>
 <63369db0-cf7f-aa53-bf9f-de2b0b2289ac@linux.intel.com>
 <20220525182644.GF1343366@nvidia.com>
In-Reply-To: <20220525182644.GF1343366@nvidia.com>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=toshiba.co.jp;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 0cd66900-a36e-481f-bb66-08da52809b38
x-ms-traffictypediagnostic: TYAPR01MB2238:EE_
x-microsoft-antispam-prvs: <TYAPR01MB2238DF2A2685456D1E576EA392B09@TYAPR01MB2238.jpnprd01.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: G73++VBsUpWmweX12AXoOo0f4qzFV5R5uNTbULlOapMIYSvO3GC3Jv0+KBU21yc9qaQX4kwquEXEglZKPXX6Eeig6hmgK2ofzquBjMH/ynGzzeLhE9MDKXRT/lF44crMayQIqnr894tYcDwg6gk4/+UrPxfQK7H7KlO8mfLH6NTSOU2914rnRYtDaxV+eRO8N1Na/ZInpYSJul2821s/oPLIUpCE0INlouSlWjsppY0Q3QPLdDqM3ieRfaOrbQsj594tdQOFPUZ7ZmijHizXubVTe74UnyIonLHHkuRI6emZ8hGEEPcogr49P/LyG7Hphn1C84gERottvIbEK47pYCINqru8wx3XOe+vHxV4R2Rhk+eNHMKPc6UEuRrToEvzZbmx45zEKNtzw5WYAihNtdUiETMl5shvOCtEyrfvOMhdG8JDmVhm4sye8qD018cI3dS0xGUBp/kBvlaSdXzwMsmheohhCS9zNzb82iwsXFlT+puGK4rN0/aSHdcng0bq8zFPQLj3QziMyZ9EyoDTEUTC0Wz9QWgD/lDyoBsksFG+gJIODC+cMfQYLAyP6mZwnLOq6rUckncF4NHt4g9M8UXXSPRHhBltMDCF0W0PmPYmctrAz+u4Be3zrXx/AeKFWsubV8JirXktyYW2NJ10rRiMj9QR1uHiefyFOF0vkpQkNN72ACjyywm33iAEcBhkg67LSRXKztObGVswc1i0Uw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYWPR01MB9420.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(39860400002)(376002)(136003)(366004)(346002)(396003)(41300700001)(86362001)(26005)(9686003)(38100700002)(38070700005)(122000001)(186003)(53546011)(5660300002)(55016003)(316002)(66476007)(52536014)(66556008)(64756008)(66446008)(83380400001)(8676002)(66946007)(4326008)(76116006)(2906002)(6506007)(7696005)(8936002)(33656002)(478600001)(110136005)(71200400001)(54906003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-2022-jp?B?Z2VGU0VGaWRmRDNubU1qT2hraWNPM0Vaa3RzWStpT05kcnZaSEdTL1BW?=
 =?iso-2022-jp?B?WmFRdlprTk82Y2ZUcThLQy83K3gxdG9mVHFKcytxaW9ONDk5TWpmK2sr?=
 =?iso-2022-jp?B?VVF4dzFjMVZVN2JPR21Ec1VQdlptSWdsSExoY1BlRzMzdXFsdnR2WGFL?=
 =?iso-2022-jp?B?bVM1dVROMEhZYzVpUXkzU0VmYW9ONlMzZWFrNXREMjkzUjdoQ1NlVEpo?=
 =?iso-2022-jp?B?a0JLdE1DWTVZeFR6Z0J2UlJ6Qnl4NSszMFliV2JJR1N0Yyt2Mk9Sakw4?=
 =?iso-2022-jp?B?M2pPRCtvd1h6bDVaQ0NBT2Z5eklMcENlMTRsdkYvZnJpWVJZNFVOYkRr?=
 =?iso-2022-jp?B?SVpDZjUyKzVPQm04NE1ORTdtTm8wZklpanE2eUVjVk85VDVLNW5sbFpG?=
 =?iso-2022-jp?B?amIzUDVrUWJ1T200dlh2ZUNseTRwUEZHUWZZay9VTHduUUFmN1F5YlE3?=
 =?iso-2022-jp?B?TEhjbFhCdzZvQXc1S1lHNEVLN2RtQ0w4TWl6ZVovRDl6czVWSTJLeUls?=
 =?iso-2022-jp?B?d1NzTmlZcWdCMUJQRml4SVo0aU1mVXB5SEo2QlFZRERVQUpnTWZ1RUcv?=
 =?iso-2022-jp?B?aGt5SndCeHd4Q1V2eitRdHRzbEU0TVc3MzVpY0ljUWhJeElMODFMMTh4?=
 =?iso-2022-jp?B?cVdKaHBQR1k4REpCWXNITmNXME04WE5RN2Nzd0ZRcFM3RFJGU1ZuMmtO?=
 =?iso-2022-jp?B?b2lSZGt0bDFOL3Fyc2ZWMEtLYU9ETjdlVUo1OXFRSWdDYnRrYVNkYml0?=
 =?iso-2022-jp?B?Q3BQV2Q2aW9RQnVwRmNrYVJqMXFOL1VkUVc0ZE1YV0RMdVFqaENOdjd0?=
 =?iso-2022-jp?B?aDU3cG5lQmhzclQrLzlXY1pHYUFrZXVSaVlkNnI2d3hzWm5YUVYybUw2?=
 =?iso-2022-jp?B?Vlg4ZDNXaUNaclB1OFJVWXVpRTVxWG1JVHdCTW9RcXowTkV1Q1JwYVBk?=
 =?iso-2022-jp?B?YTIwS1ozZkU0bXZRNHdmVm9Qa3JJQkYwTFRlYWdpTDNHamduT3BZQjZY?=
 =?iso-2022-jp?B?MkpybEJjVll0N2ZkNW5XeU54aEhKMkVzRVBhc25hM0hiNEE5Zmp5OXZz?=
 =?iso-2022-jp?B?Y3BPTmViVnZQeTViL1Vqeng4RTdrelVta3Q4S3NvRHRJa2hkd1RQRkxU?=
 =?iso-2022-jp?B?elZFZXZqMU1KUnlyTEpheUhxeXR1eHdjRmtOTzcxS0sza1JYRTlJMHZN?=
 =?iso-2022-jp?B?RmdlUWt6RWFCbWt1SS9XYXRPMGpQYXZQbXJCQVppZ3ZJRjJrdlNReHR1?=
 =?iso-2022-jp?B?STRJR1Q3eFdLZTdRN2pNdTM2Mkpqd1BhSTlzcGgreFpsV2IvTmxvbVR3?=
 =?iso-2022-jp?B?ek9pR29hQ0lINnhneFdXcy9xemNESjVvWXhHaGFrVlNYalJPVTVVaTNK?=
 =?iso-2022-jp?B?OEtycEF4WW9BdUttQTVYdVIwQ2s0bk9OSXZTTUYrVzluT3VPN2loZGJs?=
 =?iso-2022-jp?B?SHBZa0RRTzBlMWpnVjFrdFA4M0IxVWk1UkZkaXVlUWVXUGpsMmxKSytQ?=
 =?iso-2022-jp?B?YU43UEZtVEFtVW5JUi9LUFFNcytQbm56UmttREFtdnpweS8xMWt3ZEpK?=
 =?iso-2022-jp?B?OGk2YVVtb2pTeHY5M0xMZHZJNk45a0ttcjhHOU5xbkJRbGYzcnlnVHFK?=
 =?iso-2022-jp?B?NnlpT2RWYURGQ0w1OFhXYW56QjZaeGI4a3VybG5ZMGVla0hrMmRDVGlZ?=
 =?iso-2022-jp?B?VEh1TGpXSkRFUVdOOFFaU0prVStHQkluR0x1YTZOdEpTVUsyN3Jwa0xD?=
 =?iso-2022-jp?B?L1FHcFpuNHVXcXRYRGpJWDRWSjlvYUJZWTR0NXgrM2NkaEZzMEk4Uzlm?=
 =?iso-2022-jp?B?VnMzY2ZNUEEraWZqakNXSm1KRlVnM3cvVDNERSt0a2FoSUxDUXRld0I2?=
 =?iso-2022-jp?B?bFV2a3gzcGwxZWNwVlZHMStyZCszWWF6dWhjNXYvc1Zsa09UTHlwNDM0?=
 =?iso-2022-jp?B?T0U4bVh6cWRqNWlTV080ZWFtUWgxTVJHVHFZaHA2NVYzV3k0eGg2V2Iz?=
 =?iso-2022-jp?B?TW9QRmI5OXRJTWdaWUZIVjFnVXNDR3Y5cVBTT3MvSWtnMjk2czJObUcx?=
 =?iso-2022-jp?B?cnAvT1k3MitvanFjQUtHRGRxOFR1TDhjUjY5YlZCYUozODBrYkhPMldr?=
 =?iso-2022-jp?B?bTZ4QUkxdGl2cE9RM2xCc1NHaC9rZk9kcjhsakcyYVFvNHliL2xEUmVN?=
 =?iso-2022-jp?B?M3dBQXBNalYweHI2a044OFM5OHlESVRqay9vOGtjakJiMXJCQ01weU1n?=
 =?iso-2022-jp?B?Y2owQnk0bnUxQm9tQ0xueDJHSEgwaHRubHcvSTNvUkhFaHdxNEVzU0xv?=
 =?iso-2022-jp?B?T3lsbDZnNkFkMk1HMHYxV0V0WmN3ZWQvYkYvNkFLNjN2blNLY1RUbWtT?=
 =?iso-2022-jp?B?VjFQY1BQbnBIdFhhb0pTYUJrdHIxd0EweS9LUE1sTWlzV2ZrS1EzZ2Vo?=
 =?iso-2022-jp?B?cFYzNlplRkVQTElyOWZqUmlZUUZXNXFCYjhjQVE0K1prMmNTU1FPcER2?=
 =?iso-2022-jp?B?ekJRbWJyVjM3YzZVRmJXRUtGeGYvV1ViSGxwb3ZxWVdsd3pEK09pOEd6?=
 =?iso-2022-jp?B?WUZKSUQvZmVOVVZJdk5hYWZKLzhQVXcrakw4NQ==?=
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYWPR01MB9420.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0cd66900-a36e-481f-bb66-08da52809b38
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Jun 2022 05:49:13.9668
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f109924e-fb71-4ba0-b2cc-65dcdf6fbe4f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: HRHuSwsiOsBmEL0idJc1Zf+EtXSeU1vPhirPAgZ3+1yNuxIJcdKt1bISnCDNxhseln4vNlSM34ErwxwC9WYNz4ZqL5GkVZUcTjWQlXmpLQWZ+NBptShIYlCjDzDoLAK9
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYAPR01MB2238
X-OriginatorOrg: toshiba.co.jp
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Thanks for your review.

> -----Original Message-----
> From: Jason Gunthorpe <jgg@nvidia.com>
> Sent: Thursday, May 26, 2022 3:27 AM
> To: Baolu Lu <baolu.lu@linux.intel.com>
> Cc: iwamatsu nobuhiro(岩松 信洋 □ＳＷＣ◯ＡＣＴ)
> <nobuhiro1.iwamatsu@toshiba.co.jp>; Joerg Roedel <joro@8bytes.org>; Will
> Deacon <will@kernel.org>; Rob Herring <robh+dt@kernel.org>;
> devicetree@vger.kernel.org; linux-kernel@vger.kernel.org;
> iommu@lists.linux-foundation.org; ishikawa yuji(石川 悠司 ○ＲＤＣ□ＡＩＴ
> Ｃ○ＥＡ開) <yuji2.ishikawa@toshiba.co.jp>;
> linux-arm-kernel@lists.infradead.org
> Subject: Re: [PATCH 1/3] iommu: Add Visconti5 IOMMU driver
> 
> On Wed, May 25, 2022 at 02:26:37PM +0800, Baolu Lu wrote:
> > On 2022/5/25 09:31, Nobuhiro Iwamatsu wrote:
> > > +static const struct iommu_ops visconti_atu_ops = {
> > > +	.domain_alloc = visconti_atu_domain_alloc,
> > > +	.probe_device = visconti_atu_probe_device,
> > > +	.release_device = visconti_atu_release_device,
> > > +	.device_group = generic_device_group,
> > > +	.of_xlate = visconti_atu_of_xlate,
> > > +	.pgsize_bitmap = ATU_IOMMU_PGSIZE_BITMAP,
> > > +	.default_domain_ops = &(const struct iommu_domain_ops) {
> > > +		.attach_dev = visconti_atu_attach_device,
> > > +		.detach_dev = visconti_atu_detach_device,
> >
> > The detach_dev callback is about to be deprecated. The new drivers
> > should implement the default domain and blocking domain instead.
> 
> Yes please, new drivers need to use default_domains.
> 
> It is very strange that visconti_atu_detach_device() does nothing.  It is not
> required that a domain is fully unmapped before being destructed, I think
> detach should set ATU_AT_EN to 0.

I see, I rethink implementation.

> 
> What behavior does the HW have when ATU_AT_ENTRY_EN == 0? If DMA is
> rejected then this driver should have a IOMMU_DOMAIN_BLOCKING and
> return that from ops->def_domain_type().

If ATU_AT_ENTRY_EN is 0, nothing happens. It does not work with IOMMU,
it works with the memory space set in device tree.
Also, I investigate about IOMMU_DOMAIN_BLOCKING.

> 
> Attaching a the blocking domain should set ATU_AT_ENTRY_EN = 0
> 
> Also, if I surmise how this works properly, it is not following the iommu API to
> halt all DMA during map/unmap operations. Should at least document this and
> explain why it is OK..

I see, I will check DMA during map and unmap operations.

> 
> I'm feeling like these "special" drivers need some kind of handshake with their
> only users because they don't work with things like VFIO..

Since the devices that utilize this IOMMU function are fixed, I do not think that a special handshake is required.
Could you you tell me where you thought you needed a handshake?

Best regards,
  Nobuhiro

> 
> Jason

