Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AFB2F4694BA
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Dec 2021 12:05:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242200AbhLFLJI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Dec 2021 06:09:08 -0500
Received: from mail-eopbgr100133.outbound.protection.outlook.com ([40.107.10.133]:16160
        "EHLO GBR01-LO2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S240342AbhLFLJG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Dec 2021 06:09:06 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ME9w8YII1ooRQX/CoFL8yCzQrbCvWHPcotIXKWJrBiWpzj2UDElLDTgjaItmaDI5VH46fi4gFVVNUotchJZcql0XmevsKp0Uaqo8AkYTCEtn/y1iYSmG8VlhExcJBwJuBa9WQGVqgsbAvtPsUD6LsPmvQUm7sGIxAdWuNblfu3NGkNAmSKQcsQHz5p3C01x9WU0PeYhCOw99yq2l1jePI/37kUEl+EktL6wtsdz5bP/t4M8Vh3Zme7DY50LTCeA6ZuNanM0W24gQ89Gpif3sNSwymIQ9YoB1M9sO/NAMflBJCRdbmU3ECAMzqOMnejcCWnHo4yH1peZa7HHh+4aeBQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2YCCU76isRkGdz/uwCM6Nu6uQdzp3y6XhPXw3s71hGk=;
 b=I0SrUevyyqgLhmrkUlH+L69NzLQjZN6gfdsWzRgjxbxCoHv6uzrOebC2x8wNLl/buba0HZCTwXDRs0ArqlcyL0P2XpQhNA5qwyRRgLKIoAqnE5c1qmmYS3bklGj/Q0MEvjtA9Tglm0pTJSSEJGKSIQJto08RBYfegO6/U1K0Jyn+dsLPi+T05fQX2ineZIIOda24lHRF3Rfh+3kR9dMgWY4pj2UPUPybguCBZn9JP9Ng9qd8GKV6bnXlHE0bW07PQJhyJ/Ka71FlhzvOA0CX7jggFsPKtrA9OySLCIgPzzmBQgukC3yIpksZvyPynlg0G+XYfvHyPGSFfz34EDBl9A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=sancloud.com; dmarc=pass action=none header.from=sancloud.com;
 dkim=pass header.d=sancloud.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sancloud.onmicrosoft.com; s=selector2-sancloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2YCCU76isRkGdz/uwCM6Nu6uQdzp3y6XhPXw3s71hGk=;
 b=Whe5zYg8QzzryfOnvFHROa+OYQVVSUvls3v+SacuFWLdMEvZxaRfwZtr4fEruTMkuuX52W4SRse1VBMPK73UwQkoIBbd8TNy0lKMBPWZ45RLshm6TG5Ylnoxm0QQJSTmtKPig571KlXfOtfwzJUDAS+YxUXFCuwzb1DDlwExmIQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=sancloud.com;
Received: from CWLP123MB2241.GBRP123.PROD.OUTLOOK.COM (2603:10a6:401:61::19)
 by CWLP123MB2739.GBRP123.PROD.OUTLOOK.COM (2603:10a6:400:52::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4755.11; Mon, 6 Dec
 2021 11:05:36 +0000
Received: from CWLP123MB2241.GBRP123.PROD.OUTLOOK.COM
 ([fe80::e5f8:24f0:cbd5:d755]) by CWLP123MB2241.GBRP123.PROD.OUTLOOK.COM
 ([fe80::e5f8:24f0:cbd5:d755%7]) with mapi id 15.20.4755.022; Mon, 6 Dec 2021
 11:05:36 +0000
Message-ID: <5ca267ee-da67-e325-657b-10bce5df526c@sancloud.com>
Date:   Mon, 6 Dec 2021 11:05:34 +0000
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.2
Subject: Re: [PATCH 4/4] mtd: spi-nor: micron-st: add mt25qu128abb and
 mt25ql128abb
To:     shiva.linuxworks@gmail.com, tudor.ambarus@microchip.com,
        michael@walle.cc, p.yadav@ti.com, miquel.raynal@bootlin.com,
        richard@nod.at, vigneshr@ti.com
Cc:     linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org,
        Shivamurthy Shastri <sshivamurthy@micron.com>
References: <20211027103352.8879-1-sshivamurthy@micron.com>
 <20211027103352.8879-5-sshivamurthy@micron.com>
From:   Paul Barker <paul.barker@sancloud.com>
In-Reply-To: <20211027103352.8879-5-sshivamurthy@micron.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------2eFtnstfQeWXeQOnjq9U7EaL"
X-ClientProxiedBy: LO2P265CA0379.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:a3::31) To CWLP123MB2241.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:401:61::19)
MIME-Version: 1.0
Received: from [10.0.0.90] (80.7.160.81) by LO2P265CA0379.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:a3::31) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4755.17 via Frontend Transport; Mon, 6 Dec 2021 11:05:36 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: db057dc0-9765-4389-9c23-08d9b8a854ad
X-MS-TrafficTypeDiagnostic: CWLP123MB2739:EE_
X-Microsoft-Antispam-PRVS: <CWLP123MB27394DE66C5A5153DB59191B936D9@CWLP123MB2739.GBRP123.PROD.OUTLOOK.COM>
X-MS-Oob-TLC-OOBClassifiers: OLM:4303;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: eTlUWeAMNlgBGa2O7HVv65CfphBS18R0vhS5KJz+dhqx9Ty4TjVzfKap6JL07O/dgnDneCfw8jkE8S3XEjy8c7Xj+5rfAtW7zsW5xqeEvaexkNr06B36PzEjPpRK4XUDux5xrZVvNpCwEql+T0BnxCy+Xjgff1Ng1gqr3fxGTEm8iLWR/inFnPdzBJjmf6iL3Ifbdum3tC6kN2VhGadfznx16z3I1ZEQm+yogDrSea7SkwoKbC4wiRBFKWPbp9vvfF0nMl1yuvq2MDKTqb+kkaEu7A95aYtwJpzV2y/hjMhIgD1+gF0OiAH8qSbXA/dl7VaDcJA6IaoXx5kLhoKFS/eoKAr5iKuog2vkPeuOdDDdiI+oXBTAV/uiJT2o/pF8HnLH/hmV2SYSN+vWehZ2pfCYV5FmUcbBFQ09kxyjC2po2sLMoMNOT8hFog0DKQIIwl46gV/L7bV/KskMlKWisU2W0uiHIVZWUq927L3kBtZ/B1TZj8F1/d6rabYneUJ0PyfXtaRVaH7PfUfQtErg9VuXN/mMtrk3seOmvCdnO96a4o/TZJTz007bD0WqcQj4/vhvOCyyJwaLl/oZCmyzjfMxN1RJQxKISRgB/ITqkzRgkNcubIKpxf+gvsywD3LypuXAEfn28lcj+7p3IpAlEYnbJ6nAgOLebr/VEN7k+qPEBminmVEhj0kms6fCIdXl3zFLW4ydct45yLvX6kzllIDnuDcClVUnzGF9Fu0R7I78sw+cnyYnbh8JQ2owPgluBqDIsMBYbMFDN4+DNWJtccvacIQA+/0MUr82XOpHLCBc6HI/BZ8y2L26+9yb4vDg3FTaSt99JypufB3PGno9V4OlLSaa5W+ObYOzleZXxR1qlzJTaXAttoH+FDlpEuml
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CWLP123MB2241.GBRP123.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(396003)(136003)(376002)(346002)(39830400003)(366004)(16576012)(4326008)(5660300002)(7416002)(2906002)(966005)(508600001)(38100700002)(83380400001)(38350700002)(36756003)(21480400003)(31686004)(44832011)(31696002)(8936002)(2616005)(53546011)(52116002)(26005)(316002)(33964004)(8676002)(86362001)(956004)(186003)(66556008)(66946007)(66476007)(6486002)(235185007)(138113003)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TXBXbncvM0xFWGt5VUVGdWh1ZnpiQUdzeTlZbGhYYmJaWEpNQVY4bEJDbVhI?=
 =?utf-8?B?UVR0Wk9lS1plY05vS2hPQ0hJd0ZsRXFrSVFBazBPTzB3Snp5TjM1REFQZEJx?=
 =?utf-8?B?TkMrNm9TcFRyT1l4UVd0cUJablRrbUVGK0UvaitmcWtsdmdzcXdqeGxlTThN?=
 =?utf-8?B?N0FKU0E0N3dmV2huaW5OTVhqV21HdVFMMXgzTUFtYXpUS1FqYktxekVhZVIr?=
 =?utf-8?B?ZDV2VHRDbndTLzh6R0tieXN1c2hDR0VIK0JlRDZTSjBXRUNvSXcwdmkvK05Q?=
 =?utf-8?B?Z2FSSlQ2NS9kYmwvNXRPcngvT2VYU1hseURqY0RGemt6bFhXY3pJVGF3Rm5r?=
 =?utf-8?B?OTk3WkFQZlVhR3lZOGJ1Zi9zbUhObnRIai9zeDNZWDZxQUZVdW1jMmJLaGVh?=
 =?utf-8?B?amg0VjZzUHdqWnhTWmQ4MThyNmgvODJvV0oyMWF4ci9aSldVdG93eGVvbGsv?=
 =?utf-8?B?UmtwTE02TERvUVRrMjlWUWlJRnBzTVdxTTNveTdQcFZoMkFaYVBjRXdxTWQr?=
 =?utf-8?B?d0thYVIvVFZVdmwzYjVOSzY0alFHVThxUnJYdDh5enBzSVlvTkhoVC9pRGIx?=
 =?utf-8?B?T2liUkt2MENGQ0dNc1FLbmh6Y0N5akJuUUZHeFJUL3VYZDNkKzRqWm9Rc2s5?=
 =?utf-8?B?TEg1NnFzWWpWUlRxeDNEekpRR0pFZHV5cWJkN1k1T1M0SzJSN0h1NXVCQzlq?=
 =?utf-8?B?d2tic1NkOVVrajVDUkhRLzY3U3VyYTVzM0Z3VGExSk1Kb1g0bzJjeDJMbTRj?=
 =?utf-8?B?TlFIaTZ0LzRZVHpyV3FvWlpKYVUxRmQwMERucElVRU13WUpydERldFNSUTJB?=
 =?utf-8?B?Y3A3aGJtR1pDRVV3T1VrWmt6RFhwak9TcnkrRXNnTlJKZHVhTldBOXVrd21P?=
 =?utf-8?B?NEE1TWZZR1R1eElsaWM5Zk51aHdZc3JmYVNpNzhhZjM2NDFHRFFTSE5CMHdB?=
 =?utf-8?B?cHg4ZmZEbmFVZTN1R3pMbnkyVmxrSFlVN25qTmZBVXJ3QzI1S2VGUEdkd3ps?=
 =?utf-8?B?c0lmRXQxM3haSngrZyt1allQMW55R05oQkxhSysyTVppUFVUdmJ2M0FSZkFx?=
 =?utf-8?B?WEF5OHNXOVRMNTRlZlkrSUhXbm9zbUJmR093Vnp3bk1pbi9FeWNkZm9WMzdi?=
 =?utf-8?B?Rzk4bjBLVGI0OUJjS05QNXNaR2huYkhyNWRJRkt4elB6K1RKM1ZpeG9Bb0h3?=
 =?utf-8?B?VlVVOVp6cVdGNHNXTTBqcm0vSHJSc2hPSXhrdEVpTVR6UVp3UVZEd0xGK1U0?=
 =?utf-8?B?MjN6cXF0RzhlSHRZTzlSSjNzUWJsOHdpaUhuUkVWeVN1NWFLOGQ2VElDY1Ni?=
 =?utf-8?B?UFMzeEhxeDJFK3M2Yko5dEx0elI4MTFNM1cyeXRmbENXRlYxSExGanZ2a0s4?=
 =?utf-8?B?dklKOTFvZVpRVVpFOTRiNGxicENMZUw4NEF5ejh1V292dEs3cjN1Q053TXdB?=
 =?utf-8?B?dzFvdlBhejBwelZJVEdtbjdPVEtuUDZOMHI0SHpWRkE1eCtxcndoUGE0eXhS?=
 =?utf-8?B?d0ZtdDk2aGVvWGNPRlhydXc1SUxYYXVVcmxRbm5hU3lQSUpiVDBIK0ZEajZS?=
 =?utf-8?B?UFpaVFl4K280S0ZqakVuYlhhZkUzcEt3OFUxZkZVT3V3MVIwaDhYQ2NEVklK?=
 =?utf-8?B?L1l6Z3poMkp3Nk81SFhKZTVpd0tmdDRhckM4YlpsV1VENlIvdWxON0tHTm5I?=
 =?utf-8?B?aWwzM0JHZ1JMcUlkY3ZOZXdhRHB5aWJpZUlwMTkzMXpOUzdtdzZiSkNQcy9p?=
 =?utf-8?B?MURxRTJKWkwxWU9mN1VsUE55K0FYK1JWK2w1M1hCQTgyM1p5M016UVh5RVB6?=
 =?utf-8?B?ekZ4L1ZQTmdYQ2lxTk1LK0VVSmNoeUhYN25KZDZQSExtS1Y5WTFPb3lkV0dM?=
 =?utf-8?B?UjVZaThrVXlaS3doY0U3TXhiQUNNSURQVDQ0VGVhb0pPQUg0aXU1OXBxUFl5?=
 =?utf-8?B?ZlQzYVZxVjVTZkVJSEV4dzFmZE1PM0NKR0NrTzRNYW1sZzllTW9vVTlnbnpV?=
 =?utf-8?B?MDdLNWFVZTJsS2p5d2tSci8zdW11T1FwUkxiZFB6WVRVMnVJK3l2TnpCaWpp?=
 =?utf-8?B?L3dLZWwrdHdUQTBmcmxpUDBHeVBjb3dKWVdydit4NGNMci9JUVRTNjN4Y2pK?=
 =?utf-8?B?eDJtdlZ4eHVPbmozVVAzQnQ3WTZ0ZUpwWnlCRWZKYmFyTzI1YjZmQTI0dWU4?=
 =?utf-8?B?cUhubklmMGdOTGtIb0NIa2xYdXZrOWJJK1pLWEpRbzA0VENsbEc4L2gyZ3NM?=
 =?utf-8?B?eCtsa1VCN3FlRUlDaDRRcFh5dndBPT0=?=
X-OriginatorOrg: sancloud.com
X-MS-Exchange-CrossTenant-Network-Message-Id: db057dc0-9765-4389-9c23-08d9b8a854ad
X-MS-Exchange-CrossTenant-AuthSource: CWLP123MB2241.GBRP123.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Dec 2021 11:05:36.6155
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 840be37c-244a-450e-9bcc-2064862de1f4
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2YLj8ZYwcuGQlF1r8fIdiAitXEWHgy4Y8HJKidpUtgUO5R8Nllb7yPUGdFa1JtuesADIKeh+NGwwg8KWSm4qrBN0bQgZDfd27lfpZXOgbys=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CWLP123MB2739
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--------------2eFtnstfQeWXeQOnjq9U7EaL
Content-Type: multipart/mixed; boundary="------------Mv0krmr33OC0iAA3wMCMqBSH";
 protected-headers="v1"
From: Paul Barker <paul.barker@sancloud.com>
To: shiva.linuxworks@gmail.com, tudor.ambarus@microchip.com,
 michael@walle.cc, p.yadav@ti.com, miquel.raynal@bootlin.com, richard@nod.at,
 vigneshr@ti.com
Cc: linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org,
 Shivamurthy Shastri <sshivamurthy@micron.com>
Message-ID: <5ca267ee-da67-e325-657b-10bce5df526c@sancloud.com>
Subject: Re: [PATCH 4/4] mtd: spi-nor: micron-st: add mt25qu128abb and
 mt25ql128abb
References: <20211027103352.8879-1-sshivamurthy@micron.com>
 <20211027103352.8879-5-sshivamurthy@micron.com>
In-Reply-To: <20211027103352.8879-5-sshivamurthy@micron.com>

--------------Mv0krmr33OC0iAA3wMCMqBSH
Content-Type: multipart/mixed; boundary="------------223ZAcIgnMnW3h47YPKgu5VX"

--------------223ZAcIgnMnW3h47YPKgu5VX
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64

T24gMjcvMTAvMjAyMSAxMTozMywgc2hpdmEubGludXh3b3Jrc0BnbWFpbC5jb20gd3JvdGU6
DQo+IEZyb206IFNoaXZhbXVydGh5IFNoYXN0cmkgPHNzaGl2YW11cnRoeUBtaWNyb24uY29t
Pg0KPiANCj4gQWRkZWQgbmV3IE1pY3JvbiBTUEkgTk9SIGZsYXNoZXMgdG8gc3RydWN0dXJl
IGZsYXNoX2luZm8sIHdoaWNoIHN1cHBvcnRzDQo+IGFkdmFuY2VkIHByb3RlY3Rpb24gYW5k
IHNlY3VyaXR5IGZlYXR1cmVzLg0KPiANCj4gU2lnbmVkLW9mZi1ieTogU2hpdmFtdXJ0aHkg
U2hhc3RyaSA8c3NoaXZhbXVydGh5QG1pY3Jvbi5jb20+DQo+IC0tLQ0KPiAgIGRyaXZlcnMv
bXRkL3NwaS1ub3IvbWljcm9uLXN0LmMgfCA3ICsrKysrKysNCj4gICAxIGZpbGUgY2hhbmdl
ZCwgNyBpbnNlcnRpb25zKCspDQo+IA0KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9tdGQvc3Bp
LW5vci9taWNyb24tc3QuYyBiL2RyaXZlcnMvbXRkL3NwaS1ub3IvbWljcm9uLXN0LmMNCj4g
aW5kZXggYjVkODJlODVmYjkyLi4yYmViZDc2YjA5MWEgMTAwNjQ0DQo+IC0tLSBhL2RyaXZl
cnMvbXRkL3NwaS1ub3IvbWljcm9uLXN0LmMNCj4gKysrIGIvZHJpdmVycy9tdGQvc3BpLW5v
ci9taWNyb24tc3QuYw0KPiBAQCAtMTU4LDEwICsxNTgsMTcgQEAgc3RhdGljIGNvbnN0IHN0
cnVjdCBmbGFzaF9pbmZvIHN0X3BhcnRzW10gPSB7DQo+ICAgCQkJICAgICAgU0VDVF80SyB8
IFNQSV9OT1JfUVVBRF9SRUFEKSB9LA0KPiAgIAl7ICJuMjVxMDY0YSIsICAgIElORk8oMHgy
MGJiMTcsIDAsIDY0ICogMTAyNCwgIDEyOCwNCj4gICAJCQkgICAgICBTRUNUXzRLIHwgU1BJ
X05PUl9RVUFEX1JFQUQpIH0sDQo+ICsJeyAibXQyNXF1MTI4YWJiIiwgSU5GTzYoMHgyMGJi
MTgsIDB4MTIwMDhjLCA2NCAqIDEwMjQsICAyNTYsDQo+ICsJCQkJU0VDVF80SyB8IFVTRV9G
U1IgfCBTUElfTk9SX1FVQURfUkVBRCB8DQo+ICsJCQkJU1BJX05PUl9IQVNfTE9DSyB8IFNQ
SV9OT1JfSEFTX1RCIHwNCj4gKwkJCQlTUElfTk9SXzRCSVRfQlAgfCBTUElfTk9SX0JQM19T
Ul9CSVQ2KSB9LA0KPiAgIAl7ICJuMjVxMTI4YTExIiwgIElORk8oMHgyMGJiMTgsIDAsIDY0
ICogMTAyNCwgIDI1NiwNCj4gICAJCQkgICAgICBTRUNUXzRLIHwgVVNFX0ZTUiB8IFNQSV9O
T1JfUVVBRF9SRUFEIHwNCj4gICAJCQkgICAgICBTUElfTk9SX0hBU19MT0NLIHwgU1BJX05P
Ul9IQVNfVEIgfA0KPiAgIAkJCSAgICAgIFNQSV9OT1JfNEJJVF9CUCB8IFNQSV9OT1JfQlAz
X1NSX0JJVDYpIH0sDQo+ICsJeyAibXQyNXFsMTI4YWJiIiwgSU5GTzYoMHgyMGJhMTgsIDB4
MTIwMDhjLCA2NCAqIDEwMjQsICAyNTYsDQo+ICsJCQkJU0VDVF80SyB8IFVTRV9GU1IgfCBT
UElfTk9SX0hBU19MT0NLIHwNCj4gKwkJCQlTUElfTk9SX1FVQURfUkVBRCkgfSwNCj4gICAJ
eyAibjI1cTEyOGExMyIsICBJTkZPKDB4MjBiYTE4LCAwLCA2NCAqIDEwMjQsICAyNTYsDQo+
ICAgCQkJICAgICAgU0VDVF80SyB8IFVTRV9GU1IgfCBTUElfTk9SX1FVQURfUkVBRCkgfSwN
Cj4gICAJeyAibXQyNXFsMjU2YSIsICBJTkZPNigweDIwYmExOSwgMHgxMDQ0MDAsIDY0ICog
MTAyNCwgIDUxMiwNCj4gDQoNCkkgc3VzcGVjdCB0aGlzIHBhdGNoIGNhbiBiZSBzdWJtaXR0
ZWQgYXMgYSBzdGFuZGFsb25lLiBJdCBkb2Vzbid0IHNlZW0gDQp0byBkZXBlbmQgb24gdGhl
IG90aGVycyBpbiB0aGlzIHNlcmllcy4NCg0KVGhhbmtzLA0KDQotLSANClBhdWwgQmFya2Vy
DQpQcmluY2lwYWwgU29mdHdhcmUgRW5naW5lZXINClNhbkNsb3VkIEx0ZA0KDQplOiBwYXVs
LmJhcmtlckBzYW5jbG91ZC5jb20NCnc6IGh0dHBzOi8vc2FuY2xvdWQuY28udWsvDQo=
--------------223ZAcIgnMnW3h47YPKgu5VX
Content-Type: application/pgp-keys; name="OpenPGP_0xA67255DFCCE62ECD.asc"
Content-Disposition: attachment; filename="OpenPGP_0xA67255DFCCE62ECD.asc"
Content-Description: OpenPGP public key
Content-Transfer-Encoding: quoted-printable

-----BEGIN PGP PUBLIC KEY BLOCK-----

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
4yvD5AdHy8s8HYtBP5oowjSllz6aOtP0BiQ=3D
=3Duult
-----END PGP PUBLIC KEY BLOCK-----
--------------223ZAcIgnMnW3h47YPKgu5VX--


--------------Mv0krmr33OC0iAA3wMCMqBSH--

--------------2eFtnstfQeWXeQOnjq9U7EaL
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature"

-----BEGIN PGP SIGNATURE-----

wnsEABYIACMWIQS7m7rT1+CktY3YG1PYN3IfEvob6gUCYa3ufgUDAAAAAAAKCRDYN3IfEvob6i/X
AQCDv+UXooiy0LtRO48hwTT2WB4QedZLtSxzHl3hLVirIAD8CycjcTJkh6SYr6pgZcPCPFc1LuBp
yfxoJxkCBQTXfQQ=
=mWQI
-----END PGP SIGNATURE-----

--------------2eFtnstfQeWXeQOnjq9U7EaL--
