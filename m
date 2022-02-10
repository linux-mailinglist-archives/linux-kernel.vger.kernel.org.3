Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 956394B0406
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Feb 2022 04:42:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232199AbiBJDmQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Feb 2022 22:42:16 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:60818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229543AbiBJDmN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Feb 2022 22:42:13 -0500
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 658ED23BF2
        for <linux-kernel@vger.kernel.org>; Wed,  9 Feb 2022 19:42:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1644464536; x=1676000536;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=CLh2nwABYCoaqgmSyxPjwCVOJ3R00ywAg2jvwnbtDbQ=;
  b=088jns98+w9YIZ5Wm/vyDo3tvqVKba3u0CCpfBvfpN9rCoN7tKZeW9Ug
   xKj7dKUGaqQtLNE6TQTLKBViFLT6hVMQKscirX66wLGY5qXJBm+zCH+8H
   j5a1q8RrRq5iTCLpEsh5LjTXhDHqio+6YdAVbF1vSXL37Bdg1yONlrpkg
   qrPCi9bWR/WKXdoJQQ5xo7oYZF3SRfAdZauCpJTJ3OChcMxOMnir8xBHZ
   NmanCgNtJNEXu9BUzQCjpI6F89qNbVlJBZGYakhuhwZ7S46LRBaCNEUiw
   q+z++06HMb66AWYByhq4zueLVmr2wGdQk8OA0MQGP+57hbCg2zITz05x3
   g==;
IronPort-SDR: pkdtVoSco96sdQ1u20k1npon+jq+NRgHmCq0noKR//ePIgJgDPkGUvzAl3+huf61QBBAf8t2NC
 k041YgbRpQ+3yt9BecjJqGaQOdL1mStfT9okcp1N0a/4TqpkC4yp5yZ32W8gZexRLkeX5wUBlY
 vNBY2qLjNK5COG7jLDP6ss3l72Zok/zSMN0eO9N5IfKkllFzc8wCHHghwbnhE3/7datukbEmPP
 vbVGY36gogncyx5JcL+9QVK9PlrgfrdBwCfgMq/oZPDhBJPCWB8LYfa5WAri0nPYd4kZNBffMd
 ESyqPOVMK7h4nCxA9UvTgWcH
X-IronPort-AV: E=Sophos;i="5.88,357,1635231600"; 
   d="scan'208";a="152558655"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa5.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 09 Feb 2022 20:42:16 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Wed, 9 Feb 2022 20:42:14 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17 via Frontend Transport; Wed, 9 Feb 2022 20:42:14 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IfNSoYZ5Tyr662StsZEkppCeS1hrr4foxjkBqIdlBUkVCgI5XsrWGUl6aZJO7FMEzOT4ehXokyBKGJDX++WhlhqHHDfvv5eTPl2KGGemKwTBSMlQU5CP0IrCrrXj7jjQux36/hfZXNPrXv3mwVFiwYyO1XCqhIwfGkAHoC+MgEo4NEF8EpJgQS3uRJApFMkK8+3iKMQRd7vN2oC65SYXhSKVtnojcEGVg3xxkFJnBrbr6AFfkXDp5+/Iy0J6OqtNQge1cmqrWWwQ+iXn5bLuBPuci41+37Atw3XM/FouNIa8QZIfDKEwQYOUwd/+4/z3o/sCLpmzKqhih5OMU3E4XA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CLh2nwABYCoaqgmSyxPjwCVOJ3R00ywAg2jvwnbtDbQ=;
 b=CXgRvqtflEvvKVWI4CO/4OA95q080J2/fn1chpHvmlGuvxDscW29lmKeilC4yMno1whxY2CHObhZUl9/Ex1tnP/lCCytfNfjh7XlgaCL9LII6R81E5kdajsW7C/rWv279dP2Nb/lwlHCe8HWFFqlwXboaEk5EDYpOThUx7SGiRyhSOu92X1sRqEE1eexyZ0cqRB18wAa46N2LNmbPRTyhYEuTb8UT+hx7go01glhlZp1S56iCE1IPzNyxHtePd1IVR7S9+PHhoKFPwMIfjLim2KLDHRQmJIVcNc6XDAkxRaZinc8I9lVZbReDDVevktBreEdEVu0yGWV0eJcji8n5g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CLh2nwABYCoaqgmSyxPjwCVOJ3R00ywAg2jvwnbtDbQ=;
 b=TV2O7iT4bQCu6GzdlyVi9GdiGTi4rbftOujDDSQJg8Xpp6kIOGqQGQJorcgtMOuDdDX5K8T7KNsY0PxbewiQ8DhLFKeqyPxXJjcZKtUL8sssWrMKdb7mNAhvuTqRfI1H/S9fmXEaDzIKFGYjB5BNA/7EGjEGNEjxoC2thbyULZo=
Received: from SA2PR11MB4874.namprd11.prod.outlook.com (2603:10b6:806:f9::23)
 by MN2PR11MB3824.namprd11.prod.outlook.com (2603:10b6:208:f4::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4975.11; Thu, 10 Feb
 2022 03:42:08 +0000
Received: from SA2PR11MB4874.namprd11.prod.outlook.com
 ([fe80::49cd:dd25:384:e918]) by SA2PR11MB4874.namprd11.prod.outlook.com
 ([fe80::49cd:dd25:384:e918%5]) with mapi id 15.20.4975.011; Thu, 10 Feb 2022
 03:42:08 +0000
From:   <Tudor.Ambarus@microchip.com>
To:     <michael@walle.cc>, <linux-mtd@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
CC:     <p.yadav@ti.com>, <miquel.raynal@bootlin.com>, <richard@nod.at>,
        <vigneshr@ti.com>
Subject: Re: [PATCH v1 00/14] mtd: spi-nor: move vendor specific code into
 vendor modules
Thread-Topic: [PATCH v1 00/14] mtd: spi-nor: move vendor specific code into
 vendor modules
Thread-Index: AQHYHjAuRn0sp/gsuUe9nTLTR7wB3w==
Date:   Thu, 10 Feb 2022 03:42:08 +0000
Message-ID: <0c10e1cc-8f38-2e53-e24a-92e40d1473a6@microchip.com>
References: <20220202145853.4187726-1-michael@walle.cc>
In-Reply-To: <20220202145853.4187726-1-michael@walle.cc>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 8af20a9f-9c01-40ed-c2ff-08d9ec47509d
x-ms-traffictypediagnostic: MN2PR11MB3824:EE_
x-microsoft-antispam-prvs: <MN2PR11MB3824AE7B43508A8831FA9BD6F02F9@MN2PR11MB3824.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Vubc3IeBHHLchWHgkMhHOy4KN2SVLjFvs7DTyWKG243lqAyIAZie8DtzddjxS0CTxALdIjO7FH+XYM1PHz96qhdHb5Snd0K4afw5oVBeERmXMzIu1+vOsdaDiyunMmoAVtLiGUYsIem31I+I45ZCOF41NdyahdDwx0rM6lMicplDtsZmFoq0bwPr2NoP7a4QRXWiIr5T6OlCVho/cA/kl06IUHGMunsV9AvI0F1AoxX8srOgpHHbFhFS4rPZWy6u8/rFHDHZH7Lx/V97fT6OW5lC8OF4KNIC2OfIotm/Zwpu6+MCuDgC++HU8BYxRDOTaw1bP7JsaXv3Jry2mQSMD4zM72Z/fyEcLUsOVJiseCH0NSaFHHUltKS4gvfeGEeUaSxiNEr4CqaynQmmnyWXFmGcSWruDkBBXF0P4oQCJQJG4HUxuSXKPWJfyqq+408EwhchZH1oww31cMLJWTSzsq7lJrkTzcWAoQm1wGRzZjNBLV9RDqedrOIL3SnwkmuBknDLky+oA0Vey2haZrveCB1befKiMA6WI4zje0ial6sm/PUDBYUpZImHJ6SN6oEsyIqy6dABnR4N8TLzjS5wQc08S10P8LxfTXZqVWo1I09qFbKuoJodHg7xZ0vMFPCP7XK5RHVenut28qT0Kqi+iqPNjhOwn2ISihFlNaH32u/8LYaZWEKIq+DAAwBNaXPtx4Hqnqiopjyf1B57E7J3ay9CLoHkwj4QY7cWf/BXqppITj9tWNOF5Zxdnla86oXGRfecswIUkut33Zl7L1V+Lw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA2PR11MB4874.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(4326008)(64756008)(66446008)(66476007)(66556008)(8676002)(26005)(6486002)(66946007)(508600001)(76116006)(91956017)(316002)(54906003)(110136005)(6512007)(36756003)(2906002)(2616005)(83380400001)(31686004)(186003)(53546011)(6506007)(38100700002)(38070700005)(86362001)(31696002)(71200400001)(5660300002)(8936002)(122000001)(43740500002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?VnFJK0NrcTdYbGQ5djQzMm1JUEI3Z2ZueXYwVjJxSXQ3Tm5xcDRoOGFERXdS?=
 =?utf-8?B?MGZGT2dSVCtqUWV5cFBhN0NZR3BlOU4zZysvWkRTYzNoeVZuNTd5dDBwQUV2?=
 =?utf-8?B?N3ErbVltenhtVWZwUi83dmY1NExWbG9ZcGRQRGhJMnJJSWVpYSs2VGI0SUlU?=
 =?utf-8?B?cGl2NWhFK3kxYk9IRHBUOVZoVlJVNUhvUm1iajdUN1h3cFUzVWdqTDlxT2xx?=
 =?utf-8?B?N1pFNjlmcmNSNm1BOVFQdVcyNTY5N1FDTi9KdFNvcU1zWmdQRng4dHYzZGVm?=
 =?utf-8?B?Q3pQSXNXOUVONDFqRHd4a1NxWXN6N1VyeDl5UWw2REdYNkFtQnVpYXpCTFBL?=
 =?utf-8?B?d2JGQmRCeEI3V01oelhSVWV3U3JJdkR3V0xtT0JPZGFDVm5jQ1djZlNHRCtu?=
 =?utf-8?B?SGRHNFFLc3FLSTNEam5hV3VmWXBQTVlVOFhxZlI5bHRrYTgzOE9lYkVXNDJz?=
 =?utf-8?B?YjRsSlozNlo1b3Y1bTlpbHJoN01pUUhYRkFmMXdzUHY5blBuRER2QVJOZFds?=
 =?utf-8?B?MkUvN1Uzc0QrYkhOdldsaDVuODBxZ3FFTmZFMFd3eWFybXFQdWV6YWhpU29N?=
 =?utf-8?B?dDZrSElYZlFWbk10WWZNZGgrZmpaNTAvcCtYNEVtbE8rNko1MlJ4V0ZmZVRH?=
 =?utf-8?B?YmJ3ZEtxMUx0aWthOVU3djZNMU9sRDhXbDRYWkhmU0RNcHgxT0lJM0ZHZ1dE?=
 =?utf-8?B?alBhQVNpWnZpVzJNOGJiMndMQmh4a1kxQVF6bmNnM0VqTk5GTUoxeTRlT01n?=
 =?utf-8?B?STdMZGYvRGxScHVVejE3RHRMalgzdWc3VEtvSkNaQ3VqcHpLd2hLVUZwWTZG?=
 =?utf-8?B?cVdQMGI0OHp5bjZiT0lubmZ0bUQvUVNsVlY1RXh2Ti9ONnFjMm1hdUFuQm9q?=
 =?utf-8?B?Rlh3cW5sMHBuYytsWXV3SkxKbUlvdVpXWGM5Y0szblkvdFF5TGdhVmg0ZXYw?=
 =?utf-8?B?Mmx5Qm5OVEJPVlFYSDhwdjlvWWtraE41bXRhOTN2YWk1am56NysvY0dmZ0d5?=
 =?utf-8?B?dEVZeVFRQWUzYVlISUx0QUw5V3NyaHNOc2NlV1pMNTh6MkdyNFBXTEdTRkRF?=
 =?utf-8?B?L3ArZlBTMUJHS0VUeUhkT0tqS2Q4UFo3dnMzM1pIaHRuakdVb1grWjh4TWZq?=
 =?utf-8?B?ZXl6RWFoNHpGajBmUkJmNnBuWGtUMkZZV2pPWlVPMjd0WGV6bzUvUGkyV1d6?=
 =?utf-8?B?d1dFcWEyOFFEdkQ0MnN0NUM5Ry9XVlhNR3ZUSFhPT0dTYW1FN1FRS25nRGNK?=
 =?utf-8?B?NnZ2bkZHR3JNYWdUYTdxL0hDSmRkV3djZk12bkV5NmJ2SlV2R2xETTg1SURn?=
 =?utf-8?B?QjVBbEQ5NWN3WkxHTVN2amNtRVpYUzRPVm11WWh4SjkyTFd5SzBvQmNuNWJz?=
 =?utf-8?B?a1FDMWp1Zk42dXkvVHVxVGVKbXRDelhRdysyOWtUaGRNR1V1OGZ5N0ZQdHhY?=
 =?utf-8?B?NzZDb0hzTFNqTzVIKzNPU005MU0wL25zK1FFTGdTSDJBWGFxZy9oekdjK0xU?=
 =?utf-8?B?NXlaYWE4NUNiU3lDcjdRb3UrdUZ4NTNkb3p3ZmNRMkVEdGdYdkszTVQzVGth?=
 =?utf-8?B?SHFrcGliLzdKSGtNWHdielRrTWFPK09BRHNlNVBiRThrbm1vK3FYbmNKTXp5?=
 =?utf-8?B?eURnYTM2Si9KeUZ5RWN1d0RtSS9aZjd0TDdmWDJNY1dOTm9XUWQ5MzV1RnY3?=
 =?utf-8?B?cmxmWlVqaHpINjFVTXVjcjVJbVZXUWthSmhQL2JwM2RUZGdKblhDMStFWHdh?=
 =?utf-8?B?ZWlHanlKOWc5N0JuQ29VWTdHVDcvNlNhMnFLR3RVVS8yYjhrZXk3c01MOUZs?=
 =?utf-8?B?VENCdUF0SHFpQXdWUzdONktjZ2drM0tabjExejFHU0hJYm9ldkpXNkluWkNa?=
 =?utf-8?B?SDdwWmRJVDhJMVNrSXpCaVV1RWZPNVExV0w3QjNvZy96bC9MeW5ycVBzZE1m?=
 =?utf-8?B?U1JsZEQ1b3RkQXIxd2ZtNlZ3TUh4cVlldlB0OWxWUHMyeExyQVRFYzhnOC9D?=
 =?utf-8?B?QXk5Z1dxK2lKUzF5SlhxMmtncllUbGQ2ZlUyNlRiM01NeVhmNTNCUUJpRUxQ?=
 =?utf-8?B?dHJPaEFDT2VCM0pYZ0llZEkvWFRXUFl4R1BMbEZzbWlNVjdvOEMxTUhZVzYv?=
 =?utf-8?B?b09hQjlWc3E2U21VWHpTWVYvNWEzK3h2bUlSSGlSVUVjTFN1Q29zK01NdHpv?=
 =?utf-8?B?L3dXRGxjNm0rdWNoOVoxYzRzb05QSk5xUko4cnZQdXFDeXlJSXQrVWhibkU2?=
 =?utf-8?B?Tk94YStCWW9iQUpIUE5ibGpoVDRnPT0=?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <04BE5A74C8310F488E52A50EC656721A@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA2PR11MB4874.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8af20a9f-9c01-40ed-c2ff-08d9ec47509d
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Feb 2022 03:42:08.8360
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: +3mIg3sYe8RA06jZXaN6yAlBT2xQDZmKN7sEdxcguHdfusaCCCElZvWlb/FQiLEu9qqmwZNBiJp6CY1OI7+h3QvjoYlenhPLAVjsa9VtROQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR11MB3824
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gMi8yLzIyIDE2OjU4LCBNaWNoYWVsIFdhbGxlIHdyb3RlOg0KPiBFWFRFUk5BTCBFTUFJTDog
RG8gbm90IGNsaWNrIGxpbmtzIG9yIG9wZW4gYXR0YWNobWVudHMgdW5sZXNzIHlvdSBrbm93IHRo
ZSBjb250ZW50IGlzIHNhZmUNCj4gDQo+IEl0IHR1cm5zIG91dCB0aGF0IG1vc3Qgb2YgdGhlIHNw
ZWNpYWwgc3RhdHVzIHJlZ2lzdGVyIGhhbmRsaW5nIGlzDQo+IHNwZWNpZmljIGZvciBhIHBhcnRp
Y3VsYXIgdmVuZG9yLiBJLmUuIFhpbGlueCBoYXMgc29tZSBkaWZmZXJlbnQNCj4gb3Bjb2RlcyBm
b3IgdGhlIHN0YXR1cyByZWdpc3RlciByZWFkLCBNaWNyb24gaGFzIGFuIGFkZGl0aW9uYWwgRlNS
DQo+IHJlZ2lzdGVyIGFuZCBTcGFuc2lvbiBoYXMgdGhlc2UgZmxhZ3MgaW50ZWdyYXRlZCBpbnRv
IHRoZSBTUi4NCj4gDQo+IENyZWF0ZSBhIGNhbGxiYWNrIHRvIHJlYWR5KCkgd2hlcmUgYSBmbGFz
aCBjaGlwIGNhbiByZWdpc3RlciBpdHMNCj4gb3duIGZ1bmN0aW9uLiBUaGlzIHdpbGwgbGV0IHVz
IG1vdmUgYWxsIHRoZSB2ZW5kb3Igc3BlY2lmaWMgc3R1ZmYNCj4gb3V0IG9mIHRoZSBjb3JlIGlu
dG8gdGhlIHZlbmRvciBtb2R1bGVzLg0KPiANCj4gUGxlYXNlIG5vdGUgdGhhdCB0aGlzIGlzIG9u
bHkgY29tcGlsZS10aW1lIHRlc3RlZC4NCj4gDQo+IEZvciBzYWtlIG9mIGNvbnNpc3RlbmN5IGFu
ZCBiZXR0ZXIgcmVhZGFiaWxpdHkgb2YgdGhlIGNvZGUgZmxvdywNCj4gSSBhbHNvIGNvbnZlcnRl
ZCB0aGUgc2V0dXAoKSBjYWxsYmFjayB0byBiZSBvcHRpb25hbC4NCj4gDQo+IE1pY2hhZWwgV2Fs
bGUgKDE0KToNCj4gICBtdGQ6IHNwaS1ub3I6IGV4cG9ydCBtb3JlIGZ1bmN0aW9uIHRvIGJlIHVz
ZWQgaW4gdmVuZG9yIG1vZHVsZXMNCj4gICBtdGQ6IHNwaS1ub3I6IHNsaWdodGx5IHJlZmFjdG9y
IHRoZSBzcGlfbm9yX3NldHVwKCkNCj4gICBtdGQ6IHNwaS1ub3I6IGFsbG93IGEgZmxhc2ggdG8g
ZGVmaW5lIGl0cyBvd24gcmVhZHkoKSBmdW5jdGlvbg0KPiAgIG10ZDogc3BpLW5vcjogbW92ZSBh
bGwgeGlsaW54IHNwZWNpZmljcyBpbnRvIHhpbGlueC5jDQo+ICAgbXRkOiBzcGktbm9yOiB4aWxp
bng6IHJlbmFtZSB2ZW5kb3Igc3BlY2lmaWMgZnVuY3Rpb25zIGFuZCBkZWZpbmVzDQo+ICAgbXRk
OiBzcGktbm9yOiB4aWxpbng6IGNvcnJlY3QgdGhlIGRlYnVnIG1lc3NhZ2UNCj4gICBtdGQ6IHNw
aS1ub3I6IG1vdmUgYWxsIG1pY3Jvbi1zdCBzcGVjaWZpY3MgaW50byBtaWNyb24tc3QuYw0KPiAg
IG10ZDogc3BpLW5vcjogbWljcm9uLXN0OiBjb252ZXJ0IFVTRV9GU1IgdG8gYSBtYW51ZmFjdHVy
ZXIgZmxhZw0KPiAgIG10ZDogc3BpLW5vcjogbWljcm9uLXN0OiBmaXggbWljcm9uX3N0IHByZWZp
eA0KPiAgIG10ZDogc3BpLW5vcjogbWljcm9uLXN0OiByZW5hbWUgdmVuZG9yIHNwZWNpZmljIGZ1
bmN0aW9ucyBhbmQgZGVmaW5lcw0KPiAgIG10ZDogc3BpLW5vcjogc3BhbnNpb246IHNsaWdodGx5
IHJld29yayBjb250cm9sIGZsb3cgaW4gbGF0ZV9pbml0KCkNCj4gICBtdGQ6IHNwaS1ub3I6IG1v
dmUgYWxsIHNwYW5zaW9uIHNwZWNpZmljcyBpbnRvIHNwYW5zaW9uLmMNCj4gICBtdGQ6IHNwaS1u
b3I6IHNwYW5zaW9uOiBjb252ZXJ0IFVTRV9DTFNSIHRvIGEgbWFudWZhY3R1cmVyIGZsYWcNCj4g
ICBtdGQ6IHNwaS1ub3I6IHJlbnVtYmVyIGZsYWdzDQo+IA0KPiAgZHJpdmVycy9tdGQvc3BpLW5v
ci9jb3JlLmMgICAgICB8IDI2NSArKy0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLQ0KPiAg
ZHJpdmVycy9tdGQvc3BpLW5vci9jb3JlLmggICAgICB8ICA3MCArKysrLS0tLS0NCj4gIGRyaXZl
cnMvbXRkL3NwaS1ub3IvbWljcm9uLXN0LmMgfCAyMjUgKysrKysrKysrKysrKysrKysrKysrKy0t
LS0tDQo+ICBkcml2ZXJzL210ZC9zcGktbm9yL3NwYW5zaW9uLmMgIHwgMTMzICsrKysrKysrKysr
Ky0tLS0NCj4gIGRyaXZlcnMvbXRkL3NwaS1ub3IveGlsaW54LmMgICAgfCAgNzkgKysrKysrKysr
LQ0KPiAgaW5jbHVkZS9saW51eC9tdGQvc3BpLW5vci5oICAgICB8ICAxOCAtLS0NCj4gIDYgZmls
ZXMgY2hhbmdlZCwgNDE3IGluc2VydGlvbnMoKyksIDM3MyBkZWxldGlvbnMoLSkNCj4gDQoNCkdv
b2Qgam9iLCBNaWNoYWVsISBJIGFkZGVkIFItYiB0byBzb21lIHBhdGNoZXMgdG8gaW5mb3JtIHlv
dSB0aGF0IHRoZXkNCmxvb2sgZmluZSB0byBtZS4gWW91IGRvbid0IG5lZWQgdG8gYWRkIHRoZSB0
YWdzIG9uIHRoZSBuZXh0IHZlcnNpb24sIGFzDQpJJ2xsIGJlIHRoZSBvbmUgdGhhdCB3aWxsIGFw
cGx5IHRoZW0uIEkgdGhpbmsgSSBoYXZlIGEgbWljcm9uIGFuZCBhIHNwYW5zaW9uDQpmbGFzaCBz
b21ld2hlcmUsIHdpbGwgdHJ5IHRvIHRlc3QgeW91ciBzZXJpZXMgb25jZSB2MiBpcyBvdXQuDQoN
CkNoZWVycywNCnRhDQo=
