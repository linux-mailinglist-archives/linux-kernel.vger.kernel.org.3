Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 02CDB483083
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jan 2022 12:29:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232993AbiACL3b (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Jan 2022 06:29:31 -0500
Received: from esa.microchip.iphmx.com ([68.232.154.123]:22251 "EHLO
        esa.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232983AbiACL3a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jan 2022 06:29:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1641209370; x=1672745370;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=uyWuC6k/6qtsPgXjrjzGo2k1Z0Cr8pKNLEqvEoHXK2o=;
  b=Lo+6qRJkuTWtP1D1BCUCORlZPJIgTjxmli0SFWRbq1tXv04MX3sMNgow
   q0WDTmbo1dYvNEl5Fg+aI6C3rN4xfVQBBSboE7GCFcCDXBnpOZbi0wTXe
   hdmEJnGuc0YRTrIf2pDzMRdPyP9udyNRuoJQc0JtUwH++NBrK7kzZgX/a
   pFXXkyqF/8xMsLde/ByoxgteLFuo1QoRXqnY03zqVxA1ArdQV6he3kcOi
   xQyrEhFRaWiwmRuYksN+o1pH1FRzFchVc5dUTgZYWLsti0INtsXdpv2Pm
   FU8JlHQ7j8FjbgyXVmfvLVTkBKa11WF1zsV7uVuzjRQ6Z8YIyJ4nUpgKV
   w==;
IronPort-SDR: rt2xK8xttarV/s/28Yy7tvZCGDayel4BNKMY1xyFr4HzxZyr06auDMnVfs7EsposRKz0X7XLms
 V3q7Zvfb8xMFhR04PhQbR/47NsbjB6+A5WLXx8eonS//u+A6jlxAVzy8xGYUqZf0IUD2LJRsRD
 H7fj/RryPM7h+c7o3jZO1FNZOD2rGwYE0L9Cxgif14Th8PvCvVZcUUfU91ltLjdwPZyI9SKn0r
 cAQaAjznNk2A059+TrB+HX4qy3ZeCg9x736/FuHvtiqlVM4grL2SzxfJcqBNC29pTR4RHsXr9H
 43RHtw12ofX4ql8Awzkywexg
X-IronPort-AV: E=Sophos;i="5.88,257,1635231600"; 
   d="scan'208";a="81246176"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa6.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 03 Jan 2022 04:29:28 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Mon, 3 Jan 2022 04:29:28 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.72) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.17 via Frontend
 Transport; Mon, 3 Jan 2022 04:29:28 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EHc5qZpbWIbG0jW7ePMOO7ZAaUW3hFEbIAHhgwGksz7KnwQcPBqScvdgPKJxhwO8l/jVZ/zTmTKhTCVMWdCXIii8T2QYMnh4Nhe1UMq4s2z34bJrC86jGxydQ5d4GEcCBst+JamHLbG1RHWU+pumKIdWgM/Q1LguNdqSWb1IQOQ5SA/cy/3baxhmTDqpsWtFG21x6NZm1CNg1QTIDt9SVjWzx3MI6RCB6GB0Hi+jhcnGf5cJV2bpemqkyrsMEtMKEQMQuIVgfcqaKNF4dqUS3wh/N65KkQKFpd3i0LdaR/uKJD07HXE8fYkjtw+5AUikPAKZRv2EoNpvJ9AE7U6J6A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uyWuC6k/6qtsPgXjrjzGo2k1Z0Cr8pKNLEqvEoHXK2o=;
 b=jPbG8tL71SmjOVOKASakqWBOcRgs3qTI9L4359FOGy3BOjFgRtm7qm2UOqpdqLyqM3I+nPe+tPhRBCZqnT6HdehpMhzaQd6UBSBxLd7aO3CN73Chbcih+doJafJ5UcetWksyeS2PO4lj07YIADLQ1eUAaMcP0hanIjGLaiDtFLk14xLUL6Y5UmYt/pS4QbdRvzpDVvDtXveRQ6wDtBaY5r3eIOtUo53YPkAqK23IGspAhc8pjXJhvK5iBPlfhOFGDDgeGa44w8JNR2hpeU1kOfteP4vku2Ht3L4Mnejs8rng73jLVpMyaXV2NFSFBYQ+mHcd62PoXhDTjqFDFMx6lQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uyWuC6k/6qtsPgXjrjzGo2k1Z0Cr8pKNLEqvEoHXK2o=;
 b=e5ckxzna60B0YX4a9AZw628jRZIaqJPT0fRXeGVMGqEu1ypL+g4qzhj28qz4kuukLaO+R2vYVSxcjoi9SVVPRiq0iDibVU4Z/AuqkdV8LiyWVIpmC8l+tGSo1cQMbpk/tZ8LCyDIvu9JmU+KOMfztofc12zz+XpAyWgTxQR03q8=
Received: from PH0PR11MB4920.namprd11.prod.outlook.com (2603:10b6:510:41::22)
 by PH7PR11MB5944.namprd11.prod.outlook.com (2603:10b6:510:124::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4844.15; Mon, 3 Jan
 2022 11:29:23 +0000
Received: from PH0PR11MB4920.namprd11.prod.outlook.com
 ([fe80::1433:9dcf:4912:b8f]) by PH0PR11MB4920.namprd11.prod.outlook.com
 ([fe80::1433:9dcf:4912:b8f%9]) with mapi id 15.20.4844.016; Mon, 3 Jan 2022
 11:29:23 +0000
From:   <Eugen.Hristev@microchip.com>
To:     <prabhakar.csengg@gmail.com>
CC:     <hugues.fruchet@st.com>, <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        <jacopo+renesas@jmondi.org>, <sakari.ailus@linux.intel.com>,
        <laurent.pinchart@ideasonboard.com>, <slongerbeam@gmail.com>,
        <paul.kocialkowski@bootlin.com>, <linux-media@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-renesas-soc@vger.kernel.org>, <biju.das.jz@bp.renesas.com>,
        <mchehab@kernel.org>
Subject: Re: [PATCH v4 1/6] media: i2c: ov5640: Remain in power down for DVP
 mode unless streaming
Thread-Topic: [PATCH v4 1/6] media: i2c: ov5640: Remain in power down for DVP
 mode unless streaming
Thread-Index: AQHWgvi4qdMvk8Y9N0iZFwzrul8/26lggxKAgcwfagCBEtLdAIAAd/kAgAAEIACAAALHAIAUMCOA
Date:   Mon, 3 Jan 2022 11:29:23 +0000
Message-ID: <e6cfb1fd-7132-0b5c-9e85-dd9c8dfd6d79@microchip.com>
References: <20200904201835.5958-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20200904201835.5958-2-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <8b5d4928-2921-b876-7d1e-04bb42eff4fa@st.com>
 <3b54ab9b-4ffd-ab32-d495-fad6132ea504@microchip.com>
 <5c56c87d-ca48-5573-0606-da1441fab7ff@microchip.com>
 <CA+V-a8uk3h95aL7n7cDjYdXJBbE6GWF_LkiAVMOFtVzv-83ZpQ@mail.gmail.com>
 <450850f6-9296-e505-4b92-c71ed190b95f@microchip.com>
 <CA+V-a8vsX9Ei8dS+fJQe9jqcFXmvfeVb==-HhDkXFnajQYT6tg@mail.gmail.com>
In-Reply-To: <CA+V-a8vsX9Ei8dS+fJQe9jqcFXmvfeVb==-HhDkXFnajQYT6tg@mail.gmail.com>
Accept-Language: en-US, ro-RO
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 3ebe3b72-c7cc-44e8-fdac-08d9ceac4afc
x-ms-traffictypediagnostic: PH7PR11MB5944:EE_
x-microsoft-antispam-prvs: <PH7PR11MB59441B8BA8C4CF32171749E6E8499@PH7PR11MB5944.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: hACQCTuYPY4WLcm2zpCf0Wma+OruOa2I/IqwvQbCB36XhU2brCLh/lQBea+ea3X9THMYSKjtX8bZcvv05XKysfZhlsaZfiAc/CpOl0Nkwsp9tiiUe3bwukY7AviL0oorcCj/NJf8y8mjdKtERslRbF+ONVabxg3uOeA/VXSjKcRQ6o9jVM472TEqTTfipeYb+oTPaVD4Q5UCh1C/gs57CzlJEp69YSsBxm7IyMyiXteRIDbT5ExiRRA/zi4WuWC4ZpqjnONMmVnDUt2mnv6Khq6z6LSJtmG+aUuodVnGUnwZr4NWc0TU8uH2u2kFI4R+z6Nt0nomz8uXoNrrG+3In5SMU2FSS6jUiIJyfOVIoT6fENfpsFAcQsj1JCRaS8EJBHXcamzSLsOFd7lpXJWdEnxqagIyPoFyGpRSee9NnrwBO/W0ydPLPQrfAEXx5hHc01IwJspu/hvr8IY6cmjvgt5oQAitE6qkpOIK66zo9jWbJezbKo+tOr2Si0JdlkAc9YJN3YmoiQQ9+9OAHtlqeLiFVPtFkjq/mpZ1o8fvByQLhmpgo3ddybXI4cDDG9JrJTwYzDiArd6Bb5AUh7OtxE7v0jojQmRwMZBZgZv1vDhVeiVGaUAChxUoY20hY0gMvlB65/INWaDUF8crstL9CBsBIzNpb8sk6zlw4drGT9ZlLdKWfa8fGUSxQAzsHHY+fCDIK7/NjkA6tOzQWymK9rkDMSrH7PfnI76YtDBE2hgou5k8EXh41G7EEEkPnNUgrqt1Gf8WSbjVlTrB/0Kvmh1E1IlOhSzG+LAkQzlvUauuDqRpqfO/H+vy4AuvAiDYlFsRxQkmm7BTmO2az0Waa6etDsX20heMowSZVs/RttI51bETeYAejyIbB2VAzVWIy3bTp2lgzjZA1g13EpwOjQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB4920.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(5660300002)(2906002)(54906003)(31686004)(86362001)(36756003)(6512007)(66946007)(66476007)(66556008)(71200400001)(83380400001)(91956017)(4326008)(76116006)(66446008)(64756008)(316002)(38070700005)(966005)(8936002)(508600001)(8676002)(26005)(53546011)(6506007)(6486002)(31696002)(2616005)(6916009)(186003)(38100700002)(7416002)(122000001)(43740500002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?d045MEVJVVhLekl0TnhvZzg1TTRTYnhzWVZ0NHZlNFdmYTFDeHZHNU16b09l?=
 =?utf-8?B?SHlUS1NERGtJNlVuQTMzUVE5UmZBRllKQWJwQjBtSXpudlA2K3J1cUVuL2c1?=
 =?utf-8?B?Rlg5ZkhqNXJUQUthSjdQeXpOY1R0VlA4KzVteTZWOWtZNU81dzF5WlFDOHJN?=
 =?utf-8?B?TGU1N2kvbkJiOEY4dGczU1gwejZ4VG9xK0k0ekxWYlYvVlAvVytmUlRSR2FD?=
 =?utf-8?B?YWUwejZSenI0anFNNGZucGZRelZ3V3BBSll5RUpRQW1lRU95SU1pWUxTclc1?=
 =?utf-8?B?TjJ1TTFUcDNRS1RKcUZXN0UwRUs5NGlTblZOeDR6NXhkd2dRdHV0T0NLK1BT?=
 =?utf-8?B?dzhIK1lSVHEyV0w0R3IzOHRtMkVib2JCRWRSZ0VIRHNKV2RLc1hrYStBQ2F5?=
 =?utf-8?B?NjdjYkJQK2tTZ1BoNktOS1pWWTFhVk1OTFpjeG42SkJaT0lpU0NRdy9Pb05a?=
 =?utf-8?B?Qyt2NjR1Tk5pRS9zRytvRkVZRDZlU3E0NUc0VitSc3lwQlp2VVF2VFVISGVx?=
 =?utf-8?B?dGUreDVJOUZicDlNWkZ2U1N0Z0YxUDRwMWtYNmc5Um9YSHA2ZGlGanZsVU5k?=
 =?utf-8?B?WTJyZmpDVnRRVitTWUJpTkwzYU5oQ1VQQ1FEekV2ejhrYnBLbDg2R3YyRTcz?=
 =?utf-8?B?NXRURURueHEvb0xOV2k2Q2dXUlpTSWRtS2dBNmZCOFlwL1AvMTNPaFlvT3Ay?=
 =?utf-8?B?dEpyZ0NRUmwrMXRxRlVPZFo2bjBqM3pvTWhzTk4zTmJtVFgyY1hpamd0b2x1?=
 =?utf-8?B?bm5pdUo0Y1k0eWpzMkoxTXJabXVsVDB6YU43MlVHd3k5RTlOS0tNajI3RjA1?=
 =?utf-8?B?b0lmN2Y0ZDFKZjE0QklaeHU0T1NpMXFUMnVrYmF6K1R4UldZci94WFVNSDNv?=
 =?utf-8?B?ODFWSEI1ZDIxY1JPZ3E0L29TdTVTb1RlcUxYN2FZUkx2Y2hHcVRmMHFQcTJG?=
 =?utf-8?B?MW11SmkxYkdnNDZNVVRiVm1ZbVd6VE5HeG9UdkhFTTZHbVl2REFpUzgrUnRs?=
 =?utf-8?B?Y1AySmEyQTBpdEpxVXN6UEFpeG5sSE8zdmdEai81a3JQUDEvcURYOWhLS0Jy?=
 =?utf-8?B?aTRtYkEyaXlOYU8vV3IrZnZXeFluN3Z6R3hScmtOWmFCblk2LzREbGZCKzhD?=
 =?utf-8?B?bVpMRzMwaWdOSmk5bUJ3eFc3ejdwUGU0ZWlmK25pb1Zpa1p3TDV2TGttT0pw?=
 =?utf-8?B?S2FyUnRVaVhaajcwalFBODZKcjdkb2ViOEtiOWVFenA5b0lTdVFzRTlNQ1or?=
 =?utf-8?B?ZmdaWHh4VVY1dVBSNDA4aEFZZEV2bEJXZ1lmL2FqMjM4cjBtN2tiMjBWSVZX?=
 =?utf-8?B?bFZVbk03d04zenBTdHpzMFA3MmVhWEdOT2FvR1NLUGRrLzhxRmd3ZEVDUlhH?=
 =?utf-8?B?ZkV4bkdXclpVOHE0OFhNb0tEaWMvSnVGZGxEYnNiYjFzOS8wQVYxUGo3VzVa?=
 =?utf-8?B?ZUYyRzBMWDRzRWIxa29HOXJTRVhGcmtSY0I4eisrdTdqOUp3ZTltVThQanFa?=
 =?utf-8?B?VE05Y1R5dUlJTjNBcG5nWEhvLzd4UWxoeVQ0NmNPRHpQYWwrR2J3eFptT1Z4?=
 =?utf-8?B?K01IODhseGRiV3d0TDVsU2VzejRid1RqbE5jSTViMktISkdkbVA2SEFUN1V1?=
 =?utf-8?B?YVhYNm1XMndScUhVVG1oMmE5SFU4L3BXT3N6enZsNkY5RVQ2cG5TOWtoc0dr?=
 =?utf-8?B?L3d0ek1ONFErZGZpNHVtb3VmRFpLM1JNTUNQdUkrcXVGUUdYU3kvam8vc1pT?=
 =?utf-8?B?OHBFWVRCdzlZWmY0TWJFajBNRDkyU1hDbU9ZejJrZndZeXNuZDY1amo1bkN5?=
 =?utf-8?B?UkJVY1U2UWFYaUZGSkhpRTkxRDBIaFVrWHVlWkh1ZVlsbHBMc3pEODZNQWxa?=
 =?utf-8?B?VDlRenNtV3VvMjBFNWFoZDVwWlV4c3RXT0YrL0xDWklQa2pabmU1dzF3SWdo?=
 =?utf-8?B?bzF4WElZeS9IWTBaaDRGbkN0WEhZRFROZ1dHam1waDRCRzN5QnVFTlBoN1pV?=
 =?utf-8?B?RXg4ZjNpN2NGdHg5eUcyTUkybWNkRWNzenU5TjBwdFMwa3gwV2o5K01vbHFm?=
 =?utf-8?B?dWhwMzA2UHFYUzlxZ05XckQwQUZGNXJWaUZ2TmhmNmJBeHd3aEhmZjFjajdk?=
 =?utf-8?B?bHRBTk5wSDUwUHZTYThXaUo0Yk9aeHZMeWxQcGg1VklTcWhrcVJaaDRwTFlO?=
 =?utf-8?B?Q08zdldjSVRmRXZvTGkvM2hMTGtGWFgzaWRubXllZU9CZTZYSFJXZEplYXNZ?=
 =?utf-8?B?alFyTWMyandsZVFlaE51Q3VXZVNnPT0=?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <7F87B5CC82FE2D40AC04839724E2C979@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB4920.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3ebe3b72-c7cc-44e8-fdac-08d9ceac4afc
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Jan 2022 11:29:23.6162
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: gVaJRV5tylv1tEf99lI3HC//wu78GLeeGixztYhhkTEYxxqFfIeoeTTaBihUG/QFjj7C4i0Gr8LxE5zbOW4MRvgeLLGbxtuUES3Q9VCN8oU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB5944
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gMTIvMjEvMjEgNToxMSBQTSwgTGFkLCBQcmFiaGFrYXIgd3JvdGU6DQo+IEhpIEV1Z2VuLA0K
PiANCj4gT24gVHVlLCBEZWMgMjEsIDIwMjEgYXQgMzowMiBQTSA8RXVnZW4uSHJpc3RldkBtaWNy
b2NoaXAuY29tPiB3cm90ZToNCj4+DQo+PiBPbiAxMi8yMS8yMSA0OjQ3IFBNLCBMYWQsIFByYWJo
YWthciB3cm90ZToNCj4+PiBIaSwNCj4+Pg0KPj4+IFNvcnJ5IGZvciB0aGUgZGVsYXkuDQo+Pj4N
Cj4+PiBPbiBUdWUsIERlYyAyMSwgMjAyMSBhdCA3OjM3IEFNIDxFdWdlbi5IcmlzdGV2QG1pY3Jv
Y2hpcC5jb20+IHdyb3RlOg0KPj4+Pg0KPj4+PiBPbiA2LzI5LzIxIDE6NDcgUE0sIEV1Z2VuIEhy
aXN0ZXYgLSBNMTgyODIgd3JvdGU6DQo+Pj4+PiBPbiA5LzkvMjAgNzoxNiBQTSwgSHVndWVzIEZS
VUNIRVQgd3JvdGU6DQo+Pj4+Pj4gSGkgUHJhYmhha2FyLA0KPj4+Pj4+DQo+Pj4+Pj4gQXMgZGlz
Y3Vzc2VkIHNlcGFyYXRlbHkgSSB3b3VsZCBwcmVmZXIgdG8gYmV0dGVyIHVuZGVyc3RhbmQgaXNz
dWUgYmVmb3JlDQo+Pj4+Pj4gZ29pbmcgdG8gdGhpcyBwYXRjaC4NCj4+Pj4+PiBOZXZlcnRoZWxl
c3MgSSBoYXZlIHNvbWUgcmVtYXJrcyBpbiBjb2RlIGluIGNhc2Ugd2UnbGwgbmVlZCBpdCBhdCB0
aGUgZW5kLg0KPj4+Pj4+DQo+Pj4+Pj4gT24gOS80LzIwIDEwOjE4IFBNLCBMYWQgUHJhYmhha2Fy
IHdyb3RlOg0KPj4+Pj4+PiBLZWVwIHRoZSBzZW5zb3IgaW4gc29mdHdhcmUgcG93ZXIgZG93biBt
b2RlIGFuZCB3YWtlIHVwIG9ubHkgaW4NCj4+Pj4+Pj4gb3Y1NjQwX3NldF9zdHJlYW1fZHZwKCkg
Y2FsbGJhY2suDQo+Pj4+Pj4+DQo+Pj4+Pj4+IFNpZ25lZC1vZmYtYnk6IExhZCBQcmFiaGFrYXIg
PHByYWJoYWthci5tYWhhZGV2LWxhZC5yakBicC5yZW5lc2FzLmNvbT4NCj4+Pj4+Pj4gUmV2aWV3
ZWQtYnk6IEJpanUgRGFzIDxiaWp1LmRhcy5qekBicC5yZW5lc2FzLmNvbT4NCj4+Pj4+Pj4gVGVz
dGVkLWJ5OiBKYWNvcG8gTW9uZGkgPGphY29wb0BqbW9uZGkub3JnPg0KPj4+Pj4+PiAtLS0NCj4+
Pj4+Pj4gICAgICAgZHJpdmVycy9tZWRpYS9pMmMvb3Y1NjQwLmMgfCAxOSArKysrKysrKysrKysr
KysrLS0tDQo+Pj4+Pj4+ICAgICAgIDEgZmlsZSBjaGFuZ2VkLCAxNiBpbnNlcnRpb25zKCspLCAz
IGRlbGV0aW9ucygtKQ0KPj4+Pj4+Pg0KPj4+Pj4+PiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9tZWRp
YS9pMmMvb3Y1NjQwLmMgYi9kcml2ZXJzL21lZGlhL2kyYy9vdjU2NDAuYw0KPj4+Pj4+PiBpbmRl
eCAyZmU0YTdhYzA1OTIuLjg4MGZkZTczYTAzMCAxMDA2NDQNCj4+Pj4+Pj4gLS0tIGEvZHJpdmVy
cy9tZWRpYS9pMmMvb3Y1NjQwLmMNCj4+Pj4+Pj4gKysrIGIvZHJpdmVycy9tZWRpYS9pMmMvb3Y1
NjQwLmMNCj4+Pj4+Pj4gQEAgLTM0LDYgKzM0LDggQEANCj4+Pj4+Pj4gICAgICAgI2RlZmluZSBP
VjU2NDBfUkVHX1NZU19SRVNFVDAyICAgICAgICAgICAgICAweDMwMDINCj4+Pj4+Pj4gICAgICAg
I2RlZmluZSBPVjU2NDBfUkVHX1NZU19DTE9DS19FTkFCTEUwMiAgICAgICAweDMwMDYNCj4+Pj4+
Pj4gICAgICAgI2RlZmluZSBPVjU2NDBfUkVHX1NZU19DVFJMMCAgICAgICAgICAgICAgICAweDMw
MDgNCj4+Pj4+Pj4gKyNkZWZpbmUgT1Y1NjQwX1JFR19TWVNfQ1RSTDBfU1dfUFdETiAweDQyDQo+
Pj4+Pj4+ICsjZGVmaW5lIE9WNTY0MF9SRUdfU1lTX0NUUkwwX1NXX1BXVVAgMHgwMg0KPj4+Pj4+
DQo+Pj4+Pj4gRm9yIHRoZSB0aW1lIGJlaW5nIHRoaXMgc2VjdGlvbiB3YXMgb25seSByZWZlcnJp
bmcgdG8gcmVnaXN0ZXJzDQo+Pj4+Pj4gYWRkcmVzc2VzIGFuZCBiaXQgZGV0YWlscyB3YXMgZXhw
bGFpbmVkIGludG8gYSBjb21tZW50IHJpZ2h0IGJlZm9yZQ0KPj4+Pj4+IGFmZmVjdGF0aW9uLCBz
ZWUgT1Y1NjQwX1JFR19JT19NSVBJX0NUUkwwMCBmb3IgZXhhbXBsZS4NCj4+Pj4+Pg0KPj4+Pj4+
PiAgICAgICAjZGVmaW5lIE9WNTY0MF9SRUdfQ0hJUF9JRCAgICAgICAgICAweDMwMGENCj4+Pj4+
Pj4gICAgICAgI2RlZmluZSBPVjU2NDBfUkVHX0lPX01JUElfQ1RSTDAwICAgMHgzMDBlDQo+Pj4+
Pj4+ICAgICAgICNkZWZpbmUgT1Y1NjQwX1JFR19QQURfT1VUUFVUX0VOQUJMRTAxICAgICAgMHgz
MDE3DQo+Pj4+Pj4+IEBAIC0xMTIwLDYgKzExMjIsMTIgQEAgc3RhdGljIGludCBvdjU2NDBfbG9h
ZF9yZWdzKHN0cnVjdCBvdjU2NDBfZGV2ICpzZW5zb3IsDQo+Pj4+Pj4+ICAgICAgICAgICAgICAg
ICAgIHZhbCA9IHJlZ3MtPnZhbDsNCj4+Pj4+Pj4gICAgICAgICAgICAgICAgICAgbWFzayA9IHJl
Z3MtPm1hc2s7DQo+Pj4+Pj4+DQo+Pj4+Pj4+ICsgICAgICAgICAgICAgLyogcmVtYWluIGluIHBv
d2VyIGRvd24gbW9kZSBmb3IgRFZQICovDQo+Pj4+Pj4+ICsgICAgICAgICAgICAgaWYgKHJlZ3Mt
PnJlZ19hZGRyID09IE9WNTY0MF9SRUdfU1lTX0NUUkwwICYmDQo+Pj4+Pj4+ICsgICAgICAgICAg
ICAgICAgIHZhbCA9PSBPVjU2NDBfUkVHX1NZU19DVFJMMF9TV19QV1VQICYmDQo+Pj4+Pj4+ICsg
ICAgICAgICAgICAgICAgIHNlbnNvci0+ZXAuYnVzX3R5cGUgIT0gVjRMMl9NQlVTX0NTSTJfRFBI
WSkNCj4+Pj4+Pj4gKyAgICAgICAgICAgICAgICAgICAgIGNvbnRpbnVlOw0KPj4+Pj4+PiArDQo+
Pj4+Pj4NCj4+Pj4+PiBJIHVuZGVyc3RhbmQgdGhhdCBtb3JlIG9yIGxlc3MgcmVnaXN0ZXIgT1Y1
NjQwX1JFR19TWVNfQ1RSTDAgKDB4MzAwOCkNCj4+Pj4+PiBoYXMgYmVlbiBwYXJ0aWFsbHkgcmVt
b3ZlZCBmcm9tIGJpZyBpbml0IHNlcXVlbmNlOiBmb3IgcG93ZXItdXAgcGFydCwNCj4+Pj4+PiBi
dXQgcG93ZXItZHduIHJlbWFpbnMgYXQgdmVyeSBiZWdpbm5pbmcgb2Ygc2VxdWVuY2UuDQo+Pj4+
Pj4gV2Ugc2hvdWxkIGNvbXBsZXRlbHkgcmVtb3ZlIDB4MzAwOCBmcm9tIGluaXQgc2VxdWVuY2Us
IGluY2x1ZGluZw0KPj4+Pj4+IHBvd2VyLWR3biwgYW5kIGludHJvZHVjZSBhIG5ldyBmdW5jdGlv
biBvdjU2NDBfc3dfcG93ZXJkb3duKG9uL29mZikgdGhhdA0KPj4+Pj4+IHNob3VsZCBiZSBjYWxs
ZWQgYXQgdGhlIHJpZ2h0IHBsYWNlIGluc3RlYWQuDQo+Pj4+Pj4NCj4+Pj4+Pg0KPj4+Pj4+PiAg
ICAgICAgICAgICAgICAgICBpZiAobWFzaykNCj4+Pj4+Pj4gICAgICAgICAgICAgICAgICAgICAg
ICAgICByZXQgPSBvdjU2NDBfbW9kX3JlZyhzZW5zb3IsIHJlZ19hZGRyLCBtYXNrLCB2YWwpOw0K
Pj4+Pj4+PiAgICAgICAgICAgICAgICAgICBlbHNlDQo+Pj4+Pj4+IEBAIC0xMjk3LDkgKzEzMDUs
MTQgQEAgc3RhdGljIGludCBvdjU2NDBfc2V0X3N0cmVhbV9kdnAoc3RydWN0IG92NTY0MF9kZXYg
KnNlbnNvciwgYm9vbCBvbikNCj4+Pj4+Pj4gICAgICAgICAgICAqIFBBRCBPVVRQVVQgRU5BQkxF
IDAyDQo+Pj4+Pj4+ICAgICAgICAgICAgKiAtIFs3OjJdOiAgICAgRFs1OjBdIG91dHB1dCBlbmFi
bGUNCj4+Pj4+Pj4gICAgICAgICAgICAqLw0KPj4+Pj4+PiAtICAgICByZXR1cm4gb3Y1NjQwX3dy
aXRlX3JlZyhzZW5zb3IsDQo+Pj4+Pj4+IC0gICAgICAgICAgICAgICAgICAgICAgICAgICAgIE9W
NTY0MF9SRUdfUEFEX09VVFBVVF9FTkFCTEUwMiwNCj4+Pj4+Pj4gLSAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgb24gPyAweGZjIDogMCk7DQo+Pj4+Pj4+ICsgICAgIHJldCA9IG92NTY0MF93
cml0ZV9yZWcoc2Vuc29yLCBPVjU2NDBfUkVHX1BBRF9PVVRQVVRfRU5BQkxFMDIsDQo+Pj4+Pj4+
ICsgICAgICAgICAgICAgICAgICAgICAgICAgICAgb24gPyAweGZjIDogMCk7DQo+Pj4+Pj4+ICsg
ICAgIGlmIChyZXQpDQo+Pj4+Pj4+ICsgICAgICAgICAgICAgcmV0dXJuIHJldDsNCj4+Pj4+Pj4g
Kw0KPj4+Pj4+PiArICAgICByZXR1cm4gb3Y1NjQwX3dyaXRlX3JlZyhzZW5zb3IsIE9WNTY0MF9S
RUdfU1lTX0NUUkwwLCBvbiA/DQo+Pj4+Pj4+ICsgICAgICAgICAgICAgICAgICAgICAgICAgICAg
IE9WNTY0MF9SRUdfU1lTX0NUUkwwX1NXX1BXVVAgOg0KPj4+Pj4+PiArICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICBPVjU2NDBfUkVHX1NZU19DVFJMMF9TV19QV0ROKTsNCj4+Pj4+Pj4gICAg
ICAgfQ0KPj4+Pj4+Pg0KPj4+Pj4+PiAgICAgICBzdGF0aWMgaW50IG92NTY0MF9zZXRfc3RyZWFt
X21pcGkoc3RydWN0IG92NTY0MF9kZXYgKnNlbnNvciwgYm9vbCBvbikNCj4+Pj4+Pj4NCj4+Pj4+
Pg0KPj4+Pj4+DQo+Pj4+Pj4gQlIsDQo+Pj4+Pj4gSHVndWVzLg0KPj4+Pj4+DQo+Pj4+Pg0KPj4+
Pj4NCj4+Pj4+IEhlbGxvIGV2ZXJ5b25lLA0KPj4+Pj4NCj4+Pj4+IFdoZW4gSSB1cGRhdGVkIGRy
aXZlciBpbiBteSB0cmVlIHdpdGggdGhpcyBwYXRjaCwgSSBub3RpY2VkIHRoYXQgbXkNCj4+Pj4+
IHNldHVwIHVzaW5nIHRoZSBBVE1FTCBpc2MgcGxhdGZvcm0gKyBvdjU2NDAgaW4gcGFyYWxsZWwg
YnVzIG1vZGUgc3RvcHBlZA0KPj4+Pj4gd29ya2luZy4NCj4+Pj4+DQo+Pj4+PiBJdCBsb29rcyBs
aWtlIHRoZSBjdWxwcml0IGlzIHRoaXMgcGF0Y2guDQo+Pj4+PiBJIGFtIG5vdCBzdXJlIHdoaWNo
IGlzIHRoZSBiZXN0IHdheSB0byBmaXggaXQuDQo+Pj4+PiBJdCBsb29rcyBsaWtlIGluaXRpYWxs
eSB0aGluZ3Mgd29yayBmaW5lIHdoZW4gcHJvYmluZyB0aGUgZHJpdmVyLCBidXQNCj4+Pj4+IHdo
ZW4gd2Ugd2FudCB0byBzdGFydCBzdHJlYW1pbmcgYXQgYSBsYXRlciBwb2ludCwgdGhlIHJlZ2lz
dGVyIFNZU19DVFJMMA0KPj4+Pj4gY2Fubm90IGJlIHdyaXR0ZW4gYW55bW9yZS4NCj4+Pj4+IEhl
cmUgaXMgYW4gb3V0cHV0IG9mIHRoZSBsb2c6DQo+Pj4+Pg0KPj4+Pj4gICAgICAtLS0gT3Blbmlu
ZyAvZGV2L3ZpZGVvMC4uLg0KPj4+Pj4gICAgICAgICBUcnlpbmcgc291cmNlIG1vZHVsZSB2NGwy
Li4uDQo+Pj4+PiAgICAgICAgIC9kZXYvdmlkZW8wIG9wZW5lZC4NCj4+Pj4+ICAgICAgICAgTm8g
aW5wdXQgd2FzIHNwZWNpZmllZCwgdXNpbmcgdGhlIGZpcnN0Lg0KPj4+Pj4gICAgICAgICBvdjU2
NDAgMS0wMDNjOiBvdjU2NDBfd3JpdGVfcmVnOiBlcnJvcjogcmVnPTMwMDgsIHZhbD0yDQo+Pj4+
PiAgICAgICAgIGF0bWVsLXNhbWE1ZDItaXNjIGYwMDA4MDAwLmlzYzogc3RyZWFtIG9uIGZhaWxl
ZCBpbiBzdWJkZXYgLTEyMQ0KPj4+Pj4gICAgICAgICBFcnJvciBzdGFydGluZyBzdHJlYW0uDQo+
Pj4+PiAgICAgICAgIFZJRElPQ19TVFJFQU1PTjogUmVtb3RlIEkvTyBlcnJvcg0KPj4+Pj4gICAg
ICAgICBVbmFibGUgdG8gdXNlIG1tYXAuIFVzaW5nIHJlYWQgaW5zdGVhZC4NCj4+Pj4+ICAgICAg
ICAgVW5hYmxlIHRvIHVzZSByZWFkLg0KPj4+Pj4NCj4+Pj4+IEkgYW0gdXNpbmcgYSBzaW1wbGUg
YXBwbGljYXRpb24gdG8gcmVhZCBmcm9tIC9kZXYvdmlkZW8wICh3aGljaCBpcw0KPj4+Pj4gcmVn
aXN0ZXJlZCBieSB0aGUgYXRtZWwtaXNjIG9uY2UgdGhlIHNlbnNvciBwcm9iZWQpDQo+Pj4+Pg0K
Pj4+Pj4gSSBoYXZlIGEgZmVlbGluZyB0aGF0IHNvbWV0aGluZyBpcyB3cm9uZyByZWxhdGVkIHRv
IHBvd2VyLCBidXQgSSBjYW5ub3QNCj4+Pj4+IHRlbGwgZm9yIHN1cmUuDQo+Pj4+Pg0KPj4+Pj4g
UmV2ZXJ0aW5nIHRoaXMgcGF0Y2ggbWFrZXMgaXQgd29yayBmaW5lIGFnYWluLg0KPj4+Pj4NCj4+
Pj4+IEhlbHAgaXMgYXBwcmVjaWF0ZWQsDQo+Pj4+PiBUaGFua3MsDQo+Pj4+PiBFdWdlbg0KPj4+
Pj4NCj4+Pj4NCj4+Pj4NCj4+Pj4gR2VudGxlIHBpbmcuDQo+Pj4+DQo+Pj4+IEkgd291bGQgbGlr
ZSB0byBzZW5kIGEgcmV2ZXJ0IHBhdGNoIGlmIG5vYm9keSBjYXJlcyBhYm91dCB0aGlzDQo+Pj4+
IGRyaXZlci9wYXRjaCBleGNlcHQgbWUuDQo+Pj4+DQo+Pj4gSSBwb3dlcmVkIHVwIHRoZSBSZW5l
c2FzIFJaL0cxSCBjb25uZWN0ZWQgd2l0aCBhbiBvdjU2NDAgc2Vuc29yIGFuZA0KPj4+IHdhcyBh
YmxlIHRvIGNhcHR1cmUgdGhlIHZpZGVvIGRhdGEgWzBdIHVzaW5nIHRoZSB5YXZ0YSBhcHBsaWNh
dGlvbi4NCj4+PiBJJ20gZmluZSB3aXRoIHJldmVydGluZyB0aGUgcGF0Y2ggdG9vIGFzIHRoaXMg
d29ya3MgZmluZSBhcyB3ZWxsLg0KPj4NCj4+IEhpIFByYWJoYWthciwNCj4+DQo+PiBUaGFua3Mg
Zm9yIHRyeWluZyB0aGlzIG91dC4NCj4+IG92NTY0MCB3b3JrcyBpbiBib3RoIHBhcmFsbGVsIG9y
IENTSTIgbW9kZS4gTG9va2luZyBhdCB0aGUgYm9hcmQsIGl0DQo+PiBsb29rcyBhIHBhcmFsbGVs
IGNvbm5lY3Rpb24gYnV0IEkgYW0gbm90IDEwMCUsIHlvdSB0ZXN0ZWQgdXNpbmcgcGFyYWxsZWwN
Cj4+IGludGVyZmFjZSA/DQo+Pg0KPiBJIGhhdmUgdGVzdGVkIGl0IGluIHBhcmFsbGVsIGludGVy
ZmFjZSBtb2RlIGFzIFJaL0cxSCBzdXBwb3J0cyBwYXJhbGxlbCBjYXB0dXJlDQo+IA0KPj4+DQo+
Pj4gSnVzdCBzb21lIHN1Z2dlc3Rpb25zOg0KPj4+IC0gV2hhdCBpcyB0aGUgYXBwbGljYXRpb24g
eW91IGFyZSB0cnlpbmcgdG8gdXNlIGZvciBjYXB0dXJpbmc/DQo+Pg0KPj4gSSB3YXMgdXNpbmcg
YSBzaW1wbGUgYXBwIHRoYXQgcmVhZHMgZnJvbSAvZGV2L3ZpZGVvMCwgaXQncyBjYWxsZWQNCj4+
IGZzd2ViY2FtLiBJIGNhbiB0cnkgbW9yZSBhcHBzIGlmIGl0J3MgbmVlZGVkLg0KPj4NCj4gY291
bGQgeW91IGdpdmUgaXQgYSBzaG90IHdpdGggeWF2dGEgcGxlYXNlLg0KDQpIZWxsbyBMYWQsDQoN
CkkgZGVidWdnZWQgdGhpcyBmdXJ0aGVyLCBhbmQgSSBoYXZlIHNvbWUgbmV3czoNCg0KSXQgbG9v
a3MgbGlrZSB0aGUgJ3dyaXRlIDB4MiB0byBTWVNfQ0xUUjAnIGRvZXMgbm90IGZhaWwgaXRzZWxm
LCByYXRoZXIgDQp0aGUgc2Vuc29yIHJlZnVzZXMgdG8gYWNjZXB0IGEgcG93ZXIgdXAuDQoNCkkg
dHJpZWQgdG8gcmVhZCB0aGUgcmVnaXN0ZXIgYmVmb3JlIHRoZSB3cml0ZSwgYW5kIGl0IHJlYWRz
IDB4NDIuDQpUaGVuLCBJIHRyaWVkIHRvIHdyaXRlIDB4NDIgYmFjaywgYW5kIGl0IHdvcmtzIGZp
bmUuDQpTbywgSSBkbyBub3QgdGhpbmsgdGhlcmUgaXMgYSBwcm9ibGVtIHdpdGggaTJjIGNvbW11
bmljYXRpb24uDQpUaGUgb25seSBwcm9ibGVtIGlzIHRoYXQgdGhlIHNlbnNvciByZWZ1c2VzIHRv
IHBvd2VyIHVwIChhY2NlcHQgdGhlIDB4MiANCmludG8gdGhlIFNZU19DVFJMXzAgKSwgZHVlIHRv
IGFuIHVua25vd24gKHRvIG1lKSByZWFzb24uDQoNCklmIHRoZSBwb3dlciB1cCBpcyBwZXJmb3Jt
ZWQgYXQgdGhlIGluaXRpYWxpemF0aW9uIHBoYXNlLCBpdCB3b3Jrcy4NCg0KSSBhbHNvIHRyaWVk
IHRvIGNhcHR1cmUgd2l0aCB2NGwyLWN0bCwgYW5kIHRoZSByZXN1bHQgaXMgdGhlIHNhbWUuDQoN
CldoaWNoIG9mIHRoZSBpbml0IGNvbmZpZ3VyYXRpb24gc2V0IG9mIHJlZ2lzdGVycyB5b3VyIHRl
c3QgaXMgdXNpbmc/DQpJdCBtYXkgYmUgdGhhdCBpdCBkb2VzIG5vdCB3b3JrIGluIGEgc3BlY2lm
aWMgY29uZmlnIC4NCg0KVGhlIGRhdGFzaGVldCB3aGljaCBJIGhhdmUgZG9lcyBub3QgY2xhaW0g
dGhhdCB0aGUgJ3Bvd2VyIHVwJyBtaWdodCBmYWlsIA0KaW4gc29tZSBjaXJjdW1zdGFuY2VzLg0K
DQpUaGFua3MgZm9yIGhlbHBpbmcsDQoNCkV1Z2VuDQoNCg0KPiANCj4+PiAtIEhhdmUgeW91IHRy
aWVkIHJlZHVjaW5nIHRoZSBpMmMgY2xvY2sgc3BlZWQ/DQo+Pg0KPj4gSSBkaWQgbm90LCBidXQg
d2l0aG91dCB0aGlzIHBhdGNoLCB0aGVyZSBpcyBubyBwcm9ibGVtIHdoYXRzb2V2ZXIsIGFuZCBJ
DQo+PiBoYXZlIGJlZW4gdXNpbmcgdGhpcyBzZW5zb3Igc2luY2UgYXJvdW5kIDQuOSBrZXJuZWwg
dmVyc2lvbi4NCj4+DQo+IEFncmVlZCwgSSdtIHRoaW5raW5nIGFsb3VkIGp1c3QgdG8gbmFycm93
IHRoaW5ncy4NCj4gDQo+Pj4gLSBDYW4geW91IHRyeSBhbmQgZG8gYSBkdW1teSB3cml0ZSBmb3Ig
c29tZSBvdGhlciByZWdpc3RlciBpbg0KPj4+IG92NTY0MF9zZXRfc3RyZWFtX2R2cCgpIHRvIHNl
ZSBpZiBpMmMgd3JpdGVzIGFyZSBmYWlsaW5nIGZvciBhbGwgcmVncz8NCj4+DQo+PiBJIGNhbiB0
cnkNCj4+DQo+IFRoYW5rIHlvdS4NCj4gDQo+Pj4gLSBDYW4geW91IGFkZCBvdjU2NDBfcmVhZF9y
ZWcoKSBpbiBvdjU2NDBfd3JpdGVfcmVnKCkgd2hlbg0KPj4+IGkyY190cmFuc2ZlcigpIGZhaWxz
IHRvIGNoZWNrIGlmIHJlYWQgdG9vIGlzIGZhaWxpbmcuDQo+Pj4NCj4+PiBbMF0gaHR0cHM6Ly9w
YXN0ZS5kZWJpYW4ubmV0LzEyMjQzMTcvDQo+Pg0KPj4gWW91IHNlZW0gdG8gYmUgYWJsZSB0byBj
YXB0dXJlIHN1Y2Nlc3NmdWxseSwgSSBoYXZlIGEgZmVlbGluZyB0aGF0IGluIG15DQo+PiBjYXNl
IHRoZSBzZW5zb3IgaXMgc29tZWhvdyBub3QgcG93ZXJlZCB1cCB3aGVuIHRoZSBjYXB0dXJlIGlz
IGJlaW5nDQo+PiByZXF1ZXN0ZWQuDQo+PiBDb3VsZCB5b3Ugc2hhcmUgYSBzbmlwcGV0IG9mIHlv
dXIgZGV2aWNlIHRyZWUgbm9kZSBmb3IgdGhlIHNlbnNvciBzbyBJDQo+PiBjYW4gaGF2ZSBhIGxv
b2sgPw0KPj4NCj4gWzBdIGNvbnRhaW5zIHRoZSBicmlkZ2Ugbm9kZSBhbmQgWzFdIGNvbnRhaW5z
IHRoZSBzZW5zb3Igbm9kZS4NCj4gDQo+IFswXSBodHRwczovL2dpdC5rZXJuZWwub3JnL3B1Yi9z
Y20vbGludXgva2VybmVsL2dpdC90b3J2YWxkcy9saW51eC5naXQvdHJlZS9hcmNoL2FybS9ib290
L2R0cy9yOGE3NzQyLWl3ZzIxZC1xNy1kYmNtLWNhLmR0cz9oPXY1LjE2LXJjNiNuMzA5DQo+IFsx
XSBodHRwczovL2dpdC5rZXJuZWwub3JnL3B1Yi9zY20vbGludXgva2VybmVsL2dpdC90b3J2YWxk
cy9saW51eC5naXQvdHJlZS9hcmNoL2FybS9ib290L2R0cy9yOGE3NzQyLWl3ZzIxZC1xNy1kYmNt
LW92NTY0MC1zaW5nbGUuZHRzaT9oPXY1LjE2LXJjNg0KPiANCj4gQ2hlZXJzLA0KPiBQcmFiaGFr
YXINCj4gDQoNCg==
