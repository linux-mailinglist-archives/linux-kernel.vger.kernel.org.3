Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 550DA49F314
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jan 2022 06:37:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346207AbiA1Fhd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jan 2022 00:37:33 -0500
Received: from mailgw02.mediatek.com ([210.61.82.184]:55566 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S232705AbiA1Fhc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jan 2022 00:37:32 -0500
X-UUID: 00ecf590f6174423b151881531f04bec-20220128
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=MIME-Version:Content-Transfer-Encoding:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=UCX8Wn9lEVuYLGW4IDJ2Rppshprnv54N2aWaJuBu3ks=;
        b=JIPlPmLdIYR6znY1hdm7esAzVLi4fNTMWxady0gV45YVnFnGbaBSxul5GJzffJ9FNDcgettDT77wJv4NyePLmycL4Zfx74wXOjw3SmBpNZxzwqBnsCy2AP8DG8C2ohDTu9LV12eB7CPH6RpRXBt6U/yxSk/GhZVyPIVOkIBLBW0=;
X-UUID: 00ecf590f6174423b151881531f04bec-20220128
Received: from mtkcas11.mediatek.inc [(172.21.101.40)] by mailgw02.mediatek.com
        (envelope-from <xinlei.lee@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 127448711; Fri, 28 Jan 2022 13:37:30 +0800
Received: from mtkexhb02.mediatek.inc (172.21.101.103) by
 mtkmbs07n1.mediatek.inc (172.21.101.16) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Fri, 28 Jan 2022 13:37:29 +0800
Received: from mtkmbs10n1.mediatek.inc (172.21.101.34) by
 mtkexhb02.mediatek.inc (172.21.101.103) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Fri, 28 Jan 2022 13:37:29 +0800
Received: from APC01-HK2-obe.outbound.protection.outlook.com (172.21.101.239)
 by mtkmbs10n1.mediatek.com (172.21.101.34) with Microsoft SMTP Server id
 15.2.792.15 via Frontend Transport; Fri, 28 Jan 2022 13:37:28 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dbiaAtrUUxlCKGVLARR8WZGMH46KZVH5mocMcFxe+fKnjUddTp+gWxmjZ6fnwF+wNdYnobW32lNNgmlikHprwd678KcHEDoJuGSAA0oJgy3gPP+M+3aUjEgxaQmTXlEZoKUg/Q0KuC1wdvFVF35OGtmytiFzqpHmLzX7Hle4IgjtP1lbTgIbxtimZAK3GxOJv3kVdru7vj9wbW63pbSTk/F3EqbEO+P90NkwWIqq8nuCOGhUiYo6gVIaRJtJW11MDFdgKNtq6OCIHnz2rQLh08b+jRySMIVZSRDUl5DDkhxWxYF21sI4DnzWXKTTGUQgj0uMluRXnPVzp64wPdRJvA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UCX8Wn9lEVuYLGW4IDJ2Rppshprnv54N2aWaJuBu3ks=;
 b=TkyQaYRB1Pb/l7BFrY/3TQ1IE/pMMQI9iR+KeTKDlCCIp++Z3WEAFJ1MT1IH191/5zCcpEmAYiX105XS4cYqySE/PmBCKf0E8/TFy6n3vfg2zcnMJAD9HorUEEqrctjNq5D4pRYJUGS8mG1CeFa9YqX9VAsPKmjvTIygYBf7xtZiYd7frFioWzhAy9/NOKBjb8JZJJ/a6apOOlfeQGBFeXc4pJ+msxkGHl0eU5wDqd6O4dyKO0u5RFB6owdqjaq4VepIZcem73YOhA4ZbVbbjAp63YQrcyuAp1MUS3kndu6GAhrOTJfT+gERlWWY7irBqSIn+YHuIwTV3HPKudjmfA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UCX8Wn9lEVuYLGW4IDJ2Rppshprnv54N2aWaJuBu3ks=;
 b=PqAnLbLP/dH4pxp77WldnoVVvoHwV/eMZzFwiS5YwXEKd2CrsJaBGo2Zn5wuqFMBSdd0NjWNrzxBZO8QmOpmjm72Yh6xvp4RVa1C+SlvzN+JH0If3vOHmMcFJEIeuMuRhj/1HqwLTejQk0+YxXdujevtp+rMEGGA8i26VuxDWfc=
Received: from TYZPR03MB5344.apcprd03.prod.outlook.com (2603:1096:400:31::7)
 by KL1PR03MB5890.apcprd03.prod.outlook.com (2603:1096:820:80::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4951.5; Fri, 28 Jan
 2022 05:37:27 +0000
Received: from TYZPR03MB5344.apcprd03.prod.outlook.com
 ([fe80::2d32:bd6b:b270:9fee]) by TYZPR03MB5344.apcprd03.prod.outlook.com
 ([fe80::2d32:bd6b:b270:9fee%4]) with mapi id 15.20.4951.005; Fri, 28 Jan 2022
 05:37:27 +0000
From:   =?utf-8?B?WGlubGVpIExlZSAo5p2O5piV56OKKQ==?= 
        <Xinlei.Lee@mediatek.com>
To:     =?utf-8?B?Q0sgSHUgKOiDoeS/iuWFiSk=?= <ck.hu@mediatek.com>,
        "chunkuang.hu@kernel.org" <chunkuang.hu@kernel.org>,
        "p.zabel@pengutronix.de" <p.zabel@pengutronix.de>,
        "airlied@linux.ie" <airlied@linux.ie>,
        "daniel@ffwll.ch" <daniel@ffwll.ch>,
        "matthias.bgg@gmail.com" <matthias.bgg@gmail.com>
CC:     "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "linux-mediatek@lists.infradead.org" 
        <linux-mediatek@lists.infradead.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        srv_heupstream <srv_heupstream@mediatek.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        =?utf-8?B?Sml0YW8gU2hpICjnn7PorrDmtpsp?= <jitao.shi@mediatek.com>,
        =?utf-8?B?UmV4LUJDIENoZW4gKOmZs+afj+i+sCk=?= 
        <Rex-BC.Chen@mediatek.com>
Subject: =?utf-8?B?562U5aSNOiBbdjEsIDMvM10gZHJtL21lZGlhdGVrOiBNb3ZlIHRoZSBnZXR0?=
 =?utf-8?B?aW5nIGJyaWRnZSBub2RlIGZ1bmN0aW9uIHRvIG10a19kc2lfYmluZA==?=
Thread-Topic: [v1, 3/3] drm/mediatek: Move the getting bridge node function to
 mtk_dsi_bind
Thread-Index: AQHYFAR2jZRDrXwP4kiqeXgAs7nTRax36KQQ
Date:   Fri, 28 Jan 2022 05:37:27 +0000
Message-ID: <TYZPR03MB5344CE852F15848254D4FC18F6229@TYZPR03MB5344.apcprd03.prod.outlook.com>
References: <1643283773-7081-1-git-send-email-xinlei.lee@mediatek.com>
         <1643283773-7081-4-git-send-email-xinlei.lee@mediatek.com>
 <092258211c47eca805c4dea6c4bf4ecc4c246cea.camel@mediatek.com>
In-Reply-To: <092258211c47eca805c4dea6c4bf4ecc4c246cea.camel@mediatek.com>
Accept-Language: zh-TW, en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-dg-ref: PG1ldGE+PGF0IG5tPSJib2R5LnR4dCIgcD0iYzpcdXNlcnNcbXRrMjUyODNcYXBwZGF0YVxyb2FtaW5nXDA5ZDg0OWI2LTMyZDMtNGE0MC04NWVlLTZiODRiYTI5ZTM1Ylxtc2dzXG1zZy01ZGY2NGUzYS03ZmZjLTExZWMtOTFiNC01ODZjMjU0ZWU3ZmFcYW1lLXRlc3RcNWRmNjRlM2MtN2ZmYy0xMWVjLTkxYjQtNTg2YzI1NGVlN2ZhYm9keS50eHQiIHN6PSIzMzAxIiB0PSIxMzI4NzgyMTg0MzY3NjM2NzYiIGg9InN2WnNYL0N2YU9tNkJXSXpLdjhGcUJJOFVPTT0iIGlkPSIiIGJsPSIwIiBibz0iMSIvPjwvbWV0YT4=
x-dg-rorf: true
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 55d1e805-425e-4827-09bc-08d9e2204510
x-ms-traffictypediagnostic: KL1PR03MB5890:EE_
x-ld-processed: a7687ede-7a6b-4ef6-bace-642f677fbe31,ExtAddr
x-microsoft-antispam-prvs: <KL1PR03MB58903C087E540A71FC938B92F6229@KL1PR03MB5890.apcprd03.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6108;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: m/xG0s+qL85JO8y8p9x/mKPVrmT3tB69rQrfbV3eNXIYawuUCxAim6Ix43p+k7KMAsrDJQ8Vec/GjQUMDa98QC2XPlBNNoNvsvrRfKad+/MxXJyybYVOjPB3fAGge7hyHPhpG/wRSRbd3RZt6eklZ57WfKwKNFx48rF8alVT9szLNW32bnN3bVDXa9e5icI7kGsCf9TkP+PTF+vhlKgbJ+xIHDAlljgNSYDAETUW1Cwa6GuwNpM1+4TxLliWqk155+MEeLXWFfBCER+cCHVfOIjbbiMdMYUmZgGbWW+V6OKV3MgvazQGKYWZo9UcRVENC3xI/Kl8pp2bsTUEvfMWw7gezNXXtBiiQnlB/4xLO3SYOFNVb/8GknM6VatvJpEDGet1LbXAWh8jCArI+UuOabgBtDRVn9wi2D8vJ0sSBT40XYgzM5JVdBf8Aw6n656Ic9klpCbsx2STtmM++/3Cr+312tCV47Eph0q8JRu2r9geKz4HzalYsq9gXtb6YsyFVENBo+5oOac2eSGOfF+QSe+aZ6ODinvq5lo6rSgHKrsTfTT66bhTVO231HR64bLofJPvctPs/ROEprDwZ2HGqgJEVe5Q0FHFw8freOtQcfDowzLjuD+kbWsHf7n0j02cRFTUu3oPqcoLrJU3xF6WNOdWDK3X7lvBBSVhb1OWAS8oPMTl7VqACV0XbBxrQ+gokBAav3X8Bj7jR5X3GDqT8f87O/xba6NH7rUkd0GsOeOtAbVejSjzoCrCHhI0RaAP2F0d2EzBrsLA/ZEIFNBwHsxN9J2NDMQgHxV7wbMorcA=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYZPR03MB5344.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(76116006)(508600001)(64756008)(66446008)(66476007)(66946007)(8936002)(4326008)(6506007)(7696005)(86362001)(66556008)(316002)(71200400001)(224303003)(110136005)(38070700005)(9686003)(85182001)(966005)(38100700002)(52536014)(54906003)(55016003)(107886003)(122000001)(5660300002)(2906002)(186003)(83380400001)(33656002)(26005)(20210929001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?OWw0TlVNRmlSUURQUUNudjhhZ0pQWTBoUFl3SGp5ZjFMdG40V0VTZExVWVZk?=
 =?utf-8?B?VFM3Zis3T1pGTFltWithajNBSUM4ZDVsckYwWllWNHBsa3Z3Y3FRSE9qR1JP?=
 =?utf-8?B?b1NhVjBvZU4zWTNxR3p4bGJaZ0VackdrYTQzd0NFVDRpWitRZTFNaG8yLzdk?=
 =?utf-8?B?aUVOa0tNZ2tsRFUzYVMvSFBmYXNZdW8xeUgwcjhKQk5DbjE0bFdkdHBweFpY?=
 =?utf-8?B?THlHWDFDOUpXd3lRTWdYR2QrVllocmI5cU9UUkdlUGtqN3grY0JVR3pma0gz?=
 =?utf-8?B?NitHZjl6aEhINTN2Z2lIclNnMlN6a3RHSkZLU1RFSzdlZWhOeDJ6QjlxNjRE?=
 =?utf-8?B?c245QTM1Rm5vZkMzT1FYNFdBdEhDaE9ZZFFrV2xIYmNHckN3WEV0MzVnZDZk?=
 =?utf-8?B?SXFZSGFySDEzVVpwRUhiWlI0QU5uckhRcUZ5Y0t5YlBOYS9abkJleWtFbW9y?=
 =?utf-8?B?cEJ3ZkpKZElCZXU4c1haMXFvdnhCV3FERzMxQWtYRGVkRUFrcS9hd1EwWUdV?=
 =?utf-8?B?cTArYmc4Z1ZlUmdIdWtjS25waWVCem92U0psakRHcUErZzFVdVMrK0VYdW90?=
 =?utf-8?B?Vm00czZQUDJPbmhYSmVoSEVtSnJEWFlWazZZNEMwQzhKbmFOUFBmY2tITm9u?=
 =?utf-8?B?NGEzRGpxNWdRSW5RV3NGV0Fjbjd2WlBDM3J5L3BTYnhPaHo0NDVDSjd5NDVV?=
 =?utf-8?B?bm56V05lNjd1bURCeTU3K0FRSXFrSTh4RW1iZUcyYVk0UFFITjU1YXBha0JK?=
 =?utf-8?B?K3FwS285S0N0ZGNla3p3RUFiLzI5OEF2QzlyZGRudjlpVTVsaGJqSDJoLzhJ?=
 =?utf-8?B?cEtONmJ4cG5lbTd2aHNRckkvaThvVS9JM25lRnUxZkFKWFQ0czVyMDQwb01x?=
 =?utf-8?B?QjFsZ2swTDlDTUlFckR4eE9pTDRieXZqUlNTaEhOWHE5ZkdBK2FjT1lqLy8v?=
 =?utf-8?B?SUp3UkxydTY4bG92NTZPeHdNanc1OVRoVEhra203V1JtbXUyQVRlWE12Y0Rp?=
 =?utf-8?B?cVYwREpGVG52aVYwME9WcHdpdllmblpHWWhqbDBGSEQ2MWZzRnVpU25rekh0?=
 =?utf-8?B?SmgrY0lvdXpKZzJCOU5GaDJSODRob3VBSUo4TmZkYVB3dHg0NU1IRGwxNmsv?=
 =?utf-8?B?b3lrWUlhYzJuRFFka25IRXpDUVJ3Y2FYaFhaZlpjQ2pHU0sxeVQ5S2xZOWdU?=
 =?utf-8?B?eTRDNDQ2MjQ4VDJvdTBDeUY2REQwRUpibEIzQk92L3ZZd1UrQWl4UXVNRWZD?=
 =?utf-8?B?Z0hZb2dWZWFBYzZ3UGRNeHhUbzVmZnE5QXpOOXlzT1grTzhBWE11aExtREEz?=
 =?utf-8?B?U3pmYm1wbFRqc0ZrVWZXMmdYWHdnTTFTUU43Q1hkMWRRd3REZ0JBVW81L3FX?=
 =?utf-8?B?ZkdheHZSQy9MWkpINzNvR1JPY0pzMlhLTkNMcHlPVE9QazJ5UWdHaXhvc1BD?=
 =?utf-8?B?ZXpXSWsxcHlrc1VVeHRJWTIzWXpIUE0zcllaYnI4MzZHeEFJQlZkSzNaVUZ6?=
 =?utf-8?B?dkUxdS9VczhLbnlLRHl5NXY0TFk3VDhzWC9MRGQvYldpQ09tbUgreEZBakk0?=
 =?utf-8?B?NnZ2YkxrSXVjQkpJTUtndEI3cS8wNERwbURFTXNqbm5hQnZtdmNXVUdNbkt2?=
 =?utf-8?B?TVNBdGhrbVl6cDhva1BFRnZnemNhVGZKN1BJckptT1JIbW4yL1lWZjFLMDd2?=
 =?utf-8?B?cnBUOGhHazkxTWFickpubDVZc0hweFNPMm04TEFndkt5Z1NCeWczOXRFRnNJ?=
 =?utf-8?B?NTVYQ1YxYkMreEtwallzNTUwZ0pMK0dkSUFFYkoxZ0ZTVk5rbkdpczN4SWpQ?=
 =?utf-8?B?bVB2TElqM05xUmlVQTVMM3ZTRDJTQ3B1WWpxd0xEZm42c3VIbEUrQkdpa0RL?=
 =?utf-8?B?d2lYV01WbmdFNWJpcWFGcFhSQ2JEU1hRelEveWJJUmdxNkdTRWtkRUdoMG9Z?=
 =?utf-8?B?R1BEYnVPN2pzVm5SSmNMc0IvNXRadVc5TXhva29mdk4vNGxlejRwUGY0UEFI?=
 =?utf-8?B?WVdrbEY3ajREVVJZNGdiM05qU3JXNXp0UEJtbStsQ0FpamNlQmtZclBSZEhp?=
 =?utf-8?B?ZmFjMUJqUWpQZEJ2T010a0kzVHFXZG1jNzY0U1JKTFlhSlY2RHgzekg5ZEZt?=
 =?utf-8?B?S3RsUXhNa2YyTlVLRXpFU0lDTWIxYnBwd2p3SUcxL0R1cDZxMU03elVHY0ti?=
 =?utf-8?B?cUE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYZPR03MB5344.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 55d1e805-425e-4827-09bc-08d9e2204510
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Jan 2022 05:37:27.4364
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: FYBcrBUu2GCzp6ne2dtS6Gmt+8Dh/8CEAXqSbwpBRic2RcJ7Oc6TpanXXjkkLbNJk1IlZsXrn5N7eV00fKSxmQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1PR03MB5890
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGksIENLOg0KDQoJQXMgeW91IGRlc2NyaWJlLCB0aGVzZSB0d28gcGF0Y2hlcyBtb2RpZnkgdGhl
IHNhbWUgdGhpbmcsIGxldCdzIGlnbm9yZSB0aGlzIHBhdGNoLg0KCVRoYW5rcyBmb3IgeW91ciBz
dWdnZXN0aW9uLg0KDQpCZXN0IFJlZ2FyZHMsDQp4aW5sZWkNCg0KLS0tLS3pgq7ku7bljp/ku7Yt
LS0tLQ0K5Y+R5Lu25Lq6OiBDSyBIdSBbbWFpbHRvOmNrLmh1QG1lZGlhdGVrLmNvbV0gDQrlj5Hp
gIHml7bpl7Q6IDIwMjLlubQx5pyIMjjml6UgMTM6MDQNCuaUtuS7tuS6ujogWGlubGVpIExlZSAo
5p2O5piV56OKKTsgY2h1bmt1YW5nLmh1QGtlcm5lbC5vcmc7IHAuemFiZWxAcGVuZ3V0cm9uaXgu
ZGU7IGFpcmxpZWRAbGludXguaWU7IGRhbmllbEBmZndsbC5jaDsgbWF0dGhpYXMuYmdnQGdtYWls
LmNvbQ0K5oqE6YCBOiBkcmktZGV2ZWxAbGlzdHMuZnJlZWRlc2t0b3Aub3JnOyBsaW51eC1tZWRp
YXRla0BsaXN0cy5pbmZyYWRlYWQub3JnOyBsaW51eC1hcm0ta2VybmVsQGxpc3RzLmluZnJhZGVh
ZC5vcmc7IHNydl9oZXVwc3RyZWFtOyBsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnOyBKaXRh
byBTaGkgKOefs+iusOa2mykNCuS4u+mimDogUmU6IFt2MSwgMy8zXSBkcm0vbWVkaWF0ZWs6IE1v
dmUgdGhlIGdldHRpbmcgYnJpZGdlIG5vZGUgZnVuY3Rpb24gdG8gbXRrX2RzaV9iaW5kDQoNCkhp
LCBYaW5sZWk6DQoNCk9uIFRodSwgMjAyMi0wMS0yNyBhdCAxOTo0MiArMDgwMCwgeGlubGVpLmxl
ZUBtZWRpYXRlay5jb20gd3JvdGU6DQo+IEZyb206IHhpbmxlaSBsZWUgPHhpbmxlaS5sZWVAbWVk
aWF0ZWsuY29tPg0KPiANCj4gVGhlIG9yZGVyIG9mIHByb2JlIGZ1bmN0aW9uIGZvciBicmlkZ2Ug
ZHJpdmVycyBhbmQgZHNpIGRyaXZlcnMgaXMgDQo+IHVuY2VydGFpbi4NCj4gVG8gYXZvaWQgdGhl
IGRzaSBwcm9iZSBjYW5ub3QgYmUgZXhlY3V0ZWQsIHdlIHBsYWNlIGdldHRpbmcgYnJpZGdlIA0K
PiBub2RlIGZ1bmN0aW9uIGluIG10a19kc2lfYmluZC4NCg0KSXQgc2VlbXMgdGhpcyBwYXRjaCB3
YW50IHRvIGZpeCB0aGUgc2FtZSBwcm9ibGVtIGFzIFsxXS4gRG9lcyBbMV0gZml4IHlvdXIgcHJv
YmxlbT8gSWYgc28sIGxldCdzIGlnbm9yZSB0aGlzIHBhdGNoLg0KDQpbMV0NCmh0dHBzOi8vcGF0
Y2h3b3JrLmtlcm5lbC5vcmcvcHJvamVjdC9saW51eC1tZWRpYXRlay9wYXRjaC8yMDIyMDEyNzE0
MzYyMy4xMjMwMjUtMS1hbmdlbG9naW9hY2NoaW5vLmRlbHJlZ25vQGNvbGxhYm9yYS5jb20vDQoN
ClJlZ2FyZHMsDQpDSw0KDQo+IA0KPiBTaWduZWQtb2ZmLWJ5OlhpbmxlaSBMZWUgPHhpbmxlaS5s
ZWVAbWVkaWF0ZWsuY29tPg0KPiAtLS0NCj4gIGRyaXZlcnMvZ3B1L2RybS9tZWRpYXRlay9tdGtf
ZHNpLmMgfCAyOSArKysrKysrKysrKysrKystLS0tLS0tLS0tLS0tDQo+IC0NCj4gIDEgZmlsZSBj
aGFuZ2VkLCAxNSBpbnNlcnRpb25zKCspLCAxNCBkZWxldGlvbnMoLSkNCj4gDQo+IGRpZmYgLS1n
aXQgYS9kcml2ZXJzL2dwdS9kcm0vbWVkaWF0ZWsvbXRrX2RzaS5jDQo+IGIvZHJpdmVycy9ncHUv
ZHJtL21lZGlhdGVrL210a19kc2kuYw0KPiBpbmRleCA2MmFmNjBkLi5hMzkwZjI2IDEwMDY0NA0K
PiAtLS0gYS9kcml2ZXJzL2dwdS9kcm0vbWVkaWF0ZWsvbXRrX2RzaS5jDQo+ICsrKyBiL2RyaXZl
cnMvZ3B1L2RybS9tZWRpYXRlay9tdGtfZHNpLmMNCj4gQEAgLTk5MSw2ICs5OTEsMjEgQEAgc3Rh
dGljIGludCBtdGtfZHNpX2JpbmQoc3RydWN0IGRldmljZSAqZGV2LCANCj4gc3RydWN0IGRldmlj
ZSAqbWFzdGVyLCB2b2lkICpkYXRhKQ0KPiAgCWludCByZXQ7DQo+ICAJc3RydWN0IGRybV9kZXZp
Y2UgKmRybSA9IGRhdGE7DQo+ICAJc3RydWN0IG10a19kc2kgKmRzaSA9IGRldl9nZXRfZHJ2ZGF0
YShkZXYpOw0KPiArCXN0cnVjdCBkcm1fcGFuZWwgKnBhbmVsOw0KPiArDQo+ICsJcmV0ID0gZHJt
X29mX2ZpbmRfcGFuZWxfb3JfYnJpZGdlKGRldi0+b2Zfbm9kZSwgMCwgMCwNCj4gKwkJCQkJICAm
cGFuZWwsICZkc2ktPm5leHRfYnJpZGdlKTsNCj4gKwlpZiAocmV0KQ0KPiArCQlyZXR1cm4gcmV0
Ow0KPiArDQo+ICsJaWYgKHBhbmVsKSB7DQo+ICsJCWRzaS0+bmV4dF9icmlkZ2UgPSBkZXZtX2Ry
bV9wYW5lbF9icmlkZ2VfYWRkKGRldiwNCj4gcGFuZWwpOw0KPiArCQlpZiAoSVNfRVJSKGRzaS0+
bmV4dF9icmlkZ2UpKSB7DQo+ICsJCQlyZXQgPSBQVFJfRVJSKGRzaS0+bmV4dF9icmlkZ2UpOw0K
PiArCQkJZGV2X2VycihkZXYsICJmYWlsZWQgdG8gYWRkIGJyaWRnZTogJWRcbiIsDQo+IHJldCk7
DQo+ICsJCQlyZXR1cm4gcmV0Ow0KPiArCQl9DQo+ICsJfQ0KPiAgDQo+ICAJcmV0ID0gbXRrX2Rz
aV9lbmNvZGVyX2luaXQoZHJtLCBkc2kpOw0KPiAgCWlmIChyZXQpDQo+IEBAIC0xMDE2LDcgKzEw
MzEsNiBAQCBzdGF0aWMgaW50IG10a19kc2lfcHJvYmUoc3RydWN0IHBsYXRmb3JtX2RldmljZQ0K
PiAqcGRldikNCj4gIHsNCj4gIAlzdHJ1Y3QgbXRrX2RzaSAqZHNpOw0KPiAgCXN0cnVjdCBkZXZp
Y2UgKmRldiA9ICZwZGV2LT5kZXY7DQo+IC0Jc3RydWN0IGRybV9wYW5lbCAqcGFuZWw7DQo+ICAJ
c3RydWN0IHJlc291cmNlICpyZWdzOw0KPiAgCWludCBpcnFfbnVtOw0KPiAgCWludCByZXQ7DQo+
IEBAIC0xMDMzLDE5ICsxMDQ3LDYgQEAgc3RhdGljIGludCBtdGtfZHNpX3Byb2JlKHN0cnVjdCBw
bGF0Zm9ybV9kZXZpY2UgDQo+ICpwZGV2KQ0KPiAgCQlyZXR1cm4gcmV0Ow0KPiAgCX0NCj4gIA0K
PiAtCXJldCA9IGRybV9vZl9maW5kX3BhbmVsX29yX2JyaWRnZShkZXYtPm9mX25vZGUsIDAsIDAs
DQo+IC0JCQkJCSAgJnBhbmVsLCAmZHNpLT5uZXh0X2JyaWRnZSk7DQo+IC0JaWYgKHJldCkNCj4g
LQkJZ290byBlcnJfdW5yZWdpc3Rlcl9ob3N0Ow0KPiAtDQo+IC0JaWYgKHBhbmVsKSB7DQo+IC0J
CWRzaS0+bmV4dF9icmlkZ2UgPSBkZXZtX2RybV9wYW5lbF9icmlkZ2VfYWRkKGRldiwNCj4gcGFu
ZWwpOw0KPiAtCQlpZiAoSVNfRVJSKGRzaS0+bmV4dF9icmlkZ2UpKSB7DQo+IC0JCQlyZXQgPSBQ
VFJfRVJSKGRzaS0+bmV4dF9icmlkZ2UpOw0KPiAtCQkJZ290byBlcnJfdW5yZWdpc3Rlcl9ob3N0
Ow0KPiAtCQl9DQo+IC0JfQ0KPiAtDQo+ICAJZHNpLT5kcml2ZXJfZGF0YSA9IG9mX2RldmljZV9n
ZXRfbWF0Y2hfZGF0YShkZXYpOw0KPiAgDQo+ICAJZHNpLT5lbmdpbmVfY2xrID0gZGV2bV9jbGtf
Z2V0KGRldiwgImVuZ2luZSIpOw0KDQo=
