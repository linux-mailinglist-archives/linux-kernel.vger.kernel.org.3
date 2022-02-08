Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0FE6F4AD4A0
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Feb 2022 10:20:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353931AbiBHJTr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Feb 2022 04:19:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353813AbiBHJTp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Feb 2022 04:19:45 -0500
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F8DCC0401F0;
        Tue,  8 Feb 2022 01:19:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1644311983; x=1675847983;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=pyaoLezC6+Cq1xJl8u9+P5+G+r/wOidbKgp1SYpZDZI=;
  b=rFnHlFgj2nWU/iwtOlwQcDOzdcCRdd04oGKlIFIMgAqz+ugxRmd+yhnw
   R7lCI8Rg5SGZ3cSg7IYVpWvk9190irEcIvUrI/j1qxsLBCgIXbsL0bLWS
   ZKFQBjT/hQyp0JNLPIsOoos0ouivHePaS+PakONRdpucDFRFP0zFP/EYH
   kqfKMNp0gbn5f+un2HllwZjn0o/48dB1kB1ClFqsne8GmnSFyDUXAQrzo
   OfChbBMfqIO2sTV5ATJYSjOagD7dy8ebmib89Ehlt1WEmHGMM1ZoPyRYF
   Ni7yNOCVhXpquHAyPcK+ToaMQ0jH31trM789hweq6q93ez2f4VEWRKp/M
   A==;
IronPort-SDR: YNnBfkspTLf/eMHbUPi/m5poj+hWZqP73nMncMEregQw2GWzyKwDrPiXysljw2wch81lt8wTr8
 K51dqlZzJlxNptJ4y5Nn3l2XXyLZqkClcUoaNin2U2FzOL+UQEsXum83QjNSoiZ6hUp6JNct/e
 uZOzhrcUTVAIzyDbJJyd+TWTVB98ThcoBXcjOAhzhweC90DjoZr94czV+Xu33RKmC9IeDhKgJB
 I6/7T0mOXDR+FZN8WBwDt2DFtSZSZfg2kzDzPpt9+nknJRLf/1yC4yzEUisSyEshijI2OoOemn
 TUkaUvZkfTD0bCbnwLyn8ijr
X-IronPort-AV: E=Sophos;i="5.88,352,1635231600"; 
   d="scan'208";a="152816699"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa3.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 08 Feb 2022 02:19:42 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Tue, 8 Feb 2022 02:19:41 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17 via Frontend Transport; Tue, 8 Feb 2022 02:19:41 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DZdpIHntMYxO/77d7bHKjV+bhGvS395/2edtam6m2hRCN1OUuEgg5L7Wge44JEfielfnBiwwVgxkN0sL29EqQAIMly1bZmGgn0Tba9aipwZTPsIohfC3zHKF9L2ZgUfYvKGTZ9kZIfpvHGMYGVOFkXDrGNLdU4peZ9q9i7bupF5exK3HhIZJWhRQr5eLAzxeYMBYx9Dc82U66cGi9k3y2Vuw0TQQYhE94gO1DIj5/Z401rVrDWmbiR5z4WQLeGErwj5VZx9ibtiWNY8zQtzzpUkmyvqwNANu0j4p2viwgyivF6JcOqkN53wdiR+9ud/smX2CF6umDTIngJZdFHXvgA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pyaoLezC6+Cq1xJl8u9+P5+G+r/wOidbKgp1SYpZDZI=;
 b=VN0iKt2zmsqFeuACkxobVNfxb5flexB5DzzA9CINCS8DLf7krymLDIPJ0L6lOswTHH7eZQ7uYcTLx8DANKcX49vInQxaQCQqprSzR5ih+NIVqYf9pdMqZzTWQ8JTQbjFskjFkX9+wMPAAeGKfq/7+ynYNX7lfhnnwdrWWFAHqaxsWZK5Yvh2n4rKnUm1TmNtPaHT/a8idqJDDO1he2ALTy/tvMDuK7al0Z+CYzlTnMbksDk8fX5/hJldDOSfZctEenPT/XZUsKcwKi2V0rmChCXbdMb8wQFDPwqWxDNRaS2/mXQOdR+1aZ33B4KQMkUosZg4sp5BZstdjrHSE5cVRw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pyaoLezC6+Cq1xJl8u9+P5+G+r/wOidbKgp1SYpZDZI=;
 b=GsR5ZudwyR+0HAbjxkcGxA//dEz3w3zvrvWmo0retCaroPi5NBYTUGH5zCWgLDf2+wqMGi/MKBTz0vlM2aWiYLJBumggi0jgu3MeNJnTY4RyiU7c/UfGIsEipuK2TtWt1vuu2b2kEVo/IVB2aNtp0Z+XpgEhKk+0TqvUpSFIJe4=
Received: from SA2PR11MB4874.namprd11.prod.outlook.com (2603:10b6:806:f9::23)
 by PH7PR11MB5765.namprd11.prod.outlook.com (2603:10b6:510:139::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4951.12; Tue, 8 Feb
 2022 09:19:39 +0000
Received: from SA2PR11MB4874.namprd11.prod.outlook.com
 ([fe80::49cd:dd25:384:e918]) by SA2PR11MB4874.namprd11.prod.outlook.com
 ([fe80::49cd:dd25:384:e918%5]) with mapi id 15.20.4975.011; Tue, 8 Feb 2022
 09:19:39 +0000
From:   <Tudor.Ambarus@microchip.com>
To:     <krzysztof.kozlowski@canonical.com>, <herbert@gondor.apana.org.au>,
        <robh+dt@kernel.org>
CC:     <davem@davemloft.net>, <Nicolas.Ferre@microchip.com>,
        <Claudiu.Beznea@microchip.com>, <alexandre.belloni@bootlin.com>,
        <linux-crypto@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2/3] dt-bindings: crypto: Convert Atmel TDES to yaml
Thread-Topic: [PATCH 2/3] dt-bindings: crypto: Convert Atmel TDES to yaml
Thread-Index: AQHYHKD9BNP6l8jrfUC2M8gpuOVb8w==
Date:   Tue, 8 Feb 2022 09:19:39 +0000
Message-ID: <6a50f030-7ddb-ca28-cdd2-d4d08fccc5f6@microchip.com>
References: <20220207032405.70733-1-tudor.ambarus@microchip.com>
 <20220207032405.70733-3-tudor.ambarus@microchip.com>
 <c7e160b0-16fb-79ca-c291-05571bbe8341@canonical.com>
 <6aa72f5a-e9c2-cd8e-ab26-fc8b4ad5cc25@microchip.com>
 <e353cec3-9839-7274-d244-5b80b5a3fe55@canonical.com>
In-Reply-To: <e353cec3-9839-7274-d244-5b80b5a3fe55@canonical.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: b96bd0e0-0222-4f20-6611-08d9eae4220c
x-ms-traffictypediagnostic: PH7PR11MB5765:EE_
x-microsoft-antispam-prvs: <PH7PR11MB5765E731D6454F973159EE66F02D9@PH7PR11MB5765.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:5516;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: f38W6GO82M/zk8FWYhRDIkUo2FdNn/tYZM71KUdu0SMnNWotQfy6ORv13DJMXJIWCwRcfMJOQnzXon4Bio3tOH4GBt8WciotSUAPA0UAIAY4MFEFVS8C2TD8BimrEZlHZ8oc4ndJRhb+aF4DcDOY9p+tK3gbN2dGc8S2Ms78RJrZscuMvkx7zAJrZVpwpmZRkE0HUzfocQAD+seBbYtLmkKcdNApIr/7OIcFEA8YsNhALumwKLNjlwvI/mKBfN1+HeeuYkc68566JdgNxTxWjw5hkh7P2SZqJuux+GWDZwVCLAvM0XgKMQd3vipx3uy5K8azXgOzc4NjXL76h1CYcJ4LG8ymLUI071aTfl/iT7bj7G+oBk3SdEU2cAprJy/1PxTyJOT1m80A9808/jghQyjCoGmSPbilReLgWJtmN8cpR0mnm2N5UWVU9BPjHjHJWTeqSBHJMYlGSE5Ck8396mjc2jVihJxu0syfDFsf/Hu4QaMEhy0czbSvmhO9aMNY/GPv5Kipi/moybgQpsmoQFt6MZxOaUc0rocgeDTLdXmhmSpuSFnUzsey9t5mK4N1YG7Fk5nHLJ0q+mBclpHCqk8sL342vCdm2Ap9sAk0w2gC09BKrzCHEjw9WXehPiPYqbKu1oYDU9s1tEq2US3e/ded/GaESh/Iw8xwbZulcjG02LG37C9O5oCQhjjzfyinzjkXSAXSROpS7OHUpp9hEgwUsfOqzsx6ECzyQrmQLD2hsknBYPxtx2lsAj5zeVhnwU67IAxTWTE9o6HEFNEo9+u1QGm9iByT5gtkgMBN2Us7Ngm1lSC5BPPTeFmQjlc4m6LqitfXtdj12cQvaK85heAonB1dAeLjb66svdiBSo7h2OtyWaoum+PdQN3i7ga7p52gw106zP5pXWioeCeq3A==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA2PR11MB4874.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(26005)(186003)(83380400001)(110136005)(6486002)(966005)(66946007)(64756008)(8936002)(31686004)(71200400001)(6506007)(6512007)(5660300002)(53546011)(316002)(36756003)(122000001)(31696002)(4326008)(8676002)(66476007)(91956017)(66556008)(2906002)(76116006)(86362001)(66446008)(2616005)(508600001)(38100700002)(54906003)(38070700005)(43740500002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?b0tla0M1cUhlUXdUZnk2ei9tS0VQbnF2QkRBQTErdkE1VS9mN05QWGZDa1My?=
 =?utf-8?B?SE1MOWJSK1A3RStFV2pQalVPV1pFWld3elZRZW9wVkdnZmlIRzFFOU94ci9t?=
 =?utf-8?B?V1BkYXIwaG5BTHU0c1oxbmNrUXFJaDFjOG1ZQnlwaDYvVjRENDUrOUVQVDY3?=
 =?utf-8?B?em9WSWQ4WHBGM0ZFb0NIVnNzRVNOclhEVGVsdDJ2R005bFpzWnlVYUpZbE9X?=
 =?utf-8?B?QUhwcXNqTm15SXE1QVFzWE5zRFlETjBjQ0lJaXZqRmVZK1dMTEJEVTU2Mm1L?=
 =?utf-8?B?blBLNm9Id2dnV2R4MkJKUjBDb0VvbEpSZGtLb3pBVjJTZzZZaUUxUDE0Vmlv?=
 =?utf-8?B?UWRlUTZPc01DRzQvcURPdVhITDdZcTc5NkRtZG41bFg5ZithWFIzUm9VYmlO?=
 =?utf-8?B?RTAxR0dlTlEzSmtEUEV0OFk3a1o4eTRhSXp2VDN6SHNBZGM2azU0SDVIcFRK?=
 =?utf-8?B?eGdYRzQxeCtxek5Hb0hlRUdMNXphemhpb1plZmRjeW5KQ0MyeXJNZmthOElI?=
 =?utf-8?B?eXJLTnBGKzlDSjZzUDQzaU5IaTJnSkNGSXRUK3d1QXMzK3JwVXNuWDNKYUJF?=
 =?utf-8?B?R3FnWU1hbVBFdDhXeFdSR0RRN0QxWUtLc0NjM25XbyswOXdRdjNTempZVEVV?=
 =?utf-8?B?QlZsaW1jWGIvWFE2Q3B0WUsrblgvdlpCRUhia2dFdEJlRW0wSWxTKzQwUzVG?=
 =?utf-8?B?VlJMR0V2UUlxa0dPejEwZXRKaUJ0MDdoYWlhajdPNEt6MlF0Ty9EOUdFeFBY?=
 =?utf-8?B?ZzFxc0kzUmZ0NWRLbCtld1JHcGFDbndFbmFLT0s3UWhxeVNscTZia0l3Mi9Y?=
 =?utf-8?B?UnBmK0xieXZSNEZ1djlZQlJ4enlRWnhPbHlYWnoxdGNqeG05anBaUjdEc0dO?=
 =?utf-8?B?OUlUSnFrRjYvamVyN0cyOUR0L3pXaE1qOVpoMWdkdUdwVVBNY2NYbTNraGZU?=
 =?utf-8?B?NVNEQXJGQlFMZHFpT0EwbnpUUS9xNGlhRXNnMWg5ZElGV1VIckRGK0dQL1RE?=
 =?utf-8?B?V0N0eENXdHE5UzdIMjVpSVhCMzdqR2lqZm1HOVJJaW9GZ1loWDdvL09UdWg0?=
 =?utf-8?B?UnpIRnJqY0N2eEM1NlpOOEhEVWwrN1Z1VFhEYkxQcWVLNmsyODJyV2VVL0NU?=
 =?utf-8?B?bU5aK0ZQa1crc2RYQ3l1dm1SNzlZb1F3cjJaMCtweGxNQXR6Y09vVGk0Rk5j?=
 =?utf-8?B?RUluNkJrUmxNRG5pZ0M4WnVBMnhYdkptRm9ZN0lZdXVzNHR4d2s4QUxQNlJ3?=
 =?utf-8?B?aTRkbEt2Y3Erc1pUMXprNUdLcFQxK3BXRnVCQzhKL3lLNGVDRHFFVGswVHJu?=
 =?utf-8?B?ZVNOaERQb0FJYjQ0VG9UZzdpc1QydFdYa2RXSEZYM0ZBWWJzd1dBQUVBeW95?=
 =?utf-8?B?S0hlWXVuWUFxSklCZ1hpeDFyNjVQOUFhaDFYZ0VSeVVmdXVLWmtNenZIcUNv?=
 =?utf-8?B?T3IwcjRZTGZwVXVVRXVyblVvTmlvaVFtdjE5QkxkbytPV2FFSytaQzVvSWxU?=
 =?utf-8?B?VE95OWpkd3UrNmtZaHRxRVVGUjJvcTlMOWtNd1h4SnFUNUtTVmhnMlFNVkdw?=
 =?utf-8?B?T21oT202enJ4QnVCY0dCWnBidXBLaG9nQi9DTS9oenZXMUhycTdJa1dPYyt1?=
 =?utf-8?B?bTRYS1lLYnVoNitITmhrTnlPcy91MTBMRUlyd3hoeG01bmhQWVhOSjJzc1Ft?=
 =?utf-8?B?c3NBOEU0V050M0ZTU1l4aWpndWFsNDlPYlpnNEhpTHowcEJLMWcrSjRpb3NM?=
 =?utf-8?B?OG9RdnUxcWdwWFA0YWxJa0t6bW5lTW90dzlETHcyS2lmVG5TclpydVZ0R2kx?=
 =?utf-8?B?Rkd4cm0yYzd6d3BOdTJ0Z3RUaFljWWY0TElwL2t5RERBRmxlQnhHLzRKcnV0?=
 =?utf-8?B?M0Q1UFVmdThEVTNhUlVHL0k4NVZHa25PK0lvM0dMS2pma2pYOFVNempvaVhX?=
 =?utf-8?B?VExrcGFITk53UUgxNlRpRStuQlVjUFk5TG4zZFJoNGNHdTlmSnIzRTduZW4x?=
 =?utf-8?B?eUI3RFBDWjhKMUtWR2F4bTNObVZtVVNHK21tRm5Sa3A2YkNTWGVjTVVUUlFs?=
 =?utf-8?B?T2F1NGYyQ2VYQXY1anE5L1p1eklYV1VFRmcvOGlyQmZWVDlGTW9TNXZlTG1r?=
 =?utf-8?B?NkFDWFhadXhOS2VvZFJpTHVqamRDM1E0OGUrcTVGUmhsMHBhTE15ZWVyZU1x?=
 =?utf-8?B?V0lmRThUTXN6YlRKQTgwVFZ0TnVidU1oeFIzL3FXMzNyMW9qeGx4NjhCS0NV?=
 =?utf-8?B?R3pjYWtIeU9malVrcXlWVEpyZlVRPT0=?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <D16CB490DAA497498978759DC9D333B0@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA2PR11MB4874.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b96bd0e0-0222-4f20-6611-08d9eae4220c
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Feb 2022 09:19:39.3536
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: m8pTyyRWBmzakVJXeKAALvhrHrG8C2MMM1iw1u5+2CY7ywE2lukOVc3F60EsuQUYDJM6T3UlIkbLmEVUGGC3Gy9efZ7r0+5Bt75++c7fL24=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB5765
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gMi84LzIyIDExOjAxLCBLcnp5c3p0b2YgS296bG93c2tpIHdyb3RlOg0KPiBFWFRFUk5BTCBF
TUFJTDogRG8gbm90IGNsaWNrIGxpbmtzIG9yIG9wZW4gYXR0YWNobWVudHMgdW5sZXNzIHlvdSBr
bm93IHRoZSBjb250ZW50IGlzIHNhZmUNCj4gDQo+IE9uIDA4LzAyLzIwMjIgMDU6MDQsIFR1ZG9y
LkFtYmFydXNAbWljcm9jaGlwLmNvbSB3cm90ZToNCj4+IEhpLCBLcnp5c3p0b2YsDQo+Pg0KPj4g
T24gMi83LzIyIDE4OjA0LCBLcnp5c3p0b2YgS296bG93c2tpIHdyb3RlOg0KPj4+IEVYVEVSTkFM
IEVNQUlMOiBEbyBub3QgY2xpY2sgbGlua3Mgb3Igb3BlbiBhdHRhY2htZW50cyB1bmxlc3MgeW91
IGtub3cgdGhlIGNvbnRlbnQgaXMgc2FmZQ0KPj4+DQo+Pj4gT24gMDcvMDIvMjAyMiAwNDoyNCwg
VHVkb3IgQW1iYXJ1cyB3cm90ZToNCj4+Pj4gQ29udmVydCBBdG1lbCBUREVTIGRvY3VtZW50YXRp
b24gdG8geWFtbCBmb3JtYXQuIFdpdGggdGhlIGNvbnZlcnNpb24gdGhlDQo+Pj4+IGNsb2NrIGFu
ZCBjbG9jay1uYW1lcyBwcm9wZXJ0aWVzIGFyZSBtYWRlIG1hbmRhdG9yeS4gVGhlIGRyaXZlciBy
ZXR1cm5zDQo+Pj4+IC1FSU5WQUwgaWYgInRkZXNfY2xrIiBpcyBub3QgZm91bmQsIHJlZmxlY3Qg
dGhhdCBpbiB0aGUgYmluZGluZ3MgYW5kIG1ha2UNCj4+Pj4gdGhlIGNsb2NrIGFuZCBjbG9jay1u
YW1lcyBwcm9wZXJ0aWVzIG1hbmRhdG9yeS4gVXBkYXRlIHRoZSBleGFtcGxlIHRvDQo+Pj4+IGJl
dHRlciBkZXNjcmliZSBob3cgb25lIHNob3VsZCBkZWZpbmUgdGhlIGR0IG5vZGUuDQo+Pj4+DQo+
Pj4+IFNpZ25lZC1vZmYtYnk6IFR1ZG9yIEFtYmFydXMgPHR1ZG9yLmFtYmFydXNAbWljcm9jaGlw
LmNvbT4NCj4+Pj4gLS0tDQo+Pj4+ICAuLi4vYmluZGluZ3MvY3J5cHRvL2F0bWVsLHRkZXMueWFt
bCAgICAgICAgICAgfCA2MyArKysrKysrKysrKysrKysrKysrDQo+Pj4+ICAuLi4vYmluZGluZ3Mv
Y3J5cHRvL2F0bWVsLWNyeXB0by50eHQgICAgICAgICAgfCAyMyAtLS0tLS0tDQo+Pj4+ICAyIGZp
bGVzIGNoYW5nZWQsIDYzIGluc2VydGlvbnMoKyksIDIzIGRlbGV0aW9ucygtKQ0KPj4+PiAgY3Jl
YXRlIG1vZGUgMTAwNjQ0IERvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9jcnlwdG8v
YXRtZWwsdGRlcy55YW1sDQo+Pj4+DQo+Pj4+IGRpZmYgLS1naXQgYS9Eb2N1bWVudGF0aW9uL2Rl
dmljZXRyZWUvYmluZGluZ3MvY3J5cHRvL2F0bWVsLHRkZXMueWFtbCBiL0RvY3VtZW50YXRpb24v
ZGV2aWNldHJlZS9iaW5kaW5ncy9jcnlwdG8vYXRtZWwsdGRlcy55YW1sDQo+Pj4+IG5ldyBmaWxl
IG1vZGUgMTAwNjQ0DQo+Pj4+IGluZGV4IDAwMDAwMDAwMDAwMC4uN2VmYTVlNGFjYWExDQo+Pj4+
IC0tLSAvZGV2L251bGwNCj4+Pj4gKysrIGIvRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRp
bmdzL2NyeXB0by9hdG1lbCx0ZGVzLnlhbWwNCj4+Pj4gQEAgLTAsMCArMSw2MyBAQA0KPj4+PiAr
IyBTUERYLUxpY2Vuc2UtSWRlbnRpZmllcjogR1BMLTIuMC1vbmx5DQo+Pj4+ICslWUFNTCAxLjIN
Cj4+Pj4gKy0tLQ0KPj4+PiArJGlkOiBodHRwOi8vZGV2aWNldHJlZS5vcmcvc2NoZW1hcy9jcnlw
dG8vYXRtZWwsdGRlcy55YW1sIw0KPj4+PiArJHNjaGVtYTogaHR0cDovL2RldmljZXRyZWUub3Jn
L21ldGEtc2NoZW1hcy9jb3JlLnlhbWwjDQo+Pj4+ICsNCj4+Pj4gK3RpdGxlOiBBdG1lbCBUcmlw
bGUgRGF0YSBFbmNyeXB0aW9uIFN0YW5kYXJkIChUREVTKSBIVyBjcnlwdG9ncmFwaGljIGFjY2Vs
ZXJhdG9yDQo+Pj4+ICsNCj4+Pj4gK21haW50YWluZXJzOg0KPj4+PiArICAtIFR1ZG9yIEFtYmFy
dXMgPHR1ZG9yLmFtYmFydXNAbWljcm9jaGlwLmNvbT4NCj4+Pj4gKw0KPj4+PiArcHJvcGVydGll
czoNCj4+Pj4gKyAgY29tcGF0aWJsZToNCj4+Pj4gKyAgICBjb25zdDogYXRtZWwsYXQ5MXNhbTln
NDYtdGRlcw0KPj4+PiArDQo+Pj4NCj4+PiBTYW1lIGNvbW1lbnRzIGFzIGZvciBwYXRjaCAxIHBs
dXMgb25lIG5ldyAoYWxzbyBhcHBseWluZyB0byBwcmV2aW91cw0KPj4+IG9uZSkuIFlvdSBuYW1l
ZCB0aGUgZmlsZSBxdWl0ZSBnZW5lcmljICJhdG1lbCx0ZGVzIiBvciAiYXRtZWwsYWVzIiwgYnV0
DQo+Pj4gd2hhdCBpZiBzb21ldGhpbmcgbmV3ZXIgY29tZXMgZm9yIGF0OTE/IE1heWJlIG5hbWUg
aXQgaW5zdGVhZA0KPj4+ICJhdG1lbCxhdDkxc2FtOS1hZXMiPw0KPj4+DQo+Pg0KPj4gRm9yIGhp
c3RvcmljYWwgcmVhc29ucywgdGhlIGF0bWVsLXthZXMsdGRlcyxzaGF9IGRyaXZlcnMgdXNlIHRo
ZWlyIG93bg0KPj4gZml4ZWQgY29tcGF0aWJsZS4gVGhlIGRpZmZlcmVudGlhdGlvbiBiZXR3ZWVu
IHRoZSB2ZXJzaW9ucyBvZiB0aGUgc2FtZSBJUA0KPj4gYW5kIHRoZWlyIGNhcGFiaWxpdGllcyBp
cyBkb25lIGF0IHJ1bi10aW1lLCBieSBpbnRlcnJvZ2F0aW5nIGEgdmVyc2lvbg0KPj4gcmVnaXN0
ZXIuIFRodXMgSSBleHBlY3QgdGhhdCBubyBuZXcgY29tcGF0aWJsZSB3aWxsIGJlIGFkZGVkIGZv
ciBuZWl0aGVyIG9mDQo+PiB0aGVzZSBJUHMuDQo+IA0KPiBJIHdhcyBub3QgdGFsa2luZyBhYm91
dCBjb21wYXRpYmxlcy4gSSB3YXMgdGFsa2luZyBhYm91dCBmaWxlIG5hbWUuIFlvdQ0KPiBjYWxs
ZWQgaXQgImF0bWVsLHRkZXMiIHdoaWNoIGlzIHF1aXRlIGdlbmVyaWMuIElmIE1pY3JvY2hpcCAo
bm90DQoNCm9oIHllcywgSSBtaXNyZWFkIHlvdXIgcHJldmlvdXMgZW1haWwuDQoNCj4gQXRtZWwu
Li4pIGNvbWVzIHdpdGggYSBuZXcgdHlwZSBvZiBBRVMvVERFUy9TSEEgYmxvY2sgZm9yIG5ldyBs
aW5lIG9mDQo+IGFyY2hpdGVjdHVyZXMsIGhvdyBhcmUgeW91IGdvaW5nIHRvIG5hbWUgdGhlIGJp
bmRpbmdzPw0KPiANCg0KImF0bWVsLGF0OTFzYW05ZzQ2LXRkZXMiIGZpbGUgbmFtZSBzaG91bGQg
YmUgZmluZSwgdGhhbmtzIGZvciB0aGUgc3VnZ2VzdGlvbi4NCg0KdGENCg0KDQo=
