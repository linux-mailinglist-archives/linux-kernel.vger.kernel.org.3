Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 80A4847414B
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Dec 2021 12:16:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233465AbhLNLQ2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Dec 2021 06:16:28 -0500
Received: from esa.microchip.iphmx.com ([68.232.153.233]:50525 "EHLO
        esa.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229836AbhLNLQ1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Dec 2021 06:16:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1639480586; x=1671016586;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=QKFPRnfLdzNjK8s80x2tYXSEdvby8IBTt/zaFSFdyro=;
  b=SqYLqmO6ablVw3quSIw92hZlSHtvZLax6V/QVUS2AvLNqRPqvRf2Jj9t
   WijtJ/AHfRlSAR7pQdYjEm7gcrlMlb5u4zj4KPGhgzJVh8LJ3RqYufxYC
   2z+vISSWjHqYsRJQ4x48SuDg6DE6vpHgdDuamDS7Tb+LbO6ap0uQOsSJO
   JSjd0of1j+r+8kB2bvV0KMSHU1WkiSiphgmIeqavVzKXrCQGbKjp7k0ti
   SmbRuVmiMNjaxqy5edy+SPdR+l/NLn3cyDaW5OIv6BEZMLYa4i1x7EnTR
   Odkx1G55ni/fkg+yojlhqT21s9sPFAws3BxhAUf2Abxv8iquOL06F3EyX
   g==;
IronPort-SDR: bgjBZH6kBFD1ory8Vrs0+flJ86V7rlWW1T0jQUa2RB+Un7CMjtclDFwz3g71bN99pqB8IVW9Xc
 TG3foPQ/qsZE7ykPW/QTSWuHJFo3Td87FB9Ln4NxA4L4f60UAa/x193opp6hxhCDNp9ToSHfEB
 c3i5Q2pDaQfTPw+ZspA5kW47999xlz9nvFPk28XcCLop4kLjLyQG8C+sG48/dzzORMDfwofR7P
 WwYgj5J36yRg5AEjXTOialAJJrmIZHKcQCLJIfxNLfQg+Ixge3pKaC0V8hSiPMokW5qQcEx7Nr
 8hza4MV1V2JO/AWXAEoMBvVc
X-IronPort-AV: E=Sophos;i="5.88,205,1635231600"; 
   d="scan'208";a="147167653"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa3.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 14 Dec 2021 04:16:25 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Tue, 14 Dec 2021 04:16:25 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.17 via Frontend
 Transport; Tue, 14 Dec 2021 04:16:25 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kWX1uaJ1eOVAyv1KqE+rvteP/DvvXErPpjd17oOz7X9K4R5GFw3hnsjAcV9Pc2vCt0p28WWMjP4a2Q4aMt/Mf5fQ2w1xXgJe1sE2xhUIf4UWpw0A30NfczNYrXaxAbxxlGDT43PxURVz2H7vCbLdM7KJZEfIBB1ASmGW6uPO411JOBDYz7LN9G2gtbtscqygRAm7rfCWUjgAHi5HzRwMAc3DFJzjG1fEftfX4P2B8NgA2+nY4QkK0phiVFPlC3YNS4G5dY2dk8IUhiY/JfNCyGZslo2V1MPHr2tSDoPLK7+1nZdenn2L8sbjWz1CWNTqVBN5RIIIpbCk4JGhoFJqcA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QKFPRnfLdzNjK8s80x2tYXSEdvby8IBTt/zaFSFdyro=;
 b=NFrTlbEw16mZA2ZE/vXV5nMDuPN+ozbayUDkrtkr26apqj5Cq5bEEDXRdgWFGTqjMe7wzmMJ9vCkWfM79MOEY/Q7sdMxGlUMvYi7cJaYOwy1OlUCy9QBk1qRqt44yZGkv2LwVlNjYoP0/U37uo6Urn3hkmFlq7LC9JJ3YV+Nrn8e6RgnEC0RR1M/wLq2XZgUc3MCoJu+882dOtQNml7GgiSe6JVDJmV0tWjsCc98YrrA4xli128kYrV62zzh4tCwy7HQsYQzTps1FvEQHH8yJGGBSblC7NQaH9yA+/h+tyegGXS/FmUDD9NLskt7dFiZxxLZRB4HgVGMfFEnaUsr1A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QKFPRnfLdzNjK8s80x2tYXSEdvby8IBTt/zaFSFdyro=;
 b=po5p9v4Bm40RkHpab22tJeU2yJx4u/3EwgKrnbC4NCV0Cr1g107PzLNPH4usDvRJgebNIhbZ5ES2Hv2a5kWAka1UDXOjKyQ9AlX1v3QVe2tBxxTQ7GIClAKsidhDsiWbk+GGNwqd3tYALi4lO9h6//g6TbzJB8AgsXUCbsEjJPQ=
Received: from CO1PR11MB4865.namprd11.prod.outlook.com (2603:10b6:303:9c::9)
 by MWHPR11MB1613.namprd11.prod.outlook.com (2603:10b6:301:e::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4778.17; Tue, 14 Dec
 2021 11:16:19 +0000
Received: from CO1PR11MB4865.namprd11.prod.outlook.com
 ([fe80::b450:2587:13c8:e52d]) by CO1PR11MB4865.namprd11.prod.outlook.com
 ([fe80::b450:2587:13c8:e52d%7]) with mapi id 15.20.4778.018; Tue, 14 Dec 2021
 11:16:19 +0000
From:   <Tudor.Ambarus@microchip.com>
To:     <quic_c_sbhanu@quicinc.com>, <dianders@chromium.org>,
        <michael@walle.cc>, <p.yadav@ti.com>, <miquel.raynal@bootlin.com>,
        <richard@nod.at>, <vigneshr@ti.com>,
        <linux-mtd@lists.infradead.org>, <linux-kernel@vger.kernel.org>
CC:     <stummala@codeaurora.org>, <vbadigan@codeaurora.org>,
        <quic_rampraka@quicinc.com>, <quic_pragalla@quicinc.com>,
        <sartgarg@codeaurora.org>
Subject: Re: [PATCH V3] mtd: spi-nor: winbond: Add support for winbond chip
Thread-Topic: [PATCH V3] mtd: spi-nor: winbond: Add support for winbond chip
Thread-Index: AQHX8NwEXGjGR1ABx0itnLmUtO+AEQ==
Date:   Tue, 14 Dec 2021 11:16:19 +0000
Message-ID: <488aafc3-2fa9-198b-c448-d1ca7ef52f35@microchip.com>
References: <1639476991-25676-1-git-send-email-quic_c_sbhanu@quicinc.com>
In-Reply-To: <1639476991-25676-1-git-send-email-quic_c_sbhanu@quicinc.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: a29ee60b-3526-46a5-0afb-08d9bef32781
x-ms-traffictypediagnostic: MWHPR11MB1613:EE_
x-microsoft-antispam-prvs: <MWHPR11MB1613D1A4A107E9B305B8AEDAF0759@MWHPR11MB1613.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: zve0q9bO7XApvbjaZ0B5FEZmt6g31L3g6MBofw1IIY9kd9ilyikZZy1XZfytKektw9kV+qCriER3HSfpkelw3pMaG9UXAdlPfYt1pQLr2Pgjy03VA9tzBwvKQnVq3JU2CFhBj4LKyj1nIFKQSqlbmfxdjky2OPY/QztKosAmGSkYr2EvtK4bYB/XSCFllhe9f1Up6DEaTZ43eCY5ZbiPQBNDW8k5r6uS526T9Tp2RCJYE4Ds//y37CMeXwxw6Iwa2qK/nJ0XI3M6JLj3fqpwHdguKNyn4BTnP65nxJ9Pw0nb7ib4TLaRktwTDoqtKBnBmIa8p5zJwL9nTowVP3YEYKpv2+xaMcum/GadijsidQk9Tkkk+ofuyDNUkTQpF7V6OR52gkcuRFEqGrbbp89YhvjKnU1j5YGanNEgbTlGdyPF1A84buD0xtYqtBq5YiCaEPFJMj4kv+DoYkClPvTFCCDpjEkF727PUqK4evbN68aCg/SIQatwsR1e9egFXl0OuLhFxTwcuxIRwOR/kgI9MC6Vknm8tvkUM+7Nw+nJKjV4rXkvMBh0cik8tX9Yf7CJ7DhEZ202zfTyY+dNp7i0YVzaNcN0zrwRSitSdW5Fyz4kCwksG6q3ZTR9SVuhPr63sDLNlpRqlZj5VX9k6+kLIJi/EB5vPI1W8JZfII8p2xSX4v+c/Eazp6nSWRL08jIX+IQLBMLo2Fqd1k58wVxsJ097D+rUJ2vRNI5oIWrxvEYzWHlmlCMFGywRv1F+QHIP8C+Q2qHFQnEasxa5nQu0fQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB4865.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(64756008)(38070700005)(8676002)(508600001)(31696002)(66476007)(76116006)(186003)(8936002)(71200400001)(7416002)(66446008)(66556008)(91956017)(4326008)(66946007)(122000001)(86362001)(31686004)(38100700002)(83380400001)(316002)(54906003)(110136005)(6506007)(2906002)(2616005)(6512007)(26005)(53546011)(36756003)(5660300002)(6486002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?dkIvNVYzU3BGZWxzOS9wQjlhM2FWOXVDSStDOTRUSXB3NmVrYlp4NkVld2dR?=
 =?utf-8?B?VW5CdlRHUWVvazZ2V2JjV0MwY0lodVdXZ1VxVlJTQmwzakNRUEFUTVk5WjZS?=
 =?utf-8?B?QXJHZ0J6RFhleDRNZXVJYlIzaTM2S0d2SlRObU5IQkM3S2Z5ODdLSTE2TGdF?=
 =?utf-8?B?MFA0NW5idEtoTURqYmR0N3NSbGthQXBWeGRzUTk3ZVc3bjdyN3I1L0x3M3RV?=
 =?utf-8?B?UVBmK0lNQVBpR0VuZ3BpZjBIaXZYZkd6Q2ovMmh5Vk4vM1pURFdqODR6bDZ6?=
 =?utf-8?B?M2RZcUN1THVCeVBFdVhiS1lML2FoaitxaWpEWkFBbm8wWnBlVzJiZ2JiczA2?=
 =?utf-8?B?SzdCT2tKcmlQdlJsTmpCYyt4Ry9ad05EYXJoMnE4UmlUQ0J3N0NTWmRQOHhv?=
 =?utf-8?B?NG5lSVZicWlpRXYvdDB2NnI4TWNPc0VTYmdQWjRJZVIzUjJ6OXVkWGN5Z3Fw?=
 =?utf-8?B?N1NHeFN4YWgxQ2ErdlB2N3E2L1B1eUd2NDBMb05CSnFmRVRITHU5Uk9kMUQx?=
 =?utf-8?B?TE54dGgrS1R5WVlYRU8xYkpVeGk4aHp2bE0zR0VPaS9uQjNGTGcrVk5RZjBj?=
 =?utf-8?B?akdUSXZuUG1DRTdRMkp3TFR6eXpETE0yYVhrZGFUMzZWL3RhR3dXOVZIdm5z?=
 =?utf-8?B?dGI2d0dtQTZudTM1T3ErU25VenNLTk13bVNzUFprM1QrNTd5ZEwvd0xCSnJj?=
 =?utf-8?B?OFVpelNRcE9oaGFvVi9qOVBLeDFjTC9YWkdJT0U2dzJleTlNL0k3VDBwelVm?=
 =?utf-8?B?UGh4V1ViazFyVDVnSzl5Q2Q0em1DQXFETnBnWnRVUDh4VEdpOW12MEMzSUU4?=
 =?utf-8?B?MzdkSGVPV1pLREQ4RDJzc1lvaEw2ZWNFOENJeTUzaWd4Y20zVVZpb2cwWVNk?=
 =?utf-8?B?NVdsQnNHZ0RnbTVhcEVyVlg1QmVjcWZDdVJRT1htYUdwa3VlSnRmUVBrcVB5?=
 =?utf-8?B?d0ZxOThUbXVWN1lEaE01VjNZMVVkYUpVU29ZTlZMS2hpQmJBVDlKNEppTWsz?=
 =?utf-8?B?MGNQckpINU04Y05YRWNZaGNwcVY2ZXFQZUxGSFFTZkQzU2MwNURwWm9DUDBp?=
 =?utf-8?B?ajlLblk2ckhJTmZRMFVNbjFLbGR4Y05FUmpadlI5WVVHN3I3RVF0Q0QyakNz?=
 =?utf-8?B?TU1yTVJjUWpFVlM5Q0dOMWhSSTFreEJHeEFmLy8wQXJNMjV3QmltMEFwS3ND?=
 =?utf-8?B?MXRaMkhycDlpZVZqSGRUN3FjL2JSMHFMSUxJQU5mWjhWTWZWUEwrbGdKbmpT?=
 =?utf-8?B?dVp5R1ExdVlyaDlQc0JiejVnNC9tOHo0MnBJTjUrUzRDMEtvYkNZbDVlYWh0?=
 =?utf-8?B?WDFoSy9TL3kxcXpBbytja3h3QlljeGc1a21XVEhmaHgvVDZ5RzZzdFpPNW5r?=
 =?utf-8?B?U0pkN2U2N21KUG9vNko3Z0N4WmFOUy9ZdDR4SFNld0pBZkpuZjkrbmNrWVJk?=
 =?utf-8?B?WlZ4dzIrK0o0dVBzMGN3RTFoNFBKTk0xam9MZnUwSUY0VFp3ekR6N3NkbDJw?=
 =?utf-8?B?ZFVDOEwzMmRoVm43cGJldGNwYWlHWGFOWGRiZTBnZmJIL0FaRTM2M0dSWi9R?=
 =?utf-8?B?bThmcy84eTNRZmpDeVpyNlhxdkZBK2VncjVQUHU4TXg2TXhiZThEL1M0eGdp?=
 =?utf-8?B?TGhrT3NYSzVLUlpsR3BpWUhzdzIzOXp4QlJPRmZGWlg3ajQwcTB2aS9Bb2Q0?=
 =?utf-8?B?R0tJS1hMVUMwVzFjZ0RLeFhkMVRTZWE0K2NrSGlnRkw0NDYva05iQ1kyWVdW?=
 =?utf-8?B?WHVWWjZjWmpVcjhmQlRGQ2ExNVZid3M0ZGRDYnBSdENZUmRydEx1VS9JeUo4?=
 =?utf-8?B?TjNkTFRIMDRtZFZlTHZwT1F2azR1Q3V6Mm1yZFp4dGN1ZjMwU3ZxTmFSN2ho?=
 =?utf-8?B?V0p3RS9WZExYKzVNcG8xQmlJNGQyTVh3VnFYU2YzZG9ocVZuUTN2R3FLZWk4?=
 =?utf-8?B?bEN4b1JvMEpRRUh3My83b1daSVI0OW1ESFZCcXZVTWdlTzFLTEFEcDhweTRU?=
 =?utf-8?B?TmU5SWpDbU0zNkJCRlFrWlNGUTBkamhZdWgxRjhXMlk0MHJ1eG1xUjBiT0Mx?=
 =?utf-8?B?eGR5aGpYYlhLV0xiTkVYTkxwelRXaDl4clZrVnlRUCtPSExYZjNFZ1ROYXRz?=
 =?utf-8?B?SXN3dm1STXZ4enFEUkVwKzZndnVKREd5bUZrMlJ5MEJLRFk0VnZnUGNuS0FH?=
 =?utf-8?B?WXNNUW55ZXEzdnFtajlZL1d6Tnk1d1E2RldMcWxscndFYWU2aCtFYUtIVTdN?=
 =?utf-8?B?Rzc5aDFOVm9YQ0E4TFd5VnBwUVJ3PT0=?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <929DC52726931F43A06C48B31F361B1B@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB4865.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a29ee60b-3526-46a5-0afb-08d9bef32781
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Dec 2021 11:16:19.7797
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: s/Ez+PvPyODQnrL61vjihyIToQ3n85tSzkcBIDB6g+u3P44ThFouhysTqODtsnDRvvcPP/HSzZIqig8UN5WnYLvLk3VrzR0LN/+QUu1YxWY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR11MB1613
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gMTIvMTQvMjEgMTI6MTYgUE0sIFNoYWlrIFNhamlkYSBCaGFudSB3cm90ZToNCj4gRVhURVJO
QUwgRU1BSUw6IERvIG5vdCBjbGljayBsaW5rcyBvciBvcGVuIGF0dGFjaG1lbnRzIHVubGVzcyB5
b3Uga25vdyB0aGUgY29udGVudCBpcyBzYWZlDQo+IA0KPiBBZGQgc3VwcG9ydCBmb3Igd2luYm9u
ZCBXMjVRNTEyTlctSU0gY2hpcC4NCj4gDQo+IFNpZ25lZC1vZmYtYnk6IFNoYWlrIFNhamlkYSBC
aGFudSA8cXVpY19jX3NiaGFudUBxdWljaW5jLmNvbT4NCj4gUmV2aWV3ZWQtYnk6IERvdWcgQW5k
ZXJzb24gPGRpYW5kZXJzQGNocm9taXVtLm9yZz4NCj4gLS0tDQo+IENoYW5nZXMgc2luY2UgVjE6
DQo+ICAgICAgICAgQWRkZWQgc3BhY2UgYmVmb3JlIG5hbWUgb2YgdGhlIGZsYXNoIHBhcnQgYXMg
c3VnZ2VzdGVkIGJ5IERvdWcuDQo+IA0KPiBDaGFuZ2VzIHNpbmNlIFYyOg0KPiAgICAgICAgIFVw
ZGF0ZWQgY2hpcCBuYW1lIGFzIHcyNXE1MTJud20gYXMgc3VnZ2VzdGVkIGJ5IERvdWcuDQo+IC0t
LQ0KPiAgZHJpdmVycy9tdGQvc3BpLW5vci93aW5ib25kLmMgfCAzICsrKw0KPiAgMSBmaWxlIGNo
YW5nZWQsIDMgaW5zZXJ0aW9ucygrKQ0KPiANCj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvbXRkL3Nw
aS1ub3Ivd2luYm9uZC5jIGIvZHJpdmVycy9tdGQvc3BpLW5vci93aW5ib25kLmMNCj4gaW5kZXgg
OTY1NzNmNi4uNDJkNTgwMCAxMDA2NDQNCj4gLS0tIGEvZHJpdmVycy9tdGQvc3BpLW5vci93aW5i
b25kLmMNCj4gKysrIGIvZHJpdmVycy9tdGQvc3BpLW5vci93aW5ib25kLmMNCj4gQEAgLTEwMCw2
ICsxMDAsOSBAQCBzdGF0aWMgY29uc3Qgc3RydWN0IGZsYXNoX2luZm8gd2luYm9uZF9wYXJ0c1td
ID0gew0KPiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIFNFQ1RfNEsgfCBTUElfTk9SX0RV
QUxfUkVBRCB8IFNQSV9OT1JfUVVBRF9SRUFEKSB9LA0KPiAgICAgICAgIHsgIncyNW01MTJqdiIs
IElORk8oMHhlZjcxMTksIDAsIDY0ICogMTAyNCwgMTAyNCwNCj4gICAgICAgICAgICAgICAgICAg
ICAgICAgICAgIFNFQ1RfNEsgfCBTUElfTk9SX1FVQURfUkVBRCB8IFNQSV9OT1JfRFVBTF9SRUFE
KSB9LA0KDQpUaGlzIGRvZXMgbm90IGFwcGx5IG9uIGN1cnJlbnQgc3BpLW5vci9uZXh0LiBXZSd2
ZSBjaGFuZ2VkIGhvdyB0aGUNCmZsYXNoX2luZm8gZmxhZ3MgYXJlIGhhbmRsZWQuIFdlIGFsc28g
cmVxdWlyZSB0byBkdW1wIHRoZSBTUEkgTk9SDQpzeXNmcyBlbnRyaWVzIHVuZGVyIHRoZSBjb21t
ZW50IHNlY3Rpb24gLS0tLiBJJ2xsIHVwZGF0ZSB0aGUNCmRvY3VtZW50YXRpb24gdG8gYWRkIHNv
bWUgZ3VpZGVsaW5lcyBvbiBob3cgbmV3IGZsYXNoIGFkZGl0aW9ucyBvcg0KZmxhc2ggdXBkYXRl
cyBzaG91bGQgYmUgcHJvcG9zZWQuIFNvbWV0aW1lIHRoaXMgd2Vlaywgb3IgbWF5YmUNCm5leHQu
DQoNCkNoZWVycywNCnRhDQo=
