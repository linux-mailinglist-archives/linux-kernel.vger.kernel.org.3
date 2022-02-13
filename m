Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 96B5E4B3AB8
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Feb 2022 11:03:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234912AbiBMKDv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 13 Feb 2022 05:03:51 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:59626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229935AbiBMKDt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Feb 2022 05:03:49 -0500
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A54635D181
        for <linux-kernel@vger.kernel.org>; Sun, 13 Feb 2022 02:03:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1644746624; x=1676282624;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=Bt0RnDKark0oEEHJaDQKQAlJHAQSCNAmT5Rblz+J0GQ=;
  b=Y/bjFO7TyP0CTEQ1BisEblxlLvIyGyq/ZTvm/CxhHQKstPxDxtAKnJHy
   EXBDND0IQPdRm7vppQtckG47CoWNjQVG4zRbd9xrN7q376Y8LzqymlvrB
   Fsym5KU0w3iQAnIUj3DlE4oJZAzzv21H17bfk37wmmN7BTyYBjuOJKtX8
   wTiVsBG1qGxj8g7LT6GxYJGv06+aAImaQcSG7+i6uAPT7so9jxUZBrN9c
   sIEnLaBQHWU5sM+J6WUD3/IuFiD9FCg03w2sABaaH1Ab1N5/sYdlYqyvF
   rHOiUAbY7Cvyaci8Bx43kNRYEUGxkWRXleM+wbIbXJuqlp81WqSEggIml
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10256"; a="233488682"
X-IronPort-AV: E=Sophos;i="5.88,365,1635231600"; 
   d="scan'208";a="233488682"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Feb 2022 02:03:44 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,365,1635231600"; 
   d="scan'208";a="602752217"
Received: from fmsmsx606.amr.corp.intel.com ([10.18.126.86])
  by fmsmga004.fm.intel.com with ESMTP; 13 Feb 2022 02:03:43 -0800
Received: from fmsmsx606.amr.corp.intel.com (10.18.126.86) by
 fmsmsx606.amr.corp.intel.com (10.18.126.86) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Sun, 13 Feb 2022 02:03:43 -0800
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx606.amr.corp.intel.com (10.18.126.86) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20 via Frontend Transport; Sun, 13 Feb 2022 02:03:43 -0800
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.175)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.20; Sun, 13 Feb 2022 02:03:43 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ex4vUQmsLdERObEqsHbKnvWHLfUesBmmS/QhowBejhuDd1IdV9/QVtiCOdoGtlRb9hi+0o2kev6pOPEycAnehZCUVlONCAgDkOarekQb0ChNwNftGuiOf5o+gGRwDiPYPn+6Mgwpl/y6pH+WLgTiTfvHK0LS1TAS+YhzLD03MPVTV79yJADru20BkxDGFDRtZc2cabP/ANn1vAzMtoV0KAXPo6ndTvuT023HA1lHXgL9t8V6GkqtCrC8JFteLNg8IlCIbBww9eJmRK5geuJ4EOlZcCLVZwqIQFdtjqrpRcMgULPZ7agrG2H2KUhJo3UJvTVl329IMNYsYs6iVULlvw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jNyJeO6uIWDE0Uc6e1EYqBtO+GdKQe48MFZrNGV2F94=;
 b=CLmPx1Wnec+rSzVEeig8yJLmdcoJmVXvIpcjfWoW3PeCBEpB6FVmXfU9Rs279QPDrM4T3WcO97oETF1I1G7JdJt3Sg5Cc8LQkAVVMxQ39LesmXQ6IjooTaBdx7+PDkLICTPSlAt5sO2vCMj19Q3S3SkwOLg3UiGWx630DIKLZi/6xo4KpFUxchDrsdAZnK3oKpkYXyfvGi0lbjQO4W0k94g0niADi+yxeCMCrlzIYDKR1p+361O86du88bob97HnNJEGAIbvHOQaz2sdJYxzu+TSFZeGOwG14G2AE8sNK9te6oqBUonhuscmNIms0dGyG9bZ39IkZ7Vn+kaSV8uPNw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
Received: from MW3PR11MB4651.namprd11.prod.outlook.com (2603:10b6:303:2c::21)
 by SN6PR11MB3198.namprd11.prod.outlook.com (2603:10b6:805:c3::31) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4975.12; Sun, 13 Feb
 2022 10:03:41 +0000
Received: from MW3PR11MB4651.namprd11.prod.outlook.com
 ([fe80::6498:650a:6a82:7644]) by MW3PR11MB4651.namprd11.prod.outlook.com
 ([fe80::6498:650a:6a82:7644%4]) with mapi id 15.20.4975.015; Sun, 13 Feb 2022
 10:03:40 +0000
From:   "Usyskin, Alexander" <alexander.usyskin@intel.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
CC:     Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        "Vivi, Rodrigo" <rodrigo.vivi@intel.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        "Winkler, Tomas" <tomas.winkler@intel.com>,
        "Lubart, Vitaly" <vitaly.lubart@intel.com>,
        "intel-gfx@lists.freedesktop.org" <intel-gfx@lists.freedesktop.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v6 0/5] Add driver for GSC controller
Thread-Topic: [PATCH v6 0/5] Add driver for GSC controller
Thread-Index: AQHYILo8+RGY4WXVSUe7Y5RB0qLVk6yRPmeAgAAB0YA=
Date:   Sun, 13 Feb 2022 10:03:40 +0000
Message-ID: <MW3PR11MB4651F5FB8353D56C90D6F239ED329@MW3PR11MB4651.namprd11.prod.outlook.com>
References: <20220213091458.2364014-1-alexander.usyskin@intel.com>
 <YgjVuyE1n5vl6uR1@kroah.com>
In-Reply-To: <YgjVuyE1n5vl6uR1@kroah.com>
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
x-ms-office365-filtering-correlation-id: 1cd63328-d18c-4322-0731-08d9eed81c7f
x-ms-traffictypediagnostic: SN6PR11MB3198:EE_
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-microsoft-antispam-prvs: <SN6PR11MB31986FC7327CAD3A93616A46ED329@SN6PR11MB3198.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: HGaIdkz4JSK7iIVWZtmKa7AdhLpSr7X58jH65wqmrMA2KU1yRP6s/RnQvPLDMaf17xLr/n0QgXz2qINUfspu2eWYs5FrbdEKqD62tw6ICRlR0w3IW53Bv5phZ+I0oBY2lgRHeimolkNcQ+30H7EStZ6RpkkGSNz3BOH5xCuIv2ZRSUHsw88A7qXLxOdo6TXmJY8xrJaBPZtjO2SNprjve3KXIE1zFo7OjpupKf8Qb+x2hVpcZJ9yHA3Bp26cqopKSvTdLuiubv/1ZMWThKzvTpC5heRilFUrgXz06ZPiteCw7vmyMAARpMZ22XBfHkhdbNImmWFTuYYmlM2J46KAhoeMvGbjx7s8kqaqbZcSXdYfi0+7RW1gD2IXUVTbVP8tvrNTKCh2Hkp+KlqrdoSCCobNzGMSk7mxGcrKUG329kTKtdPSYCHPkoCTMDWNV28Gl+3ehdbAr0ceJ5mSVkiZr5ujPeYE+mYqJnmER+3WHYbxNgOjNyo5qFLK7n+le6msy3IXj4BoT5vRF+gYbkJ8v8KqQ+yxppPXQuR+HcUQO/n94RezDPFcmFIrB2zFoy6uxuVkAAVZ22KKbCPAhHOofwTdPSOz17QaMY6b4usbYzCjM2hcUbHz41IeR+oE9cOEPsFrjz5vwtGT+F2IvDQDJ7dQgx/zYMN9Kiix52wgQb4xGQpRQsyKsEZc3umW1Sz66qiob0ZfVW+XqPwPmGuJJg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW3PR11MB4651.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(26005)(52536014)(5660300002)(38070700005)(66476007)(33656002)(8676002)(8936002)(66946007)(76116006)(4326008)(54906003)(9686003)(316002)(64756008)(66556008)(66446008)(82960400001)(186003)(83380400001)(2906002)(71200400001)(38100700002)(86362001)(55016003)(122000001)(508600001)(7696005)(6916009)(53546011)(6506007);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?l0v+vcVAcTAe2xRqYBc4r9NaMD0eTiq+x92R8WfrYHWqb6kMEcSa4BUwqs/8?=
 =?us-ascii?Q?PzahDl/pPzeoUpIM219qfbFnYEn4L+XxEXn1wLarwqNQMWQHH6IuctVawt8r?=
 =?us-ascii?Q?FCH02jvjStXoS1nqKEj6MnO11eUVpcHc8DbI6voc/+u4Ga6yWRHgZOJczt+O?=
 =?us-ascii?Q?RM9HZbLHoY70TNZCbyDtapOwpDdZt5mgQPgHNM27CUU+E4VTpI1jrnnueF5L?=
 =?us-ascii?Q?jDgh2X7UisV1bb8xHnTcVq6+6capOAPLk4EwNp7qKqXC2nmIWaX30DgXXhMB?=
 =?us-ascii?Q?zm6u+/CWCUYt1w/OkQAluSjJ2OamV0ELfSlkmEtiUPuTcb1rTRn/4h/qy+Pj?=
 =?us-ascii?Q?pYlpne5mN0HM9kNhjHFLWSWVkt7yzuuIBMSF53kwtrjy/tefai8l5jRPeeBt?=
 =?us-ascii?Q?788xusWW9FN5BaSxaGeIAXViDxCulxGhnbKP+VPgNFjA9VTHJXhYnb17FT/Q?=
 =?us-ascii?Q?WPEhY24r/iA+w1ouRCD8QJqGZX4+BIrppnLKsFuWFVlQ7vIne1ZgFLBvzQ5+?=
 =?us-ascii?Q?DXWHc7HVw7itgrz6u5ZdHJaZbcrzpOSU58+COni8yhmw1jzyY11OkYM1VtXO?=
 =?us-ascii?Q?+8b0UsjolRoqbT5uAkDmPAnRcxs+ZmeziXCWtkK5xx/BkFh4+TweYRh037ea?=
 =?us-ascii?Q?rVlRPznTRIzMU5fBj718Nrb5Lgbt5g+0Sd3BSlr9C418khZeYpsmGrb04M3A?=
 =?us-ascii?Q?0V1YXdurNY3oYKZnulb9jvXExmSvfJ8rkVRkU6XoQS9bBX9e4FPt/DBfxomY?=
 =?us-ascii?Q?xW0ke8s0WrHCLv8lnl443Ku7bi/TwodKk+VCnPx9LbTiNpUbw5/ppGa817UG?=
 =?us-ascii?Q?IMTGagDTOp7dJQAjJxo1ba8yuWDOUbX6mYtwNNBdxuEhm678VUH0/1biqm8v?=
 =?us-ascii?Q?abrPVuH8Fu5dEJ+4vCborn2aUF8Qrp2ScjuJOi+s4Z9XcAxMe67Y/kdSDSfq?=
 =?us-ascii?Q?nLTDJ9qwx/wonzuJW32F3Ae9L0/47jERBmdIfEY/yRNb8cD5f6hjKXqso+bO?=
 =?us-ascii?Q?de7Io3ySg6cge92mXtzI0FOt9rHiDOAO0NXJBl8Pre0ix2kLhdPvSTMbu9p9?=
 =?us-ascii?Q?XdsVvWjU2o1UhY2sEu/WYlr/WGcjcg0nW99odk8oJkpwePASPheUyRD3Sr9L?=
 =?us-ascii?Q?Tw3OaSpzFuvN9C5dAcPIucBLuCZh3XvpAgc4nmVjaPk81dmLCT2KfBD6jITO?=
 =?us-ascii?Q?Te8Wt5Jm7Hr1DSTiZZJLWgY1XiRna9tphJHKrbXP+Wo4/NgTaDAc2xQ1OdVP?=
 =?us-ascii?Q?/tPcyEz7jT5gAnIBiJDzTYGX16uTB1dZGe/bQPq2NPYKZnUUceLh7cdywuwY?=
 =?us-ascii?Q?KvfAxkCuVtuFG5jeJC3Q8UNqdRGbJmEvR7RAsm4ZLtx/jlg3QiCphJL7naq4?=
 =?us-ascii?Q?j9Zf3jwUXimJWSqAFfrsmm5iXwwTXyJtREoNidfofwCVX/TOB9VjGRKqNjjM?=
 =?us-ascii?Q?vYBUB8HEBITdAOOONVHI/79dYDdOPrT7a1dRZPaIbgQQxlx/nWWOo5odnq1z?=
 =?us-ascii?Q?SbYx967sjNTzdO4bOpD8mNTo6pEIILKoQgUTTksGoaRcLTZiHnh+K9W4QykK?=
 =?us-ascii?Q?mqnAqmE1OJcZJjyh8oZp/KQciWbt6hPd2uI+WYhC9/BBywCYtNYiV9wqN+sh?=
 =?us-ascii?Q?6/m7PBOH5kEIhp4q4Qx+kfoaUr0+bkOD4/j+p7LLykAi2yXcj7OA8LpBAyAU?=
 =?us-ascii?Q?bONHGw=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW3PR11MB4651.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1cd63328-d18c-4322-0731-08d9eed81c7f
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Feb 2022 10:03:40.3214
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: cKeqWs7vi9bXU3jHvbKs6CpbWnyJ1JQv1YIgApTn4b/CqadEhghhBqdNY2El5yK+uK+KbhFzbjhTSG0s6zNmJRPT/OuKelOj4jyrEHVn7wc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR11MB3198
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> -----Original Message-----
> From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Sent: Sunday, February 13, 2022 11:56
> To: Usyskin, Alexander <alexander.usyskin@intel.com>
> Cc: Jani Nikula <jani.nikula@linux.intel.com>; Joonas Lahtinen
> <joonas.lahtinen@linux.intel.com>; Vivi, Rodrigo <rodrigo.vivi@intel.com>=
;
> David Airlie <airlied@linux.ie>; Daniel Vetter <daniel@ffwll.ch>; Winkler=
,
> Tomas <tomas.winkler@intel.com>; Lubart, Vitaly <vitaly.lubart@intel.com>=
;
> intel-gfx@lists.freedesktop.org; linux-kernel@vger.kernel.org
> Subject: Re: [PATCH v6 0/5] Add driver for GSC controller
>=20
> On Sun, Feb 13, 2022 at 11:14:53AM +0200, Alexander Usyskin wrote:
> > GSC is a graphics system controller, it provides
> > a chassis controller for graphics discrete cards.
> >
> > There are two MEI interfaces in GSC: HECI1 and HECI2.
> >
> > This series includes instantiation of the auxiliary devices for HECI2
> > and mei-gsc auxiliary device driver that binds to the auxiliary device.
> >
> > In v2 the platform device was replaced by the auxiliary device.
> > v3 is the rebase over drm-tip to make public CI running.
> > In v4 the not needed debug prints and empty line were removed,
> >       'select' were replaced by 'depends on' in MEI Kconfig,
> >       the new include file now listed in the MAINTATINERS file.
> > V5, rebase and add Greg KH Reviewed-by
> > V6, rebase and drop redundant assignments found by the kernel test
> robot.
> >
> > Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
>=20
> This line needs to be added to the individual patches if you want any
> tool or maintainer to pick that up.
>=20

Thanks for a tip, will send with your review added to the individual patche=
s.

> thanks,
>=20
> greg k-h
