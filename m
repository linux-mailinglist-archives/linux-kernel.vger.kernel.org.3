Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CA2C151D0B0
	for <lists+linux-kernel@lfdr.de>; Fri,  6 May 2022 07:29:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378627AbiEFFc2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 May 2022 01:32:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350145AbiEFFcV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 May 2022 01:32:21 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE27BB853;
        Thu,  5 May 2022 22:28:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1651814919; x=1683350919;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=zcVVhGfwMXAjEirGvjMq6oGZglYXcAZuT+qzDK9sNDA=;
  b=jC+TIJoC8VV6ISkCyCeDkdlMaoKdQSZGWwtBq7lTMgus3yplaHmbn2rt
   4qVV1cqdcPEAQmKWVPme2jdeoq9tBz19hYD+WsxK0ZJtngooTqGdBwZaU
   L/Pq9h94JnxpYclfk195YDPbmLztA+TbMtxf8fvbRHQyOOR17PxWElqcB
   7KblbqR1ERR9zFFmf/lTduEdPxVy1BO8XUVAxMDez3Sn9OrxI5q515Cbq
   ZSYheOaxvcHZtR1/lPvcINmpsvE+xY4dfmOJUzN3OwVJtm3a1+2C+pkJG
   YZOy4uvKYvyfiY913a0LlkYM2qcpd+k0VGZmtbKe2i/yIPvlbiJRslQ/5
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10338"; a="268253679"
X-IronPort-AV: E=Sophos;i="5.91,203,1647327600"; 
   d="scan'208";a="268253679"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 May 2022 22:28:39 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,203,1647327600"; 
   d="scan'208";a="585780728"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by orsmga008.jf.intel.com with ESMTP; 05 May 2022 22:28:38 -0700
Received: from orsmsx608.amr.corp.intel.com (10.22.229.21) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27; Thu, 5 May 2022 22:28:37 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx608.amr.corp.intel.com (10.22.229.21) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27 via Frontend Transport; Thu, 5 May 2022 22:28:37 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.176)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.27; Thu, 5 May 2022 22:28:37 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jvvNdliiufGHa4NlXq7EuBbphMgcXi8c91zNH9pAUnqaNLIq/7RjUkhTBF2qanTkdvcVkuG+9WQJ3c2HPMM/HRRCgO5LCtvlqAiesLR7c8L6AdJ96v17DhErADK5UL6bl8P7eBd/xqRSxzuWDhRhZYKTzrFZEmBdlBDSGBkh9uRFOvkMYvgBMEIRvXRCZvIWvtlVpH7C2OJnDsFONrPoyrtm3KScwBxwVSQIh2XBQsKzsTN/OQY9Wf9Bdk6YBpEc+G/ccOExs1ly2TibQGfyyN928KKRL6My7QE2WpTMvjqjboA0DouP0amUyEO6WPuRYtRrqgR71qPCPbIljv1A/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9fcaAplNtS8mwXtRlg6LEP3oR6sH1lSNH8p0RJZb+mk=;
 b=m3YddiRm2C0gxphuKRbEila3/GDAWOwSKJ871P3P5PR31HGPPoNQXsq2g6CB8zTv0y9AAg93LZgjcemEk3jqeDuLSpzKv1jpZYheoOFOIb8uvbj7xVhLr0Ntm/NqOzWZ9d+vtttlr53X4anbu9gujZAAK142oUpBdGc97Rax1cmxSbmYYYm17mcjqJwJISf0N0VAFOpdNLabxavFwKuYcaE0ymlKoD3WFUW15UKU14g26xhm0fxiXFXCgUkc+RN5uwz+QgCQ+x0T859o4bWFlrkVsADhBP80u8lqrwfQB3OE15y9zcf5h78L7bBpOW9+jmHrrKA01n/gCm/4WE0gbw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SA2PR11MB5115.namprd11.prod.outlook.com (2603:10b6:806:118::22)
 by SJ0PR11MB5118.namprd11.prod.outlook.com (2603:10b6:a03:2dd::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5206.24; Fri, 6 May
 2022 05:28:36 +0000
Received: from SA2PR11MB5115.namprd11.prod.outlook.com
 ([fe80::9489:e53a:f37e:e0be]) by SA2PR11MB5115.namprd11.prod.outlook.com
 ([fe80::9489:e53a:f37e:e0be%7]) with mapi id 15.20.5206.027; Fri, 6 May 2022
 05:28:36 +0000
From:   "R, Monish Kumar" <monish.kumar.r@intel.com>
To:     Greg KH <gregkh@linuxfoundation.org>
CC:     "olebowle@gmx.com" <olebowle@gmx.com>,
        "oneukum@suse.com" <oneukum@suse.com>,
        "vpalatin@chromium.org" <vpalatin@chromium.org>,
        "wangjm221@gmail.com" <wangjm221@gmail.com>,
        "chris.chiu@canonical.com" <chris.chiu@canonical.com>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Rao, Abhijeet" <abhijeet.rao@intel.com>
Subject: RE: [PATCH] Add USB_QUIRK_NO_LPM USB_QUIRK_RESET_RESUME quirks for
 Dell usb gen 2 device to not fail during enumeration.
Thread-Topic: [PATCH] Add USB_QUIRK_NO_LPM USB_QUIRK_RESET_RESUME quirks for
 Dell usb gen 2 device to not fail during enumeration.
Thread-Index: AQHYYGiY+IIOJ+L3hkCnjjBIIxNTcq0QM0SAgAEeO3A=
Date:   Fri, 6 May 2022 05:28:36 +0000
Message-ID: <SA2PR11MB51157FBE0367288DEBC4396BC3C59@SA2PR11MB5115.namprd11.prod.outlook.com>
References: <20220505101459.7804-1-monish.kumar.r@intel.com>
 <YnPARed/HKdnwPKV@kroah.com>
In-Reply-To: <YnPARed/HKdnwPKV@kroah.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-product: dlpe-windows
dlp-version: 11.6.401.20
dlp-reaction: no-action
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 24952c9f-84fb-4afa-8ee4-08da2f2144dd
x-ms-traffictypediagnostic: SJ0PR11MB5118:EE_
x-microsoft-antispam-prvs: <SJ0PR11MB51186890A60322C3CCB7DCF3C3C59@SJ0PR11MB5118.namprd11.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: QJQuN5Ork1PdaQv5JXakbqw/WsHMPB5Qw0etOPSf/suazlfkAWNLjDrnT65ajkOabCtlsPRWPOMSrVeio32Sm8nU0XyZ1ut3ztQIluclvkUFyVQWhZV2PFBXSFR9hLgrNsNRRcWdoN60EY1mCe3kwLbUMLiAuqU2X5qutPr5uY8zCADQppffddzuPSyHsGWe6e+sGnGNBgWhaa+iqlOHY/EahwQz42YM7GlMMjDEMpQzOY0Ea42IfV89qOxNv5KnZ4baHb1TTYxA4Bnyo23NUtnKOIVmw7xiqhTztGv5ge5FLCLIPJZXm97/rJsLFARQR+dPE6WefiTpUT5blzhq24H+ivrVaPOKUnlrOY03Ms6UMPPKarLlPiEtASXjKOdIfwFxDYwEMxgUIINbXFuoPpO86USHVg2ruVtObZ+sMQ5RX29DWpQ72hhQuZ1bYpXmDu+Yd+5z7dtjLI8xw/KL7DPNmgLLB79JplqYUZ0DGsNtOsRUC49hqSwJgAAqsu+7T/9dV7p+tD2oej8M7wS702b4Q01LPcxkdN8B1XRnQs//VPv+KjnPkHvPXunMxN+HFDZAsPq3zHpi8uPhjjqncF3hB9LDolWc3TUCGeGq7FrkxCDrGg2t/ugeNUtG/gjtyJahg4B3XKQGJAS9dlPfcSoRup0qhY2NKT6QodFEO7DetS+gJLDAUDx+o6osmYbC9BIJjOTw7smnZbCV7xbWKeqmsReiopd3gVRaLJi8aPI=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA2PR11MB5115.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(508600001)(33656002)(71200400001)(55016003)(82960400001)(122000001)(38100700002)(38070700005)(54906003)(6916009)(316002)(76116006)(66556008)(26005)(5660300002)(8676002)(64756008)(4326008)(2906002)(9686003)(66446008)(86362001)(66946007)(66476007)(7696005)(186003)(53546011)(6506007)(52536014)(107886003)(8936002)(83380400001)(518174003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?3As5SN310rYbOuxpcgjbfSeLLryMdGdoLEQBWuhTy8LTk4NJABlpt3Xe/ERM?=
 =?us-ascii?Q?K6efK6c4PiAatDNJXCopBAurYe3tJcX5unBOQoIqruiaGgrAkOczR2Z8WkCs?=
 =?us-ascii?Q?RHCUiByOv5fmdBndqKA+wXxX/o59UN4SWxPnUbXKhsNzND8DK5FZJVcauayj?=
 =?us-ascii?Q?dPheNv73I79Cs6sMCFf9ZdNTr8okCd4r7F9Qb3YfNFDKd6TpYT8ZvG+a0dfW?=
 =?us-ascii?Q?SFaEGyx8LDg1iUGi0xNuvwvJ0WENCJvGMs4y4jHvmiBScHgkXuC0FQWdnV2j?=
 =?us-ascii?Q?mYWXjSwqrgQkqP/KutoD/kigRUT0aKOH98BsAHnfVEvQLjdHFUcuQebK7owF?=
 =?us-ascii?Q?SDR6d5yjidHb4d9YA1WE0bjrwQKYgKHflutzDUKdXTPXL4IQ8Q6oZlO84oyq?=
 =?us-ascii?Q?2ODAuHI+3If1r4VML1QGFD6cWlkT2qjMmY1Xa77yKmnsR5bBA0MYvqitlFYc?=
 =?us-ascii?Q?NKpa3/sbMg6xHDhtCkR40OBbSLp4q2dc9gWso+aXW/fOeuPGDIUBKCnx++hx?=
 =?us-ascii?Q?lqoQBX7+ngTGY/+NwpfU+xWc6TeC6naGxYwNAMrnfvkhQ/GdmuxALQV9YswD?=
 =?us-ascii?Q?LG3bFCFZgD6haLt/TWmKk2Q7BVK66O0AlX0QoWUabaahSD33dIWRYYzKrMXb?=
 =?us-ascii?Q?7aslgv7VmiLaRqwRg3nKk9D/4k1BxDd4SD8ZMQsZdxtcwM06b7ena025VbMZ?=
 =?us-ascii?Q?1lhMzB5oyGKHq2E8we4MN0+lkP+8wg7/Wcr4ttyMhkA237nlWsZ54R9B2hPC?=
 =?us-ascii?Q?4Y+3RDRrimxc+g0xBmED4mtBMrL/jUm10GKb3fsioo6ZXjmJ9JCNPug+z/on?=
 =?us-ascii?Q?/d6/6tdaA+XT+ZSjjfoDHuySYXDQw/SxnH888WQrqN5+DWfdW51C6LTf/hMc?=
 =?us-ascii?Q?5B9ihOH8uGRVJKYJfWiBDxMxpHsH9FnwquHjwIkBwsep/Ym47ACiS38hjFLs?=
 =?us-ascii?Q?AWpsQS5weK+FLAVOuKbzB9DjHzka05zJ6MaGwsUokheWBd1/n4/YhSeaTHO+?=
 =?us-ascii?Q?jjIxNZbouxrXRO0HEBhizE35KpA0qhTZCNU1nKFExtwkatZ3ao2V73QYFsEq?=
 =?us-ascii?Q?Qxz4ou6bcLwd+3xQuIplbKqFVFztu2Y7bHIaKauV/4l0AdZ4BQfhtV1o082n?=
 =?us-ascii?Q?skSLlJtqGUlVQf1XDyOgewIs3j8QOxAh2/FvDAU8T1aRRg0Xj5h/araLhCmJ?=
 =?us-ascii?Q?CxSmbUy16pn6Oip9xNIVlaPUYSan5O+a2EqGTBOfaUsQOlogi8juD/4kPO1A?=
 =?us-ascii?Q?DH1Yxh5WmSlU3IADHftZpDdcLhNnEhKc3hpouAKwmc49UHz/YnK/5wxW/7tg?=
 =?us-ascii?Q?EYa056BcsgzJERTOIKCSMrxDhxpeFY7gL7CMzqbW7GaTruAb/hWOoBSJw6hl?=
 =?us-ascii?Q?6MHawqbUBdSkYl0ck2BOz04bLcuyOdkdKpiKWOxq4RQNA2PtlWr024dmAh7Y?=
 =?us-ascii?Q?uClFhMy/7H49Vr/+s0scAiV3KN/CUZc3EC1m+m6m9m6Djv9UYNZhMYr1Xiys?=
 =?us-ascii?Q?I0xhskoQZuv8kk5644I4Fcmo74h1Hk2evSx4848Jo9ybJs4Oh39wlAc1hxJW?=
 =?us-ascii?Q?FWHNZjium+pdjOXfCgdSXquxoSjoqCEFoNWYWfHYOrHthr0wKxNjiRCEiJPK?=
 =?us-ascii?Q?EsSYAW73QRmNw25huaaNmyzqrR+T0MPdQvvhI80hS/AbfkASpAxzN5he1cJO?=
 =?us-ascii?Q?o57c3lhROFhZCIMRTKjyAzVkpHNwF3XjPB8e+L8ynKm+XaGULvwNymEw6MmZ?=
 =?us-ascii?Q?O7E92dFMlg=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA2PR11MB5115.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 24952c9f-84fb-4afa-8ee4-08da2f2144dd
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 May 2022 05:28:36.1674
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: zeiKUFgHKxJSz6qek+q6/IF45Ba2EiADNHmUrOfu/F5R1r+ZxpOCIflniPMMEVYC/gXkx0UqeYCbz4blOJ4wZn8tZwzad+jfsqm1vsotk4Q=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB5118
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi greg,

Are you sure you need both?  How was this tested that both are actually set=
?

>>  Yes, both NO_LPM and RESET_RESUME quirks were needed.
As the Dell usb gen2 device U1/U2 link states were failing when connected t=
o type-C ports.
Disabling LPM helps to resolve U1/U2 link state failures. However, it leads=
 to resetting the device multiple times. So, added with NO_LPM and RESET_RE=
SUME usb quirks.

Tested multiple hotplug of Dell usb gen 2 device, it passed for all the cas=
es.

Regards,
Monish Kumar R

-----Original Message-----
From: Greg KH <gregkh@linuxfoundation.org>=20
Sent: 05 May 2022 17:47
To: R, Monish Kumar <monish.kumar.r@intel.com>
Cc: olebowle@gmx.com; oneukum@suse.com; vpalatin@chromium.org; wangjm221@gm=
ail.com; chris.chiu@canonical.com; linux-usb@vger.kernel.org; linux-kernel@=
vger.kernel.org; Rao, Abhijeet <abhijeet.rao@intel.com>
Subject: Re: [PATCH] Add USB_QUIRK_NO_LPM USB_QUIRK_RESET_RESUME quirks for=
 Dell usb gen 2 device to not fail during enumeration.

On Thu, May 05, 2022 at 03:44:59PM +0530, monish.kumar.r@intel.com wrote:
> From: Monish Kumar R <monish.kumar.r@intel.com>
>=20
> Signed-off-by: Monish Kumar R <monish.kumar.r@intel.com>
> ---
>  drivers/usb/core/quirks.c | 4 ++++
>  1 file changed, 4 insertions(+)
>=20
> diff --git a/drivers/usb/core/quirks.c b/drivers/usb/core/quirks.c=20
> index 97b44a68668a..257ac37464e8 100644
> --- a/drivers/usb/core/quirks.c
> +++ b/drivers/usb/core/quirks.c
> @@ -515,6 +515,10 @@ static const struct usb_device_id=20
> usb_quirk_list[] =3D {
> =20
>  	/* INTEL VALUE SSD */
>  	{ USB_DEVICE(0x8086, 0xf1a5), .driver_info =3D USB_QUIRK_RESET_RESUME=20
> },
>        =20
> +	/*DELL USB GEN2 */
> +	{ USB_DEVICE(0x413c, 0xb062), .driver_info =3D USB_QUIRK_NO_LPM },
> +	{ USB_DEVICE(0x413c, 0xb062), .driver_info =3D USB_QUIRK_RESET_RESUME=20
> +},

Are you sure you need both?  How was this tested that both are actually set=
?

thanks,

greg k-h
