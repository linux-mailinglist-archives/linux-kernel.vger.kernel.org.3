Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C27C14664F2
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Dec 2021 15:13:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347080AbhLBOQm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Dec 2021 09:16:42 -0500
Received: from mx0a-0014ca01.pphosted.com ([208.84.65.235]:43202 "EHLO
        mx0a-0014ca01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S239646AbhLBOQk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Dec 2021 09:16:40 -0500
Received: from pps.filterd (m0042385.ppops.net [127.0.0.1])
        by mx0a-0014ca01.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 1B2DZsst023312;
        Thu, 2 Dec 2021 06:12:54 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=proofpoint;
 bh=yw6p0fn6aENJV2sIfXFNi2yulY1kj7S9xRXZ2s/1L9U=;
 b=WEN0GFgQTgkAxuN7jDw0lz4kNSNyABWF7jVcOVamj3T+1cjw2oes7XymaBuxNx7aTskC
 d6zWuauSbDU8vNLjVLAX7b1rwe5VT72IqiMAWKEH2m2zwNoqEhFo6wsYLISfQRcCtUmK
 a4JALHRaCfkSw8VZ4aFWXw53KjbBnTDKYySksH+T6n7BB55vFIxoctsVx2TnpioD1Wwt
 HpJnD3hMbm+ZSWob554wl1sc41AP4raFfeAdCOZ7G29cfSz0TO9Plcr6YIPAOyLgnK7+
 3SsNFiYOMXHufGdb8ahY9HqNIqMd0N+KuczN5jUx9BnRUG9Nfga0UhzuFsvXFZrQPPLn zw== 
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2170.outbound.protection.outlook.com [104.47.57.170])
        by mx0a-0014ca01.pphosted.com (PPS) with ESMTPS id 3cpqkmhqs8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 02 Dec 2021 06:12:54 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jXwGxiNsz4NowGsazbTuiigrZxBa9Eq5lCnCp+qN3nxBWL5pNLh6Tjxxqgh+WjucVLwP0xMuXZ8ENbjXjJQTiVSUwAuvfjXf8No0Of+1hc29lYaFIp28ATDieHHR8PHvyJPNFxfG5tSSuFz5kZVvIQ8GbA4UScazY4wVdV3vk5WAHTJi0fU3V22ynaaULHBl4gNo0Qd1WXi/eAoQJ+gvF+ngV+egdzxu0pz14DU5VDgmIdhunHG9lAMnCE5U2cAqQEDY3EyNoDKe3pmpSalNSGMCq1/x0gJKPqoAZ8fDFW8fmw83PUTN9UBf/pRTDD21WwNff4bpTmHJtVKa1IUr2w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yw6p0fn6aENJV2sIfXFNi2yulY1kj7S9xRXZ2s/1L9U=;
 b=Jz0uQU+dF0rn/7G5Ss5hptnNMnFFyHjdckzRkZDy/AXlRe756QuJS7Cijd8BALG9iSwtVcLnTkH2F2quawE72as07Dth/h3GPotZXmOy7jpoGZXnt73/qbm1bXB+SdRTafVqrO03VVJcpCnqna3b4gi5RX0VoBSaVnr4mfsxGxOzssoWjM59f5qNx07FL2MzB4a3lZzAZ0f2+ROIH5w0TaMJXXet0JOEEASax4YNvXPSd3ZH9B8Nu2wPdtthwp54t+IJoxoAZWyzm464Bh1V/V1gwIkHeVSv5rDhZOe5HGuR5JcV8VMal8YBlN5gy/70+l4fc/QK/8iZZCsTgWCcoQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cadence.com; dmarc=pass action=none header.from=cadence.com;
 dkim=pass header.d=cadence.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yw6p0fn6aENJV2sIfXFNi2yulY1kj7S9xRXZ2s/1L9U=;
 b=afCratwBlvn5IrlvOxbVlOaA1k1cwRMgnuJJ4qvPrPqv3AQlD5s1pKMNxjgjv4W5X7oPcY7HS8X3eYfro7UdTZoWgn0FFmh3i1zyPZ6RNURhmJRhGUAMtj9qrYhZFusBHbSK2+TXKslw98UDLrC0p2vtiMAiyEMkyyz0GQwKdLk=
Received: from DM6PR07MB6154.namprd07.prod.outlook.com (2603:10b6:5:17e::20)
 by DM6PR07MB6489.namprd07.prod.outlook.com (2603:10b6:5:1c6::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4734.23; Thu, 2 Dec
 2021 14:12:51 +0000
Received: from DM6PR07MB6154.namprd07.prod.outlook.com
 ([fe80::a15c:c860:703d:3017]) by DM6PR07MB6154.namprd07.prod.outlook.com
 ([fe80::a15c:c860:703d:3017%7]) with mapi id 15.20.4755.014; Thu, 2 Dec 2021
 14:12:51 +0000
From:   Swapnil Kashinath Jakhade <sjakhade@cadence.com>
To:     Vinod Koul <vkoul@kernel.org>
CC:     "kishon@ti.com" <kishon@ti.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "p.zabel@pengutronix.de" <p.zabel@pengutronix.de>,
        "linux-phy@lists.infradead.org" <linux-phy@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        Milind Parab <mparab@cadence.com>,
        "a-govindraju@ti.com" <a-govindraju@ti.com>
Subject: RE: [PATCH v3 13/15] phy: cadence: Sierra: Add PCIe + QSGMII PHY
 multilink configuration
Thread-Topic: [PATCH v3 13/15] phy: cadence: Sierra: Add PCIe + QSGMII PHY
 multilink configuration
Thread-Index: AQHXx2bHmQutwPZ9l0Sv3BSHrxD/16wQu9eAgAG6aaCAAXB/AIALkHAQ
Date:   Thu, 2 Dec 2021 14:12:51 +0000
Message-ID: <DM6PR07MB61549C25EBF70ED2639FBCF6C5699@DM6PR07MB6154.namprd07.prod.outlook.com>
References: <20211022170236.18839-1-sjakhade@cadence.com>
 <20211022170236.18839-14-sjakhade@cadence.com> <YZxyja2xEkpWvStR@matsya>
 <DM6PR07MB6154FB5EB84B7BE063965619C5619@DM6PR07MB6154.namprd07.prod.outlook.com>
 <YZ8aygJQoxie+Ddn@matsya>
In-Reply-To: <YZ8aygJQoxie+Ddn@matsya>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-dg-ref: PG1ldGE+PGF0IG5tPSJib2R5LnR4dCIgcD0iYzpcdXNlcnNcc2pha2hhZGVcYXBwZGF0YVxyb2FtaW5nXDA5ZDg0OWI2LTMyZDMtNGE0MC04NWVlLTZiODRiYTI5ZTM1Ylxtc2dzXG1zZy1lY2Q1ZmY0ZC01Mzc5LTExZWMtODU4ZC1jOGY3NTA0NDIyZDhcYW1lLXRlc3RcZWNkNWZmNGUtNTM3OS0xMWVjLTg1OGQtYzhmNzUwNDQyMmQ4Ym9keS50eHQiIHN6PSIyNDEwIiB0PSIxMzI4MjkyNzk2ODE2NjA1NDQiIGg9IkxXcW11VU05bTExT2Nac2pmUDNiV21TZGpkcz0iIGlkPSIiIGJsPSIwIiBibz0iMSIvPjwvbWV0YT4=
x-dg-rorf: true
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 4f57cf76-3f32-4f9a-10ca-08d9b59dd3dd
x-ms-traffictypediagnostic: DM6PR07MB6489:
x-microsoft-antispam-prvs: <DM6PR07MB6489141E03289823E6E914AAC5699@DM6PR07MB6489.namprd07.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:4303;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: RLNL8JRoyahrGP6s4O816wq+LeL6heR7a4foaiJDEV93aQsiCXa/HgJs8qIJ05HsfcWqln5hyzbqoMC0VAjA2k11YxGqV1KptK64Z7HO1q+YSu5rz1+wqOtIp1/AHttLc4K4YYYh63i54i2dbrUJRXT+N3K6Ah5blLWgkpyGz765S0UbpZ/mxsiwQLB7wIOg8UztmV3SQ9QEAKw7gA/n93cBXjU+I5cbFtXm3Redub1MMugO7X6o4xnGqgUdFdz8uqRixa1BEWlDAgW4ZABwweXJgIsZSb7F4uz0CjT5cMwAe8v8kKYRVSsL6jOifSbX8UmBfhSaaDorSzAmqMUd/lSmZToSWOLTCyetO4UscF03PlsQf2f7BeyaBjI6BwsgFrQKuTD/+T7LuTU53lXBSxJ7smBkMFfp8TCfLdxwflG+56UnGYQt/jLte4BHmRPjbqfOvqqDrSIw8ITONfGVvdyJc5/gH/tkRsmABr42LA+0H5ODpcRIpTyYE5fi3eK1nrx3ekVGHDIPrb3LDxJuRkjtxw9VGVvK0mG5rRizy6FhvPEXXiDh53OJmXHelCqTIWl0G2aGdV8hzwdOwETPpUu00uBKRSDEGYdCwtyuYuwfBUlsLF4wAa9nNfimZYLTImdPHFTLpT+mTj3gj0K5R2D38+g8fLvUbHE60o9UTGZ4FVAqoLA7gz6jvtNlWBHD5ftMjVTY5YoH+aGb4WBGS7XwzZF170j0OTfA2Q8aiBLXdAr4elpcIGTD9GRw8e8K
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR07MB6154.namprd07.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(36092001)(508600001)(55016003)(33656002)(52536014)(122000001)(2906002)(53546011)(186003)(5660300002)(7696005)(64756008)(76116006)(316002)(66476007)(54906003)(66556008)(66446008)(86362001)(83380400001)(71200400001)(8676002)(4326008)(6916009)(26005)(66946007)(38070700005)(8936002)(6506007)(38100700002)(9686003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?DyaJm5vujDPMe+yer/1OaPkaRoeIXgtyRVB4nYHAK3+yS0WDJ2JuF/aWcNJn?=
 =?us-ascii?Q?LjLqotj/gusvJpsngTkGpXjuVGrNnUsQkbUyv+GD4/g4ibDVSE2dOPmO/xEx?=
 =?us-ascii?Q?kIu+tQpkEhlGpHjmNk8caUQ11rGIap2ckDS7DWrWqpjZO4NbNXMFYxC7NTI3?=
 =?us-ascii?Q?GVHy0f7V2Y15zlbZBuXVVEi/sVjFUUNRoMqms0APVXrUSrYcQ7AIFbOrvYvk?=
 =?us-ascii?Q?qTzBIOxUGqOF8NMa0VNVrOzZLJUCokcLILm7jsO8uKSgSOWKSL4JVfxwk26Q?=
 =?us-ascii?Q?wJqtcxdGrBrCqLbsu0ly+Ym+IiLXNFCVLLAjry735LdDAFDGlPH62GQc2OlN?=
 =?us-ascii?Q?IkYtJEgNyX4ZXj42JLHEXHmHIqJ/Y5u+3feRmNbxwBr9vgusy9GXQoZX9mmq?=
 =?us-ascii?Q?uU1p8C95YfYfSGKNXOPsOFfphmZuida2D+X8Z78TdgCnDxZbLdspp1ckcF12?=
 =?us-ascii?Q?1VnjCVM0/jnmAO0GdPUKt2b+4x24eBH4W/ENCtk+A3VGlROdFNeuvs4h/dBQ?=
 =?us-ascii?Q?V23g7U2ln/YImAje2b1yut863tUWbR3zX1Gh5Qmeb2aqKNYAlji8oI9GAT50?=
 =?us-ascii?Q?jq9ozfKVASvDPFikRlTXkNMQ89tJCsZ6WSaPpa0wN5cv4U9vWbgD1VeVd5yJ?=
 =?us-ascii?Q?XjDGToLgKcFVuYm8iI84a6FAbi7CGSYYnB20gN4K/xIPIONWzFi3SRg6B4qN?=
 =?us-ascii?Q?wHRw9mr+zaxCoWQLjN9PRZdSh10jQMtInCfP8gjWlDxGQsTvCcyMfN/pTeYK?=
 =?us-ascii?Q?ibW6q0wEg0etpAmDZ5Kb7aDn5iee6hJ25XZv7hIWLFQCQu8nkUH5FwE99X7C?=
 =?us-ascii?Q?9k6UbvFqSQjuRUoBG7OInZS0KqC6wjuSlByyxz4/DjpYgia9GUNL/5tWGhUr?=
 =?us-ascii?Q?zVkxiPTF/k5GNdo1roOhqEp0XmXBQjux9qz5uiwvQ4b93Kjj93Qzi+2U3un4?=
 =?us-ascii?Q?bY16bgjsQ7RQXcPRJMeMR4t4sSKhQggwozQz9pipwg5Kuqvs5rXX7P9/UVtE?=
 =?us-ascii?Q?utZKz3tETQtPq178cogQhagmfRVhqjw/972T6ndnJQn9E6mirb5il9WK50Te?=
 =?us-ascii?Q?CH4kwnnCLZ0PXYKMevXrunsM+8psLBCTvovDjFOotPdwf5lkDqCxMRAq0Ljx?=
 =?us-ascii?Q?T1zbQQeUHFUUsWEKMGB5bBhVZDC1gZkFxzdas5q48jipJAYtyRYP6hOKxapQ?=
 =?us-ascii?Q?bVTXYyPLFpSK2b6VALztQBILWijcBkiaCC2ZLymfTuchaO3XFFOJoJ+dfSNx?=
 =?us-ascii?Q?99rYUYk8kSzU/RLmnh3iZMnoSA4nYTU3zoHWMv/31EcmwbEja4UI6TC4H8c9?=
 =?us-ascii?Q?/b9oaTShhB2F0flhhQLeCc0WjRtdVz+r/9lnuzGsEY97jTQ6Sk7RTOnKl1Hr?=
 =?us-ascii?Q?KcvuZlvhUWr1+p0tTDMjAQGMFiPfOC3u6AVDMTPKc0c5N8rHEaOD7FDrS1xt?=
 =?us-ascii?Q?TuOPxAR2qU6SwDJrQzrcT6e66eb9XEfOlVdBEbx9VRVpkamzu8j8aJSMzEXq?=
 =?us-ascii?Q?20xyt6mvs4lwkOo9AQ6DlEJb0o7Q+82Uwk1TZnJCsOhndGJCbHXpW8pdjF0Q?=
 =?us-ascii?Q?ty+9C0y6QQfjkQFYHjUX2jN80be+r/32AAbPN9W7ZcpJy+Fgic2lNa7GvC+y?=
 =?us-ascii?Q?c127ZtRkFSoNZGoDaMW4vlUD+qvW/G2hLtsAzyUdUs81W2TIU0vzYMl50U6p?=
 =?us-ascii?Q?z27MZg=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: cadence.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR07MB6154.namprd07.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4f57cf76-3f32-4f9a-10ca-08d9b59dd3dd
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Dec 2021 14:12:51.7929
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: d36035c5-6ce6-4662-a3dc-e762e61ae4c9
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: nfEoEw+XLD9n3kO2M2nYhyyZX5TbhsfZer3zjJpYb9AsBlNLi9gWacOPQnUZ0BiOWRF/Xfjq1+NGol8uFaQB4pHYPRkovDvfv1tYrF/ghoE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR07MB6489
X-Proofpoint-GUID: AaAx8osbaY56XjqM36YtqeCRcbf2-VUS
X-Proofpoint-ORIG-GUID: AaAx8osbaY56XjqM36YtqeCRcbf2-VUS
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2021-12-02_08,2021-12-02_01,2021-12-02_01
X-Proofpoint-Spam-Details: rule=outbound_check_notspam policy=outbound_check score=0 mlxscore=0
 bulkscore=0 adultscore=0 phishscore=0 lowpriorityscore=0 suspectscore=0
 priorityscore=1501 impostorscore=0 spamscore=0 malwarescore=0
 clxscore=1015 mlxlogscore=632 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2110150000 definitions=main-2112020093
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Vinod,

> -----Original Message-----
> From: Vinod Koul <vkoul@kernel.org>
> Sent: Thursday, November 25, 2021 10:41 AM
> To: Swapnil Kashinath Jakhade <sjakhade@cadence.com>
> Cc: kishon@ti.com; robh+dt@kernel.org; p.zabel@pengutronix.de; linux-
> phy@lists.infradead.org; linux-kernel@vger.kernel.org;
> devicetree@vger.kernel.org; Milind Parab <mparab@cadence.com>; a-
> govindraju@ti.com
> Subject: Re: [PATCH v3 13/15] phy: cadence: Sierra: Add PCIe + QSGMII PHY
> multilink configuration
>=20
> EXTERNAL MAIL
>=20
>=20
> On 24-11-21, 07:33, Swapnil Kashinath Jakhade wrote:
>=20
> > > so this is pcie->qsgmii ->ssc/external/internal ... ok
> > >
> > > > +				[NO_SSC] =3D
> > > &pcie_100_no_ssc_plllc_cmn_vals,
> > > > +				[EXTERNAL_SSC] =3D
> > > &pcie_100_ext_ssc_plllc_cmn_vals,
> > > > +				[INTERNAL_SSC] =3D
> > > &pcie_100_int_ssc_plllc_cmn_vals,
> > > > +			},
> > > >  		},
> > > >  		[TYPE_USB] =3D {
> > > >  			[TYPE_NONE] =3D {
> > > >  				[EXTERNAL_SSC] =3D
> > > &usb_100_ext_ssc_cmn_vals,
> > > >  			},
> > > >  		},
> > > > +		[TYPE_QSGMII] =3D {
> > > > +			[TYPE_PCIE] =3D {
> > >
> > > now it is reverse! qsgmii -> pcie -> ... why?
> > >
> > > what is meant by pcie->qsgmii and qsgmii-> pcie?
> > >
> >
> > Multi-protocol configuration is done in 2 phases, each for one protocol=
.
> > e.g. for PCIe + QSGMII case,
> > [TYPE_PCIE][TYPE_QSGMII] will configure common and lane registers for
> > PCIe and [TYPE_QSGMII][TYPE_PCIE] will configure common and lane
> registers for QSGMII.
>=20
> Then it should be always common + protocol or protocol + common, not
> both please! Pls make an order and stick to it everywhere... If that is n=
ot
> possible, I would like to understand why
>=20

Could you please elaborate what do you mean by
" common + protocol or protocol + common, not both please!"?
The order is same everywhere which is common + lane configuration for proto=
col 1
and then for protocol 2. For multiprotocol case, PHY configuration is based=
 on which
protocols are operating simultaneously. So e.g.
[TYPE_QSGMII][TYPE_PCIE] -> QSGMII configuration when other protocol is PCI=
e
Which might be different than
[TYPE_QSGMII][TYPE_*] -> QSGMII configuration with other protocol.

Thanks & regards,
Swapnil

> --
> ~Vinod
