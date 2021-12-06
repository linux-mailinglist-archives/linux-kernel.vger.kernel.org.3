Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7E02A46A6A9
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Dec 2021 21:15:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349431AbhLFUSs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Dec 2021 15:18:48 -0500
Received: from mail-eopbgr50044.outbound.protection.outlook.com ([40.107.5.44]:44382
        "EHLO EUR03-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1349378AbhLFUSp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Dec 2021 15:18:45 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GQ2/BQ78QXBra+g+udGIqIr3LRtFVuP+dBYeHahmmpnxQ/1X9TqtVYA5zMhe7aI/bYGFE+6FgMM/bMGBoxkIhkk9jlt4A/YdnUAfClySoCpngV0pXkIqSqxTxK2IMvdAVMPdTs2Tv7H2jmkZ14MyxamxvoE611snsVxpC3ELiepbnRJsCL+JZbUs8RACMUNlIVj5uX5yTw8WUsczkSiBb82tkVI7nl0nF23YGNJRMocdRqC9tnkwjucSin6Z5Pe2HHa1NHUc6uzb7KbmRNudxiAiFlCOg2Sm78rmDTKoh6UaK6u1tuPo8QWeFuzTqm4qV8iqB1eRQ6rZykLTI1LCsQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DGLEEgBtYXwpN5fQdWqSW3AXw92YbDMkTiIqt72o8D8=;
 b=jE/o7oruDfIuWh8Q+XLbq0ERQVEudk30QQPjx/ptuFZ+mZb5qCg9hRCWHwQ9rjj7fWe1Sb41Ua4RH7yJzXexsMzldEmnfvTGbc2SflyIfajQg3iB1PgpQphapm+IfdUKI005aeZ4FxI5FCmXnETv1NlSTYOXoIrzoYvdNnzhsAC4REqi6AnVt6pJMrX84GbI4jIC94LNX6eXcCqgS//RQAfq7jOSOr5VcNBk5oM4a9ATCmFW4fAJhElJR97StIiACDKO/d9ueVDfeEaBOiYlGtUlsN240s1gJ8Uf6DLbOHdzccpgrVpUVLXDY0Ynz+DAX6+mKfoAcZZcGZn8qrKJdg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=diasemi.com; dmarc=pass action=none header.from=diasemi.com;
 dkim=pass header.d=diasemi.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=dialogsemiconductor.onmicrosoft.com;
 s=selector1-dialogsemiconductor-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DGLEEgBtYXwpN5fQdWqSW3AXw92YbDMkTiIqt72o8D8=;
 b=bihKYplpagB9DrMCmDUPhFGUyNiXtRNb3d0vx7owsi1QZdNnm5KQKPr59ln5b72PL2Fb+JM92gBd0avAONxpglFmgS8JbjY6atBdJzjIh4HY98MOvenGr8kv2aVgb73lHHN2gIfVHMwidVt4MxzyFqE9RoNhewZ5/JqdZsedlOU=
Received: from DB9PR10MB4652.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:255::23)
 by DB6PR1001MB1207.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:4:66::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4755.21; Mon, 6 Dec
 2021 20:15:14 +0000
Received: from DB9PR10MB4652.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::852d:c54f:8414:3276]) by DB9PR10MB4652.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::852d:c54f:8414:3276%4]) with mapi id 15.20.4755.021; Mon, 6 Dec 2021
 20:15:14 +0000
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
        <linux-arm-kernel@lists.infradead.org>,
        "cniedermaier@dh-electronics.com" <cniedermaier@dh-electronics.com>
Subject: RE: [PATCH v5 2/5] mfd: da9061: make register CONFIG_I writable
Thread-Topic: [PATCH v5 2/5] mfd: da9061: make register CONFIG_I writable
Thread-Index: AQHX6m0sKOk/7DUyg0ySC591wOoe2awl5wjg
Date:   Mon, 6 Dec 2021 20:15:14 +0000
Message-ID: <DB9PR10MB4652DBF87E18FD8819EECA45806D9@DB9PR10MB4652.EURPRD10.PROD.OUTLOOK.COM>
References: <20211206064732.280375-1-andrej.picej@norik.com>
 <20211206064732.280375-2-andrej.picej@norik.com>
In-Reply-To: <20211206064732.280375-2-andrej.picej@norik.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=diasemi.com;
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: e5bd8a1b-1056-4a36-e948-08d9b8f51d00
x-ms-traffictypediagnostic: DB6PR1001MB1207:EE_
x-ms-exchange-sharedmailbox-routingagent-processed: True
x-microsoft-antispam-prvs: <DB6PR1001MB1207EFD15D4963772AF706BFA76D9@DB6PR1001MB1207.EURPRD10.PROD.OUTLOOK.COM>
x-ms-oob-tlc-oobclassifiers: OLM:1303;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: cViesVr5pGDtcNDHhTo+6hE9GgJHK2qCXbWESMw4+/zWkRuOxfW33LD8wJ/3r4/YfJW3EZxlnwpolLTxVEel/gH3NdUiIiKgUX68foPt7XT/9OJo3h65UqtilQzbTJNTDefAVIx70QZLN0Q1d0mtj7DTl0jjeibRUV+Z8sZIZtByH2BYhqZy6910SeyVhGn/vjGfGLcmN063lyttRAYOeuztHubEpM2ON5uE5+95HMlJCzq9AcST3nFnJ584bBgJHuEOcAeYskFW6Cko+7FI0CBkwXNFXasJTxJSLBUDdscYqOBbTRkQnyzE/UoDcKplFMj3XY4agu02l3pXKmMpQ3cL/CmUsSmJTuTn0+hiYhiEjxfdEh50fKP+CPVJ2dyYpkoS/Q0n0J/+3SSP859DpmazzE9LBYK4WhYFRvSMw7EClAEU3VcU6jJWtjt++lccGKT6/g0Pcm1PoyTUkB5FrnbZ8U1Egieh4dBq/UDqZXcVGkkJ31zTQMIz1SHe2J3WaG7S8z2OqaEqd+/zpaZT01biL3QSq7+mM6UV8JKdqrx6H6AkCWDI+gWEiMxXpZzxS47gPzlOiFDgaK/+EWae+QPrEYh9bkijMaXDgd9c/KZnoaMUf0U8cnkycyXXKrSu4tyTkGyEcsHNXV0TcZo40209LmJJCQAvwm7HNHhNjmb6Ig+vhXrE/Q2wWOcQzlT6Tv67O2Pg42DOXOvdvxwe/g==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB9PR10MB4652.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(4636009)(366004)(186003)(86362001)(122000001)(38070700005)(8936002)(64756008)(26005)(7416002)(76116006)(66946007)(8676002)(66476007)(66446008)(508600001)(38100700002)(5660300002)(66556008)(558084003)(71200400001)(52536014)(316002)(7696005)(6506007)(110136005)(54906003)(53546011)(4326008)(55016003)(33656002)(2906002)(55236004)(9686003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?E0cHQGadp7B69xDC/eaNf1EFl4OyNydXnHvF0i3fx+zyiqllofpBrBz1vror?=
 =?us-ascii?Q?beiJ6uwDqIQx2/FZQukLS4FbiIAxNzSBMVQ5ftuBkckBoetjucfUZqpP+4O9?=
 =?us-ascii?Q?gtk8J9geS2Hd/mGGQgrQfEspuWQ/+P912bhg9y6P5FcTqoaB84jQAInLtcSU?=
 =?us-ascii?Q?Jvc3OVPHDGjEVKJcmRJK9i8mYUxUvPP8Qn1IbTF9DRt5JZgypY6PMG98ydOC?=
 =?us-ascii?Q?fYgHrgNKXSr0taXef9P10z7aHdUOaxvqwRrUa8c2D+ONrQChoAbsPmRj6crm?=
 =?us-ascii?Q?Ih2eFZ0MFhMENjmLx0KRjAFnbhDEotHBkQHSXP/AV44+rgWaOaIqX2++umpy?=
 =?us-ascii?Q?YU37Z8Oo5Rb6E3LvIT4BGVrx2qfDVsZjFKMANFgJUYgUe2iO4L8XHlGHoEfC?=
 =?us-ascii?Q?PbrneEB1RwamyBJ6t3bSuozFVnyvCkh23GQjTAPnLO9l7KH4GiEp7kx/wXow?=
 =?us-ascii?Q?+fmqMtmcaQ1pcWShp6xnxMldK+RtVXldTfZ3P/a4BNLUX2oxCxMxo3OocSlt?=
 =?us-ascii?Q?NCEjDypbvyyNLL40uUzwCuNNIh9AH+pAM2MPu4/32f2ZNXpnKNkPL+4SN00t?=
 =?us-ascii?Q?pFUsOOXWw9es1u5k63rmx92Dlbv1BoyfI+FMMvjkYpYaElMUVNH+wSlBcBWO?=
 =?us-ascii?Q?dC/XGtUyOPZuD+oyCjMf5XuBJbBNc6NG7D2HuiO+qAFGyEueOewKvz2lITM8?=
 =?us-ascii?Q?egeSL4fXglki3li/0Utdi/yLU08+sphgfhfTgc/tGcDw3mCumlwGJ1st3tX4?=
 =?us-ascii?Q?ZjezyHByQVGwOEf01SIjONSEieK0BmYxvFNCbPxStQLElnWn00/HblupBkeb?=
 =?us-ascii?Q?qnCTvB2h0ElRDal2jEoRHj/wbKEyOF5zThlU8HU/SuCydE0VQie+VMHXfy9G?=
 =?us-ascii?Q?vw5dCabeHJbKYwXGWfNFaWPrFddUyA1bCXPB+ulqzeQsq8tvqq1f0G9rrHAu?=
 =?us-ascii?Q?F5cZCrz3nNqtT+cv61ie1ASmOnmXbZNA8+7768FKlCiC7p4ClExlNTovlL01?=
 =?us-ascii?Q?Q68xUV5QpxRNct9ewBcgtbmlKbBZyPzQDmnTRuDLlRCs5KgbvPQc9arthcmZ?=
 =?us-ascii?Q?Hyh8MQWlQcGSxh3O8sDZFo8oAQc69QJ3D1660GCI5ILsmW5vwDsAVzmJqFLl?=
 =?us-ascii?Q?hs8gPC8i2XC43Dlhnu9FYRygW5TPIIoiZ5dJdIaroNYbFxWnq0BfCvBj6XQw?=
 =?us-ascii?Q?mpGyBe/d2neZQ4JEb8armJIKNpHznZIMsTOCvqYOwEg/o3tk9DE9CBcyhxpY?=
 =?us-ascii?Q?dAI/S/0fnoVLCJbYI6psZwGCmvhafX2N2kjjYX4Y9Fmcco/as9rsmOXrwnnX?=
 =?us-ascii?Q?26JSLLcdXGWbx4Vkl+dJOxhGoeHyRnqKzQwwyVoPhJpPyMlXIk16oJ6CnK+l?=
 =?us-ascii?Q?oTBokkS2ChzM5rYMNjPZO4v2bTdw3Y/EJxNEso8utOePZWUBeRVYCakCDXol?=
 =?us-ascii?Q?l4sbntWP751iUjw/+lxIONmNhVoP5PLkEJ/4dy6HTtSt/ZWL8jhK4Y8bf9zb?=
 =?us-ascii?Q?lFEMLj9oNo6PW37YykfX4K97caaA+ADOypaQzzJlvi6x4+gnIAIYaLTQTDJq?=
 =?us-ascii?Q?dZkpJJDj0TYfXtrF0ToQXUNAK6Eyyak3GgfLPfcnGIPXgmMQGUepS+ywe6Tn?=
 =?us-ascii?Q?9fDhAeTXw5ViAS3STmWphtQYcxvaulH7MqXAjU379QUHZJ2MQkFdBxiXaEWP?=
 =?us-ascii?Q?7KfCtQ=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: diasemi.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DB9PR10MB4652.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: e5bd8a1b-1056-4a36-e948-08d9b8f51d00
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Dec 2021 20:15:14.1339
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 511e3c0e-ee96-486e-a2ec-e272ffa37b7c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Uh9q6Le8bYdc7qRNkl447T3MQrpgK1vnMyHJSKsAj+/guPMAGUuN3RdKjhJY8VLC67wyOplT1CtsiW4GxPUeuqS0z+1gABeZIbZWrQoOc78=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB6PR1001MB1207
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06 December 2021 06:47, Andrej Picej wrote:

> Make the config register CONFIG_I writable to change the watchdog mode.
>=20
> Signed-off-by: Andrej Picej <andrej.picej@norik.com>
> ---

Reviewed-by: Adam Thomson <Adam.Thomson.Opensource@diasemi.com>
