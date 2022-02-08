Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 70C2F4ADB64
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Feb 2022 15:40:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378377AbiBHOkQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Feb 2022 09:40:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378360AbiBHOkO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Feb 2022 09:40:14 -0500
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01D77C03FED1;
        Tue,  8 Feb 2022 06:40:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1644331211; x=1675867211;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=Gq3fo8tZZgEDdP/M1Z7py7eoAeQC0TLhQuvK8iyydI0=;
  b=jbqppcIL/hByz2pPU3VoVeT82+UbsZdYvw/WuZp+nCeGi+gCDkwpdB8l
   UEVJktz34Q2G5QMjYZ2SYnupu2eSXmYzkKeuCSu3f7n1PzGmfdLzgdnpQ
   ee+qz13PfQ0Viwf8HelTaRPZymN/MHVWiVZAbg6rO1V1vpUKBkhUOu9Iv
   8uv8eqpnzCTqjlFEn7NzirSFfJrEaYhg679DMziweuJozFFH0sO7PYmer
   OnxfLcQd5j6/go2CJEici6DkGpCXf2D66AobHbwTFIqLCi8FyKc1lU1Pf
   k2osHL2TeyqksUPb6P/uR9ZGlKfmD1lL/8afeBOL7kaIrzhsQ35cKm07b
   Q==;
IronPort-SDR: 6aAspCAee2h1MDW3IrXQ/nlymDdraXWcGyMu85cuD9SeVXgxwjX9zThm48+Pqi5qKlcTxcjo+v
 EM5YbTNoxC3QkSNCUar6kweQ4mtSkJAVmm2fkM+5w9WQ0u6o6SSXTMF5Gx6rWvbWHthDHRSPtB
 /vV+Km9t1r+nCZup1nowiQXI1eUoCTp7Q9YqU2v3wMti32stYk1bzG/x/7ddZ9rwVG/sjCGJ3H
 KVFViwcq8iGUrCfkeZwDVJ4bouceKJ7N2iitxeWZD7+R7C63zqgSVfP8pq9X8ZLcx3PyC37q9R
 kUugbaowvUzk3+jN2l6v1N5j
X-IronPort-AV: E=Sophos;i="5.88,352,1635231600"; 
   d="scan'208";a="152319047"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa5.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 08 Feb 2022 07:40:10 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Tue, 8 Feb 2022 07:40:08 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17 via Frontend Transport; Tue, 8 Feb 2022 07:40:08 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TuEEZ8siWbTrzgGWkGvgvyt7TsJq8XPhYtyTtj/v9JmR5G7xKgVYELXmKYfPyt/j0GduVotbVBISxJZgBlWe+vLKhr26LYMgc/BXvcLZdFS6XLLnLuRMDENj+b+RsC7mopqyd84QA2Yqs2eEHyLynnLrZoAEUbaqMkA3ObBnyiZm+aqwA7z61RQyNJmZofoey0CStaJAyMhilbW900vPH/t7zO1chCEfL3kBUcycNHd7+0bxACL57HRck+z3FNR4u+5XHd66rtxqfSFU0GroBIZZcYvWU6VOD5J86nEb1qaIxGyEBjf0eDodevHpEfyUXmKOljjrtP3B97+WDOfSwQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Gq3fo8tZZgEDdP/M1Z7py7eoAeQC0TLhQuvK8iyydI0=;
 b=Xgsk0X0VnHusWM13ZqIeqOFmRv/smQ7Mg41F9kcOBF8urtDPxdS2pFvOo2dKirNuSMBy6Iv99DGl9CXEHTqcr007oQXcYqht9yvsUEu7gAs83g7otUvqyhKw7vTAYllVSiuTvmqAyCGa5hB3OoH0Zhv260C9HMgTGTVWpngoEtvpM80juR2qpMcP67FKGk50ubG2mxITElMvN/ilPKbr8PKrbvU71PayGQd07FWqyr25PkXx2gWz9l6h7z0ngM6WojgpHWd1Bf1sOqOtcQgEgz9Vv4/2ccxfinBrv2UjDPM+eqjo2Fad5+sM4z+xMakI51LayMXT6+0dnhxTD95FDQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Gq3fo8tZZgEDdP/M1Z7py7eoAeQC0TLhQuvK8iyydI0=;
 b=jrZrxbY96uw3bcLQ4KTc9236GjJZN19WD3THPeBYH1mcX+8DoK8Ou442QA/15zWv+FEyegzfvt7U2e0gFDY6nntnKO361E3Jvig1VsnSlEZKmr87OcDSxNP1qPGZHPPo3JFnbW1upMGNYoK7p8V2hUEMjpo6BFJkRGWd7X0IwAY=
Received: from SA2PR11MB4874.namprd11.prod.outlook.com (2603:10b6:806:f9::23)
 by DM8PR11MB5671.namprd11.prod.outlook.com (2603:10b6:8:3c::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4951.17; Tue, 8 Feb
 2022 14:40:07 +0000
Received: from SA2PR11MB4874.namprd11.prod.outlook.com
 ([fe80::49cd:dd25:384:e918]) by SA2PR11MB4874.namprd11.prod.outlook.com
 ([fe80::49cd:dd25:384:e918%5]) with mapi id 15.20.4975.011; Tue, 8 Feb 2022
 14:40:07 +0000
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
Date:   Tue, 8 Feb 2022 14:40:07 +0000
Message-ID: <d72a96a9-f99c-5204-00d0-00f78ea96772@microchip.com>
References: <20220208104918.226156-1-tudor.ambarus@microchip.com>
 <20220208104918.226156-2-tudor.ambarus@microchip.com>
 <f5563605-7b61-c23e-68ec-6e315efb268d@canonical.com>
In-Reply-To: <f5563605-7b61-c23e-68ec-6e315efb268d@canonical.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 27565c17-939e-4389-c7a2-08d9eb10e6cf
x-ms-traffictypediagnostic: DM8PR11MB5671:EE_
x-microsoft-antispam-prvs: <DM8PR11MB5671185F9FC3355FF88E2FD9F02D9@DM8PR11MB5671.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7691;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: lK0DxadIOwModtRKKA71x6nSg5f7PNnsVHfttLUQpaJzzYQWD6q9Mi+CCWQhLS6qB/pYa7emwg65BTKDzWhSzYjWele32LksiE0kGBJts2tCH7x03fSSvHJjbkDMhlNMUonliHgBkJUlLegKUSXYSrsOc9prqDVbfSP3SbNz6pxJ1Yi9UqrWGpw7OYXki/gXo88BLMk7OifAjKVztWH1/e31qOuTr20PCfh2eE62YEK7fjIJWGYdg2YbNAwKY+lfNn4+eoBpbcF+uLPhaeyAtlGs2wG7BIxb9craJQMAV4RBTOuxqeGSiO3zI2Z1ZI9Sa22s8efHsc9zN5KMVxVYUXxnpFMeVTX2wn3TOoBV4ely7gtN9+G02kbyi/Xw49dCevuAOKWJuS1j2OnFh6Fv4ivorl+fl3iFHCE7L/0HZVIFfoUZ9S4GfC2/U83COUqOxxce4G4DM2qPqL4CSALRMbA3Ix6Cow8Kh2mRJl+4DJ1Z7dLcF1JkSCiu50f7KXWGy7RmLNsseGg773Y2JzKGds/RpAwojyYgvYOtZrUO2SW9cRj6LAaOYVVdOhv/uqs3vr1TFgSoZ6n0S/+ke6BiFKvwj0BoUykB+33PFT1dDmf3TXuKhCZKEoUiCIZx8p9+fforUZyo5yw768x5382b3yNdT8wvfkO4gUFoT5xVCzzl4EWd9Z894+42oK9XtllmrUntv7s5vgznR8wA/Ae36084yCl5/cEP2L5VdwQowfxzIcPe4v4/HnyoLOmUdh+V/h4w9uPZToKd1WHs25ENhvOVZiT7cFDVonhENNH7Q0zMDhLLyKFsRR2Wg8Zpkg5igvzDRLMEO1zPAZGmbq5UO6D74Kd17GgDtx2wxqJwpDc=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA2PR11MB4874.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(83380400001)(31686004)(76116006)(66946007)(66556008)(64756008)(66446008)(6506007)(66476007)(36756003)(508600001)(186003)(91956017)(38100700002)(966005)(6486002)(122000001)(5660300002)(71200400001)(26005)(86362001)(54906003)(31696002)(2906002)(110136005)(316002)(6512007)(8676002)(8936002)(4326008)(38070700005)(53546011)(2616005)(43740500002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?VmhnUGNlckpEaktIZDdsbnRKZTR2d1NOM2VYM3JVRDZIYzR1aHNTMk4rNk1t?=
 =?utf-8?B?Y25tK2dZa3NxMkhuRDh5NXh6SlN3cHR4SExhZkFFejMrQ2xpNDg5WlgzNDJm?=
 =?utf-8?B?Uy80MUxiY1I5OFh0eXJEZXFnenA3RTdtS2l3b29yOGhwVE5oYjc4MGpJOTR2?=
 =?utf-8?B?N3VtWllPTU15L1NPa0l2Q08rbm1Zd3dsN3NjNkNNV0N4eEQyUStPTXl5d2Vm?=
 =?utf-8?B?bStOaWNORUI3N2ZvNDdzeEdzcTRlL2JOOEFOUmtkY21TbkxDUHliSHBqRzJN?=
 =?utf-8?B?cnhuWVZKaERROTV6aVBRWDI3UDAxMWM1QkVjUFJ1dzc3dW5ydTFrOEtza0N5?=
 =?utf-8?B?QjEzNnJnNmY0Q1VnaVBZeFpmbSsrTDY4VWIzNFdNZDNNaFZybFBQYVd1SXRP?=
 =?utf-8?B?SHA5TGEwQkZFYnZFSEpwcjlUbkROeUZZdWdESEk4NU5RQndHZnR6a0dka1BE?=
 =?utf-8?B?QVpkRmhxWTJRMHBDMTkwWUtmUC9BOVZ4ZHNDN2V0NG4rWHFvSHRGaU1FVU1D?=
 =?utf-8?B?OEJZbDc1RzlGbDl5cExiRVh0cWxBYk55YlNTR0FRTzl1blJhQUJ0V2JJZmV4?=
 =?utf-8?B?eHgvQ0IyZE9FR3plZjZFNWlpbDB6aTBWalpYNHFZeGVUNmMyZnQ4RmtiSXVY?=
 =?utf-8?B?REZRWCtScXpMSG1jaCtoK0ttZktDT0dsdi9KU2FreEJJeDhEWko5dVVDYlZF?=
 =?utf-8?B?cTlXQ0pQam5hYWtlYmhqTWRFQ0ZYMFVCRUpUaTVYbWZIRWhMYXgySk1VSzN3?=
 =?utf-8?B?NE10SHpJa1lrRWFBSENGdXhoYU5Na0QxWXNmWGd2OHZmOCtENE9zUXVvTlI4?=
 =?utf-8?B?ZENMSTBTMnlZcUdZbWtWMllmNWNPZUNTRCsrOGllRGk4V0RVbTluUEhjM1Bz?=
 =?utf-8?B?WXkyVmp0Y1Z2RGJyUHduZ3JhVDA0NFlBSFRrdU14QVNoOWEzckkzUE4vM3VD?=
 =?utf-8?B?RWp6WmxEcjJEZVA2c3k4cnY4bi9LcFlUZ21CTHFPUkE1THRvam5CMVU0K3Na?=
 =?utf-8?B?R3lnWG5zKzZ0ZTlRY0U5Wm1xZlRVODFmZ1hCcTEvWUVDY2lDanI1YTdpNGFZ?=
 =?utf-8?B?RkJjNU4zNzRYSmNWZHFqN2plT3hOWHpWYlpXV1Vxc0hzZk5ycTMzWGJrZUtS?=
 =?utf-8?B?TDFZRFJKNDdwR1ozSDA4YWVjMCtucllGMDJncHVDTm1EWXRqaTViWkhKZHd2?=
 =?utf-8?B?UVhZUEFwbnZqMy9xcEVyL1RjdENaZlJJaFVlS2FCKzc3UjJDaFNjelRka1RG?=
 =?utf-8?B?Zkt4YVA3azVkNzFvRUppZnEzeU4rK1g2bVMvakJpdVN4T0VxWCtQU0ZLR3hV?=
 =?utf-8?B?TGNtNE0vazNoQWJRNFNMa3JoM01ORmd6K3JadlNJSDZFNUVTampMcENRb0tW?=
 =?utf-8?B?aktRelpHY2xtVEEwTjJBdkR3VmJKZm9kNVowcVNYUHV3Sk5mdG8yTXp3STd4?=
 =?utf-8?B?TVpKN0xpbFZyUmxaVlBReDdUQzNYMkpDY2lnbGs0M2dYZjNyVjFkUXg0YU5i?=
 =?utf-8?B?UVhVZUpaSmt4ZlF0L1Vuei9mV3RsbmZYRFJYYmUwd3NmMVhGcjJRVFRaK0Fy?=
 =?utf-8?B?ZnVwMzdNcjlEUS9Tc1hOTGxBRURQZm5yUmhIT3pJT0VnTmxaY0hHWmllcXpo?=
 =?utf-8?B?OVJmSlFrNEZsRS9oT3JCdGtrU3ltVzJ0ZGNiaVpkMFl5Nk1Yb1IrMGw5VGFx?=
 =?utf-8?B?dFYvWmZoQzNsYlI0SitJdTZWdWNiM2QyZVZyZG9OT3Fsc0F4M0RURGs0TmNo?=
 =?utf-8?B?d0p6WDF0RVdldWlVVDU0Wm1taTV4U0lyZDJpL05RRnVYamJwdEhlYTMrVHVp?=
 =?utf-8?B?RUhTbDNUZmVoZE1NNkNGNk1mRXpGV25MZmlxRURiV05jbmZ2UngxUmlBejd4?=
 =?utf-8?B?Qll5a2JZcWRjWUNhallGclpLYTVTcmE5bm5RaU85TVdKZWZmcXl1RlExTk9F?=
 =?utf-8?B?amFOckhvVWZqaDQ2WnEwNHViQ0NWblBhZmRzUUdwZ20yTHZlclZnUmZrZm5i?=
 =?utf-8?B?LzFwN1pJUEF6VFUza3k0R0dWL2lla2VnM2RwdHNGRFoxWlFLMG05NnR3cDNu?=
 =?utf-8?B?OVNGZUFjN1pLdTdYWWh4cnJMN3BmQWhadGs4cGZ1UnRpZXkzcU9zWDZ2UnVq?=
 =?utf-8?B?N2ZVODFiZFM3Z0lwNEFqbmsxbXdSVnRnQWtGS0JMVzFpNWdldzczY1lGYkxp?=
 =?utf-8?B?eTdEQkFHS2dqcnduVU8vZ21haUdEZzJJYnQvMCtCYTQ2L0FOWFJNcXd2OU9y?=
 =?utf-8?B?OVFyRVQ3Q1psSHg5YnMrY1hFYjlBPT0=?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <E61DCF0C2F476E4B92E3C05A26D61AD8@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA2PR11MB4874.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 27565c17-939e-4389-c7a2-08d9eb10e6cf
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Feb 2022 14:40:07.3079
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: tZHUKcChMthHa9z5Y/mTqE1l9qk41I8edMUouIGR8g8PYhZ1aFjoQV6nmwJmuGvMQthaBH7+zHUvrlAHtHCYfeChVCSNEq3UZQqhgpujnX8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM8PR11MB5671
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gMi84LzIyIDEzOjU4LCBLcnp5c3p0b2YgS296bG93c2tpIHdyb3RlOg0KPiBFWFRFUk5BTCBF
TUFJTDogRG8gbm90IGNsaWNrIGxpbmtzIG9yIG9wZW4gYXR0YWNobWVudHMgdW5sZXNzIHlvdSBr
bm93IHRoZSBjb250ZW50IGlzIHNhZmUNCj4gDQo+IE9uIDA4LzAyLzIwMjIgMTE6NDksIFR1ZG9y
IEFtYmFydXMgd3JvdGU6DQo+PiBDb252ZXJ0IEF0bWVsIEFFUyBkb2N1bWVudGF0aW9uIHRvIHlh
bWwgZm9ybWF0LiBXaXRoIHRoZSBjb252ZXJzaW9uIHRoZQ0KPj4gY2xvY2sgYW5kIGNsb2NrLW5h
bWVzIHByb3BlcnRpZXMgYXJlIG1hZGUgbWFuZGF0b3J5LiBUaGUgZHJpdmVyIHJldHVybnMNCj4+
IC1FSU5WQUwgaWYgImFlc19jbGsiIGlzIG5vdCBmb3VuZCwgcmVmbGVjdCB0aGF0IGluIHRoZSBi
aW5kaW5ncyBhbmQgbWFrZQ0KPj4gdGhlIGNsb2NrIGFuZCBjbG9jay1uYW1lcyBwcm9wZXJ0aWVz
IG1hbmRhdG9yeS4gVXBkYXRlIHRoZSBleGFtcGxlIHRvDQo+PiBiZXR0ZXIgZGVzY3JpYmUgaG93
IG9uZSBzaG91bGQgZGVmaW5lIHRoZSBkdCBub2RlLg0KPj4NCj4+IFNpZ25lZC1vZmYtYnk6IFR1
ZG9yIEFtYmFydXMgPHR1ZG9yLmFtYmFydXNAbWljcm9jaGlwLmNvbT4NCj4+IC0tLQ0KPj4gIC4u
Li9jcnlwdG8vYXRtZWwsYXQ5MXNhbTlnNDYtYWVzLnlhbWwgICAgICAgICB8IDY1ICsrKysrKysr
KysrKysrKysrKysNCj4+ICAuLi4vYmluZGluZ3MvY3J5cHRvL2F0bWVsLWNyeXB0by50eHQgICAg
ICAgICAgfCAyMCAtLS0tLS0NCj4+ICAyIGZpbGVzIGNoYW5nZWQsIDY1IGluc2VydGlvbnMoKyks
IDIwIGRlbGV0aW9ucygtKQ0KPj4gIGNyZWF0ZSBtb2RlIDEwMDY0NCBEb2N1bWVudGF0aW9uL2Rl
dmljZXRyZWUvYmluZGluZ3MvY3J5cHRvL2F0bWVsLGF0OTFzYW05ZzQ2LWFlcy55YW1sDQo+Pg0K
PiANCj4gSSB1bmRlcnN0YW5kIHRoYXQgeW91IGtlZXAgdGhlIGxpY2Vuc2UgR1BMLTIuMCAobm90
IHJlY29tbWVuZGVkIG1peCkNCj4gYmVjYXVzZSBvZiBleGFtcGxlIGNvbWluZyBmcm9tIHByZXZp
b3VzIGJpbmRpbmdzIG9yIGZyb20gRFRTIChib3RoIEdQTC0yLjApPw0KPiANCg0KVGhlIHByZXZp
b3VzIGJpbmRpbmdzIGRpZCBub3QgaGF2ZSBhIGxpY2Vuc2Ugc3BlY2lmaWVkLiBXZSBoYXZlIERU
UyBmaWxlcyB3aXRoDQp0aGVzZSBub2RlcyB0aGF0IGFyZSBlaXRoZXIgKEdQTC0yLjArIE9SIE1J
VCkgb3IgR1BMLTIuMC1vci1sYXRlci4gVGhlIGRyaXZlcnMNCmFyZSBHUEwtMi4wLiBJIHRob3Vn
aHQgdG8gZm9sbG93IHRoZSBkcml2ZXJzLiBJIHNlZSB0aGUgZXhhbXBsZSBpbiBbMV0gdXNlcw0K
KEdQTC0yLjAtb25seSBPUiBCU0QtMi1DbGF1c2UpLiBJIHNlZSB0aGUgY3J5cHRvIGJpbmRpbmdz
IHRoYXQgYXJlIGNvbnZlcnRlZA0KdG8geWFtbCBhcmUgZWl0aGVyIChHUEwtMi4wLW9ubHkgT1Ig
QlNELTItQ2xhdXNlKSBvciBHUEwtMi4wLW9ubHkuIElzIHRoZXJlDQphbm90aGVyIGd1aWRlbGlu
ZSB0aGF0IEkgbWlzcz8NCg0KVGhhbmtzLA0KdGENCg0KWzFdIGh0dHBzOi8vd3d3Lmtlcm5lbC5v
cmcvZG9jL2h0bWwvbGF0ZXN0L2RldmljZXRyZWUvYmluZGluZ3Mvd3JpdGluZy1zY2hlbWEuaHRt
bA0K
