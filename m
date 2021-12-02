Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4A4C8466365
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Dec 2021 13:19:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357768AbhLBMW6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Dec 2021 07:22:58 -0500
Received: from mail-eopbgr00042.outbound.protection.outlook.com ([40.107.0.42]:15425
        "EHLO EUR02-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229463AbhLBMWx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Dec 2021 07:22:53 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=C8JKFenPw+NHVdpqV3YsNVLA7q3myZLlcMYx9BWh5fPQYvvMgSNSC1fzfe/0ARghgHWyfuaPx0XZbyH/sDJaqUQ2lP4z3VeBeBlUyUgGmWiOP6DWxrV8jUNpcV02bnOrsUH8JJeblKVthxZ210TVELe6pQKD9sYeZHVEnFKDZnMtOgifnXVT7n/hXenth/8Qn0jfu9ajcXvU2grfMug7dE5U+pRDkS5QvQ67Rus/UmGBit0JSdsS15buPCSSWdr2us/8/BlG5wm3Ro58/d7Rz7jtGklaDX6v8d+TcOKZLtcxf2RtjQ5J9OMVHdBuwnu/P0ssF728lAnKCQSL9EY0nQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0s5q3Iu8Nb0t5UJ4fQwJPXqr9dkAJ9/OnPthci7YN/I=;
 b=TliWBC7fOJ5Y0vVYdMFbefVSucgYWhYtAyioAuz/ucDEtBZB/ome7fABTK7dEstRhFQ7GBV8eCxan3klS95Hp8O+IXggd38Nde7rEl4FveFSGHfdXy0yYsK0eRoQMX/hkMrs8MHOXPbzQL6ldMpJpZ7Vp9hyc42hwJxDD/+Tmn0LCGHAqZlGqEFHLfq/1yYVDJSjhqVpt2qv7xbLKHxaGvXnw7WILQCFfchzpGVGhjFNWVsRIYFw8fuQ7gxRW6znubYxqi4dsJngXd3WIIfR2MZ7wAt4BVgjV7HLaqklYpUF+cT7sZ6ZV8ED5D4MbsvQybBEcLVA+VpqiUYeBL/vOw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=diasemi.com; dmarc=pass action=none header.from=diasemi.com;
 dkim=pass header.d=diasemi.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=dialogsemiconductor.onmicrosoft.com;
 s=selector1-dialogsemiconductor-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0s5q3Iu8Nb0t5UJ4fQwJPXqr9dkAJ9/OnPthci7YN/I=;
 b=qiOB5s+m7+zQBQulWbzbF+aeF6LAirtZS4uhRzZLwgHwwZ19Imxn06wHC8l3bGl0VUAAmlgf6RW7gZCaqkySJSu7o8khWPfU7IyML2VQe7RQ1rt4zf9yT/qMMQEZkzHe8rCMrKagIK/e2f1bzpO04xf+91OO1xxWvPB+wDWIHhA=
Received: from DB9PR10MB4652.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:255::23)
 by DB9PR10MB4426.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:222::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4734.23; Thu, 2 Dec
 2021 12:19:28 +0000
Received: from DB9PR10MB4652.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::852d:c54f:8414:3276]) by DB9PR10MB4652.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::852d:c54f:8414:3276%3]) with mapi id 15.20.4734.027; Thu, 2 Dec 2021
 12:19:28 +0000
From:   Adam Thomson <Adam.Thomson.Opensource@diasemi.com>
To:     Andrej Picej <andrej.picej@norik.com>,
        Support Opensource <Support.Opensource@diasemi.com>,
        "linux@roeck-us.net" <linux@roeck-us.net>,
        "linux-watchdog@vger.kernel.org" <linux-watchdog@vger.kernel.org>
CC:     "wim@linux-watchdog.org" <wim@linux-watchdog.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        "linux-imx@nxp.com" <linux-imx@nxp.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
Subject: RE: [PATCH v4 3/4] dt-bindings: watchdog: da9062: add watchdog
 timeout mode
Thread-Topic: [PATCH v4 3/4] dt-bindings: watchdog: da9062: add watchdog
 timeout mode
Thread-Index: AQHX51+RGREztfUVRk+CCGVq+Iu6gqwfHuoQ
Date:   Thu, 2 Dec 2021 12:19:27 +0000
Message-ID: <DB9PR10MB46523DC971180A1B39BEDBC380699@DB9PR10MB4652.EURPRD10.PROD.OUTLOOK.COM>
References: <20211202093230.3951996-1-andrej.picej@norik.com>
 <20211202093230.3951996-3-andrej.picej@norik.com>
In-Reply-To: <20211202093230.3951996-3-andrej.picej@norik.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=diasemi.com;
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 613e5542-137b-4781-d211-08d9b58dfc72
x-ms-traffictypediagnostic: DB9PR10MB4426:
x-ms-exchange-sharedmailbox-routingagent-processed: True
x-microsoft-antispam-prvs: <DB9PR10MB44268F63F48E95155B4BE0BAA7699@DB9PR10MB4426.EURPRD10.PROD.OUTLOOK.COM>
x-ms-oob-tlc-oobclassifiers: OLM:2657;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: PE+D4t9RVP8SI+e3Og6WWAth9hwcV0Ohd1rPC4Ymc4wXYMEf47rUCSl50fwoPJgMZb2s6bcnR967ws0l8UwIcMozgDR4draFY3LJZONuYJdIIYyneyioqfVPknSbhEcJClKPWvyJwqa9U1Jdv2wdqZ0SD3lPtZIOb3SeBo4z1fEXeb0vcx+/I6mha3Apa1DANHrAsbr6Qd1ryTu3icpJfn8F7Vquc8LCN4UnNtB0RlsXyKfMKtzqQVagY4HwOqToeoc7ZC80yB2mANV7z5/T0YPmyDv1svtw4kdp/BTUL36EfgPY0olPIQc7nwqWEMyyvXqMg9tumX212//AFGPijBDFXHhko/Z+H82mFRzFCwzD+SKvMTvBE1I2SfKm7buMLBbC4IPAbw0sO0YdS7bBCqogcqvYgAaUN5znCXaLnm1xn0Croy4QlXyLk6cjhERfWSuR8uKsv9yo/n7yerKF+QK0igjd/g4UlHSzENoyuxnXD0U60ViC/hrwup5/CoL3e7JBebo6w7TTsWjVle8cHzgf9M2wkgDsCE2dVwqoKhxEE1FjavY2HtNG7LcotYDaY/KvVYsFxKgb3MU7li2W1HlfnLw51UW0t32tJZZSrJljHHsPIDrWmKErph4qASWphLabHgzN+BJet+/2pXn1qXxUoWTTtdJsofwMkBcXu6KexRn4eGaVXbauHpOmtU7oobw0CGcNkKMh7hK5FdJHaQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB9PR10MB4652.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(4636009)(366004)(122000001)(8936002)(6506007)(7696005)(7416002)(53546011)(4744005)(110136005)(38100700002)(54906003)(2906002)(66446008)(9686003)(508600001)(5660300002)(66946007)(71200400001)(76116006)(86362001)(64756008)(66556008)(66476007)(26005)(8676002)(33656002)(52536014)(4326008)(38070700005)(316002)(55016003)(186003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?/8pvWLLEowlI4207F1I4ArEqW+FWMBHc0mpE6OozcRxT9i39TPI7WCN2SBqM?=
 =?us-ascii?Q?1mBkELwfSntF0adMX5ww2asboanowqrGng6LVFAVpSedI1tlEkuNwSh04mnH?=
 =?us-ascii?Q?fszxdxTZs4EUM/eUj1BELDxe8lYFgFVxo452i1DLG4Rgii5skMEzIEaBUY4c?=
 =?us-ascii?Q?FMoXkUohF7W9rGTJrgT7bUQf/Zx0AIffg6cdvdw10PBmsHEBEQopofGlQgKG?=
 =?us-ascii?Q?H3yX7SOFJBLA7Zyqz4tGGs18dtNB65qGr4eADb+/rmQrGEkDVP3neA9XXm6d?=
 =?us-ascii?Q?Z0UW8I6myHNRvcfJLDsPrJzYs8kWn4hj9YEqGbpPvrAg+KVQO4SZR5AZls8Y?=
 =?us-ascii?Q?OWm8sM8NcxicwcE4qFn+GOhx5ABwo9fsYLbqVJTEEWXrs1jEr4t2dkv1kt48?=
 =?us-ascii?Q?xJ2WciEgq29jMiGpGQeQdR3sJT0ay/AsTXmD+96ePQi+wob8pC+z3rNEQTEG?=
 =?us-ascii?Q?AclY3//Ikas8sdl2blqB07YYQrsS5eCSckkPSDIj/19nplj/TT/6uhsE6aWi?=
 =?us-ascii?Q?fAqXr3OISvOjPb1YunwHuAzxyUdlzMD9JRnPaD1eJpFaQYjAtXdiQt0oGfAQ?=
 =?us-ascii?Q?Cb3wh1vCelBlItZw2uKHEXRun8JYI0hKOlS4jrB8FcTnS9hdbhde78nH9WZP?=
 =?us-ascii?Q?YrxveNZdfnYNIn3Ke3FAWBUcMcBmZHXAydmr+dq3uli/7Vsdt70jVexJ6zWA?=
 =?us-ascii?Q?k62IgXpXM+eBLXixWwvoUAgKoiG4voYaddMORKp3/9XNMRm4p71Q4AmtMgwa?=
 =?us-ascii?Q?LsJlBA/ztD6tb0zt0KReK9psUAcPaJaHMz3ZQsYneciHQ/Ux7z7XYxj1XOON?=
 =?us-ascii?Q?ExPDcezHmGQabsqJlA5ns9H7FgaqlqFMchcBcb6aqp7RBt7We7K1hEmTF48h?=
 =?us-ascii?Q?eqk5gqmOVR80envDQSvDuoSOqXIeuHD4KUK9Jv6q1A67dxckP3gvFcniI8BO?=
 =?us-ascii?Q?mqnPcu3UpGmn4hxQxLxugJeaEVLZjs0kXOmt0JkKH5Qf7Ww0JGqU/wCiA61g?=
 =?us-ascii?Q?KIrENFU5eCnEoZZecsxNbLzyhqPCS9BI3VOAk+lBd/OQF/0GPi5nZk+uyR9X?=
 =?us-ascii?Q?lD6/OP4cVuBGTBIqLLlwwztJEhJQGHChJHSd0RUChNKLSHFPkqNkBJw6xARE?=
 =?us-ascii?Q?dTdih64v3rzvzjVkV+LMJLwa8jpzjGuUAh5xK4D+jvmKl88rP8xMx6D8+9NQ?=
 =?us-ascii?Q?qevYA621pqKh8Tec+3DNiwvTFa9uzP1aic5Y1APinSGrM2twCwT5IW47SiVk?=
 =?us-ascii?Q?iJI7ceGwxsQm+rLgzsNLP20JWxamatfVKckUoHabVi+5pKnCU8SijQHh1HjQ?=
 =?us-ascii?Q?HVwVX2rOZ2Y0PqlMBb+jPdrTlR7rREV5XE/AMVn3/NPfAjbQ+KA0lBaR7UyP?=
 =?us-ascii?Q?uzaafHWi9jQTj40O6Xmzoz+9/NNZg9OeZQTosoVG/A/inR6kVMQ5wPjozFeM?=
 =?us-ascii?Q?rdpDcKJAHf4DcFdPAVoOAegsFIL0RvytfLyOVW0JvjdssW+KnaLPs10PUu8z?=
 =?us-ascii?Q?Aw3logWcTiVxrk0o3SLG0wcVDHmYMWVzhHa/z1nZ4ApWrpiKWhQZi2SHAdh0?=
 =?us-ascii?Q?XTO4sJo1cGYklKUdJ0wJ9ypd/02MeJVYbT7gu63PaBFdEDitn2AchxNM7bkG?=
 =?us-ascii?Q?UlzquzfyP2sue7mzd3pVBGbSyrZjZ8ZOLuNVICQ/xahDZkx6YY3W4SgzRkCv?=
 =?us-ascii?Q?ukPSqQ=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: diasemi.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DB9PR10MB4652.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 613e5542-137b-4781-d211-08d9b58dfc72
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Dec 2021 12:19:27.8750
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 511e3c0e-ee96-486e-a2ec-e272ffa37b7c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: RqCsL8uMRjsa2t5XBq55cOAur98YR+nvBtwc7z/3gIV4L9bM7WYCEZgGn4eo145PuP7I88f24VL5Cv3LjPo8uMWaR79FdS39aYbZKq4gm8k=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR10MB4426
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 02 December 2021 09:32, Andrej Picej wrote:

> Document the watchdog timeout mode property. If this property is used
> the user can select what happens on watchdog timeout. Set this property
> to 1 to enable SHUTDOWN (the device resets), set it to 0 and the device
> will go to POWERDOWN on watchdog timeout.
>=20
> If this property is not set, don't touch the WATCHDOG_SD bit and leave
> the configuration to OTP. This way backward compatibility is not broken.
>=20
> Signed-off-by: Andrej Picej <andrej.picej@norik.com>

Reviewed-by: Adam Thomson <Adam.Thomson.Opensource@diasemi.com>
