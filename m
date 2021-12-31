Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ECF244824A4
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Dec 2021 16:50:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231189AbhLaPuG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 31 Dec 2021 10:50:06 -0500
Received: from mga02.intel.com ([134.134.136.20]:44453 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229453AbhLaPuE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Dec 2021 10:50:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1640965804; x=1672501804;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=P9z/yQ6yovlHA6hX/qIlL51rhu45CGOkunDQqULnheg=;
  b=nq4dl+Ui7PdBNpWlDcsdvsmPOBWf/Oc+htHOJzoAo6taZ33EhovHEkko
   CWMXUuoZohoskmBdB4zEdJpO7uxb6JK+Nq5cuwfMIEtupRCaaA9B+oF6K
   SMZGGIqskRaA8mm7EfJLgGnM9vfrZUAJTITtQC4pA4TLDme8YFqdD4kZq
   bdrdBEAPhmJEnckiN+cqbTfQlxGqIy8BWF+1ouRWseMZYwTzAp1XB71BR
   MQap1IWNtdF+oLMqVQG4qkLP5QErzrREmGldIWfPKdj7hFSecsS0UQX7M
   wynJusbSdorHBqtC5ofMxeebHeay5Ycc8E5tHSHg6B5Lf07BpaXUnhklY
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10213"; a="229137206"
X-IronPort-AV: E=Sophos;i="5.88,251,1635231600"; 
   d="scan'208";a="229137206"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Dec 2021 07:50:03 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,251,1635231600"; 
   d="scan'208";a="555069108"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by orsmga001.jf.intel.com with ESMTP; 31 Dec 2021 07:50:03 -0800
Received: from fmsmsx607.amr.corp.intel.com (10.18.126.87) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Fri, 31 Dec 2021 07:50:03 -0800
Received: from fmsmsx605.amr.corp.intel.com (10.18.126.85) by
 fmsmsx607.amr.corp.intel.com (10.18.126.87) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Fri, 31 Dec 2021 07:50:02 -0800
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx605.amr.corp.intel.com (10.18.126.85) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20 via Frontend Transport; Fri, 31 Dec 2021 07:50:02 -0800
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (104.47.74.41) by
 edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.20; Fri, 31 Dec 2021 07:50:02 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bxAz2n9tDzAGMjw6aN3/C9wv35m0jUx+uuSejixCrVnnItKlQgiQFwZRF3B+eGts/90nnfs+HbFbA5KirwFzncSGZfXaBh8NaSi4+42YhD0e0oUbt+UgW+6u/2ODvGxojjcu9zK+RMu+pD3DixF875ttSKoEWO5kqD4drGCatXJ/P3Xh0m1qLH3Fh50kU37scT8KlSAzKSfwjzYVj8aqBqcw7GpFA20DXavKKMtYSjJtGoFlnuscnpiXRMEQduSD6M9y5T6SkV4n3b/tyIs+ANo05GSJRZnmtVBPFZRslvKT0zQi69A1YNmShhMd/ldP+MVl2IkDs0RlVS0LQ7+G4A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MVj1cRfUAf1eAA1dCRmFtVv0C/t55p/ZncxBykZCgKw=;
 b=BeEpO+1YBqn7WC3U4UXKlFFWrB0O5ddISh5EwOHA3prcvbWnpBQzqlAT4EBAz/+QotWEYwI0DpaVfeUZmhGW7hwsxArDgk1RXt0cGiyw13U1niCsgf+K7Wz3hC3gERYvlnv4XflSGDfMdngc2/FR5Kp9Fub5e7qgzOPzBZBP+G2i7Q9zdZNpuizOXFVCFbtLilnfE7gZfpQv9MT+51H5NymMlP9pXAF9XKh+4g8rZcyBI6bh/YRCghuZ8BAXw048akqa1EcYv2Ow2yxm2GD0dUMHx5bc7e5cZHq7a3bRvbYIjiQjmpSHP8mALvd0+PHSuUsO7Xc6bwjqU2U3EM/Pgw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from CO1PR11MB4835.namprd11.prod.outlook.com (2603:10b6:303:9e::22)
 by MWHPR11MB1501.namprd11.prod.outlook.com (2603:10b6:301:d::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4823.21; Fri, 31 Dec
 2021 15:49:56 +0000
Received: from CO1PR11MB4835.namprd11.prod.outlook.com
 ([fe80::9920:c2e:ef83:d62b]) by CO1PR11MB4835.namprd11.prod.outlook.com
 ([fe80::9920:c2e:ef83:d62b%6]) with mapi id 15.20.4844.014; Fri, 31 Dec 2021
 15:49:56 +0000
From:   "Khandelwal, Rajat" <rajat.khandelwal@intel.com>
To:     "mika.westerberg@linux.intel.com" <mika.westerberg@linux.intel.com>,
        "Krogerus, Heikki" <heikki.krogerus@intel.com>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "platform-driver-x86@vger.kernel.org" 
        <platform-driver-x86@vger.kernel.org>,
        "Westerberg, Mika" <mika.westerberg@intel.com>
Subject: RE: [PATCH] platform/x86: intel_scu_ipc: Keep polling IPC status if
 it reads IPC_STATUS_ERR
Thread-Topic: [PATCH] platform/x86: intel_scu_ipc: Keep polling IPC status if
 it reads IPC_STATUS_ERR
Thread-Index: AQHX/VdVI9fbyn2ZKUGZmpjZsx6tm6xMwTug
Date:   Fri, 31 Dec 2021 15:49:56 +0000
Message-ID: <CO1PR11MB48352F856F280F0E3716972196469@CO1PR11MB4835.namprd11.prod.outlook.com>
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
x-ms-office365-filtering-correlation-id: 9f72dbc0-989a-40b8-6d9e-08d9cc7531bc
x-ms-traffictypediagnostic: MWHPR11MB1501:EE_
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-microsoft-antispam-prvs: <MWHPR11MB15015A43E730F4E7DB9E8A4696469@MWHPR11MB1501.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6108;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: DEN27ZMy56hDa467MoPixbcHXVQTST/w5mZU8PmtflnQT+MZdZnZLprisPMCbly9h9Z9yONBUp44dg4Ulez+yc5fqvoT3GdaBMlXYvCqEEXt2IlaYpv0vIvqIZbvZN3lrh7SKoZdEdauf7FPtZaFSvOSC3js8O8ID+Z421ysHTMgew29ofzvJGuAy8M9H6Oe1k9P/uN9wtPrsxzESyMHVyeuGQ/LUXwttbxezli9L07v2tbHOCM+ArdzNXnyxGyGVLDwNqJFG6TxKzNizbpKXoUXMhtbwKZ8zU7EqM+sLGe20dm2Lno6Vm4INmpOrOlpg7POMqw/Z44+uBdxqValLcrkBWZBP70g1EbAHTydwnENc6j51PIuqaM5NhZLjvq2ru5w8GOXnPV2n8z7D6kFikJl3782GUJO9nbymAlScjd21YcGCRFj632OihCYKvsqbF7eBh0CqvuiNKRE/ljFiJ1ja1+io6w/Rwx0Sy2BCR6J6DUTuRGNA98FwwtV6IAm8eOdph3pItdZ32NNkb9Vw+QLXKlHhzFz4gmrXllqbqQ1ocHxI2pU1LKyQUZqQX3Fk1japnZj4lCtkLQSKEU8Sbk8P2/crzcPoBfKxVRqOXp3xTRyTOUVt83hboYpiigqAR9BqIw8DX4BLf6TubMCg+wapGkMouwQfJjibfFWCwzsFk5FCbA4ptvETMNKE2N79MTvoRkUuyW8n4ev7FeSJQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB4835.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(54906003)(82960400001)(52536014)(9686003)(8936002)(6636002)(6506007)(7696005)(76116006)(38100700002)(122000001)(55016003)(71200400001)(53546011)(508600001)(26005)(110136005)(316002)(186003)(83380400001)(2906002)(66946007)(5660300002)(33656002)(64756008)(8676002)(66476007)(66556008)(38070700005)(86362001)(66446008)(4326008);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?1BkGkPC4BaTxIftlwyY3LSJ5/E+6d44dj6ARF1hZ0P8mOWArcQf8lPejwBPG?=
 =?us-ascii?Q?BgHKqIPbg0Iv17vL72UVP4z8fZeL+G9QvXBAe3oo5yeU7bQf/8TNmevy4Vae?=
 =?us-ascii?Q?LLlo2ZZ78Vfe21YQFpogQB7fkQ/yxeC73KPVlDm0DA1kEI8s9DNrlBsOEIkk?=
 =?us-ascii?Q?SGnrugTvoD1Ogolnl6uVVntykwSKkoZAzN43b0cfuuaZa9LtDCtF2qxCamBs?=
 =?us-ascii?Q?vTLsTBxq9+SW8gvXKCfrC0Ejx65Xa9D68jsBoGSkZLbLwIHxg94yrvJVgENO?=
 =?us-ascii?Q?DxYg2X/BEUpr62InNnBFniNpUC/uxqCFOpYaUVtpGOXwKpWgJ44QZWq44LdC?=
 =?us-ascii?Q?ve56P6kIv/hSvn/1wQvQWbBWw3m4JYvu1KR8gWKNUsPQfTkQXGPCc7+gUvMs?=
 =?us-ascii?Q?eX4kjuvmWp6QgR0zIWMRF8NRlXZuF9ptHs2otKa6ACw2vFIUqX7/uGpswPAM?=
 =?us-ascii?Q?eS4co4W1CqmI/dAphX4TxqQmo5z4KYJlqDdF/OJ3UPiJDCy+7u+o5NGzVjy6?=
 =?us-ascii?Q?UdIoKVveYUzp66rgszzv/ECwWM9czZQxR7nv7agYDLaJY3Da7Z8SfASd89ho?=
 =?us-ascii?Q?QT91stdEtelp+R3Lo9D6N/ZIAulQiD5v3CZ+e4rHDveHw8NijdSO3yp4FVHz?=
 =?us-ascii?Q?gHvBLgmpSL5I8n3AZRg7cJIodE1UMvSJJYhy5W/JVwK4n4e52WzSazWKnNWc?=
 =?us-ascii?Q?4lnySghX4LE9WJdmfwTT77gF0jRE0KqsZCO1J1PfgakVj6322T8SBZM54tWL?=
 =?us-ascii?Q?dxpGaOD7kvWZunH7fMi/l5c9wM6uNL4j4Hx0NeOFV7JVgjCOkOKBurXytucx?=
 =?us-ascii?Q?B+NaKkqx1GIkt/KKBhAWDSRsX9vZ3scZ/Cfyn0lm4VQCcsMHMePaegZuQDOb?=
 =?us-ascii?Q?yX+gp9OkiXIxcvZTA5dhPtdCPxrgkfnL++4QtnjS6CuaqDJI9zhVMd8+ysiP?=
 =?us-ascii?Q?sL794Rn29q15U1tMYGlAQAW+zY5RLOqn0S8h1N1V09H9RQmCQOK4nRb7gARN?=
 =?us-ascii?Q?0GbK+UeN64SsBZmwcWIVCdHh9XM/I+6zvhJ0ky9c0ph+hr2OOCI2WGKHgNud?=
 =?us-ascii?Q?EtyepF7/0qxGL4NUQp61lL2qKTul9n7qys9BzfuJNMdfOy5msRIOkFl6m19T?=
 =?us-ascii?Q?HA9LvX7kEarAeraK4eiaJuDxZergHyedx2c3peDH6ciP5wBR4FTFNk4Q8s0f?=
 =?us-ascii?Q?M5ycK5SXfv/AMalhOPKkKLt85AdLhA5/K2Uu5vIjTznxT80F9FLBe2rYgwXk?=
 =?us-ascii?Q?dBkRczHbPc0eOMvfSmRUEK34fnLBztK2bhlJX5oiTDDjl0A7zS5zNIuIQ8+T?=
 =?us-ascii?Q?t1w/9PwNoPez3CriQ13goDxLYnEThCaWErZB6J2f+aPmoS1jPGZyPoD9kkt1?=
 =?us-ascii?Q?HKMLpPisrleBysWKoYTCgKZYTfv3giISH1/i2Cj0G9WWy6txVIfw+/0WfRpz?=
 =?us-ascii?Q?LOq4Wlpv65CnXgTYTD02jbDOyhEQUw3tkFttJ/Hl70i0i1JAKT9TfW1BEaga?=
 =?us-ascii?Q?l2xExd67F7h/pjmDsN2DqN4QPLNCjQT+43UVyfr8olmMU5GPfvkozNlIEqbH?=
 =?us-ascii?Q?agdo/2KeGqas5uFhvt47JrkMnVpcVThkWB29LWW4vapnhlrBXmFGupk1ekYR?=
 =?us-ascii?Q?A2Bbo+ulAvcDPUFbz0wocDt4iYJDl5XMUZpRoN6uEIgwL9YP/R0sdXeaUH37?=
 =?us-ascii?Q?kTmt7Q=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB4835.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9f72dbc0-989a-40b8-6d9e-08d9cc7531bc
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 Dec 2021 15:49:56.6370
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 4qRg2cOZgH8h25n1c6SJ5V3IPyJyzARDwWo68i3PxoYX65e/OeB9nK/imprQ+98wGU9BZcJCub7SZyO4RC1vY8eYhgTtIhIEybU4U9tJCNQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR11MB1501
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Adding ++Heikki

Thanks
Rajat
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

