Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 09E14493272
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jan 2022 02:50:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350746AbiASBuE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jan 2022 20:50:04 -0500
Received: from mail-vi1eur05on2054.outbound.protection.outlook.com ([40.107.21.54]:5793
        "EHLO EUR05-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S238680AbiASBt4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jan 2022 20:49:56 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CUR9AfmPBfcKxYwRePo+RxvwZBvZIFyydEWXU9eEo8iOdDqaLaspll81ujrHBCYGkaZcPrU2Ut5ndAyJVlg7NUZ11H7hwnFvB/LB3QQAV2T0wcCw7pGd0AAGFO1bV3iPNd6NcW5hgMXlXIEpE+uubH4OSbIh1uXFECaRLs4lE42SVvyDySeAKBnHk53RcEEN23lwewr6Bs9jxr6cuHX4aWG4CNXOs6Pnc/dpPwYooPysgVT7yq140k8WqYxDfuQ4Te46Ol9R2favVQtbctzaqMTsPeL8vovNi1j/vrs3BauieTI/n2PX1+Sv+o6IeE/zY/Qn3TDC5Cs4solgeoQPuA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gM32fOudcXZ6V65I3ZRDUjyPPh2ReJxRI51cDS1CMeo=;
 b=AR1VHGeoNZeWtnIlPDJ0BKJfsQUvpQt99miIQ7C6zHj38qfISleHCCS/JQbPRj1WLnjpJPW/t2vl1Ko8QE0Sj3YDGGraWCoB3hcIALtKxcN6lbbbwdpRm/hTZFZj6GM65UEI+cFRdCl3sD+5yyC1I6Dom6QAtEm3cx0NtOtQzYT5MLJdIqQ+yaEvSyUlili7fITC2tiPErw3jYnqGAORXQErSYJX7YjH28yvG1gZqos2BU5smTMeqCkj6GzwlhFxOt6FRhpUVgNwMxaAHrLcWNGGXe8qE3msrru06ArljzuHRqgE4YiK/uoXbvmO8f+EXbJ1fX+y0Q4rmPnKj00sbg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gM32fOudcXZ6V65I3ZRDUjyPPh2ReJxRI51cDS1CMeo=;
 b=WAporhG2iNeOaOjgWIIkLb5sHDb1BM3Rcmzwpx7Dm+e2BXRUcc4DGqhfeO6ZH9sytXMpJFThKONMYe7Z2vl1wxAABrFI1w3/qa5Pn5GXGGs3mXSWpHzYVFy8VGQUL+snH1tawTjNDeTJaVq7QvHkni/YUAHJiSk4SVAOpHYu6wM=
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by DB8PR04MB6907.eurprd04.prod.outlook.com (2603:10a6:10:119::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4909.7; Wed, 19 Jan
 2022 01:49:53 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::d4dc:8c9a:55d0:81d8]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::d4dc:8c9a:55d0:81d8%4]) with mapi id 15.20.4888.013; Wed, 19 Jan 2022
 01:49:53 +0000
From:   Peng Fan <peng.fan@nxp.com>
To:     Abel Vesa <abel.vesa@nxp.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh@kernel.org>
CC:     Alexander Stein <alexander.stein@ew.tq-group.com>,
        "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        dl-linux-imx <linux-imx@nxp.com>
Subject: RE: [PATCH] dt-bindings: serial: fsl-lpuart: Remove i.MX8QM from enum
Thread-Topic: [PATCH] dt-bindings: serial: fsl-lpuart: Remove i.MX8QM from
 enum
Thread-Index: AQHYDHMZ7HYNvIruxEWyQ/2oDFQkpKxplISA
Date:   Wed, 19 Jan 2022 01:49:53 +0000
Message-ID: <DU0PR04MB9417D9724F34059B1E7D6AAF88599@DU0PR04MB9417.eurprd04.prod.outlook.com>
References: <20220118135535.2118720-1-abel.vesa@nxp.com>
In-Reply-To: <20220118135535.2118720-1-abel.vesa@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: de37790c-0738-4f4a-edf3-08d9daedfd22
x-ms-traffictypediagnostic: DB8PR04MB6907:EE_
x-microsoft-antispam-prvs: <DB8PR04MB69073D6F91DF962815E6253A88599@DB8PR04MB6907.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:3276;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: TUoXtkjCcu1fPMz5UCFOEsbvGETnusAdu29W3cCTI+Tfk9Ku0ETY3vgZZYoROLOqbimewsaVgIf+eK+a5P+KydI9a/gJdEzRfuOjC6LjaOncVq7skVAzl9Ffkr5YQpPtAWSjdD/OIZkVFD01YDoBAiIszKNZtx7ucDOpv3mBKisVBuO2c1IHdCTgKFc3NylzrZVp1ju97DtA3r0db2dMG7A0CZOeJbqiVAciN0RV0QRXc/5KK3Kw1SGQwI9Gg+QnIlWRgPNeMwBv/Ifor0C2XNmMSYrRD3RYW+03WjXSV/2xI+cvNO/B1JiXgkWSGpfSE02iXq46my9VjU7FU8CKzTWGhRM4KHQ+stzc9bdnOv4Ws0KQ27Hrpxt0/2LOCxeEQAGjCLBqCWZ8jK3PM+kj0vorRRsl7nBw6W/UroyMlml5jqlaWEytaZEQ3e06htO1/LcageaDKJshGW0pGqxlptYFsQJzV25U47R9LlXK5bEq+kDuOF9L9eg4ghjtgA7HkmWPRdNORiUOaOL5mcmw/URndy8wzgMijGVqIh21oJoIbTrrQh8+hvC6i4204M7I6LSGsCGWPAJYDXxn5OJx9jBXqzpTqDYJ/rXLonMaLPPORK8yq5+02JmkgUeBHQg4rPi7xLrxCkgBmZ6MAnOQ68A84sBKRt7E+BSJjoGK90SsfGOf7567z4M6zPxxgFX+eNDqGNBRIztegvKIuBNnOw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(55016003)(508600001)(83380400001)(44832011)(38070700005)(86362001)(8936002)(71200400001)(52536014)(122000001)(4744005)(5660300002)(38100700002)(54906003)(316002)(9686003)(4326008)(76116006)(2906002)(66556008)(66476007)(66946007)(64756008)(66446008)(7696005)(186003)(8676002)(33656002)(26005)(6506007)(110136005);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?jIAC1xfuuywJpMFSsKdlTLIwWo2w0Z6nKeGSXABlFDVlQ17iOE5mhYFb56eW?=
 =?us-ascii?Q?tw3h7+OFzMJLHRiUDcH6k0LcXQ/CZqMkuA9JJTgNb5q/SWYRPEHxQ+fQceVb?=
 =?us-ascii?Q?2yh8GUDBfpfQkCsHJZb2SxqDtqKOlFeBvgAV+n20Q2vsC0JA4eV8MJ6390DH?=
 =?us-ascii?Q?RSkKLaGPYH/4Dl72TnjIctkrOYxj+ZMhhpU80L185dwmCAmojSjp2K6O+Gvf?=
 =?us-ascii?Q?ddlwzWRepQ3XIuyBbZwqmZ9Sa/7mScFFZ91h/88JlOeDjBxHJgr83hAipQee?=
 =?us-ascii?Q?WTKNGRQ+scOBHQR0Mhg1OZ46MqLw8zf1VP9n0ODq+nCm23JSl4u/MBAWYofX?=
 =?us-ascii?Q?dj9UqB1ApY2htcVOoqGlIYjKR42YN1KECzDCspRTVEuwTqQb05aoT/PKN0fQ?=
 =?us-ascii?Q?9ZaWvYyC/YpCGFPpMlEDW7DPOHtnX3FjPor8kVAXulHpL3zDCxf7mupsw1d6?=
 =?us-ascii?Q?YIIgKhljEmVye8o5q4X+gKhGR0NpZ0ow03aAX4S1kKjwtPObWqCubJrL7Phj?=
 =?us-ascii?Q?TDqsedj+/FXL1YGDIfUWBPt9SsjmxQSQbEXS/uIjok91m596XPVzawC4iKnO?=
 =?us-ascii?Q?fNwRkwdBfcYwSSITfMZ3gvyeoBHLxukPCBM4o0Onu+ZQvKSiS0F98OlOBrlC?=
 =?us-ascii?Q?azWqQbujPi2Oe4QTx+Ck9x5qUaZf2dRQfCJnetPVDtootiNhL59VRo9R4wpa?=
 =?us-ascii?Q?bi5np4SKIjLsv++PFXVm0kG8353DMR/paQwT0iazLrZk90t39PK2mY2glglI?=
 =?us-ascii?Q?5LVYMUkznMUAW76TPTT7dTtY4abzf4ddCMTOQATsitVgcfGIdWp1bv2Y2qLp?=
 =?us-ascii?Q?vBha3FedBbgzu61HXqcgUt/aO/9eav/lVtq3XTVXJlY9XVa6HxWBO5Ef2UlM?=
 =?us-ascii?Q?v/V9iM8VUjvwob8Jcqwj4Vau0O5NMqSxDSVFGZJY67+bTBss9cGX4MOhHnqf?=
 =?us-ascii?Q?Uaxf25G53zBYJoqUMD+Q4GLV+aqSkFlD8KRjKBDLi/qZ+iOdxI4cWWpQwgkK?=
 =?us-ascii?Q?viMPOJKkKZvZckKLFC9LKCvL5Jejvd7k44NE+1CqIxIZZGdZU8WZh5Pk/dAF?=
 =?us-ascii?Q?uvfghvFFIgPPNpHPSuHsC+X5/XyvPSLEMTRALKRKzs3lGos7uJywu3jkXgvE?=
 =?us-ascii?Q?9dJHEw5kUKQWmOftgfO5JpLx/qiahIhJBXz2ZSP71b4oH6KxCslXSSn5t+QE?=
 =?us-ascii?Q?VKB5lrGEOIqJCe4NKOFv0pHMs9joPkfHCtT/QdSMa8CP8RDQ3+wCKHDPMeyy?=
 =?us-ascii?Q?04Ejv2yEdXi57s/lGJQJGcTCuBZdyoOhSrCK2Fmpk4bCFIQ//d0K3yjzTIOn?=
 =?us-ascii?Q?U1SakHS1MaNDI//bdKq1WtWn6ATFP7Ch7YOJftV79I6dRN8vP1X4rdNshtwv?=
 =?us-ascii?Q?2Mwr1K6Uii9vnULicDxabVyTOzwxxpEx37wKFI+/7uX53FbJ3KJgPdCMCcSi?=
 =?us-ascii?Q?OaMr6EGjxnL93Y+L6iFLZGbp7/qfxN43Xr8Q/3Szeld0+wWU9J/L6BeTd7di?=
 =?us-ascii?Q?uwzc2KTP4MRCHOIXn42Nb0uQtozXvfZiuHPsqjdmxGuUAVF2yK6zDqmcdO6L?=
 =?us-ascii?Q?6OZugqyvgOsZXxMeMbWs6C9Ia+MuyuWb/MIHzC0qiSzJ8UHeHAEDlkMCJpgN?=
 =?us-ascii?Q?ow=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: de37790c-0738-4f4a-edf3-08d9daedfd22
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Jan 2022 01:49:53.8040
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 7JLboyeGOQd5486yH6ZAzNipWC6jJa9RC8ZkdtwAZKSoXscuskhHmIEg5zi9xgy/jBmGzwwYBtMmJDrLsFt1BQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR04MB6907
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> Subject: [PATCH] dt-bindings: serial: fsl-lpuart: Remove i.MX8QM from enu=
m
>=20
> i.MX8QM lpuart is backwards compatible with i.MX8QXP, so lets remove the
> single match from enum. This will force nodes to have both compatible str=
ings,
> since there is alreaady an 'items' entry for that.

Typo: alreaady->already

>=20
> Signed-off-by: Abel Vesa <abel.vesa@nxp.com>

After typo fix: Reviewed-by: Peng Fan <peng.fan@nxp.com>

> ---
>  Documentation/devicetree/bindings/serial/fsl-lpuart.yaml | 1 -
>  1 file changed, 1 deletion(-)
>=20
> diff --git a/Documentation/devicetree/bindings/serial/fsl-lpuart.yaml
> b/Documentation/devicetree/bindings/serial/fsl-lpuart.yaml
> index c33e3af1b5ea..aa83cbf56d59 100644
> --- a/Documentation/devicetree/bindings/serial/fsl-lpuart.yaml
> +++ b/Documentation/devicetree/bindings/serial/fsl-lpuart.yaml
> @@ -20,7 +20,6 @@ properties:
>            - fsl,ls1021a-lpuart
>            - fsl,ls1028a-lpuart
>            - fsl,imx7ulp-lpuart
> -          - fsl,imx8qm-lpuart
>            - fsl,imxrt1050-lpuart
>        - items:
>            - enum:
> --
> 2.31.1

