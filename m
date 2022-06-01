Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 97DE753A056
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Jun 2022 11:29:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350520AbiFAJ2k (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Jun 2022 05:28:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350221AbiFAJ2K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Jun 2022 05:28:10 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BBA853FBC4
        for <linux-kernel@vger.kernel.org>; Wed,  1 Jun 2022 02:28:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1654075689; x=1685611689;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=vLG4MWGefkwyyCJmkbNqYH3/dtWX0kcbAFR2OOw+zLU=;
  b=FCvHI3r3eK9cYTRBk3cZbmGU2mSPXnfUZgdLvvNExm4zWomZqYM+shjg
   K/L4fZZWGtAEQBWLnkt/jD69eS6tq1MUvsoK1pBnmkf1oNTq1nc1x5CrO
   OUWdm3pFa3hz0EaXioX7OFYVxgHWkV8LQ11MZ0pAbe8MSMSnHLfvBWkKc
   nY4LwdtP/gTmYO34jKLxBNz9oYQ+5tW5MqBA5dcTV1K/5U4gzPupnBAnt
   bKAKYXDhPNOED2Ny/fEKn4XsusJG8QiLrtMvRhQLaFpdKGauqw1xPrHvg
   yzFM11N/LsIa5jZb9iNDgomSvbo0yh4AfxozC9KEBGWegJ5JHuZZXcGxF
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10364"; a="255399913"
X-IronPort-AV: E=Sophos;i="5.91,266,1647327600"; 
   d="scan'208";a="255399913"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Jun 2022 02:28:08 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,266,1647327600"; 
   d="scan'208";a="680009890"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmsmga002.fm.intel.com with ESMTP; 01 Jun 2022 02:28:07 -0700
Received: from orsmsx607.amr.corp.intel.com (10.22.229.20) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27; Wed, 1 Jun 2022 02:28:07 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx607.amr.corp.intel.com (10.22.229.20) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27 via Frontend Transport; Wed, 1 Jun 2022 02:28:07 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.172)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.27; Wed, 1 Jun 2022 02:28:06 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IJlW/7kugZKDHmSEzrGhnvHByF6Re4pIR29dtLYGTZWOiAiRcXBfTqWkOIxRcCjuDkbewL2OCgiFNDAdoUKoIOPJHGKAL0FVs8uO9xA56CGVPc+XI92TE5ymoNy+6FD7NNU+8ybB/b+PDU9rxZqAlXLCWurR+k+HKgcZI+NEBvJtFgx1dIqr6+74mHaw94Jc9snpIKpS2RNY8JcPTXESbe6clOddGHtWqa3LYIj9/MQQRK4ubeAMmF1T28vD5svIGtQSz/PXwcoZ57XLdKZllrYKhkGa/GD4wv0ldCrVX5JRJVpcGI3xT19ZolOAFj40QnVRXhYMiXtv5MuP2lS+Gg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=K/LZVGa2sA/Rn7jeQCFe/sW84kBzWrBzV7n7HLSBa24=;
 b=Blvqq6FTOQf4VYzWWQw29kX9yo5oSeJVweJWDoePtSXmZR7OzdKHyRy7hoF/v3Xa8SMCytcJoxfdlG3z81eENpqpp/b3/HJ3MQoAzrrwcvjdw3NINmK58O7ippeEnr5c9YPunHC8cGZ9qNV/9ar9IYx1qFzW7wFOAqnXHgtVixy6NhA2IMfTXIXlGWlDOUfgiofAuycaAzMwWGIfjoIfCxffrvlj0uFk5Xfx6ou119OoH6EgHljvf4bG8zFfzyxuvgwjmaQ9KTYo5ggUmTFwCVtzY8SVvAtiqQV27CY7Qs9AlKlq4cwsJ4f1mW2d0GsecNG5B4Vr+mvdbj5FKxPbuw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by BN6PR11MB1475.namprd11.prod.outlook.com (2603:10b6:405:9::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5293.16; Wed, 1 Jun
 2022 09:28:05 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::a1cb:c445:9900:65c8]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::a1cb:c445:9900:65c8%7]) with mapi id 15.20.5314.012; Wed, 1 Jun 2022
 09:28:05 +0000
From:   "Tian, Kevin" <kevin.tian@intel.com>
To:     Lu Baolu <baolu.lu@linux.intel.com>,
        Joerg Roedel <joro@8bytes.org>,
        "Raj, Ashok" <ashok.raj@intel.com>,
        Christoph Hellwig <hch@infradead.org>,
        "Jason Gunthorpe" <jgg@nvidia.com>
CC:     Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
        "Liu, Yi L" <yi.l.liu@intel.com>,
        "Pan, Jacob jun" <jacob.jun.pan@intel.com>,
        "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH 09/12] iommu/vt-d: Check device list of domain in domain
 free path
Thread-Topic: [PATCH 09/12] iommu/vt-d: Check device list of domain in domain
 free path
Thread-Index: AQHYcZPVYxDxhgtiEEikhmCfUbpnPa06TxHg
Date:   Wed, 1 Jun 2022 09:28:05 +0000
Message-ID: <BN9PR11MB5276C3D7134CCE64D88F6F048CDF9@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <20220527063019.3112905-1-baolu.lu@linux.intel.com>
 <20220527063019.3112905-10-baolu.lu@linux.intel.com>
In-Reply-To: <20220527063019.3112905-10-baolu.lu@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: e5ca830e-3850-46f1-780c-08da43b1082b
x-ms-traffictypediagnostic: BN6PR11MB1475:EE_
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-microsoft-antispam-prvs: <BN6PR11MB147585BF7AE2648C0AD86D828CDF9@BN6PR11MB1475.namprd11.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: XfdW3rM/Z71lhGa+wsq8D89cLxiTwwUxCrT41wKZEaZ9bAQ5H/+5wcAKndVgcOavGNbuA33PtSS8rOvvv6jJu6urahJn8g+oEDUg9ZJAcvAqsVm8kgPTMaBFLm7ChW8FmCJOmKauTTkqt+Y4eMDdqYEZy70Bw0jrGrMoZn0L8Zm8ZM/7bGYGRkpQ6645SDdHGvpPQRFxqVzHT/s67N0eTmF9DIY3Jxsu3GZ+REtENkvs6yUHLDGhWHG8dRxSOv9ewPf5OwK0QJ0W2R40MJgC2WnY29/QHgShDUlEw4KgLQqggP2mXh2RmE673UZ+Yz9T1/07IVXKyx0Fl2R28YetoN4ZIbwLkRu+YW7sZWcOP2yz8E829t/ddMPex8wGYDbOUc5SxVb2lLUPa+woG/hRbzcCkz39eG2mPBYitCxjon6WMlv8P854+HhLqKI1dmPjnORjs/sbYBjkJMbyGBBMqq6lv88udG5r2C6T1/8Qq5uzOkz3t3jlvw7n3zNYJCWIj4bxnOCBG6PNinLM5sKZycoOzi4Y0Lx5p1hvXWP8Fi0Gim8sL7WoC8FxkHpcF9Vbw1B4fBptKl1XGsG7NReWPtCIQpUrRTWccS4MXpPOCId6xMULl6t18SVf1VaAjk2yQ2iZmSlV0LWF4kMDF5azlilbuvqpOiI6ZCLJYa7iShHncn888nmD/E1ZYtjKaxKRvRiZZSOxdmO6llwW3+lMlQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(6506007)(4744005)(82960400001)(38070700005)(110136005)(316002)(7696005)(54906003)(2906002)(55016003)(86362001)(8936002)(508600001)(64756008)(66446008)(66476007)(66556008)(5660300002)(4326008)(8676002)(186003)(66946007)(33656002)(71200400001)(76116006)(83380400001)(9686003)(122000001)(38100700002)(52536014)(26005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?1IAdX7tgi3EPJVuRq3RvUV0Abl/yL28e8nsBxgrIhpd9XaL26ttdwwYCaCnw?=
 =?us-ascii?Q?sAvRvwBkDGSWGaYUhxqIDG/wyD6yabi4SdTZA0CTX+BUExKZlAt9GQVxbCi+?=
 =?us-ascii?Q?5OVwYhTkgBSDPcalWz0/8jBcx7vOEi1EJxLAXLW71O0rXtPFeWpkw6FTfTVm?=
 =?us-ascii?Q?sNR9xejzO0j54T0J9A3dsRfebjvvsDWjndoy2L+CxzszK5LFWcfVyTj8FYMF?=
 =?us-ascii?Q?RXUTnimc8sYFTV/FNI2r5jZtaI50Qs6HWVCpEjn0nVlGvWjDCtFELcsDdvjC?=
 =?us-ascii?Q?oYmjGa/S7piInRNwZanyytWPdDv2LePVWEC7A/5hYXYWnEk2shqaqW+NRwTV?=
 =?us-ascii?Q?61RZl+pg0Erf6L5WFeTRl+3C7Vez0HWSylrRuzLH8ezThvbebkjeJ3YoBqWP?=
 =?us-ascii?Q?6EnOEADWig3b65tfMRT9K4M45dBWjpT4NZ8mwk4HxsouEec2TAT7qf7/Bu9i?=
 =?us-ascii?Q?EdZzov9nH5gTGLuMIAuRPXjuoAYxv2G4r/WOLSD0t7eRHlCEGjxqyzmPti4Z?=
 =?us-ascii?Q?1EoFd7IqkLGe6YJaSHh3mAHaLHtHTlrTM72Hjy6Hh4rqP6aoVwjOSPghaiti?=
 =?us-ascii?Q?OaFVNf9jHAeNzqnCaVVWArlIT4x+bxfRBCT0vVnNuQ+h4hM3W3C7cHiHJen9?=
 =?us-ascii?Q?KCLxeEocjzCJc6yLAifhsz8LwBlDrqLwuyul5VOUMT34DlN93rwOdcCgUPCB?=
 =?us-ascii?Q?gO3JQGylF8wwm2lSAZMyy34adxjozQ6tNr5jMju9g+U6AGR3fu0eNmeqChsK?=
 =?us-ascii?Q?ggvynmbwCOQSLFG3nRwCvmdVnVkSoOdne2DgH978/SvBSS5sh9GU3purY3bM?=
 =?us-ascii?Q?d+roAwq+jS3lQRhjkkAfZ72YSzqyG5R3sg8jalaL5FLrrYXdtCOA/MXJHYv8?=
 =?us-ascii?Q?YlMGsQ/8qEtcU/i5+KSBVMXTYM6SNZ8TvtE+wuSTnz7QZIhojHTjD3LbYjUV?=
 =?us-ascii?Q?NmHLJhcKNxDcGCtGRbJTn81pkrozH1lJgnHcnFXrGR/XWVnB+ngMqWwblbnR?=
 =?us-ascii?Q?443iIRpkis3l8D/1MeJ/dHShvt3ZXz/ZB+qYpuiBUnPkp2qnSPQ046NLK8cH?=
 =?us-ascii?Q?krkdh90Hfadk6zkzOO4F71s2SD3/A/WOuPO7PYrltKW45CA1Hoio3i1H8pmw?=
 =?us-ascii?Q?c95zaWTgV+nag0TWYTg15VTSFhEIzWgMUIiPDErhPyrXRezzHv2/BWBGtHWH?=
 =?us-ascii?Q?sZGJD53k4Rqjv2SLygv3uRVe8yq0rNCeo5D8cWsnAZEPUUQpYeuleykUko9d?=
 =?us-ascii?Q?kM/s22s/pq8i3s+/n1wfcMD/Bt0pzTi87f9eLAtqNXq0CYLNQkZ1Bbhq4Vr4?=
 =?us-ascii?Q?208gvk8ZYSHylIQMyOiIDwv2jWg7jaA/HepF0oGCoZt8XFyW8KeLvdaE2zRz?=
 =?us-ascii?Q?N3q3XD3hASrwgOQRsv+zg+W6I6gf11JlW8YH0tL3BQ2/WdjZW4vCutxigg4x?=
 =?us-ascii?Q?zQahDE7pvP7PnJuaK0Uxf+28SxE+5yfMmpEkNebd6dKVynlvcpVJg0/fn6Tp?=
 =?us-ascii?Q?D16Kjo3fQ1M8Jp9Q72kWX5cWqYJXhMBfEtNv9kNy5VkjOhaBfpKffQZEnmCV?=
 =?us-ascii?Q?UVyV66kwLeXmBxTir5u3I9p9c3thTYCATjXFHL5l/oAOPUrNFSVY7BSQN8FE?=
 =?us-ascii?Q?5rz6dkny0mjD7Wq8m9DqRxyHQq/0DfWIDCgqUpiKmiO5pLhboyhEs7ueJref?=
 =?us-ascii?Q?JO6w1ErL/NyPMAzBe0b2UL2LiJ/1/vowlEnEt+GBOpww6l2GBzT7PHmUraDT?=
 =?us-ascii?Q?WS3H/tjSqA=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR11MB5276.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e5ca830e-3850-46f1-780c-08da43b1082b
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Jun 2022 09:28:05.1529
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: PMYHbN1sLsRpx9EpmoG4+UHFhHBpxS9rC8kG9nsmZHm6myvVaqLNIqfk576+YnQ98A8C+MTFVh4P3aZvcZADXw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR11MB1475
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> From: Lu Baolu <baolu.lu@linux.intel.com>
> Sent: Friday, May 27, 2022 2:30 PM
>=20
> When the IOMMU domain is about to be freed, it should not be set on any
> device. Instead of silently dealing with some bug cases, it's better to
> trigger a warning to report and fix any potential bugs at the first time.
>=20


>  static void domain_exit(struct dmar_domain *domain)
>  {
> -
> -	/* Remove associated devices and clear attached or cached domains
> */
> -	domain_remove_dev_info(domain);
> +	if (WARN_ON(!list_empty(&domain->devices)))
> +		return;
>=20

warning is good but it doesn't mean the driver shouldn't deal with
that situation to make it safer e.g. blocking DMA from all attached
device...
