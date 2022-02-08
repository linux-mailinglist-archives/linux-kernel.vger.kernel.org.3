Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7853C4ADC9F
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Feb 2022 16:28:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1380354AbiBHP2B (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Feb 2022 10:28:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1380317AbiBHP2A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Feb 2022 10:28:00 -0500
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34A00C061578;
        Tue,  8 Feb 2022 07:27:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1644334079; x=1675870079;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=8IVDJKt7buS0qbojbGI30U389EPhzSkQAwkSnNqfgCA=;
  b=xIaAtGKNZWHiQqE4aAZwC3XDOul3AVZW7U33Rh+1flOPR8tkem3b/4ww
   ysjTcPWTMzzE262e3kZYR1li7zTRZYnVWH6TYOL+ey+x+Rc9xDrVDZ9iT
   iqsynmKrnu3titknH02NKCtyLofCtnUR5+IhPB/tn4T5gxP/2C0TqO4WT
   uUTz+B14GOH//HiMGFRE5DuzIkPJq131LsaadcQOfo1ATOZwSUd5MCZoB
   Gv2VAE6dN8ZRgFWJbWjs8GuAA1b5uvrlPIGhehj2VC1vxXo89BJs2iPxv
   fFPNRbqQmzgSFqkmYiTXTwmYtKdIqKLoU5i4xox+ClTm01az+11efOmN0
   A==;
IronPort-SDR: b/eu7wtO8lZxL1EbD8cq/sGn/BMIAsTzW1OQBM4v+xrd/no1jk9C0J504lkQoBMel05uKPthgR
 QnTAKPytke+jBZAP23xlEtowTfJUWMHfdLNq3dgvNjf/aUMKatNGb3H3Ml4vMsI4SPjqMpQnc1
 TgTxSOS9IR23eQfIt9CYIV/i19/ggioql48v6U3pCOO4eL43TyYSc7+HjK9VcYQPPcXwS9Ln7+
 Efbii6KFr4yktoUtSG7SWCIoLBdb1ImK26Pknlxd1YVAyJcKoUgd4y/3SsiD5bA0BWxc5FKruG
 XOXtKwy57szhn1zEQoCjiz9Z
X-IronPort-AV: E=Sophos;i="5.88,353,1635231600"; 
   d="scan'208";a="148002490"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa2.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 08 Feb 2022 08:27:58 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Tue, 8 Feb 2022 08:27:57 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17 via Frontend Transport; Tue, 8 Feb 2022 08:27:57 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FvpzPBpAOzdOwnWJmCz1lgwQA56b4YUVEkT8q9NYCjZViklMPxw3a835PiaF7hDvKH4QC6gZSOpVYdCPR594WgNHYhsD8MEo+aOlfNiytudtlm5p9CaIIF29eZ3x/JVl0zgXTSYdVi7Pkd5u7CPyGQZFskIQfmKdIsGf9uIash0ryUjhPZ1i3sUjbwXuY+iFn0oNjMTgkfkUmAs3mcw8ngrySFt53jVJXW4nA/nLVV9/kqrGAibYmenS53B++YNsVqTs2MlEHramI2wvd4XyoxFvS4lUgtRU2KfoOPL3VCOVs2Ao8e8Poesn6SIvnBDmY0hG+usT5VOv7Y5o5CVq0Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8IVDJKt7buS0qbojbGI30U389EPhzSkQAwkSnNqfgCA=;
 b=hLqYKpDiW4x7keUwoYG7H8gg+UYx0g6H08Bhmw4HAccPDdWU2LYW23ow6BR4woAkBS9UTFk7pnueBZp4sbrZ4EdKT6MIAC0TpIZo7IhZXH0LKMZ/+3KRviV0+EOiATUJFwCnm9lJ6bh1dU+fG6npYwUzwzgZe0FOlnWceTcezoCYRPhgpc5r279ONMiRkqn5GltNSN8rWa5bxlYAbRLLzJp9X0EaeZgB5HC8anxWHlwSmYrpkKs2CkVHWncxk7eBLS7PvKGGeQXTipytKdq76vPfCETwOKNq3KBJ/Ab/00nH6xQD1eiU8YZp5CVy5oJNRhbtYQ9/FtBR9p0Wzulscg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8IVDJKt7buS0qbojbGI30U389EPhzSkQAwkSnNqfgCA=;
 b=VpBNHVP/Gs8yLgHlmh4hz2AQgTCZpV7CPTucT5xO4TDGMpvdN+TStTe9Xv/e0FlnuR9FjoR0c1V6toF/ikG64La1BN7/xnwL+Z0/5PP8TBSDSoR4YfI8SJwj/4HD40w7q9t9iaRAoIWOWKAZKAB6jG6YrTmDVEFNzRpkXF+54I0=
Received: from SA2PR11MB4874.namprd11.prod.outlook.com (2603:10b6:806:f9::23)
 by SA2PR11MB5097.namprd11.prod.outlook.com (2603:10b6:806:11a::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4975.11; Tue, 8 Feb
 2022 15:27:47 +0000
Received: from SA2PR11MB4874.namprd11.prod.outlook.com
 ([fe80::49cd:dd25:384:e918]) by SA2PR11MB4874.namprd11.prod.outlook.com
 ([fe80::49cd:dd25:384:e918%5]) with mapi id 15.20.4975.011; Tue, 8 Feb 2022
 15:27:46 +0000
From:   <Tudor.Ambarus@microchip.com>
To:     <krzysztof.kozlowski@canonical.com>, <herbert@gondor.apana.org.au>
CC:     <Nicolas.Ferre@microchip.com>, <Claudiu.Beznea@microchip.com>,
        <alexandre.belloni@bootlin.com>, <linux-crypto@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <Kavyasree.Kotagiri@microchip.com>,
        <devicetree@vger.kernel.org>
Subject: Re: [PATCH v2 1/3] dt-bindings: crypto: Convert Atmel AES to yaml
Thread-Topic: [PATCH v2 1/3] dt-bindings: crypto: Convert Atmel AES to yaml
Thread-Index: AQHYHPnDVT4dxUSni0qjnycASWeRyw==
Date:   Tue, 8 Feb 2022 15:27:46 +0000
Message-ID: <2703df0f-a47c-f7cd-4d79-954b797cb57a@microchip.com>
References: <20220208104918.226156-1-tudor.ambarus@microchip.com>
 <20220208104918.226156-2-tudor.ambarus@microchip.com>
 <f5563605-7b61-c23e-68ec-6e315efb268d@canonical.com>
 <d72a96a9-f99c-5204-00d0-00f78ea96772@microchip.com>
 <bca78043-d552-a7e4-149b-087c6226d8bf@canonical.com>
In-Reply-To: <bca78043-d552-a7e4-149b-087c6226d8bf@canonical.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: d660fb86-b242-4cd9-0e25-08d9eb178f40
x-ms-traffictypediagnostic: SA2PR11MB5097:EE_
x-microsoft-antispam-prvs: <SA2PR11MB5097275ED55D4BF0FCF54EDFF02D9@SA2PR11MB5097.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 5TV477xmtJ0t96FXjXelRtoQhYSmGdNDZyn9P09RjjHFnYpzb3sKyy/d1susbT28GgE+zjKSH68CYHJ3e+4uA773LZCsSgtO/L3uMLbrylTezSwKWwTo7p83hjWLtv9P79ug2yVPYCOMTGLyyk2uJfT1QZRXDqRYuGbawtYNByqLA+JTD0dx8NoHvv8cFBBnDQOgnAh4ocEc/e/nc2peYytLLlIjUTsH8ZXfYNvVx1M3B98JTWqbT/Zma9cgwPy6Vg1RnHfBZqnyFc1yOvEmJAwniV/sdCvAQzkqndVevNM4TjkLSmAwmgBIWVsj9u5LcVeHwDgB3NzJ5Yt1OuDJHSTuY4GNC+6clknIQsD64BoXobTxhG9P4TOLEKqxIna/WB1J8MpVSglS/g0Ar6Y4R513aDxkGk/6axqfh75CJUDK9XPw6s7PiD3Rsld9RskW4hvwV9uPaC3uRjNDos5SxXO2B3AHeq8BgJidQ4JlN6p61LUMYKxT4NeUhnrEBJLyQETxoHidTvDIzPwwmCNDrWFveCnmuYu+aDZod4Zx9jsZ7Xdl+iqCA9Mm0LgEh8J5spAiLQTKUZkTt8DNxOID9Xe9QMTFZq+7qnK1Xa40upl0PI1BBfFOxB658Z8dUUyXHqLW+Kl6CfGGPfhhqvTmJtk3jDCMPEiidA+JhbmcxP9odZnwKx5M05B+tiWtPjN/YjIGFAoT06AuPrhk/zK6YrP4Y3I3KFQFVfKER5Lae+nhHaC/XDsmiZN7+2gsuDK+u9fkIoUHMwOjMLIvY5uPZQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA2PR11MB4874.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(54906003)(6486002)(86362001)(8936002)(8676002)(122000001)(64756008)(66446008)(76116006)(66946007)(66556008)(38100700002)(66476007)(91956017)(316002)(4326008)(186003)(26005)(2616005)(71200400001)(36756003)(83380400001)(31696002)(508600001)(6512007)(6506007)(53546011)(38070700005)(110136005)(31686004)(5660300002)(2906002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?N05XcllUc3JsckxkZHRZbHUzWnVJR3kwTUdHNm9IOWVESlVkREtlVDc2VC8x?=
 =?utf-8?B?UnArb3dwNk5pWTJjL3hsZUpQVmRCTlZrc1lhamdSMi9UL3JWZXYxSUYvQWRE?=
 =?utf-8?B?ODJnUGw5cVliNVpxN3J2REcwV0hkNjJILzVDeGFDRmRIa1VxZHdaU0VQbEpV?=
 =?utf-8?B?WlAwakRXQ0ROUGkxVFA0TnBYVFAwT1ZjSEliWXZnUDZnay8rcjMrM3NEU3Y4?=
 =?utf-8?B?NjV2V3VFK3o3NzRDL3hXbktVYzVaZlIzVEc3VGtwT1RpV3pGOStCVk90YlhG?=
 =?utf-8?B?bFhHY1dRV1YrQUMzNkFKc0NlZE15WDljTVgxNGtta1h5T2xzWGJsSGxLekw3?=
 =?utf-8?B?b0xqNlBmUzRiUjEzTE5NRCs1QWZnOGVGY2JjQmhCVjIxY3oxNlM5ek56VGtD?=
 =?utf-8?B?Uk1zaVZMZHR5S0ZLSndrNGozUFhDWkd1NkpOZEYwdzRYRzIwNWNqUmcvSU9z?=
 =?utf-8?B?V1htZWIrTDd5MS9zQi9ia1hXT3owaFlyMFJNUktOQ01sUGdGUVBUcFA0Y0FW?=
 =?utf-8?B?cjZ4bzN1ckFaZTJ0TW14dW9GdENDN2t6Wnlxa2lwK1ZjaGFXMW1OZGdiYm4r?=
 =?utf-8?B?N1pXUnkrOFdHU2JuZ2xmTjVhTUZxUHZFKzQ3SWUrTEc1YUNXcm5PQ1hhS05v?=
 =?utf-8?B?bHRqSXFJMkEwd0JzZXB6VmdtbWlucllDZTVxeTZkWnZ4aDhsOGsvUjVsL1Yw?=
 =?utf-8?B?NVJEcStZTkhBYkx2OTYyMlZEeGQyeDZUSFZSTkg3Y0l2L213Z3YyeENQUkNG?=
 =?utf-8?B?d1hpaktRUTlvQUdpTk9QVXE0L1pPZG1EWUJmL0x0NnM4SENjZ2oycmp3ZDZM?=
 =?utf-8?B?T2pOWnN3YWx1MkNSRjM4azNEU24rT2wwVzdvM3NFVzJpZGJWeHRhR1VNK3Rm?=
 =?utf-8?B?dG9jaGxOSUNFWEV0UmQrL3JRbVZSVUtxREd1eXJPeERZKzNsQ1E0OFZQVlFy?=
 =?utf-8?B?a0tFcENMa3ovYWFUNXB0Nmg2Nko5dmNNdjFGYUtoeVpFcWY3V01tclNLVGNI?=
 =?utf-8?B?NXUzdXVKYXNPb2U1OWYzQUNpOE9Qa3NTY21ZUDZzcExLbk04REVBaDE1aDZU?=
 =?utf-8?B?dVdWMTFmVW1uMld3NC8xZ25FNzdzUUJRYXozQnRlWld1U1R2cFNDemE3WnFZ?=
 =?utf-8?B?MzZwb1g0ZC9KcTlrSXpIU2RVZENwQk5SbjhlcC82QzFxaEdmakdSWk8xUW9Z?=
 =?utf-8?B?emhPYm5sdnUrTDBncTJGOFhEbkxSN1JFZzEyYU1FS2FqcktaeVBWSEdRSnNF?=
 =?utf-8?B?azcyTDYvVUk4djRjYjdya2Y4ZzMxYURnc1hEMTh1Z0k2U3lDSVp3eTUyKysv?=
 =?utf-8?B?ZlNqNnlnZlZDWVg3akFWbHZQaFI3T2dpWk02MERBaEc2VUZySkdCaGxkZE1a?=
 =?utf-8?B?MDd4aEdUQW5lM3dzd3BmclZwL1Z4dnRkY2puZGdNKyt6anRwOE5ZM1ZkZ3Jx?=
 =?utf-8?B?dS9tVjAyb1dPZ1hZcWkvcnRTUFZzbXlmNkJYYUF0aTdPWEVla2tMcUhDR2x4?=
 =?utf-8?B?Y3VVUHBLSnRORSt1cHNvc25Vd2ZjUTBFdGZDTzVYcERVd3lpZkZWRVhvSXI4?=
 =?utf-8?B?clhMczByL3JDSTZlY2NlMTBTTG5VTXBuNzFnT1o5U0txdEpxbHRweEJaeDdB?=
 =?utf-8?B?Wk1UeFhkSTBsZXZleEdSVUpWZ2ZLTEVBeFQ3Z2FWY05tR1U4YlM2YVdrdVFG?=
 =?utf-8?B?WmNxaWcwZjAyVFlEYUZweTcxd1JnMWRqQ1dUQzhxSTI5cTE5d1h6QzJNdmJI?=
 =?utf-8?B?Wm5DbFo3U2JTdEovYXdNN0c4TWFlSDlPeGE2dUdMcnFOZVV3Q2tyVVBxYmp4?=
 =?utf-8?B?dnlTc0xDVlM3My82NnhGd3FaZHRBeXJRRVl0TWtRZ2tTWkJrOHdwNWdpUzBU?=
 =?utf-8?B?UmpDZDZZQTd6UytQWHBPY3hBc09lZGd2NklydU1CZFNCa1NCdTEvZklkK0lz?=
 =?utf-8?B?SGRQVkNQNW5iUm1veXkySGQ0aGpXT3ZTSFljcVN1YlVxNjU3WXMyOFFuaDZ6?=
 =?utf-8?B?RGhMeGE4SER5MXdMQk1US05oRUZwb0ZsREo3K3RwdlN6LzFzQ1pwbmpwWWQ1?=
 =?utf-8?B?QkQ1VXpVbk40VzM4N3VrTG8rY2JIRU03R1FoRFBnTWk3ZmQydmVxSlZaOWZ2?=
 =?utf-8?B?ZTcyeVI2K05tMzBPWmkwc3BMMlZiU0V0MkNHdzYzU09XckpBaUx4Sm16NG1t?=
 =?utf-8?B?cysxSDhaNWpsUVFmbmFPTWlwSUhXbFVBSVlFbk15V1k3RVZ0RnNhd2hUeW8r?=
 =?utf-8?B?bmNaWCtrQVZsb24wRzZTdDFtRzlnPT0=?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <7CA652B2E3B278479C9E6BCE570DB478@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA2PR11MB4874.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d660fb86-b242-4cd9-0e25-08d9eb178f40
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Feb 2022 15:27:46.9282
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: QGXc9di1HWjp+u2x/wvPK+HZvLGghwMvNyO6ZpRNBlydWCyu/3WJw5TNrl5CIiUMwL5MBFm9Q81LHdvWNcn6U8gomD1Q8pmQA86gLBtEZjo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR11MB5097
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gMi84LzIyIDE2OjU1LCBLcnp5c3p0b2YgS296bG93c2tpIHdyb3RlOg0KPiBFWFRFUk5BTCBF
TUFJTDogRG8gbm90IGNsaWNrIGxpbmtzIG9yIG9wZW4gYXR0YWNobWVudHMgdW5sZXNzIHlvdSBr
bm93IHRoZSBjb250ZW50IGlzIHNhZmUNCj4gDQo+IE9uIDA4LzAyLzIwMjIgMTU6NDAsIFR1ZG9y
LkFtYmFydXNAbWljcm9jaGlwLmNvbSB3cm90ZToNCj4+IE9uIDIvOC8yMiAxMzo1OCwgS3J6eXN6
dG9mIEtvemxvd3NraSB3cm90ZToNCj4+PiBFWFRFUk5BTCBFTUFJTDogRG8gbm90IGNsaWNrIGxp
bmtzIG9yIG9wZW4gYXR0YWNobWVudHMgdW5sZXNzIHlvdSBrbm93IHRoZSBjb250ZW50IGlzIHNh
ZmUNCj4+Pg0KPj4+IE9uIDA4LzAyLzIwMjIgMTE6NDksIFR1ZG9yIEFtYmFydXMgd3JvdGU6DQo+
Pj4+IENvbnZlcnQgQXRtZWwgQUVTIGRvY3VtZW50YXRpb24gdG8geWFtbCBmb3JtYXQuIFdpdGgg
dGhlIGNvbnZlcnNpb24gdGhlDQo+Pj4+IGNsb2NrIGFuZCBjbG9jay1uYW1lcyBwcm9wZXJ0aWVz
IGFyZSBtYWRlIG1hbmRhdG9yeS4gVGhlIGRyaXZlciByZXR1cm5zDQo+Pj4+IC1FSU5WQUwgaWYg
ImFlc19jbGsiIGlzIG5vdCBmb3VuZCwgcmVmbGVjdCB0aGF0IGluIHRoZSBiaW5kaW5ncyBhbmQg
bWFrZQ0KPj4+PiB0aGUgY2xvY2sgYW5kIGNsb2NrLW5hbWVzIHByb3BlcnRpZXMgbWFuZGF0b3J5
LiBVcGRhdGUgdGhlIGV4YW1wbGUgdG8NCj4+Pj4gYmV0dGVyIGRlc2NyaWJlIGhvdyBvbmUgc2hv
dWxkIGRlZmluZSB0aGUgZHQgbm9kZS4NCj4+Pj4NCj4+Pj4gU2lnbmVkLW9mZi1ieTogVHVkb3Ig
QW1iYXJ1cyA8dHVkb3IuYW1iYXJ1c0BtaWNyb2NoaXAuY29tPg0KPj4+PiAtLS0NCj4+Pj4gIC4u
Li9jcnlwdG8vYXRtZWwsYXQ5MXNhbTlnNDYtYWVzLnlhbWwgICAgICAgICB8IDY1ICsrKysrKysr
KysrKysrKysrKysNCj4+Pj4gIC4uLi9iaW5kaW5ncy9jcnlwdG8vYXRtZWwtY3J5cHRvLnR4dCAg
ICAgICAgICB8IDIwIC0tLS0tLQ0KPj4+PiAgMiBmaWxlcyBjaGFuZ2VkLCA2NSBpbnNlcnRpb25z
KCspLCAyMCBkZWxldGlvbnMoLSkNCj4+Pj4gIGNyZWF0ZSBtb2RlIDEwMDY0NCBEb2N1bWVudGF0
aW9uL2RldmljZXRyZWUvYmluZGluZ3MvY3J5cHRvL2F0bWVsLGF0OTFzYW05ZzQ2LWFlcy55YW1s
DQo+Pj4+DQo+Pj4NCj4+PiBJIHVuZGVyc3RhbmQgdGhhdCB5b3Uga2VlcCB0aGUgbGljZW5zZSBH
UEwtMi4wIChub3QgcmVjb21tZW5kZWQgbWl4KQ0KPj4+IGJlY2F1c2Ugb2YgZXhhbXBsZSBjb21p
bmcgZnJvbSBwcmV2aW91cyBiaW5kaW5ncyBvciBmcm9tIERUUyAoYm90aCBHUEwtMi4wKT8NCj4+
Pg0KPj4NCj4+IFRoZSBwcmV2aW91cyBiaW5kaW5ncyBkaWQgbm90IGhhdmUgYSBsaWNlbnNlIHNw
ZWNpZmllZC4gV2UgaGF2ZSBEVFMgZmlsZXMgd2l0aA0KPj4gdGhlc2Ugbm9kZXMgdGhhdCBhcmUg
ZWl0aGVyIChHUEwtMi4wKyBPUiBNSVQpIG9yIEdQTC0yLjAtb3ItbGF0ZXIuIFRoZSBkcml2ZXJz
DQo+PiBhcmUgR1BMLTIuMC4gSSB0aG91Z2h0IHRvIGZvbGxvdyB0aGUgZHJpdmVycy4gSSBzZWUg
dGhlIGV4YW1wbGUgaW4gWzFdIHVzZXMNCj4+IChHUEwtMi4wLW9ubHkgT1IgQlNELTItQ2xhdXNl
KS4gSSBzZWUgdGhlIGNyeXB0byBiaW5kaW5ncyB0aGF0IGFyZSBjb252ZXJ0ZWQNCj4+IHRvIHlh
bWwgYXJlIGVpdGhlciAoR1BMLTIuMC1vbmx5IE9SIEJTRC0yLUNsYXVzZSkgb3IgR1BMLTIuMC1v
bmx5LiBJcyB0aGVyZQ0KPj4gYW5vdGhlciBndWlkZWxpbmUgdGhhdCBJIG1pc3M/DQo+Pg0KPiAN
Cj4gWWVzLCB0aGVyZSBpcy4gUnVuIGNoZWNrcGF0Y2ggKHlvdXIgcXVlc3Rpb24ga2luZHMgb2Yg
cG9pbnQgdG8gdGhlIGZhY3QNCj4gdGhhdCB5b3UgZGlkIG5vdCBydW4gaXQuLi4pOg0KPiBXQVJO
SU5HOiBEVCBiaW5kaW5nIGRvY3VtZW50cyBzaG91bGQgYmUgbGljZW5zZWQgKEdQTC0yLjAtb25s
eSBPUg0KPiBCU0QtMi1DbGF1c2UpDQoNClJpZ2h0LiBJIHVzdWFsbHkgcnVuIGNoZWNrcGF0Y2gg
LS1zdHJpY3QsIGJ1dCB0aGlzIHdhcm5pbmcgc2xpcHBlZCBzb21laG93Lg0KTWF5YmUgYmVjYXVz
ZSBvZiB0aGUgdHdvIG90aGVyIGZhbHNlIHBvc2l0aXZlcywgdG9vIG11Y2ggbm9pc2UuDQo+IA0K
PiANCj4gSWYgeW91ciBuZXcgYmluZGluZ3MgdXNlIGNvcGllZC9kZXJpdmF0aXZlIGRlc2NyaXB0
aW9uIG9yIERUUyBjb2RlIHdoaWNoDQo+IGlzIGxpY2Vuc2VkIGFzIG9ubHkgR1BMLTIuMCwgdGhl
IGJpbmRpbmdzIGl0c2VsZiBhcyBkZXJpdmF0aXZlIHdvcmsNCj4gbWlnaHQgbmVlZCB0byBzdGF5
IGFzIEdQTC0yLjAgYXMgd2VsbC4gVW5sZXNzIGNvcHlyaWdodCBob2xkZXJzIGFncmVlIHRvDQo+
IHJlLWxpY2Vuc2UgdGhpcyBhcyBHUEwyLU9SLUJTRC4gQXMgcmVwcmVzZW50aW5nIGNvbXBhbnks
IHlvdXIgcGF0Y2gNCj4gbWlnaHQgYmUgZW5vdWdoIHRvIHJlLWxpY2Vuc2UsIGJ1dCBtYXliZSBv
dGhlciBwZW9wbGUgY29udHJpYnV0ZWQuIEkNCj4gZG9uJ3Qga25vdy4NCj4gDQo+IEkganVzdCB3
YW50ZWQgdG8gYmUgc3VyZSB0aGF0IHlvdSB1c2UgR1BMLTIuMCBpbiBwdXJwb3NlLCBiZWNhdXNl
DQo+IEdQTDItT1ItQlNEIGNhbm5vdCBiZSB1c2VkLg0KDQpPaywgdGhhbmtzIGZvciB0aGUgZXhw
bGFuYXRpb24uIEkgaGF2ZSB0byBhZG1pdCBJJ20gbm90IHRvbyBmYW1pbGlhciB3aXRoDQp0aGUg
Y29udGVudHMgb2YgZWFjaCBsaWNlbnNlLiBXaWxsIHJlYWQgdGhlbSBhbmQgY29tZSBiYWNrIHdp
dGggYSBmb2xsb3cgdXAuDQoNCnRhDQo=
