Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4AF6C53FFA1
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Jun 2022 15:01:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243207AbiFGNBg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Jun 2022 09:01:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231426AbiFGNB2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jun 2022 09:01:28 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F37BAE261;
        Tue,  7 Jun 2022 06:01:26 -0700 (PDT)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 257CWpS4013812;
        Tue, 7 Jun 2022 13:01:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=I7+4BBoJW3D0v6uvgRqYTPKwyEVJHoo4Kc8rMTx9xpE=;
 b=06sp70ATK763bcdNSxX96JG6airV5SmCoXFfPsfYTLwE1HD4clEYqs5u5rMolv+uxEW8
 zbhzGQFJvBIYZkjIuSBswruLVMsCuw9/vBATx513rL5D7s+uShk4PoccbUeeRULqrlqM
 QeQTyJ0wViv5x/FAHFybrcicvEa85Kqq0FEws8RWGPIHHXuMVYAWUi8YmNsvKfrkR+4z
 ziC77UePIfdZ9Ia8700084j6pD+/jR4uTeJ7JMFycBbtZHu0e3mzDmg31WCPEIfZZ2Ny
 7jRm7cc0vu06L8nwFCWH/mdFdGIzKOmx8N6TIp6TgasWoVV444X9pK9g3aMctZk6pjLK cw== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3ghexeb3rn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 07 Jun 2022 13:01:14 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 257Cf9mp025125;
        Tue, 7 Jun 2022 13:01:13 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2171.outbound.protection.outlook.com [104.47.55.171])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com with ESMTP id 3gfwu9nusn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 07 Jun 2022 13:01:13 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZKnpcxMRlj2UAGpvvfmlnMYvJLLxpWR0nh6MlIRQpG90yx/lzVIU9Wq2bHB1WCoy4HMrTr9b5xb4RnzFVCqvj/ZqiSpgPmjOoK6LurYjrCpPxyGhXnxeTc30+xOafNBjOgO7P1YXOoLrR5JgdeaTwXfSnuD8mxLKF9vO0WDwXCZFFeksAOOHwdqlbl2CsjoDAyFOjwFHpqozhsHOt0uO7GARu3MjEQr2M2qirkHXDKa+cvGZhw8H08tTfuy/NsZLB9hbMrHgmAnAqKBIRyvHk4kgSwbWM8gWF62WwrIaHycQgTZRWvTPholQKYf7AgWC+OhG1Ii3+5eY2Y1d/oebcQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=I7+4BBoJW3D0v6uvgRqYTPKwyEVJHoo4Kc8rMTx9xpE=;
 b=bOWjbFApqCxJi+G5hscwFhMaw1narMlzgvXNIj2p79ntkOke7IZOUYr5YsaI8J1V7crqtQazKlNZV8/ycGJde891TFut75XgaDBJfM7R9aRGYGaKtu9TNGESjvLC5T4P0CRgRsPkrUbWgZXoDmCatA5Kj7kecyDuASsWAuYyWSPuXHYhgWfz983y/mASFu3CL17VK5Q5lYxUt1tI1pjLzvLID78ro1IHcCWLNA570jRGdQkHJVOiFCzKENqHjU3eeHC1EyGOpmjc0lFF9LIZhtE4zcy72SmRwiCCtKldvXwVfKSI7jGN4jtPGxj8Z5S/wgCRi7VBthFS28C4/Jb8Mw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=I7+4BBoJW3D0v6uvgRqYTPKwyEVJHoo4Kc8rMTx9xpE=;
 b=jVKx9180IOzfnGYZdCp70Fq3IMNwqk2Vo5Vh5LYOOxZcVXIZEjT8QJqHiy4mNrHoW5vL5xvKsY1Etd49GTHSJvRcb52O37/S4unJDp4m8Szfu7NlotuIWia1u+5avibu1X/+Pd+m0tIKZADcN0H2rP2nueKWDn01HgrrFE/rqnQ=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by DM5PR1001MB2188.namprd10.prod.outlook.com (2603:10b6:4:32::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5293.18; Tue, 7 Jun
 2022 13:01:11 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::e1df:2e42:6674:313e]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::e1df:2e42:6674:313e%7]) with mapi id 15.20.5314.019; Tue, 7 Jun 2022
 13:01:11 +0000
From:   Liam Howlett <liam.howlett@oracle.com>
To:     Lukas Bulwahn <lukas.bulwahn@gmail.com>
CC:     Matthew Wilcox <willy@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "kernel-janitors@vger.kernel.org" <kernel-janitors@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] MAINTAINERS: remove an obvious typo in MAPLE TREE
Thread-Topic: [PATCH] MAINTAINERS: remove an obvious typo in MAPLE TREE
Thread-Index: AQHYejlPdPHJeTcOw0uyeGje1vTJC61D6NwA
Date:   Tue, 7 Jun 2022 13:01:11 +0000
Message-ID: <20220607130046.dxrol6zinr5excy5@revolver>
References: <20220607063834.7004-1-lukas.bulwahn@gmail.com>
In-Reply-To: <20220607063834.7004-1-lukas.bulwahn@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: d986118b-cccc-48fa-870d-08da4885cbc7
x-ms-traffictypediagnostic: DM5PR1001MB2188:EE_
x-microsoft-antispam-prvs: <DM5PR1001MB2188D7A6F9D9FA661A688C0CFDA59@DM5PR1001MB2188.namprd10.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: K7+yBZPblgXbM2TUamP7wL18ZhVtk4y1DZ0TI2zqtkKp+XDy6obyldq8iLp+s0+RdTNl4OTKeLHG2C7rgPzeboqhsc9C1zpAPEFtXjTaoYeJjXVKNpXQnj6Qdz+3fvlCK/8Kc8unj1vYn4YPBPPzujyC9WFJr/zkBZhTJzqHqTnVn93+idUNoFTf8SXZNrNHfXh3q07mIZQaAwx/Z7f0mBtVmA440FCJH2biWu0LnaPnb/XS3W0AuyMnMniENsOOMt8JGwRnjCoLYn98KkCAK7HKsbwrCFbB9adFx6Q8J4MXm4we1uZ92tGtOfxHva/rKwpPXbtIt5BNnPJLq9TPPWCsdQFQlt8fHSMGHAiTsM/7Dg4X8YZlAlXtCGFokN0I5n1dSHjzOcF9fJe+ooppteEmBYjdOMkUTXlWeyepInLyZV4TMf12cnm1s9EyNEvbZt1t3cWjuRLnKvdJ72/ZAkKFNxM47rCO2SMFMSujH8V8/u0AqLcTBnWDAh7uBjp0h4/fSueR7BrShW+exrCE+GEFogVvtVzApuF/+ybiHJPgppxOjgkMqfuMOZ5p9CPZ2X5FtgYVfVnq3NJGHqeWNv9RgLH9+TujZM0CrI/7iTe6weOFzYtoXJUUjQv1oA35CbCbJpiea7T1qdwCF4/XYUn4nV4qnSxlQQPAGHL2v5sXKAP1sDh5n2/fJcGhxREkmxd2rVUJRiY8/3XaBoBrYA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(7916004)(366004)(6512007)(71200400001)(26005)(508600001)(6486002)(9686003)(6506007)(122000001)(186003)(38070700005)(83380400001)(38100700002)(1076003)(66446008)(66476007)(66556008)(66946007)(64756008)(4326008)(76116006)(8676002)(44832011)(8936002)(5660300002)(86362001)(2906002)(33716001)(6916009)(316002)(91956017)(54906003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?temoUj39CJ6NapPoZ/z+3pc1MUaiuda8Uj8PLN8byLCyBtX49oHbz9e1sN47?=
 =?us-ascii?Q?Ndqjzs/UQsK8sVtax4/9fLrs0w6doBnpF/lvaAqiD4lhvLYfeIt5BWBN2Fwv?=
 =?us-ascii?Q?VnXeBHQLHoTz2XgVkRIhZQXnmFWP8mQkuE7ZfNxrTd7Ir5wdyc2IcuBrhRr+?=
 =?us-ascii?Q?iPYKds0J6o0KfWuAQFdGaAeD8WnhslBbPEJJH4AWPRpSriaLX/yZCLQU57mY?=
 =?us-ascii?Q?vjvWp7C5cvZDKJi2Z47yApgPYWP1ffbpvdCorIN5FlzV3mXpWyjch3BGxxrH?=
 =?us-ascii?Q?V+cbjB7tec1yRhFclVWK9IOvn5I97yvCauuSKiDKnwn56cp58VQexTr4iayx?=
 =?us-ascii?Q?yP1QEBlu4vyNQ4zHN9tU//fXWdYWYevwJVGX4GzLBJase3ebDjQ9oHmOa6jR?=
 =?us-ascii?Q?nmrgd60rM2USADRDxaQPYUgbDB6qw4UvahbAxTBwlsCa+bbltzJqYv4Dxr41?=
 =?us-ascii?Q?jQuk1GIgufOr5hMudx+MlXMskARLdg/io8A3odXyRUmb8qSdfIgZPpefwWrT?=
 =?us-ascii?Q?rMeyiC41iEeTnAPC6Lvzr33vNZxBozxcJZOOOhOWcVoN1QsTWKXoeNspPTbI?=
 =?us-ascii?Q?ssPg6SepvncywKW9wSupO789f2o7+HD3FArLSFhpS9GV7khRq8gayHXkAPoS?=
 =?us-ascii?Q?2P5Al0gWirFDNzoYfbY87qRTR6MGl3lWFWJOaSk31zkTX1mjEAQI4M31xaux?=
 =?us-ascii?Q?1lp2Gl1lBIAmyN2zqVbnioVc//3G+TkX0P5YH5KgHfIhNjZ7SlkpC2MD9Pct?=
 =?us-ascii?Q?llUrOt1CiKBy6CUkV0HUNNakg4YkLRx6tCFsKxbNkPVVVmOmEYhSLeUPuwag?=
 =?us-ascii?Q?jYbbq7kY0hFbBIEnrimOfAS2uuafcBSTw+Oy4lkl5iQxACT/ISIYePK1gRpC?=
 =?us-ascii?Q?ofZ876OgbW3i583MKCvRp8ibHyWQjVbyeIiLdM05FaxfihxP8FPmBJLZnKjM?=
 =?us-ascii?Q?nkJpYp70x2ZZULLHF5k/aYZr80vyd6S0o+yVwLj8rc8idAAo+mFFQg2vzHYR?=
 =?us-ascii?Q?M4r7iJzZSKtNRXHVk4mE7mRyXUoBMNvQh6M31sK9WUX1YkcfFDAxdutOTF6s?=
 =?us-ascii?Q?H6Mg2sUMQYr6zEP5AZKxCfcXS7WY+8ByKYS2cVou+pk7/4xJt849xAcNd8B3?=
 =?us-ascii?Q?Bs/x4sWO1B7Yl3+c1P2JCkvrbI8vpbzzdhAvoJ9+K4sSrJ6UhT3wezXQEjBB?=
 =?us-ascii?Q?ONxAEeIaS1XxMGSvIdXvoARgpcmadFF2YfdIY2a23Dq/y2a8FfyQGHJsRbPH?=
 =?us-ascii?Q?FXo4R1xi5ZCF7iHMoQeryRAYnogQH3eNj+pz51Hl9qoNVOPV28RMwQM2FL5/?=
 =?us-ascii?Q?+wbA9MhCfQWTNz0rITA3N2WH9hc0Fih5aOZchFf8Wu7lKpsgC4enxSZCpeVm?=
 =?us-ascii?Q?J9LsUM5++H6OLifnyOz0jCtwzue4Es1AiC1o9ID+SNbaLoFqT2w6JMOQdCPE?=
 =?us-ascii?Q?1OgfGFadu+JoufCzjHQSTxfAKqyrdZ0uCBZzsa+OZ0/NRlH6yLLlZECxGkqZ?=
 =?us-ascii?Q?ovgr2eC6MUv9zwrSbIH+x/8Z21wF3vqFxtwHBpeosv2bLX89+aj/tPkjm08y?=
 =?us-ascii?Q?z2vbp3vcvS6QGk+RobjiYSu8AmPFM/CvjYqNVwV2icYA5KtOyQIXOIN6zjaN?=
 =?us-ascii?Q?PSAp36BuF3hKV6sFpa92S7ZN321GkRkxQGp6li8ojY5cTZ+HcYsdHQmfLzty?=
 =?us-ascii?Q?/csGa6B0jZq2vxD5Rp3tTOPAi3zbLv3y7gsQ/KABBP8F7do3YuKbquLx5PeP?=
 =?us-ascii?Q?DvuCzm27KdfpFY7symq2DwwHeG+e8/w=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <59505FEB412AD247899E0B8A3446C97B@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d986118b-cccc-48fa-870d-08da4885cbc7
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Jun 2022 13:01:11.2579
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: m+lIdeM2i8EPqQOOMWxT+QEvCSFHU8A2ZYctfkoSWDWM0XSDZfFFpYh2ncVcytIfPHO6i/5+UmdpT4XwqlFl8Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR1001MB2188
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.517,18.0.874
 definitions=2022-06-07_04:2022-06-07,2022-06-07 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 bulkscore=0
 malwarescore=0 mlxlogscore=951 adultscore=0 mlxscore=0 phishscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2204290000 definitions=main-2206070054
X-Proofpoint-GUID: 7PczdPSH1m8bZcp2HdQ1GbxoE7IbsSsm
X-Proofpoint-ORIG-GUID: 7PczdPSH1m8bZcp2HdQ1GbxoE7IbsSsm
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Lukas Bulwahn <lukas.bulwahn@gmail.com> [220607 02:39]:
> Commit c6e2362e9289 ("Maple Tree: add new data structure") adds the maple
> tree and a corresponding MAINTAINERS section, but slips in an obvious typ=
o.
>=20
> Hence, ./scripts/get_maintainer.pl --self-test=3Dpatterns complains about=
 a
> broken reference.
>=20
> Remove this obvious typo in MAPLE TREE.

Thanks Lukas.

Acked-by: Liam R. Howlett <Liam.Howlett@Oracle.com>

>=20
> Signed-off-by: Lukas Bulwahn <lukas.bulwahn@gmail.com>
> ---
> Liam, Matthew, please ack.
> Andrew, please pick this minor non-urgent fix into your mm-next tree.
>=20
>  MAINTAINERS | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 8eaf234d663c..572f50739fb2 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -11792,7 +11792,7 @@ F:	include/linux/maple_tree.h
>  F:	include/trace/events/maple_tree.h
>  F:	lib/maple_tree.c
>  F:	lib/test_maple_tree.c
> -F:	tools/testing/_adix-tree/linux/maple_tree.h
> +F:	tools/testing/radix-tree/linux/maple_tree.h
>  F:	tools/testing/radix-tree/maple.c
> =20
>  MARDUK (CREATOR CI40) DEVICE TREE SUPPORT
> --=20
> 2.17.1
> =
