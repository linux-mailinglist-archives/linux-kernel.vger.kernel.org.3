Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ADB95554327
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Jun 2022 09:04:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349332AbiFVGpM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Jun 2022 02:45:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346353AbiFVGpJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jun 2022 02:45:09 -0400
X-Greylist: delayed 306 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Tue, 21 Jun 2022 23:45:08 PDT
Received: from de-smtp-delivery-113.mimecast.com (de-smtp-delivery-113.mimecast.com [194.104.111.113])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 35FBE34678
        for <linux-kernel@vger.kernel.org>; Tue, 21 Jun 2022 23:45:07 -0700 (PDT)
Received: from CHE01-GV0-obe.outbound.protection.outlook.com
 (mail-gv0che01lp2040.outbound.protection.outlook.com [104.47.22.40]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 de-mta-33-Mm2W_fWMOdaMfLOIRUPAlQ-1; Wed, 22 Jun 2022 08:38:09 +0200
X-MC-Unique: Mm2W_fWMOdaMfLOIRUPAlQ-1
Received: from GVAP278MB0929.CHEP278.PROD.OUTLOOK.COM (2603:10a6:710:57::6) by
 ZR0P278MB0604.CHEP278.PROD.OUTLOOK.COM (2603:10a6:910:3b::10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5353.15; Wed, 22 Jun 2022 06:38:06 +0000
Received: from GVAP278MB0929.CHEP278.PROD.OUTLOOK.COM
 ([fe80::7b:8f0a:1d7:60f2]) by GVAP278MB0929.CHEP278.PROD.OUTLOOK.COM
 ([fe80::7b:8f0a:1d7:60f2%5]) with mapi id 15.20.5353.022; Wed, 22 Jun 2022
 06:38:06 +0000
Message-ID: <7d04c05771ded0f8302d716fa5289d94df27c8eb.camel@toradex.com>
Subject: Re: [PATCH v1] arm64: dts: imx8mm-verdin: update CAN clock to 40MHz
From:   Andrejs Cainikovs <andrejs.cainikovs@toradex.com>
To:     Marc Kleine-Budde <mkl@pengutronix.de>,
        Francesco Dolcini <francesco.dolcini@toradex.com>
Cc:     Shawn Guo <shawnguo@kernel.org>, devicetree@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        linux-kernel@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        NXP Linux Team <linux-imx@nxp.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        linux-arm-kernel@lists.infradead.org
Date:   Wed, 22 Jun 2022 08:38:04 +0200
In-Reply-To: <20220621195046.rnv66d2333wjmtow@pengutronix.de>
References: <20220512104019.19725-1-andrejs.cainikovs@toradex.com>
         <20220621180749.GA22098@francesco-nb.int.toradex.com>
         <20220621195046.rnv66d2333wjmtow@pengutronix.de>
User-Agent: Evolution 3.44.1-0ubuntu1
X-ClientProxiedBy: GV0P278CA0066.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:710:2a::17) To GVAP278MB0929.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:710:57::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 3191f2a8-3eda-4d9e-bcb1-08da5419c3ce
X-MS-TrafficTypeDiagnostic: ZR0P278MB0604:EE_
X-Microsoft-Antispam-PRVS: <ZR0P278MB0604BDE48074DC4CA0591825E2B29@ZR0P278MB0604.CHEP278.PROD.OUTLOOK.COM>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0
X-Microsoft-Antispam-Message-Info: 3yAaYGoCobPe7xzqXYzab7SVM+K5He0FUeWaheTP2VJtC15gmKkbPOLGAP607y0f60FChq9ufAVUn/MqPHeU7wAy11dLd6lLGwt1+1U7T5wQx39gOvHyLGfrDPKHao+n9a/ai1jvCTTV89E1DkW7J1APFtYpLaX+og+p83un+Grx+tel47K4gn0BkIh3S3LfeuifROQECmOgA9+PMl7AgOybTOETFnMGve5Y42wmY0RX+N8HyYLbcGD8onUyL5uNEmJ9Vnj7C7gaKdDHm04yZwfHW4tAoUfJEo6VLsRezxJVZ5/JFHiVc4Gn7AaHtXKcD86R8979vaP1+ctqQPd3dMK03RDwUdFMjgatFp45fKZsMsMpfXMBOGib9bxPDcnv5BKTWoiaMUqXdF6g4mCk25rD6y45+Zn7b2CULhgOK0UpjPg3ZNAcqhLduPHPezod6PCzwNuLi3/tEdqtok7v/LPLd6exIUDUyXXFDCZprL6xS5h9gQa18TLduNOzYs9y3Bup2y7IQ1EYWxSga3gxlQmyQQs05e/VcduPVXziL/n77MxgRra/o07b8uACXODsO4enBeVr4RWAx9xqsKjvnEQOCwqEouC3TDAVxWhNvDrsWJ3hfd3jUc9sVWMovEAzy1+uFUt/YQ11WUdvv3LhZ0hSfxcLxRjAD5Y9QWdhMf7RsiQPiVB7qOi6uqYHnYVtpS6UwRNZM8gxndjWuv7H+vj3+Um3rA+LGj9avs4U4yF6aacBQMlXQl0m1yXGHyq1iLJaRV1iBqqDfAsvv/SCdQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GVAP278MB0929.CHEP278.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230016)(4636009)(376002)(366004)(136003)(396003)(39840400004)(346002)(6486002)(54906003)(36756003)(316002)(6636002)(478600001)(4326008)(66556008)(8676002)(110136005)(2906002)(83380400001)(38350700002)(44832011)(66476007)(5660300002)(7416002)(15650500001)(52116002)(8936002)(2616005)(41300700001)(53546011)(186003)(6506007)(26005)(38100700002)(86362001)(6512007)(66946007)(32563001);DIR:OUT;SFP:1102
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZUphZmlZQitVTENOK0FtNW44QVJnZTUxRk1pSmpkc3VycFcrQ1NJNTR5em14?=
 =?utf-8?B?M0FOcGxkQnpYSmZ1aU9RSXdlMFVxUzFCNlBoZGFYdUt0MUx3eGhqRGJOakps?=
 =?utf-8?B?NFlGN3dIQnNjWXQ4V2dCWCtvVTNJbjFLTTdqZjJhME03anpka2VxUVpleG40?=
 =?utf-8?B?enBPWndhLzRzR0YrOXRIN0ZsdnpwOGE2N213OHRWYVY1cjBsOTZGenhBcW12?=
 =?utf-8?B?SmJBcVkrYmhTNWYybFJzY3NlbVlZaHJBK0VnQVJHSThiREkzcEdSL3hmMytL?=
 =?utf-8?B?Qzd5S1o5Wkp2NUlNQWJmbzROZU9MSmN6NGsrSDRSKzNtUDliSDRkSllJb2w4?=
 =?utf-8?B?YnE2ZUxmZ21GNittcWJhQ1AxbkJrN2tSaVRNMjFTYkl1SW94MWdXK2xBbTAz?=
 =?utf-8?B?bGhnK0xMRU0wZjJXMDlnNTJPMFZWZWgrRUlCUDZ5SlFOSnBIYUxkOHZWd3o3?=
 =?utf-8?B?ajUyTVZHRTh6TUwvRHpjUTdCRStjdWhtZ3hsTVVhTEQwdU1SY1RHd1Vvd29Y?=
 =?utf-8?B?eGVEbFZBRWFmVkpBeVVJSnVSRkhOekNVSHhlTVNRTm91WTE1ejRpMTBDczdT?=
 =?utf-8?B?dUtmQVdTWENMSm95RGJGZjdNZ3NKUG1hV09idlMyT1o2WVpkM2w0RWg5UWZN?=
 =?utf-8?B?OUI2WCt5QVppTmQwK1lHV1RJdENHSzR2YUR2MmNrVzNscmlYOVlxRjJFMmNX?=
 =?utf-8?B?UnVzenFONW9JSkNwNnRDM21kcnZnSzErNVBuNEIxTSs2blV5Y0xSeTc5UURo?=
 =?utf-8?B?SnpMbi9xbUdxd0hHd2J4bG1RRmlIYmN5dDFGYXVhVURCTlBibyt6ZkI3Q0E3?=
 =?utf-8?B?Y0E3T3g3YlJZWjl0VGJjdkVYSFBMaTJvOVRRUWw5WFZZSGd2cUxYQ2RrTGJ5?=
 =?utf-8?B?YnVPQjlRK2g3WjFpSG5TWGxLekIzV3RqNWQ4dlNtUURnY3ZBQjFYaU5KUHV1?=
 =?utf-8?B?RG5vM0d2RGZreVNsMUxGWGl6US9oMllJY2UzUXpLbGtPRVltd2ttb29JTHVL?=
 =?utf-8?B?OEZmNjBXN3hLZkpHcDR4dHU4UVdxcllndlRaSmt0T1F3TlRXS21rVEFTY1NT?=
 =?utf-8?B?d1hWSjJsalRqcG9OQjlVQ0N5dU81MTZ5UDJzWlhSWHJxMTFOUzdnUEdLYlJG?=
 =?utf-8?B?ZXlTTHFXSldRSm1pYVpjNHlLWUg4S2d6WllyOTFJQUVnaEFZUzBlSGw4RTN5?=
 =?utf-8?B?ME5GM2JFUUdSd2hZWkEvcktKRGYvNVY1ZlFLblVDVktUWEtPVmg1d2NBYXoz?=
 =?utf-8?B?MVkwc1EvZ2t2MlBtKzVIbjRUL2lKMWJFeFNmbjhyc2VOazIyN1hXMDBVUmhq?=
 =?utf-8?B?NEg3ekp1eTdLK0tSYjVvbmhZclYycG9yR1JCYWFiMEVIVVBQc1l4Ry9aVEQz?=
 =?utf-8?B?RnYyWEJtU2RlL3ZKMWxGcFN0bHNxdTdBYmlmelQ5c29lQ0RhSlVPNVdKZ01K?=
 =?utf-8?B?bU0vM0FvT0hjQkVHS1VveVBBYm00TElWejVLZGJxSEJ0V2FPaTYvUWkyNHdW?=
 =?utf-8?B?MEliYnVMQzFzUjhqOXlVektjWG5KNDlCVDFpR0J3T1IrUTlnN09ocFRpdVpB?=
 =?utf-8?B?ako3Tk0vbjhCZ2svbTRENG9HWE01OTNUTUVxRkJ0M1MzMW1ueXFZNnlCeWRK?=
 =?utf-8?B?R3pDNk1TN3NHc3JFTmU1UjltRGJZMWJ6V0hSb3VhWEdrQ1ZQak5iTHRWTHoz?=
 =?utf-8?B?L0w5WUZzNWtlbWpQSDV0SlM5Sm5EbEtueWlhbWk4YUpxMU0xMFJJSkVqdFVa?=
 =?utf-8?B?NzdJUWducE9QYUVma1RqaGxlZS82L0hhc1FuY2g1NzJYVXo0Z2xXZ2loQnRI?=
 =?utf-8?B?YTJ4SzlqbUdGWDRaVkc5TDE0ci8yVUg4amlMbXVhSTlGNjE4VTRxOHlVQ04w?=
 =?utf-8?B?cEdHSGZXVFlhY1RpeThQTW8xVitFQ1RVYVMxN3BZUHFIcXJNNHh2M09ENkxx?=
 =?utf-8?B?MTFTTVhTQllBa0xhVlRwTWQ4ZytBZkQ4UW5xYVZjWDBKM09ncDZDcm00alJK?=
 =?utf-8?B?WlhOcTlmbERhMEtGb1hNT09LdUFIcWVpemtmcThDZTZ6bWdwZ3dBNnRBTTVo?=
 =?utf-8?B?d1lXbnZpa0wxNWxFWTZlMVhkTkJ6VEF5SUtFTzhNZWh6S1prU3NteUsydWlS?=
 =?utf-8?B?MGJ0eGFJQyt6TFpxdC9UZS9iNE9RdFkzZHNJTzhLcEVOZWZWWGZGYVVVaVFj?=
 =?utf-8?B?T2JNN0x0cjRaNk94cmo2U3EySE5ZZFRMNGtRSE0zMnlnWTNvN3pnUHpia2hN?=
 =?utf-8?B?NVI0bCtDNkFZcGdjVnkwVGlwcloxRFBEZk1CZWc0bWR5NUNEc1pySW1pLzJp?=
 =?utf-8?B?bXlRUHpvdHpqT0Q0a1YzNm1zK0FyUjNQVVFZMExwMW0xTFhEdkZQQ3MzNnEx?=
 =?utf-8?Q?WZ4qEpljoH4ZsNYY=3D?=
X-OriginatorOrg: toradex.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3191f2a8-3eda-4d9e-bcb1-08da5419c3ce
X-MS-Exchange-CrossTenant-AuthSource: GVAP278MB0929.CHEP278.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jun 2022 06:38:06.4242
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: d9995866-0d9b-4251-8315-093f062abab4
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XwisvlwFFnqPfYRohmI8utQ7jWAbDZ5wF8jwR/IIh8PUdPS2wjqETiaIlECdldM+jhzp+T0qpYMbz9OIxCPMB5nE+5NlzLdZPsOKQEXkjJY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: ZR0P278MB0604
Authentication-Results: relay.mimecast.com;
        auth=pass smtp.auth=CDE13A77 smtp.mailfrom=andrejs.cainikovs@toradex.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: toradex.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: base64
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gVHVlLCAyMDIyLTA2LTIxIGF0IDIxOjUwICswMjAwLCBNYXJjIEtsZWluZS1CdWRkZSB3cm90
ZToKPiBPbiAyMS4wNi4yMDIyIDIwOjA3OjQ5LCBGcmFuY2VzY28gRG9sY2luaSB3cm90ZToKPiA+
IEhlbGxvIFNoYXduLCBqdXN0IGEgcGluZyBvbiB0aGlzLgo+ID4gCj4gPiBGcmFuY2VzY28KPiA+
IAo+ID4gT24gVGh1LCBNYXkgMTIsIDIwMjIgYXQgMTI6NDA6MTlQTSArMDIwMCwgQW5kcmVqcyBD
YWluaWtvdnMgd3JvdGU6Cj4gPiA+IFVwZGF0ZSBTUEkgQ0FOIGNvbnRyb2xsZXIgY2xvY2sgdG8g
bWF0Y2ggY3VycmVudCBoYXJkd2FyZSBkZXNpZ24uCj4gPiA+IAo+ID4gPiBTaWduZWQtb2ZmLWJ5
OiBBbmRyZWpzIENhaW5pa292cyA8YW5kcmVqcy5jYWluaWtvdnNAdG9yYWRleC5jb20+Cj4gPiA+
IC0tLQo+ID4gPiDCoGFyY2gvYXJtNjQvYm9vdC9kdHMvZnJlZXNjYWxlL2lteDhtbS12ZXJkaW4u
ZHRzaSB8IDYgKysrLS0tCj4gPiA+IMKgMSBmaWxlIGNoYW5nZWQsIDMgaW5zZXJ0aW9ucygrKSwg
MyBkZWxldGlvbnMoLSkKPiA+ID4gCj4gPiA+IGRpZmYgLS1naXQgYS9hcmNoL2FybTY0L2Jvb3Qv
ZHRzL2ZyZWVzY2FsZS9pbXg4bW0tdmVyZGluLmR0c2kKPiA+ID4gYi9hcmNoL2FybTY0L2Jvb3Qv
ZHRzL2ZyZWVzY2FsZS9pbXg4bW0tdmVyZGluLmR0c2kKPiA+ID4gaW5kZXggMGQ4NGQyOWU3MGYx
Li5kMzA5YmMwYWI4ZjYgMTAwNjQ0Cj4gPiA+IC0tLSBhL2FyY2gvYXJtNjQvYm9vdC9kdHMvZnJl
ZXNjYWxlL2lteDhtbS12ZXJkaW4uZHRzaQo+ID4gPiArKysgYi9hcmNoL2FybTY0L2Jvb3QvZHRz
L2ZyZWVzY2FsZS9pbXg4bW0tdmVyZGluLmR0c2kKPiA+ID4gQEAgLTMyLDEwICszMiwxMCBAQCBi
YWNrbGlnaHQ6IGJhY2tsaWdodCB7Cj4gPiA+IMKgwqDCoMKgwqDCoMKgwqB9Owo+ID4gPiDCoAo+
ID4gPiDCoMKgwqDCoMKgwqDCoMKgLyogRml4ZWQgY2xvY2sgZGVkaWNhdGVkIHRvIFNQSSBDQU4g
Y29udHJvbGxlciAqLwo+ID4gPiAtwqDCoMKgwqDCoMKgwqBjbGsyMG06IG9zY2lsbGF0b3Igewo+
ID4gPiArwqDCoMKgwqDCoMKgwqBjbGs0MG06IG9zY2lsbGF0b3Igewo+ID4gPiDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoGNvbXBhdGlibGUgPSAiZml4ZWQtY2xvY2siOwo+ID4gPiDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCNjbG9jay1jZWxscyA9IDwwPjsKPiA+ID4g
LcKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoGNsb2NrLWZyZXF1ZW5jeSA9IDwyMDAwMDAw
MD47Cj4gPiA+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqBjbG9jay1mcmVxdWVuY3kg
PSA8NDAwMDAwMDA+Owo+ID4gPiDCoMKgwqDCoMKgwqDCoMKgfTsKPiA+ID4gwqAKPiA+ID4gwqDC
oMKgwqDCoMKgwqDCoGdwaW8ta2V5cyB7Cj4gPiA+IEBAIC0xOTQsNyArMTk0LDcgQEAgJmVjc3Bp
MyB7Cj4gPiA+IMKgCj4gPiA+IMKgwqDCoMKgwqDCoMKgwqBjYW4xOiBjYW5AMCB7Cj4gPiA+IMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgY29tcGF0aWJsZSA9ICJtaWNyb2NoaXAsbWNw
MjUxeGZkIjsKPiA+ID4gLcKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoGNsb2NrcyA9IDwm
Y2xrMjBtPjsKPiA+ID4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoGNsb2NrcyA9IDwm
Y2xrNDBtPjsKPiA+ID4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqBpbnRlcnJ1cHRz
LWV4dGVuZGVkID0gPCZncGlvMSA2Cj4gPiA+IElSUV9UWVBFX0VER0VfRkFMTElORz47Cj4gCj4g
WW91IGRvbid0IHdhbnQgdG8gdXNlIGFuIGVkZ2UgdHJpZ2dlcmVkIGludGVycnVwdCB3aXRoIHRo
ZSBtY3AyNTF4ZmQKPiBjaGlwLiBZb3Ugd2lsbCBiZSBsb3NpbmcgaW50ZXJydXB0cywgYmV0dGVy
IHVzZSBJUlFfVFlQRV9MRVZFTF9MT1cuCj4gCj4gcmVnYXJkcywKPiBNYXJjCj4gCkhpIE1hcmMs
CgpUaGlzIHBhcnRpY3VsYXIgY2hhbmdlIGlzIG5vdCBhYm91dCBpbnRlcnJ1cHRzLiBCdXQgdGhh
bmtzIGZvciBhIGhpbnQsCkknbGwgbWFrZSBzdXJlIHRoaXMgaXMgYWRkcmVzc2VkLgoKQmVzdCBy
ZWdhcmRzLApBbmRyZWpzIENhaW5pa292cy4K

