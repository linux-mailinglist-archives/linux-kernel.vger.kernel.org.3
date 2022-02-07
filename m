Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C8DDA4AC352
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Feb 2022 16:29:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347099AbiBGP3L (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Feb 2022 10:29:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1443443AbiBGPNR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Feb 2022 10:13:17 -0500
X-Greylist: delayed 398 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Mon, 07 Feb 2022 07:12:28 PST
Received: from mx0b-00128a01.pphosted.com (mx0b-00128a01.pphosted.com [148.163.139.77])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8EF4DC0401D7
        for <linux-kernel@vger.kernel.org>; Mon,  7 Feb 2022 07:12:26 -0800 (PST)
Received: from pps.filterd (m0167090.ppops.net [127.0.0.1])
        by mx0b-00128a01.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 217A6b1p012023;
        Mon, 7 Feb 2022 10:05:39 -0500
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2170.outbound.protection.outlook.com [104.47.56.170])
        by mx0b-00128a01.pphosted.com (PPS) with ESMTPS id 3e31cngqqj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 07 Feb 2022 10:05:39 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OrVma2lW/5pKjTOXb/zMSFJSd/+T0DWRFOFQ3hG1ly2CKoAbElrTJ94Q7AeylVpXrOZLweaqsKNDLwtLVX3vE5T1b9Sv8llDT/s/fckAET9IOQ0U1dodmpYCUNlqQV2gybUvwpKhMRn+8EQ7M4dPoMhn64rJkER6jPoQ/PwEPzOiZjLOxHeD1XqPKwRiPzUNWK31i6JaVHgeS4oa8TCv0fZdnzFmO2GQUiTAcWkQSO6F6ZICxUiYY8kxQz5/sMwZfIF7R/oJ/uQm+wBgK/lHDclInrjW3dOmkLkHA3u0CCR/i89AC9LME/QMYUtiPnzZ9sDA48CrVfjEOMzTctxX8A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VWQX/juVJ2TYfw7QyYebCq1/jEj6vXgYMjhRL8bFYdE=;
 b=Iii7d0T+a1/S5rBhff47pmgCt+ZrD9BBSgf6n5Z9yOp0tiSutrFZqlshRLcjNPlVNjTVIaP7ihbrcGHl0plhe25clQ8ZUVU5ghP0EZxyJnVaNXU8AIIwGVBl/tDO2OgZHTwbiB9nkhhCNmqe3D6/Yj3mY6nZ/LNrMNPsqsGAClGyEg/WLt1/q32LrbSPmJQY3LwwNi1kGfxxFyGzxEWt79uwvkoAXUcVO2fGbgwpRvlEgUr/k/YvdCWWl2JwgmXibn/wcXzsjSs6/VySOUlYrw43NXnYzTEdxTeYHRWAVZjc3IdVGrsljaOr7T0zMslx1sfmjVZV3vw1nd46Z246xg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=analog.onmicrosoft.com; s=selector2-analog-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VWQX/juVJ2TYfw7QyYebCq1/jEj6vXgYMjhRL8bFYdE=;
 b=Qzdt+jvGb0y1mCuIVzjsJq1yZVlTQWt8fqiPo5J/CcQjarQ8lCmGMzlE+gezx+FroONeTnTF9aYrTJTbY9I4UYX7mx3jQpd2QUZRCUTyba17M90Zy/Q1An9gZEep3mnrtJBE//wLbzheB0Cav1wZ11YTSJhDxCM07VJbdEDDyXw=
Received: from CY4PR03MB3399.namprd03.prod.outlook.com (2603:10b6:910:57::13)
 by BYAPR03MB4902.namprd03.prod.outlook.com (2603:10b6:a03:13a::27) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4951.12; Mon, 7 Feb
 2022 15:05:35 +0000
Received: from CY4PR03MB3399.namprd03.prod.outlook.com
 ([fe80::1964:eb68:12be:426c]) by CY4PR03MB3399.namprd03.prod.outlook.com
 ([fe80::1964:eb68:12be:426c%6]) with mapi id 15.20.4951.019; Mon, 7 Feb 2022
 15:05:35 +0000
From:   "Miclaus, Antoniu" <Antoniu.Miclaus@analog.com>
To:     "Miclaus, Antoniu" <Antoniu.Miclaus@analog.com>,
        "jic23@kernel.org" <jic23@kernel.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v6 2/4] dt-bindings:iio:frequency: add admv1014 binding
Thread-Topic: [PATCH v6 2/4] dt-bindings:iio:frequency: add admv1014 binding
Thread-Index: AQHYHCTSCskrpiXzCE2ys/ytCJ2mTqyIL9xA
Date:   Mon, 7 Feb 2022 15:05:35 +0000
Message-ID: <CY4PR03MB3399A7BAF3ACA2F2796F464E9B2C9@CY4PR03MB3399.namprd03.prod.outlook.com>
References: <20220207130549.98415-1-antoniu.miclaus@analog.com>
 <20220207130549.98415-2-antoniu.miclaus@analog.com>
In-Reply-To: <20220207130549.98415-2-antoniu.miclaus@analog.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-dg-ref: =?iso-8859-2?Q?PG1ldGE+PGF0IG5tPSJib2R5LnR4dCIgcD0iYzpcdXNlcnNcYW1pY2xhdX?=
 =?iso-8859-2?Q?NcYXBwZGF0YVxyb2FtaW5nXDA5ZDg0OWI2LTMyZDMtNGE0MC04NWVlLTZi?=
 =?iso-8859-2?Q?ODRiYTI5ZTM1Ylxtc2dzXG1zZy02NTMxYWYwOC04ODI3LTExZWMtYWMzMS?=
 =?iso-8859-2?Q?0xNGFiYzVmM2QzMjhcYW1lLXRlc3RcNjUzMWFmMGEtODgyNy0xMWVjLWFj?=
 =?iso-8859-2?Q?MzEtMTRhYmM1ZjNkMzI4Ym9keS50eHQiIHN6PSI1MDI0IiB0PSIxMzI4OD?=
 =?iso-8859-2?Q?cxOTkzMzQ2OTk3MTciIGg9IjBOVEU2SzZYMTZRZGp5MEh5dlBCanhJelBP?=
 =?iso-8859-2?Q?OD0iIGlkPSIiIGJsPSIwIiBibz0iMSIgY2k9ImNBQUFBRVJIVTFSU1JVRk?=
 =?iso-8859-2?Q?5DZ1VBQUVvQ0FBREZrb29uTkJ6WUFZTDU1bWRiVDhIbWd2bm1aMXRQd2VZ?=
 =?iso-8859-2?Q?REFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFIQUFBQURhQVFBQUFBQUFBQU?=
 =?iso-8859-2?Q?FBQUFBQUFBQUFBQUFBQUFFQUFRQUJBQUFBWFEvampRQUFBQUFBQUFBQUFB?=
 =?iso-8859-2?Q?QUFBSjRBQUFCaEFHUUFhUUJmQUhNQVpRQmpBSFVBY2dCbEFGOEFjQUJ5QU?=
 =?iso-8859-2?Q?c4QWFnQmxBR01BZEFCekFGOEFaZ0JoQUd3QWN3QmxBRjhBWmdCdkFITUFh?=
 =?iso-8859-2?Q?UUIwQUdrQWRnQmxBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQU?=
 =?iso-8859-2?Q?FBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?iso-8859-2?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUVBQUFBQUFBQUFBZ0FBQUFBQW5nQU?=
 =?iso-8859-2?Q?FBR0VBWkFCcEFGOEFjd0JsQUdNQWRRQnlBR1VBWHdCd0FISUFid0JxQUdV?=
 =?iso-8859-2?Q?QVl3QjBBSE1BWHdCMEFHa0FaUUJ5QURFQUFBQUFBQUFBQUFBQUFBQUFBQU?=
 =?iso-8859-2?Q?FBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?iso-8859-2?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQU?=
 =?iso-8859-2?Q?FBQUFBQUFBQUFBQUFBQUFRQUFBQUFBQUFBQ0FBQUFBQUNlQUFBQVlRQmtB?=
 =?iso-8859-2?Q?R2tBWHdCekFHVUFZd0IxQUhJQVpRQmZBSEFBY2dCdkFHb0FaUUJqQUhRQW?=
 =?iso-8859-2?Q?N3QmZBSFFBYVFCbEFISUFNZ0FBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?iso-8859-2?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQU?=
 =?iso-8859-2?Q?FBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?iso-8859-2?Q?QUFBQUFBQUFCQUFBQUFBQUFBQUlBQUFBQUFBPT0iLz48L21ldGE+?=
x-dg-rorf: 
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 5a4d59cc-d36c-4fee-78c1-08d9ea4b4b55
x-ms-traffictypediagnostic: BYAPR03MB4902:EE_
x-microsoft-antispam-prvs: <BYAPR03MB4902961AF45C62480E5F1CD79B2C9@BYAPR03MB4902.namprd03.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: f4tKTi65obkqIw6KwAJaP5+dhwVvOeFFy2dQlihFEXy/WpMERpEdT+TC2S60Izvn9ppnjKkgnFkOgtCaOoGYH/l/saAcRNHLZ6OGAFPmjTy0RMAd1D8QZUWFRv2969//vKA44Jo1mvrMX6neS7eleHqUUPpwm3b/M2O1NO+GZQm5Fx6kll5FMgpP0VvEVUjp+N+wMY3gbeBQyiX9CCc/Zf9oYhTqq06zLttUFt734ut/l4gfG0LTWuFEhr27o60UxvxFf2j7c7u8Dnp/BvVPBTooRM8dkwgtYOpbMiWF/k03scJgT4+/zSHbalRYetMJr72mqS+xxd3HDw0GdN6spmkkb2zZtGjZCqkX6r27xwFJYWdItk5/Z4//UK0HWA1wJunj7uRgklbzX7Yx02CSvwm0VZH8NQw/9lN/VS8vRbrPwbIXcbw1jSQyd603nqhIvmAi2qobmqdpvz4HGO7Qj/uU30FIYYaeSn1LwtW4/iNSsvi1hIkXbZRIzskXpJD83zPshrvk4NyljsDgEa66xzyIYewCN2oYR4BBj3ID9Jpj+HlP/aUJv3xiv9M1bjP4o24sBAdpzPTNJ0euEvnmaqVY3WUpMBXyhFw9lD2YjyRx1AOtiBetgNZDqz+fEShX4vR1REywdjeihIyuFHCNCbZoKPVlsWJSWARfqSbROThV3hTedq0lk5KczpLrwOha359gFpDjo+MwcCCUkwkVvHAIMhzSnl9fJTZkFUOiwzKcDA0Nrnv7yMjeaWBA87QXKRLzYSPMw0dOygNOnxVu0JrCdhemgqWdeudPUD2TFfkBzkxl+r/+8oCg5YAPQ2x2
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY4PR03MB3399.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(52536014)(83380400001)(122000001)(966005)(2906002)(5660300002)(38100700002)(38070700005)(55016003)(66476007)(66556008)(8676002)(66446008)(64756008)(66946007)(8936002)(186003)(66574015)(76116006)(316002)(33656002)(110136005)(9686003)(71200400001)(53546011)(508600001)(86362001)(7696005)(6506007);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-2?Q?ifKXL4ZUL/zmRad9VQ/++EtnN3lKqkHp4w7ImV0VXxuBYXaFgUnVDECagN?=
 =?iso-8859-2?Q?UtulFUcZ3vmd5hOjMNJZbyb15OBlXQxuam+yIMH2O/z0kueUkV1RaVKc/m?=
 =?iso-8859-2?Q?Md9CTwEwmYH6RJizdCLiv8vXKFL+oOV3V8AwbLXB0dTUILt8qJIJYsu+Qu?=
 =?iso-8859-2?Q?IGJd5kHKS5BwwkJZs5eXrvWAqlVWnUm3EAz8Xg9ac5NJ0Qu6YuPswtn4E+?=
 =?iso-8859-2?Q?AbFjJ4TOxid5PyatCuQdaHM+Thi6J2gLglIxfAPJQYCrqfpNyjfNuAzx9o?=
 =?iso-8859-2?Q?73AxSiSnCwCG6zdN6T0//EsCmLwWqSoaRlqPV7kPivQz8MvLHbsFpzWa4n?=
 =?iso-8859-2?Q?jqE2mrLfKt5QZ+cYuF9xeUxmG+B163SRfVhiXhIDt68sMko+gBsgAut+88?=
 =?iso-8859-2?Q?GoVSKIqiq4U6F3eBwYky3bRHbsWZcugJR+83Gm21VFrtlPqI9GQbBCJpkc?=
 =?iso-8859-2?Q?t2k2cub6/cX8IZZaZsmtqadmQP8L6qhpMx3KoSNVhY5qVXhiBfVR0wz1Ww?=
 =?iso-8859-2?Q?fn1R2yRrMwDV5VxYcb+s098eyUSNB+ZAcDTR+pIifXiqVClsJ57oSbqyYX?=
 =?iso-8859-2?Q?L7eivO85xAE3YuVX8vMzruSIbtTQDZ0dNJdfsuIomFtwQoqO2/Oz5SdDTJ?=
 =?iso-8859-2?Q?24IPC7f1A5i1h43NhLS7+dZTwihL3Z/+pDrZLvr3OpdoydPPB7UlACPsm+?=
 =?iso-8859-2?Q?+6lcUkiluZhUxnF6EzwW3MPompkf6PHFmK5dULFkNa/MNIUrG8WluW8tWJ?=
 =?iso-8859-2?Q?wTOTYEI63AF9GqFaG3QlNIGy6cNAcwHvMx24+QdY8d7b9YP7gt2Jmz0J/b?=
 =?iso-8859-2?Q?WE9xppKHKi//yXHAezXDFiAq2YRUSBWSPZtQa1vV8zmi6sjCwPF5dFAs1h?=
 =?iso-8859-2?Q?6AE5K/356eTHBWUSrwHpnBPW+Jos8YsfIl9x7j2hAn/WeR1GgqVEmu4C24?=
 =?iso-8859-2?Q?ZCeXI40F7odz4pW469eL8hMMGHgk19Vp7VhF6/kR+4upb0aMSOCv3KAjWQ?=
 =?iso-8859-2?Q?tN6fyDT4ExaLAxTrRyKjxqaBQKd/auID7Th5qiKvlSMJU1tbfzfXtYnGEF?=
 =?iso-8859-2?Q?m7lvi/VKLQJ8Ikd2rtcRcVY1U9UcW4K9UxZUoLtSWom9qZnM96j1DioSr/?=
 =?iso-8859-2?Q?Q072CcpvxaOwJr0LG5HZ2bT9paKcAUWkCZH2RSaXnr2uBLl8iW67UuWE5Z?=
 =?iso-8859-2?Q?RV9SOdcoDygpH8/N+SQrqxPDuK6hujFnN9hHB3PYzkMpJJNtF1+FYAZ8yC?=
 =?iso-8859-2?Q?8oQ5jkx0dEq0fpDBski7DPi0nLdQTZBFuPyJPiMXwBsoBFCuAnvYZU8mUM?=
 =?iso-8859-2?Q?kRpEa2zlNb2S6pQK0WUfcr1sOevjOyloxEEMWx+GvItuhDk6QhZeBwwvFN?=
 =?iso-8859-2?Q?cMLfZmrxCixlIVr/iEOBrT/SuvwTEFM7nzaI+jQwlcM8lQymX6aogWO1XM?=
 =?iso-8859-2?Q?KEFEBVRVSg2BV+7ZWAsgzol4Uv4vDIiJpKpuX3Nayo94Ul4Htetg6Ss0pR?=
 =?iso-8859-2?Q?orY/1SxgUf4zR2IgyEtCTlpmuj+YlbnlMb/IBcVTRiAKEmMVLs9zH2IgX+?=
 =?iso-8859-2?Q?9JS9yJrVqt1FtC+geN8p3J9VBjKKvnFolxKNi2B7Yk9mBNOOAPvVpvcWvP?=
 =?iso-8859-2?Q?sFeAO1cs6nWrGGmsdNrs4xS5KwoMs+vrm7EbjHD1CRNIuRnrMZ9YRaGept?=
 =?iso-8859-2?Q?9xzMgijmI/5K5IotfSuXj5JO6KOxnndCduZFpXzLKsKOd0MUUSmIfSWcuF?=
 =?iso-8859-2?Q?ooj1QFoZJsuhZo3G2gEUMFPKQM21KRCYeSpDpwM5MRhsNNgYjnoZxyP/VK?=
 =?iso-8859-2?Q?wBKbktEw8Q=3D=3D?=
Content-Type: text/plain; charset="iso-8859-2"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY4PR03MB3399.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5a4d59cc-d36c-4fee-78c1-08d9ea4b4b55
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Feb 2022 15:05:35.6037
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: boD54mdK2GNjAONDctbTPVXmrzI7tF+IzMX/v5Sc7WSPHD07WVQk/lPDuEqQYwYdSSEYUHX0Ny7tV7tpsgl7MK3uuZ94LdcDx0QS8TZ/yt0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR03MB4902
X-Proofpoint-GUID: p-PKWNjoN9bKSszvhBdptrFEijUZOwou
X-Proofpoint-ORIG-GUID: p-PKWNjoN9bKSszvhBdptrFEijUZOwou
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.816,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2022-02-07_05,2022-02-07_02,2021-12-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 mlxscore=0
 suspectscore=0 priorityscore=1501 adultscore=0 clxscore=1011 phishscore=0
 malwarescore=0 mlxlogscore=999 lowpriorityscore=0 bulkscore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2201110000
 definitions=main-2202070097
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



--
Antoniu Micl=E3u=BA

> -----Original Message-----
> From: Antoniu Miclaus <antoniu.miclaus@analog.com>
> Sent: Monday, February 7, 2022 3:06 PM
> To: jic23@kernel.org; robh+dt@kernel.org; linux-iio@vger.kernel.org;
> devicetree@vger.kernel.org; linux-kernel@vger.kernel.org
> Cc: Miclaus, Antoniu <Antoniu.Miclaus@analog.com>
> Subject: [PATCH v6 2/4] dt-bindings:iio:frequency: add admv1014 binding
>=20
> Add device tree bindings for the ADMV1014 Upconverter.
>=20
> Signed-off-by: Antoniu Miclaus <antoniu.miclaus@analog.com>
Forgot to add in v6:
Reviewed-by: Rob Herring <robh@kernel.org>
(here, not in the ABI patch, my bad)
> ---
> no changes in v6.
>  .../bindings/iio/frequency/adi,admv1014.yaml  | 137 ++++++++++++++++++
>  1 file changed, 137 insertions(+)
>  create mode 100644
> Documentation/devicetree/bindings/iio/frequency/adi,admv1014.yaml
>=20
> diff --git
> a/Documentation/devicetree/bindings/iio/frequency/adi,admv1014.yaml
> b/Documentation/devicetree/bindings/iio/frequency/adi,admv1014.yaml
> new file mode 100644
> index 000000000000..fe352c01dd94
> --- /dev/null
> +++
> b/Documentation/devicetree/bindings/iio/frequency/adi,admv1014.yaml
> @@ -0,0 +1,137 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/iio/frequency/adi,admv1014.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: ADMV1014 Microwave Downconverter
> +
> +maintainers:
> +  - Antoniu Miclaus <antoniu.miclaus@analog.com>
> +
> +description: |
> +   Wideband, microwave downconverter optimized for point to point
> microwave
> +   radio designs operating in the 24 GHz to 44 GHz frequency range.
> +
> +   https://www.analog.com/en/products/admv1014.html
> +
> +properties:
> +  compatible:
> +    enum:
> +      - adi,admv1014
> +
> +  reg:
> +    maxItems: 1
> +
> +  spi-max-frequency:
> +    maximum: 1000000
> +
> +  clocks:
> +    minItems: 1
> +
> +  clock-names:
> +    items:
> +      - const: lo_in
> +    description:
> +      External clock that provides the Local Oscilator input.
> +
> +  vcm-supply:
> +    description:
> +      Common-mode voltage regulator.
> +
> +  vcc-if-bb-supply:
> +    description:
> +      BB and IF supply voltage regulator.
> +
> +  vcc-vga-supply:
> +    description:
> +      RF Amplifier supply voltage regulator.
> +
> +  vcc-vva-supply:
> +    description:
> +      VVA Control Circuit supply voltage regulator.
> +
> +  vcc-lna-3p3-supply:
> +    description:
> +      Low Noise Amplifier 3.3V supply voltage regulator.
> +
> +  vcc-lna-1p5-supply:
> +    description:
> +      Low Noise Amplifier 1.5V supply voltage regulator.
> +
> +  vcc-bg-supply:
> +    description:
> +      Band Gap Circuit supply voltage regulator.
> +
> +  vcc-quad-supply:
> +    description:
> +      Quadruple supply voltage regulator.
> +
> +  vcc-mixer-supply:
> +    description:
> +      Mixer supply voltage regulator.
> +
> +  adi,input-mode:
> +    description:
> +      Select the input mode.
> +      iq - in-phase quadrature (I/Q) input
> +      if - complex intermediate frequency (IF) input
> +    enum: [iq, if]
> +
> +  adi,detector-enable:
> +    description:
> +      Digital Rx Detector Enable. The Square Law Detector output is
> +      available at output pin VDET.
> +    type: boolean
> +
> +  adi,p1db-compensation-enable:
> +    description:
> +      Turn on bits to optimize P1dB.
> +    type: boolean
> +
> +  adi,quad-se-mode:
> +    description:
> +      Switch the LO path from differential to single-ended operation.
> +      se-neg - Single-Ended Mode, Negative Side Disabled.
> +      se-pos - Single-Ended Mode, Positive Side Disabled.
> +      diff - Differential Mode.
> +    enum: [se-neg, se-pos, diff]
> +
> +  '#clock-cells':
> +    const: 0
> +
> +required:
> +  - compatible
> +  - reg
> +  - clocks
> +  - clock-names
> +  - vcm-supply
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    spi {
> +      #address-cells =3D <1>;
> +      #size-cells =3D <0>;
> +      admv1014@0{
> +        compatible =3D "adi,admv1014";
> +        reg =3D <0>;
> +        spi-max-frequency =3D <1000000>;
> +        clocks =3D <&admv1014_lo>;
> +        clock-names =3D "lo_in";
> +        vcm-supply =3D <&vcm>;
> +        vcc-if-bb-supply =3D <&vcc_if_bb>;
> +        vcc-vga-supply =3D <&vcc_vga>;
> +        vcc-vva-supply =3D <&vcc_vva>;
> +        vcc-lna-3p3-supply =3D <&vcc_lna_3p3>;
> +        vcc-lna-1p5-supply =3D <&vcc_lna_1p5>;
> +        vcc-bg-supply =3D <&vcc_bg>;
> +        vcc-quad-supply =3D <&vcc_quad>;
> +        vcc-mixer-supply =3D <&vcc_mixer>;
> +        adi,quad-se-mode =3D "diff";
> +        adi,detector-enable;
> +        adi,p1db-compensation-enable;
> +      };
> +    };
> +...
> --
> 2.35.1

