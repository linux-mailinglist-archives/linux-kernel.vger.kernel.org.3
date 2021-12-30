Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B5935481ABF
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Dec 2021 09:31:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237711AbhL3IbZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Dec 2021 03:31:25 -0500
Received: from mga02.intel.com ([134.134.136.20]:57215 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231140AbhL3IbX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Dec 2021 03:31:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1640853083; x=1672389083;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=tqOwW3GiXRRzyTob02jTp6ErBMEccNHGQz6ZhCgX+6o=;
  b=Ex8xtzcSMlkcbw6ZMyqi3yqn0lTKc8hHg5+58UoTmDQmKiyWx9+WT7XK
   kgpweGTPvSE5FIQCLeBov2DFiep3KDbympPiINO9NlqJ+AOUOr+1bSWhX
   /RUcCiDwgdTnQEvOcNhJ6BIMw+P1cywx8I/9X9GAPwrsDZuyIJo9BqmF4
   UgGYh+i8AC2QQ8zzouadUuEdrQaZnF/+MpZG75eMOuYZKVazutdJ3zqh+
   gAAnrPOYvPJ1tXEXX8pJcg+AHtmy56enWEn2kB922u+iejZv2Jq3k3GCg
   6Kz5PbduI1ZK873gbYLSTpLiD3sd9zCNganzIhU+W+PqgDn63ti0oe69J
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10212"; a="228948586"
X-IronPort-AV: E=Sophos;i="5.88,247,1635231600"; 
   d="scan'208";a="228948586"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Dec 2021 00:31:23 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,247,1635231600"; 
   d="scan'208";a="486830796"
Received: from orsmsx604.amr.corp.intel.com ([10.22.229.17])
  by orsmga002.jf.intel.com with ESMTP; 30 Dec 2021 00:31:23 -0800
Received: from orsmsx604.amr.corp.intel.com (10.22.229.17) by
 ORSMSX604.amr.corp.intel.com (10.22.229.17) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Thu, 30 Dec 2021 00:30:45 -0800
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx604.amr.corp.intel.com (10.22.229.17) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20 via Frontend Transport; Thu, 30 Dec 2021 00:30:45 -0800
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.44) by
 edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.20; Thu, 30 Dec 2021 00:30:44 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UkoktErv8odBGCQwz/NedszxAejfr88A1TcVMMxhtl/kEbyYl5nbLQygjZAKCeKw/Oji7O7itrH96qnYj8QnZb5nzBXfVsZ9BjIxs7VHkofZpkPwV2h/bvxoRQElQ1BYhyhXt8uFh3KdR10SVkibho+JRX646tmQaObf66dN8Qb5tUDltdVo0niQWFWP3jONBZMTQi++l0dSdV2YZ7C5XW7EZKIL2wFidGRSHWzC5KQ0lj9C/aHF9gWliQp3+Iecv+EokMOeK9P0Vo3He3GthiJeD47p8BmllWThPkT00qDy3+3AA1fu6L3zpAcjqao8lACOyWB2XJOsxC9lncnNJg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YsNIkHJmRtAR7piwNWLL/EmwnGnQWpAQwCY7RH/E8QY=;
 b=OPT2bI2F/CVz7qW9DEerYzqUZeEeWS6a7iRXBAhRmyrZBc4RJbaqC/2wrQDQKIR2SFJLO4qNXuqc5YN1zvbhjNGyYAxYtSGaVYBF3DR2/hkpeBC0nXMt+Rei97W/d3kDEGmS70A5ZjJ7U82CBY03SKxaKOyd/MlRm3Iny8sQW0A7/0kKSSOTQqBFcdyITtPZRe+uM5S4IUpM8XBFYifIAtwqcs1yIUVAnn6Zd9dqB4m+6T/6KXORBgZKjIsLYgbU8z+Haq/1IOS4OuHHLeaiBWg8xm8qxkChUeH33SGVL9uwrCu/Ix+zAUzHKpCSD+IWYkcg6bfMVmq5ZRWo4O13NQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from CO1PR11MB4835.namprd11.prod.outlook.com (2603:10b6:303:9e::22)
 by MW4PR11MB5821.namprd11.prod.outlook.com (2603:10b6:303:184::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4844.14; Thu, 30 Dec
 2021 08:30:40 +0000
Received: from CO1PR11MB4835.namprd11.prod.outlook.com
 ([fe80::9920:c2e:ef83:d62b]) by CO1PR11MB4835.namprd11.prod.outlook.com
 ([fe80::9920:c2e:ef83:d62b%6]) with mapi id 15.20.4844.014; Thu, 30 Dec 2021
 08:30:39 +0000
From:   "Khandelwal, Rajat" <rajat.khandelwal@intel.com>
To:     "mika.westerberg@linux.intel.com" <mika.westerberg@linux.intel.com>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "platform-driver-x86@vger.kernel.org" 
        <platform-driver-x86@vger.kernel.org>,
        "Westerberg, Mika" <mika.westerberg@intel.com>
Subject: RE: [PATCH] platform/x86: intel_scu_ipc: Keep polling IPC status if
 it reads IPC_STATUS_ERR
Thread-Topic: [PATCH] platform/x86: intel_scu_ipc: Keep polling IPC status if
 it reads IPC_STATUS_ERR
Thread-Index: AQHX/VdVI9fbyn2ZKUGZmpjZsx6tm6xKtDaA
Date:   Thu, 30 Dec 2021 08:30:39 +0000
Message-ID: <CO1PR11MB48359C6EC7DAC17F7FDD91D896459@CO1PR11MB4835.namprd11.prod.outlook.com>
References: <20211230082353.2585-1-rajat.khandelwal@intel.com>
In-Reply-To: <20211230082353.2585-1-rajat.khandelwal@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-version: 11.6.200.16
dlp-product: dlpe-windows
dlp-reaction: no-action
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: c3144ab4-fd7d-42f7-5e1e-08d9cb6ea971
x-ms-traffictypediagnostic: MW4PR11MB5821:EE_
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-microsoft-antispam-prvs: <MW4PR11MB582115477FC7F0DA7238B5AC96459@MW4PR11MB5821.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6108;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: yLvZXnf2/rphUYPQKqgcDm+OAgvnnJhvX6xEkeGBoJEo/uOj81L/pVqKSJpyvIFW7BFDTApicoyA6iGyRVQzZsmyh/oTd25J4JO/xt/o6UylbtRESNKWizBSCAIWQAu8s6g9tT3M3/g+xu4ZUSgpltrR/RXRcVU+QUfUgn7WIHBfNAWgZ0n1SznbchJnSApJ8F36ZeCQUscJp9h/GmXJ6PR5/25rdLCKoCRcgSyE6unXsXmPzjkLWIFCxejvqdDmB5gzc6ULOG/UDx7Mi2i0Z7gQX7kZya2ZmDzhHz1hUG6DNOt1eai7X3LVls/DkGikZsQZ85JKNhJ+TzYf3+irP6dxcc3lm5K0UBuciVo4ebqzM/TfiIK5iOpzxIqKdAlUgr/C4eJh9o0P9sSuGW/zMqYX4y1I9DkgUYAwfvYKnCE4+jGn7KlCBGlnIHnbRUr76XfRvlhVwGyYJZTRAoXcNu2wWxsyUb9I3tMRMI1uLVDEz+m+/3dYCCAJvYME8vIrQVDaPB75sZOj0L3X1DaO6Umhxmz+oh7W1af3EIhIoKLdjydj+E7X2MqclQVeMCiMCzbRUp7IbiVYA365Ubgdjnu54mRGFDKD5GuhUSl4C02Oe6num66sadqQlGbmlqB/qiWqZ2LVsHTFGCajtCYV461Z/4pcklQlwrYG8U+UDvCb68MncCew8biwJOh7G2wDHjFyWjBWjBpEWTrPx4nUvg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB4835.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(66476007)(2906002)(33656002)(66946007)(6916009)(76116006)(508600001)(9686003)(83380400001)(52536014)(66556008)(64756008)(66446008)(316002)(186003)(55236004)(38100700002)(38070700005)(26005)(5660300002)(122000001)(55016003)(7696005)(4326008)(86362001)(8936002)(54906003)(8676002)(53546011)(6506007)(82960400001)(71200400001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?IjLtMu2MyfGZ960D+xNi6QCjyxBJCl5ssNrMNdm/28351aTdGv+hU+LgeRRa?=
 =?us-ascii?Q?GXlkCz1+GogahvtzRqLyFV56S9odUrxWaI4JMfAA3Zfd4qSqrJz8JBTAqvy6?=
 =?us-ascii?Q?Gw3U2CK6u9MrcDf7AwK08rws2810K2A1voirFnI8rsI4w7tPONmRLUZzNgxP?=
 =?us-ascii?Q?ollc8tBYL4ACzabpDELyxL1xJe+VcHWYQdPUAo2hIFZSMTbkVfJbo1k8LyVr?=
 =?us-ascii?Q?vWiyfc7ZNOFtwEYA66dJNIGe70EeNMhGdcEZ1FYETjkrHx8WJKjRV1bkcJvM?=
 =?us-ascii?Q?7o/DrNJ8zupVEoJKlrgm6opAffjazCvTo+p5Gr9kRDBeO3EcYkuHyuTLGRHX?=
 =?us-ascii?Q?QzitApWrNhxQL+vwfDgSmtHZXJmdutM+4BRjs9DtpxuL2YmQuM6avmjKYW3S?=
 =?us-ascii?Q?h/4f+6Itl/ZZViTI7qo/uE1tkO1YLEoSHwvEQ10ROHjDvKHPEBjztSnmcNch?=
 =?us-ascii?Q?q7YTl5BKQXTI726WfzNtkGmzh355wiq8Z3FD1ifAoDd4MCrODcR/ibdIaqpL?=
 =?us-ascii?Q?K7o8jE4IkJMwPZmVz6WI38QYCT/RCq7aFphSDX95SM/L/7fELFzGiFvKGkeJ?=
 =?us-ascii?Q?tp+RWA1l0bkT4quDag5pBLfoJWsVfpJsll1o6KTZBG1i0EVuQwORX+Yj2GYB?=
 =?us-ascii?Q?6MjprMOmcY5xv/Dmp81gSkdcqXy5xHqeoLyC8wcAbJP2qPgJpZtAiq+o0cEo?=
 =?us-ascii?Q?uL9qYC/SMSmOtK/dwDwNx4/z0pWSzUL5kzBmVVIPIMv085/0fb20eeN0r33V?=
 =?us-ascii?Q?dSoGXdvnc/1zJgOTzGKbA+K7eoGZUzr/DWOxLqntmYeFLQp6AhUgM2goj8uv?=
 =?us-ascii?Q?S6fh471HxD/cdbahDJE2CpxdAJAH9rCxv/OHksIakydXgtKIaV5kKcj5jczO?=
 =?us-ascii?Q?jgA8tBlX7TVSY9qs/s/mhYovHi8suDb5E76hjh+ofoLboMelguVrdgREGVhp?=
 =?us-ascii?Q?U83ny0wOjXZGQdmgji8LgwoEr6tjvbkW3iN5cK+NsjzlTRz7p06gBI9DNgRT?=
 =?us-ascii?Q?wrnOBHt7G7KcUWmOnGDd2PJnvWAIW03AsWCGtXHddbK5FQO5IXAevYIr2dT3?=
 =?us-ascii?Q?rf7jmaL5oASbheU/sF13B2n40qKxqpt2KLbNmwe42nK+JJnTNRuJf9+P5/Wa?=
 =?us-ascii?Q?BU30j88GOPh+kt0rVXi9YNmg+anrxzPehdTOAn+VOdiKH5aud0Es5oJ+Rhdt?=
 =?us-ascii?Q?xr3kbx19+UUVNr1VlHQsaz09l5ejxnKaQsc+1cAfCDBErH/+bo46IpCV4ysn?=
 =?us-ascii?Q?bDqQMNxNtxWYC3CoRkUAhSZ5/9ai++3TgdRgNf+Picam/pwMeIQaA+Uf0fOz?=
 =?us-ascii?Q?X5WkoMDcHYaryzRA01xeoVcuNdp3YoSlhvh3GavMvnE9x/dnh5X/vwfTyxWS?=
 =?us-ascii?Q?yvMbjfs71tbEq4QL3iBSg0t2LDQaFS23kaCjqEyAFaC8d7W6QUcPUmUyyVJd?=
 =?us-ascii?Q?YDAaBwtpNdwVGlx1xanTcuIAstcz5yJgrlnKPdjB9emCpg0z6HzqLdsRBpOC?=
 =?us-ascii?Q?jTVd4cIvwN+jQod8Llf8CblrDLhpwb0bR8YmvLuttotpQ/IJbOR/6z4Bvoj1?=
 =?us-ascii?Q?mVFKSh0rnVCPb5KuPDnDqfnbl+1aD+HyFnHn5dmwo4uppDtxvsFQfenbpkOl?=
 =?us-ascii?Q?Ex5vYfuWLwl/DiZgODDd5L72VVBcxzollUVyDtOgJKyzol7qYjBBBFVy91g/?=
 =?us-ascii?Q?rdA4xQ=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB4835.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c3144ab4-fd7d-42f7-5e1e-08d9cb6ea971
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Dec 2021 08:30:39.7850
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: AeEufjXmq0IW4ggwKOAJky2yWnzxWWngSx7w03X9oGQ6Pa3e8mZvT//wwnnzIu+LJXj0194dxG/SLImdN9J/qSfIjVBNIeL1ff04aPZUhvM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR11MB5821
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Mika
I hope this annotation is correct? Sorry for the multiple errors!=20

-----Original Message-----
From: Khandelwal, Rajat <rajat.khandelwal@intel.com>=20
Sent: Thursday, December 30, 2021 1:54 PM
To: mika.westerberg@linux.intel.com
Cc: linux-kernel@vger.kernel.org; platform-driver-x86@vger.kernel.org; Khan=
delwal, Rajat <rajat.khandelwal@intel.com>; Westerberg, Mika <mika.westerbe=
rg@intel.com>
Subject: [PATCH] platform/x86: intel_scu_ipc: Keep polling IPC status if it=
 reads IPC_STATUS_ERR

The current implementation returns -EIO if and when IPC_STATUS_ERR is retur=
ned and returns -ETIMEDOUT even if the status is busy.
This patch polls the IPC status even if IPC_STATUS_ERR is returned until ti=
meout expires and returns -EBUSY if the status shows busy.
Observed in multiple scenarios, trying to fetch the status of IPC after it =
shows ERR sometimes eradicates the ERR status.

Signed-off-by: Rajat-Khandelwal <rajat.khandelwal@intel.com>
---
 drivers/platform/x86/intel_scu_ipc.c | 14 ++++++++++----
 1 file changed, 10 insertions(+), 4 deletions(-)

diff --git a/drivers/platform/x86/intel_scu_ipc.c b/drivers/platform/x86/in=
tel_scu_ipc.c
index 7cc9089d1e14..1f90acaa7212 100644
--- a/drivers/platform/x86/intel_scu_ipc.c
+++ b/drivers/platform/x86/intel_scu_ipc.c
@@ -233,17 +233,23 @@ static inline u32 ipc_data_readl(struct intel_scu_ipc=
_dev *scu, u32 offset)  static inline int busy_loop(struct intel_scu_ipc_de=
v *scu)  {
 	unsigned long end =3D jiffies + IPC_TIMEOUT;
+	u32 status;
=20
 	do {
-		u32 status;
-
 		status =3D ipc_read_status(scu);
-		if (!(status & IPC_STATUS_BUSY))
-			return (status & IPC_STATUS_ERR) ? -EIO : 0;
+		if (!(status & IPC_STATUS_BUSY)) {
+			if (!(status & IPC_STATUS_ERR))
+				return 0;
+		}
=20
 		usleep_range(50, 100);
 	} while (time_before(jiffies, end));
=20
+	if (status & IPC_STATUS_BUSY)
+		return -EBUSY;
+	if (status & IPC_STATUS_ERR)
+		return -EIO;
+
 	return -ETIMEDOUT;
 }
=20
--
2.17.1

