Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9FBB747DF0F
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Dec 2021 07:28:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242328AbhLWG2H (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Dec 2021 01:28:07 -0500
Received: from mx0b-00622301.pphosted.com ([205.220.175.205]:6366 "EHLO
        mx0b-00622301.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232444AbhLWG2F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Dec 2021 01:28:05 -0500
Received: from pps.filterd (m0241925.ppops.net [127.0.0.1])
        by mx0a-00622301.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 1BN5tXhh001151;
        Thu, 23 Dec 2021 06:27:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ambarella.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=com20210415pp;
 bh=kibEU9CtORsuP81+wj9HAF0dZZAL4XY0wvxcY4Gc3+0=;
 b=MXQyitZvA51Q6JAdFXDa/+L2hH1aCzAGUx6HY6jD92DfxMGxeIM1Cpbt9+pcFud20zOY
 NpekSURN00ApOW0KAwapHGIq0xiIf7Jhtmi51/v57ZCFRif+0VRZS3BTFYuZnvNI7ihX
 /B84O7CknkA0Ob6wIvZl0cfZqOd2QDdqlUHtqrJMB6GtdDG6J29Z/3hQhV7Hnswbuwtk
 Bt3GcE6vZFyn99etJS1xsm7TnIcPR6gMB0JHfn7bCROl+H8ZXtBvc5YnaLYMytQ5XRv4
 5oV8bJHBqxNZgFLqWzo+W63qvahNtXv82CURoRBykGVCuG2aP0GBQKno1O7MS4IhQcW/ Lg== 
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2102.outbound.protection.outlook.com [104.47.70.102])
        by mx0a-00622301.pphosted.com (PPS) with ESMTPS id 3d3ucggj43-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 23 Dec 2021 06:27:43 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=abtIiaavgRxjSfEO23UDa1SeEWPUl5y4JEgCe2w3NUvGUhC07nB6SWXFo5BEuHSFVjYKgz3bLd/wSyuqEuZO8qD9oubZ0leJfWIwXCPY6UkEvR9/djANtYFCCkUTGcCMzVgfAJnzWFW28OUN6Ax7fSn4yM/zoW5DL4/JolQBXw5DD7McCmpMHVydJxtERKslfg005Yu4V/v7dnhZzlNU6hnc8I/YaI1NRwq/ROKYycqZEkgowbWQLirYXw5Nme3IbkWsoHpL69ywtr+bbeITImJj0eXpuoeSC/7pxBmLgENzXQg2ItySbtJQAU9qKEMLASQ7ryj4WGM8SgovDWBBbg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kibEU9CtORsuP81+wj9HAF0dZZAL4XY0wvxcY4Gc3+0=;
 b=WEAmp1UK7pbqG23rT4X2+uuCYcEFIhhPrdYXN/rALChh/flBIpao2NMTcnUKekL7DHclABr9DEq9kCToG2ITYw+o6KduzpK012qIwcZ7p45INgAXHXgZvJOx7k/msMNsjtHAnskFRLax3LUmghMkEl8orCydurzKL5xl81LB5vBYEf0SCfXygQyhi9PSNOhs55X2GymzqaFbDgah88KJkIndzd5ffegfMFciiS5E5u5dGuGg7BTwLAihffCpXc0ILIqMprCZBkOpKt8R101iO8uYSaaa7cGiVCDIz/WJJMxx6q1LE7gMCj6iysCyzuXnCrNMM6Lpo0WAcnehhOB8tg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=ambarella.com; dmarc=pass action=none
 header.from=ambarella.com; dkim=pass header.d=ambarella.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ambarella.onmicrosoft.com; s=selector1-ambarella-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kibEU9CtORsuP81+wj9HAF0dZZAL4XY0wvxcY4Gc3+0=;
 b=kLOXIR6uW5BprYZvzBQxGw7fDoSs/k4UeZLzlHPqJYIQKa+vEaXavp3GUxPRs0pSHCvbsj8Mobb1TnrGFGPOtF2+wEviquGmXMuFPN0bOex7kla51rVC6bJXLBPNHAOki/c6uRygPQ/eKC9CXlI9rdjoYTXt22If42Ru2xAqWJc=
Received: from CH2PR19MB4024.namprd19.prod.outlook.com (2603:10b6:610:92::22)
 by CH2PR19MB4024.namprd19.prod.outlook.com (2603:10b6:610:92::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4823.18; Thu, 23 Dec
 2021 06:27:41 +0000
Received: from CH2PR19MB4024.namprd19.prod.outlook.com
 ([fe80::3c65:8b89:ca42:d828]) by CH2PR19MB4024.namprd19.prod.outlook.com
 ([fe80::3c65:8b89:ca42:d828%8]) with mapi id 15.20.4823.019; Thu, 23 Dec 2021
 06:27:41 +0000
From:   Li Chen <lchen@ambarella.com>
To:     Vinod Koul <vkoul@kernel.org>
CC:     Kishon Vijay Abraham I <kishon@ti.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Swapnil Jakhade <sjakhade@cadence.com>,
        "linux-phy@lists.infradead.org" <linux-phy@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Dan Carpenter <dan.carpenter@oracle.com>
Subject: RE: [EXT] Re: [PATCH] Revert "phy: cadence-torrent: Do not configure
 SERDES if it's already configured"
Thread-Topic: [EXT] Re: [PATCH] Revert "phy: cadence-torrent: Do not configure
 SERDES if it's already configured"
Thread-Index: Adfigy5UG7A+JRfzRGOjQFvgL0E/BwVOokqAAAH7bcA=
Date:   Thu, 23 Dec 2021 06:27:40 +0000
Message-ID: <CH2PR19MB4024714657D84812E6F16A77A07E9@CH2PR19MB4024.namprd19.prod.outlook.com>
References: <CH2PR19MB4024BE31FB249744412071F6A0639@CH2PR19MB4024.namprd19.prod.outlook.com>
 <YcQIp3IJ0eki3hY2@matsya>
In-Reply-To: <YcQIp3IJ0eki3hY2@matsya>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 5a3827b7-7b20-4afe-811f-08d9c5dd52a4
x-ms-traffictypediagnostic: CH2PR19MB4024:EE_
x-microsoft-antispam-prvs: <CH2PR19MB4024C49C58C998725796CFB1A07E9@CH2PR19MB4024.namprd19.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:4941;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: T5P6FoQSXBBrGoATIQL6sePn/PsM8sOF45Il+tS6Zr3Bp8RekaIYpY//XpuO1ZNZiHPTMqTwBc/SPZmnG4X8uqaYGo0iXWfqYnd6mg7cgCjob+S4Ujm/dUJMQ82SNrWeeZycL6WrfwtODVulbU+E2l7fpC9pDnI1aM9SXmxUQAC4y0pEyniCWRTUYVasnEhwcXqtkxcjHbbHVoZ0asLd8yArBRwoOu2g9nHvHKmjxZkWJo9MoX2XriUPTNnm6n4GeXaK8OfsBICkZ5XzaA2CgedWrib404jFPcFnB7KOVnEB1LqahvJv3yXCuEIvaqUxw1xMcFoNg0t5+Z812ya+Qph6mblHIoTomALll1RF9vFHZcjRSJMTnQiOq8eIaL+Ce6H3sk959i90/66QAkkSpUhDeCJO4jeV3EXZTjJv2YWFgkIM4gcxgmVbHGZo1cKvmczBocF1M7Y6TMO3JJL/BiEFPL54QJfiOd8bUTXszQgUtTWGcbA/5M7x31u66ZDb7RIoko1ZCM3oAycbcKXSTjobls7ySr/xmVAtF9nEGpyUcDzT5o2JEeCVhN0agQHQC4/H7UNTBvJCbJcteJHxcFoztPJ4hhlerEhAc5Xs0PRiu72dadasKlKi8wUHoHliCLglc7ec1BzB5Hi3m8C5rg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR19MB4024.namprd19.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(26005)(88996005)(52536014)(8676002)(86362001)(122000001)(54906003)(316002)(508600001)(8936002)(6506007)(53546011)(83380400001)(33656002)(186003)(2906002)(55016003)(5660300002)(6916009)(64756008)(66946007)(9686003)(66446008)(71200400001)(66476007)(66556008)(4326008)(7696005)(38100700002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?sWgKltkoa6hRBsll3FqCDSaHyNCGPmW9e4gZYQUQQdmjOiOVnlFltp3WC6qg?=
 =?us-ascii?Q?bJUMAsNW08TGb9/Yh8SpfRiHyZ3rknPUc2TV0mKD2WvZYIUgs/Dn/WaG4EP+?=
 =?us-ascii?Q?f9k32ZWLmHSKoVaSk/hCsjQrKiwG57YKAKApKE2z8AqrV7IC2jh1ka6d3nvL?=
 =?us-ascii?Q?M40fE7DLjvPpRNOwS5cJbW5eMikcipc3hJRoxxiQWF/p1llUfGvN4zK0m78S?=
 =?us-ascii?Q?N2TH2Dq7EDjVlXA2AtyF4TU5rqfeamBGNAdmqYWRwB+GW2MW4IuOsPRiRNqF?=
 =?us-ascii?Q?Bo/w+llPbm1Q4dBD0IG0dNWUwWQWuLRGcfj8wXkISwTTaTplBGmg/dTJEP4J?=
 =?us-ascii?Q?76MStJIoIM+aPqAh0zEXi0FnXTEXa5GkNOZlNZBanmPfLRXd2/kTdgnNd07V?=
 =?us-ascii?Q?xbmOI99rLvpSMfxFEHZIZDdSxTOLcILkhqSPFpl/y+GoEpNhGIByVNY3Z3nb?=
 =?us-ascii?Q?w+8ZOE0F5E76ZLGyL4rfxMx0GY27dBFD1g9/qqmwxpLTPUMaCgRtHQ23hjt+?=
 =?us-ascii?Q?NC7yZy+Iqe8GLv6KpuqvQRcLFi3N+3LTv+Pc6e6UslMghjrnt1jbfm9KhCsM?=
 =?us-ascii?Q?/4ZfT6mtJdgnnpmW21OlxAxcCzgyLKh+FJJayjeTPum7ni5iEh+5kW1WnFj3?=
 =?us-ascii?Q?/muMcyJ8hocq+PNrcjLf6a2z9rl4P0TqWhPeep54Ovd5VPsP6UNAYPVXDAde?=
 =?us-ascii?Q?aG/2S3vO1v813Q+I0vjX7sdF2mV41Njca+KrFTjxMfWoDd54pzLCl5LpWutG?=
 =?us-ascii?Q?7Gvi8cGdtLBSvorMmfTxUleZRhyh2EPu7Y6skb/n7DZlW75ZTlesrZnYa3EP?=
 =?us-ascii?Q?FSUFVShwBCvIME4BGIcNvYhbILlxgE0ZlnSpfCfNB94DGAzndZUikawir4At?=
 =?us-ascii?Q?xgy+OgoDgTYye6PDYIeqYHYnwygW5B47eUnF+SVbUZ79qdCzjb/pSyMfHmV7?=
 =?us-ascii?Q?JxkV2Eu1e2VjiLcMQ6d7SyIzl+qF6SkDipQnxDcwgfx1KvnXEdcV6UsArnv6?=
 =?us-ascii?Q?XKltqu08+tEADQppDEHNUS/Ns2aqKYAu1KbXUjeyGMns6A4+aR77Ak0pBZOS?=
 =?us-ascii?Q?aQz+7kKnKZ+uHrCXBN00ZDHE16eDJFHSBMNNpyfbCK/uC5DJpIV9mMFqt+S1?=
 =?us-ascii?Q?00qGDBJczwKE/uxn6+zkvshP4d4i6jkOMysrOaJo82AUOW40wKNNX/hiuveu?=
 =?us-ascii?Q?vTLfo5jAC123gztpV6Y7AgpoFEFDgigzun7C2Hov7zmlWRuVItrRsXfTLrl7?=
 =?us-ascii?Q?Kbrcw+IRlWgjd+ScL3a+VtAvVwP3s3TmUcmg33YPSRMGLlZIb/dakt07+1Sk?=
 =?us-ascii?Q?fHJA1NvIoy3ozEMedlZblriw5OwX4Om747Djq8mVAnuCTs1Erkb7UnHN3vEO?=
 =?us-ascii?Q?5kOux50ApdMiSdtxgvFysNbOtOTONvHePqQgDFbk83VzGNnFqBe0LmAaic4P?=
 =?us-ascii?Q?wfMFvXd5dU4E3jL/3zVKs9wpFW97R2qLl6Uvw0Ooqr6/BvnGRzNapIMk1X6T?=
 =?us-ascii?Q?qzSCRrqvmy4F0eGMZYj1tpZ6gJUTU31E5rXcd93aKXjQUSylaQLMa0OMAgfQ?=
 =?us-ascii?Q?oSOOK7invDzWVwR7P2L8BWev+p6tSC/6Ry/wsRG3HYDVXnj4ltBzdh2IoB8Z?=
 =?us-ascii?Q?uLhpmEBuHXaryMfxPtgEywU=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: ambarella.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH2PR19MB4024.namprd19.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5a3827b7-7b20-4afe-811f-08d9c5dd52a4
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Dec 2021 06:27:40.8656
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3ccd3c8d-5f7c-4eb4-ae6f-32d8c106402c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: mQCIVk7WhcP2BlVO0KpN0qsMW/XHbkL6J9EWHJF+V1mgv8bNX98o1v1X6tJKfzv86bq9gN/VghbVhqAEJ123+g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR19MB4024
X-Proofpoint-ORIG-GUID: gDil6U4NlL2plpDSbHLXsElyr10bkFI4
X-Proofpoint-GUID: gDil6U4NlL2plpDSbHLXsElyr10bkFI4
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2021-12-23_01,2021-12-22_01,2021-12-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 spamscore=0 clxscore=1011 suspectscore=0 mlxscore=0 bulkscore=0
 impostorscore=0 lowpriorityscore=0 phishscore=0 mlxlogscore=999
 adultscore=0 malwarescore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2110150000 definitions=main-2112230035
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Vinod

> -----Original Message-----
> From: Vinod Koul [mailto:vkoul@kernel.org]
> Sent: Thursday, December 23, 2021 1:27 PM
> To: Li Chen
> Cc: Kishon Vijay Abraham I; Philipp Zabel; Swapnil Jakhade; linux-
> phy@lists.infradead.org; linux-kernel@vger.kernel.org; Dan Carpenter
> Subject: [EXT] Re: [PATCH] Revert "phy: cadence-torrent: Do not configure
> SERDES if it's already configured"
>=20
> On 26-11-21, 05:06, Li Chen wrote:
> > This reverts commit
> > b69d39f68419("phy: cadence-torrent: Do not configure SERDES if it's alr=
eady
> configured")
>=20
> space between commit id and open brace...
>=20
> >
> > our soc will hang on any regmap field read before reset.
>=20
> okay, in this case the right fix would be to keep track of reset in SW
> and still skip reset if it is already configured?
>=20

I should be grateful if you would give me more details of reset in SW.

> >
> > Signed-off-by: Li Chen <lchen@ambarella.com>
> > ---
> >  drivers/phy/cadence/phy-cadence-torrent.c | 31 +++++++----------------
> >  1 file changed, 9 insertions(+), 22 deletions(-)
> >
> > diff --git a/drivers/phy/cadence/phy-cadence-torrent.c
> b/drivers/phy/cadence/phy-cadence-torrent.c
> > index 415ace64adc5c..e57e0b1523aff 100644
> > --- a/drivers/phy/cadence/phy-cadence-torrent.c
> > +++ b/drivers/phy/cadence/phy-cadence-torrent.c
> > @@ -2031,11 +2031,6 @@ static int cdns_torrent_noop_phy_on(struct phy
> *phy)
> >  	return 0;
> >  }
> >
> > -static const struct phy_ops noop_ops =3D {
> > -	.power_on	=3D cdns_torrent_noop_phy_on,
> > -	.owner		=3D THIS_MODULE,
> > -};
> > -
> >  static
> >  int cdns_torrent_phy_configure_multilink(struct cdns_torrent_phy *cdns=
_phy)
> >  {
> > @@ -2282,7 +2277,6 @@ static int cdns_torrent_phy_probe(struct
> platform_device *pdev)
> >  	struct device_node *child;
> >  	int ret, subnodes, node =3D 0, i;
> >  	u32 total_num_lanes =3D 0;
> > -	int already_configured;
> >  	u8 init_dp_regmap =3D 0;
> >  	u32 phy_type;
> >
> > @@ -2321,20 +2315,16 @@ static int cdns_torrent_phy_probe(struct
> platform_device *pdev)
> >  	if (ret)
> >  		return ret;
> >
> > -	regmap_field_read(cdns_phy->phy_pma_cmn_ctrl_1,
> &already_configured);
> > -
> > -	if (!already_configured) {
> > -		ret =3D cdns_torrent_reset(cdns_phy);
> > -		if (ret)
> > -			goto clk_cleanup;
> > +	ret =3D cdns_torrent_reset(cdns_phy);
> > +	if (ret)
> > +		goto clk_cleanup;
> >
> > -		ret =3D cdns_torrent_clk(cdns_phy);
> > -		if (ret)
> > -			goto clk_cleanup;
> > +	ret =3D cdns_torrent_clk(cdns_phy);
> > +	if (ret)
> > +		goto clk_cleanup;
> >
> >  		/* Enable APB */
> > -		reset_control_deassert(cdns_phy->apb_rst);
> > -	}
> > +	reset_control_deassert(cdns_phy->apb_rst);
> >
> >  	for_each_available_child_of_node(dev->of_node, child) {
> >  		struct phy *gphy;
> > @@ -2404,10 +2394,7 @@ static int cdns_torrent_phy_probe(struct
> platform_device *pdev)
> >  		of_property_read_u32(child, "cdns,ssc-mode",
> >  				     &cdns_phy->phys[node].ssc_mode);
> >
> > -		if (!already_configured)
> > -			gphy =3D devm_phy_create(dev, child,
> &cdns_torrent_phy_ops);
> > -		else
> > -			gphy =3D devm_phy_create(dev, child, &noop_ops);
> > +		gphy =3D devm_phy_create(dev, child, &cdns_torrent_phy_ops);
> >  		if (IS_ERR(gphy)) {
> >  			ret =3D PTR_ERR(gphy);
> >  			goto put_child;
> > @@ -2490,7 +2477,7 @@ static int cdns_torrent_phy_probe(struct
> platform_device *pdev)
> >  		goto put_lnk_rst;
> >  	}
> >
> > -	if (cdns_phy->nsubnodes > 1 && !already_configured) {
> > +	if (cdns_phy->nsubnodes > 1) {
> >  		ret =3D cdns_torrent_phy_configure_multilink(cdns_phy);
> >  		if (ret)
> >  			goto put_lnk_rst;
> > --
> > 2.33.1
> >
> >
> >
> **************************************************************
> ********
> > This email and attachments contain Ambarella Proprietary and/or Confide=
ntial
> Information and is intended solely for the use of the individual(s) to wh=
om it is
> addressed. Any unauthorized review, use, disclosure, distribute, copy, or=
 print is
> prohibited. If you are not an intended recipient, please contact the send=
er by
> reply email and destroy all copies of the original message. Thank you.
>=20
> Aha!!!
>=20
> Okay destroyed this now!
>=20
> --
> ~Vinod
>=20
> ##############################################################
> ########
> This EXTERNAL email has been scanned by Proofpoint Email Protect service.

Regards,
Li
