Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 964C85887F7
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Aug 2022 09:31:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234103AbiHCHbi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Aug 2022 03:31:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230071AbiHCHbg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Aug 2022 03:31:36 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3484518369;
        Wed,  3 Aug 2022 00:31:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1659511895; x=1691047895;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:mime-version;
  bh=sQtCI6W4JRTeeqVDk7X9bc5ldTtKyAfkR14lLpgJvk0=;
  b=XdEU9WbibrBAbuLQXL4b3aGjnawUALPvb+dpAhLqGUZgjbNO/XQHxJsD
   J1E6qhXKVgcXaKLeC70oWwK1BTEA0upTbfeA5ctYSH4Ndd7NWp/iM/VuF
   UrrATADWSeRl0+Se0oHEJMSukz/aCaRhJBo/WE5S3MzsJgklCxvUtR6rr
   DtRlfufvWKx/TCoqCMnAgy5EXMzniNYsFe9UjodPYFmCKAhKAlXfhwAPQ
   i6ozJtYmxso3z1OLLHACffQ7vjKO05AYrGNLZRjZsS4yqx+zMiQTvqQhL
   wuP6l29qpCniYM+6Kr9szh02qidRsKnAZG08+ICHrPFEF9ziG/Ple51ip
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10427"; a="353612490"
X-IronPort-AV: E=Sophos;i="5.93,213,1654585200"; 
   d="scan'208,223";a="353612490"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Aug 2022 00:31:34 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,213,1654585200"; 
   d="scan'208,223";a="553224343"
Received: from orsmsx605.amr.corp.intel.com ([10.22.229.18])
  by orsmga003.jf.intel.com with ESMTP; 03 Aug 2022 00:31:34 -0700
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX605.amr.corp.intel.com (10.22.229.18) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.28; Wed, 3 Aug 2022 00:31:34 -0700
Received: from orsmsx608.amr.corp.intel.com (10.22.229.21) by
 ORSMSX612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.28; Wed, 3 Aug 2022 00:31:33 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx608.amr.corp.intel.com (10.22.229.21) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.28 via Frontend Transport; Wed, 3 Aug 2022 00:31:33 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.173)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.28; Wed, 3 Aug 2022 00:31:33 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MuURtEZ//yXWZ+xzJQk8Oi1or8gFml8g5hFQ1rf44vN1FQH0hD5o8WZFuPVo/ChiIQCEkBD+hhy4gKo/Ic9cSNstMPUZodIKOFXZ06k7cekIoO19UFEmPGi+iGDNGtKLA6GTTHjBtZyXWXblZL/CplFXZpgZAorVwL3XrUCMEDYhfzM8y86PwZggBrMeJaSASStKwaTUpNvruJ4CWB2v0TWLGQcHixwP78tmpuqddEgqsQsEh/qQQwEgcdgYUY3qk97kR6lIcg02cn9k1IsafB8Iol+9zGhPzDIYAZXlQhaFDH0jVmhdx4NVu4f+zOxiXWCNeP+BJzamCX29SICwww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=D98n4XwKC2gF8VmhVVPSotqZWm4Hgn11WlJMu+CZsGs=;
 b=E7V53jaEjuG3/Qar6yNnTmLP/rlnhM4RJni1zJhRAAbXbQn7hSr10KbkQUk1huIR7OrLJFOKUbSr7AAjytgqn6aX2V9kSFmyw++iHke3zAZM3eRgJfJda/MTlNJIWX8+ZYM0Bs3sd74j7++K9iFyJe0fH/aX+qxyO5SlteoKF1bOstNwVuHd/9FGHVkdy5rjPapRdVfnNQRm+A7SKbd7FaBEqAXaDPS1GYHpSHIL5TQ7eNZo2ZkMhXhhDt8s4ksSaGmtnqzgxK9jr0d2SOtRFt9nD1S1hIFGjVi1ZjDDthNcWgKZnRZtN3cesoX259pHqtuohE1fDIfQ7ociAdGtqw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from CO1PR11MB4835.namprd11.prod.outlook.com (2603:10b6:303:9e::22)
 by DM4PR11MB6191.namprd11.prod.outlook.com (2603:10b6:8:ac::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5504.14; Wed, 3 Aug
 2022 07:31:30 +0000
Received: from CO1PR11MB4835.namprd11.prod.outlook.com
 ([fe80::d9d9:ed53:6b0a:e537]) by CO1PR11MB4835.namprd11.prod.outlook.com
 ([fe80::d9d9:ed53:6b0a:e537%7]) with mapi id 15.20.5504.014; Wed, 3 Aug 2022
 07:31:30 +0000
From:   "Khandelwal, Rajat" <rajat.khandelwal@intel.com>
To:     Mika Westerberg <mika.westerberg@linux.intel.com>,
        "Malani, Prashant" <pmalani@google.com>,
        "bleung@google.com" <bleung@google.com>
CC:     "andreas.noever@gmail.com" <andreas.noever@gmail.com>,
        "Jamet, Michael" <michael.jamet@intel.com>,
        "YehezkelShB@gmail.com" <YehezkelShB@gmail.com>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Rao, Abhijeet" <abhijeet.rao@intel.com>
Subject: RE: [PATCH] thunderbolt: Supporting wake on DP hot events behind
 TBT/USB4 routers
Thread-Topic: [PATCH] thunderbolt: Supporting wake on DP hot events behind
 TBT/USB4 routers
Thread-Index: AdinCrp/wAKoliRWSz2ixLRb9JQnKwAAEDLw
Date:   Wed, 3 Aug 2022 07:31:30 +0000
Message-ID: <CO1PR11MB48354DBE206824F26EB3D830969C9@CO1PR11MB4835.namprd11.prod.outlook.com>
References: <CO1PR11MB48353AD9FD931B1D4AD5646F969C9@CO1PR11MB4835.namprd11.prod.outlook.com>
In-Reply-To: <CO1PR11MB48353AD9FD931B1D4AD5646F969C9@CO1PR11MB4835.namprd11.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-Mentions: pmalani@google.com,bleung@google.com
X-MS-Has-Attach: yes
X-MS-TNEF-Correlator: 
dlp-version: 11.6.500.17
dlp-product: dlpe-windows
dlp-reaction: no-action
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: a1a8b6d7-a24a-4ac3-efcc-08da75222f2d
x-ms-traffictypediagnostic: DM4PR11MB6191:EE_
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 8Oq3mJM1O/XhzrMm4d0J5APenC3K2ucUKesqu/eFLC6bzt7LYEfnLsZabP34Qm77KsAHvYCwei+T3n+zLzPZtN2oThf9/ZVMPVs490IIDjT4LLDZrRvGSfAKWU2SctBRVoWIRe7kv20XxGpV4/49dJgY1M0+43NuecBeWDwta7gNfDsNxnmW1n2ON+qepWVoo/5JGFGprRQqGCVnxaz7XHHTrsBmfX7z+PHeNEZR6uty7FWFS1+YCXmVWybXyCCPmnelvfvEu4ZRQiIia2Cdx0pBRH/boDs1l7oVR/AAlTSX333nIXL5cW4AiCVj5mp+damE/ygXTmRfjb2ENsZMFL5mWdeCo99sUtYHGjjknrHlPb7LNlxuOBu8XjzayzAqFpqUtSUfrefF6GPHUkrE+TkJx/UFgjPl4coIsm1jh6JphHXcn/wuAnWPQ02EAeeTHSLJr76VVQm7116ZIsZcF3vOvkYaGE2Ft9CtR9g8ugDaVpHzP0K6XvI4u4X1/a8Lqgt4f9sH0p2wLUShzinqXi0Dz6OdxYHIUk1gExsAfNKfAOWuK0l9EzuTSa04Xx5oP4zNwUAwF7/Ed6UEtr1gtB7G8H2hGzIpZsZUtB8y5pXOxkCwipYh0HiYzP+5J5guwxc3hfuP0nuqGn1C3KcJV4lgO7vS8RfSNLReTa7XHWYuviiUm7U8Y/6JCD0h6MHrW8/aEHo4+1pHVRxU7Tq2mFtaSgKqHJHPaTBukxdvXj3gHSd5KcGaFXoTGsgnikeq+CtOTEOeQlyz3S+gdBwdM7HtIXsTra6dCws9DD8nSZFCbQt1vkkj/lQjy6vi4lGb
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB4835.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(39860400002)(396003)(346002)(366004)(136003)(376002)(7696005)(122000001)(6506007)(2906002)(33656002)(99936003)(38100700002)(186003)(41300700001)(2940100002)(55016003)(83380400001)(53546011)(9686003)(26005)(54906003)(86362001)(4326008)(66446008)(8676002)(66476007)(76116006)(66556008)(66946007)(316002)(71200400001)(64756008)(110136005)(8936002)(38070700005)(52536014)(82960400001)(478600001)(5660300002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?FXgPOLqBLjeg228U3AwNohUYdAinvE92q/IXfUF4DdR2Y+wZuN/o/r5poDCo?=
 =?us-ascii?Q?c0KrU5SFz0ByiL4yFD06gvQCVHG4rqU8vDYP/mUfIFjVUBnzOedSSRYC2r3v?=
 =?us-ascii?Q?aedYVgbPyAB6Z3RhX9/MDfAFwV6AhEg4L1u3ji5Ify8u6F2OmMyNEtqMU4+V?=
 =?us-ascii?Q?SNbhoxDhiPdb73LXwoiVPLHXo42jEo44qWZE8UuXsE39obCu496dOVM751aO?=
 =?us-ascii?Q?uk1D5YOjWUKHRyA06CGMU4LekFOxAEl5epllQLiB6g5KR7+PazqcIw+gvXR7?=
 =?us-ascii?Q?OjS1e/trp7zX1aIjhrOngI4JbzgpCWDxwqi0ZbDJnzya1b+w9JWCAfJJp6Ic?=
 =?us-ascii?Q?Hz+0yRFTfdwIpyTSvU9AlyvPtGUmSwVOtNAfmgwvA2pZ8f8dj94Gjc+Xy7o7?=
 =?us-ascii?Q?IMPODckD8KJsf/L3IhcJ/b9piXt7UXMe7XUPQts+lBU2Ks8RHExk3a+Oibw2?=
 =?us-ascii?Q?Mp358RXixKjbL4bXTPhqVPCzNV3PQ5FpSXKfYVvQphsLh4AulVZBNv9hzSOV?=
 =?us-ascii?Q?oBK+mvn4IL4O6biqt3lJ2D0wCGo/lKL3ravwf4UWrV2/Wq9AesoV1rEWGNx0?=
 =?us-ascii?Q?OVf3wtX6vsDIqZG1yhW4/OkrIjpeMsTaAXOUGDI6myUSNWAXeB+g4W2PXq5g?=
 =?us-ascii?Q?dmgaFzPk+xFztA3gCN4pb84G0qIimvZVKKVGX91Ts6QAuMSOMDcFcFKYXaFQ?=
 =?us-ascii?Q?j5cLPrl9M+/fjqts1iw17JGTcmKOpUUSZttw5Jz8fxIeKkYgXy/KAduraQCc?=
 =?us-ascii?Q?1kh2TPuLHZ+z0ui7Bd8WgVWAu6KegxtSKxeCf0wdAZm9YrDMG3bzKjMdoDo5?=
 =?us-ascii?Q?C3ttSDhfaX4ikcwZUp9A742hCyLU63ACY/aFng8P47H9RSTKsjquggc9YXZA?=
 =?us-ascii?Q?ieMVcvfErpMjYlI+4W1dTZTVTfVWzgTHc23lO0UppDAk2x4q2nL1LXOPWIo9?=
 =?us-ascii?Q?KM7dZR2YXMpn8m2HdYSbOjexNHyQ06euk0SruE7CC25OlqPDi8axp/S6e4/C?=
 =?us-ascii?Q?RGovF43p0X47dnE1S47jdqCcNT4DWqi/ZE2IjP4xgzaAMsRGe3BaM5Ktbjw4?=
 =?us-ascii?Q?4MEMFYXbArXv0L6XlfukvDaIU9/AfzSbUalKM3kIMs8YUleuxR43QiCaHkTk?=
 =?us-ascii?Q?KHJIupXaN8oifkS+swTsYmipFS0hVFdNGMoLZ/EACgF3gV2q4STndYGSENuJ?=
 =?us-ascii?Q?NyPBXwDBOy/qziGEOi8JPrE478QdwK39U9+TVobiUEpZ/gx8lyQGC1XbmQ2V?=
 =?us-ascii?Q?zkxlg+yq4fMA7dJ5maRthai+36vMKV4/Y3Rl+v3TErAKBlLp+B/yRnMQ82Su?=
 =?us-ascii?Q?G8a0s+xcSmdbPJsoKac7C6ZKMgWfDuWMk2Mf8ZwSDnmYJRKcckLHXE/3nm7m?=
 =?us-ascii?Q?/0EaVhI5XGiUVUmbJ5uYBnGZTyFqOV054qkQ1mVgPUIy3/0l4zc7yVH2SO17?=
 =?us-ascii?Q?sZB/sNDIWTRHf3JWPjgKlvMNzwe/D1CaQBD33f9f0yt6q5kanttePn1KgKWe?=
 =?us-ascii?Q?YaxLWbQEIinNFiAZ4fZoxKO8XxIcOqwK4fhclA+CQ8u0fURdeUylGvepF+w8?=
 =?us-ascii?Q?3tsaIhxP+WKz8oJLwzNM0K5y9dgKmYnoSoNyis4PSZzhcOykXhKapO28+dgA?=
 =?us-ascii?Q?1Q=3D=3D?=
Content-Type: multipart/mixed;
        boundary="_002_CO1PR11MB48354DBE206824F26EB3D830969C9CO1PR11MB4835namp_"
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB4835.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a1a8b6d7-a24a-4ac3-efcc-08da75222f2d
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Aug 2022 07:31:30.6599
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: X8TCN2aBTafXpSqUMVbejf04/+vkB5MSDWuUxjyNAscQ2NRvXRcJ3+Vmk3VAkHV6Za+zIsu3nE+qg9tzSny/6UzAzp+rVEHMM8spNRtB3qc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB6191
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--_002_CO1PR11MB48354DBE206824F26EB3D830969C9CO1PR11MB4835namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable



-----Original Message-----
From: Khandelwal, Rajat=20
Sent: Wednesday, August 3, 2022 1:00 PM
To: Mika Westerberg <mika.westerberg@linux.intel.com>; Malani, Prashant <pm=
alani@google.com>; bleung@google.com
Cc: andreas.noever@gmail.com; Jamet, Michael <michael.jamet@intel.com>; Yeh=
ezkelShB@gmail.com; linux-usb@vger.kernel.org; linux-kernel@vger.kernel.org=
; Rao, Abhijeet <abhijeet.rao@intel.com>
Subject: RE: [PATCH] thunderbolt: Supporting wake on DP hot events behind T=
BT/USB4 routers

+Abhijeet
@Benson Leung @Malani, Prashant Please provide your comments.=20

-----Original Message-----
From: Mika Westerberg <mika.westerberg@linux.intel.com>
Sent: Wednesday, August 3, 2022 11:07 AM
To: Khandelwal, Rajat <rajat.khandelwal@intel.com>
Cc: andreas.noever@gmail.com; Jamet, Michael <michael.jamet@intel.com>; Yeh=
ezkelShB@gmail.com; linux-usb@vger.kernel.org; linux-kernel@vger.kernel.org=
; Malani, Prashant <pmalani@google.com>; bleung@google.com
Subject: Re: [PATCH] thunderbolt: Supporting wake on DP hot events behind T=
BT/USB4 routers

Hi,

On Wed, Aug 03, 2022 at 06:31:39AM +0530, Rajat Khandelwal wrote:
> Current implementation doesn't allow user to go into system suspend=20
> and simultaneously project the screen on an external display connected=20
> to a TBT/USB4 device. This patch enables this feature.
>=20
> Let me know what you think about this.

Please prefix patches to follow the sybsystem style. For Thunderbolt it sho=
uld be "thunderbolt: ....".

This will cause any monitor plug to wake up the system and I'm not sure we =
want that, at least to be default behaviour. If you have a regular Type-C (=
non-USB4/TBT) dock and you plug in a monitor to that, does it wake up?

IIRC I already suggested you to do this for the USB4 ports themselves (stru=
ct usb4_port) so that userspace can make them wake up the system on any eve=
nt by writing "enabled > .../wakeup" which is the normal way.

--_002_CO1PR11MB48354DBE206824F26EB3D830969C9CO1PR11MB4835namp_
Content-Type: application/octet-stream;
	name="0001-Supporting-wake-on-DP-hot-events-behind-TBT-USB4-rou.patch"
Content-Description: 0001-Supporting-wake-on-DP-hot-events-behind-TBT-USB4-rou.patch
Content-Disposition: attachment;
	filename="0001-Supporting-wake-on-DP-hot-events-behind-TBT-USB4-rou.patch";
	size=2629; creation-date="Wed, 03 Aug 2022 07:31:15 GMT";
	modification-date="Wed, 03 Aug 2022 07:31:29 GMT"
Content-Transfer-Encoding: base64

RnJvbSA3NmJhNzZiOTk1OWU4OWNkZmFiMDgyZWY4MDdhNjVjMGI3MDY2ZWQ3IE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBSYWphdCBLaGFuZGVsd2FsIDxyYWphdC5raGFuZGVsd2FsQGlu
dGVsLmNvbT4KRGF0ZTogV2VkLCAzIEF1ZyAyMDIyIDA2OjEwOjI5ICswNTMwClN1YmplY3Q6IFtQ
QVRDSF0gU3VwcG9ydGluZyB3YWtlIG9uIERQIGhvdCBldmVudHMgYmVoaW5kIFRCVC9VU0I0IHJv
dXRlcnMKCkN1cnJlbnQgaW1wbGVtZW50YXRpb24gZG9lc24ndCBhbGxvdyB1c2VyIHRvIGdvIGlu
dG8gc3lzdGVtIHN1c3BlbmQKYW5kIHNpbXVsdGFuZW91c2x5IHByb2plY3QgdGhlIHNjcmVlbiBv
biBhbiBleHRlcm5hbCBkaXNwbGF5IGNvbm5lY3RlZAp0byBhIFRCVC9VU0I0IGRldmljZS4gVGhp
cyBwYXRjaCBlbmFibGVzIHRoaXMgZmVhdHVyZS4KCkxldCBtZSBrbm93IHdoYXQgeW91IHRoaW5r
IGFib3V0IHRoaXMuCgpTaWduZWQtb2ZmLWJ5OiBSYWphdCBLaGFuZGVsd2FsIDxyYWphdC5raGFu
ZGVsd2FsQGludGVsLmNvbT4KLS0tCiBkcml2ZXJzL3RodW5kZXJib2x0L3N3aXRjaC5jICB8IDMg
KystCiBkcml2ZXJzL3RodW5kZXJib2x0L3RiX3JlZ3MuaCB8IDEgKwogZHJpdmVycy90aHVuZGVy
Ym9sdC91c2I0LmMgICAgfCA3ICsrKystLS0KIDMgZmlsZXMgY2hhbmdlZCwgNyBpbnNlcnRpb25z
KCspLCA0IGRlbGV0aW9ucygtKQoKZGlmZiAtLWdpdCBhL2RyaXZlcnMvdGh1bmRlcmJvbHQvc3dp
dGNoLmMgYi9kcml2ZXJzL3RodW5kZXJib2x0L3N3aXRjaC5jCmluZGV4IDU2MWUxZDc3MjQwZS4u
M2E5ZjE3ZmNiZGZlIDEwMDY0NAotLS0gYS9kcml2ZXJzL3RodW5kZXJib2x0L3N3aXRjaC5jCisr
KyBiL2RyaXZlcnMvdGh1bmRlcmJvbHQvc3dpdGNoLmMKQEAgLTMxNTIsNyArMzE1Miw4IEBAIHZv
aWQgdGJfc3dpdGNoX3N1c3BlbmQoc3RydWN0IHRiX3N3aXRjaCAqc3csIGJvb2wgcnVudGltZSkK
IAkJZmxhZ3MgfD0gVEJfV0FLRV9PTl9VU0I0OwogCQlmbGFncyB8PSBUQl9XQUtFX09OX1VTQjMg
fCBUQl9XQUtFX09OX1BDSUUgfCBUQl9XQUtFX09OX0RQOwogCX0gZWxzZSBpZiAoZGV2aWNlX21h
eV93YWtldXAoJnN3LT5kZXYpKSB7Ci0JCWZsYWdzIHw9IFRCX1dBS0VfT05fVVNCNCB8IFRCX1dB
S0VfT05fVVNCMyB8IFRCX1dBS0VfT05fUENJRTsKKwkJZmxhZ3MgfD0gVEJfV0FLRV9PTl9VU0I0
OworCQlmbGFncyB8PSBUQl9XQUtFX09OX1VTQjMgfCBUQl9XQUtFX09OX1BDSUUgfCBUQl9XQUtF
X09OX0RQOwogCX0KIAogCXRiX3N3aXRjaF9zZXRfd2FrZShzdywgZmxhZ3MpOwpkaWZmIC0tZ2l0
IGEvZHJpdmVycy90aHVuZGVyYm9sdC90Yl9yZWdzLmggYi9kcml2ZXJzL3RodW5kZXJib2x0L3Ri
X3JlZ3MuaAppbmRleCA2YTE2ZjYxYTcyYTEuLmYwM2ZhNmYyNmQ1YyAxMDA2NDQKLS0tIGEvZHJp
dmVycy90aHVuZGVyYm9sdC90Yl9yZWdzLmgKKysrIGIvZHJpdmVycy90aHVuZGVyYm9sdC90Yl9y
ZWdzLmgKQEAgLTIwNiw2ICsyMDYsNyBAQCBzdHJ1Y3QgdGJfcmVnc19zd2l0Y2hfaGVhZGVyIHsK
ICNkZWZpbmUgUk9VVEVSX0NTXzZfVE5TCQkJCUJJVCgxKQogI2RlZmluZSBST1VURVJfQ1NfNl9X
T1BTCQkJQklUKDIpCiAjZGVmaW5lIFJPVVRFUl9DU182X1dPVVMJCQlCSVQoMykKKyNkZWZpbmUg
Uk9VVEVSX0NTXzZfV09EUwkJCUJJVCg0KQogI2RlZmluZSBST1VURVJfQ1NfNl9IQ0kJCQkJQklU
KDE4KQogI2RlZmluZSBST1VURVJfQ1NfNl9DUgkJCQlCSVQoMjUpCiAjZGVmaW5lIFJPVVRFUl9D
U183CQkJCTB4MDcKZGlmZiAtLWdpdCBhL2RyaXZlcnMvdGh1bmRlcmJvbHQvdXNiNC5jIGIvZHJp
dmVycy90aHVuZGVyYm9sdC91c2I0LmMKaW5kZXggM2EyZTcxMjZkYjlkLi4yMjczNjdjZTJkMzYg
MTAwNjQ0Ci0tLSBhL2RyaXZlcnMvdGh1bmRlcmJvbHQvdXNiNC5jCisrKyBiL2RyaXZlcnMvdGh1
bmRlcmJvbHQvdXNiNC5jCkBAIC0xNjYsMTEgKzE2NiwxMiBAQCBzdGF0aWMgdm9pZCB1c2I0X3N3
aXRjaF9jaGVja193YWtlcyhzdHJ1Y3QgdGJfc3dpdGNoICpzdykKIAkJaWYgKHRiX3N3X3JlYWQo
c3csICZ2YWwsIFRCX0NGR19TV0lUQ0gsIFJPVVRFUl9DU182LCAxKSkKIAkJCXJldHVybjsKIAot
CQl0Yl9zd19kYmcoc3csICJQQ0llIHdha2U6ICVzLCBVU0IzIHdha2U6ICVzXG4iLAorCQl0Yl9z
d19kYmcoc3csICJQQ0llIHdha2U6ICVzLCBVU0IzIHdha2U6ICVzLCBEUCB3YWtlOiAlc1xuIiwK
IAkJCSAgKHZhbCAmIFJPVVRFUl9DU182X1dPUFMpID8gInllcyIgOiAibm8iLAotCQkJICAodmFs
ICYgUk9VVEVSX0NTXzZfV09VUykgPyAieWVzIiA6ICJubyIpOworCQkJICAodmFsICYgUk9VVEVS
X0NTXzZfV09VUykgPyAieWVzIiA6ICJubyIsCisJCQkgICh2YWwgJiBST1VURVJfQ1NfNl9XT0RT
KSA/ICJ5ZXMiIDogIm5vIik7CiAKLQkJd2FrZXVwID0gdmFsICYgKFJPVVRFUl9DU182X1dPUFMg
fCBST1VURVJfQ1NfNl9XT1VTKTsKKwkJd2FrZXVwID0gdmFsICYgKFJPVVRFUl9DU182X1dPUFMg
fCBST1VURVJfQ1NfNl9XT1VTIHwgUk9VVEVSX0NTXzZfV09EUyk7CiAJfQogCiAJLyogQ2hlY2sg
Zm9yIGFueSBjb25uZWN0ZWQgZG93bnN0cmVhbSBwb3J0cyBmb3IgVVNCNCB3YWtlICovCi0tIAoy
LjE3LjEKCg==

--_002_CO1PR11MB48354DBE206824F26EB3D830969C9CO1PR11MB4835namp_--
