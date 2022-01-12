Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CCC6F48C42D
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jan 2022 13:47:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353260AbiALMq6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Jan 2022 07:46:58 -0500
Received: from esa.microchip.iphmx.com ([68.232.153.233]:34799 "EHLO
        esa.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240521AbiALMqw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jan 2022 07:46:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1641991611; x=1673527611;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=w6JRVD0d0sYE5MaQ9lofQVnpKSWBxgr0UgeP/vMZuT0=;
  b=0OZMdGdloQFbAdIFrJOF/zB8cd/1Z1Dj4lXa7j44oBftJT8ecipqUb1X
   NYKae6F1++H80MZmr2Wu/zbqfNARq74vy+J2o26Zsra23rnp8qxb7SWbG
   x8qEmTu2gc5jqCSKYiHF/Xpgjyie/uaXhKe5KxPiwsRe5dfJ6tzN+4Bra
   GctiYsnZ0YZ8KbdwclPR3OwMOvrhKHt9XrQHy+UhlIP4DC2A03kOsCItK
   LDS3Q1Pn/1irQRkGntJe3WczrnCOV21Los51+dK5si66cFzpZOYYYJdIf
   2MpbcQrq9I+htOZ1qHmVWx0jBoMYzYu9DUJbnmF+crjlZn/gl+xNyZnGD
   g==;
IronPort-SDR: 4by1JFbOo9z8iNqRmCu5xQRsDoCOcgydxOppAdvu8W10a4ddP40jRNrutVvqi2HUbbcTcPIDI4
 tULzuRYCfLsgEGIjloCaPvCuyq6wREPhaGnrDwkOy/UtF5CofFzeFDsHIjtzUxgYQNQDOuMCbm
 4lpOmG7m4/9D8TsCh+pweuAsK+/MC+eclJjsmyKR70/fJuUpMZzivFLHFI1TLr9jxVhiI/wtPW
 tduUGuGCYVbTh0W9PUKgb5Z5vu9zLLjOx6MuCyyJFx6rnHcyfXuPN2j7NBDGcI+qmLxSF7Fdm+
 Ps0yN5zvTLFgJLBr1TvPd5Sg
X-IronPort-AV: E=Sophos;i="5.88,282,1635231600"; 
   d="scan'208";a="158398688"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa1.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 12 Jan 2022 05:46:50 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Wed, 12 Jan 2022 05:46:49 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.72) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.17 via Frontend
 Transport; Wed, 12 Jan 2022 05:46:49 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RQPM/b7NZ2Q4qDDGPcO96y2Bz7JwRNm6Ruez8bBG/2eocIPIthidwKdoUhTElckqv0ZWqB7/f7DM36GTiRl59TLZu3JejQYh/vqtH/Wpl21W9TjMEzfkbrxL8kuRGjQbUnywqIB/0EHqRuYnz47zr3nysuH/D/WKL4ye9Tl1Iq2BEUHHVoMELFoyPtCHDJ5hH6ydCgCgw8NrDmUHkmhSWuaTfGm+BsWFW/jVL3fxe8pxiXVpC3N4KI7ISiO/r3XXpbktk3Q6kUlP0GdytAfuN3p6Wk4We+55RRLKcH29mDFvMRuPBa9rppF2GXW+A/auFsh6hkvB0GDdZm0PtFicUA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=w6JRVD0d0sYE5MaQ9lofQVnpKSWBxgr0UgeP/vMZuT0=;
 b=gnE5ZipiCJ+6RTARsKpQCimUAcIxKCXYBBTAOUUPyYPlYbhgsbn/Hs4DPmZn0dFxnEBCDP+CpRO0bDiR5zNOxgVeBOZLlzDymEforVCvh4AjWLt4hAfrcAop8N+1WN96ComYuP089UgxRBAZwaLZhi60ywjADwpvCWrODJ9QICtgEcf1Hz07DbwbBVTMhBw3NNkg+qpJYxUbRu8nG7rKRL9AxLDENNrzCDyoC3mL1fCKBLRGABV3YcRzlu3AE3MsGvohlCvRUDZ2NH80ju2GOPymwFUqnpxzoTksJnqjipoWj4DxxlQtQjMIFaVtG66bKvvcxYhB73qSLPkuIQK3Uw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=w6JRVD0d0sYE5MaQ9lofQVnpKSWBxgr0UgeP/vMZuT0=;
 b=SYcA/+y29nquZWf3YPDLgK4JKY2UuK7k85q5Zw9Q2kn0vy7wNnKUgHTxNUV5g5VbROIJ+oYyxz+eNe1LPkcXTPdbxZfu2QnGUmHf3/DhfSYXFQBTKwLkI4TKSe04vsHd151Wx7OtYjdXxUzF//9rt3efdzn/EiZPh5PFi2de0Lw=
Received: from PH0PR11MB4920.namprd11.prod.outlook.com (2603:10b6:510:41::22)
 by BN6PR11MB0019.namprd11.prod.outlook.com (2603:10b6:405:69::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4867.9; Wed, 12 Jan
 2022 12:46:44 +0000
Received: from PH0PR11MB4920.namprd11.prod.outlook.com
 ([fe80::d7c:834f:4591:3c0c]) by PH0PR11MB4920.namprd11.prod.outlook.com
 ([fe80::d7c:834f:4591:3c0c%8]) with mapi id 15.20.4888.011; Wed, 12 Jan 2022
 12:46:44 +0000
From:   <Eugen.Hristev@microchip.com>
To:     <hverkuil@xs4all.nl>, <linux-media@vger.kernel.org>,
        <jacopo@jmondi.org>
CC:     <robh+dt@kernel.org>, <laurent.pinchart@ideasonboard.com>,
        <sakari.ailus@iki.fi>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <Nicolas.Ferre@microchip.com>
Subject: Re: [PATCH v3 00/23] media: atmel: atmel-isc: implement media
 controller
Thread-Topic: [PATCH v3 00/23] media: atmel: atmel-isc: implement media
 controller
Thread-Index: AQHX8Chc5lJsnh5FGk+AqTx2RTjmVaxfeZUAgAAK+wA=
Date:   Wed, 12 Jan 2022 12:46:44 +0000
Message-ID: <6cf11fa8-2a9c-badf-2243-a7ead42aa91c@microchip.com>
References: <20211213134940.324266-1-eugen.hristev@microchip.com>
 <50bb6274-b004-eff7-56d5-68ec8e10d3c4@xs4all.nl>
In-Reply-To: <50bb6274-b004-eff7-56d5-68ec8e10d3c4@xs4all.nl>
Accept-Language: en-US, ro-RO
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 3e955dd1-a15e-424c-a2c9-08d9d5c996ec
x-ms-traffictypediagnostic: BN6PR11MB0019:EE_
x-microsoft-antispam-prvs: <BN6PR11MB0019AF335761EBF4494D1F5CE8529@BN6PR11MB0019.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 3oTMhwrQQDJf+lFskMjS04O8n3XdHU4ObpamMEIlC+/8SBBq9m2q3IfX7AQmxzetNnGVhfZB3oCTaP95BK3gZt6w+AWKfF+A5sQxThTQ3ncXX4cOhaYsHq2PQ9xYh0xzTrTnWkWlvp06sNpk3eNtuiBjQqkX9M6mUZo2wFoiZjAbNtXds1fJIW+MKmbY1AG4vJwVvraZMAoL+a12IS3yym//xV5nWe6yviIAyARAApKPv8GrY/Z+oWCPwEYCII6ceUUQaFntC/QIBd/rRjGi4JQ2neqeF5egZFae0v6nHS19YAjge6j3YFMBce8dWZ5si3W5tTPQxp6T0AjIRxoir+x7PNdk+UniZaYMRJQWgE6W3jzY8PdQVMCfsd084MzcdKtcmCyPyPlnl5eWBzYygsFZ5MIRoJVpIJMCmLTLhyg6UtVF9NGMXMRFbdgVRVFc0sd9l5LjE0IlAPYdnxVD8EqRn5xSVJ5sYR4FZUV6yQNO/7jDDtgr1Sskt/TD0dkXeQuJUUC6mmZjne2fruZIYj0XIvGdDaD5TzBJi1lRc6hzEGvmdtsHG6wQtVG2HkpNr1Nivdl+ckxrNAVIgmU8YpQ+lcG4mNy2OZXWbWfQ5reKkNtqg7uDbwxrCutRUNLM1+0zGcOQR1i2Uiep1BiIl9V1KFD7Im12duv4uKfBPw4oin/6j4NgyuO5FwLDm1wi5rloQIQlVGz3KJAF85AkhKfV6YMyV07tqFUv+TMh6poYlmGm4SXDbCD+L0o/BOY6oC1hqTez4AC/d08eDxWjGdSech7fF8wBfAPigGnaaX5+ZJo4WoaxjzMPBCsbqrCKwx4852mP/s3H62Tg0UtcYURfal0W7uMNq2kHTpbf6n0tK0CtE70Cx4MkBO2ifVSJ38v/V7APxscESNiJcIPAtg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB4920.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(26005)(38100700002)(6506007)(122000001)(53546011)(4326008)(86362001)(8676002)(508600001)(6486002)(316002)(64756008)(76116006)(5660300002)(91956017)(83380400001)(31696002)(107886003)(71200400001)(66446008)(66556008)(110136005)(38070700005)(36756003)(966005)(8936002)(186003)(6512007)(31686004)(2616005)(2906002)(66946007)(54906003)(66476007)(45980500001)(43740500002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?SSthaDhzeDdRSmpPZlMvMlFtVEg1bU5aRlgvSk9IaGJXU2xKYWo5UkgweGRZ?=
 =?utf-8?B?UlNCUlFTNHFTNUJhTjQ4K0VOeE84ODhacy9FODlVSTZidzRucTg1d0EwbGZU?=
 =?utf-8?B?YU5uY2FydFFlZzdmV3ZLQ0JqTHQ2U2hHM0NGbHFiV0xnemFTQno1dmUyS1JV?=
 =?utf-8?B?Kzg1VFdnSy9DQk9XaWRwYzJzcXVvSWJmWGtBVUlMcTZPZGtOQ2hRdEdtMzhU?=
 =?utf-8?B?d2hvV3A4MGFVZVJ3U1ZTRzc3MWVIQUV5ZWFhR2NydG5GV0hYM3lzRlBtYklH?=
 =?utf-8?B?VEV1aENmR0N6OWxEVW5nclBQdVhXc24wcEVRdXFNbWEwMHFKNW9sdFVmL3J2?=
 =?utf-8?B?dU5lVytGeXJqK0xOVTJmMi90ZUQrRm4zVGlucFhLRFN1SFd3dDgwZWkva0s5?=
 =?utf-8?B?L3FxNXJ0RVloNzg3ZkUrWm5GRFZOZU11REFkZ0Q0cmRJc1c2Y1o3emlMU3Ev?=
 =?utf-8?B?c3c2YnpCOVlKQlo4ZUFacDF1Skg3Rmg3NjdiWk5RUU9oZllOTE1Yb1pWTWZ3?=
 =?utf-8?B?Q2VLYkJVQlgyc0JON1Y4a1VaZFpqWUxseEVwYUJZZm5GN2xWTXVGT2RwRks3?=
 =?utf-8?B?UHhnTHQ2UHpvY1NlcHp0a1NIdlp3YXg5WDBuSFFVUXpPVWJlTXBicTdrcHQz?=
 =?utf-8?B?ZVFlaEZ1dVcwRHZkQ21WNzdLbmt6c25KUXJaS2doK0F5Mkw4RmRmMzA4Z2Mw?=
 =?utf-8?B?RXVlSWM2ZzZUYUkybUtGSG0xWTJET05yc0VkU1hPaEMvWWp6SC9XZ1V1RWRk?=
 =?utf-8?B?dFhzQjVQMlpPY0NENVl5Wm5EdGxJY3dYckMySUtXZ1hKT2Q0UWpNUzVQeE5M?=
 =?utf-8?B?YVQvWVExUmRoWVRLR0hMcCtuL3dXdUloaGxPMHhaRXExYjFrUWl0UkU1WE1l?=
 =?utf-8?B?YmJrOEVGL0wrendrc0haOUZwY2MvY2NUT0NOejVGQzZ2Ry9PQnNnM3hSWEV4?=
 =?utf-8?B?UHRFUXBEaTY2QXZjTmRCcmxZZTBxWnowekNsdEZkbFNuVVBsdTI4YWFjZyts?=
 =?utf-8?B?Qk9yNnB4aUF4Qlk2QzUyRThpYmd6ZWUvYy83MkZCZHVwSVpxVm1XWlAvU3Yr?=
 =?utf-8?B?TlZSdjZmYTFZNDdsUDFPNyttOWFUNStTYy9seVQrWXdBak0xck1MNDJ2cWtP?=
 =?utf-8?B?bDZnbEZCQ3pQbEhDT0xpTm9Db1NIeDNUbC91YjBJUEliTHpBcHZhU1l0N1dC?=
 =?utf-8?B?Ymg1K1dVcytwN2N3Y1FLQkVmOG5sM3BENWMyeUQveWhwTFZLdXc0WDNRSGJK?=
 =?utf-8?B?VUptQ0w2SFBxOVlmdnJrZmt4YUlIRGhmUC9PR25DTzdJQTFuQWx6SnI0YjdQ?=
 =?utf-8?B?Wm9RV1k1MFhTTU1jNE12ejlNblZmZThsaEhpV01kOGVmSmxncFJNa2loTUFW?=
 =?utf-8?B?Yi9iKzZOU05ZbHpSd09ySllVQkhFK0Jzc2paNmdEb1NxblY1VFpXdlBYSEZC?=
 =?utf-8?B?eGRIQm5lRlVvS1Q3S0pxR3IxRjZpcDJhL0ZiLzJxN3E3VXFhNXNiM1F6S2g3?=
 =?utf-8?B?SFdUcmlhbHFvNE5mdXdwaW9kQjdrQUZzMGlqWGFxT0IxTkhhVmtqVzRiR0VH?=
 =?utf-8?B?UWxMTzA1QStKVnVqVlluczFNbzlNaFczb2E2S0hvUSs2b0V5Mm9xSUd4d3pI?=
 =?utf-8?B?ekV4RnVXcUFrazdielFJZHFRNFY0amJvQUNteEtFZ01taVhRUUQ1THlkOXEr?=
 =?utf-8?B?ZlV3ZmdMZWVBai8yM01HSStiL0swYWNPRVdxRytkc25EaFo2cnByRlJ3emc0?=
 =?utf-8?B?Q3NBT2R3MlpUTmVqKzk5WitlSkQzVGxZTU11L21uSE16cjFEL0xXdlJlMkpO?=
 =?utf-8?B?WFJlcklNeE8vakFCYVp5OGRFR04wOHFTTVZJV2RwcjVyZ1hUR0g3MG1QZURs?=
 =?utf-8?B?cERGU080VEVxVUVNMlFvV3VKZEZJL3JmVHIyNGxLUFgyWDQ3eFIwdmM3Smh2?=
 =?utf-8?B?SmJhd3BzYWdzbFFiOFB5cG5NeFhkUW9rbzRsbUtWTFJXRnFQMng1M1ZqaXBp?=
 =?utf-8?B?OWlHZlM4dUdhUXlWVUtaWFF3NDdVYm1HUUU1djNMSkZ5UHVuVFJnbDdEZ2w0?=
 =?utf-8?B?S1BBWjBxaHNFbDNGY2hCYnBvS2dBSlFDYVJiNUJIWlloRE50RkZkcjZYdmlj?=
 =?utf-8?B?bTFDZXlSeVFCS0FCdlZZVVpzZnlXNksvM2RXelJHWUhIYzEwRGdaSlhxV0Q1?=
 =?utf-8?B?dlhRdmF4MTEvZkdPTFRZeU9raitMTzZBNCtjd3JyUHNyQWpmWDl4cjRrWEU3?=
 =?utf-8?B?NU85ajNvT2ZlbTVVU1M4d1podk5RPT0=?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <8841957B4AFC1C48BE2AC46F1687802D@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB4920.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3e955dd1-a15e-424c-a2c9-08d9d5c996ec
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Jan 2022 12:46:44.5619
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: vvEasDYQ29v93Yvh6v2oSSHVCmvUiKtuYMe6mj7oDuDMicUIGpqsY8WKz4S8wGRS64unNOD4JvT+KjIHwlsZNR/tAc2XgpvLx6rdLSlBfHo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR11MB0019
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gMS8xMi8yMiAyOjA3IFBNLCBIYW5zIFZlcmt1aWwgd3JvdGU6DQo+IEhpIEV1Z2VuLA0KPiAN
Cj4gT24gMTMvMTIvMjAyMSAxNDo0OSwgRXVnZW4gSHJpc3RldiB3cm90ZToNCj4+IFRoaXMgc2Vy
aWVzIGlzIHRoZSB2MyBvZiB0aGUgc2VyaWVzIHRoYXQgYXR0ZW1wdHMgdG8gc3VwcG9ydCBtZWRp
YSBjb250cm9sbGVyDQo+PiBpbiB0aGUgYXRtZWwgSVNDIGFuZCBYSVNDIGRyaXZlcnMuDQo+PiBU
aGlzIHNlcmllcyBhbHNvIGluY2x1ZGVzIHRoZSBjc2kyZGMgZHJpdmVyIHdoaWNoIHdhcyBwcmV2
aW91c2x5IHNlbnQgaW4gYQ0KPj4gc2VwYXJhdGUgc2VyaWVzOg0KPj4gaHR0cHM6Ly93d3cuc3Bp
bmljcy5uZXQvbGlzdHMvbGludXgtbWVkaWEvbXNnMTgxMDQyLmh0bWwNCj4+IGh0dHBzOi8vd3d3
LnNwaW5pY3MubmV0L2xpc3RzL2xpbnV4LW1lZGlhL21zZzE4MTA0NC5odG1sDQo+PiBUaGUgZHJp
dmVyIG5vdyBhZGRyZXNzZXMgY29tbWVudHMgcmVjZWl2ZWQgaW4gbGF0ZXN0IHY1IHNlcmllcyBm
cm9tIGxhc3QgeWVhci4NCj4+DQo+PiBUaGUgc2VyaWVzIGluY2x1ZGVzIHNvbWUgbWlub3IgY2hh
bmdlcyBhbmQgZml4ZXMgdGhhdCBpbXByb3ZlIHRoZSBpc2MgY29tbW9uDQo+PiBjb2RlIGJhc2Us
IGxpa2UgcmVtb3ZpbmcgdGhlIGVudW0gZnJhbWVpbnRlcnZhbHMgVklESU9DLCBmaXhpbmcgYnl0
ZXNwZXJsaW5lDQo+PiBmb3IgcGxhbmFyIGZvcm1hdHMsIGV0Yy4NCj4+DQo+PiBNYW55IHRoYW5r
cyB0byBmb2xrcyBmcm9tIGxpYmNhbWVyYSB3aG8gaGVscGVkIGEgbG90IHdpdGggdW5kZXJzdGFu
ZGluZw0KPj4gaG93IGEgbWVkaWEgY29udHJvbGxlciBkcml2ZXIgc2hvdWxkIGJlaGF2ZS4NCj4+
DQo+PiBGZWVkYmFjayBpcyB3ZWxjb21lICENCj4+DQo+PiBDaGFuZ2VzIGluIHYzOg0KPj4gLSBj
aGFuZ2UgaW4gYmluZGluZ3MsIHNtYWxsIGZpeGVzIGluIGNzaTJkYyBkcml2ZXIgYW5kIGNvbnZl
cnNpb24gdG8gbWMNCj4+IGZvciB0aGUgaXNjLWJhc2UuDQo+PiAtIHJlbW92ZWQgc29tZSBNQUlO
VEFJTkVSUyBwYXRjaGVzIGFuZCB1c2VkIHBhdHRlcm5zIGluIE1BSU5UQUlORVJTDQo+Pg0KPj4g
Q2hhbmdlcyBpbiB2MjoNCj4+IC0gaW50ZWdyYXRlZCBtYW55IGNoYW5nZXMgc3VnZ2VzdGVkIGJ5
IEphY29wbyBpbiB0aGUgcmV2aWV3IG9mIHRoZSB2MSBzZXJpZXMuDQo+PiAtIGFkZCBhIGZldyBu
ZXcgcGF0Y2hlcw0KPiANCj4gQmFzZWQgb24gdGhlIGN1cnJlbnQgcmV2aWV3IHN0YXR1cyBJIHRo
aW5rIGl0IHdvdWxkIG1ha2Ugc2Vuc2UgdG8gYWRkDQo+IHRoZSBmb2xsb3dpbmcgcGF0Y2hlcyBm
cm9tIHRoaXMgc2VyaWVzIHRvIGEgUFI6DQo+IA0KPiAxLTYsIDgtOSwgMTEsIDE2LCAxOC0yMi4N
Cj4gDQo+IEFyZSB0aGVyZSBhbnkgcGF0Y2hlcyAoZXNwLiAxMSBhbmQgbGF0ZXIpIHRoYXQgcmVx
dWlyZSBvdGhlciBwYXRjaGVzDQo+IG5vdCBpbiB0aGlzIGxpc3Q/IEluIG90aGVyIHdvcmRzLCBk
b2VzIHRoaXMgbWFrZSBzZW5zZT8NCg0KSGVsbG8gSGFucywNCg0KWWVzLCB0aGlzIHNvdW5kcyBn
b29kIC4gSSB3aWxsIHJld29yayB0aGUgcGF0Y2hlcyB0aGF0IGFyZSBsZWZ0IG5leHQgd2Vlay4N
ClRoZW4gSSB3aWxsIHNlbmQgYSB2NCBvZiB0aGlzIHNlcmllcyB3aXRoIG9ubHkgdGhlIHBhdGNo
ZXMgdGhhdCBhcmUgbm90IA0KeWV0IGFwcGxpZWQuIEFuZCBJIHdpbGwgcmViYXNlIGl0IG9uIHRv
cCBvZiB0aGUgbWVkaWEgdHJlZS4NCg0KVGhhbmtzIGZvciByZXZpZXdpbmcgIQ0KDQpFdWdlbg0K
PiANCj4gUmVnYXJkcywNCj4gDQo+ICAgICAgICAgIEhhbnMNCj4gDQo+Pg0KPj4NCj4+IEV1Z2Vu
IEhyaXN0ZXYgKDIzKToNCj4+ICAgIE1BSU5UQUlORVJTOiBhZGQgbWljcm9jaGlwIGNzaTJkYw0K
Pj4gICAgZHQtYmluZGluZ3M6IG1lZGlhOiBhdG1lbDogY3NpMmRjOiBhZGQgYmluZGluZ3MgZm9y
IG1pY3JvY2hpcCBjc2kyZGMNCj4+ICAgIG1lZGlhOiBhdG1lbDogaW50cm9kdWNlIG1pY3JvY2hp
cCBjc2kyZGMgZHJpdmVyDQo+PiAgICBtZWRpYTogYXRtZWw6IGF0bWVsLWlzYzogc3BsaXQgdGhl
IGNsb2NrIGNvZGUgaW50byBzZXBhcmF0ZSBzb3VyY2UNCj4+ICAgICAgZmlsZQ0KPj4gICAgbWVk
aWE6IGF0bWVsOiBhdG1lbC1pc2M6IHJlcGxhY2UgdmlkZW8gZGV2aWNlIG5hbWUgd2l0aCBtb2R1
bGUgbmFtZQ0KPj4gICAgbWVkaWE6IGF0bWVsOiBhdG1lbC1zYW1hN2c1LWlzYzogZml4IGlzcGNr
IGxlZnRvdmVyDQo+PiAgICBtZWRpYTogYXRtZWw6IGF0bWVsLWlzYy1iYXNlOiB1c2Ugc3RyZWFt
aW5nIHN0YXR1cyB3aGVuIHF1ZXVlaW5nDQo+PiAgICAgIGJ1ZmZlcnMNCj4+ICAgIG1lZGlhOiBh
dG1lbDogYXRtZWwtaXNjLWJhc2U6IHJlbW92ZSBmcmFtZWludGVydmFscyBWSURJT0MNCj4+ICAg
IG1lZGlhOiBhdG1lbDogYXRtZWwtaXNjLWJhc2U6IHJlcG9ydCBmcmFtZSBzaXplcyBhcyBmdWxs
IHN1cHBvcnRlZA0KPj4gICAgICByYW5nZQ0KPj4gICAgbWVkaWE6IGF0bWVsOiBhdG1lbC1pc2Mt
YmFzZTogaW1wbGVtZW50IG1idXNfY29kZSBzdXBwb3J0IGluIGVudW1mbXQNCj4+ICAgIG1lZGlh
OiBhdG1lbDogYXRtZWwtaXNjLWJhc2U6IGZpeCBieXRlc3BlcmxpbmUgdmFsdWUgZm9yIHBsYW5h
cg0KPj4gICAgICBmb3JtYXRzDQo+PiAgICBtZWRpYTogYXRtZWw6IGF0bWVsLWlzYzogaW1wbGVt
ZW50IG1lZGlhIGNvbnRyb2xsZXINCj4+ICAgIEFSTTogZHRzOiBhdDkxOiBzYW1hN2c1OiBhZGQg
bm9kZXMgZm9yIHZpZGVvIGNhcHR1cmUNCj4+ICAgIEFSTTogY29uZmlnczogYXQ5MTogc2FtYTc6
IGFkZCB4aXNjIGFuZCBjc2kyZGMNCj4+ICAgIEFSTTogbXVsdGlfdjdfZGVmY29uZmlnOiBhZGQg
YXRtZWwgdmlkZW8gcGlwZWxpbmUgbW9kdWxlcw0KPj4gICAgbWVkaWE6IGF0bWVsOiBhdG1lbC1z
YW1hNWQyLWlzYzogZml4IHdyb25nIG1hc2sgaW4gWVVZViBmb3JtYXQgY2hlY2sNCj4+ICAgIG1l
ZGlhOiBhdG1lbDogYXRtZWwtaXNjLWJhc2U6IHVzZSBtdXRleCB0byBsb2NrIGF3YiB3b3JrcXVl
dWUgZnJvbQ0KPj4gICAgICBzdHJlYW1pbmcNCj4+ICAgIG1lZGlhOiBhdG1lbDogYXRtZWwtaXNj
LWJhc2U6IGFkZCB3YiBkZWJ1ZyBtZXNzYWdlcw0KPj4gICAgbWVkaWE6IGF0bWVsOiBhdG1lbC1p
c2MtYmFzZTogY2xhbXAgd2IgZ2FpbiBjb2VmZmljaWVudHMNCj4+ICAgIG1lZGlhOiBhdG1lbDog
YXRtZWwtc2FtYTdnNS1pc2M6IGZpeCBVWVZZIGlucHV0IGZvcm1hdCBtYnVzX2NvZGUgdHlwbw0K
Pj4gICAgbWVkaWE6IGF0bWVsOiBhdG1lbC1pc2M6IGFkZCByYXcgQmF5ZXIgOGJpdCAxMGJpdCBv
dXRwdXQgZm9ybWF0cw0KPj4gICAgbWVkaWE6IGF0bWVsOiBhdG1lbC1pc2M6IGNvbXBhY3QgdGhl
IGNvbnRyb2xsZXIgZm9ybWF0cyBsaXN0DQo+PiAgICBtZWRpYTogYXRtZWw6IGF0bWVsLWlzYzog
Y2hhbmdlIGZvcm1hdCBwcm9wYWdhdGlvbiB0byBzdWJkZXYgaW50byBvbmx5DQo+PiAgICAgIHZl
cmlmaWNhdGlvbg0KPj4NCj4+ICAgLi4uL2JpbmRpbmdzL21lZGlhL21pY3JvY2hpcCxjc2kyZGMu
eWFtbCAgICAgIHwgMTk3ICsrKysrDQo+PiAgIE1BSU5UQUlORVJTICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICB8ICAxNCArLQ0KPj4gICBhcmNoL2FybS9ib290L2R0cy9zYW1hN2c1
LmR0c2kgICAgICAgICAgICAgICAgfCAgNDggKysNCj4+ICAgYXJjaC9hcm0vY29uZmlncy9tdWx0
aV92N19kZWZjb25maWcgICAgICAgICAgIHwgICAzICsNCj4+ICAgYXJjaC9hcm0vY29uZmlncy9z
YW1hN19kZWZjb25maWcgICAgICAgICAgICAgIHwgICAyICsNCj4+ICAgZHJpdmVycy9tZWRpYS9w
bGF0Zm9ybS9NYWtlZmlsZSAgICAgICAgICAgICAgIHwgICAxICsNCj4+ICAgZHJpdmVycy9tZWRp
YS9wbGF0Zm9ybS9hdG1lbC9LY29uZmlnICAgICAgICAgIHwgIDE1ICsNCj4+ICAgZHJpdmVycy9t
ZWRpYS9wbGF0Zm9ybS9hdG1lbC9NYWtlZmlsZSAgICAgICAgIHwgICA0ICstDQo+PiAgIGRyaXZl
cnMvbWVkaWEvcGxhdGZvcm0vYXRtZWwvYXRtZWwtaXNjLWJhc2UuYyB8IDc5MCArKysrKystLS0t
LS0tLS0tLQ0KPj4gICBkcml2ZXJzL21lZGlhL3BsYXRmb3JtL2F0bWVsL2F0bWVsLWlzYy1jbGsu
YyAgfCAzMTEgKysrKysrKw0KPj4gICBkcml2ZXJzL21lZGlhL3BsYXRmb3JtL2F0bWVsL2F0bWVs
LWlzYy1tYy5jICAgfCAyODcgKysrKysrKw0KPj4gICBkcml2ZXJzL21lZGlhL3BsYXRmb3JtL2F0
bWVsL2F0bWVsLWlzYy5oICAgICAgfCAgNDkgKysNCj4+ICAgLi4uL21lZGlhL3BsYXRmb3JtL2F0
bWVsL2F0bWVsLXNhbWE1ZDItaXNjLmMgIHwgIDU5ICstDQo+PiAgIC4uLi9tZWRpYS9wbGF0Zm9y
bS9hdG1lbC9hdG1lbC1zYW1hN2c1LWlzYy5jICB8ICA3MiArLQ0KPj4gICAuLi4vbWVkaWEvcGxh
dGZvcm0vYXRtZWwvbWljcm9jaGlwLWNzaTJkYy5jICAgfCA4MDYgKysrKysrKysrKysrKysrKysr
DQo+PiAgIDE1IGZpbGVzIGNoYW5nZWQsIDIwODUgaW5zZXJ0aW9ucygrKSwgNTczIGRlbGV0aW9u
cygtKQ0KPj4gICBjcmVhdGUgbW9kZSAxMDA2NDQgRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2Jp
bmRpbmdzL21lZGlhL21pY3JvY2hpcCxjc2kyZGMueWFtbA0KPj4gICBjcmVhdGUgbW9kZSAxMDA2
NDQgZHJpdmVycy9tZWRpYS9wbGF0Zm9ybS9hdG1lbC9hdG1lbC1pc2MtY2xrLmMNCj4+ICAgY3Jl
YXRlIG1vZGUgMTAwNjQ0IGRyaXZlcnMvbWVkaWEvcGxhdGZvcm0vYXRtZWwvYXRtZWwtaXNjLW1j
LmMNCj4+ICAgY3JlYXRlIG1vZGUgMTAwNjQ0IGRyaXZlcnMvbWVkaWEvcGxhdGZvcm0vYXRtZWwv
bWljcm9jaGlwLWNzaTJkYy5jDQo+Pg0KPiANCg0K
