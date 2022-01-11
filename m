Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2DB7A48B25A
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jan 2022 17:38:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350059AbiAKQia (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Jan 2022 11:38:30 -0500
Received: from esa.microchip.iphmx.com ([68.232.154.123]:32900 "EHLO
        esa.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350052AbiAKQiV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jan 2022 11:38:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1641919101; x=1673455101;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=KwimgrXx+RKwS9lvpZ8cM3rSWXcTXgnH+Y8YrFkcKzs=;
  b=Y5nsOUhXJCyjQnYTnIvYlBcs3h3ptFJanVYpGNNzqMdAFIU6QparYuPF
   DOu8vfmXN10f1n7q9wQv7ud45Pt6nDFyDFnYNlPTdv0tPSvP7TrGN64zW
   sHekzi0C57QhLJX8OcQ3nO3vVrD7rf+UV9Apg9AyHzNgKGd3WZPE9akic
   HuILLMd/Po5qs16z92/UbLShua4q0oeaWpG5TI16iuDI7bUJydaOHybsh
   PYr4BFQIebY7zCyR7vQdcprMFMJgA0OZDKG6CK3OX70CERT/t1Mly4166
   rEdOMcg5qY+ubOA6tD9Ew5p1xyX9w0LbNm3ZAl5ps67US0fk27IZ8JMLZ
   Q==;
IronPort-SDR: RYHpD0fxFfeEDtFBRIFj4esv9ZY20gTIYmDG9gtLL2CnL3j2Pu0M00CbuyD3RFQGkmemTHr9ud
 EBvTxE1jX4sj26RJb1ffS1BwfqfDFrGs+PEE+2adCW1zTOphM32kMnhKWOs66ePy0PRvR1uqge
 QoBRFpBmEmdvy0MECpOrVusZxibW8x9LVHTa+ElpVNVKYpIa6qqbiyUcmf/zwD7jqV5qoYc6TY
 3bfX5Tq/poEwPP4oGNT3sq8s1K5fQLzykjC+34rzftskAZHTai/MUzvmyr1bxmvp0uK5Gq1HwA
 r7v8EZ8mAZMbXjwFapKwY69B
X-IronPort-AV: E=Sophos;i="5.88,279,1635231600"; 
   d="scan'208";a="82143527"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa6.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 11 Jan 2022 09:38:20 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Tue, 11 Jan 2022 09:38:20 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.17 via Frontend
 Transport; Tue, 11 Jan 2022 09:38:19 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EYnFDKQ/XE1t9tByd4upi9pXeCBOg+nyRSmLPz4JuxL+6Yk4fqPo0bLiUH4iF1XTImmCSBSry0fIvZv3R6b15XBfUhvsDkSqfH+11Bpz1R4knXHlHDM9042AqV38LblMO8h01ozQtBg+ANSUvUXQ7qPYS0hmfBmXGJCCwepAu7EBaNsgcpGpWRatKhz0KZa2x+tBKTsWenHwz2ojxcB6CiHkr4sQ7LDf4K4Dro9BClv98gBLtae/maHhysH3iXU+jmbBwdmklAQOHv7ta9avlrvb1Q79USBzgm1b5vuv1BY5lHG0K8c/rna8RoMoLtE6cFPBXiLlo0gUe6ZiAtXrPA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KwimgrXx+RKwS9lvpZ8cM3rSWXcTXgnH+Y8YrFkcKzs=;
 b=gFRiICw7FOGWfHIAPi4vTJlMqLra0xzDVXPZrH1udtdK5ongDRbprXEqZn7Lt6j7pZe+3nZGeabgcWlUlhNi4KOzl4RHV9k7of0eVuy3ixc84/A8GxRp7BwihXuLhGAoijGqbfj2as0bE7RVsrCs2RotgHDKnS45zUrFVGDEwPOk8igbYkDfAmENukyTubjY6PN7cURcn7KW2YADIHMN41B1huiyQj834PYop+O6J7R29keJ0fmJMKS4j1ARB3/RutzSSxToy2/Uw8NFyncs1LnVRjISdNFoWyf+4w0Amx58MretMeT3OeTnX4ACC2COieAXerP6pHehtI6gcyO4+g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KwimgrXx+RKwS9lvpZ8cM3rSWXcTXgnH+Y8YrFkcKzs=;
 b=F0cu5AN5MvX2xz13V6qimfLCIDHFrwd7UIKsCyG7zlRYe73i8G8GbAq7c+KP2lxhhHaf3ZoOCvsUMG68ApqJW+tzOY44n5kmM8CVO9umUt25ViKfEhm8mdvzkQdYeEd+yL5ofmUN9jszS5bSxhNhxWXugWf6uc7ht+atoCnTW1U=
Received: from PH0PR11MB4920.namprd11.prod.outlook.com (2603:10b6:510:41::22)
 by MWHPR11MB1485.namprd11.prod.outlook.com (2603:10b6:301:d::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4867.11; Tue, 11 Jan
 2022 16:38:17 +0000
Received: from PH0PR11MB4920.namprd11.prod.outlook.com
 ([fe80::d7c:834f:4591:3c0c]) by PH0PR11MB4920.namprd11.prod.outlook.com
 ([fe80::d7c:834f:4591:3c0c%8]) with mapi id 15.20.4888.009; Tue, 11 Jan 2022
 16:38:17 +0000
From:   <Eugen.Hristev@microchip.com>
To:     <hverkuil@xs4all.nl>, <jacopo@jmondi.org>,
        <laurent.pinchart@ideasonboard.com>
CC:     <linux-media@vger.kernel.org>, <robh+dt@kernel.org>,
        <sakari.ailus@iki.fi>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <Nicolas.Ferre@microchip.com>
Subject: Re: [PATCH v3 07/23] media: atmel: atmel-isc-base: use streaming
 status when queueing buffers
Thread-Topic: [PATCH v3 07/23] media: atmel: atmel-isc-base: use streaming
 status when queueing buffers
Thread-Index: AQHX8CiVdfXd9oS6LEuz0qJiSrlq1axeJnwAgAAMcQA=
Date:   Tue, 11 Jan 2022 16:38:16 +0000
Message-ID: <5e4f591b-9105-9de0-5067-2bd82dc04983@microchip.com>
References: <20211213134940.324266-1-eugen.hristev@microchip.com>
 <20211213134940.324266-8-eugen.hristev@microchip.com>
 <c6adb59e-4554-dc08-3772-148eb22c29ba@xs4all.nl>
In-Reply-To: <c6adb59e-4554-dc08-3772-148eb22c29ba@xs4all.nl>
Accept-Language: en-US, ro-RO
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 4dcec08e-96ce-401a-706c-08d9d520c506
x-ms-traffictypediagnostic: MWHPR11MB1485:EE_
x-microsoft-antispam-prvs: <MWHPR11MB14859D65BB3F88909B210655E8519@MWHPR11MB1485.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2958;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: tynuaR/NIHvTmSA2RDlAb6lKgbuDLeFzs0lSoVNn6QneVvPUp3qXBF+HVS9AzyNFnPPDL0I2BVEj1f3okhshLBNkcxV0BW9pWLtELqQkQhpPGPw8rPbtaXHQcQauvx5bJUnwJqYxwiDfPY/1x2JAzgtAxto9/zO96GViUUkiRb9jWIWgByAyqd67VTgMJX9iWVUT3s6p27HUzZDFx7QDUFJzZc69EFgn99nZOu58Gg8pVJy8AkErZwumbee0jN9b3/CRjdQqMw+9s9rcbTXk7DPNAz5KMCNJoiEVzRnFH3ZLwLL/2DE4e5L/XSK5kc4r7iThkJ+tM3D2Jmd7EaRsChoujOFaf5SMSxXfwhLDOCvRlEgIAS4XPj7djSZsFJ5CqYxiRLKcfA+IH4luialuk1In1Acn+pEadG2dxeIUBar+WnAEuy9B5pi0rEfIahExDolxpgqbaDfnWTgjr3zoTggF4aX+OyEPORiMknfEbgg6ZlswBhYhqQiVgCMrCAXskNlMQUypm72tow4mz3U/74u5XVvGzrtdkv/S3zRji8FcEO9id6ya9P/Jd3lbnQuocGMIZHzEZFVayIm0MjJgkXnL+iBjppfEFxCiC7Xw+lZPkuAyxJY+g02AI4rf5zNII4z3bX3SIzhci3MF441sraUCjw+YadiAB8el2UQpXN68vm2tvNiO39vdgaoSNwwgf/uSQlDrEjr/38ujrxzoqUFU75Mi9zds2gKEc0hG08Y//gVZQEZx0fS6rxhUDaPlwz38I4JeKcTbJCzC3HqJ2Q==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB4920.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(38100700002)(54906003)(66946007)(8676002)(508600001)(71200400001)(66556008)(38070700005)(2616005)(6486002)(53546011)(26005)(36756003)(186003)(91956017)(4326008)(76116006)(64756008)(5660300002)(6506007)(66446008)(31696002)(316002)(31686004)(6512007)(122000001)(83380400001)(86362001)(8936002)(2906002)(107886003)(110136005)(66476007)(45980500001)(43740500002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?dGtwM0gzZlFxWTQ5VzFnZFViQUp0dmphdWxPOW96KzVYOVE4czVDcDl5SFNm?=
 =?utf-8?B?UG4zcmh1cWwySDg4WGcwTWtHMlIxUDFYdzVIOUR5UlJyMVR0a0FzTXNJZFZF?=
 =?utf-8?B?QkZuRzg4amxmcE1tcWRtTWRkb2pocjUzK2hqMGFPendsUnQ4YmdjSTA5TFhw?=
 =?utf-8?B?a0g0SGZnaWcrb3VvcVdPb3EwZzVVSUVJSHlXUHBhUkVUU3RPeVN5YnpYSlNk?=
 =?utf-8?B?L3lGbnI0eXhOdVAxWjhQYWZLU1p4aFVTakxsZ3F3ejJnaFhxTGNJUTNua3lo?=
 =?utf-8?B?MXJDdkVBaGZ5T1o5MUw0YVYzTGpXYnpTRDlYenMvK2pxS2RORkd5cXE4bFhi?=
 =?utf-8?B?eFVwRldLN2NtTGpBbmU5YytrdWs2MEJoaTJTM21BeFpFamk2Wjl5bTRpV3hy?=
 =?utf-8?B?TXdYY0tQd0NNN3JYa2taU0RjMldXcFRjNFVDWE1rUVFQYnJ1Mkx6dVZBUTdj?=
 =?utf-8?B?cG82SXNRMGlEczZocEc3dzFDT1BiU3dqNkozcEtKVUlKSFhWVCsxNHF4UTZQ?=
 =?utf-8?B?dzZ6MGhBdFVOOFdrWG53d3dYcUtDYVdPdnFWNmU1VjNtVWc3ZEsrWlpiRUtk?=
 =?utf-8?B?UmxHcU1KY0h5VUp3MHduZFRNbHVYenV4VmJ4UWtUUWlzWmVVQ1R3eUFPYytB?=
 =?utf-8?B?bTlRQUJwL2tKa0Jma1lpSThpeTI2bnJSSW8rMmxJaFFnMmhEZ2ZDNk5jWTlP?=
 =?utf-8?B?MGR4ZTBTTGZRVE8zSlBsc2ZLZEpWNlRrVTF1NGcwK1VieTFMaEYydk56cWhT?=
 =?utf-8?B?aUpQWUF3UCtIK2VnL1liM25JKzRaNkNNQkpZN3Q3eXhlcWU5a0o1YllLdzA1?=
 =?utf-8?B?STgxZDdJcmM1c2VLOTFCR1NIQzdPUkVLWFJodTdHSkNKS2ozQnpwbTZMNWJm?=
 =?utf-8?B?MUdsQjRDTHpxZjZqWmY3Q2J2RUlOS0EwTnJybWh5eUc1U3FObDljbHl4cWpl?=
 =?utf-8?B?NDMxQnpWMEkydmhHLzZ0NzFNVWJienAxanFxbzVxTkRQdU41MTFVVm45Yi84?=
 =?utf-8?B?OFJ6TE14NVVpYUtZaUxTdTRKcWpnbytPb1hwMEdQY1BoNGo2SldrRWxqU3RS?=
 =?utf-8?B?UzdWUTUwcmhmYjg3RnptUkEyRzFqQzkvVzJxdkJkNmhIM1Q0VGR1YXF0Q05L?=
 =?utf-8?B?UlJaQWRaN3FScTVPQ1ZTRkc2RXhhblBPVlNsVUhFZVBkbCtYRTNUTVFuM3BT?=
 =?utf-8?B?YnExY2I3cXlrdGptSTNCK0l1R25yT092OHV2UzdTS1U4OHB1THN2SjhCMk1n?=
 =?utf-8?B?UGVHMjBudDF3MGY2YzNpSExKN3puLytWUGJSZzVESGpsbG92dHN1Vyt3cm9S?=
 =?utf-8?B?YWxmbC9kdVdRcFhlb1NtaHo0V0FLZ2VBNk5abmFNMXJsVjl5TndQS2hjYzBr?=
 =?utf-8?B?UDlBcXRkZXY3SUUvWkJDVVJLVWl3dHRuNStGNkJkNGJpMFVSanQ3YWlCeEZ2?=
 =?utf-8?B?dkwzVEY3dFluV0VGMGs1bmhpc1dpQ1JSbWdwN3p6SlR0eW9tUU9zV0dpQlJF?=
 =?utf-8?B?TjFFaGhNNGduMERCdjZ6dE9GMUpGUnhKdzRIVnVTWVNkN2pvekdvSUl6ZzB1?=
 =?utf-8?B?eVp5VzgvSFhnNlJvUGZBOHJDUzl0QWZybkxXUDVvd0hsUTdEeGJoOXJORkFi?=
 =?utf-8?B?b3UwWCt0eWpBTjVZa1pOeklWb0NHYjhkNjVYSmpUY0l3SnU0cVhiYXlnR0Rr?=
 =?utf-8?B?YXhVL2tyWksxalNqUGpXN1Q1VGwvWHJxZ3NLdTlIS0xTaGw2L2Zpd1RoYXBK?=
 =?utf-8?B?TXpGTnJ1NXlWT1FrbEZiR3BUUGJ5M082aDR1dVRGaEgvYTBmUVpOOHdNSjd4?=
 =?utf-8?B?WkdrWVBwRFJWU29VWDV5NlRybmcvdVJBbERKNzdKbXl5SExnNHBNdjlaRTcz?=
 =?utf-8?B?WDFmTDdyZkZ3Uk5zZ3ZKTDNhMzV5clg0VVVtTW1iKy9jWkxXTmJjYjd0NUNr?=
 =?utf-8?B?ZE52WEx2Rmw3ZEcrNncwVzE2Y0IrenF3c1JpNzZJa09CeHRrNk1mbXhxdjlD?=
 =?utf-8?B?YjV6Y1JNUDE3K21mUHdod2RKcUkwazBBUHZuOXluRnVTQ0szcEUwRkN5ZTgv?=
 =?utf-8?B?dW5HZ0J2bmNxc0s4ZVB4Vi9ZMzZTWXBRQXA5SXZlNnp1MHNqRlJTb3lCNkhm?=
 =?utf-8?B?Z3RRNmVTU2krbU9LRE5HSEpLQkdVYWFMSmNYTTZUWkU1cDdTM2pVa081Q0J1?=
 =?utf-8?B?SXFSUUhXSXh2U1l6SEY3RTRSemVEemNqQmtvbmxYSDFxdTJWQ3RrMFVLcmxq?=
 =?utf-8?B?ZmZTTlkxU2VCbXZyOGg3TlErZ2h3PT0=?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <CC7FD0854805CF42ADB55B6D8BFCEA48@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB4920.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4dcec08e-96ce-401a-706c-08d9d520c506
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Jan 2022 16:38:16.9433
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Xb3uQgZqgX9pT3QodBtPMlpPJDHP325B9YmrlX7jfP6uPWQ1F0ave7xCRG2GAkv+q0PiJl8ouHW8VibdfAendCqhVVMZlL5fovpKW+x2LeA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR11MB1485
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gMS8xMS8yMiA1OjUzIFBNLCBIYW5zIFZlcmt1aWwgd3JvdGU6DQo+IE9uIDEzLzEyLzIwMjEg
MTQ6NDksIEV1Z2VuIEhyaXN0ZXYgd3JvdGU6DQo+PiBEdXJpbmcgZXhwZXJpbWVudHMgd2l0aCBs
aWJjYW1lcmEsIGl0IGxvb2tzIGxpa2UgdmIyX2lzX3N0cmVhbWluZyByZXR1cm5zDQo+PiB0cnVl
IGJlZm9yZSBvdXIgc3RhcnQgc3RyZWFtaW5nIGlzIGNhbGxlZC4NCj4+IE9yZGVyIG9mIG9wZXJh
dGlvbnMgaXMgc3RyZWFtb24gLT4gcXVldWUgLT4gc3RhcnRfc3RyZWFtaW5nDQo+PiBJU0Mgd291
bGQgaGF2ZSBzdGFydGVkIHRoZSBETUEgaW1tZWRpYXRlbHkgd2hlbiBhIGJ1ZmZlciBpcyBiZWlu
ZyBhZGRlZA0KPj4gdG8gdGhlIHZicXVldWUgaWYgdGhlIHF1ZXVlIGlzIHN0cmVhbWluZy4NCj4+
IEl0IGlzIG1vcmUgc2FmZSB0byBzdGFydCB0aGUgRE1BIGFmdGVyIHRoZSBzdGFydCBzdHJlYW1p
bmcgb2YgdGhlIGRyaXZlciBpcw0KPj4gY2FsbGVkLg0KPj4gVGh1cywgZXZlbiBpZiB2YjJxdWV1
ZSBpcyBzdHJlYW1pbmcsIGFkZCB0aGUgYnVmZmVyIHRvIHRoZSBkbWEgcXVldWUgb2YgdGhlDQo+
PiBkcml2ZXIgaW5zdGVhZCBvZiBhY3R1YWxseSBzdGFydGluZyB0aGUgRE1BIHByb2Nlc3MsIGlm
IHRoZSBzdGFydCBzdHJlYW1pbmcNCj4+IGhhcyBub3QgYmVlbiBjYWxsZWQgeWV0Lg0KPj4NCj4+
IFNpZ25lZC1vZmYtYnk6IEV1Z2VuIEhyaXN0ZXYgPGV1Z2VuLmhyaXN0ZXZAbWljcm9jaGlwLmNv
bT4NCj4+IC0tLQ0KPj4gICBkcml2ZXJzL21lZGlhL3BsYXRmb3JtL2F0bWVsL2F0bWVsLWlzYy1i
YXNlLmMgfCAxNyArKysrKysrKysrLS0tLS0tLQ0KPj4gICAxIGZpbGUgY2hhbmdlZCwgMTAgaW5z
ZXJ0aW9ucygrKSwgNyBkZWxldGlvbnMoLSkNCj4+DQo+PiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9t
ZWRpYS9wbGF0Zm9ybS9hdG1lbC9hdG1lbC1pc2MtYmFzZS5jIGIvZHJpdmVycy9tZWRpYS9wbGF0
Zm9ybS9hdG1lbC9hdG1lbC1pc2MtYmFzZS5jDQo+PiBpbmRleCAyNmE2MDkwZjA1NmMuLmU2Yzkw
NzFjMDRmMCAxMDA2NDQNCj4+IC0tLSBhL2RyaXZlcnMvbWVkaWEvcGxhdGZvcm0vYXRtZWwvYXRt
ZWwtaXNjLWJhc2UuYw0KPj4gKysrIGIvZHJpdmVycy9tZWRpYS9wbGF0Zm9ybS9hdG1lbC9hdG1l
bC1pc2MtYmFzZS5jDQo+PiBAQCAtNDQxLDEyICs0NDEsMTQgQEAgc3RhdGljIHZvaWQgaXNjX2J1
ZmZlcl9xdWV1ZShzdHJ1Y3QgdmIyX2J1ZmZlciAqdmIpDQo+PiAgICAgICAgdW5zaWduZWQgbG9u
ZyBmbGFnczsNCj4+DQo+PiAgICAgICAgc3Bpbl9sb2NrX2lycXNhdmUoJmlzYy0+ZG1hX3F1ZXVl
X2xvY2ssIGZsYWdzKTsNCj4+IC0gICAgIGlmICghaXNjLT5jdXJfZnJtICYmIGxpc3RfZW1wdHko
JmlzYy0+ZG1hX3F1ZXVlKSAmJg0KPj4gLSAgICAgICAgICAgICB2YjJfaXNfc3RyZWFtaW5nKHZi
LT52YjJfcXVldWUpKSB7DQo+PiArDQo+PiArICAgICBpZiAoIWlzYy0+Y3VyX2ZybSAmJiBsaXN0
X2VtcHR5KCZpc2MtPmRtYV9xdWV1ZSkgJiYgIWlzYy0+c3RvcCkgew0KPj4gICAgICAgICAgICAg
ICAgaXNjLT5jdXJfZnJtID0gYnVmOw0KPj4gICAgICAgICAgICAgICAgaXNjX3N0YXJ0X2RtYShp
c2MpOw0KPj4gLSAgICAgfSBlbHNlDQo+PiArICAgICB9IGVsc2Ugew0KPj4gICAgICAgICAgICAg
ICAgbGlzdF9hZGRfdGFpbCgmYnVmLT5saXN0LCAmaXNjLT5kbWFfcXVldWUpOw0KPj4gKyAgICAg
fQ0KPj4gKw0KPj4gICAgICAgIHNwaW5fdW5sb2NrX2lycXJlc3RvcmUoJmlzYy0+ZG1hX3F1ZXVl
X2xvY2ssIGZsYWdzKTsNCj4+ICAgfQ0KPiANCj4gQm90aCB0aGUgb2xkIGFuZCBuZXcgY29kZSBk
b2Vzbid0IG1ha2UgYSBsb3Qgb2Ygc2Vuc2UuDQoNCkhlbGxvIEhhbnMsDQoNCkkgZGViYXRlZCB0
aGlzIGEgYml0IHdpdGggTGF1cmVudCB3aGVuIEkgaW5pdGlhbGx5IHdyb3RlIHRoZSBwYXRjaC4N
Cg0KVGhlIHByb2JsZW0gd2l0aCB0aGUgY3VycmVudCBjb2RlLCBvciB0aGUgY3VycmVudCB3YXkg
dGhpbmdzIGFyZSANCndvcmtpbmcsIGlzIHRoZSBmYWN0IHRoYXQgdmIyX2lzX3N0cmVhbWluZyBy
ZXR1cm5zIHRydWUgZnJvbSB0aGUgbW9tZW50IA0Kb2Ygc3RyZWFtb24uDQpUaGUgRE1BIGVuZ2lu
ZSBvZiB0aGUgSVNDIGlzIGJlaW5nIHN0YXJ0ZWQgYXQgdGhlIG1vbWVudCBvZiANCnN0YXJ0X3N0
cmVhbWluZywgYW5kIGlmIGJ1ZmZlcnMgYXJlIGJlaW5nIHNlbnQgZWFybGllci9sYXRlciwgdGhl
eSBhcmUgDQpqdXN0IGFkZGVkIHRvIHRoZSBxdWV1ZSBhbmQgRE1BIGVuZ2luZSBpcyByZXN0YXJ0
ZWQgaWYgaXQgZmluaXNoZWQgDQpwcmV2aW91c2x5Lg0KSG93ZXZlciBpZiBmcmFtZXMgYXJlIGFk
ZGVkIGJlZm9yZWhhbmQsIGxpa2UsIGZpcnN0IHN0cmVhbW9uLCB0aGVuIGFkZCANCnNvbWUgZnJh
bWVzLCBhbmQgdGhlbiBsYXRlciBjYWxsIHRoZSBzdGFydF9zdHJlYW1pbmcsIElTQyB3aWxsIGNy
YXNoLiANCihhcyBJIHNhaWQsIERNQSBlbmdpbmUgaXMgcHJlcGFyZWQgYXQgc3RhcnRfc3RyZWFt
aW5nKS4NClRvIGF2b2lkIHRoaXMsIEkgY2hhbmdlZCB0aGUgdmIyX2lzX3N0cmVhbWluZyBjYWxs
cyB0byBrZWVwaW5nIGFuIA0KaW50ZXJuYWwgc3RhdGUgb2YgdGhlIHN0cmVhbWluZy4NCkRvIHlv
dSB0aGluayBJIHNob3VsZCB0cnkgYW5vdGhlciBkaWZmZXJlbnQgYXBwcm9hY2ggdG8gc29sdmUg
dGhpcyA/DQpQZXJoYXBzIGRvIG5vdCBwcmVwYXJlIHRoZSBJU0MgZG1hIGVuZ2luZSBhdCBzdGFy
dF9zdHJlYW1pbmcsIGJ1dCBhdCANCmFub3RoZXIgcGxhY2UgPw0KDQpMYXVyZW50IGRvIHlvdSBy
ZW1lbWJlciB0aGUgdGFsayB3ZSBoYWQgYWJvdXQgdGhpcyBwcm9ibGVtIGEgd2hpbGUgYmFjayA/
DQoNCj4gDQo+IGJ1Zl9xdWV1ZSBpcyBvbmx5IGNhbGxlZCBieSB2YjIgaWYgc3RhcnRfc3RyZWFt
aW5nIGhhcyBhbHJlYWR5IGJlZW4gY2FsbGVkIG9yIGlzDQo+IGFib3V0IHRvIGJlIGNhbGxlZC4N
Cg0KVGhhdCdzIGEgaHVnZSBkaWZmZXJlbmNlIGZvciBJU0MgZHJpdmVyIGFzIGl0IGlzIHRvZGF5
LiBzdGFydF9zdHJlYW1pbmcgDQpiZWluZyBjYWxsZWQgYWZ0ZXJ3YXJkcywgbWVhbnMgdGhlIElT
QyBETUEgZW5naW5lIGlzIG5vdCBzdGFydGVkIChub3QgDQpzdGFydGVkIHN0cmVhbWluZyksIGhl
bmNlIGEgY3Jhc2guDQoNCj4gDQo+IFR5cGljYWxseSBhbGwgdGhhdCB0aGUgYnVmX3F1ZXVlIG9w
IGRvZXMgaXMgdG8gY2FsbCBsaXN0X2FkZF90YWlsKCZidWYtPmxpc3QsICZpc2MtPmRtYV9xdWV1
ZSk7DQo+IGluc2lkZSB0aGUgc3BpbmxvY2suDQo+IA0KPj4NCj4+IEBAIC0xMDE0LDcgKzEwMTYs
NyBAQCBzdGF0aWMgaW50IGlzY19zX2ZtdF92aWRfY2FwKHN0cnVjdCBmaWxlICpmaWxlLCB2b2lk
ICpwcml2LA0KPj4gICB7DQo+PiAgICAgICAgc3RydWN0IGlzY19kZXZpY2UgKmlzYyA9IHZpZGVv
X2RydmRhdGEoZmlsZSk7DQo+Pg0KPj4gLSAgICAgaWYgKHZiMl9pc19zdHJlYW1pbmcoJmlzYy0+
dmIyX3ZpZHEpKQ0KPj4gKyAgICAgaWYgKCFpc2MtPnN0b3ApDQo+IA0KPiBUaGlzIGlzIHdlaXJk
IGFzIHdlbGwuIE5vcm1hbGx5IHRoaXMgY2FsbHMgdmIyX2lzX2J1c3kgdG8gY2hlY2sgaWYgdGhl
DQo+IHF1ZXVlIGlzIGJ1c3kgKHRoYXQgcmVhbGx5IG1lYW5zIHRoYXQgYnVmZmVycyBhcmUgYWxy
ZWFkeSBhbGxvY2F0ZWQsIHNvDQo+IGNoYW5naW5nIHRoZSBmb3JtYXQgaXNuJ3QgYWxsb3dlZCBh
bnltb3JlKS4NCg0KWW91IHRoaW5rIHRoZSBxdWVyeSB0byB0aGUgc3RyZWFtaW5nIHN0YXR1cyBt
YWtlcyBubyBzZW5zZSBoZXJlIGhlbmNlIGl0IA0Kc2hvdWxkIGJlIHJlbW92ZWQgY29tcGxldGVs
eSA/DQpJIGNhbiBkbyB0aGF0IHdpdGggYSBwcmVxdWVsIHBhdGNoIGlmIGl0J3MgdGhlIGNhc2Uu
DQoNClRoYW5rcyBmb3IgcmV2aWV3aW5nLA0KDQpFdWdlbg0KDQo+IA0KPj4gICAgICAgICAgICAg
ICAgcmV0dXJuIC1FQlVTWTsNCj4+DQo+PiAgICAgICAgcmV0dXJuIGlzY19zZXRfZm10KGlzYywg
Zik7DQo+PiBAQCAtMTUzNiw3ICsxNTM4LDcgQEAgc3RhdGljIGludCBpc2Nfc19hd2JfY3RybChz
dHJ1Y3QgdjRsMl9jdHJsICpjdHJsKQ0KPj4NCj4+ICAgICAgICAgICAgICAgIGlzY191cGRhdGVf
YXdiX2N0cmxzKGlzYyk7DQo+Pg0KPj4gLSAgICAgICAgICAgICBpZiAodmIyX2lzX3N0cmVhbWlu
ZygmaXNjLT52YjJfdmlkcSkpIHsNCj4+ICsgICAgICAgICAgICAgaWYgKCFpc2MtPnN0b3ApIHsN
Cj4gDQo+IERpdHRvLg0KPiANCj4+ICAgICAgICAgICAgICAgICAgICAgICAgLyoNCj4+ICAgICAg
ICAgICAgICAgICAgICAgICAgICogSWYgd2UgYXJlIHN0cmVhbWluZywgd2UgY2FuIHVwZGF0ZSBw
cm9maWxlIHRvDQo+PiAgICAgICAgICAgICAgICAgICAgICAgICAqIGhhdmUgdGhlIG5ldyBzZXR0
aW5ncyBpbiBwbGFjZS4NCj4+IEBAIC0xNTUyLDggKzE1NTQsNyBAQCBzdGF0aWMgaW50IGlzY19z
X2F3Yl9jdHJsKHN0cnVjdCB2NGwyX2N0cmwgKmN0cmwpDQo+PiAgICAgICAgICAgICAgICB9DQo+
Pg0KPj4gICAgICAgICAgICAgICAgLyogaWYgd2UgaGF2ZSBhdXRvd2hpdGViYWxhbmNlIG9uLCBz
dGFydCBoaXN0b2dyYW0gcHJvY2VkdXJlICovDQo+PiAtICAgICAgICAgICAgIGlmIChjdHJscy0+
YXdiID09IElTQ19XQl9BVVRPICYmDQo+PiAtICAgICAgICAgICAgICAgICB2YjJfaXNfc3RyZWFt
aW5nKCZpc2MtPnZiMl92aWRxKSAmJg0KPj4gKyAgICAgICAgICAgICBpZiAoY3RybHMtPmF3YiA9
PSBJU0NfV0JfQVVUTyAmJiAhaXNjLT5zdG9wICYmDQo+PiAgICAgICAgICAgICAgICAgICAgSVND
X0lTX0ZPUk1BVF9SQVcoaXNjLT5jb25maWcuc2RfZm9ybWF0LT5tYnVzX2NvZGUpKQ0KPj4gICAg
ICAgICAgICAgICAgICAgICAgICBpc2Nfc2V0X2hpc3RvZ3JhbShpc2MsIHRydWUpOw0KPj4NCj4+
IEBAIC0xODI5LDYgKzE4MzAsOCBAQCBzdGF0aWMgaW50IGlzY19hc3luY19jb21wbGV0ZShzdHJ1
Y3QgdjRsMl9hc3luY19ub3RpZmllciAqbm90aWZpZXIpDQo+PiAgICAgICAgc3RydWN0IHZiMl9x
dWV1ZSAqcSA9ICZpc2MtPnZiMl92aWRxOw0KPj4gICAgICAgIGludCByZXQgPSAwOw0KPj4NCj4+
ICsgICAgIGlzYy0+c3RvcCA9IHRydWU7DQo+PiArDQo+IA0KPiBJJ20gcmVhbGx5IG5vdCBzdXJl
IHRoYXQgeW91IG5lZWQgdGhlIHN0b3AgYm9vbCBhdCBhbGwuDQo+IA0KPj4gICAgICAgIElOSVRf
V09SSygmaXNjLT5hd2Jfd29yaywgaXNjX2F3Yl93b3JrKTsNCj4+DQo+PiAgICAgICAgcmV0ID0g
djRsMl9kZXZpY2VfcmVnaXN0ZXJfc3ViZGV2X25vZGVzKCZpc2MtPnY0bDJfZGV2KTsNCj4gDQo+
IFJlZ2FyZHMsDQo+IA0KPiAgICAgICAgICBIYW5zDQo+IA0KDQo=
