Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EBA345104C1
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Apr 2022 18:58:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353565AbiDZRBq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Apr 2022 13:01:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235356AbiDZRBo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Apr 2022 13:01:44 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8CF7B6EB2A
        for <linux-kernel@vger.kernel.org>; Tue, 26 Apr 2022 09:58:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1650992316; x=1682528316;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=K6gcVBmBneg8NSxV/fRjuSYDJXi/vlUgUYaDXnC6fFY=;
  b=MslZhryFy6c24cqGogj/q8lyLQVVsYr/7bg9gmv4qt5jxsJF3jBNt4Wb
   8+Y2qBeK/+lLvgHNLTa/79iJLNJFrc9cP4GJe5dt78Gk77NAkOD2NWAdG
   NOdaQJdcVKBccB3u0B5aK6ykmI9KTH5tnjA1/+WSrVj3YG7xuKCgpz7m8
   viu6OgItYujdmPDOJ+WruJzcN3nW78wanV0/jHVTOz0mkB2TkgkCM9JOz
   4YH6QE2TJ3vXe5QxvT/HnLgyPb/lQBinICIrS6VacwZJ+LgpoHPYuQAzR
   T9vF9t/IUko9D+2KnWWrX8ooPcMeb+AZMVaMASJrphLKTByPaHvzHOsfi
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10329"; a="265817138"
X-IronPort-AV: E=Sophos;i="5.90,291,1643702400"; 
   d="scan'208";a="265817138"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Apr 2022 09:58:36 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,291,1643702400"; 
   d="scan'208";a="705146078"
Received: from fmsmsx604.amr.corp.intel.com ([10.18.126.84])
  by fmsmga001.fm.intel.com with ESMTP; 26 Apr 2022 09:58:36 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx604.amr.corp.intel.com (10.18.126.84) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27; Tue, 26 Apr 2022 09:58:35 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27 via Frontend Transport; Tue, 26 Apr 2022 09:58:35 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.103)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.27; Tue, 26 Apr 2022 09:58:35 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SqRdFW+BUVdLgoqRiJ055groGi4FSeG+HdSPPLpuWX6rMKFR8TcSLD565VdkYH3VvHn3W2bYC3Azj3HXtgMJ3z4rkeAYkEuEfzECMeC0TU6U4R4/0ywb0880B0Y2zQKVnEPws491fzTWOxTfRwcq2RBgxNgTFg4ti9iSlLvTpyRorf5Rfy82hmgHDJW+pKZkSKjzazPCyN0ypshldqRszXKn0DvZ6tEzYKrAMi0ClM2hsOWobPq+58wn/MmODl5s17OcwFGKau1KIW9YVYx9tXAaC05Udafok0NipUwakrZZZED30Rh1KNeZYK3/jISE7lmdCugheL+vqAvnfUXJGA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VspCXDkpEb6WXPRlTu25vP5mk/pmOgZyR0UmcAeDa3k=;
 b=PobWT/RvNdDsQtIkBs5DxqNQqEt2xZmqEqv4I8fNYA5kjqwLVX2QbJPFWjQmRzHQ0iV93PL2S+AG8gFvdX8F8vwo7jb2RDUJkIF0D/9B3nrthSA+meJEWpk9VzR7+CC3BFgdYK7zEkGbUMGH9I5Jq2L2mlDKkmiGce4Qb7PAk4qwhS65toi9Y8m/1nwXKuApa+szvqZs1tXPKx5gfOjNpjitaFv0NNdMCVR6I7d8C9Q5Pnqb6un8s8xGhGtb2ZaAkSx2ghtjKIOWaf8Lch8YdMmJkeg+ymrSxpf6AMREsr/l49hZt0oWu6qhlxLRgQO/JfecvudngiqmuI9Tozblcg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DM4PR11MB5549.namprd11.prod.outlook.com (2603:10b6:5:388::7) by
 BN6PR11MB4163.namprd11.prod.outlook.com (2603:10b6:405:7f::37) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5186.18; Tue, 26 Apr 2022 16:58:33 +0000
Received: from DM4PR11MB5549.namprd11.prod.outlook.com
 ([fe80::e5b8:93eb:e06b:f1ab]) by DM4PR11MB5549.namprd11.prod.outlook.com
 ([fe80::e5b8:93eb:e06b:f1ab%7]) with mapi id 15.20.5186.021; Tue, 26 Apr 2022
 16:58:33 +0000
From:   "Wang, Zhi A" <zhi.a.wang@intel.com>
To:     Jason Gunthorpe <jgg@nvidia.com>
CC:     Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "intel-gfx@lists.freedesktop.org" <intel-gfx@lists.freedesktop.org>,
        "Joonas Lahtinen" <joonas.lahtinen@linux.intel.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Alex Williamson <alex.williamson@redhat.com>,
        Zhenyu Wang <zhenyuw@linux.intel.com>,
        "Vivi, Rodrigo" <rodrigo.vivi@intel.com>,
        "intel-gvt-dev@lists.freedesktop.org" 
        <intel-gvt-dev@lists.freedesktop.org>,
        Christoph Hellwig <hch@lst.de>
Subject: Re: [PULL] gvt-next
Thread-Topic: [PULL] gvt-next
Thread-Index: AQHYWUN8Agog0QB2HUW+VGhdlmLDqK0CWPcAgAASO4A=
Date:   Tue, 26 Apr 2022 16:58:33 +0000
Message-ID: <e245c195-fdb0-32c4-dcfb-8ff49bc3a63c@intel.com>
References: <c5cf6773-e7a2-8ba8-4cde-0bb14007bc6b@intel.com>
 <20220426155318.GQ2125828@nvidia.com>
In-Reply-To: <20220426155318.GQ2125828@nvidia.com>
Accept-Language: en-FI, en-US
Content-Language: aa
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: f15fa20d-c882-4e4d-de8c-08da27a5ff9f
x-ms-traffictypediagnostic: BN6PR11MB4163:EE_
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-microsoft-antispam-prvs: <BN6PR11MB416345585BF038487F5B128ACAFB9@BN6PR11MB4163.namprd11.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 1Y5lvjrjsFoEqunJPJ1TVD/KZsl2h9y+5k6k0C0plJmcUoXvUMwXBaHKh1HSCqiMkcD/5oRArqtdZcI3odwnnmQOzMBCZZ+MJ9M+aVWm6gMUG4rbhMZHrA+yJMEM3fqOqIDHe33Roe609+jRfW0Mt5HtDZxfkgEShJAhr0RtFg/oy+PNXLWlpn8xjCKAoRvmRyU/VbE0OopjjYoWFGRlsMQSdLTe9sTN/cUJPuGMfOZhVzinblDz5V5N9eKKXOilWxWH1h7/oZCyq13k08C69zMXQW4Rvn8arDVWiRdYT2Jcg4JlIX/RM2AoPuBjA5DJ+OXEdnWns7oo9f5ECH6vLsIfOI7r7Ll6eon3z6gOiNmRiv/Ana336HWbJcHmtY9BShCDIPN8+PvFRuFXDrMMT11tfUnVkB5Oqb3zaPVrGL2YQh/SMmCEcdBXoh5Lwyt22WYithLqcPO+FGkfQ6OFSRcSZo+S5/l9ZXOAuPb2dLUz0tYqd46xZ1Dtaqix+QJNlxUa4eIzC/jUWczcwRNhvQ5yPlMMNTi2le9Kcwx3W2zlR18WrkfoUKUxli8d8VFtcgQ44M5OlMF+noKkYnDmqo1kjHh4y+D515x3PVgge18VROoYZqK9d9j7MSMim8ROPciJECoSweB4ISah/M0Mj0cgfmVNqPNO47BVz+oPo42yRpCRYfKfTXasNhzeUltEZ0bF0NJNtzsV46srWvUcYgAb/Z7Iscp8ISxXb4BCbozBFGYUDCivy6byJAASEPUrfNxNoGbKlHeiWRtoAQEIAVnfJg6dpvxS/S59QSylmHkYG3Amo+kZ9Nu9e+5ZSMacdi1zSNRJSCgYTyOXfcAJ8neenfKIywjX6pn9pK4wadw=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR11MB5549.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(6916009)(26005)(186003)(54906003)(8936002)(316002)(6486002)(508600001)(36756003)(966005)(71200400001)(31686004)(66946007)(66446008)(64756008)(66556008)(8676002)(4326008)(66476007)(6512007)(38100700002)(5660300002)(7416002)(2616005)(31696002)(86362001)(53546011)(6506007)(91956017)(76116006)(2906002)(122000001)(38070700005)(82960400001)(45980500001)(43740500002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?Windows-1252?Q?+U5gBwLHte85IIgQdeX15afOnjFf63e2WZXgyx/5sdhmMp76K1rHDKM3?=
 =?Windows-1252?Q?GqUPeF3g0k+eBqQE+WrO48qqw9lNYyReIoDPVuz0Pfj5elSRq8Sy0HKX?=
 =?Windows-1252?Q?oMmcwZa4QJqGgwk04SbyP6TqXM4TOban6bXQKOwnuujjsCGOgZCnpAKi?=
 =?Windows-1252?Q?yrSHFaLTO+IoMo4KyjClN1XRPXl/Ut3EVkY/dmXOPz9cIngMk6Jm98dw?=
 =?Windows-1252?Q?bQ1d7MKOvO8wilVgL69RUmKYtLZYcRSRcWsOX1iv3S1vfhoHpzBHG3bD?=
 =?Windows-1252?Q?gJaL2fXvq8tUdf3jwafFzzm8SUBk3jBTq+wa3IzJmG0EriV8xCUmQf2L?=
 =?Windows-1252?Q?ncN55A2sJEE2Z2y87cdacmrsHaPwPgN8sz0jQDV5Fli4HnAmxzfifot4?=
 =?Windows-1252?Q?bzy8hIfZuNeB3EgTGe6fiMvQ1VnpvTN47ekV76Ww3asEk97KQ/KqqAQB?=
 =?Windows-1252?Q?bYEjsQe383lBVZIIDQn7H6Nh2GytAAbgXaZ6U296xmBHgK6xQ1TfmkuG?=
 =?Windows-1252?Q?KuctxFRBb4Ccb68VNlTOSLUWeNn69LgcjWgBgzNsnGCrMnMLB6IGyaU2?=
 =?Windows-1252?Q?yjl86fTh6a9PB/gOupcABiu8Yj2ZucRyBpZtmgFvJaJH/v2CnKzFJ6oD?=
 =?Windows-1252?Q?ej8Bc+ujtEhsLeK10hAnaM38oWwbv4Vb8M2aDD2jyawSXVyC6mDGBaGm?=
 =?Windows-1252?Q?SjiLJtGBZqrZwfomUdm0rTLamlkJqhm8VP+af6sJAaP4yGMTrUAtpM6n?=
 =?Windows-1252?Q?2zqd1X4eAqx70VTmKFU/9rpsfgBmozzaIQXGon4qa5Y2LqLoyoC6ynpP?=
 =?Windows-1252?Q?QQwE+NAkcCGL0l9QiPBuKWu8zqLu1jX1mHeKy2TqgAETFtrLVWA268eY?=
 =?Windows-1252?Q?Xgp9yqk+WHaXehfUuHL5d2he+Osnj7Wr+SrSUUqayaX92GpiYYK+EWsv?=
 =?Windows-1252?Q?PLLyTSwUZNDwiLjpJD488WF6IxyWqm0yc55dqXnCgrJbrOOGmUX0ww3J?=
 =?Windows-1252?Q?kta2AuDYluAV10SClYjZe3UGsbjKUnMjlpTd+PSNE2ZpIvJelVehYL25?=
 =?Windows-1252?Q?FOtqxUk0ceqfxz78rcVytiqbUtmdEyfxzsy+N4Aq6uUmB4KIHr2RXb85?=
 =?Windows-1252?Q?oFHJZ/seeAwpsUi9RD7FZH9/QNjuuQDCPnRvu2Ci7XY7GN5LELPfvVQ2?=
 =?Windows-1252?Q?3lFwNy7I6iqNHQ180nGJanvKkwKcJ6NvPrax2dX26cMqjnq3vDGiSRoe?=
 =?Windows-1252?Q?DuynkmyoQ8XpdlEfeTvAZRySlZ7jiLfxldkeWv0urtgd6fn2QolY3nqi?=
 =?Windows-1252?Q?v1uRcx06rcHBwAjA5Tg7vwke9DHj8oqgWvELgygDaOvs2rR9PW7tIZ8F?=
 =?Windows-1252?Q?7kWo3GpIeCf3H7oM/f92lONRd3O552QsFvO5NXcDQuf7F4SrpPbN0qwu?=
 =?Windows-1252?Q?VMEWNKznR7T56OMdEOuD7NTHQuzCrVZ+mqeOtgGPnCSx9obnlVTn5M0R?=
 =?Windows-1252?Q?t32Rwctp4Yj2AOFEUyBXR+m59tTm1WY3AwPuyYCjfFr09G6npQkvINMC?=
 =?Windows-1252?Q?B9cwWMuMBOOtp8Jkt4EalnSLPoqQQEevzfoSUjvkzYUc3VKDQmDLpheO?=
 =?Windows-1252?Q?wsNHfFmul0sEH93aIuYB9Tu1YU6tDYG5YZ2yrj8naqYN4yjOnd6BI29I?=
 =?Windows-1252?Q?bw6eLoL3SZF1X6n2AVzVmXO6Q75/I5ZHpHK2D9MPqlL0zAYsOOmlBE04?=
 =?Windows-1252?Q?ff6+gcWOgRnfBJYVnKFg56AhgjsZKDGzGwaaKcegoA5lAgsuKSx1vRL5?=
 =?Windows-1252?Q?7fB49612Ues7K8dwD4dAltbMbRBln543FJUhvfWxbPcZZ8XXtxqWEYa/?=
 =?Windows-1252?Q?/v8Cwxb3jWO20w=3D=3D?=
Content-Type: text/plain; charset="Windows-1252"
Content-ID: <D98443480C310A49ACE03F3D5528AF2A@namprd11.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB5549.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f15fa20d-c882-4e4d-de8c-08da27a5ff9f
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Apr 2022 16:58:33.7944
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Vr7MHfqvhCmiPHJFMQI8TlJoJ19ypCxU0RSip8SAm9vgB+RzVcJhhUBl3QpuSuKtePPKK97R2B/FWdC6CBcyDQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR11MB4163
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-9.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/26/22 3:53 PM, Jason Gunthorpe wrote:
> On Tue, Apr 26, 2022 at 07:58:59AM +0000, Wang, Zhi A wrote:
>> Hi folks:
>>
>> Here is the pull of gvt-next which fixs the compilation error when i915 =
debug
>> is open after the GVT-g refactor patches.
>>
>> Thanks so much for the efforts.
>>
>> Thanks,
>> Zhi.
>>
>> The following changes since commit 2917f53113be3b7a0f374e02cebe6d6b74936=
6b5:
>>
>>   vfio/mdev: Remove mdev drvdata (2022-04-21 07:36:56 -0400)
>>
>> are available in the Git repository at:
>>
>>   https://github.com/intel/gvt-linux tags/gvt-next-2022-04-26
>>
>> for you to fetch changes up to 2da299cee780ea797b3f72558687868072cf5eb5:
>>
>>   drm/i915/gvt: Add missing export of symbols. (2022-04-25 18:03:04 -040=
0)
>>
>> gvt-next-2022-04-26
>>
>> - Add two missing exports of symbols when i915 debug is enabled.
>>
>> Zhi Wang (1):
>>       drm/i915/gvt: Add missing export of symbols.
>>
>>  drivers/gpu/drm/i915/intel_gvt.c | 2 ++
>>  1 file changed, 2 insertions(+)
>=20
> This still has another compile problem:
>=20
> ERROR: modpost: "intel_runtime_pm_put" [vmlinux] is a static EXPORT_SYMBO=
L_GPL
>=20
> Because:
>=20
> #if IS_ENABLED(CONFIG_DRM_I915_DEBUG_RUNTIME_PM)
> void intel_runtime_pm_put(struct intel_runtime_pm *rpm, intel_wakeref_t w=
ref);
> #else
> static inline void
> intel_runtime_pm_put(struct intel_runtime_pm *rpm, intel_wakeref_t wref)
> {
>         intel_runtime_pm_put_unchecked(rpm);
> }
> #endif
>=20
> Looks like it happens if CONFIG_DRM_I915_DEBUG_RUNTIME_PM=3Dn
>=20
> I think you probably want to #ifdef the export in the same way:
>=20
> --- a/drivers/gpu/drm/i915/intel_gvt.c
> +++ b/drivers/gpu/drm/i915/intel_gvt.c
> @@ -309,7 +309,9 @@ EXPORT_SYMBOL_NS_GPL(__intel_context_do_pin, I915_GVT=
);
>  EXPORT_SYMBOL_NS_GPL(__intel_context_do_unpin, I915_GVT);
>  EXPORT_SYMBOL_NS_GPL(intel_ring_begin, I915_GVT);
>  EXPORT_SYMBOL_NS_GPL(intel_runtime_pm_get, I915_GVT);
> +#if IS_ENABLED(CONFIG_DRM_I915_DEBUG_RUNTIME_PM)
>  EXPORT_SYMBOL_NS_GPL(intel_runtime_pm_put, I915_GVT);
> +#endif
Sigh. That's tricky. Let me prepare another one.=20
>  EXPORT_SYMBOL_NS_GPL(intel_runtime_pm_put_unchecked, I915_GVT);
>  EXPORT_SYMBOL_NS_GPL(intel_uncore_forcewake_for_reg, I915_GVT);
>  EXPORT_SYMBOL_NS_GPL(intel_uncore_forcewake_get, I915_GVT);
>=20
> Jason
>=20

