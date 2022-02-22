Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1CC294BFE49
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Feb 2022 17:16:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233960AbiBVQQS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Feb 2022 11:16:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233946AbiBVQQO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Feb 2022 11:16:14 -0500
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03EE61662E2
        for <linux-kernel@vger.kernel.org>; Tue, 22 Feb 2022 08:15:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1645546549; x=1677082549;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=6Bv22+T3lVgCVdMMDzjpVuhcYw2YBLy4C1V/gBm60xQ=;
  b=dkjguKxByA3Xj8fcj0GfEoX7OC7QXzLsOYbH6urLYy+nm7+mWVYRIUh3
   AhjdkL8+lLbckWWc8oNPga80WB/FMuY2luwEA54CIH2NzfrLRgOAEO31f
   F0Gd17VZ3Ns/XclbsYtSWkFjx9ofh+XHJ0fUhseRKagD5COegAwxR5jGF
   zZm0uu9B/oazogyXGyUCEJ5/FnQONO9WIxf34dwl2gGkuMt1e/PKkQFue
   JaMCXzzumRmVIa2Im5/typ07ZgFljMC6RBtyIqrLh4gZbs3vCPT9xfVw8
   vx5VVM4xavd/CCGYd3xvYv7XtKFpAdb8xl8reLb7tvsG6X69CD9JYpn1v
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10266"; a="251484911"
X-IronPort-AV: E=Sophos;i="5.88,387,1635231600"; 
   d="scan'208";a="251484911"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Feb 2022 08:15:48 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,387,1635231600"; 
   d="scan'208";a="542986821"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by fmsmga007.fm.intel.com with ESMTP; 22 Feb 2022 08:15:48 -0800
Received: from orsmsx605.amr.corp.intel.com (10.22.229.18) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Tue, 22 Feb 2022 08:15:47 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx605.amr.corp.intel.com (10.22.229.18) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20 via Frontend Transport; Tue, 22 Feb 2022 08:15:47 -0800
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.174)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.20; Tue, 22 Feb 2022 08:15:47 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=U7T8uu+9CnQeHN9OKrTapz4J7/0D1xby5JFdoWvMruyVPWU+2CtztSjhx6ycs0JnXeFywEPcOwxtTPtnjzq+5QVSFJnrbNDcG46L9tRR5MOac5mcel5jhNAdd7A9l4kJoTvJtsvCVy+FJb9uDEEJzcHpEcU6hxVVEfjuuGsGIbTal/k9TAZW2Y6uU9szjM5xl06LOrJwOgt+eN9RDIufUNo2m8cLcK9IYcKflSShE5yDf89z3itVRm4g6FsicBVkN1d+h+PmzyVFJDyBnz9ptWKa+Vbh3AJYNRWt3gNZVtH9wCoFXTVOHdTt1MpUDNrOCr5PeXQTcfkebVVERjA5jA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jZCMJUaX2gMrZWGAy3e2AWYaD4iNi/mTwngADd1q2O0=;
 b=CL9/PmbeUpXWpidePELB0c5iov6fAeJrkOWoxtMNfbBtzBqcH5YP89RQEgiELzNTNp2KXNsloLrU/wk9szdGkBiqH5gs7i1bBosYvTDG18HTGgoNaFZeKQ3g2VkwkXDAHf9l1kMTBniwUevscTMauynfTGw0xspvZ80LcrPz7inCcFKJiBR+VCpprEYLcVnujwGE4aTerGCPgiuEk7vOipxGv8PiYjW9YcQXNZIRZskOsUptcFC4M7XTqQacs1FOiw7bo9EjOEllt9mossM8OO7TeATrCn2YBw6YAU+GZdrfjzngOh48po0WQRBnHD6njHLKea1/YtnjKYFVogkH8w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from MWHPR1101MB2160.namprd11.prod.outlook.com
 (2603:10b6:301:5b::12) by BY5PR11MB4452.namprd11.prod.outlook.com
 (2603:10b6:a03:1bf::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5017.21; Tue, 22 Feb
 2022 16:15:45 +0000
Received: from MWHPR1101MB2160.namprd11.prod.outlook.com
 ([fe80::d8ec:bf3:44c1:a96b]) by MWHPR1101MB2160.namprd11.prod.outlook.com
 ([fe80::d8ec:bf3:44c1:a96b%5]) with mapi id 15.20.5017.021; Tue, 22 Feb 2022
 16:15:45 +0000
From:   "Schaufler, Casey" <casey.schaufler@intel.com>
To:     "Hocko, Michal" <mhocko@suse.com>,
        Mike Kravetz <mike.kravetz@oracle.com>
CC:     "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Baolin Wang <baolin.wang@linux.alibaba.com>,
        Zhenguo Yao <yaozhenguo1@gmail.com>,
        Liu Yuntao <liuyuntao10@huawei.com>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        "casey@schaufler-ca.com" <casey@schaufler-ca.com>
Subject: RE: [PATCH v2] hugetlb: clean up potential spectre issue warnings
Thread-Topic: [PATCH v2] hugetlb: clean up potential spectre issue warnings
Thread-Index: AQHYJQ7pC+ocI1dW70qd+Zl7K7F75qyds9mAgADEEoCAAL7hAIAAjXwQ
Date:   Tue, 22 Feb 2022 16:15:45 +0000
Message-ID: <MWHPR1101MB2160B81491FFE4411B18F7ECFD3B9@MWHPR1101MB2160.namprd11.prod.outlook.com>
References: <20220218212946.35441-1-mike.kravetz@oracle.com>
 <YhNQf3LUZzNRD7u0@dhcp22.suse.cz>
 <26565cd7-01b0-197c-6ce9-af92f5bc8563@oracle.com>
 <YhSVGPQ6VIQfBZ9o@dhcp22.suse.cz>
In-Reply-To: <YhSVGPQ6VIQfBZ9o@dhcp22.suse.cz>
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
x-ms-office365-filtering-correlation-id: 17be764e-0390-4d20-b77e-08d9f61e9493
x-ms-traffictypediagnostic: BY5PR11MB4452:EE_
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-microsoft-antispam-prvs: <BY5PR11MB4452C85A96EB947E74F9C59BFD3B9@BY5PR11MB4452.namprd11.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: MNxkwq1xGrDMT8AVPM5PzPXApJbG8Dx+T4tVJLPS/Ew1+EkPBYL+60/qQb0J5EiThQucI6QqMwxjdTAfKKM4HDsIjFfem0NY0SAoo6HGEDp7/UsLTAJxhlTAlWB/trCvZgbvJGKl9vofLbVLs1H9uTMNwci/za3pyRvo+P1t4tMLX70cqLnaNSASRCjMMCSnuypBABTpFY8EjNUcZU5vH+FH5uXSavw+8Q86aoVWiWJoFIYMu4g3MilRwmronoxR0cEa2381IzZfu6EIzo7c1SrbK3ZqLRhkKRKAAlVsCnzYPvgeRnnlQQFRep6jdjYOFg2r2EHROIjJX2yzvuYh4Xx4xE0C31lm8dHgWpVfYomCUh8bjQC2+JhyA3fSVyTiOeYXKsAqJDF+JkEdNyIni2Px1UUxNy5pcgrFHaMo3zRSz6BpB5bTjF2FBMNUekX664i9bfyerai5xkyMYdb5skwJ7pIh/REAGcmciRQrW5ATojw1BZTvPix/EkZiVDDmsOXeQ19ZsGiqGcvLdun1muJTpe3w8OaY7LSkLibS+T2xT2Pof92pr9e7XJHsIgUcZRlrWL8O23QfSsy22sZZhZuY8HXEhGo1DM4yJQBc/bWCgrqoZZ79/7fRn4fcgRnSJa3BgkC7ffCF5sFkWkUHpNviLlf9R5f2X7HGFMyCBbmTgqxZFmnUZsqA9bHIyZsK4WxKoCoaXxeWM2ge/WLDpg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1101MB2160.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(54906003)(316002)(110136005)(9686003)(7696005)(6506007)(53546011)(508600001)(55016003)(8676002)(4326008)(76116006)(66946007)(66556008)(66476007)(66446008)(64756008)(7416002)(5660300002)(52536014)(8936002)(2906002)(83380400001)(33656002)(38070700005)(82960400001)(38100700002)(122000001)(71200400001)(186003)(26005)(86362001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?5HRPVpy7lC1yXuKRzHBqRNtQarq9V+hOUA1/noD0zIMpbhTLsk0EJCubIt4t?=
 =?us-ascii?Q?I0g02SVo5xw04c+sBZ8qjXycWCvtl7sHBzCr7RtOzB+xOW0RmSluDVWGcFIl?=
 =?us-ascii?Q?w0wiv27pfL+j3bHX112Wkeq1F4Fhi58ferp4wzCj3/wSyXl9bzy0BpqnYaPh?=
 =?us-ascii?Q?Dj7yFeAmAtZQ4Y3N5OeT60quBUzAG00Af++Sxa3vDmvpp4eFe33XDtD82VjR?=
 =?us-ascii?Q?jHylZpUdUds3NFaE6mbV/5eVfbdkZO93YDvSVY/PUlm8HgMPfgQKgFkK1Lqm?=
 =?us-ascii?Q?KQRQXo7gZ+/EyOaE0Q2c6BUupVlEYAkeqd33C9ovtDPF6WKPN3qwg+XQp3UV?=
 =?us-ascii?Q?UKpC9PSu9q2ebq4qZi63UAwl4EI0j0fb9ouSjjRd0m35eNwezd+HEgk0+Ao9?=
 =?us-ascii?Q?zpdQ3Btd8TUmBBRtARNGYf+UCToZ5PzPUqcymA70MkEtAFOXtptMeEsMcz/u?=
 =?us-ascii?Q?p5FhBmE+2FhObf+bmPvPUmtCNG5ydedoD5ayKPuSUKJxubA91ezI0cdXjFiN?=
 =?us-ascii?Q?LbghfS9T98sP0ZxP5M1GBOhx9ngRMD7dT+k34+sMvKGh5jaaG7NRHihe700I?=
 =?us-ascii?Q?kQY+XEBwrNrPMWn4njYnmdJ5AzTXeKZ/i2RT9NKJUt+Wn7mlwSO3JVTHlaIr?=
 =?us-ascii?Q?9uQejnCL+7sN55xne2WZm8IXYOEOztUz+rQDnCYVeZbpjiwLjWb+kkUm6Wkk?=
 =?us-ascii?Q?0gWO9UEn2VU0sgxsxAYqDftn9J+5l0S3c+PquKMXOesWPLcwdfkzhmaIoIKy?=
 =?us-ascii?Q?lvog5ImMxuVonok8a968Ix2mp/qhkf6X0jL+6A++amsBgeNf5zVvT8hTt/A9?=
 =?us-ascii?Q?bjASqtPqz0PkXbdPFCJLhitdKYfbLfVgigKf3GvxWiWrqCCuysWVnieaTfRZ?=
 =?us-ascii?Q?JhUIO7Titf8DlpoSSxKcF/LE2EiYhFirUbMRpwcgZeNYsr5ZuiMRDjBznSko?=
 =?us-ascii?Q?punEusm9NLdDTHVp1PGGFEO0wpqOLFDpEe7o/ATAVdzcoVRUrCqRrRD8MFHz?=
 =?us-ascii?Q?7aqOxVxCiOEgRYwwHAWC6g3JrVRd7SkHC27WRwNCnEmuzx0X6gmTXIi9vMLz?=
 =?us-ascii?Q?yPD3i+krWPi9wA8ZIt4fDqvhT/xnGpEXRjyn6wJPLlmOmBeXCP7Zezey+6GN?=
 =?us-ascii?Q?Cxgk7Zugty7ynDMM7nEOSqFx2TS5AkF+YsjLTi5T0jq0Td1uVbCBh34zoY5h?=
 =?us-ascii?Q?Ug2CEd//vhmyVu299gwhrZcvZCmt5IWOR9glv83ZEJ/fcZS0kG6MSH7YAQ+V?=
 =?us-ascii?Q?7xE9Gcj/xsmTxL61ZCJT3UzMPRa6AMej1N4ppSrSNnGX9iKP4lR0MqhzQe1f?=
 =?us-ascii?Q?/2c+n/F5hogNd1D2JpFBlTip5lkqAuLte2/lsitstm0Z05D4Esc01GBu8Sbq?=
 =?us-ascii?Q?bgrfKdwhvePUsVTGJDtT5hPz6B8AxSrnegs2js61Bs2OKhDTTsh5jDQNj86c?=
 =?us-ascii?Q?NCo0ZBKwflYDTrDsHAOq4Zrvd2v2DHrbSV7NaBZ3Q2TdMb0EJu+ZJPEgxZaG?=
 =?us-ascii?Q?boYyT0BeUDPfGcqYXOTPBXg4v21hq3OtLLkhZ1SikhZC++hnEhXGjHLNeiDB?=
 =?us-ascii?Q?jglBQwj+4WMzSPRH6k92Pu27xUOLANP7c9mfE8L54xjG2aBi+dLPyomkhNhs?=
 =?us-ascii?Q?SuWI9HDbweSAFobz0ttjEmwQDhHHNN+EloCv1s8zzpjuawz9xhhWpg+N03PN?=
 =?us-ascii?Q?qUUI6g=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1101MB2160.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 17be764e-0390-4d20-b77e-08d9f61e9493
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Feb 2022 16:15:45.0390
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: bqC6P6S0F0G1G0IcjIwrLUA7dJE/1bgWndVOos3AyGYKcXbMxMtZi951RD/NQ/4HDe3fIrzd2qfQH+ir0EAo72gIgTVGzkk5G2DVaClYYn0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR11MB4452
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> -----Original Message-----
> From: Michal Hocko <mhocko@suse.com>
> Sent: Monday, February 21, 2022 11:48 PM
> To: Mike Kravetz <mike.kravetz@oracle.com>
> Cc: linux-mm@kvack.org; linux-kernel@vger.kernel.org; Baolin Wang
> <baolin.wang@linux.alibaba.com>; Zhenguo Yao
> <yaozhenguo1@gmail.com>; Liu Yuntao <liuyuntao10@huawei.com>; Dan
> Carpenter <dan.carpenter@oracle.com>; Andrew Morton <akpm@linux-
> foundation.org>
> Subject: Re: [PATCH v2] hugetlb: clean up potential spectre issue warning=
s
>=20
> On Mon 21-02-22 12:24:25, Mike Kravetz wrote:
> > On 2/21/22 00:42, Michal Hocko wrote:
> > > On Fri 18-02-22 13:29:46, Mike Kravetz wrote:
> > > [...]
> > >> @@ -4161,7 +4162,7 @@ static int __init hugepages_setup(char *s)
> > >>  			}
> > >>  			if (tmp >=3D nr_online_nodes)
> > >>  				goto invalid;
> > >> -			node =3D tmp;
> > >> +			node =3D array_index_nospec(tmp, nr_online_nodes);
> > >>  			p +=3D count + 1;
> > >>  			/* Parse hugepages */
> > >>  			if (sscanf(p, "%lu%n", &tmp, &count) !=3D 1)
> > >> @@ -6889,9 +6890,9 @@ static int __init
> cmdline_parse_hugetlb_cma(char *p)
> > >>  			break;
> > >>
> > >>  		if (s[count] =3D=3D ':') {
> > >> -			nid =3D tmp;
> > >> -			if (nid < 0 || nid >=3D MAX_NUMNODES)
> > >> +			if (tmp >=3D MAX_NUMNODES)
> > >>  				break;
> > >> +			nid =3D array_index_nospec(tmp, MAX_NUMNODES);
> > >>
> > >>  			s +=3D count + 1;
> > >>  			tmp =3D memparse(s, &s);
> > >
> > > This is an early boot code, how is this supposed to be used as a side
> > > channel?
> >
> > I do not have an evil hacker mind, but I can not think of a way this on=
e time
> > use of a user specified index could be an issue.  It does add noise to =
the
> > BUILD REGRESSION emails sent to Andrew.
>=20
> Maybe Smack can be taught to ignore __init and other early boot
> functions.

Why is Smack getting called out? The relationship is not obvious.

>=20
> I do not have any strong objections to using array_index_nospec because
> it won't do any harm. Except that it makes a security measure a normal
> comodity so any future changes to array_index_nospec and its users will
> have to consult additional callers. Whether that is something we should
> deeply care about, I don't know.
>=20
> At minimum make sure to be explicit that this can hardly be a Spectre
> gadget as it is a _one_ time early boot call. If there is a scenario
> where this could be really abused then it should be mentioned
> explicitly.
> --
> Michal Hocko
> SUSE Labs
