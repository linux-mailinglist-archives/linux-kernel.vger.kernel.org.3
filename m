Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3768649B9DC
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jan 2022 18:14:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242835AbiAYRNs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jan 2022 12:13:48 -0500
Received: from mail-eopbgr90043.outbound.protection.outlook.com ([40.107.9.43]:13121
        "EHLO FRA01-MR2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1345326AbiAYRLX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jan 2022 12:11:23 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OXXUI8rX6dMqKP88x7X7PaREWJBNDL0RFqMqddNE568Tt0S0mF9xMt2AGAdBpyFNY02LyNY7MIlMYjC3lkjI9pEWFRzvxHMQmRhLXGUWtTP3AkR1hl+wo1LAJLfl4c6r8nbqM6xnQWircBQqbESr0k8sKXPh8XjGOVNrwe6+smXrTkJe/eVfi9pR+K0jS0ZugI9BmN8Xc2+L1IENW4bERWj9Mw0tyff9JrdEC1e9a8WGGmUj3muCekiFYg3TBC6Om7k1Ikx7RvYm82ITbLuplPSHZDH1Ia5w2OiswvJhvP7f87L4XcD1hFc4pBJrm4c25j1ciIQUuk1S09b+ew+Amw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vUBKMPQT9MSDWr/cljFkZ0ysGZr2mfE+S85Sm3jPCT4=;
 b=eOokyDaSLbEZtOFYGrN6cGxN+K666jBsdKdyVyNItZ7c/3rWoyH6qMuHpWYuj6v4dltI3Ws2bdnCZ2OLjXdxz+pu/VLPxmUfzE1hL5pxZx+CsuJFOuCI54mCLCltW02Vu5dQYm6Kb7Ppww5r0elZ53f+STAhRyD4xqKO1byKpPNgfdtG4YLSWvlYlLz2mmqBb/kNuBpFjw3vH1CPApqUl8K07Rthb6V/Aba2Yaal3NZaH9goeNo+q+FInxyL6HA6uTv8OWSEQpFgdBIsKDMJ+RCRVlOqno4qv3UeeD+58NVVq8xjIeE1k7FysSmfnO1dCZZOsMg6lK/tuZU/Zfke1A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
Received: from MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM (2603:10a6:501:31::15)
 by MR1P264MB2193.FRAP264.PROD.OUTLOOK.COM (2603:10a6:501:14::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4930.15; Tue, 25 Jan
 2022 17:11:20 +0000
Received: from MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM
 ([fe80::9d4f:1090:9b36:3fc5]) by MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM
 ([fe80::9d4f:1090:9b36:3fc5%5]) with mapi id 15.20.4909.019; Tue, 25 Jan 2022
 17:11:20 +0000
From:   Christophe Leroy <christophe.leroy@csgroup.eu>
To:     Dan Carpenter <dan.carpenter@oracle.com>,
        "kbuild@lists.01.org" <kbuild@lists.01.org>
CC:     "lkp@intel.com" <lkp@intel.com>,
        "kbuild-all@lists.01.org" <kbuild-all@lists.01.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Michael Ellerman <mpe@ellerman.id.au>
Subject: Re: net/kcm/kcmsock.c:645 kcm_write_msgs() error: we previously
 assumed 'psock' could be null (see line 585)
Thread-Topic: net/kcm/kcmsock.c:645 kcm_write_msgs() error: we previously
 assumed 'psock' could be null (see line 585)
Thread-Index: AQHYEfqCqk7bncEpOUG/RwO1mvTfQaxz+S6A
Date:   Tue, 25 Jan 2022 17:11:20 +0000
Message-ID: <72a13f13-056a-be0a-a50a-4edc1cda87ad@csgroup.eu>
References: <202201220354.fJ3VzqBt-lkp@intel.com>
In-Reply-To: <202201220354.fJ3VzqBt-lkp@intel.com>
Accept-Language: fr-FR, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=csgroup.eu;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: decf2d80-bebc-4dba-7e25-08d9e025b535
x-ms-traffictypediagnostic: MR1P264MB2193:EE_
x-microsoft-antispam-prvs: <MR1P264MB219360943F406F7BCA3CF5A0ED5F9@MR1P264MB2193.FRAP264.PROD.OUTLOOK.COM>
x-ms-oob-tlc-oobclassifiers: OLM:5236;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: nz2dP2JAsPFck/QBRZwXJGxg+fE1GJ5iD2TIwyUrIZD8lmyjq0OJE5drRLv+H1tFds4wlOxwe7Z/l60SERI8rUGynxCdUO4Bm/euUw2tvleru189mD5oaKfJFFMbxQAbYT4fVjUnA+oiMDnA3vjGFMKMwvpNw6JAq84J4/gzK+woR9C+akvo/oqYPvOiV1N6aIhjmoXu6nc4vmdjvKuuX2Rsk1Iyx+F9CfoYLTEFAa16f+1DR9/GTWgkcG1bjLXsmKdXYsClsfsSIZ7Xd2zs2wVlMZHTSBrF5X7hRmKJ8XoL5f1BpJZNpEOiVsNpEMzFN8NgVk0UNrXaYrdMszmV65r7XLtbriG6/QE6FbakcGwUVVpEvEydqPOkxw3T077TQQHuqHntCvUV7mE5XKdplEXrAK1t5m51OQlbOnPYaMK2FMRdIWtbFUryX2gDD3+pRG5BhU/6h9tzSJiS0Sfasm6MjKWqX68nskjXxvRi1MrYAID9O1qvWPv9LwlpPTtVVwPxBiM2VVcU+M5qcdtfuL/q8zFqiNrVGf0y22r/gpE0I1vvNK6dRKbyRDIZLhZjzkeVOselyGo9aBWzwqM2zWyfTvBLAHzQkt2uLdcd/5C1Mda5RK3BmFw8djya4T6vk5lCs2kI9rIcA6YWzVME14pzuNO52+qOjjGlVquIiqN+NGtwdYMYL4s+R5m3Cxar7TuQjmC4VWfRLVFZcKKV4Tv9GxZu3a9ctsdPdBQJ7Dck9xU6OBnJxbZogGPNTKz6ppHZG+dFPNlBCvSM6yPqEwocIAvSpUHs+pMB87hSdclRbovDxSmBCKqlqi85JKjsKmscH0/5g7qyfH4F5ZKdb9svgxnk+v+Z5LmJJ7jHAM8=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(6506007)(6512007)(38070700005)(71200400001)(31696002)(508600001)(110136005)(86362001)(54906003)(316002)(6486002)(966005)(66574015)(122000001)(83380400001)(26005)(66946007)(66476007)(2616005)(186003)(38100700002)(36756003)(8936002)(31686004)(44832011)(5660300002)(4326008)(76116006)(66556008)(2906002)(91956017)(8676002)(66446008)(64756008)(43740500002)(45980500001)(20210929001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?OXIxQ1kyOExYTW92UC9lRjZITXhZdWNWMDQ0T2UzcDJNTzFQVG41RDAxUCti?=
 =?utf-8?B?YVkrc0txSDRWeTk1cWtWRlErRHVERm1Bd0lDcXVjT0V6NGpheWFBK2o5UDNC?=
 =?utf-8?B?VHJMVzRGK0tmN0dsZERDdmxKMHEvemdLV2kzeFdXWGs1R3Z4OHpCYmhCOUFm?=
 =?utf-8?B?WnR1VU9zOSt5ejViUndnNWJsZ2lRRjNsYUdxUjZFemxCbXU3NnB0cDBJc2Y1?=
 =?utf-8?B?RU9EL0dWM1draWxCSzhtVHhXa2Uxa0pIbWNhaUdXVzNLNHBCYXN6azVtTTlF?=
 =?utf-8?B?d2l5ZVhXMURicDhET1psdkxYRWhpaGdpVHNNRXZqalhhMHorUjdrSVIrRHVa?=
 =?utf-8?B?bmJLM095L28zdytyTWRlem84L0wxZTNyNDR0QXpublBSc2s3cE5kbERKVklt?=
 =?utf-8?B?U2R6bVYwdGtHa2MwajJUendTOFBtanB0YVpMVXRNMlg4MlR6NlZaczRVUVAv?=
 =?utf-8?B?VVdieDUzNDVmSWQzQVlmbzI3aThTNHJ1ODN2T2xKcWJKYi9JVStPeW5STTAx?=
 =?utf-8?B?R1h6ek9ZWkM0UE9wNXNSdW5iSUo0cDArRlRLcEhxVnJsaHBZbDBaTmg3dlly?=
 =?utf-8?B?SmIyTWplaHNUdTlwTEY4VUNzYkhNWlk2a1lRUHpIcmV2ekpYL1lBSjBWWjUy?=
 =?utf-8?B?UzN2cVdMNVNkN05WRGcrUEwwVTRlU2xmWUZMaTF0R2NuSkxCY3NKclJucnAv?=
 =?utf-8?B?WmFud04rVzRYM3NSdUdsY3VYVGdnL0lnLzhpcXQwWDBzM2sxeVJoVDQ0TnZN?=
 =?utf-8?B?QU5SU1UyQlJ1eHFadGZ6VVFoZm9HdmlEY2lmZ2NCd1VjdnV1cUdEODlYRDBO?=
 =?utf-8?B?T3Z1OTB6SXcvN3QzbUIwa2l5bXVHTGR0MFJTVG85Qm1qZUdlSGZER0ZubDB1?=
 =?utf-8?B?bk1rL0hFM2xPbG44NmlEaHU1Q09JNXo0STVLTFpsSUg1dXJyMzFNUG9CNjZr?=
 =?utf-8?B?dXdXUDh1aUcwTDJaTkdnblRDRTFaaG9IQm9XT3YwWEJ2Z3liTEJpbzFrREJz?=
 =?utf-8?B?d21RRGNhTm01enYyMmhWdUNMYy9RWVJVTWZ4VEd0alJjVEd5OGZRS1d6T3Bw?=
 =?utf-8?B?aWZQQk1qK3ViZVlhUWJNY0I0M2l0NUtlblhOS1NRdHhoZi9zaTJyaGhFN0h3?=
 =?utf-8?B?ZDFSYlFsY1dISmlkWmpkSE5PTC9oZ3ZmS0FUb1cydlg3MkVjREhVZkl0S3Rj?=
 =?utf-8?B?U1NEckFlMW13dmEzUkEyTDBpZHZPTXBZVjBKZzJlWGMrdll2SnhkTzN4elRu?=
 =?utf-8?B?c2ZvZ0tQcWtDUEpRTFJlamlOcmZqZElBK1VyNk5rQXluZlpvOHg2RnorWmZq?=
 =?utf-8?B?N0tkQjdNVWxHc1JMcXV6VnR1QmtiSG5VcURhdVZNNFpnYW82ZkFUL0xXRDRp?=
 =?utf-8?B?NVBVUWE3bE8vS1FMTDN6MU91WHJTYTAvRTdBL21WY2VWUEs4aURpRS8rbVNW?=
 =?utf-8?B?LzI0RnBNN09hbHJpd3ZoTjlZTFZPRklhcTRUb0tsZjg2VURUenEzeGt2WFZ3?=
 =?utf-8?B?VEdZdWM3SW83QzJYUlBjcGJmRDR3MEVqOHVHOEtvM08yNjlLQ3NWL1pxdTdh?=
 =?utf-8?B?cDNXREliY3hKTDdFTkRPSHNiKzcvWVBkOXZZSkFrcGlNaG4vWnVvc1ZmeVRN?=
 =?utf-8?B?WldlSTVpdFZBVkduOFdTOXZjMjJCUFVQWGxjMlFMZ3FXV2ZZS0EwQlNmOENq?=
 =?utf-8?B?L0xobXhVZGZQV25BSG9EeVNndGl6aWViRDhNMzF1RDRuamY5NEE0SDJaOXRh?=
 =?utf-8?B?TXp0ZmxNQWNKZTZjekhWQStPQUFDdUpybFVLN1ZJZkU4VFhiRnFMRHNoamhi?=
 =?utf-8?B?Lzl1anVELzRYWWpaYjlrTjlYNi9XTGRLUURFdXV4S3JMbXR3bHBpcXV4ejBS?=
 =?utf-8?B?dCt4K1VDWUh0MGNqR29ITFBoN1FVNzdleGVUTnRERlhsaVFOVXJURHJjbWJl?=
 =?utf-8?B?b1VtbC8zUGNmeUJQSmZ5UUR5Sjg3SnFUaFJoZ2U0MmtMdTFLcjNJODFKZGw3?=
 =?utf-8?B?ZlJzbjU4ekZ3Mzc0SkNkbW9RN0IrUE82NnlrN1lJSzd1RTY2K3NMVmNvSU1V?=
 =?utf-8?B?MnVVYWtZNjFXcWpxV3JUQkpNd0h3OFI4bVFtaVJpTnpSbFNtUlp1dnlyL3U5?=
 =?utf-8?B?cU15MVVPcDdqOFZFNkhWQlY5L3A1Q1ZocEw0UkhPNkZxcThxcXkvOFpYbkRF?=
 =?utf-8?B?SjVuS0JPNlBzMm5od0RiN1RGS0VwY2FzblJqUytiTnBxVHlUZjA0azVWMGRv?=
 =?utf-8?Q?UEBCsptGBVpw1p540ZubnWO/7JcIzFFvC6qCabq6kE=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <89CC4ABB82172D43A4239F97B98FF1EC@FRAP264.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: csgroup.eu
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: decf2d80-bebc-4dba-7e25-08d9e025b535
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Jan 2022 17:11:20.7443
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 9914def7-b676-4fda-8815-5d49fb3b45c8
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 6rjPjUal3MFxsIgS0K5r68xNQE4K9o7zlw1CbjpF345oKu7L1uTcdVyk69/LzuKxLkBwNjXilx3ywPbXiiCUS1fR620khz6Z4iyjfLY8jbQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MR1P264MB2193
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCkxlIDI1LzAxLzIwMjIgw6AgMTU6NDcsIERhbiBDYXJwZW50ZXIgYSDDqWNyaXTCoDoNCj4g
dHJlZTogICBodHRwczovL2dpdC5rZXJuZWwub3JnL3B1Yi9zY20vbGludXgva2VybmVsL2dpdC90
b3J2YWxkcy9saW51eC5naXQgbWFzdGVyDQo+IGhlYWQ6ICAgOWI1N2Y0NTg5ODU3NDJiZDFjNTg1
ZjRjN2YzNmQwNDYzNGNlMTE0Mw0KPiBjb21taXQ6IDFlNjg4ZGQyYTNkNjc1OWQ0MTY2MTZmZjA3
YWZjNGJiODM2YzQyMTMgcG93ZXJwYy9idWc6IFByb3ZpZGUgYmV0dGVyIGZsZXhpYmlsaXR5IHRv
IFdBUk5fT04vX19XQVJOX0ZMQUdTKCkgd2l0aCBhc20gZ290bw0KPiBjb25maWc6IHBvd2VycGM2
NC1yYW5kY29uZmlnLW0wMzEtMjAyMjAxMjAgKGh0dHBzOi8vZG93bmxvYWQuMDEub3JnLzBkYXkt
Y2kvYXJjaGl2ZS8yMDIyMDEyMi8yMDIyMDEyMjAzNTQuZkozVnpxQnQtbGtwQGludGVsLmNvbS9j
b25maWcpDQo+IGNvbXBpbGVyOiBwb3dlcnBjNjQtbGludXgtZ2NjIChHQ0MpIDExLjIuMA0KPiAN
Cj4gSWYgeW91IGZpeCB0aGUgaXNzdWUsIGtpbmRseSBhZGQgZm9sbG93aW5nIHRhZyBhcyBhcHBy
b3ByaWF0ZQ0KPiBSZXBvcnRlZC1ieToga2VybmVsIHRlc3Qgcm9ib3QgPGxrcEBpbnRlbC5jb20+
DQo+IFJlcG9ydGVkLWJ5OiBEYW4gQ2FycGVudGVyIDxkYW4uY2FycGVudGVyQG9yYWNsZS5jb20+
DQo+IA0KPiBzbWF0Y2ggd2FybmluZ3M6DQo+IG5ldC9rY20va2Ntc29jay5jOjY0NSBrY21fd3Jp
dGVfbXNncygpIGVycm9yOiB3ZSBwcmV2aW91c2x5IGFzc3VtZWQgJ3Bzb2NrJyBjb3VsZCBiZSBu
dWxsIChzZWUgbGluZSA1ODUpDQo+IA0KPiB2aW0gKy9wc29jayArNjQ1IG5ldC9rY20va2Ntc29j
ay5jDQo+IA0KPiBhYjdhYzRlYjk4MzJlMzIgVG9tIEhlcmJlcnQgICAgICAgICAgICAgMjAxNi0w
My0wNyAgNTg5ICAJCXVucmVzZXJ2ZV9wc29jayhrY20pOw0KPiBjZDZlMTExYmY1YmU1YzcgVG9t
IEhlcmJlcnQgICAgICAgICAgICAgMjAxNi0wMy0wNyAgNTkwICAJCWtjbV9yZXBvcnRfdHhfcmV0
cnkoa2NtKTsNCj4gYWI3YWM0ZWI5ODMyZTMyIFRvbSBIZXJiZXJ0ICAgICAgICAgICAgIDIwMTYt
MDMtMDcgIDU5MSAgCQlpZiAoc2tiX3F1ZXVlX2VtcHR5KCZzay0+c2tfd3JpdGVfcXVldWUpKQ0K
PiBhYjdhYzRlYjk4MzJlMzIgVG9tIEhlcmJlcnQgICAgICAgICAgICAgMjAxNi0wMy0wNyAgNTky
ICAJCQlyZXR1cm4gMDsNCj4gYWI3YWM0ZWI5ODMyZTMyIFRvbSBIZXJiZXJ0ICAgICAgICAgICAg
IDIwMTYtMDMtMDcgIDU5Mw0KPiBhYjdhYzRlYjk4MzJlMzIgVG9tIEhlcmJlcnQgICAgICAgICAg
ICAgMjAxNi0wMy0wNyAgNTk0ICAJCWtjbV90eF9tc2coc2tiX3BlZWsoJnNrLT5za193cml0ZV9x
dWV1ZSkpLT5zZW50ID0gMDsNCj4gYWI3YWM0ZWI5ODMyZTMyIFRvbSBIZXJiZXJ0ICAgICAgICAg
ICAgIDIwMTYtMDMtMDcgIDU5NQ0KPiBhYjdhYzRlYjk4MzJlMzIgVG9tIEhlcmJlcnQgICAgICAg
ICAgICAgMjAxNi0wMy0wNyAgNTk2ICAJfSBlbHNlIGlmIChza2JfcXVldWVfZW1wdHkoJnNrLT5z
a193cml0ZV9xdWV1ZSkpIHsNCj4gYWI3YWM0ZWI5ODMyZTMyIFRvbSBIZXJiZXJ0ICAgICAgICAg
ICAgIDIwMTYtMDMtMDcgIDU5NyAgCQlyZXR1cm4gMDsNCj4gYWI3YWM0ZWI5ODMyZTMyIFRvbSBI
ZXJiZXJ0ICAgICAgICAgICAgIDIwMTYtMDMtMDcgIDU5OCAgCX0NCj4gYWI3YWM0ZWI5ODMyZTMy
IFRvbSBIZXJiZXJ0ICAgICAgICAgICAgIDIwMTYtMDMtMDcgIDU5OQ0KPiBhYjdhYzRlYjk4MzJl
MzIgVG9tIEhlcmJlcnQgICAgICAgICAgICAgMjAxNi0wMy0wNyAgNjAwICAJaGVhZCA9IHNrYl9w
ZWVrKCZzay0+c2tfd3JpdGVfcXVldWUpOw0KPiBhYjdhYzRlYjk4MzJlMzIgVG9tIEhlcmJlcnQg
ICAgICAgICAgICAgMjAxNi0wMy0wNyAgNjAxICAJdHhtID0ga2NtX3R4X21zZyhoZWFkKTsNCj4g
YWI3YWM0ZWI5ODMyZTMyIFRvbSBIZXJiZXJ0ICAgICAgICAgICAgIDIwMTYtMDMtMDcgIDYwMg0K
PiBhYjdhYzRlYjk4MzJlMzIgVG9tIEhlcmJlcnQgICAgICAgICAgICAgMjAxNi0wMy0wNyAgNjAz
ICAJaWYgKHR4bS0+c2VudCkgew0KPiBhYjdhYzRlYjk4MzJlMzIgVG9tIEhlcmJlcnQgICAgICAg
ICAgICAgMjAxNi0wMy0wNyAgNjA0ICAJCS8qIFNlbmQgb2YgZmlyc3Qgc2tidWZmIGluIHF1ZXVl
IGFscmVhZHkgaW4gcHJvZ3Jlc3MgKi8NCj4gYWI3YWM0ZWI5ODMyZTMyIFRvbSBIZXJiZXJ0ICAg
ICAgICAgICAgIDIwMTYtMDMtMDcgIDYwNSAgCQlpZiAoV0FSTl9PTighcHNvY2spKSB7DQo+IA0K
PiBUaGlzIHdhcm5pbmcgaXMgYSBmYWxzZSBwb3NpdGl2ZS4NCj4gDQo+IFRoZSBuZXcgUG93ZXIg
UEMgaW1wbGVtZW50YXRpb24gb2YgV0FSTl9PTigpIGlzIHdyaXR0ZW4gaW4gYXNtIGFuZA0KPiBT
bWF0Y2ggY2FuIG9ubHkgcGFyc2UgQy4gIEkgZG9uJ3QgaGF2ZSBhIGNyb3NzIGNvbXBpbGUgc3lz
dGVtIHNldCB1cCBzbw0KPiBmaXhpbmcgdGhpcyBpcyBnb2luZyB0byBiZSBhIGJpZyBoZWFkYWNo
ZS4gIDovDQoNCkNhbiB5b3UgZXhwbGFpbiB3aGF0IHRoZSBwcm9ibGVtIGlzID8NCg0KWWVzIHBz
b2NrIGNvdWxkIGJlIE5VTEwsIHRoYXQgdGhlIHJlYXNvbiB3aHkgdGhlcmUgaXMgdGhpcyBXQVJO
X09OKCksIA0KaXNuJ3QgaXQgPw0KU28gd2hhdCBkb2VzIHNtYXRjaCBkb2Vzbid0IGxpa2UgaGVy
ZSA/DQoNCkhvdyBkbyBJIGluc3RhbGwgc21hdGNoIGFuZCBob3cgZG8gSSB1c2UgaXQgdG8gcmVw
cm9kdWNlIHRoYXQgPw0KDQpJcyBpdCBsaWtlIHNwYXJzZSwgZG9lcyBpdCBzZXQgdGhlIF9fQ0hF
Q0tFUl9fIG1hY3JvID8gV291bGQgaXQgd29yayBpZiANCndlIGRvIGEgc2ltcGxpZmllZCBDIHZl
cnNpb24gb2YgV0FSTl9PTigpIHdoZW4gX19DSEVDS0VSX18gaXMgZGVmaW5lZCA/DQoNClRoYW5r
cw0KQ2hyaXN0b3BoZQ==
