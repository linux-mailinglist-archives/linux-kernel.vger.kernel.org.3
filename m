Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4B5FE4F140A
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Apr 2022 13:49:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376443AbiDDLur (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Apr 2022 07:50:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230134AbiDDLup (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Apr 2022 07:50:45 -0400
Received: from esa5.fujitsucc.c3s2.iphmx.com (esa5.fujitsucc.c3s2.iphmx.com [68.232.159.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E0273CA73
        for <linux-kernel@vger.kernel.org>; Mon,  4 Apr 2022 04:48:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
  t=1649072928; x=1680608928;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=qREfmwzkSFVS2xVFJClf/nNn47V3MaGM3Bwe9KaJygg=;
  b=mAaHf0Eyc8R/7AQGOND1XVfFXYisWsw62cKLMdR4F5qyRMz5xd5a0dks
   8oDJOB/s8uZ+6bcIpnupOSzMY0A3QdX5ysCqVZORuROZ3ahBcx1bgx21p
   47SgUvtVCNXdC7PAyObMrnmSzWstE2wvYXtDSl8exKXvkdWWqXZd+/5aT
   p0vrh9DfOZl6t4liPQ8Kuvz0hoYaGyYjwtOeMKsg+70417vlQZHvGM9AH
   gxO2yWJqofkRQc/1PM2UNZpFWUBailxxuPAwn7S+mDR+B5OOSkSWMDL/i
   aEjOP5p4K7RZewVvS5HjVZSUnd3Xs6WW/qGns5vMiuWoUZr2tIiPooU7N
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10306"; a="53286629"
X-IronPort-AV: E=Sophos;i="5.90,234,1643641200"; 
   d="scan'208";a="53286629"
Received: from mail-tycjpn01lp2171.outbound.protection.outlook.com (HELO JPN01-TYC-obe.outbound.protection.outlook.com) ([104.47.23.171])
  by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Apr 2022 20:48:43 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bqg8w8aLi1mLeCuU3ok70/GFo99hn4Hwjfg6CquDe9nRuWJPVyfOxM+tU1bEH0DssQq01S0yaF3rY8FECdTEWMbNQ8jUdm6r+jn2y5Xc6/3WqcL2Ki7h1KXowwAKlAqmf9BrJJfjGtBQoC6uku8Q5Eqw1piLhkeAoQOZgsgZFI+tP/5dNtPZOf+Pr+2lW+Ng3fzlX+DiBIVPCAENNC1I2BavEr+wF58VV7RrV3e9vS6zRSdK906yCiyOfbvMI0R/p8Fv9/+MlRUAb2qQ7nQgae1K0Ny+O3xFr1oG5GDotthr42dH55fRYKi8hGquPAJ9+vMDkFacfFZOb9EsKcY7Fg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qREfmwzkSFVS2xVFJClf/nNn47V3MaGM3Bwe9KaJygg=;
 b=kNRxVaenbYPP85YbS4JUABlfyJ1SdjMPv6JznFSPf0JVF65RP692jgqW+J4Ef7uSYJ7LbsaNbnh2zucTHmdgEWPEKXXfXiQZ3NL1d5Eg2bGxGybul7Me5eiJxWhTE05gi60R9DhMyGamrJywjdrEDI2wzCOmf5z4x4NYyA83bNSX/qEjJIwSp2Fbx7Dv8Yg5z9RSjlpsd3Sv4w5GoDMLyAjhjsB4AqWv4IKtqP6rXX9CNVY5DR7OLrU1IlxIAMgZPDCif1bKo2ywwSAHhKvy2fMa7Km3pyVXUzQ4TWjWRSeOTf4j88I5xHCyvQKtbl/4poMbry1bnCMsj4xXpuiX4Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=fujitsu.onmicrosoft.com; s=selector2-fujitsu-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qREfmwzkSFVS2xVFJClf/nNn47V3MaGM3Bwe9KaJygg=;
 b=DU8nSFOsZdeBg9rUPLXdKlzibjz0RGwebJrGl5CtvzSRa1gR8ftsa9ukh0PRGCHs0tp8Iam8pPxOFVJiYFy8evQgULkozihaYpCyDEtDn1DvlNKZ7aIkB3hpVQ2hugxfa2EVxSt9oFeLUCARBBQ5zFZquXUnkwRrWWDAK+bY0xI=
Received: from OSBPR01MB2037.jpnprd01.prod.outlook.com (2603:1096:603:25::17)
 by OSAPR01MB4435.jpnprd01.prod.outlook.com (2603:1096:604:63::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5123.31; Mon, 4 Apr
 2022 11:48:40 +0000
Received: from OSBPR01MB2037.jpnprd01.prod.outlook.com
 ([fe80::a01d:8cfb:2889:a316]) by OSBPR01MB2037.jpnprd01.prod.outlook.com
 ([fe80::a01d:8cfb:2889:a316%6]) with mapi id 15.20.5123.031; Mon, 4 Apr 2022
 11:48:40 +0000
From:   "tarumizu.kohei@fujitsu.com" <tarumizu.kohei@fujitsu.com>
To:     'Rob Herring' <robh@kernel.org>
CC:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        X86 ML <x86@kernel.org>, "H. Peter Anvin" <hpa@zytor.com>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v2 5/8] arm64: Create cache sysfs directory without ACPI
 PPTT for hardware prefetch control
Thread-Topic: [PATCH v2 5/8] arm64: Create cache sysfs directory without ACPI
 PPTT for hardware prefetch control
Thread-Index: AQHYNTHJC6TH14O00EWCaC45/KXqIqzYnMCAgAcqBAA=
Date:   Mon, 4 Apr 2022 11:48:39 +0000
Message-ID: <OSBPR01MB2037F1C72276FD4E4ECBF44A80E59@OSBPR01MB2037.jpnprd01.prod.outlook.com>
References: <20220311101940.3403607-1-tarumizu.kohei@fujitsu.com>
 <20220311101940.3403607-6-tarumizu.kohei@fujitsu.com>
 <CAL_Jsq+TvPMZLeBx5Xi4pUNKueGUG9pSTXO2DzWov401w4a6Qw@mail.gmail.com>
In-Reply-To: <CAL_Jsq+TvPMZLeBx5Xi4pUNKueGUG9pSTXO2DzWov401w4a6Qw@mail.gmail.com>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 4426af01-7f52-466d-ad7f-08da16310fe1
x-ms-traffictypediagnostic: OSAPR01MB4435:EE_
x-microsoft-antispam-prvs: <OSAPR01MB4435554AAEB365338687D2F680E59@OSAPR01MB4435.jpnprd01.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: A0IvqygGq7x5QbBozcslocCaSHOv8Vyynd5EmROGA6D8X4OZx0Ik/m8I9euPZ71oSZjlUG/VXHDUytZp5sXbEFqMDeQ/h11gV+rkrEOVgico3ayXanP/0d4p9epJT6jlRlzsRq7mz8cqEeqnP8c0zAeZeiNHysbRHGjKU0XmwGJjQDQfd9+jTWyqCXQ0q2Bfz8RIdm84r28TScoeoNSMKgfLj33T+5FePTJMp63Uvvo5ogtZm5rc5zumsrC0bbgSxc/RbtG9o9fX1XfVD/lHfR23YaVLT8j5+PPijT38eviDPIwEWKKy1BsSNv/f1cgzXRsJACf/IyUZ4Ao54kurPX7oVQZtcw+ubVyAecCD7YDDuY7enhroezWhrzptQdf2VBbSrN/B+m4QT+aO7Ke1kWYh5wHiTo3TOGVtxUdZ6Zrwr+kaelIuYQ9HI8OGkzQg6r3iqzUB+2UbqqKSRXXj9KELwsnFhQbbwmMnmsqczncLxFsDvNDXjNGzw4NnodzotGdjPXgxEHv40c8XshAAP+f4xFpiHL8p/x63tGIfrZi+mWtd4RnSATa/Zoi8a+eEWsjeT+6sIdguuRBtYB462tSzis7UPyje6X37zXlxuUEyEQtIJmZTlQOIpoi8aKpbUcGwD1IuM/c5JAFPJigFGNLZ/U5mzgv6C/VX6iz9z74YYSPo7eR+l+Qsl9ZkqT9u3+sger/18w/k9E06U+POVg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OSBPR01MB2037.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(38100700002)(7416002)(122000001)(4744005)(5660300002)(508600001)(6506007)(7696005)(82960400001)(54906003)(6916009)(38070700005)(2906002)(9686003)(316002)(33656002)(71200400001)(76116006)(8676002)(66556008)(86362001)(66446008)(66946007)(4326008)(85182001)(186003)(66476007)(64756008)(55016003)(8936002)(26005)(52536014);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Q00vcVRHUXFWU2dtZEJRRUVxQmN5ZVBtenYzSTFqaXBRVDg3Z0trSW1tZU9P?=
 =?utf-8?B?U2kxQzJ0K3JMcEo4M3RJdXBJbFNYQlNoNE5JcTIwZ015dkhpYnV5UEQxcjNs?=
 =?utf-8?B?YnE5Z2x1R0JzTmNTZEVxNURiK0JLa2dqRzhmTGlPRzlQc3pFdkhJcHpoajd3?=
 =?utf-8?B?bWp5TFRFNU13aDZ6M3dYa2lnRjlNTDR6OFZUcDB4YmZUOWRtZmlXQXM0UHVH?=
 =?utf-8?B?dmhNU3ZGVUJzL09iQ1ZsN3N6WEVmdmdXc2FHWnFQM2t2eXhtcHkrRFdYYitO?=
 =?utf-8?B?ZUdkUTdvWnp6ZWhOa0p4OVlTVkxmUmtOV2Zyb3NzdXAxd2NJNnd6a2Q3bXBB?=
 =?utf-8?B?L0g2RW45ajJuMVFiRlJmLzdFSXhGd3RCdkJLQVQrWnlsYnYxNUpuNjVZREwy?=
 =?utf-8?B?ZTNadWhwYVFYNmdqdGIrYzA2eDZFRUV4eGY1NEJ1cmpndElLc1JORFJ4M2gw?=
 =?utf-8?B?OG45ekVpQ1Z2QzFXQmxQZTFWQ0dCRkZ2K0x2UkpNNVdvN01xcG00VTJFZmVQ?=
 =?utf-8?B?N0VLQmZzWXg2MVdFTm05bDQ1NFJ3NlQybGo5MHI3U0xaMDJVamtzVWh0aVhN?=
 =?utf-8?B?K0FsQ0FxZkdsVHF5YzUwRXZCS0NKUmsrTHBSWW1saVNoQnBUTkVJckRxb3NS?=
 =?utf-8?B?aS9NNnU4cDlYV1IwdmphUFBiR0VjY0pQbkxZQUgvTmdTWS9penVnZkhsZ3lO?=
 =?utf-8?B?UVZKL2I0eVNBa2tFVDRIdExnaUEzU3Y0bkdxT3BRakt4OFAzbXN6RUNUVXhX?=
 =?utf-8?B?MjZtcENkbzJDYSt4NFJsckNQL0xqSkxSc0ZpWkI1MnMyM1h2ckJnNzFMNDNN?=
 =?utf-8?B?dzYwNDlhTEprQjIreFpwaHJwSUxwanM1aElRZ3lWaVRWT0lycWs3Z3ZOOTZZ?=
 =?utf-8?B?aWllUnYzbDhrNHZ2amJ2Z1N1ODM0VkVmTzNpdFdLS3JxZEc4NFREcXBjN0tV?=
 =?utf-8?B?eHFzRHZnUk9OYmJjRjZ5K3d4cVJlT0tFbTREb2RsMURqc041SGIzK0VqS0JB?=
 =?utf-8?B?TU1OVU5kRlg3TDRJS2JQeG44elM0NC9YQ2E3ZDdqL0JXa1hCTDNLc2V6YkRD?=
 =?utf-8?B?SEdRaGFHdmZjVW1xaTAxZmZ1akIySmxUTlhjeE5YWUtZUzJIRXZQTU1iZGxJ?=
 =?utf-8?B?UVh5Z0pGcFpjZEZvankzeHlqbmRzdGxPZFNBc1VjVk5NSzdwSnlvMmg3cEo5?=
 =?utf-8?B?Vi9vTDFxWU0xYzJFNnA2VnpyNmxNNkFza3A3ZnpCKzNNb29sVkdZc3RBbUtV?=
 =?utf-8?B?Zng3M1V2ZkhuaDZROE5XeGljcWovRHZyRnNPdStvTWpPMFlvdXJPZ09CMWNt?=
 =?utf-8?B?bGZVV3JYT0ljMDNhcmhJK2NkZGE1djRXdUo4cHo1SkV4bFlSSk9uNDFLVXRD?=
 =?utf-8?B?UXE0aFQ0WFc3eVhkZmJoa3o1WmJOanpYaVEzOEdoNVJlZTJGczVES1JaTCty?=
 =?utf-8?B?TVhRbytWdHRJUk9QMGhRTitncHhnSDRJSGRyYmtOZWdFQWdPdFh3dEl0K01L?=
 =?utf-8?B?R2l6ajlFOXJPNWVoK3BpZC9mblM5dHVPNEprY205NFpOWkFETlBWUWMzQ1Jt?=
 =?utf-8?B?OXR3bUkvQ1ZtYnVwNkJGSXo5cEwzWWo1eUxHNjdCZFhNZXVyVDlYU0l6a0px?=
 =?utf-8?B?c3dIRjVwZVd1THVjZWtwM3JvTjZpTVl1MCtURlFxdVVlRWd0TnpGeUtMaFps?=
 =?utf-8?B?YjNyempISG9yMHliZDRjVjJLWEVEd2VleFI0T3MrYmFCekVEM2R2VkY1dnpt?=
 =?utf-8?B?YXl1UGdsc3BsMHNZK0tpMVFqRHRTWVc4SzV3Z05QRHM3N3BLUVNkbHh0aUF0?=
 =?utf-8?B?QUNib3NsaGd2d2hLQ0R6dGNLYnNIWDJ0Qnc2TDZSam8yK2w5WENHWnFtKzFO?=
 =?utf-8?B?TnlYZWgvSnp5WEU1K0xUYTJNVEhUeitHQlU3STk0ZEZmNm5vdmQyMktyeURR?=
 =?utf-8?B?Y3ptS2dnZmtyNjdmUlVqU2FBNzlSOHVaRFhQeFEyRy9ra2JrL3pVbEw1RnNm?=
 =?utf-8?B?QkFmeGRzVlp5SElkS0ZPY21uN1BOWExRVjdWNmpSUjM3V2dmOFRaWm01b3k0?=
 =?utf-8?B?UmdkSWMrUlV1UzRUQ01ZSk83TzZocTFwcTBEMHFzR0hlVUROdzRpUU1wNnJ1?=
 =?utf-8?B?SVN5Wmg3b1ZBYUlQR0RxSytkbkRaYS8rVTNqdkFyY0dlb1cxdmhleW8ybG1o?=
 =?utf-8?B?UVBnanlzWWxMeHovY2JZWFVaN084N0pDMkZ4SmNQNElXRzQwK0NNNXpDQ3kz?=
 =?utf-8?B?Q25UVDNIUitGK2VtVUsrZUxlelBMSTBncUgwS01uTkt2eENPeHVtTi81d0ti?=
 =?utf-8?B?RVNaQ2w5ZThZL0RxejljenJSZGF2OFJYcHR1USs1VzB1bmlGVzRtalQxN0ls?=
 =?utf-8?Q?obfZdtkQJs7gJvRY=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OSBPR01MB2037.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4426af01-7f52-466d-ad7f-08da16310fe1
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Apr 2022 11:48:39.9503
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: h51VTi0kR8B88MHDxrrvJGHoemKQLCNLJQFZktSxOR6AA4MN/RYC9f0nOBhpp0xRBaZlTVjTyyWDaKEklEDdyKA7ljBik7uj+yhzZ5dnxAw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSAPR01MB4435
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiBXaGF0IHJlZ2lzdGVycz8NCg0KPj4gSGFyZHdhcmUgcHJlZmV0Y2ggY29udHJvbCBkcml2ZXIg
bmVlZCBjYWNoZSBzeXNmcyBkaXJlY3RvcnkgYW5kIGNhY2hlDQo+PiBsZXZlbC90eXBlIGluZm9y
bWF0aW9uLiBJbiBBUk0gcHJvY2Vzc29yLCB0aGVzZSBpbmZvcm1hdGlvbiBjYW4gYmUNCj4+IG9i
dGFpbmVkIGZyb20gdGhlIHJlZ2lzdGVyIGV2ZW4gd2l0aG91dCBQUFRULg0KDQpUaGlzIHJlZ2lz
dGVyIG1lYW4gQ0xJRFJfRUwxLg0KDQo+IENDU0lEUiByZWdpc3RlciBpcyBubyBsb25nZXIgdXNl
ZC4gWW91IG11c3QgdXNlIERUIG9yIFBQVFQuDQoNCkkga25vdyB0aGF0IGNvbW1pdCAiYThkNDYz
NmY5NmFkIiAoYXJtNjQ6IGNhY2hlaW5mbzogUmVtb3ZlIENDU0lEUi1iYXNlZA0KY2FjaGUgaW5m
b3JtYXRpb24gcHJvYmluZykgcmVtb3ZlZCB0aGUgY29kZSB0byByZWFkIHRoZSBDQ1NJRFIgZnJv
bSB0aGUNCmtlcm5lbC4NClRoZXJlZm9yZSwgSSBvbmx5IHVzZSBsZXZlbCBhbmQgdHlwZSBpbmZv
cm1hdGlvbiB0aGF0IGNhbiBiZSByZWFkIGZyb20NCkNMSURSX0VMMS4gQXJlIHRoZXJlIHNpbWls
YXIgY29uY2VybnMgd2hlbiB1c2luZyBvbmx5IENMSURSX0VMMQ0KaW5mb3JtYXRpb24/DQo=
