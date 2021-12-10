Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F399B470223
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Dec 2021 14:55:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238899AbhLJN6f (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Dec 2021 08:58:35 -0500
Received: from mail-eopbgr70052.outbound.protection.outlook.com ([40.107.7.52]:26502
        "EHLO EUR04-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S230205AbhLJN6e (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Dec 2021 08:58:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OgUmEoKuPgFly/mXIjTIVDv8sR5DvV82x2TYtZRSKJI=;
 b=85+N2raY0RkGZwE1xjK1ieihV7DmW4YT64oA4PNqG3zFjVycicqdgbamBqB0sBdy6MTttkfJvYvz1q8FWxVeBtuSth0y367gkHFkQYSKIalgl8kIj+E2XgbgxC1oX6TLPX0ajld65W8+d1qKTiiqqAMrrLnxPj2rvBysgnLYz38=
Received: from DB8PR04CA0008.eurprd04.prod.outlook.com (2603:10a6:10:110::18)
 by AM6PR08MB5077.eurprd08.prod.outlook.com (2603:10a6:20b:e6::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4778.12; Fri, 10 Dec
 2021 13:54:55 +0000
Received: from DB5EUR03FT053.eop-EUR03.prod.protection.outlook.com
 (2603:10a6:10:110:cafe::8e) by DB8PR04CA0008.outlook.office365.com
 (2603:10a6:10:110::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4755.16 via Frontend
 Transport; Fri, 10 Dec 2021 13:54:55 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 63.35.35.123)
 smtp.mailfrom=arm.com; dkim=pass (signature was verified)
 header.d=armh.onmicrosoft.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 63.35.35.123 as permitted sender) receiver=protection.outlook.com;
 client-ip=63.35.35.123; helo=64aa7808-outbound-1.mta.getcheckrecipient.com;
Received: from 64aa7808-outbound-1.mta.getcheckrecipient.com (63.35.35.123) by
 DB5EUR03FT053.mail.protection.outlook.com (10.152.21.119) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4778.12 via Frontend Transport; Fri, 10 Dec 2021 13:54:55 +0000
Received: ("Tessian outbound c61f076cbd30:v110"); Fri, 10 Dec 2021 13:54:55 +0000
X-CheckRecipientChecked: true
X-CR-MTA-CID: b894961c9fe67add
X-CR-MTA-TID: 64aa7808
Received: from a94c98eeeee1.1
        by 64aa7808-outbound-1.mta.getcheckrecipient.com id 0EA52B15-7F86-4432-BFCC-22D1E313199E.1;
        Fri, 10 Dec 2021 13:54:45 +0000
Received: from EUR05-VI1-obe.outbound.protection.outlook.com
    by 64aa7808-outbound-1.mta.getcheckrecipient.com with ESMTPS id a94c98eeeee1.1
    (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384);
    Fri, 10 Dec 2021 13:54:45 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VPROEtATqYUkMrTPh1wZHR9accajIUEyQMMZnqALBMFqfMWjwD/d7yfw92UbYAipU4Z7RCtJWEQbS47vsDYoRQ+H+ityQrgTR4QGZZquA5CBrQZTdRe9aAZ8Bz+S81BDNeVQtXOLaAMRfHxKuwf/QEsNw8cHyWeyFxbtwxcQaSi0ULxcWycuSEy4KnZxpGab0BFoXmfuFoE5kXzfEPA3xhFk65PJMf8HZWkSvIt69IipRDsg2HSlqphOlaBMytNSe1ihe8T5YJ8eEqjuOPrBTJVKgMKRoX3CRHLaFyxL8BmrUp95PONv2x8dl/5nGIkP5r5E1hZ2x1krks0E505R1Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OgUmEoKuPgFly/mXIjTIVDv8sR5DvV82x2TYtZRSKJI=;
 b=DUvtEFaR/+622EyzU+9yllBbDXwVjdYAlS3p2KvRayizYWoY0vJiYKB62R9XrervHgSX3p7sHe+LFkCiBEiv2reyTIq+uDEusvGXx6jxEGyH4IpyWojhwjPg7WuXHhl6pkGFMAGpDxUeH2lxJzQW3roHlxJDojOQFJ8mI9vwxiF4+sSw+WIPphFE390nxfZgW+MjR2fOrqXExIhNBkYagZb8Ukt0wBhs7eMuA9CkAjGYlzoBy5dbCMHP5okWZRFjO6TTXm5xOj5x7eWwsrpTxw3+fuB+qgJii3xii7nQ0wrIK/jP5Oh59nq+BpW4kQmlgbuqC4YCfWGbj7slthWqEg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OgUmEoKuPgFly/mXIjTIVDv8sR5DvV82x2TYtZRSKJI=;
 b=85+N2raY0RkGZwE1xjK1ieihV7DmW4YT64oA4PNqG3zFjVycicqdgbamBqB0sBdy6MTttkfJvYvz1q8FWxVeBtuSth0y367gkHFkQYSKIalgl8kIj+E2XgbgxC1oX6TLPX0ajld65W8+d1qKTiiqqAMrrLnxPj2rvBysgnLYz38=
Received: from AM6PR08MB3784.eurprd08.prod.outlook.com (2603:10a6:20b:85::25)
 by AM5PR0802MB2401.eurprd08.prod.outlook.com (2603:10a6:203:9d::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4755.20; Fri, 10 Dec
 2021 13:54:43 +0000
Received: from AM6PR08MB3784.eurprd08.prod.outlook.com
 ([fe80::c0c1:d43a:acf3:a59d]) by AM6PR08MB3784.eurprd08.prod.outlook.com
 ([fe80::c0c1:d43a:acf3:a59d%4]) with mapi id 15.20.4778.015; Fri, 10 Dec 2021
 13:54:43 +0000
From:   Bertrand Marquis <Bertrand.Marquis@arm.com>
To:     Oleksandr Tyshchenko <olekstysh@gmail.com>
CC:     Xen-devel <xen-devel@lists.xenproject.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>,
        Stefano Stabellini <sstabellini@kernel.org>,
        Julien Grall <julien@xen.org>
Subject: Re: [PATCH V4 6/6] dt-bindings: xen: Clarify "reg" purpose
Thread-Topic: [PATCH V4 6/6] dt-bindings: xen: Clarify "reg" purpose
Thread-Index: AQHX7Tg58KQ3i6/mL0iJhWZTO46LzqwrcNWAgAAGoACAACKBgIAAJpCA
Date:   Fri, 10 Dec 2021 13:54:43 +0000
Message-ID: <F9B96A75-8DBC-469C-9961-C2CDF11DC5BE@arm.com>
References: <35ee3534-9e24-5a11-0bf1-a5dd0b640186@gmail.com>
 <1639136201-27530-1-git-send-email-olekstysh@gmail.com>
In-Reply-To: <1639136201-27530-1-git-send-email-olekstysh@gmail.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3654.120.0.1.13)
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
X-MS-Office365-Filtering-Correlation-Id: b2617923-4cec-4543-943b-08d9bbe4a59f
x-ms-traffictypediagnostic: AM5PR0802MB2401:EE_|DB5EUR03FT053:EE_|AM6PR08MB5077:EE_
X-Microsoft-Antispam-PRVS: <AM6PR08MB50770226D639A94003541BAE9D719@AM6PR08MB5077.eurprd08.prod.outlook.com>
x-checkrecipientrouted: true
nodisclaimer: true
x-ms-oob-tlc-oobclassifiers: OLM:9508;OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted: BCL:0;
X-Microsoft-Antispam-Message-Info-Original: udNO2H3pgHSVUNwJ7q/bKT03t2ovA/nat9Ec8SXA1yw1nQojsHgmW2wQiAzMUe3vyQyDbT7OBHjkgjVROefW63HZcHx1hWCeMcQf0WzvwMViw/cUmojc2/YogTK1ghuaTNZ+FQIEwff32zboNgGlZnysorMP3zAIO4Yf93bDAg4iu8Pu4b/EkedBTIcQs9bw+/CbHZhdCNUYTFJo3WLDQxhNt6a8AzJIqyv/oheo/v1/f5hCpYaGB5g81/fmUwE43OjCSFqApb4xiQkOCqt3FiIeVdvEkEyqdnlHxUi2PEDAZ6bGzNQZgI21bnom/EJ2Ry8+S2ZPjRiHUOcSUIP+pj8aMwaIA6tWrO3t6JOrQFUSkZONsxZD1j1qXioo/JSJtLDr8bTZ7NpO/KUZIIPb36/XbssaTt2dnvgAc1+xvK1+s3E0GGHWVh5/mp7zZTQA6h+nk3BNXffxwT9X16X4PqLRrLbZbUrTIVKI27PrfRJK4P8dQCZemS6TS5whL7nkEPvGzbTCGYuBCMkJ0sTMAPP98G5ASq7mx1vouUMSTsL53yfWOshgxymAgDV+W+HjN86oO35oZOcdy5hWIdg+9LH+wKbTWSEqZJ5hIIy+9VArTUIhPmGJ4EsjfCdrqburW/Wju4Lh2dMLheabxLgS0zqQMK358jckDbDgGvYdpWMi1GQ0mJX7Jv55qf24DDpuRXduxvNxvSzMnZjPr9bp/zYPwvP3EJCIWwPtavGg/wUZHvU7DUcAAE5EL3hy2n50NFV/tMbPNRA87B/91wy0IxGscpPaMmee0ebKxXYqsK8bEQEbH3f4XbSelGeLRg/fQBqz/dDT59S7mZp3mj0KyQ==
X-Forefront-Antispam-Report-Untrusted: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR08MB3784.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(71200400001)(38070700005)(83380400001)(508600001)(316002)(5660300002)(38100700002)(66476007)(122000001)(4326008)(6506007)(8936002)(2906002)(64756008)(186003)(76116006)(66556008)(66946007)(6486002)(66446008)(91956017)(6512007)(53546011)(2616005)(33656002)(966005)(6916009)(54906003)(26005)(36756003)(86362001)(8676002)(45980500001);DIR:OUT;SFP:1101;
Content-Type: text/plain; charset="us-ascii"
Content-ID: <9EF347FE1F15D54CB90464D1CCF4A1E0@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM5PR0802MB2401
Original-Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: DB5EUR03FT053.eop-EUR03.prod.protection.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs: 18e4facf-b5ba-457b-fb56-08d9bbe49e7a
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 5G8ZCwoWRlHBc2ZXHxFjnW6Hytifa5LiLOMABVGKANhgaWVYgCU19QWk6uVzj0KtRqMUqAmA4v6iXuzODfIsRwhTYcPnjML1CLH21fzCmasmM2ks2/7KBkZZBF9Dcch+fRf7jQu5tr0coyXiDLB8Lt3+38cqH3X5Akg829ZZZmKFcXv9LuPUczrpSS6YzylyEpTA3sk8MAaelb8i57I+Nvi6nM/Y/XbUMUQm1dvXEXCsqmgVsOMNM4Ri5lGEpnpnYFoV4CgHKpu07gZRi+o1N/JfQW/AbP4cBuFyNU4o2vRAQYYNTOKRWhBw4dCVTAL1vkqpYqY6izo8O0UZ5aM0qkx/CTtKuBN4fv85nQpFR+KBqQrbqoKz8MHiJobK/HueOcHIj5p9Gv6AQwyI2Ggip3bRT8LdV6kVcw3bdvJL1pgQnNc92/6jTlpZ7sG7ZBcdflhgrUHbDekl9r2wBfIE/O4+uuq5kFhiI2quFpbIMlALO5iSScMjfIg0iKvuVI3fLV1u+bXXOj1+PyT2gSw1I9aE4m4J3lnj+hl3h6KkufMigWOCFXZqSpqX8Mjw5m8UFflagkxeY3uZueVUIIwzNvM0C3AEd9NHTyuxXXRVYKvT6PeYFjCFw9IFp4JTSQT4PmW8VR5oFLOEYcQ+b0w1venD9cU/QBOj69ILxELYcUoVS79vdYBVkueb9aavOQomIJR/4tKyG6mNaiSpIiPZIn+g9O1R1/qJjze4HHgTMG0xuv8ykPVM68ECDakqCi3+0NkypKEgSEzm5NpU9mXKQx1xBk1r9YtGTp+Vj1t6MiU=
X-Forefront-Antispam-Report: CIP:63.35.35.123;CTRY:IE;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:64aa7808-outbound-1.mta.getcheckrecipient.com;PTR:ec2-63-35-35-123.eu-west-1.compute.amazonaws.com;CAT:NONE;SFS:(4636009)(46966006)(36840700001)(2906002)(54906003)(316002)(186003)(336012)(33656002)(4326008)(47076005)(8676002)(508600001)(26005)(36860700001)(966005)(36756003)(53546011)(8936002)(6506007)(450100002)(6862004)(6512007)(2616005)(83380400001)(86362001)(81166007)(356005)(6486002)(70206006)(5660300002)(82310400004)(70586007);DIR:OUT;SFP:1101;
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Dec 2021 13:54:55.5116
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b2617923-4cec-4543-943b-08d9bbe4a59f
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[63.35.35.123];Helo=[64aa7808-outbound-1.mta.getcheckrecipient.com]
X-MS-Exchange-CrossTenant-AuthSource: DB5EUR03FT053.eop-EUR03.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR08MB5077
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Oleksandr,

> On 10 Dec 2021, at 11:36, Oleksandr Tyshchenko <olekstysh@gmail.com> wrot=
e:
>=20
> From: Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>
>=20
> Xen on Arm has gained new support recently to calculate and report
> extended regions (unused address space) safe to use for external
> mappings. These regions are reported via "reg" property under
> "hypervisor" node in the guest device-tree. As region 0 is reserved
> for grant table space (always present), the indexes for extended
> regions are 1...N.
>=20
> No device-tree bindings update is needed (except clarifying the text)
> as guest infers the presence of extended regions from the number
> of regions in "reg" property.
>=20
> Signed-off-by: Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>
Reviewed-by: Bertrand Marquis <bertrand.marquis@arm.com>

Cheers
Bertrand

> ---
> Changes V2 -> V3:
>   - new patch
>=20
> Changes V3 -> V4:
>   - add Stefano's R-b and Rob's A-b
>   - remove sentence about ACPI for "reg" and "interrupts"
>     properties
>=20
> Changes V4 -> V4.1
>   - bring the mentioning of ACPI back which, as was pointed out by Julien=
,
>     fits in the context:
>     https://lore.kernel.org/xen-devel/9602b019-6c20-cdc7-23f3-9e4f8fd720f=
6@xen.org/T/#t
>     so technically restore V3 state
>   - remove Stefano's R-b and Rob's A-b as I am not 100% sure they are
>     happy with that
> ---
> Documentation/devicetree/bindings/arm/xen.txt | 12 ++++++++----
> 1 file changed, 8 insertions(+), 4 deletions(-)
>=20
> diff --git a/Documentation/devicetree/bindings/arm/xen.txt b/Documentatio=
n/devicetree/bindings/arm/xen.txt
> index db5c56d..156fe10b 100644
> --- a/Documentation/devicetree/bindings/arm/xen.txt
> +++ b/Documentation/devicetree/bindings/arm/xen.txt
> @@ -7,10 +7,14 @@ the following properties:
> 	compatible =3D "xen,xen-<version>", "xen,xen";
>   where <version> is the version of the Xen ABI of the platform.
>=20
> -- reg: specifies the base physical address and size of a region in
> -  memory where the grant table should be mapped to, using an
> -  HYPERVISOR_memory_op hypercall. The memory region is large enough to m=
ap
> -  the whole grant table (it is larger or equal to gnttab_max_grant_frame=
s()).
> +- reg: specifies the base physical address and size of the regions in me=
mory
> +  where the special resources should be mapped to, using an HYPERVISOR_m=
emory_op
> +  hypercall.
> +  Region 0 is reserved for mapping grant table, it must be always presen=
t.
> +  The memory region is large enough to map the whole grant table (it is =
larger
> +  or equal to gnttab_max_grant_frames()).
> +  Regions 1...N are extended regions (unused address space) for mapping =
foreign
> +  GFNs and grants, they might be absent if there is nothing to expose.
>   This property is unnecessary when booting Dom0 using ACPI.
>=20
> - interrupts: the interrupt used by Xen to inject event notifications.
> --=20
> 2.7.4
>=20
>=20

