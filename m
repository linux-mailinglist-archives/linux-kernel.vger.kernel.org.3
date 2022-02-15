Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C57004B6694
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Feb 2022 09:52:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234952AbiBOIwn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Feb 2022 03:52:43 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:34310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229948AbiBOIwl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Feb 2022 03:52:41 -0500
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EDB38113AED
        for <linux-kernel@vger.kernel.org>; Tue, 15 Feb 2022 00:52:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1644915148; x=1676451148;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=BaDCvre+ATMX3Vei4ysv7xcMzwabtq7J/8sfKz9lSMU=;
  b=itpKDVVEZlyqiOvuaMr1ScbWiPyY10gNzjeXOxReOegUlon7gUnn3C4y
   TgY4XekkrEhyMiHgG6LsanOJLmN4uqdEZLiP83NhgmXzeo5B0ihjufbYv
   LzvT3jfBgPHTbkn/LkqzMXqz2RlajHxccrtQKp4XDkT24aH5viPgbNM9v
   K5SzGb2BhJ8SVX+iYGnH5WfMFZm3CcJePV2KHefxAbTHcg3QGb3IpgxR0
   atiO24oQjk2Mrxqxe2IGsGbSk+5O/wJ/8VGmpvG7H0BTuunhudCIuyI+d
   vNZ9BhaS4vQ6lNCRYr7MHOaZ6rVXrIUcrvLg0937brf0RQp4mNUAVu/5g
   w==;
IronPort-SDR: /riTwrMLuTqWmOc8HREhPZekPxpOjvUHy++AxbUXmeRb2v5H27T5Zl9NtOwQoHF5n0IlewiIXF
 4ggJ1zZm38vjmO4X6TaybRizWdJ+FUvnarEylgd/lIkzJnHufJm2Eirx+42csgNsLGR8feFZ3D
 EjusnRGE5Uwa+ggnEOmJZ6DrpfQfCSeSBTFh8EadShjFFmrn7u1IWSJ5OnKcXmFpbnJUv8yqk9
 1lCNYYQqbWh6rROaQZQZNaUjTiqzdH8HVy+XSdr/b2v6h7BJnC0ABzBzogP7WauFKwQ8mHFqT6
 /BhbQ+e7Hu0HT4s7A3JNS8nt
X-IronPort-AV: E=Sophos;i="5.88,370,1635231600"; 
   d="scan'208";a="153627340"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa3.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 15 Feb 2022 01:52:24 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Tue, 15 Feb 2022 01:52:23 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17 via Frontend Transport; Tue, 15 Feb 2022 01:52:23 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Hgk/0k5kfjIvvUk+x0x3vX481ZpADROK45fTkNQCAOeaq7fAPohCpvFIXmtW9tA/OvyeUJ2eo9VS6qtqbVaevDgupvXgL2nNlEd1as2WM+336krv+eZz0dlxnPOZLblNK8F4u55FhksT4TEcoLTwP/qpIjpK2gA/rdzgWa3KaJ3vQcN66bVFjhQ8QyoVawKgi+TwoTbheWd6iYrCNWnZ/ncPUF7HE4ytor8aa4KGWZa34duLvoALsTViUwWuMKMn9seO3yZLfDxezr8HLb8mAdOKPPF9zbHbOnhyFLg/U02RLA95zVlEbv9BQ3RdgN13KdsNI0tSAvUEy1jRxi9Z2g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BaDCvre+ATMX3Vei4ysv7xcMzwabtq7J/8sfKz9lSMU=;
 b=BDfMNs3pbotITryonssVFz6O9nFyNQnrzkLAQNDURMjnfatSidzTl5wvf76rqD2j7MQPhbGrfLQs0RWI7RK72x/HAK5jfbN86y3yaF2164fHqiquW/pQqGn0cwg/SFHau8j5xF8aDlLan32epk6qWi7Q5MeeyFyQD/IZWUKuVWepVHAHyOrT2Faewfgax6RApC5pc1j4dL/l9NTPfZlLV8xfND912fzA+RyB75IiDPVVaEsfxcRLN4LGPjoqy19mdBs4AkC+NDiO8eMw8v4vxZcz6ROO/+eCVMRx/A6dfFewmLwWaRuVKXhJOyNv1g809aN2WMv7xqWWsSCmEQQ8tg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BaDCvre+ATMX3Vei4ysv7xcMzwabtq7J/8sfKz9lSMU=;
 b=noHIVIE1gJ+1KNHiAX3b2eUdiUOih9UCQ3IPa3k2tMR0Yy7WA+vEdXVHXVntjSZncoUqR6mGzFj3OL8HI6hYq4iLIR923VyPOkGkPhQuzCJxVDPKZjAwGdHFpODkS9vKiCrN6rSbOqpZjsYiVsiZI8TOitqlyf11cI9e98c7cvc=
Received: from SA2PR11MB4874.namprd11.prod.outlook.com (2603:10b6:806:f9::23)
 by BL0PR11MB3425.namprd11.prod.outlook.com (2603:10b6:208:73::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4975.17; Tue, 15 Feb
 2022 08:52:13 +0000
Received: from SA2PR11MB4874.namprd11.prod.outlook.com
 ([fe80::49cd:dd25:384:e918]) by SA2PR11MB4874.namprd11.prod.outlook.com
 ([fe80::49cd:dd25:384:e918%5]) with mapi id 15.20.4975.019; Tue, 15 Feb 2022
 08:52:13 +0000
From:   <Tudor.Ambarus@microchip.com>
To:     <michael@walle.cc>, <miquel.raynal@bootlin.com>
CC:     <linux-mtd@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <p.yadav@ti.com>, <miquel.raynal@bootlin.com>, <richard@nod.at>,
        <vigneshr@ti.com>
Subject: Re: [PATCH v1 05/14] mtd: spi-nor: xilinx: rename vendor specific
 functions and defines
Thread-Topic: [PATCH v1 05/14] mtd: spi-nor: xilinx: rename vendor specific
 functions and defines
Thread-Index: AQHYHiuFz8+evF2o8USFiXwNjUvH0Q==
Date:   Tue, 15 Feb 2022 08:52:13 +0000
Message-ID: <7d8b7581-4610-6c04-9033-dac9ba27038b@microchip.com>
References: <20220202145853.4187726-1-michael@walle.cc>
 <20220202145853.4187726-6-michael@walle.cc>
 <68aa414b-7a9d-1330-531c-37b2db2ab09d@microchip.com>
 <73d3d8ed2cb4ca1b06902b767fe529c3@walle.cc>
 <d76f21dd-4038-57de-f2f6-6afa947b62cb@microchip.com>
 <c3a58de8ee39dd473483dfd0ed8a0058@walle.cc>
In-Reply-To: <c3a58de8ee39dd473483dfd0ed8a0058@walle.cc>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 87da95b1-7137-467a-3428-08d9f06075ce
x-ms-traffictypediagnostic: BL0PR11MB3425:EE_
x-microsoft-antispam-prvs: <BL0PR11MB342530D52B36666F1A92547BF0349@BL0PR11MB3425.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: qQkHRkuyECbBcRvYG5iBxqBfJXt0hzjGhxYDByaXZy9sYEZqKIW8hTZJmjFIxIwZaZ5J1IJ/7Ul+L8/rTRmTj6Nsa8tdOpzPb4twcZMGr2XrCouCGgM1oJ+dnIKewMJ8OtlZUD9NUZpT88B1kuLGLP8kiL9sA+z8NZmHj2B6KVjseiOqfkvmGzTuy3XGKzxzEBWq4rAzMNfjqce3WLImDGB0Pk1RrkUzblsW9ThCHmfRExgvalTaggcLPv9IjgCA2ISNL2qhHxiUuW1pqwjTGZhbn6o3Tjv5KsD+jerjrWuv8OYewhTR7D8xbqE++1i+R3dxkEJtmr/rLRORHV+/BCppruOkMWPytoaZxiHAz3rojjHJdbSHxePYKZGTUVafreSuWIj4ga8KOaU/CTznDuY3BQf7qBjl1Q0XWyGVPqgsbHljBBIYbog1TZuUs3WIk7ggKD8V+rUMPHe/gMJ7VWvy+0mpYeitVZ8pqAvD2SS4S6BK39K7gW844N/xjefd6e90X/7ZdEeQrjydyddFcbY2P0Fhnp0Oe7CZ0ICPGPQ3tSUjqL0Uw6aInZfp1HDNOIojCBIIqiYrwpPbH0T8mWzE53aQU1BiSSRFSlseE/Unj5iAfoCt8UNa8BdnIr6XwIgGx7fm2LicNrtZoUaRYxPGKYH1M/+SIO1+U8U1RKAEAoCKbv27eN5xHuW3mppBHMj1GVC6DnpnthDm4S7K4XunwBqitgnEJOm2JKApsZOZKm3lcwefs7rc3p7rRu6X3/jBsvDm5hmtB46RDw6CJg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA2PR11MB4874.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(86362001)(66446008)(110136005)(4326008)(8676002)(64756008)(6486002)(54906003)(91956017)(316002)(76116006)(38070700005)(31686004)(8936002)(36756003)(38100700002)(5660300002)(66556008)(122000001)(66476007)(31696002)(66946007)(71200400001)(53546011)(2616005)(6506007)(2906002)(6512007)(508600001)(26005)(186003)(43740500002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?d1JBdjYyWStZMFBKQnQ0SVVyMGh2QzA3NjE4RmUvUVg2dTlqcGxONk9JOVpS?=
 =?utf-8?B?TEYvUnVRd0FsRHg4N2RZekpqdkh0WWpKbzZTeVY5R1Y2cTRRejJkYnFRaWxR?=
 =?utf-8?B?ZVo4UW4yQ3BmamxCeW1UWTBYNHNZM0wxdFJqTFU2cDZPVHRBWE51alZEL29v?=
 =?utf-8?B?TWNzMCtCZkJBd2pUUlRQaWdFTEdQTmRIY0JQdXUyTVNJbzNaOVZONTBNZEw2?=
 =?utf-8?B?YWtwUG85K3VCOHEvZEw4emtiNGJETnNlYVhFSmszU2I0KzhYVHJMczhEdFo3?=
 =?utf-8?B?RW44dWdaN2s5SXI5Z0Z6aUlSU04zT1FyaHBpU01kdWVnSFpLVkgyMklNRE1w?=
 =?utf-8?B?b1JSU2ZaVkNtbTRmQnRYZk9BeEtyWUs2eWEzRkJzelM5SlI1Tit0WFZsK3E5?=
 =?utf-8?B?SWxGMmZSa2FPNWw3RDY3MWFzdWpNZnNVc0x5YzM1ZnMzeEF2cGFxdVluK1Ux?=
 =?utf-8?B?aS9OdUg5YksweWxJZjArY3dHejVYTHpOSFkxVS82VXBwVm9XMDVOVFFZaWRs?=
 =?utf-8?B?cEJOVUhoMkNoekJraHVYOVo4MjBqOU9VcXJ4VkI3Y1d4Q242UTB0REk0L21M?=
 =?utf-8?B?ZDBVcVNSUlFmN1RndkRXMHhqcGJzd1MvTTNYeXEzTUxwVE9SUjVVemllejY5?=
 =?utf-8?B?R3YvSGxKRDdxQWl0NlBzeTcvdkl2NDFjSm9Wc0dKbDQ5R1A0dTdnenN4eUNx?=
 =?utf-8?B?cUNGQWhaeU9mTDhmSTZrSko2bStCeVo4Und6S1JaeXFJd3RDbkJNY3lsa2ha?=
 =?utf-8?B?V21WVzhiMTRIcG1YYSs5aWU0RjhiQWRHRGVQQitSR29FSHhtOXdwTjJIQnB5?=
 =?utf-8?B?eEZCditMeEtHOGJtWm9QK3E0UXJiUWxvd1JVN2JaMHdDcy9Lb0xQN1hXQVV6?=
 =?utf-8?B?YXdnc0pQeGhBOVJTZVpGWGoxZG1VdkZDajJ1NWRsNXptbGhIZVJWWnNnc1Mv?=
 =?utf-8?B?cjlTVDhuV2JzVEFCVzdPMkFHWUgxTTN1d2V3MmJ2alJ5dDgrN2R6cllvTTlx?=
 =?utf-8?B?OWR6YjBkU1doOGJwNVc3ckVUdUhDbHFXWkt4WG1ZWk9RNkhoSXhKY242NWs2?=
 =?utf-8?B?TytPS0FxZUx3ZkxUak9qeTJaM1pkTVhkdkNLNkt0TzEzOUNXZm1lOWN6bGdP?=
 =?utf-8?B?dEVJV2JMa3U3NVozT0FaUnlMdHBOb1o0VnA4MU9tQVNvckRqZUNuNUxKVGpV?=
 =?utf-8?B?dyt2NGhyZGhodFQzZTV3T0svbE1zcEYxTHJTOXdXa0tPbG1WcE01L3JMS043?=
 =?utf-8?B?WWV3dnZoOEVrazd2OGw1NkJaRmNCaGNISjgzRTdQWlo2MHhHNkROb0lqTVdU?=
 =?utf-8?B?dWpRbHdwa2xKV0gyL25RWklpYVNMcWNhT250eXltbU1GN3NnZ1ZxMUFleUxS?=
 =?utf-8?B?YUZYZDJwMEFBRm4zSkpuaGw5OStvMXlhWTNWWklIWFpTSkZqeGdxRkhIVXZy?=
 =?utf-8?B?VEJmbXNhdDhvZ05JWHVQTEFibTdrTGt6WnMzam44SFJpY0RVWUJhcWJBUEg5?=
 =?utf-8?B?ZFlqMXBUOXhZR2hyVGtUZytwY1kzM1VQMndrSzFPK1A3c1J6YXRDREE0UUUy?=
 =?utf-8?B?ZnVxcVliaG52N1lJbW90K3R6RTlOcFZJZVRHa0g3cWZjVmNuMmdnK2NpZjNr?=
 =?utf-8?B?eTZPTTEwb1lucm5TLyt4OHlXMlBtblBycTA5QVZVUnpWN2pnRVhvaDdtWE1E?=
 =?utf-8?B?bDFnRHZ2VU1SRkp4TzhDMDhuMU9aL2c5N1V0dmN2Y1MycERoZVFJelpSSDZR?=
 =?utf-8?B?MUF3NjVidytTb1JZVkhjZHlJRGljTi8xK3FKL2w2MmV3V2RwVysvNEtBRjJr?=
 =?utf-8?B?U2NWY25jL2VlckxCWjMvNExrY0JEd0pSb3dueHNWeEw4d01TOGZKdlBRUjda?=
 =?utf-8?B?eUNjMHhQa05OMzE5anJ6bkl6blpDbnBRSDh5WUY4dm54YnpqUXVEUlh5QnhM?=
 =?utf-8?B?eDhVZzByVmJBeUlITm16NUd6YmVnbzRCQ3ZkYUt6MXV2d0Fnd1FJUCs1VU15?=
 =?utf-8?B?WnpTZFdCVmc1Y3VUZVdlZlIxZEliSVdKNEdvK0xQVFpaVWFwVjJLcDZFWkRj?=
 =?utf-8?B?VW12V2tYSzliaTJSRDZTbENTaCswa0g5WTRBdFVrS2Z3NDFOZ2NTQVk3d2dq?=
 =?utf-8?B?VzYxQ2YyMlhtVG1ndXNmK0xnOXZoeDVUZHdnQ2VFMUhQQnpubTNrTFB5QnJu?=
 =?utf-8?B?WFIxdWxHNlB0VVd6b2pwbXVBMGdxN1MzaVlRUVNEdk5sUUh2M1plc3N1VGVN?=
 =?utf-8?B?c3pMZ3Y2UjVPMkQ4SGkzdG45SmlnPT0=?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <D142FA0A5B26B6429A4E528C5AB602D8@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA2PR11MB4874.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 87da95b1-7137-467a-3428-08d9f06075ce
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Feb 2022 08:52:13.2985
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: yEZxZng3bRgQOFHVZMC6Rwfyv9uqQPbepGyrpmVhQaw8xpo0MDSYuTBpzUPKQlzAC3CniEx9jql69xExYKWfdkHcqO6KSAtP/byXJneTlMo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR11MB3425
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

TWlxdWVsIGluIFRvOg0KDQpPbiAyLzE1LzIyIDEwOjI1LCBNaWNoYWVsIFdhbGxlIHdyb3RlOg0K
PiBFWFRFUk5BTCBFTUFJTDogRG8gbm90IGNsaWNrIGxpbmtzIG9yIG9wZW4gYXR0YWNobWVudHMg
dW5sZXNzIHlvdSBrbm93IHRoZSBjb250ZW50IGlzIHNhZmUNCj4gDQo+IEFtIDIwMjItMDItMTAg
MDk6MDYsIHNjaHJpZWIgVHVkb3IuQW1iYXJ1c0BtaWNyb2NoaXAuY29tOg0KPj4gT24gMi8xMC8y
MiAxMDowNCwgTWljaGFlbCBXYWxsZSB3cm90ZToNCj4+PiBFWFRFUk5BTCBFTUFJTDogRG8gbm90
IGNsaWNrIGxpbmtzIG9yIG9wZW4gYXR0YWNobWVudHMgdW5sZXNzIHlvdSBrbm93DQo+Pj4gdGhl
IGNvbnRlbnQgaXMgc2FmZQ0KPj4+DQo+Pj4gQW0gMjAyMi0wMi0xMCAwNDowOCwgc2NocmllYiBU
dWRvci5BbWJhcnVzQG1pY3JvY2hpcC5jb206DQo+Pj4+IE9uIDIvMi8yMiAxNjo1OCwgTWljaGFl
bCBXYWxsZSB3cm90ZToNCj4+Pj4+IEVYVEVSTkFMIEVNQUlMOiBEbyBub3QgY2xpY2sgbGlua3Mg
b3Igb3BlbiBhdHRhY2htZW50cyB1bmxlc3MgeW91DQo+Pj4+PiBrbm93DQo+Pj4+PiB0aGUgY29u
dGVudCBpcyBzYWZlDQo+Pj4+Pg0KPj4+Pj4gRHJvcCB0aGUgZ2VuZXJpYyBzcGlfbm9yIHByZWZp
eCBmb3IgYWxsIHRoZSB4aWxpbnggZnVuY3Rpb25zLg0KPj4+Pg0KPj4+PiBtbSwgbm8sIEkgd291
bGQga2VlcCB0aGUgc3BpX25vciBwcmVmaXggYmVjYXVzZSB4aWxpbnhfc3JfcmVhZHkgaXMNCj4+
Pj4gdG9vDQo+Pj4+IGdlbmVyaWMgYW5kIGNhbiBjb25mbGljdCB3aXRoIG1ldGhvZHMgZnJvbSBv
dGhlciBzdWJzeXN0ZW1zLg0KPj4+DQo+Pj4gQnV0IGFsbCB0aGUgb3RoZXIgZnVuY3Rpb25zIGlu
IHRoaXMgZmlsZSBzdGFydCB3aXRoIHhpbGlueF8gOykNCj4+Pg0KPj4+IEkgZG9uJ3QgaGF2ZSBh
IHN0cm9uZyBvcGluaW9uIGhlcmUsIG90aGVyIHRoYW4gaXQgc2hvdWxkbid0DQo+Pj4gYmUgY2Fs
bGVkIHNwaV9ub3JfcmVhZF9ibGFiYSgpIGJlY2F1c2UgdGhhdCBsb29rcyBsaWtlIGENCj4+PiBz
dGFuZGFyZCBzcGkgbm9yIGZ1bmN0aW9uIGJlbG9uZ2luZyBpbiBjb3JlLmMNCj4+Pg0KPj4NCj4+
IHRoZW4gbGV0J3MgcHJlcGVuZCBhbGwgd2l0aCBzcGlfbm9yX3hpbGlueF8qKCk/DQo+IA0KPiBJ
J20gc3RpbGwgbm90IHN1cmUgd2hhdCB0byBkbyBoZXJlLiBIYXZlIGEgbG9vayBhdCBhbGwgdGhl
IG90aGVyDQo+IHZlbmRvciBtb2R1bGVzIGluIHNwaS1ub3IuIHRoZXkgYXJlIGFsbCBwcmVmaXhl
ZCB3aXRoIHRoZSB2ZW5kb3INCj4gbmFtZT8gRS5nLiB0aGVyZSBpcyBhIHNzdF93cml0ZSgpIHdo
aWNoIGlzIGZhciBtb3JlIGxpa2VseSB0bw0KPiBjYXVzZSBhIGNvbmZsaWN0LiBTbyBzaG91bGQg
d2UgcmVuYW1lIGFsbCB0aGVzZSBmdW5jdGlvbnM/IE9yDQo+IGRvIHdlIGp1c3QgdGFrZSBvdXIg
Y2hhbmNlIHRoYXQgaXQgbWlnaHQgaGF2ZSBhIGNvbmZsaWN0IGluDQo+IHRoZSBmdXR1cmUgKHdp
dGggYW4gZWFzeSBmaXggdG8gcmVuYW1lIHRoZSBmdW5jdGlvbiB0aGVuKS4gVEJIDQo+IEkgZG91
YnQgdGhlcmUgd2lsbCBiZSBhIGdsb2JhbCBzeW1ib2wgInhpbGlueF9yZWFkX3NyKCkiLg0KDQpJ
IGRvdWJ0IGl0IHdpbGwgbm90IGJlIGEgY29uZmxpY3QuDQoNCj4gDQo+IEJ1dCBJIGNhcmUgZm9y
IGNvbnNpc3RlbmN5LCBzbyBoYXZpbmcgc29tZSBuYW1lZCB4aWxpbnhfLCBzc3RfLA0KPiBzdF9t
aWNyb25fIGFuZCBzb21lIHNwaV9ub3JfcmVhZF94c3Igc291bmRzIGFuZCBsb29rcyBhd2Z1bC4N
Cg0KeWVzLCBJIGFncmVlLiBUYWtlIGEgbG9vayBvbiB3aGF0J3MgaGFwcGVuaW5nIGluIE5BTkQu
IFRoZXkgcHJlcGVuZA0KdGhlIG5hbWUgd2l0aCB2ZW5kb3JfbmFuZF8qKCkuIE9yIGluIFNQSSBO
QU5EIHRoZXkgdXNlIGZsYXNoIGZhbWlseQ0KbmFtZXMgd2hpY2ggc2hvdWxkIGJlIHVuaXF1ZS4g
U28gaG93IGFib3V0IGFsaWduaW5nIHdpdGggTkFORCBhbmQNCnVzZSB2ZW5kb3Jfbm9yXyooKT8N
Cg==
