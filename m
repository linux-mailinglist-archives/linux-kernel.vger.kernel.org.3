Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9D03346996B
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Dec 2021 15:47:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344623AbhLFOvV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Dec 2021 09:51:21 -0500
Received: from mailgw02.mediatek.com ([210.61.82.184]:49374 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S237563AbhLFOvT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Dec 2021 09:51:19 -0500
X-UUID: b0cbf87fa0cc44f5b0ecc4cec042812d-20211206
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=MIME-Version:Content-Transfer-Encoding:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=j1IWWPpnpPtjbA/xPDcfmppDEyYymzl9DIAAK72gq+I=;
        b=QjVZkOXEa1Zxp0mjt1anO7FNRXYHREd96Ir8HRHj7FUvFTLSAIe99FyT+w41icMHwtILX27pNyq6EStFO84GBKPCT5UBiNWTmrdcj8QTwiIIL7pFmtitKB3AMFVqpoVMflrgEU0sn6L6OqbUzKqfhD/qVLX2LapUI35prfu1Q/E=;
X-UUID: b0cbf87fa0cc44f5b0ecc4cec042812d-20211206
Received: from mtkmbs10n1.mediatek.inc [(172.21.101.34)] by mailgw02.mediatek.com
        (envelope-from <mark-yw.chen@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 1719651498; Mon, 06 Dec 2021 22:47:47 +0800
Received: from mtkmbs10n2.mediatek.inc (172.21.101.183) by
 mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.792.3;
 Mon, 6 Dec 2021 22:47:46 +0800
Received: from APC01-PSA-obe.outbound.protection.outlook.com (172.21.101.239)
 by mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server id
 15.2.792.3 via Frontend Transport; Mon, 6 Dec 2021 22:47:46 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OQdgz+k3m3xYXF6Fstwib7dKFuIrpoQaCfxecTVVIp9J5KpI+cHih66ziFdXYhuDzc0i5xu5YHow5qVIX5mXO8h34vp2pqOyLwsd00Kj/f/cNJ5ATWvBzDepXic6cAPfH26yE5tIe4J4cOyEDoUvzlRpr44KDlVqo87L4UWcK0RwvsNAbmHyEFLCmQj1OjPEbjh+Puei2+Cu04YJwZBAUijYlmxEvL9c2gqArunp17L4l6RFfl7QS+pvj0VbcrUN8zgWw8ZFPIRL7nxQB9ar5qnInrMIujy+bqxLz1BDue/NgYNcnFVUR/zzxM0+RuUk9vu619MRiezzunYI5sKvag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=j1IWWPpnpPtjbA/xPDcfmppDEyYymzl9DIAAK72gq+I=;
 b=WCya+4lddCVIkj4/ShzFG9MMNY/T5sQAf4tFDSKS7zZOX8u3BDysbDm+yJ7TphiBJxqN3wmEXrzklAytyXigR4vlYNTAXnlXShaiKYFkcdKIRjUN6A/y8Ybu1S256Rn8JkPVZNZT9oWeuxM+dlHdRI8FKX5Ziyw+EhGzFfDC64s+i8el4dE6bY9K3cKqFQD1gHVTKQPt5UZIXtNbvOV9EW4OJfsECubk1Swmz1VSE5JH4EVQdvjvqhx7lEKKWjg7//muj4BmtMqsEwiQrn7ZcUozKzJ9GF13sWya4sWtecGPeWrQiynOFSjBjiaGfvUSYpzdU6210LGWbdBVoE91uw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=j1IWWPpnpPtjbA/xPDcfmppDEyYymzl9DIAAK72gq+I=;
 b=QSb44KXsfnZ93sk1Xkghz3TgfdCmqdE8ioL+YKLzygeNKFHyh/K2muFjGchJSVk5oDkPR4dv3cMz2tvhpjNUdQ4IAdxDMG2YVJ2eLGey2GIPqQ85lgon6ItWsDZW8eJHJO4ALWLp9hItJMUJBrKSTsdCIezwhRgTzB5FsJZry/U=
Received: from SL2PR03MB4457.apcprd03.prod.outlook.com (2603:1096:100:5b::16)
 by SL2PR03MB4603.apcprd03.prod.outlook.com (2603:1096:100:62::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4778.10; Mon, 6 Dec
 2021 14:47:42 +0000
Received: from SL2PR03MB4457.apcprd03.prod.outlook.com
 ([fe80::a504:479b:79da:9c15]) by SL2PR03MB4457.apcprd03.prod.outlook.com
 ([fe80::a504:479b:79da:9c15%3]) with mapi id 15.20.4778.010; Mon, 6 Dec 2021
 14:47:42 +0000
From:   =?utf-8?B?TWFyay1ZVyBDaGVuICjpmbPmj5rmlocp?= 
        <Mark-YW.Chen@mediatek.com>
To:     Paul Menzel <pmenzel@molgen.mpg.de>
CC:     =?utf-8?B?QWFyb24gSG91ICjkvq/kv4rku7Ap?= <Aaron.Hou@mediatek.com>,
        "kaichuan.hsieh@canonical.com" <kaichuan.hsieh@canonical.com>,
        "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
        "linux-mediatek@lists.infradead.org" 
        <linux-mediatek@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "marcel@holtmann.org" <marcel@holtmann.org>,
        "johan.hedberg@gmail.com" <johan.hedberg@gmail.com>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        Sean Wang <Sean.Wang@mediatek.com>
Subject: RE: [PATCH] Bluetooth: btusb: Handle download_firmware failure cases.
Thread-Topic: [PATCH] Bluetooth: btusb: Handle download_firmware failure
 cases.
Thread-Index: AQHX6oNEG+a4uNTdPEWZmxQdgBd/FKwlOGyAgABQi6A=
Date:   Mon, 6 Dec 2021 14:47:42 +0000
Message-ID: <SL2PR03MB44574A50769EABFA9EE3739BB36D9@SL2PR03MB4457.apcprd03.prod.outlook.com>
References: <20211206092546.27216-1-mark-yw.chen@mediatek.com>
 <61e772a7-6e46-7c0f-32ba-b3e3ad88062c@molgen.mpg.de>
In-Reply-To: <61e772a7-6e46-7c0f-32ba-b3e3ad88062c@molgen.mpg.de>
Accept-Language: en-US
Content-Language: zh-TW
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-dg-ref: PG1ldGE+PGF0IG5tPSJib2R5LnR4dCIgcD0iYzpcdXNlcnNcbXRrMTM2NzhcYXBwZGF0YVxyb2FtaW5nXDA5ZDg0OWI2LTMyZDMtNGE0MC04NWVlLTZiODRiYTI5ZTM1Ylxtc2dzXG1zZy03NjQ0OTdjNS01NmEzLTExZWMtOTFiMi0yY2YwNWQ0NmQzNzBcYW1lLXRlc3RcNzY0NDk3YzYtNTZhMy0xMWVjLTkxYjItMmNmMDVkNDZkMzcwYm9keS50eHQiIHN6PSIzODA0IiB0PSIxMzI4MzI3NTY2MTU3OTY3NDkiIGg9Ii9TZjRFNEp5djNhYzNEWG1zTVVqOTNtUnNUWT0iIGlkPSIiIGJsPSIwIiBibz0iMSIvPjwvbWV0YT4=
x-dg-rorf: true
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: cdda3989-d184-4938-a73a-08d9b8c75bd3
x-ms-traffictypediagnostic: SL2PR03MB4603:EE_
x-microsoft-antispam-prvs: <SL2PR03MB4603C892AEA9CF16E2FB5259B36D9@SL2PR03MB4603.apcprd03.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: dt8ydKGxjkgGPuHMCtqqy/GiFsz4Q98QEz9c+VRjNkYOrvnWKM+v29KHTDLXGwKoq2geqW7u84QFIaADsvviTdrChqyum19ixkhyIaipgr99rmTzEh6JiggI3Dw1Rw17UscTdyXOpMS7uApVfakcFX9MVcSDXm3aSerzZq9E/DVutkqHp81so4mI5SgP8S71OrJFyCv2+MvfegRP2ibv6xIxu2KagvBJG04PO9f9N0Jm8VAniAra9R4K8S8wvu3PFsIxs6Y1GDjjpFu69x/rXs8zrljSeE8BboMXefs9eGofByLERuR048/5vGUq8TzCZMQF77TowGsEwCbcPFqd134rKjHu7Z0qhwCdljB0op9+0jua1BpjnRp0pC+fmcutuEOzG1cl1jb0D4YAg3j1oLZup7flraKahYgfh5CRbBNYLFOpFfSkkez9L7mPr23ryBSwOt9ToqYpse0C1eQHJXoHMOAofeVaOrTEVhi5VkPA+KCOuGSrjMrNmJtd79NmX4IuUwyeIt17aL3anLUD47zDZkhYbw4vF6PHpaUfJgIMnJgmReLIQ/0GSjxm2+Dqho+Kn7tgIypEZfxocqHAgVxTg38EAzXvXBhSAj31PODHDzVZFj6cbUzJ9DPgC0elAKbTbXbTMe3qxHt8etty4zy2rmOSr4xPNciI68R/lIOLj0ZVlb+A3xpebwFWEyBUixXD+ZpKXkQEu3VRlvrxJg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SL2PR03MB4457.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(122000001)(38100700002)(6506007)(4326008)(85182001)(71200400001)(5660300002)(26005)(7696005)(186003)(6916009)(8676002)(33656002)(83380400001)(53546011)(66946007)(76116006)(316002)(66446008)(55016003)(54906003)(9686003)(66476007)(8936002)(64756008)(38070700005)(66556008)(86362001)(107886003)(52536014)(508600001)(2906002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?czkwcVFsT21KUjh2NUNHZVI1TTNRZTlYSUVjUFQ4b3hJbzAxcWRrOUVFUTBV?=
 =?utf-8?B?SGdSdy8wK0FpT3Uxb1ZPY2hOcE8wUjdybDU2NzNibzhMcWt6N2NEYnFRSHBs?=
 =?utf-8?B?VlZXSWtaN3oxelhLLzVyejVhenRqSmFvUzJoMUhwbnJ3MWVsZ0ltaEhGL2sy?=
 =?utf-8?B?SVBVdjArZnBGVG96NFl4YnVJeFcvWXNoUUVjNzJhYmZycEhoNVd6SE9oeVps?=
 =?utf-8?B?Y092T0dTaHBNNXV6ckp2bGdRdmJHSGR5MDg1eFVDdTcxZDY2MnFCdkxEdi9r?=
 =?utf-8?B?RHZjd0NUMnVKNjlrV3hqUXZrV2RMa01LcUJhdVZ2bk9GNnpHV0NEL2R6VXU0?=
 =?utf-8?B?SlcwM2RJWEliRmdYOEprZ25GcXRGd1BkYWE5dE96cEZzSlBEdENmR2VpTWEy?=
 =?utf-8?B?aTRrYkZZaTF5REtTeHZrYjFPL2hmYjljZnRTYWdGcmczRXhFTlNJNE5WTTRW?=
 =?utf-8?B?cGZtSW44SkltaFc1bDJQaWFMM2lIa013RklwYXI1eWZvQWsrV0xsbkQyOFlK?=
 =?utf-8?B?TnZNckQvNzlQSkd4NmtGSk5RZkszbG53dEk4NUhEZnd1RjFvSVpraXJKM1Fn?=
 =?utf-8?B?WFFFU0N1djNXdGZaZzI5czBjNXM2ang4cFRkK2lQeVRMM05hU2V3T1p5OFdw?=
 =?utf-8?B?TElYdGV6S1FoZlB1RDNGOTZmWkx2L3FJeTM3V2djaXNMT25uWFNSbnV1K29k?=
 =?utf-8?B?MGExNHB3Wk1EOEVlcTVEUFF3R2RPQjFMSU1oS29Vc281dTA5eTdpd09rd0p4?=
 =?utf-8?B?VlR5b0RkSnNYdmRXN3lEUXZQaHBIWWZEdXQ2NHcvNzkrQUNQSEwreVJNbHpQ?=
 =?utf-8?B?dGhOL1Y2V1J4TXhMdXFGMDZtTmJ1VmZRNFRFK05nSzNzNnRyM2VGekNmeUJH?=
 =?utf-8?B?ejFDamZvZGJyMXRIVTdmSUliOGd0M3ZxNGNPcC81OGtueSt4ejBvUTBJOUxL?=
 =?utf-8?B?b2hKZlhkYjZNblNFbjZyYjUyTDBKWndwSW1NYTc3K0xkOTNtOW1GZXZIRFBE?=
 =?utf-8?B?K2hDcEJxYWJ3YzNqRVV0WHZIVXJ3TUN0LzgxVUtTQ2tBR016eXhCcEN5TkRp?=
 =?utf-8?B?Z3FCNzU5MHBHOEtPQXB6WjVETVJiODA4QUUybHVEWmYvVlcwTnRkUzBydGR4?=
 =?utf-8?B?VGVaWlpjcmF2a3lQRitVU0ZSVlk0OWozUHdrZk1MUVFmOUxLdDhFbjhVNm5j?=
 =?utf-8?B?ZGhVNlE4bU5VSXZJWEVyK2EyN1UrQnNnSWNrNEJnNGMxSVU1NFZjdG5EL05U?=
 =?utf-8?B?RXNWSlpsaHVoVWYrbkNSTUh2TmhPY2I5cVJqc3NuSCtZaC9WMlZnbzhCUDBR?=
 =?utf-8?B?OXBNYWttZm84d1M1M2YvM1NnaWNVQjh3d1lzbDVMdkZUK3EyTVBVZnV5TUNC?=
 =?utf-8?B?WXFuYng4Y2Eyd0NHS1ludmdUSHRlemUxVlVzUkJRYjhNS2RUK0RlWHdRSmNC?=
 =?utf-8?B?cWVGZlBNdnpEeENFaDJRRFdCcWlhUDZuME8zQnlmMFc4dnpsZ0xRNGVSK1Vx?=
 =?utf-8?B?czFOblR1dGJPalptV0k4UU02dDU3b1FoaW1acXZBMHYxK2hNendmTjl5TlJI?=
 =?utf-8?B?MlY1YlFjR1B5d25VWU1VOWxwZlhKNFA5cUs1Q0tpdU95NFBFUWpWcjRTdnNw?=
 =?utf-8?B?Z0hQcFQ1V1FUdit6bEZvY0RMZW5nMWFwWElTWm1nYThTV1BJcWg4UGxmWkJF?=
 =?utf-8?B?RDhyNG5iMUNiQ1c2VEdiZVhwSnhVL0FielhXb0ZQSnVQanB6TE5XVm9sS1A2?=
 =?utf-8?B?MFNQdTBmZDhEbnFJMjhQeFhGRkZjamdxSUt1aFJXbXpOeUZSMkdrS2lEd05j?=
 =?utf-8?B?RVpFbzhCQytOKytMMk9nUGJjNzJ5cWN4b2dLWTU3eDlYQjZ4L3pMVDBBNFRY?=
 =?utf-8?B?Ym1qUVhKMFpMaHJFS2k1UThVaytyZmQ1Zk5NVjlWaDIrUkgrMWprMUhWOW5a?=
 =?utf-8?B?K1Y1cSt5UXhvc2xzQitQODdoZ2k3UWcxdGhSaEpqd3hFcXd6cEJqcVJFRDNP?=
 =?utf-8?B?aWpXZk9jaWdMUVFkcGdCOFZzWGd2WEMxRkRpOTJPMkxvbmNBQ3VrODBGbUZ4?=
 =?utf-8?B?NEtVR3BNLzBDdm43THdkYVd2U2xiV2dXVjdwcDR4dStjWWxmOElxUXN6YUl5?=
 =?utf-8?B?K3V4N2lDTXFub016bzNUb0lMOGw1aVQ4VFNDRU5pTWp5QWxpZlJXZjBlc1FB?=
 =?utf-8?B?WnNmMXlwOUNOR3pBQVpwTWpIOXB4VjNQZVdvcW8wUDNGcTUwNnVEYXBGZ2ZZ?=
 =?utf-8?B?b2E2Vy9adG1RSEpwSnhDa1BaYW5BPT0=?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SL2PR03MB4457.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cdda3989-d184-4938-a73a-08d9b8c75bd3
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Dec 2021 14:47:42.6829
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: AsldkZm0uC73YVtn2p21DaZYafVnr0CJidK7TjGGlyrpdb6DMN3w2qVI+Fn/JoqePIyKvF/HkpKnvf8+WyK9h9wiGISRgRTDmlOMMihpMsI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SL2PR03MB4603
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgUGF1bCwNCg0KVGhhbmtzIGZvciB5b3VyIGNvbW1lbnQuDQoNCj4gLS0tLS1PcmlnaW5hbCBN
ZXNzYWdlLS0tLS0NCj4gRnJvbTogUGF1bCBNZW56ZWwgPHBtZW56ZWxAbW9sZ2VuLm1wZy5kZT4N
Cj4gU2VudDogTW9uZGF5LCBEZWNlbWJlciA2LCAyMDIxIDU6NTEgUE0NCj4gVG86IE1hcmstWVcg
Q2hlbiAo6Zmz5o+a5paHKSA8TWFyay1ZVy5DaGVuQG1lZGlhdGVrLmNvbT4NCj4gQ2M6IEFhcm9u
IEhvdSAo5L6v5L+K5LuwKSA8QWFyb24uSG91QG1lZGlhdGVrLmNvbT47DQo+IGthaWNodWFuLmhz
aWVoQGNhbm9uaWNhbC5jb207IGxpbnV4LWJsdWV0b290aEB2Z2VyLmtlcm5lbC5vcmc7DQo+IGxp
bnV4LW1lZGlhdGVrQGxpc3RzLmluZnJhZGVhZC5vcmc7IGxpbnV4LWtlcm5lbEB2Z2VyLmtlcm5l
bC5vcmc7DQo+IG1hcmNlbEBob2x0bWFubi5vcmc7IGpvaGFuLmhlZGJlcmdAZ21haWwuY29tOyBM
dWl6IEF1Z3VzdG8gdm9uIERlbnR6DQo+IDxsdWl6LmRlbnR6QGdtYWlsLmNvbT47IFNlYW4gV2Fu
ZyA8U2Vhbi5XYW5nQG1lZGlhdGVrLmNvbT4NCj4gU3ViamVjdDogUmU6IFtQQVRDSF0gQmx1ZXRv
b3RoOiBidHVzYjogSGFuZGxlIGRvd25sb2FkX2Zpcm13YXJlIGZhaWx1cmUNCj4gY2FzZXMuDQo+
IA0KPiBEZWFyIE1hcmssDQo+IA0KPiANCj4gU29tZSBzbWFsbCBuaXRwaWNrczoNCj4gDQo+IEFt
IDA2LjEyLjIxIHVtIDEwOjI1IHNjaHJpZWIgbWFyay15dy5jaGVuQG1lZGlhdGVrLmNvbToNCj4g
PiBGcm9tOiBtYXJrLXl3LmNoZW4gPG1hcmsteXcuY2hlbkBtZWRpYXRlay5jb20+DQo+IA0KPiBJ
bnN0ZWFkIG9mIHRoZSB1c2VyIG5hbWUsIG1heWJlIHlvdSBjYW4gdXNlIE1hcmsgQ2hlbiAob3Ig
dGhlIHdob2xlDQo+IG5hbWUpPw0KPiANCj4gICAgICAkIGdpdCBjb25maWcgLS1nbG9iYWwgdXNl
ci5uYW1lICJNYXJrIENoZW4iDQo+ICAgICAgJCBnaXQgY29tbWl0IC0tYW1lbmQgLS1yZXNldC1h
dXRob3I9Ik1hcmsgQ2hlbg0KPiA8bWFyay15dy5jaGVuQG1lZGlhdGVrLmNvbT4iDQo+IA0KPiBB
bHNvIGNvdWxkIHlvdSBwbGVhc2UgcmVtb3ZlIHRoZSB0cmFpbGluZyBkb3QvcGVyaW9kIGF0IHRo
ZSBlbmQgb2YgdGhlIGdpdA0KPiBjb21taXQgbWVzc2FnZSBzdW1tYXJ5Pw0KPiANCj4gPiBGb3Ig
TWVkaWF0ZWsgY2hpcHNldCwgaWYgdGhlcmUgYXJlIG5vIGZpcm13YXJlIGJpbiBvciBjb21tYW5k
X3RpbWVvdXQsDQo+ID4gdGhlIHByb2Nlc3Mgc2hvdWxkIGJlIHRlcm1pbmF0ZWQgaW4gYnR1c2Jf
bXRrX3NldHVwKCkuDQo+IA0KPiBPdGhlcndpc2Ugd2hhdCBoYXBwZW5zPw0KDQpGb3IgTWVkaWF0
ZWsgQ2hpcHNldCwgaXQgY2Fubm90IGJlIGVuYWJsZWQgaWYgdGhlcmUgYXJlIHNvbWV0aGluZyB3
cm9uZyBpbiBidG10a19zZXR1cF9maXJtd2FyZV83OXh4KCkuDQoNCmVyciA9IGJ0bXRrX3NldHVw
X2Zpcm13YXJlXzc5eHgoaGRldiwgZndfYmluX25hbWUsDQogICAgICAgICAgICAgICAgICAgICAg
ICAgICAgIGJ0dXNiX210a19oY2lfd210X3N5bmMpOw0KDQovKiBFbmFibGUgQmx1ZXRvb3RoIHBy
b3RvY29sICovDQpwYXJhbSA9IDE7DQp3bXRfcGFyYW1zLm9wID0gQlRNVEtfV01UX0ZVTkNfQ1RS
TDsNCndtdF9wYXJhbXMuZmxhZyA9IDA7DQp3bXRfcGFyYW1zLmRsZW4gPSBzaXplb2YocGFyYW0p
Ow0Kd210X3BhcmFtcy5kYXRhID0gJnBhcmFtOw0Kd210X3BhcmFtcy5zdGF0dXMgPSBOVUxMOw0K
DQplcnIgPSBidHVzYl9tdGtfaGNpX3dtdF9zeW5jKGhkZXYsICZ3bXRfcGFyYW1zKTsNCmlmIChl
cnIgPCAwKSB7DQp8ICAgICAgIGJ0X2Rldl9lcnIoaGRldiwgIkZhaWxlZCB0byBzZW5kIHdtdCBm
dW5jIGN0cmwgKCVkKSIsIGVycik7DQp8ICAgICAgIHJldHVybiBlcnI7DQp9DQoNClRoZSBwcm9j
ZXNzIHNob3VsZCBiZSB0ZXJtaW5hdGVkIGFuZCByZXR1cm5lZCB0aGUgZXJyb3IgY29kZS4NCg0K
PiANCj4gPiBTaWduZWQtb2ZmLWJ5OiBtYXJrLXl3LmNoZW4gPG1hcmsteXcuY2hlbkBtZWRpYXRl
ay5jb20+DQo+ID4gQ2hhbmdlLUlkOiBJOTlmMWQ3YjcyZmE3MDY0M2Q5MTIzZTdlNmNkYzhkMGI0
MzY5Y2U1Mg0KPiANCj4gVG8gd2hhdCBHZXJyaXQgaW5zdGFuY2UgZG9lcyB0aGUgQ2hhbmdlLUlk
IGJlbG9uZz8gV2l0aG91dCB0aGF0DQo+IGluZm9ybWF0aW9uIChSZXZpZXdlZC1vbiB0YWc/KSwg
aXQgc2hvdWxkIGJlIHJlbW92ZWQ/DQo+IA0KPiA+IC0tLQ0KPiA+ICAgZHJpdmVycy9ibHVldG9v
dGgvYnRtdGsuYyB8IDEgKw0KPiA+ICAgZHJpdmVycy9ibHVldG9vdGgvYnR1c2IuYyB8IDQgKysr
Kw0KPiA+ICAgMiBmaWxlcyBjaGFuZ2VkLCA1IGluc2VydGlvbnMoKykNCj4gPg0KPiA+IGRpZmYg
LS1naXQgYS9kcml2ZXJzL2JsdWV0b290aC9idG10ay5jIGIvZHJpdmVycy9ibHVldG9vdGgvYnRt
dGsuYw0KPiA+IGluZGV4IGMyZWU1YzRiOTc1YS4uNTI2ZGZkZjFmZTAxIDEwMDY0NA0KPiA+IC0t
LSBhL2RyaXZlcnMvYmx1ZXRvb3RoL2J0bXRrLmMNCj4gPiArKysgYi9kcml2ZXJzL2JsdWV0b290
aC9idG10ay5jDQo+ID4gQEAgLTEyMSw2ICsxMjEsNyBAQCBpbnQgYnRtdGtfc2V0dXBfZmlybXdh
cmVfNzl4eChzdHJ1Y3QgaGNpX2Rldg0KPiAqaGRldiwgY29uc3QgY2hhciAqZnduYW1lLA0KPiA+
ICAgCQkJCX0gZWxzZSB7DQo+ID4gICAJCQkJCWJ0X2Rldl9lcnIoaGRldiwgIkZhaWxlZCB3bXQg
cGF0Y2ggZHdubGQNCj4gc3RhdHVzICglZCkiLA0KPiA+ICAgCQkJCQkJICAgc3RhdHVzKTsNCj4g
PiArCQkJCQllcnIgPSAtRUlPOw0KPiA+ICAgCQkJCQlnb3RvIGVycl9yZWxlYXNlX2Z3Ow0KPiA+
ICAgCQkJCX0NCj4gPiAgIAkJCX0NCj4gPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9ibHVldG9vdGgv
YnR1c2IuYyBiL2RyaXZlcnMvYmx1ZXRvb3RoL2J0dXNiLmMNCj4gPiBpbmRleCBhYjE2OWZjNjcz
ZWEuLjNlYTA0YjFkMDc1MCAxMDA2NDQNCj4gPiAtLS0gYS9kcml2ZXJzL2JsdWV0b290aC9idHVz
Yi5jDQo+ID4gKysrIGIvZHJpdmVycy9ibHVldG9vdGgvYnR1c2IuYw0KPiA+IEBAIC0yNTU0LDYg
KzI1NTQsMTAgQEAgc3RhdGljIGludCBidHVzYl9tdGtfc2V0dXAoc3RydWN0IGhjaV9kZXYNCj4g
KmhkZXYpDQo+ID4gICAJCQkgZGV2X2lkICYgMHhmZmZmLCAoZndfdmVyc2lvbiAmIDB4ZmYpICsg
MSk7DQo+ID4gICAJCWVyciA9IGJ0bXRrX3NldHVwX2Zpcm13YXJlXzc5eHgoaGRldiwgZndfYmlu
X25hbWUsDQo+ID4gICAJCQkJCQlidHVzYl9tdGtfaGNpX3dtdF9zeW5jKTsNCj4gPiArCQlpZiAo
ZXJyIDwgMCkgew0KPiA+ICsJCQlidF9kZXZfZXJyKGhkZXYsICJGYWlsZWQgdG8gc2V0dXAgZmly
bXdhcmUgKCVkKSIsIGVycik7DQo+IA0KPiBUaGUgdmVyYiBpcyBzcGVsbGVkIHdpdGggYSBzcGFj
ZTogc2V0IHVwLg0KPiANCj4gQWxzbywgdGhpcyBlcnJvciBtZXNzYWdlIHNlZW1zIHVucmVsYXRl
ZCB0byB0aGUgcGF0Y2ggaW4gcXVlc3Rpb24uIE1heWJlDQo+IGFkZCBpdCBpbiBhIHNlcGFyYXRl
IGNvbW1pdD8NCj4gDQo+ID4gKwkJCXJldHVybiBlcnI7DQo+ID4gKwkJfQ0KPiA+DQo+ID4gICAJ
CS8qIEl0J3MgRGV2aWNlIEVuZFBvaW50IFJlc2V0IE9wdGlvbiBSZWdpc3RlciAqLw0KPiA+ICAg
CQlidHVzYl9tdGtfdWh3X3JlZ193cml0ZShkYXRhLCBNVEtfRVBfUlNUX09QVCwNCj4gPiBNVEtf
RVBfUlNUX0lOX09VVF9PUFQpOw0KPiA+DQo+IA0KPiANCj4gS2luZCByZWdhcmRzLA0KPiANCj4g
UGF1bA0K
