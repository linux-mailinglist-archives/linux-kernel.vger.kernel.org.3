Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 424EF4696EA
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Dec 2021 14:24:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244417AbhLFN1y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Dec 2021 08:27:54 -0500
Received: from esa5.hgst.iphmx.com ([216.71.153.144]:41153 "EHLO
        esa5.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244379AbhLFN1x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Dec 2021 08:27:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1638797063; x=1670333063;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=XRoxFR4KPzyeCMbryugGkkOX81ojQJO554S+Ipxja1Y=;
  b=HMzDoxLlH+IJ5wvU3oibO1UteK/d9P7ArXrr0sl5SUBhPIPHRpMnG/TZ
   A6IzTey23OaRu4vcQoPaDzx6sW+46zyEIBFb8PLNOwlWajTROAZIqFeB8
   MXXOS4fxRSSm50FYpV2Qc58oSQymPxDMkHBQ9a+Xb7zxx6gmrQ7M4luvB
   Jy+cOKBk9OIIzij6zbh0rwYqNC/08wb7ljNVkiINf6CvsGhcj3WSUPK2o
   k6hRU+yWDQ1CMVPOTplf5bylqAY//1WOJ1afCubfMzDILFSxQ5DklzkUI
   BxOaQZfklGXPTG/rL/d6xfGsD4zTmNRazwH2RzdB+VmkgkzIQtx+GOY8Z
   A==;
X-IronPort-AV: E=Sophos;i="5.87,291,1631548800"; 
   d="scan'208";a="187561195"
Received: from mail-sn1anam02lp2049.outbound.protection.outlook.com (HELO NAM02-SN1-obe.outbound.protection.outlook.com) ([104.47.57.49])
  by ob1.hgst.iphmx.com with ESMTP; 06 Dec 2021 21:24:22 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aKSpDNncMQDUtulBMbYuFqHawpkZ/8rjIAPHSRiammLxKn1Vwwo7sPXADWfD37Mni+fVsxwZr1zqXAjGY8v7Io7ozvfZrjskQruJcgpQE4ubmqWLSAsFNxImnpgbp3b+v3X+bQYWsi7Yb7dMlP/mfeQPj+N2BuAw+a5aOQX5QDT2FG4vSP74DPPBirl8fGaApK6mBKR2SldmRkZI9dwOEe/IFgoWzcIGDQA9PSvuB+JXowLOTlSANI5/vd+isz6CoXI//kfydgaryPNo5xpO328ICyimWcOV16JqVcQ5eftfjgcK/wJGi/5NSrficEYXGyyXAcbM04mHHpl2jkpUoA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XRoxFR4KPzyeCMbryugGkkOX81ojQJO554S+Ipxja1Y=;
 b=B6ugJDZHmmW950M+QQedmTf2wRIbKOQgsMeCK9Ru+FhBqmpTXCruAn5A4hf9P14M2CVshWWnvclKY1CxGmVOU4Nf6PXEFELGwajazGxTNqCQrHKPbZW+8K3CR15rGJVCE3NXy+gnvjkHPU6WF36RKgXuk67HHeNcHNrJSd3BECEDPSoIRf0y/JdIDdg8EVJtPPGvqq6ZAyhwH+j4KaF4k6NW8/PEX7K5GBZo1bJVQ002F3SE2wwKSL+mSCxMV3/npYZB3SJ2x/AMRUlNWHKkZsjk3qzPhTu3vHXU3UY+YUpJf8mql5mvBuzxKdRbIDe6hRR3krt1XOzev/ew/xoICA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XRoxFR4KPzyeCMbryugGkkOX81ojQJO554S+Ipxja1Y=;
 b=ENaeTjx7yPt7nS5Kp+2dpCY9joohKg94h6zrwnjR1VfeHH8BjaMPp5conNYeqg6jTH0yhtMVcT6PKbVJb3tMaAFUwuHBsgHKKVpX1tCGi8e7IZNIhgme1pQfVwD8Qmo9O5OK+B7PaelDJixnPEjQIIQ5H9IQL2L4Wk7cV65A744=
Received: from PH0PR04MB7158.namprd04.prod.outlook.com (2603:10b6:510:8::18)
 by PH0PR04MB7334.namprd04.prod.outlook.com (2603:10b6:510:b::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4755.14; Mon, 6 Dec
 2021 13:24:20 +0000
Received: from PH0PR04MB7158.namprd04.prod.outlook.com
 ([fe80::c504:3d44:5aef:f3ca]) by PH0PR04MB7158.namprd04.prod.outlook.com
 ([fe80::c504:3d44:5aef:f3ca%4]) with mapi id 15.20.4755.022; Mon, 6 Dec 2021
 13:24:20 +0000
From:   Niklas Cassel <Niklas.Cassel@wdc.com>
To:     John Garry <john.garry@huawei.com>
CC:     "Ajish.Koshy@microchip.com" <Ajish.Koshy@microchip.com>,
        "jinpu.wang@cloud.ionos.com" <jinpu.wang@cloud.ionos.com>,
        "jejb@linux.ibm.com" <jejb@linux.ibm.com>,
        "martin.petersen@oracle.com" <martin.petersen@oracle.com>,
        "Viswas.G@microchip.com" <Viswas.G@microchip.com>,
        "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Damien Le Moal <damien.lemoal@opensource.wdc.com>
Subject: Re: [PATCH] scsi: pm8001: Fix phys_to_virt() usage on dma_addr_t
Thread-Topic: [PATCH] scsi: pm8001: Fix phys_to_virt() usage on dma_addr_t
Thread-Index: AQHX6qST8eOxJfqT20yZh1HFV7vkWA==
Date:   Mon, 6 Dec 2021 13:24:19 +0000
Message-ID: <Ya4PAu4Xj8UGHEV7@x1-carbon>
References: <1637940933-107862-1-git-send-email-john.garry@huawei.com>
 <PH0PR11MB51123148E4932FE1C64F8052EC669@PH0PR11MB5112.namprd11.prod.outlook.com>
 <a60318ef-dc19-a146-5ac3-16eae38b8c37@huawei.com>
In-Reply-To: <a60318ef-dc19-a146-5ac3-16eae38b8c37@huawei.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 840f6252-ba33-4baa-5191-08d9b8bbb604
x-ms-traffictypediagnostic: PH0PR04MB7334:EE_
x-microsoft-antispam-prvs: <PH0PR04MB7334FB620E8A85625DE4D1DDF26D9@PH0PR04MB7334.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:4714;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: tSqE5cOcGaAoTao/QLTgV272nc/P6s6aYVtV/wecx8tq+moNDVICLBY73KX6lOZ81tqKjc/nqOqo5JeI6BezKOAaDkTR5l9QOGm3eoLOx9M6ZtmYS8B+ul+xQ+AFWQ56KpYhM2zx5c+ZjqL0m2L195lddVUkxGWbRfz8/RsVgepUwCeeqOoR8gyLWV/lM370p5RqDPfNg1GIm/XlBEBs+uh8NEnMi+Nrg0PH8vD9y0MR8BJaWDoagymKP8EL0bnHrEaFCCtpLUK+vaODGW7YBys4bgs6Qs00ppOk/crC+ieRNb8ZClGiNewZs0a11EjZhSFH6EP4TDgiWBLkPa4jJONyqVeYcnL0LMbZE0fQLI8S57KliOdLTUIfNj/gakArvig63+OJL82S8scnoIDBI7G6jAXWKo8DuwgadQ6JkSCwLw8XZ/Xhoi69VWsBD54QdHAKxXWHKqRd7GxHqLyKG7HzdRIEJBVOQWRFtsXonT/SD18StZfZ+mNbYLw/1mKKOkfAwlO6nW+fLmwvppA9k9HFSBgZPpFXDWwFjpjAkNwW10WzmUKKmu5PnZlmQfrlfPc4zWQ3SxAkpfU2zzD82UjL92fJ3aaTRItnBUpzUbNvsEILxD9ftZGwyVZSg33AW1fBxROFLDiLghxSxVWXUDrB5CMbUQGktS47aF+esaFXr8ZgNa2RLkjUc3ubMsFpuODBtNNidRo3Bxn7jJQaiRZd69TTLHoxrhz09gJoeJSYgLhtoJsIu0dUJMXn1tweQsNmBfx/jnJloGbvTq+WeFN65kbLie439AccdqGSL+8=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7158.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(7916004)(4636009)(366004)(83380400001)(33716001)(38070700005)(966005)(53546011)(6506007)(8676002)(508600001)(71200400001)(186003)(64756008)(76116006)(91956017)(66446008)(66556008)(5660300002)(26005)(66946007)(66476007)(2906002)(82960400001)(54906003)(9686003)(316002)(4326008)(6512007)(122000001)(38100700002)(6486002)(86362001)(6916009)(8936002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?HNmzmR5CKcCAgiUuK1JLzZlWYqn21LLFi7o9NTMMxJAba01rOYsA9auPiEk2?=
 =?us-ascii?Q?mS+hm8/XdfCezS1utpVebD5gaBvG0HAd+7OzlPseegYeRHrdCNM7oj5CedGV?=
 =?us-ascii?Q?uqnAxGTnxAbLlWvgPV2s9yLI2MzgRrN2ZrswN3nujdNmsLdZCTkVul1OIhlC?=
 =?us-ascii?Q?javlKIq0LaZfjckFwzh/KX3kbV3CJiLURH+/0/0WDbP7JnsVHJo0PQ4R1rxs?=
 =?us-ascii?Q?dHlWZx+S8WWxBE8q0+Z7r3HOxM6TMnQdv8uthtC2+tYRil3CgMkiyk0Cr6j3?=
 =?us-ascii?Q?1w9z0Q+FLI1L8Y7ZMckaIV2JrqvIPJlgorFcR/34gPav1qzAHTvXMr8VJwrR?=
 =?us-ascii?Q?5nr2nwHF759WVOwclQz5Hh4wSdyOt4mDyLXr0Ml326O93XF/L/+TBH306fX/?=
 =?us-ascii?Q?u6ahFqkCHaezbkh6IaEoVi27IzRZpubhXLgMOzcWRAHUwvsyasU+xjUA60d+?=
 =?us-ascii?Q?F/zCpn1WFpvs+mwAATUCHx7cXkNX8Edxy66uNSDxKSS9f1M1kuapQQG9mUCd?=
 =?us-ascii?Q?RR6D449kZOU3aD6+3HbMBSqHvPFqalmdEHwKhuT4/c3qMg3a1k7ICCOjSYmx?=
 =?us-ascii?Q?08IU2Xe2Ihi4cozyjuDEu5wFyPH1VaNri9FeX8eMAwz5ykNhsFw9ZMYMAMOu?=
 =?us-ascii?Q?osb20iudBbVU/dHjaZmdUnvzWvcIsmaMTjWoTuaaKg3QrvICxsHN3Mx86QAm?=
 =?us-ascii?Q?MWCcVMVre2am7V3Hlc678tshTZ+dn+vCNxmLL2k1sJV936RaVzKz/JCfhbIf?=
 =?us-ascii?Q?Wgq7x27dOJhkCHL7Z9kzv1l6q64BsenrcQmTK3lqDJ/CvsSdMeLkora+aSKv?=
 =?us-ascii?Q?/50UqlKCXbUDHmB0DT7CgCeFQS1GV22jTKyDw4sES7Dyb2qCGnl0xrOiqt9L?=
 =?us-ascii?Q?+i5LogxxBwW8mR5D6Bx86YV3qmtxNUWHDRbrT0TL362s61EZaB1ZppQGR2tk?=
 =?us-ascii?Q?KSI/pH3nzwgGRLrOrED0KWa9VyqUdcPSeYutaZIctppObYdED1zqcyNoamr5?=
 =?us-ascii?Q?HYArtmIYOefAMxjOOIGU08JnZ8VR/ec/VWl6ocwzeqAzAs9xmH/9C62anQFz?=
 =?us-ascii?Q?2JkUpd5g/GxNoDBdl/PnU0Nr8C6TqOZdDrGaC5OKT4QR2VdpeLrBFcv9tzIi?=
 =?us-ascii?Q?Tm6lLFum3nkUAR89M40fjwMJlL8hhlrouwSaxq9Xp3Vf5T8dWHQmWCtKYtPp?=
 =?us-ascii?Q?X8jOyqpcaSjsz4e4V9YBfTR716UY/2WZctChTCVdNinr9zKJT/BOgtcY1lNS?=
 =?us-ascii?Q?0Ei+mPC0lTDB/pWRWE+DDHGrQgGY/A4K0tUIrF+tRIHW/GA2MK8OA+f+uXpb?=
 =?us-ascii?Q?JmoZwPhCstN6jGfoTkOo+Jy1e8VNRt18G7gIxjbfdJijYT4FNAyoH7ULjEsv?=
 =?us-ascii?Q?IKNftgo5dfoDZxnRZnuCmPZ1gMgbumKMjQb2+NsFkzE7T2HWHZ7Msx811kBk?=
 =?us-ascii?Q?/pw0Xylzf+RdmNbvoZjYPJ6e7CFhv6OWnChpGKEHOhs2E9eTPNggJ4O+n6hZ?=
 =?us-ascii?Q?MJqPYktn4dvnFL2rDt8E6yMc378M+qn7qmpiMzq6yfPx2TwkenOJ8Fdoz04o?=
 =?us-ascii?Q?6I2U5SfE+SB2Yjs3xmuqMrd610LZSQhecROPvKWUV61R+6+3yuRBUJlpIX1l?=
 =?us-ascii?Q?RHOlaEhJ1SR33geaxbeY04s=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <7D8526AFC5D06A43B7E073D459843E58@namprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7158.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 840f6252-ba33-4baa-5191-08d9b8bbb604
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Dec 2021 13:24:20.0363
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: NxHP4FzMVGvCoKHajX3BUbgBUETaSiIUTbD26+Yo5X/R41TNpXNjAs7oWu7s3ELd65FTM2hsHRu6OpaTkgCyzg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR04MB7334
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 06, 2021 at 09:42:23AM +0000, John Garry wrote:
> On 29/11/2021 10:46, Ajish.Koshy@microchip.com wrote:
> > Thanks John for the update. Based on the given issue,
> > we never tested on arm server.
> >=20
> > Further arm testing will depend on the availability of
> > the server.
> >=20
> > Meanwhile will do further test on x86 and update
> > on the observations.
>=20
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
Niklas=
