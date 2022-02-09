Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 109F14AEFF7
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Feb 2022 12:30:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230461AbiBILaE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Feb 2022 06:30:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230389AbiBILaA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Feb 2022 06:30:00 -0500
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D3F6E099878;
        Wed,  9 Feb 2022 02:23:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1644402217; x=1675938217;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=RfOBDj6VN/gWqnocALwN2o7tssKYSO9/FOZF/DPLIM4=;
  b=aChTk+t+PVM592t2Po82CJJUN+zyFxaNTP9gFsYMY0AKSjazDRH+ifal
   TXotzHOPu9stfVj3izKXggUIufzSjaQpSL3ROZckgAk2DUZmS0rnSG0wI
   8fX+YlcJee5wU6hH13f4WaUXHzFOiFRKBDQPWlOExpPVaanS/DKyI8CVT
   ZjjrGGICnsaV+iRrtYNewyT8MSM1iHwlvruyA8F6Brl9q5aANYCKT1bRT
   R+31DXBnOGb9HqpcVao9crg+rSFvBP5LeHv5ZG5uGJ9acbGP78Yz3gXmm
   2UErdNFeyrKn6/JI/UZyJxvD94tMSa9UnNlVTP606idX/3W3kkNJGXc2O
   A==;
IronPort-SDR: VUKwCGPbP4pW25SOwMdYUB4RxMirbqzqf7mwwc+yPYxVShrAiQFvU7uxAef+vsWdDArj9jRlgl
 RmQyhnorWGv+x9LGyPYhNqU578syNfe7EvKNQg34U7PBswDhBeQU/2BXnCcVyfhaebaRq4vKzB
 dRvfQwf5fSjhv52mDW44Cg0O9RyJuHcFZE9PPB2GtoUN97kvEryhj8sZxovkfDsyY+i8aFBJRm
 SCMNuKruSsfMrMm4/mSb54aDV0IVjWdxW53hmhLZdZbGlIV2bADFRRbXX5pPKKyqZ6LDwfZXCY
 iZl5ij8XKj9Y3SLUJqUEHY79
X-IronPort-AV: E=Sophos;i="5.88,355,1635231600"; 
   d="scan'208";a="152970165"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa3.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 09 Feb 2022 03:23:35 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Wed, 9 Feb 2022 03:23:35 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17 via Frontend Transport; Wed, 9 Feb 2022 03:23:35 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AaL+3IXGQGS34xiTB2Ko4Nl3nLtGx8rScHgOJVRgwvc+SK0ed50yGB5ivYRiadrWmKtwwjsDVmr1ZROcZutdBLWCP6r60DqsxizYXdS60k5/Gm55zGslUHeThrUymzUFTmnEbga6GbUb5kRHpsGqlPxJjFuVJI3MLHRoW9jAXFv5OC6+JHy0rk7FEK9UQgNOYaSAFsW8VMr/3T8Xrl12SBOft2yRIwMeKXatduf69Z3jnVTCF6C2gHbVnhhIqUPejzzEolqYmZudSqYWD7w6ZWalbZ/yqtzOJ5qD0vVy50ZGFEghbD0GwvR1CgxJCmr22QaBU9hUj7Y+hiBmVpJPvg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RfOBDj6VN/gWqnocALwN2o7tssKYSO9/FOZF/DPLIM4=;
 b=FDo97BSDEDCjJMjQLFhoiA5yAXkIccKOIhrA+tJy3cFPCqsYMU2KaADnhm7ZlDY/O8ItWlvgEFjavgwBEKIiweQaXH7etAr2VS9XZbYFv9OdSsUmgMYOzhs/4elnV3/7rYGJTKLdopUrvVTylj3kmBPQCU7w83fD3wkCjG7lHCE/Cmt84lkO+L0dznQL8Yu+0RJym9oIHT/x1Nopj9zHs01HK+EK0DJd8vbijagAof8gATUQMOfgoTTZr/Ks/N+57Xbc1sFiVA3mPugTHomiwd+pDSLgyhqD69lu4kzRwCrewBVuRNDWyBkHkW0sxf/MbcY/e01MHmaP5otNUnR8CA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RfOBDj6VN/gWqnocALwN2o7tssKYSO9/FOZF/DPLIM4=;
 b=vZFrwi1/TuIgiHO8gfqi5SvP9igWAJiXqx7gNoXCRk+xcXg2PnH2n5QEL2amiBXB0A2gN4FrevElKPYLB0AfA0avXa/96uw2hV0sTrXIBMJr+e84wIgpUxJuFEkWa3CDSUp+gZu4ItlMtl42ByE3ZvLA+43tR1g4AkuCxY8v05o=
Received: from CO1PR11MB4865.namprd11.prod.outlook.com (2603:10b6:303:9c::9)
 by MN2PR11MB3902.namprd11.prod.outlook.com (2603:10b6:208:150::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4951.12; Wed, 9 Feb
 2022 10:23:31 +0000
Received: from CO1PR11MB4865.namprd11.prod.outlook.com
 ([fe80::25bd:b3c9:a714:cdce]) by CO1PR11MB4865.namprd11.prod.outlook.com
 ([fe80::25bd:b3c9:a714:cdce%6]) with mapi id 15.20.4975.011; Wed, 9 Feb 2022
 10:23:31 +0000
From:   <Kavyasree.Kotagiri@microchip.com>
To:     <arnd@arndb.de>
CC:     <Nicolas.Ferre@microchip.com>, <olof@lixom.net>, <soc@kernel.org>,
        <robh+dt@kernel.org>, <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <UNGLinuxDriver@microchip.com>
Subject: RE: [PATCH v3] ARM: dts: add DT for lan966x SoC and 2-port board
 pcb8291
Thread-Topic: [PATCH v3] ARM: dts: add DT for lan966x SoC and 2-port board
 pcb8291
Thread-Index: AQHYCFO5ScMFg2Rm1UOuhcbekcFR86xgn+oAgClbpICAARgxcIAADYOAgAALPzA=
Date:   Wed, 9 Feb 2022 10:23:31 +0000
Message-ID: <CO1PR11MB48651A1E2F29073C711428B1922E9@CO1PR11MB4865.namprd11.prod.outlook.com>
References: <20220113080017.30155-1-kavyasree.kotagiri@microchip.com>
 <f8b83cf0-7ebf-1ecd-b544-f0d0079d9dde@microchip.com>
 <CAK8P3a2kRhCOoXnvcMyqS-zK2WDZjtUq4aqOzE5VV=VMg=pVOA@mail.gmail.com>
 <CO1PR11MB48651C0D73189AF010407F9B922E9@CO1PR11MB4865.namprd11.prod.outlook.com>
 <CAK8P3a1swyDBvSTg9a6tUnd2V2Zi=ANpJWhJpWwfvp7ArZpwVg@mail.gmail.com>
In-Reply-To: <CAK8P3a1swyDBvSTg9a6tUnd2V2Zi=ANpJWhJpWwfvp7ArZpwVg@mail.gmail.com>
Accept-Language: en-IN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 418e9cbf-0aac-43d4-34e5-08d9ebb63866
x-ms-traffictypediagnostic: MN2PR11MB3902:EE_
x-microsoft-antispam-prvs: <MN2PR11MB3902C9615E0768CB8C2B483D922E9@MN2PR11MB3902.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: po4sN676UE5ES0b0GDpxtqOB822nzNqcYAYSHgvoAOwNmhEEldfi8p4JmAN3gAiWPrFI5s2NerxUogDptFWLAZ0C6RVLZ6r+WbtsVVKK9x2IpWA6zVGhs8QPGWNvuskS2Gb7NzssCxDx7FlExedlgTw1Hf1PR8FiM+IpkhgIy2mVwb2Ba4RVOdudpY8Ay7aH/VreOg5txmNjxyPSmWCB2SMJ4rOZ03RWFNia8E8V9MhGmPFS4X0TUVAyE3Vyigjs5vAnB9bZ7PALV88Lvi0SZGmurpr/+naOdbSHfhmwif/zMoW+enYCe7pSdcYZmaltV54OIXIUCLYE9fbSQYS/QUESe9yPTPWThE2einHwOWuIXA/cqu2YRRZwVg2kfGlJ+lxJO4LOD0KYtqP3SRiXPTfkjEFIGdmXIZhnBXJy8Q796tXe7x30Z1PtnDGNbYw2urc5tMnmEzj0aWGQj8RnQ99VRagbpRhYbt2218uGwv/0PweBTNqvZeX6C3/qDFT/F7ob1kOdq5Y6Dx5h6UKj96deIddFgpgUTKdfgOMi4KhEIlURMvTIj9UR42pUBzJ4Dj/f5igP9Gx8x5gkEh74p0FSiPU1ubrhL8j9oWGEx1IDicgcpaEFOTqr9e3T0ghsOJtfIHQiV9aPly4PiXBtVPoDKx4rfUNlqTPnDY6LLlABoacaJlpCq2tGvHX8aQkNSHAEzsNvz50SmNG6uh24Ccwz0EQSaSXjpImmltEgr7TBnlb/9zUfAV4pOoB5pmGRXOSksmCfh9TjUnp1/sthan/21EZkS2zQaiM4npXfldg=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB4865.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(186003)(122000001)(76116006)(6916009)(33656002)(38070700005)(71200400001)(316002)(26005)(66946007)(54906003)(38100700002)(107886003)(2906002)(5660300002)(9686003)(6506007)(7696005)(966005)(8936002)(508600001)(86362001)(83380400001)(53546011)(4326008)(55016003)(52536014)(66556008)(8676002)(66446008)(66476007)(64756008);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Zk5nSmFGdXhHU0pxcEhRbTl1dmpHRjFkYlJlTHhieDJnTmhnMjBBWEpHZUVv?=
 =?utf-8?B?N1FMNDRuOE4rbm4xUmFRUTdmUkxVdlVXdE9oVThZTUlaaFNMSE9aTVBzem50?=
 =?utf-8?B?V2QvYzJCbFE2dndWVS9wbHE5RzJEQUhyMTFROHFTK09SWGNiR2tPQ2FNUzlm?=
 =?utf-8?B?c1NPRTFTT3RGY1M1ZGVXdG1LdXpSU1RNVFJldmhCVS9YTk0xci9PNW8vcExm?=
 =?utf-8?B?bzVhdVh6U2w5ZkNhb3hNNkhqa1NUV1dEeGlOSXhYVTN5WGMzTGl2ZHl5N0Qw?=
 =?utf-8?B?aUNQbmt1YnVBd213MFZ1cVp0SkxLcFZhUXF0bzFtUHIzUmlpZXlHQXVPZDV6?=
 =?utf-8?B?L2VaYWRIZXg1RFNhc0ZldTNUQnpFQ0lJTUJGZkl0eWVSakF6SzNHYlJFOUxh?=
 =?utf-8?B?dVUzRTVrR1NjeFppa0NqVWs4T3JNaDJDRElpTEtCWm1qZ2IxWHBHWkdFRm4y?=
 =?utf-8?B?YzJzRHJEN2NjUXREdzVTQnp6dEduNGZDNjdCclZIT2l3RjBlYmhLTlN4aDBR?=
 =?utf-8?B?L2JxOWNkNWFTTEdKQUlxZWFFV2FxWmsxNjZQQWsyMVYycVM5Q2Q2dCt2bi9F?=
 =?utf-8?B?N1A0UlkwVHpQQ2FBNGV4cUlXSGFzYloxU0F1THF1cy9IRDdPeVNTZ2R2ZHA1?=
 =?utf-8?B?dlR4ZHRNdzRyckdWRHRZd1BXQ3BQL1lCNUNuUnVsc1FGanV5Z3R3K3lpYU5i?=
 =?utf-8?B?Z2Y0ODlINjVYYm9vUUQxcWsvQ3h0aHptYmRZMUcyWkhhb1lyMCtLRXBLUDlQ?=
 =?utf-8?B?TkcyU2RKOGI2MWVNd252ZXIxY0ZZak5OekdqRytFZkRFcnZxVmpZYkk0czUv?=
 =?utf-8?B?RTJjQkNCczA1aUhTL3hkQkc2b2JVM1F3QmNiTUd4TG9oWVF6SDRXVDYxb0F3?=
 =?utf-8?B?TFI4MkVaT2pNSHQrOWwxVWo4M3lIYlhCOWRNenZIQVVqY2FRMzFudnhTTVJV?=
 =?utf-8?B?SlBUZXlHNEQ3b0VCSDlRRE5YWFRBdTMrczdwM21IYkdLTGRQR3V4aCsySTIz?=
 =?utf-8?B?NGlrZ1IrNmlVQjRZM2d2Q00yTWFldkxpWWZBZTM0UitTNTRvQUdIbktUOFZ4?=
 =?utf-8?B?TmpDRGVTakZ4azVrazk2bkcwNUt0RVliNEMybWxQYjMwelBvRUhjbnBWTE1m?=
 =?utf-8?B?ZlNQUzg4SzlBSnY3TE5qaUNjQ3hTdE9JT1BPeU5GQWtpNWJ4RWhrcHpQZzl3?=
 =?utf-8?B?cTEzNDNLaVFLNFhnVHF0NHdYUmxEZTgvYWJ1cnJyekFneFhwcEh2QWRuVVhs?=
 =?utf-8?B?QzZrNnFMTnlsT09kOWhzbEo4enBIUExhYldjTGtXOTBFQlpBSlRlem1uSUh4?=
 =?utf-8?B?Qng4MzVTVFJqRnplTjRJdjBKVjJGdUo0c1lrWHpyYzMxNXo4bUNyREs5OGFJ?=
 =?utf-8?B?SWFRb2drWmNQUFlRaVJZekljY1VEeGhqWUd0R1kyVCtic3R5ajNiWmVUbkMx?=
 =?utf-8?B?b1RYdlFqVTlvSThMVGNqZGVmd1puNVdHczlzdlY2YVYrckV0NXBURUVXYjNO?=
 =?utf-8?B?cnRoYlJOQTZJOUhzbkR3Q3JvVHdqVng4eVJCRkU1QXFRbTROT2ZTVk1OY25r?=
 =?utf-8?B?OVdML1UrZ2x6Ry9OU0FpaGNmSkd0c3ZualJuNHljVmEwaWE4bkcyUVYvRXlU?=
 =?utf-8?B?L1FLeVVQUTFVMUlUSEdJVHBUN0VCTzUvV2lNMkFmTWNsc05KbmNiY0ZpWXNB?=
 =?utf-8?B?TWFsejlFTFRqbFdCM1JEOHZoVzFEeGFRN3ZhKzhYZkdlVXJ3TmRRQkJHWXBQ?=
 =?utf-8?B?Vm9OcDd3aEhZNS9BbWszWE9qb1d6WWF6emtxWTU0S1FJT21SNWxRUTJqZURC?=
 =?utf-8?B?aGp5eURSc0JyNjhVcCswd1ZPNlJsKzlMMUN4TGo0bnVuSk9SaG9hSEtibSs4?=
 =?utf-8?B?TDFzUkU4WXcxcFF3cDR6Yzh1UVNYQWlDWFdrZWo2ZmllbUo4SHdaMzhhREFw?=
 =?utf-8?B?WFcxZ0p4SW01bWJDZHRVN3QzaXRoSUMxS2Ivak1GdkJTbW1mWGxOMXo3ZWJm?=
 =?utf-8?B?M0dTWnU0eHZWN3VPK2htMFVCOWdTY3BMSUlnUkFETzlRZ2pWRGo0WmpNbGYy?=
 =?utf-8?B?UWJ0eVNTd1lBVVA5eHdqYjU5WFYwdkJoanA2eFBmd3VORmtIdU5vQlpmemh0?=
 =?utf-8?B?UWFLeHpsRjlVRUZsQmZpcmVSNUFla0EreDRYNEE2RVJveXBwVmdnVWowckI5?=
 =?utf-8?B?N1YyS3B5TCs1RWhMSnBScG93enJMVlVyUFVQcVBqaHJCdU5jd1phclpaOUhp?=
 =?utf-8?B?b0gzTERmWU9yVGphS2EzZHlRN2pwYkhyV005b0MvQWMzTjFmTWVpOURxNGtj?=
 =?utf-8?Q?rBY0cinq8w6TjAKAmz?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB4865.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 418e9cbf-0aac-43d4-34e5-08d9ebb63866
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Feb 2022 10:23:31.1097
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 2MiBA/gb/f8ZS6H5PDHUR6HYAmhH+VWwmiyo/OsmHEICPykPdv5KTakfWxBYPprvLeDIEvmTi3TnSGkoN8jAU5WaH5G41IMKI6bNNL49aARv+RNCZMN+Uv4irAkflu/Q
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR11MB3902
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiBFWFRFUk5BTCBFTUFJTDogRG8gbm90IGNsaWNrIGxpbmtzIG9yIG9wZW4gYXR0YWNobWVudHMg
dW5sZXNzIHlvdSBrbm93IHRoZQ0KPiBjb250ZW50IGlzIHNhZmUNCj4gDQo+IE9uIFdlZCwgRmVi
IDksIDIwMjIgYXQgMTA6MDIgQU0gPEthdnlhc3JlZS5Lb3RhZ2lyaUBtaWNyb2NoaXAuY29tPg0K
PiB3cm90ZToNCj4gPiA+ID4gT24gMTMvMDEvMjAyMiBhdCAwOTowMCwgS2F2eWFzcmVlIEtvdGFn
aXJpIHdyb3RlOg0KPiANCj4gPiA+ID4gPiArJmdwaW8gew0KPiA+ID4gPiA+ICsgICAgIGZjX3No
cmQ3X3BpbnM6IGZjX3NocmQ3LXBpbnMgew0KPiA+ID4gPiA+ICsgICAgICAgICAgICAgcGlucyA9
ICJHUElPXzQ5IjsNCj4gPiA+ID4gPiArICAgICAgICAgICAgIGZ1bmN0aW9uID0gImZjX3NocmQ3
IjsNCj4gPiA+ID4gPiArICAgICB9Ow0KPiA+ID4NCj4gPiA+IFRoZXNlIHByb3BlcnRpZXMgZG9u
J3QgbG9vayBsaWtlIG1vc3QgcGluY3RybCBub2RlcywgaGFzIHRoZSBiaW5kaW5nDQo+ID4gPiBi
ZWVuIHJldmlld2VkPw0KPiA+ID4gSSBkb24ndCBzZWUgaXQgaW4gRG9jdW1lbnRhdGlvbi9kZXZp
Y2V0cmVlL2JpbmRpbmdzL3BpbmN0cmwvDQo+ID4gPg0KPiA+IFRoaXMgaXMgc2ltaWxhciB0byB0
aGUgb25lcyB1c2VkIGluIE1pY3JvY2hpcCBPY2Vsb3QgYW5kIFNwYXJ4NSBwaW5jdHJsLg0KPiA+
IEZvciBleGFtcGxlLCBzZWUgdXNhcnRfcGlucyBvZiBncGlvIG5vZGVzIGluIGJlbG93IGxpbmtz
Og0KPiA+IGh0dHBzOi8vc2JleHIucmFiZXhjLm9yZy9sYXRlc3Qvc291cmNlcy8vODQvZDM5YjU0
Mzc5MGZmMjUuamh0bWwNCj4gPg0KPiBodHRwczovL3NlYXJjaGNvZGUuY29tL2ZpbGUvMzMzNzUw
NjM0L2FyY2gvbWlwcy9ib290L2R0cy9tc2NjL29jZWxvdC5kdA0KPiBzaS8NCj4gDQo+IE9rLCBJ
IHNlZSwgc28gdGhpcyB3YXMgcmV2aWV3ZWQgYnkgYm90aCBSb2IgYW5kIExpbnVzVywgSSBhc3N1
bWUgaXQncyBmaW5lDQo+IHRoZW4sIHRob3VnaCB0aGUgdXNlIG9mIHN0cmluZ3Mgd2l0aCBjYXBp
dGFsIGxldHRlcnMsIHdpdGggYWxsIHBpbnMNCj4gbmFtZWQgIkdQSU9fKiINCj4gc3RpbGwgbG9v
a3Mgb2RkLg0KPiANCj4gRm9yIG15IHVuZGVyc3RhbmRpbmcsIHdvdWxkIHlvdSBkZXNjcmliZSB0
aGUgbGFuOTY2eCBmYW1pbHkgYXMNCj4gYSBmb2xsb3ctdXAgdG8gT2NlbG90LCB3aXRoIHRoZSBD
UFUgY29yZXMgcmVwbGFjZWQgYW5kIGZsZXhjb20gYWRkZWQsDQo+IG9yIHNob3VsZCBJIHRoaW5r
IG9mIGl0IGFzIGEgU0FNQTcgYmFzZWQgU29DIGRlc2lnbiB0aGF0IGluY29ycG9yYXRlcw0KPiB0
aGUgVml0ZXNzZSBzd2l0Y2ggSVA/DQo+IA0KTm8sIE9ubHkgR1BJTyBjb250cm9sbGVyIGJsb2Nr
IGlzIHNpbWlsYXIgdG8gdGhlIG9uZSBvbiBPY2Vsb3QgYm9hcmQgYW5kIEZpcmVBbnQgcGxhdGZv
cm1zLiANCk9ubHkgZGlmZmVyZW5jZSBpcyBMQU45NjYgcGluY3RybCBzdXBwb3J0cyA4IEFMVCBt
b2RlcyBmb3Igd2hpY2ggaXQgcmVxdWlyZXMgdGhyZWUNCkFMVCByZWdpc3RlcnMgdG8gYmUgY29u
ZmlndXJlZC4gV2hlcmVhcywgb2NlbG90IGFuZCBGaXJlYW50IHN1cHBvcnQgNCBBTFQgbW9kZXMu
DQoNCj4gICAgICAgICBBcm5kDQo=
