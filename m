Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D75F24B22E4
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Feb 2022 11:14:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348821AbiBKKOQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Feb 2022 05:14:16 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:47056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229671AbiBKKOO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Feb 2022 05:14:14 -0500
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 060BAB38;
        Fri, 11 Feb 2022 02:14:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1644574453; x=1676110453;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=ug+7uvDegwUPu6OBbJ5agwSPvnq92YYBG7DCctHq6S8=;
  b=WmypgZb90uqddb1TIu/pn9AMKMVeiY5JgQ5+bn4TnCQrh7HlDuHuna4x
   DdNG/z21tVXPKH8hrSpKAL15jt36Zypu5aN6jgobCc6FLtVDSBXJRjXOV
   5wTcQMXO2bO+8KThtjMazBg+u0jJs4zLIsktxvmdezZGKwOIfDGDtzvQL
   ymK/5nNvqoekwajKxJ95SBe8LWd0+PUDnGI4I2yomhRI1rhM8M6n8xLs6
   Ng6cTlN/1WZSA/4lVu7llB9tkz1AHSixatk1BYs4tMCZW8mlBqr+x0Fmy
   +pmbxSj8tpH2kT1lBYmev1iN16fNh9HizGAvERHdS2x/j+TROIUB8a6Pk
   Q==;
IronPort-SDR: JQJkQH+7jcfd2mvJeJ96Feif+6G77qI10NzmszSjC/uAGw5foUjLevHCnyw7olrPs7dcDpXe+m
 Q4DSVB9Zr7HNP9SBIz0p/1/lMs7Bujexh2IOmr1g6oy+KkibamIGKGBlfVwnb/g0VU11CMXlil
 9Ydu0AKnEo0I7WhuakJwKN/QiVev2GElTsch7eCTvlFckS1u/WDflC3JnZx3ffvYI0Bfg8/Rh/
 Sc1XmB23YxhhNqlKUM7fU8a/HLq/es3ZofTpz2ZcCVt5WwTWi5XiZVO6EJAJuYEGXtFHIHBp03
 jsrsUZJ9wlR3aEuPy4e2tNNl
X-IronPort-AV: E=Sophos;i="5.88,360,1635231600"; 
   d="scan'208";a="161910832"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa1.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 11 Feb 2022 03:14:13 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Fri, 11 Feb 2022 03:14:13 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17 via Frontend Transport; Fri, 11 Feb 2022 03:14:13 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VL1sNBV2DICpSjfgriJ8ZtmRc0HVQ+ecm8PkKZwaaxn0a8VtbegoXWfYdpPWcYB4KMq+uY0AWVMMLPDp7akW+Kp4kqHPhJZ50N3QNJ8V1+fkPNrLO6OPx+YlOJBocWqDRo/EpzENFf/MtjS/bYJbop1FnpQbYS+n8Rk0jke3BKzFWB362icQME3Cvs7WaQ1Tmm5CvTqaPz7iRsu8JKEjyxIN3umF+DCc3M6p2uTdzixZt4DpMNyKxAquAnVPE7lKKy+7OD30M42s8NcKQuwS+rrz/mnrCQ/ee+yNLcfdPfcCgY0hOT+Hzn1AO+ywY0XMv2/7HMv7fgnXQzaouSECYQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ug+7uvDegwUPu6OBbJ5agwSPvnq92YYBG7DCctHq6S8=;
 b=cXRedWpmZfQcIZVBNiEP9lb+0JGl1Y4FKtboUwS82LyNf2IA2ZzmKoqCz2RTfjISIyfuVPU2gEbb+CUHs4n6kxAk3ctkTtEvT6fh/3X965CidN0/CPGL/xNhyhqxUCqCQVcJtZsj5tyOOP6BoeCWhaootY/SS8JLGVkq60ZXVK2MUBgGpd4UE16+Yl40dZTh4+2BOL0wZ/fZ/QO9MwPjrv80Y9sfN01sU1PC1VcFfAwI6/nRKxDAIXsvHaj+Qxx3laMuLEi2JW8J/VtIskrjaFAQfN+RCQxBqqjASGgtKB6unyvgE8x4ic6IKqfOw6URGu2p7ztE7/PdL+Dw7xWwbQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ug+7uvDegwUPu6OBbJ5agwSPvnq92YYBG7DCctHq6S8=;
 b=iLCVCErsIjarhCFO5X1Ja7DawXtZVlnuAAesbb+J7rwK2N7Tl7rxkSEjT+lkrzRpLLns4HeCS4xOxMwnQpnZVIyuH35iRTJ2JwLvIt1H+Ipyuwdtd1MRA7vmArBSdAG8i+cOxRdC0wdjMVmH4DkGmKA/6+W3LSVh1J0hJuk7aa0=
Received: from CO1PR11MB4769.namprd11.prod.outlook.com (2603:10b6:303:91::21)
 by BN7PR11MB2722.namprd11.prod.outlook.com (2603:10b6:406:b8::30) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4975.11; Fri, 11 Feb
 2022 10:14:03 +0000
Received: from CO1PR11MB4769.namprd11.prod.outlook.com
 ([fe80::5cae:e802:4a48:bd0f]) by CO1PR11MB4769.namprd11.prod.outlook.com
 ([fe80::5cae:e802:4a48:bd0f%5]) with mapi id 15.20.4975.015; Fri, 11 Feb 2022
 10:14:02 +0000
From:   <Claudiu.Beznea@microchip.com>
To:     <Tudor.Ambarus@microchip.com>, <herbert@gondor.apana.org.au>,
        <krzysztof.kozlowski@canonical.com>, <robh+dt@kernel.org>
CC:     <Nicolas.Ferre@microchip.com>, <alexandre.belloni@bootlin.com>,
        <linux-crypto@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <Kavyasree.Kotagiri@microchip.com>,
        <devicetree@vger.kernel.org>
Subject: Re: [PACTH v4 0/3] dt-bindings: crypto: Convert atmel-crypto to YAML
Thread-Topic: [PACTH v4 0/3] dt-bindings: crypto: Convert atmel-crypto to YAML
Thread-Index: AQHYHzAXavezFHTohE6hzuhSmskh0w==
Date:   Fri, 11 Feb 2022 10:14:02 +0000
Message-ID: <0e5a2956-7a43-04cb-a042-65bbc5f9b164@microchip.com>
References: <20220211093922.456634-1-tudor.ambarus@microchip.com>
In-Reply-To: <20220211093922.456634-1-tudor.ambarus@microchip.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.1
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 15278cdb-5bdc-4806-65e6-08d9ed473a7c
x-ms-traffictypediagnostic: BN7PR11MB2722:EE_
x-microsoft-antispam-prvs: <BN7PR11MB2722243228F75133D610ACDB87309@BN7PR11MB2722.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 1XHmnw86NK/WlEPAU3TXLWGWhK3HRMB3braXNcIChAQHmFHUnmKZ92Cf5Z/nrbrdPrmsbYPnEV5yfFX+mPnEhAkyxRXRZIJW9a9RqL4uDlRGO1bclsHsDBFEX03kL7hUBMvpFlH/sYa8t+c8iw0Q1L+yvm0uEK7hz8stuuCcrue7xyEVYPg5erVOsoO3xZxv8qVHoTTIVOBE0Sw5jqF0qF2CcNuLnHzyrpgycsgV47D5TD7l8CbmlZXvH9orBH/mwOj1cz7QfbvlpvbV4fyraJwqX6QkTyTIjais854JJv2pqH4UhH5kag/T2/IVoeNoCaClXDIorebvnpiSHezyLzh1G/X+uneDCbq+/wHClI6XIe/TUfvSHSXjd4pWnfgO+KBTmN1S6rA6KNcenlKjA6dILwC10Th/rsjX/iwEaqoUvNqafaGlpe09+i+SJ75fIVvNvLarJdw03q5JabLgLGu41uFWl3SKEp7mXJMl73h5R2IfTXhwP6dak0accfGb2VGfkYAKt/0iUbPM/xcnV2PXVbYZsZFhvXVI+20CAT8bkFyS4f4kEQxMxPNkYBWOaqrnHCYkD31Dp2aWXSp4uWcSh7VgwhqadU5rGvFAjZbpRlZ3O5HfT8JXB8/QRatbGKgYK9UVI4l6wo/L0y3+W7gA+sXIDQhSYJI9lddj/KxZZpxAcMNi62lNNdNtQnaHiEKVCgCbJgZ1/K70V0MiyOhGRJFQE+hveF/FElzi8QsRxdZXs0GPm8KhJRegSdCQATTnjWSFsM0QIz2YBpPlgFQ8FEMCDdrLWc60AbtCwy0KOqTZCMa2aNtitqBLegWfTDbcXeoyo4Inzo99yCYg88ejNXsExK37HqeAeMlvb/E=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB4769.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(76116006)(966005)(66946007)(53546011)(38100700002)(8676002)(64756008)(8936002)(66476007)(66556008)(4326008)(91956017)(110136005)(54906003)(316002)(66446008)(6486002)(71200400001)(38070700005)(508600001)(86362001)(31696002)(36756003)(83380400001)(2616005)(26005)(6512007)(31686004)(122000001)(5660300002)(6506007)(186003)(2906002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Z014VzEvVGhlUSt3UGZRekN2REVuVXR3RVg2SktzdHJ6bE83TzNncVlXTW91?=
 =?utf-8?B?cFVQZDRqOUpqRFpyT1haR3Z4UFdaNWMxQ2lvOEZ3cW5qOW9Od2tMVVRsNlJ0?=
 =?utf-8?B?dUtaYjVyR2ZoenBBdmt5K3o1UVIzK1lJS3g0NklrQVpMUjBLWWhrdTUzOEgv?=
 =?utf-8?B?bXJoa29EU2xLRkpGcjd0c1k2OU41TW5OcG1iaktpcWE5QUVCZGlPbUhUYkNo?=
 =?utf-8?B?a2Q4RkVvRmRJOXZjTDM4bEFRNDNNczUyMElkQXk2cTBkZTBpOEs5TnVXZU1y?=
 =?utf-8?B?cDdEczVzWHJvQnhRQ0d0dXZYQktoU3VOQThYTEp6K0NueCsvSG1VUmIvT2h0?=
 =?utf-8?B?SkVPVDVFWVdmanhTcmlmRTZlTUlldG14aWNaZU1DVnhwNFUyNlFOaGcxak84?=
 =?utf-8?B?dEtIWS9ldnE2bFhwUFUyNit6eEhYK01JNG9VVUVrUGU3ZEcvaVhCTnZJdXVL?=
 =?utf-8?B?anR5ZUtQVkdXM3VlcGJZdm43YkI0VmQ3K0J3MnowQnpNZFBFRmpVSWkzd0h4?=
 =?utf-8?B?M3ZJQUlMdnhxNEROaEJ3YytQem1wek5yaUNvRVNXU0dGTDFXUVJLb2xRU2l5?=
 =?utf-8?B?NW1LQjQ5MC9wbXdYalZLaHp3OSsvYk9kSEdscHdHLzdkeFFuMWVSdHhLWlo4?=
 =?utf-8?B?RHNiM3ZGZUgycVlLQWN4VzQ2UnlQQUZXSmlxdlpVWGk3R0hJd1ZocmRXZ1RK?=
 =?utf-8?B?SXExdDBsMXpkNHo0VzErNUFaUndMVVF1Um0yWk42SWFyQjFyQ28zc0hYNVN6?=
 =?utf-8?B?aE5BYlZrK3c2OXhVWUIyUlVLY200SnJtKzN3U1BCVHdBVVFaSEJVQzhLNmdm?=
 =?utf-8?B?ZXBCMlRpZVBnZHhWaWlDTnRVKzBMM0kxMlB5QXNVR29ISVh2TFlxSkcwb0p0?=
 =?utf-8?B?RlhqZ2hxZXVVa2dDenloL21oeTRscGFzM2FLZUdQeEFrenNjNDk2Tkgwamhq?=
 =?utf-8?B?bitWQUhadWlhb2lXaEUzRHBpUS9EYUxRa2c4L1pXWkF0dVBTRXdxNU9iZFVJ?=
 =?utf-8?B?dUZCK2VacmJ0VFZ0MEczSXk5eTQvVmQ0cGNEMmZPZnp6U2luUW1LYlRCTlRJ?=
 =?utf-8?B?VGVPN3hNQVU0cExHWi9xZ0tsYi9PRmlEODZDNGo2UnBRUE02OFczNUowaDNJ?=
 =?utf-8?B?TGM5RWxLVlVNV2ZBS2doOGZlbURtbkpRT1BTVGoxOTBtOU9ncFR3L3NISU5K?=
 =?utf-8?B?YWcrTk0yaHBGRlZzaWlJeXBZL3cvRnFodUU3LzhNdkduM25jdngwdXBqUVNh?=
 =?utf-8?B?TkZZTldFM29BNGZ3d3QrZTdHbnErUkJwSTFSemZUWmkwMk1qa0J5YkE2WUsw?=
 =?utf-8?B?WWRmbUtOTmJyU0VXZk9GUEc4LzJhYnVwR0RxOGhUSktIbUMxSjZ3eW5maHpD?=
 =?utf-8?B?RHoyY0FCMVRmVEhZTHIvUGhGTUlqOWVJNm5RTkxSNjM0Zk9uTFhnQW55S2c1?=
 =?utf-8?B?Yy84d0hPZ0VIdFFhTVpwVU1HMjN0bnZFckI5b3hKOERsTVM1amJTWFZZNTBE?=
 =?utf-8?B?b1htVElXVnlSYXd1bmFjajMzb3ZtWmVmRjljdjE2L1g0ZkNSV2ZBYXJmZjM0?=
 =?utf-8?B?eVEvVDBWY1RUUXIxK1A3NWRUVVB1ckd4VjdvNzU1bVF5Zkxwei9vYWNWTG44?=
 =?utf-8?B?TnlKZnVUR3RPUGRlaVBOYlI3VDQ3S1Jac1BoUDhFMDN4cWt0YXZSMnB0UzlK?=
 =?utf-8?B?TU8rOVAvdjJPTzBTZmNVNDNUbXZCZGtTUURkc1R5OE5NTnY2VFNLTUZKNmE2?=
 =?utf-8?B?ckpiYU1kMkFna24yV3JqWkFrWTF3cXBDUGRleTRNM2dIN2tsUTd3OEtsVkpN?=
 =?utf-8?B?bERHRHJ6OXppU1BUQmFWdzZZRWdVVE1JbHMzWmwyT0JSZkpya2dQVFZGZmRB?=
 =?utf-8?B?UVRiS3BGaU9GOU1tbjQxWTc2WEhTUzVPUTBPVTY4NnlQclBGSEYvNmNkcTg0?=
 =?utf-8?B?L0ZWYXhrOHRQZW5ZZFV1NHFuVHAyNUhZQi82aDBnamN6Q1RiSWY1eHhYNFZt?=
 =?utf-8?B?MzF1USsxRm0wTVkvVlB6RFZkS3JpYUg2SVVoSERDM0tZb0JqcnRzQXh2TTFy?=
 =?utf-8?B?UHJuZGNLTkdWUUdWSmpsWDUzRGZrNmx5QUd2dktlYVh2NDJvUXNQYkNnZmgw?=
 =?utf-8?B?dm9ObEYyNVdnYThSMWVsVFh0aGxCR09IRDltZTBDY3lKZzM0U3d0MDdoREQ2?=
 =?utf-8?B?dEwweTRhL2xOTVJ5Mk9uRzBkQmxJcWZOUFZBOHNneW5XVWhlTjZmNFFKWXpU?=
 =?utf-8?B?amp3T0Njc1lvamNuMGVBVzBXMXRBPT0=?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <D2A48970369B0F4CAA12B0185DAA7A19@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB4769.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 15278cdb-5bdc-4806-65e6-08d9ed473a7c
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Feb 2022 10:14:02.8546
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: J/HDBoFTD+ECOTaHX8K8AMB/pJQUDK/362Upevtnf0sYNZ4gHIkNF6Z06ojVgriDVShNBr8+3bNi6xr+15MwKtkH3noN1/lVgbS7XjZidF4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN7PR11MB2722
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gMTEuMDIuMjAyMiAxMTozOSwgVHVkb3IgQW1iYXJ1cyB3cm90ZToNCj4gQ29udmVydCBBdG1l
bCBBRVMsIFRERVMgYW5kIFNIQSBkb2N1bWVudGF0aW9uIHRvIHlhbWwgZm9ybWF0LiBUaGVyZSBp
cyBvbmUNCj4gYmluZGluZyBkZWZpbmVkIHBlciBmaWxlLiBLZWVwaW5nIGFsbCBiaW5kaW5ncyB1
bmRlciB0aGUgc2FtZSB5YW1sIGRvZXMNCj4gbm90IG1ha2Ugc2Vuc2UsIGFzIHRoZXNlIGFyZSBp
bmRpdmlkdWFsIElQcy4gV2l0aCB0aGUgY29udmVyc2lvbiB0aGUgY2xvY2sNCj4gYW5kIGNsb2Nr
LW5hbWVzIHByb3BlcnRpZXMgYXJlIG1hZGUgbWFuZGF0b3J5LCB0byByZWZsZWN0IGhvdyB0aGUg
ZHJpdmVycw0KPiB0cmVhdCB0aGVtOiB3aGVuIHRoZXNlIHByb3BlcnRpZXMgYXJlIG5vdCBwcm92
aWRlZCwgdGhlIGRyaXZlcnMgcmV0dXJuDQo+IGVycm9yLg0KPiANCj4gdjQ6DQo+IC0gZml4IHRo
ZSBBRVMgZXhhbXBsZTogbWF0Y2ggdGhlIG5vZGUncyBhZGRyZXNzIHdpdGggdGhlIHJlZydzIGFk
ZHJlc3MNCj4gLSBjb2xsZWN0IEtyenlzenRvZidzIFItYiB0YWdzDQo+IA0KPiB2MzoNCj4gLSB1
cGRhdGUgbGljZW5zZSB0byAoR1BMLTIuMC1vbmx5IE9SIEJTRC0yLUNsYXVzZSkNCj4gLSBhZGQg
IkNvcHlyaWdodCAoQykgMjAyMiBNaWNyb2NoaXAgVGVjaG5vbG9neSwgSW5jLiBhbmQgaXRzIHN1
YnNpZGlhcmllcyINCj4gLSBhZGQgS3J6eXN6dG9mJ3MgUi1iIHRhZyBvbiBwYXRjaCAzLzMuIENo
b3NlIHRvIGtlZXAgIm1heEl0ZW1zOiAxIiBpbnN0ZWFkDQo+IG9mICJpdGVtcyIgYW5kICJkZXNj
cmlwdGlvbiIgYmVjYXVzZSB0aGF0J3Mgd2hhdCB0aGUgZ3VpZGUgYXQgWzFdIHN1Z2dlc3RzOg0K
PiAiIyBDYXNlcyB0aGF0IGhhdmUgb25seSBhIHNpbmdsZSBlbnRyeSBqdXN0IG5lZWQgdG8gZXhw
cmVzcyB0aGF0IHdpdGgNCj4gbWF4SXRlbXMiDQo+IA0KPiBbMV0gaHR0cHM6Ly93d3cua2VybmVs
Lm9yZy9kb2MvaHRtbC9sYXRlc3QvZGV2aWNldHJlZS9iaW5kaW5ncy93cml0aW5nLXNjaGVtYS5o
dG1sI2Fubm90YXRlZC1leGFtcGxlLXNjaGVtYQ0KPiANCj4gdjI6DQo+IC0gdXNlIGdlbmVyaWMg
ImNyeXB0byIgbm9kZSBuYW1lDQo+IC0gZHJvcCByZWR1bmRhbnQgc3RhdHVzID0gIm9rYXkiIC0g
aXQncyB0aGUgZGVmYXVsdCBzdGF0ZSBhbnl3YXkNCj4gLSBpbnRyb2R1Y2UgZW1wdHkgbGluZSBm
b3IgcmVhZGFiaWxpdHkNCj4gLSBiZSBzcGVjaWZpYyBhbmQgcmVuYW1lIHRoZSBiaW5kaW5ncyB0
byBsZXQgcm9vbSBmb3IgZnV0dXJlIHBvc3NpYmxlDQo+ICAgbGluZXMgb2YgYXJjaGl0ZWN0dXJl
cy4NCj4gDQo+IFR1ZG9yIEFtYmFydXMgKDMpOg0KPiAgIGR0LWJpbmRpbmdzOiBjcnlwdG86IENv
bnZlcnQgQXRtZWwgQUVTIHRvIHlhbWwNCj4gICBkdC1iaW5kaW5nczogY3J5cHRvOiBDb252ZXJ0
IEF0bWVsIFRERVMgdG8geWFtbA0KPiAgIGR0LWJpbmRpbmdzOiBjcnlwdG86IENvbnZlcnQgQXRt
ZWwgU0hBIHRvIHlhbWwNCg0KUmV2aWV3ZWQtYnk6IENsYXVkaXUgQmV6bmVhIDxjbGF1ZGl1LmJl
em5lYUBtaWNyb2NoaXAuY29tPg0KDQo+IA0KPiAgLi4uL2NyeXB0by9hdG1lbCxhdDkxc2FtOWc0
Ni1hZXMueWFtbCAgICAgICAgIHwgNjYgKysrKysrKysrKysrKysrKysrDQo+ICAuLi4vY3J5cHRv
L2F0bWVsLGF0OTFzYW05ZzQ2LXNoYS55YW1sICAgICAgICAgfCA2MCArKysrKysrKysrKysrKysr
DQo+ICAuLi4vY3J5cHRvL2F0bWVsLGF0OTFzYW05ZzQ2LXRkZXMueWFtbCAgICAgICAgfCA2NCAr
KysrKysrKysrKysrKysrKw0KPiAgLi4uL2JpbmRpbmdzL2NyeXB0by9hdG1lbC1jcnlwdG8udHh0
ICAgICAgICAgIHwgNjggLS0tLS0tLS0tLS0tLS0tLS0tLQ0KPiAgNCBmaWxlcyBjaGFuZ2VkLCAx
OTAgaW5zZXJ0aW9ucygrKSwgNjggZGVsZXRpb25zKC0pDQo+ICBjcmVhdGUgbW9kZSAxMDA2NDQg
RG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL2NyeXB0by9hdG1lbCxhdDkxc2FtOWc0
Ni1hZXMueWFtbA0KPiAgY3JlYXRlIG1vZGUgMTAwNjQ0IERvY3VtZW50YXRpb24vZGV2aWNldHJl
ZS9iaW5kaW5ncy9jcnlwdG8vYXRtZWwsYXQ5MXNhbTlnNDYtc2hhLnlhbWwNCj4gIGNyZWF0ZSBt
b2RlIDEwMDY0NCBEb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3MvY3J5cHRvL2F0bWVs
LGF0OTFzYW05ZzQ2LXRkZXMueWFtbA0KPiAgZGVsZXRlIG1vZGUgMTAwNjQ0IERvY3VtZW50YXRp
b24vZGV2aWNldHJlZS9iaW5kaW5ncy9jcnlwdG8vYXRtZWwtY3J5cHRvLnR4dA0KPiANCg0K
