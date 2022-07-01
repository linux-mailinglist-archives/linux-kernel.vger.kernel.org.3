Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F31E4562D93
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Jul 2022 10:16:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236038AbiGAIPw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Jul 2022 04:15:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229957AbiGAIPt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Jul 2022 04:15:49 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4529E67593
        for <linux-kernel@vger.kernel.org>; Fri,  1 Jul 2022 01:15:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1656663349; x=1688199349;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=8gnp1JQo42uX6AI+n90mcsRyUxR6za8mgtn/rw8tp5M=;
  b=QLAzlhmoUe++8cYh2qCdiTS5RmlsOPHcfNuv14E/lG91L+xhkUqY/SpQ
   kHLw3Bn+N96qvqc4AYHQXdruM8xIP/0EEXWGMUQrp3jIX0itvbUiqMwPi
   l0kt+j0vfBfd8EkJBxMcwzl6HHEjPW6zTW4e0ueAGlQgJBZrr+n87zPK3
   GJMKPpWTAVfgwMhIYPdhMH4aW10GxElve+VhWYt4nzyCQ7KpQyEHcGZ5A
   P6t3tB1ZxzKOS0GhEV9CtIq8TLHZCbLsAJI5Ar/x53cklr6gFmkAVoBnI
   T7Wo3zLr3w1mFjhMd2WXhIhwQeIFQGr6io/7IekD1m0RDjKVyBZXkDtwA
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10394"; a="262387166"
X-IronPort-AV: E=Sophos;i="5.92,236,1650956400"; 
   d="scan'208";a="262387166"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Jul 2022 01:15:48 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,236,1650956400"; 
   d="scan'208";a="768422101"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orsmga005.jf.intel.com with ESMTP; 01 Jul 2022 01:15:48 -0700
Received: from fmsmsx608.amr.corp.intel.com (10.18.126.88) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27; Fri, 1 Jul 2022 01:15:48 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx608.amr.corp.intel.com (10.18.126.88) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27 via Frontend Transport; Fri, 1 Jul 2022 01:15:48 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.174)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.27; Fri, 1 Jul 2022 01:15:48 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jV9q0hgvwpJZ10M/8LhFaNRs8cynjyCiVC7ggcB768heagobmgt/Rj8qUyoBw5dMqCUH49nBXDRONSgHuvM6jMlw6qhsMUMtwDV9qAWERQGHmEnTvWI1k/y1TolqcO5RjsaJGEvWGkj2mVjLo18LIfIRVmFmQPr68YsZRy1/8NRiokqFHKSaJHJNf3m2edLulmPQDOmrHL95RmCgn0aunG4g8wUX47ovKEERDmNFd/Fnul5VT/Pixcpf4SvV6qvAelZg4CajEE5tEEpheOp9ZQH1+hqC/MJZNJCqVcNBvqOUzeHp1z3pAvMDh9L+sBZnKJptIHHgUhC+fhBlWHoBrg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JYdozj6yf3i3bdz14TYy6p5S7J49uyTDPbt6xuxiQ7U=;
 b=YkUCSIEXMJYB6lzNX8WBAfI7muXo8ucRfRf64KmShKL7q01WcOPrqJYzcfPiZojadeLA1Vj3CW6hoPim2e+w/yQ8CHjqQM7/A8wIU3VZqmtpnA8RLup2+ARtVo4W3AGF+0uMq/IYjIQoLe8Fv5FVxUcN3EQWxXPMX9lHcvN5MdDqnm7DDLDz7vyoQ6muoloE9KlqsPQra9D/oBJPOnFDd85MZT8JA1QHve+sCVYUkb/RHQvv+RfBv70W1PXAhzDmNJ4ggtyeDiWH16nErrXR9jZk0KoaCMGN5u+Rkjc0tPtFbJ4q15Wi7dd8MtxEqDRmxWBrOU1xp/elhK+I4CSOUg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by BYAPR11MB2631.namprd11.prod.outlook.com (2603:10b6:a02:be::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5373.16; Fri, 1 Jul
 2022 08:15:46 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::8435:5a99:1e28:b38c]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::8435:5a99:1e28:b38c%2]) with mapi id 15.20.5395.015; Fri, 1 Jul 2022
 08:15:46 +0000
From:   "Tian, Kevin" <kevin.tian@intel.com>
To:     Lu Baolu <baolu.lu@linux.intel.com>,
        "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
        "iommu@lists.linux.dev" <iommu@lists.linux.dev>
CC:     "Raj, Ashok" <ashok.raj@intel.com>,
        "Liu, Yi L" <yi.l.liu@intel.com>,
        "Pan, Jacob jun" <jacob.jun.pan@intel.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v3 10/11] iommu/vt-d: Use device_domain_lock accurately
Thread-Topic: [PATCH v3 10/11] iommu/vt-d: Use device_domain_lock accurately
Thread-Index: AQHYi40sMMfWvFTUxkmVK9oQLWZN+a1pLhxQ
Date:   Fri, 1 Jul 2022 08:15:45 +0000
Message-ID: <BN9PR11MB52763F336B2535BC89E2C7498CBD9@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <20220629074725.2331441-1-baolu.lu@linux.intel.com>
 <20220629074725.2331441-11-baolu.lu@linux.intel.com>
In-Reply-To: <20220629074725.2331441-11-baolu.lu@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 4f30ff78-5354-4845-8f02-08da5b39e63c
x-ms-traffictypediagnostic: BYAPR11MB2631:EE_
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: go0CAvuiip8aBwh2hmn9gxmuCpVeAoOc/shtLwhFxKpKubonmI0qJUT10omNgqUqnuxjIDTEpLwO13qW/pef5ACrDTIKFhZpWuJLi5Rxm0ptE7/qWVbwaZEJOOHRlgbKoNTagWVQgwajz7Txyf9KjLtbj9CfX/0IrRy+LNQLOTvFpwitJp7P93H4Z/39OeVwtFY4WtxEqMO9VhN+LpdF7wu1wP2yE9domon2foawWeJsfpIXqYbJy/UcWOcD+oawPwdRn/bKjuykGZJVPd+cS8bNf7QRRo6oR4GD+tuYdDWGvOqKp9fUxRxWv+Ufq+MsLDuMZZE1HFEONXWxYNpeCjWV7Xo2jvxeJDX4dSZscoW3FXxc/r1jIWuhEv7hTCNs/8qpIo26RNrlal0/r60EFIJffjCvPD5a5tizW73w7oey3OPZw9uzzWVT2CWuAOmpeIIXutQ0P/Vhe+rXyaeM+dxpNlRD3cLM36SuozqiQ4vSl4abUw98TGX4ZT7mU75XA99icKm2rrMAUSi6lv2pL0MjdDhp5WtosBervmd8HA8d5XkWs/+GI7LJ9cc9GjL8MdhSQZqvvIGuIsAnMvLO8lWxxW1MpooLGaR9eB3WlNbjtyfz2SbzYZgkXxRHehSX9q/H7CfmgO8TQW98mr/7z4haXv9v67Dz3XXW3XjbBsRS9ZRlDYR1JkM01mzN9E+/fHWZfC88/UzHm4rZRuTVLROtB6P42BgNLFq2Uao+C7rkTD0E/N/qQr6pMnmCnRXD/K9gvO0NqYJnRk3NZMhjbAsO9F/G7RYal3dm+aAEaa1VKu6RH6U2gxoBjbXwe3hW
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(136003)(376002)(396003)(39860400002)(366004)(346002)(38070700005)(55016003)(4744005)(122000001)(66946007)(64756008)(8936002)(9686003)(7696005)(82960400001)(6506007)(83380400001)(66556008)(52536014)(26005)(66446008)(41300700001)(76116006)(38100700002)(66476007)(2906002)(478600001)(110136005)(316002)(71200400001)(186003)(5660300002)(54906003)(33656002)(8676002)(4326008)(86362001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?Zfi4ZdOOdZxnU77CANKSGTKlkgoi48wm0jes2jgZjTO/rKQAWBoevmpqgI35?=
 =?us-ascii?Q?EhUQEHGqsNOpDigHvRoJYpC72PiTVIkNSPWUscYrFi9Pk1qwb4Dm2A6Qj73D?=
 =?us-ascii?Q?vTBvfMMGM5SC3XR6YC8jBBa7QHiz7s2e/AHpRmrKW10Kz6gz9l8TahQNn0/B?=
 =?us-ascii?Q?L3jdgQ3dhC8kc2j4P/HSGuqWj9YY/tQyl8sTi6EAznlHnftLqsIq+pjhaX4v?=
 =?us-ascii?Q?wdhnLg42wSNht46XiySZvByj2k4Rr3TL4qztLprWvbiOGWjKIJ0AIs7dRNci?=
 =?us-ascii?Q?l1XP0/vR4kPlWyHw6gfihbzeyRJQJ029L9gevT2FMfRKeC57b/lwu80PcjQ7?=
 =?us-ascii?Q?fgd11LbPGBR1zuDcQeaWvQ+9tZ4Fn8fS8WZEA7Ywdps87RO/i9l8XEtaaUWS?=
 =?us-ascii?Q?BXJq/B3bCIhvc04PBXSmM7gJxln7V6j/6Y/WTeK42LoLs8kiOMOinhNaYCer?=
 =?us-ascii?Q?FkNYvM+QaoMwvwzyQruggOMzMuWEKOBj7Zwf9UY3/+m78gjbLW6PM+g5EfPU?=
 =?us-ascii?Q?l8Ue+TN7DDSRU1+v/KHyaFERMpa06IBlZxmkbfZc64GVP+VLylhjuCMAIGUq?=
 =?us-ascii?Q?HaC9cwESCxxjL2Rf5WIfxWr76ejOFCSuolrxgvRdYPxi90ZgpvtMiXdzasdP?=
 =?us-ascii?Q?LDXK703oQdhwdHgH2IW7kVLO1XUes09sPS8YvTKH49bVpuHHz4B+LNSZNxlw?=
 =?us-ascii?Q?i7NX2d5Uo9yy/8G/F30KC5lZ7CMiZ2evwBzMnm/mR0IESuxWznvSQA38NxXI?=
 =?us-ascii?Q?iSWv1hTT1AvNKGleq6n3tJVZuLZ9Copnjr+PCR9G4qyB58oGVSmd+hYaRsW1?=
 =?us-ascii?Q?/U3ruG/h+WuzBUiHUEkY+RgriyRr/agpo8oZZaCiyl0Fu+UJip2m6DkYSUdW?=
 =?us-ascii?Q?UXOUfbwTQALgIo/DWDJU65zdkfxdqlwd1+dv1woFLJgZ3jC8rFssfVp14fBa?=
 =?us-ascii?Q?86uwPanY94vEbe2AqIJ302q+CFdCcG0ZfVf9eeoOK+JI2NAHGY2D2E3Y2knz?=
 =?us-ascii?Q?Tk7xLW57TRNqJv07UabISaMmIPpYVMh4ThTKvd+B73CbAELGHxIapHXGEl2v?=
 =?us-ascii?Q?yTvkRh7HIqvEmGynN33hh2/JEHajNnJeeu6WFW0Zsqfz+w2ZRTF6mFs0mCBM?=
 =?us-ascii?Q?fMxD8iMoJT0VRBLXhjXNOb7c44+44MmKVuGtBApKxkzJljGXqMBG1SnyzoXW?=
 =?us-ascii?Q?WyGP9TxSGcdthpaAfDh587Cgc38p2KlZYhEGISNNrExYUWBtlEmtOuaAaDkt?=
 =?us-ascii?Q?9TTlMsoG6UeMnGsiE9+lRa3MNdDqnzV6MVCsScnddHw6sZ4Op9TKMh/dgnxr?=
 =?us-ascii?Q?cDz02mYrS9jONJ6goYcpWtBmC6TpOwY4J1LZDKXhDa49OLz9z0EUfnXxNzw1?=
 =?us-ascii?Q?0WLuGanNwuiYmA6LwCzjSU5GIHFQJ/i2DWMTz8oUGXczSMdvpQIO4gf+Ize7?=
 =?us-ascii?Q?kcvE0fFcVE2UlvzcwbTxygNrTxYdENkSfZURzMMWW1lJSRyiAJtAVHy7eVlB?=
 =?us-ascii?Q?lwv3zEa2eYMixhgcFWF0zmWzeNa+utVCVucOvfiG3i10j9MkMmWQG9ee7iqx?=
 =?us-ascii?Q?0VuKfXHmXdvkOolkI/XWkIl/0k9UIi0uKxYFZOcc?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR11MB5276.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4f30ff78-5354-4845-8f02-08da5b39e63c
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Jul 2022 08:15:45.9714
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 5oHqO7oEF+uGTdrFlCU/+43GXkdV5xEvMeAafQdhDtE+KU6mzPAyxO/4asku+X5f92Jd3zR6scgtJzAlNuColA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR11MB2631
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> From: Lu Baolu <baolu.lu@linux.intel.com>
> Sent: Wednesday, June 29, 2022 3:47 PM
>=20
> +	spin_lock_irqsave(&device_domain_lock, flags);
>  	list_for_each_entry(info, &domain->devices, link) {
> -		if (!info->dev)
> -			continue;
> -

suppose you can replace all spin_lock_irqsave() with spin_lock()
in patch5 instead of leaving some replacement to next patch.
