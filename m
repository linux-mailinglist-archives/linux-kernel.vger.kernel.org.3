Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EBFFF46B93F
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Dec 2021 11:36:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235302AbhLGKj4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Dec 2021 05:39:56 -0500
Received: from esa.microchip.iphmx.com ([68.232.153.233]:14040 "EHLO
        esa.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229594AbhLGKjy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Dec 2021 05:39:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1638873386; x=1670409386;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=UP/q2FJkAXJFKFTJN6q8c9qIkg6tBGTY+VTrwsDtrp4=;
  b=jfxyoErRpIz9KPN2l/p5NZRx2vXX/oOZuPLZkOYKRcBiHMZow2UybUA/
   iZ4lV5cUz59MRyeHvNiAsVY5mU/Sd/Y+Wu53EwBNMNXoKAhN9C5pIQz/3
   JT1fBUFIKtnH/8EyezRk8bxhAm6/cYF8msqOF6gpnaYtK9Tcz5+F4+U7a
   iQZs1sw5PAYX/68uf76QJ4qJVYTmFbWkhZMG5oHI1KHX1/PZ7fnvcojxv
   qkOF/tiBHD96R+G4XOU/3nSQ2cpV7xrPQjiriyrbcKJcTEFBn3k1zF6Rl
   U22YyqtweHb5Pqp7SfEfaOM9FxGZgOM3G7cojoM5Hmo2+Sl5wF9WJDTis
   g==;
IronPort-SDR: UeRdx2cceFXeL83qHl7Fb8YFj9VH6bPRZdvc5QhAnWJPrN4H2aLMGArVuX7l83mu2O2tlzR2yz
 A2zjpNNl5KPuTZ9HfFltxfTQeaui0wfBeFJzjTovFpK1iOqQXY/ugb3G3k8fhDqRiIi0ktmXlr
 aBLnjlehvZ3MLFLrYQncnm04Rmv7JqiIKRK3I34RbIvDaXuLLMAZsuuK36l3pvb/FkVYTowAYh
 lazHvx3Ossq7srKlpuwhs3mjNhaesGX2oGHxlj1UfDZwUP4iTFr5diIvetgX/XYhF8fT1jBQzs
 u4haX33SvV4iSuokmyF28yJj
X-IronPort-AV: E=Sophos;i="5.87,293,1631602800"; 
   d="scan'208";a="145785654"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa5.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 07 Dec 2021 03:36:25 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.14; Tue, 7 Dec 2021 03:36:24 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.14 via Frontend Transport; Tue, 7 Dec 2021 03:36:23 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hB2i9oSE17w7QMZ4GseRTMuzRj2RDUke2rYUfgAZF8vVFCl78qAOcNGOtks6ykU4S+YJxkXLUaV6Ie47OPzdHO8pgVY/631yu6Br4YNJ/DBFG/hM7hfMzDx+UiZWnlV5W1uIhxEeQM3rpQcYtAlA4DVVretsYUBd5Q2c0dOgolboKwIBJD9Y7yPs4rE63zhRmhvLOkIBHp2Z/xWQQcUc+lHF2AaYUDjniQWLspgcj5q+wmtPaJ+6TXITX4UEZ/I1Ieh0eHg6hxvirDCm2kDWtWKvCHIc4/0JtY7+cNAX7bFbR18gVeY3aIzkvvKUBJhr1wAXUAou1XA0oIMuieHPOA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=b+VJJx5slacxAHwIdi5w4Hu3GEz+uCWv1q5wKptWXg4=;
 b=PXu8/SzaHgrDWc5YbVVJqSJDRIGV3s28p9BWHqh57K4ICIEsdDQ69z6zqGSbxZBCCVnp1X+BX+sUpvKoR2J2ohfM6kAM0iKiRjgZahJZJuV6tDjjPxc8n4z9pbxN2QqDVr/ZCcsWfUezoJ+glbYQflSrW/sVbe8KyhOoTrdYk8FcYwPGUYiSQCeLHXKbnbkKC1UNn7h6tS7rNUkn2IsD1Ll/cnBshe8gJtw32S2okv35AwIPBV+YXc1JwKDGzy5CLqf9MXyNVXY1Ssq1DG3wCLDS6u/o0dlO7xjvJruAbWjFzGaBUZH5fFTAqVs+WiN7T9ZrAEwRGg7YbobQfFPIbg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=b+VJJx5slacxAHwIdi5w4Hu3GEz+uCWv1q5wKptWXg4=;
 b=VDOxlJNZwue7e8+IB2ylTb5N2s7zFxsJp1ppMpfFYdOxA5rB+ktgCNV15YgEA2m+n2bTEKv9eT9Y+5d5LSfJaIApZ4EK9v3NebaiBGkMjp5TJHqXIcDmDdR2MSStrzO/YfQjQSXk8rteo4Td3sWC5IhuAJhE3ZUslwIgm3s94aU=
Received: from PH0PR11MB5112.namprd11.prod.outlook.com (2603:10b6:510:3b::18)
 by PH0PR11MB4853.namprd11.prod.outlook.com (2603:10b6:510:40::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4778.11; Tue, 7 Dec
 2021 10:36:19 +0000
Received: from PH0PR11MB5112.namprd11.prod.outlook.com
 ([fe80::ec81:740d:c5cf:5ad0]) by PH0PR11MB5112.namprd11.prod.outlook.com
 ([fe80::ec81:740d:c5cf:5ad0%5]) with mapi id 15.20.4755.022; Tue, 7 Dec 2021
 10:36:18 +0000
From:   <Ajish.Koshy@microchip.com>
To:     <john.garry@huawei.com>
CC:     <jinpu.wang@cloud.ionos.com>, <jejb@linux.ibm.com>,
        <martin.petersen@oracle.com>, <Viswas.G@microchip.com>,
        <linux-scsi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <damien.lemoal@opensource.wdc.com>, <Niklas.Cassel@wdc.com>,
        <Ajish.Koshy@microchip.com>,
        <Vasanthalakshmi.Tharmarajan@microchip.com>
Subject: RE: [PATCH] scsi: pm8001: Fix phys_to_virt() usage on dma_addr_t
Thread-Topic: [PATCH] scsi: pm8001: Fix phys_to_virt() usage on dma_addr_t
Thread-Index: AQHX4twBpu9E7jx9w0eTfQRflv+fTqwaU8QggArxp4CAAD4CgIABW1WQ
Date:   Tue, 7 Dec 2021 10:36:18 +0000
Message-ID: <PH0PR11MB5112E2E7D00D95F32C86677AEC6E9@PH0PR11MB5112.namprd11.prod.outlook.com>
References: <1637940933-107862-1-git-send-email-john.garry@huawei.com>
 <PH0PR11MB51123148E4932FE1C64F8052EC669@PH0PR11MB5112.namprd11.prod.outlook.com>
 <a60318ef-dc19-a146-5ac3-16eae38b8c37@huawei.com>
 <Ya4PAu4Xj8UGHEV7@x1-carbon>
In-Reply-To: <Ya4PAu4Xj8UGHEV7@x1-carbon>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 7b47b77c-3f4d-4f00-db8f-08d9b96d677b
x-ms-traffictypediagnostic: PH0PR11MB4853:EE_
x-microsoft-antispam-prvs: <PH0PR11MB485338DBCF4403D77276810EEC6E9@PH0PR11MB4853.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7219;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: iuY1KFbOFZT8yp4rHWkZTxUqpUMxK7oV6ZrwgnekLfDWne3YkgF/pPqPt9qNWBCFVA8yZuA2T4FH2jBwJK9kuYnm6DENWuqigwA6xDiJRQVvF8rR+EKVZF50XgSBuOw8upAV/e5JJc+/B8K7dgfDVQbqeBIYEq58SFQKMoyGMKRVyvvIZFcCKY9xwnFU9D6KnVd7qiXnGGgdPMp2YrBdVkUdsbfd1nFYnxsLAHO0wJApmDSQd1EE6lQn+vGJz+TNW51vBEn1Aqwli+2W90pa/72kR5UCVb9wsVvC1+kkBLsEWcOPEQKr0d0ytgDNC0cocqLUTGV494d0NlriQkS3kXhxXnRFMBlOg2mLLjNVWgT8XqJpT5ToJ8+gg3GBOfAlgZZpys8iLxIkCMx+eD/2LU4n7nojfighXwIKfb26eFYm30lc9XDybFIAyEoH9atUWH/+e3DPnhyRSX4M1Z2oEYrzlguXweOpR7VNvBSjl7U8jXY11NCNrAkN8L0ZFRbL7azURIvKSTH/bNZb6NSPaGr9wE3cbpYf/vIAwUSuVxohWXPR28N6Y89J/zXO4FTnfKnQaBDxTkMoCCslLNS9OEGrJ1EzZ0VeGjTWShcZxK/wdD1eRcySgWIvKHYhOf16QY/Z4KaA88kasPwNryzzFFL4iICfFEpZx217B5IxgRdp5pVXfmf05NSETxs8daruP5RLKiULhI4+HLywg/m18kPpVSCQfvxOwdxVsxYHZYe8NcRxQb56N1UJdMqhKcCvNU3KjtIuTsiSgWdNZ5+F2OvpC43ZkJoCBTk2YNvvLgstvMARDdl+KfDcUZ1tLD8tase2z+GkKP8xISuJIq3NRjnbw9BjrCvmrBcGq4SkERw=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB5112.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(508600001)(52536014)(83380400001)(6916009)(7696005)(966005)(26005)(6506007)(53546011)(55016003)(4326008)(54906003)(38070700005)(316002)(8676002)(2906002)(8936002)(186003)(71200400001)(122000001)(38100700002)(86362001)(107886003)(64756008)(66446008)(66476007)(5660300002)(76116006)(66556008)(33656002)(66946007)(9686003)(10090945008);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?Eyeqim8pwv1cRL627Krettd8OVVlQ76eOouYxUu564YmJVRsg09565BR/cwV?=
 =?us-ascii?Q?dVlm8cgFDVe/WWfjoDa6Ol2X6KDZHu2bqEuZq8DCncExjw2OuvMAJ4QD/bFB?=
 =?us-ascii?Q?I+r5gTu27gsVTRhmWG3ryS5tgOhdk5m/B2/DrmfQ8EytiC9yXx6x3KVPCMMk?=
 =?us-ascii?Q?G8f1PFSv0cVc2guUhZF4Emss3w1PueMVskzMhAmR3Jkmcm8OE9wIeAr+h0NA?=
 =?us-ascii?Q?nMun+Srik63Ejp8+qrOSpkIAcPu+GaYiMerA4kfd+4fWhH73xI14Hi4idsqQ?=
 =?us-ascii?Q?+5asvOD2e7lxM6vV2YxE8ApXBuBtzzaoUfos1LlM2Mr32EbrypFbe2Hi1ePE?=
 =?us-ascii?Q?kHYlZfKFDRf52Y8oefrILXTvNE9OadUTAWpiZmLCfyXLDTcOcjBquu7aV2PD?=
 =?us-ascii?Q?3w04mLSGH/48QK5AjUA8Y6a6xDjfg+p79zCIAPcOxqnZqkvpQlBZt0y7DLty?=
 =?us-ascii?Q?JINzSauK1MG5N0L/S/FqY6novWrXZCR9idwX8PtSKX7b2qpJqqqj5g9FGPXJ?=
 =?us-ascii?Q?kYJF1r/EhQYEGgoXYlx1g39CfZplJrGiy9prt1cnV3W+ACPEApphHhQ3nu82?=
 =?us-ascii?Q?XXMYgd1l6It4u9YiPqlKRU7JUUlSj08R6yWctfQ5XleWNFCb0gaxQifLJ7PX?=
 =?us-ascii?Q?Omi7Avl92EZscpGrXAFjHUfIcgNZ2/f7xfAlKbzdSfnWbjkl+ThXmOPbvVJ+?=
 =?us-ascii?Q?AE08Nu9jYShXqiGHAj7a99Y3yb8A/4R1qsBZAc8Gn2qwzcrvcU8xErrKAo1Y?=
 =?us-ascii?Q?y1e6vZiZF/7eslNkuvGFJwJkjm1EIIK0pgwoocraL0qoltacMDY8GT8ypZIj?=
 =?us-ascii?Q?SxC0E/8AZNEk4k2PEv7sx5jqCQvbxte44eXNMweCNJ0Ox93MEsamldo1k1rX?=
 =?us-ascii?Q?XQbobzeTkVopBhB8kITpiae8AZKQQDYsBC0AQFSrOz8/dzGqmqn6CtVuSzgv?=
 =?us-ascii?Q?mcN8lvilA6BWBZT+15Ud0MMqIEdPHX6soAJgVeGIHS/knmdTRvNTyOlcuAUn?=
 =?us-ascii?Q?uNNNWyGY2bD/HdXd0NjCEZh/E7rPl7FKUQ6OOcaN6lCqWhmjJcCnEfaqX9j5?=
 =?us-ascii?Q?XRtwLPw4OgL9Ea9tnKvXWzXzA7R3svV450/RS3q90X3qlu94z1Y+Ruk8Fxg7?=
 =?us-ascii?Q?vZvsLQF+NLXs7HV+im7qZxZO96wP4lyVscTSrQCtNMLk1HDhRjagxaUxy8CS?=
 =?us-ascii?Q?fdW7P3HI7ToCtWPaxMdHKvuTm2k/UJ3dOnFEle7IcnVQapDUKNg5D7Jqat6n?=
 =?us-ascii?Q?wR3NGIERNjt4GPHBeh7daWxwup5jiNJWTgt1iOZrguFKPkrMZmcgE7RvCxEV?=
 =?us-ascii?Q?ChqAxZ8OZC5/x5v/sJkgGDPR/rsaG4VnN0ksVFWUwJp4ksE7MS6RKoxN7AUU?=
 =?us-ascii?Q?m4BISURg8ZoGziiOqUfsHwE6SNy6HmIiTO2M7ZD5Gv59ScklWKrfI6vX7bnO?=
 =?us-ascii?Q?yp1pnA9LatQj5McqHEZxZXYeXahatpC2gNDhGtbeQiOUEYitU6Btg3AepANH?=
 =?us-ascii?Q?oHWt0rTfuzChAP8XkX8IAQSC17KQX1/SZ5459Y1Mgy5lsj+HJG/Ti/VtIgk5?=
 =?us-ascii?Q?phoRAiKEwGwyvT7UWSGxzIzZ6udPL5mp6yqyOuusuyn7ABp1eG2c8M5u7sHG?=
 =?us-ascii?Q?nOHugYb6NTaSexvh5pz5USA1h76Nk+/bBSRcrW9HuGawdYRv9NrBP00ej0oQ?=
 =?us-ascii?Q?jM3phQ=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB5112.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7b47b77c-3f4d-4f00-db8f-08d9b96d677b
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Dec 2021 10:36:18.7394
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: XsqfvTzEMtjktidHCqON/uuiHQ+lNE5+H3TWCSgH++Km5MZWoJo+L/fdpAU6RB+F1RJ1YFk3pbEyzQnD3IXJNwKEAjOiTf/U+OQDEi/6E8M=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB4853
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi John,

Well I could see this kernel panic [  126.843958] RIP: 0010:pm80xx_chip_smp=
_req+0x1d6/0x2e0 [pm80xx] with respect to existing driver on my current sys=
tem x86 64bit after enabling the following 2 kernel boot arguments:
-intel_iommu=3Don
-iommu.passthrough=3D0

Post application of this patch,  now not observing the kernel panic and dev=
ice discovery happens smoothly.


Thanks,
Ajish


=20

-----Original Message-----
From: Niklas Cassel <Niklas.Cassel@wdc.com>=20
Sent: Monday, December 6, 2021 06:54 PM
To: John Garry <john.garry@huawei.com>
Cc: Ajish Koshy - I30923 <Ajish.Koshy@microchip.com>; jinpu.wang@cloud.iono=
s.com; jejb@linux.ibm.com; martin.petersen@oracle.com; Viswas G - I30667 <V=
iswas.G@microchip.com>; linux-scsi@vger.kernel.org; linux-kernel@vger.kerne=
l.org; Damien Le Moal <damien.lemoal@opensource.wdc.com>
Subject: Re: [PATCH] scsi: pm8001: Fix phys_to_virt() usage on dma_addr_t

[Some people who received this message don't often get email from niklas.ca=
ssel@wdc.com. Learn why this is important at http://aka.ms/LearnAboutSender=
Identification.]

EXTERNAL EMAIL: Do not click links or open attachments unless you know the =
content is safe

On Mon, Dec 06, 2021 at 09:42:23AM +0000, John Garry wrote:
> On 29/11/2021 10:46, Ajish.Koshy@microchip.com wrote:
> > Thanks John for the update. Based on the given issue,
> > we never tested on arm server.
> >
> > Further arm testing will depend on the availability of
> > the server.
> >
> > Meanwhile will do further test on x86 and update
> > on the observations.
>
> Have you tested on x86 with the IOMMU enabled? From my limited experience=
,
> out of the box the IOMMU is disabled in the BIOS on x86 machines - that i=
s a
> very general statement. But this is not just an issue specific to arm64.

My limited experience tells me the opposite, that modern x64 servers
have IOMMU enabled by default:

E.g.:
https://www.dell.com/support/manuals/en-uk/poweredge-r7515/r7515_bios_pub/p=
rocessor-settings?guid=3Dguid-ec36d324-4f45-4bc1-bb51-de2db7cc5cd9&lang=3De=
n-us
https://support.hpe.com/hpesc/public/docDisplay?docId=3Da00025662en_us&docL=
ocale=3Den_US


This driver not working properly on a system with an IOMMU just tells
us that the number of mainline users of this driver is very low :/


Kind regards,
Niklas
