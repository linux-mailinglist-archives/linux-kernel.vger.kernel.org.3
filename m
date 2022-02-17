Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9D4094B9C9F
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Feb 2022 10:59:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238192AbiBQJ7V (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Feb 2022 04:59:21 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:47502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229789AbiBQJ7S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Feb 2022 04:59:18 -0500
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50F955F56;
        Thu, 17 Feb 2022 01:59:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1645091941; x=1676627941;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=UopaOpBMXbG8pQqlZwqMrEIotBR9FmovLoEdrqAo9d8=;
  b=FJWVdZ+rTWtV7u3eJdBPlcwGTpd73hZtlREB3JjeduPhytnJKQlf9yUU
   C0aaa6SrCVefUtcmX5aeJ0sOnWRI37oRc/s12KfnbbdqOQ/oT8dLyBTe2
   o1iTIz4+69coDmEp51+g7O0iaRX/N20/79qostQY+ibTQ44VeuyS6qLBH
   NhEY8FrgSgh5r69NtM9m5/oe6wVmyxcooOUTpFWNNuxqQDyoEBxnbu+3A
   4lZYwSBhi2iLTUWoE0zQGXReUa1vTc79pTOUlmDGQshI/MajszBefbSWG
   6na7ozhdvo2nWR9S3zTjbLp4T/29ABArUzaaWEFYIVXSBOWBjCKACrCwk
   g==;
IronPort-SDR: WXS3yxdIkxLYjUkcDmgZWwR6J4lrBHWVKyqLEhrjwginxLzSJCdLLaxtI4SmwvhPtLjxQE0piR
 O79kgDUMg7VZOsX3v/GL2xV9GcqvsoVOBEuQpbH3pDionLFYHBHI4UnDgzDDZM4r08AMZz6RzC
 J74QBwJzqCRVAnqqD3UcjfjzTgN7szh6HCu+HA9L/8ZcZ5ov+SYKdwzr7NCsu30pDbGaWyOwTK
 0t3b0sdvPDXEVA4FSzG5kudbfUTu+sSUAuufan8amFLUvnykfLsmyXZI857LjHZbm5VZzedDhD
 e1IxQBabm/3QaRRCf/8urhdZ
X-IronPort-AV: E=Sophos;i="5.88,375,1635231600"; 
   d="scan'208";a="162607206"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa1.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 17 Feb 2022 02:59:00 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Thu, 17 Feb 2022 02:59:00 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17 via Frontend Transport; Thu, 17 Feb 2022 02:59:00 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RnIEBzNjLH7P89YAcWBGbynSu2YgID840jhsTBx26zhO0ZZEVTmh7nsXcx8SaUdaYYjhGNMTNkWg7Sq4wmBhJll8i7+O3RECRJqGSMgMGurqhLbdNvMS+Vj62yjVdp/R4NAZHV5zh+dwWWB8KGZ1xV19H3A03nfYseR7uxvgLk32wdEF5Kmiah1vbOA7yB65i0QUrqvMKQSsEZ9mPem4HxacbFAHgBxIcADUDuiTQFOJc4TiGfmADdWNvhIlIuLGzCbVuoEC6WNYfWfm+0eCEH1VpUdSpxF8x3l57ypLjJos8df1yO8rsG8jdgsPy7FHvyjjAdudJ3Or4Zjb147zCw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UopaOpBMXbG8pQqlZwqMrEIotBR9FmovLoEdrqAo9d8=;
 b=IkMVgKjMhbjY2+WTq9S2gA6e/mdJsDnmF9BLMby06ir8bAGAQ4RflufiWo8oqUF8K464eRB1efDrf/Qnai6pzMi3eCXMGOSXR2heXpPBYSJf9uPLpv7ftx2VMRqLcFtb7wtBjBVwHMdvhR2g3tNgzHIp25r1oFMcS15Rh0jnx+51bRx0CyTxYfWUMO9h8e/BOqEWmbmrUWsEWVOAElj8kNgFTzfxaJF7yiwt22fKe8+h/FCQycl3JznZ8dVIbwqZ56UVi3gNXKNmDr9uuAQ1jysh9Ykc05WUCfenvclT+6kdMjTfMQ5OUiqj6yf6RxI1lc90MyLUsemXu9LHPN4NDg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UopaOpBMXbG8pQqlZwqMrEIotBR9FmovLoEdrqAo9d8=;
 b=ki7rtmiAIqHw5sKHBMTSClrxPXXH/CgeOgHLY6HMDZYaq/XWNJsLwy+6n0qdcjjhUX3RJnpNljAQzJ87Ch9pfatqzU7RmcedHyMyhY7H/QXfk0CfWkOlxF/PdF2vmFEkmrhzc1sFpXIPOGGoqKeZFG+1TUovAgqDXV70Dw2B/Wg=
Received: from CO1PR11MB4769.namprd11.prod.outlook.com (2603:10b6:303:91::21)
 by BL1PR11MB5464.namprd11.prod.outlook.com (2603:10b6:208:319::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4995.14; Thu, 17 Feb
 2022 09:58:58 +0000
Received: from CO1PR11MB4769.namprd11.prod.outlook.com
 ([fe80::b952:cac0:826c:f0be]) by CO1PR11MB4769.namprd11.prod.outlook.com
 ([fe80::b952:cac0:826c:f0be%6]) with mapi id 15.20.4995.016; Thu, 17 Feb 2022
 09:58:58 +0000
From:   <Claudiu.Beznea@microchip.com>
To:     <michael@walle.cc>, <richard.genoud@gmail.com>,
        <gregkh@linuxfoundation.org>, <jirislaby@kernel.org>,
        <Nicolas.Ferre@microchip.com>, <alexandre.belloni@bootlin.com>
CC:     <linux-serial@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] tty: serial: atmel: add earlycon support
Thread-Topic: [PATCH v2] tty: serial: atmel: add earlycon support
Thread-Index: AQHYI+T7DWZHXilmmEm5yp3Kiixbjg==
Date:   Thu, 17 Feb 2022 09:58:58 +0000
Message-ID: <afb20e85-6907-94d1-84ae-b50600716ad8@microchip.com>
References: <20220217094620.1148571-1-michael@walle.cc>
In-Reply-To: <20220217094620.1148571-1-michael@walle.cc>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: ddc85123-8777-4483-1b1d-08d9f1fc1df3
x-ms-traffictypediagnostic: BL1PR11MB5464:EE_
x-microsoft-antispam-prvs: <BL1PR11MB5464E5404175895E4697925387369@BL1PR11MB5464.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:513;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: /PJNi9dfdDMyzHI+8h6aEMnLDmzSe3qxH1sBxgVqKjnqfQu7uxcM24kDmXSBMtGviA74GcCjnQZKCNJNStfGKuoyEGbJW1oiyMDTYMnzZYVt0d01ln4FI4JeOM3nLp/mAlxXOCuks5SKe+6H+1OurS5evIfu+eTQYwJA05AsSd2zMwAhHmb97lK+FrMwoLl9gjTC631+icStKUbg2sAJaQVlfR73/qMuYBirDgOrWpvKWclcBGoiofUI0u/XPJvwqnMz2nX5SW1LwTfjKi9SvcKVcN3xsc1nnSLXX3AcWnvyFcSB9XkCGu6sI4c5FK5R7cSUr81kzcUXm1DdIMdV0AAWCFmPe6393cpbdwYw/03x3RKT5EHEVANN0To+9TfejO1xyf2z8h/QpSoA0JdK7Clw/mg/6cyHxoUyhXGBkRN046CQco28bNh7Op2BwLF+5ZXZg04Jg2I9teBlOgWbRhXFIkImBhAGjmtHnIbR4TJUHvtbwP1bB9i2KenlhEMkzmwGfySg4SPjWTb2fQZrPj7C+BKp9M6OvucxmNJYotFqgy7cGvT4e1PPMYsSE37Iu8BaopVooyc4hdNzo2CpWdzupRstqmiTbWJCZJqBY34ew3Jrdl0p3EUpAiD3TIR7K8xXzmVToke7gt6Wqq6dfpXgXDHzisZ+0gl8cMoxCyr9fOCUxu+l05UBP6AH6LZdyTDqvCMhR/xwVj0BXSJCzUB8zkVHuF6Mo6GRZlNfxmONR5YSRkCacqlQascebMr3aKpCZ2EAbVJO9rliQvQykQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB4769.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(6512007)(38100700002)(8936002)(122000001)(36756003)(2906002)(31686004)(5660300002)(31696002)(66556008)(66476007)(91956017)(186003)(38070700005)(64756008)(8676002)(4326008)(316002)(66946007)(66446008)(76116006)(71200400001)(86362001)(110136005)(508600001)(54906003)(6486002)(2616005)(53546011)(6506007)(26005)(43740500002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?djQ5Q2xWeGgwRmI0cVhVbDBkM0FQTCsrQlJJNDFQc3F6VS9ObGhzT2RlbzBO?=
 =?utf-8?B?aWwxcXMwU0lvazROL1VJWG9JaDlrTDZhbTdocURlTjIvMXEyVVpYQnJDMFhu?=
 =?utf-8?B?aWIwMnhVcCtEUkJ4MTFGRHlFTnFuNzZVRFpOVm1TVFhOOXZ3WFJXcDExbGV4?=
 =?utf-8?B?ck5CMWFaTGdLQTBabEtldFhiM3lDbkNRZnIrS0QrSTNkY2VtcWVRL21ZcjVl?=
 =?utf-8?B?NXBZMUhiTVkrUkNnTU5rYXp2YW9aWERsb2JBWnNTWlpmZ0xSVDZya0tOUTAx?=
 =?utf-8?B?eXF0QlVBUURQSnQzZjR4UWsvd3BJRnpPT2U5Y1pVUXNDakNFVEpZNkFKRGc4?=
 =?utf-8?B?ajI4eHNMYTllUmJvRWdXUFVuRmkvTEI3QWZXSVMwOTNUTHBFOFJCN1NhR0Vs?=
 =?utf-8?B?UTJJRXBLWWNFWTNMdmlKOU5yMVFVdFZTMTJ0K0FTdm96RTFMdjEzdlh2S1pE?=
 =?utf-8?B?UXNmUDc1K2RLaDNFRlhjVklXNHRzcTByMEVWWXVyeTNjWURxWTU5dVZLMGZv?=
 =?utf-8?B?dkcwTjVwcUV5WlVodStIbjcvUG15bGFpaTcwZVRHQ0drZk9UcmtlY3lUdHhi?=
 =?utf-8?B?aU83bUpHenVnNVBPSGU0eHhBb0ZEd3BZamJLVDRBbCttZDIrVGwvWS9KMXdF?=
 =?utf-8?B?TDdLVDV3cjY4MGc1NmRXOXRUaEFKWXg0cHJ6UkxtaGtsdnZIbzYwNjZRaTN1?=
 =?utf-8?B?UGErSHBmMUw5R3A3RWxMVWJMU0dGR1VtOEI3MEdHSWZTZVlpU0U5eFpLc0NM?=
 =?utf-8?B?STRXMWZRMzhyT0lYNE1UNEg1dzA4b0JZMkFsNDU1UUVsSzU3QnV3bEJHdS9T?=
 =?utf-8?B?UHhTZXM3YnVQY0pxSnlMMzZ0Rlp5U21hdDJuQ0w0VXBWM0xQYWM3eWJBSjR4?=
 =?utf-8?B?UElLS0gwWkUxbHh2Y1ZZemFFRXRycFBPNUJsbzd0K1RSTDJzV1VzUGd0MENK?=
 =?utf-8?B?enVTMGxsRHFXR0prOTg0Njk2VksrLzhZVFFYUURDK3VLR0xlbk5ZeHRDZlAv?=
 =?utf-8?B?TUxJL0gwdGgxbldKZStPZEtaYnU2T3VuVUszNmhQYWEzNDFMTjl0VzV2RGRm?=
 =?utf-8?B?MTBKakE1amg4N28zL3ZrTUs1b216UkhPOG1TSWhpQmJHbTNIQWRlR2RPSDNF?=
 =?utf-8?B?VDA3MmhIOFhBZVNDKzFRMDRqTi9HUUdiTTJOWGlpZ1lucGsraHNvL1JnUUE4?=
 =?utf-8?B?NDhRa3l5Q1ErQS9pWEkwRzFZZnpjSUM2ZE1MRjZ6MGxZY3JmRjRZSlpBYkI0?=
 =?utf-8?B?VEVsQ0xaQ1pseUhITTdTeXk1OENBbnNLZ256TzZxUm9hek5PR3hwTVlHYWFR?=
 =?utf-8?B?aE93MUJITkV2N1NpMlFnbjNOd2ZvSFJiRWNBaU5kZ0J3MDIwK3JmbkJVaitO?=
 =?utf-8?B?cmNkOWcxZWk1WDVma1FxbFY0dEwyYmowUDN3R2xKeEpaZXFyempXZVoybmpq?=
 =?utf-8?B?TDZNbWQ4TW5qcmJOcEFuQk84Tk50NGlqalYvZm41N0lWQ2dIZEljeVVNaTlV?=
 =?utf-8?B?OXNQN1dWdDFIa3JJSHZvdFBJUGdFOHBVd2hOVy9MRVljQW9UQWZ4bndlNUtt?=
 =?utf-8?B?dHhrTkdvRTQvQTJIUnFqQjd1Q0FVRkdQUTZPUCtsblc1QmJXV0hoQnBTK05Z?=
 =?utf-8?B?alFHZ2NWRkJtYWhRSlR0ZXJoeU03RjRuUVJJOTVLU3hxcU5sMWZGSHNxRm5k?=
 =?utf-8?B?UndrQlpxTm1lOEwwWThUUEt5SmFCbzVZbmV4bzJWUXk5YXZwV0NySnJ4YXNK?=
 =?utf-8?B?amcrejhYOWQwWTRuYUx4N1pXWWF3Y3RTcUluM0owdTJkbVozUEJ6NGZ5SFlD?=
 =?utf-8?B?MVVQUnpYWnJ0NGFISkhKRG9jYXArZS9KM1EwMlJpWmk1QkdySEFYVWVQSFpW?=
 =?utf-8?B?SEVPSW1YeXEzUWlmcURxZkNONTV1dnFUTFR2NStRTFc2V3U2QTk1a3YxY0t6?=
 =?utf-8?B?ZHJNT2dpTkhtMllHTjJSWGdudmdhaThOWjhkb2h5Y3pJKzV0OElwaWp4emt0?=
 =?utf-8?B?NzBZZnNqcGZnOXRPWlVhWmtNQWt5dU54RFJ5NWtFa2Ryci9tYk5RdWI3Umkv?=
 =?utf-8?B?VUVMbGVrV29ySEd5QytYOEd5QXl4UnRwSHZiMkFDS2dRb0p3VGpFRVdzK04v?=
 =?utf-8?B?U2h2OUZXQWllSENZQll0UUs5VkY2VFhnbGJkZFJrWEN6VXJmSXRMVkRoTi9k?=
 =?utf-8?B?ZW45NTRxbFRtdDhUaUo3N201Nm1hdmVzdm1Qc2w1cWZVTzFCNVJlN1I2TTNG?=
 =?utf-8?B?TVh1cTY5RmZMbkRNRzNlcUxmWnRBPT0=?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <74388BEEA937F14A9890C96DAD5D4C98@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB4769.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ddc85123-8777-4483-1b1d-08d9f1fc1df3
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Feb 2022 09:58:58.4753
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: fvxXadvybgzJXVteUq4pVGjCIbZLv7oQ9Sjl2YCkjyBa9JclKCxEQDImTzvLk+yVPMqNeN/JGlYMlLDwme2Nl6NaDowu2TZa0/2l+CpZx8A=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR11MB5464
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gMTcuMDIuMjAyMiAxMTo0NiwgTWljaGFlbCBXYWxsZSB3cm90ZToNCj4gRVhURVJOQUwgRU1B
SUw6IERvIG5vdCBjbGljayBsaW5rcyBvciBvcGVuIGF0dGFjaG1lbnRzIHVubGVzcyB5b3Uga25v
dyB0aGUgY29udGVudCBpcyBzYWZlDQo+IA0KPiBBZGQgZWFybHkgY29uc29sZSBzdXBwb3J0IHdo
aWNoIHJlbGllcyBvbiB0aGUgYm9vdGxvYWRlciBmb3IgdGhlDQo+IGluaXRpYWxpemF0aW9uIG9m
IHRoZSBVQVJULg0KPiBQbGVhc2Ugbm90ZSwgdGhhdCB0aGUgY29tcGF0aWJsZXMgYXJlIHRha2Vu
IGZyb20gYXQ5MS11c2FydCBNRkQNCj4gZHJpdmVyLg0KPiANCj4gU2lnbmVkLW9mZi1ieTogTWlj
aGFlbCBXYWxsZSA8bWljaGFlbEB3YWxsZS5jYz4NCg0KT24gU0FNQTdHNToNClRlc3RlZC1ieTog
Q2xhdWRpdSBCZXpuZWEgPGNsYXVkaXUuYmV6bmVhQG1pY3JvY2hpcC5jb20+DQpSZXZpZXdlZC1i
eTogQ2xhdWRpdSBCZXpuZWEgPGNsYXVkaXUuYmV6bmVhQG1pY3JvY2hpcC5jb20+DQoNCj4gLS0t
DQo+ICBkcml2ZXJzL3R0eS9zZXJpYWwvS2NvbmZpZyAgICAgICAgfCAgMSArDQo+ICBkcml2ZXJz
L3R0eS9zZXJpYWwvYXRtZWxfc2VyaWFsLmMgfCAyNCArKysrKysrKysrKysrKysrKysrKysrKysN
Cj4gIDIgZmlsZXMgY2hhbmdlZCwgMjUgaW5zZXJ0aW9ucygrKQ0KPiANCj4gZGlmZiAtLWdpdCBh
L2RyaXZlcnMvdHR5L3NlcmlhbC9LY29uZmlnIGIvZHJpdmVycy90dHkvc2VyaWFsL0tjb25maWcN
Cj4gaW5kZXggMGU1Y2NiMjViZGIxLi40MDdhOThlYzA3OTEgMTAwNjQ0DQo+IC0tLSBhL2RyaXZl
cnMvdHR5L3NlcmlhbC9LY29uZmlnDQo+ICsrKyBiL2RyaXZlcnMvdHR5L3NlcmlhbC9LY29uZmln
DQo+IEBAIC0xMzksNiArMTM5LDcgQEAgY29uZmlnIFNFUklBTF9BVE1FTF9DT05TT0xFDQo+ICAg
ICAgICAgYm9vbCAiU3VwcG9ydCBmb3IgY29uc29sZSBvbiBBVDkxIHNlcmlhbCBwb3J0Ig0KPiAg
ICAgICAgIGRlcGVuZHMgb24gU0VSSUFMX0FUTUVMPXkNCj4gICAgICAgICBzZWxlY3QgU0VSSUFM
X0NPUkVfQ09OU09MRQ0KPiArICAgICAgIHNlbGVjdCBTRVJJQUxfRUFSTFlDT04NCj4gICAgICAg
ICBoZWxwDQo+ICAgICAgICAgICBTYXkgWSBoZXJlIGlmIHlvdSB3aXNoIHRvIHVzZSBhbiBvbi1j
aGlwIFVBUlQgb24gYSBBdG1lbA0KPiAgICAgICAgICAgQVQ5MSBwcm9jZXNzb3IgYXMgdGhlIHN5
c3RlbSBjb25zb2xlICh0aGUgc3lzdGVtDQo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL3R0eS9zZXJp
YWwvYXRtZWxfc2VyaWFsLmMgYi9kcml2ZXJzL3R0eS9zZXJpYWwvYXRtZWxfc2VyaWFsLmMNCj4g
aW5kZXggMmQwOWE4OTk3NGEyLi43M2Q0MzkxOTg5OGQgMTAwNjQ0DQo+IC0tLSBhL2RyaXZlcnMv
dHR5L3NlcmlhbC9hdG1lbF9zZXJpYWwuYw0KPiArKysgYi9kcml2ZXJzL3R0eS9zZXJpYWwvYXRt
ZWxfc2VyaWFsLmMNCj4gQEAgLTI2NzMsNiArMjY3MywzMCBAQCBzdGF0aWMgc3RydWN0IGNvbnNv
bGUgYXRtZWxfY29uc29sZSA9IHsNCj4gICAgICAgICAuZGF0YSAgICAgICAgICAgPSAmYXRtZWxf
dWFydCwNCj4gIH07DQo+IA0KPiArc3RhdGljIHZvaWQgYXRtZWxfc2VyaWFsX2Vhcmx5X3dyaXRl
KHN0cnVjdCBjb25zb2xlICpjb24sIGNvbnN0IGNoYXIgKnMsDQo+ICsgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICB1bnNpZ25lZCBpbnQgbikNCj4gK3sNCj4gKyAgICAgICBzdHJ1
Y3QgZWFybHljb25fZGV2aWNlICpkZXYgPSBjb24tPmRhdGE7DQo+ICsNCj4gKyAgICAgICB1YXJ0
X2NvbnNvbGVfd3JpdGUoJmRldi0+cG9ydCwgcywgbiwgYXRtZWxfY29uc29sZV9wdXRjaGFyKTsN
Cj4gK30NCj4gKw0KPiArc3RhdGljIGludCBfX2luaXQgYXRtZWxfZWFybHlfY29uc29sZV9zZXR1
cChzdHJ1Y3QgZWFybHljb25fZGV2aWNlICpkZXZpY2UsDQo+ICsgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgY29uc3QgY2hhciAqb3B0aW9ucykNCj4gK3sNCj4gKyAg
ICAgICBpZiAoIWRldmljZS0+cG9ydC5tZW1iYXNlKQ0KPiArICAgICAgICAgICAgICAgcmV0dXJu
IC1FTk9ERVY7DQo+ICsNCj4gKyAgICAgICBkZXZpY2UtPmNvbi0+d3JpdGUgPSBhdG1lbF9zZXJp
YWxfZWFybHlfd3JpdGU7DQo+ICsNCj4gKyAgICAgICByZXR1cm4gMDsNCj4gK30NCj4gKw0KPiAr
T0ZfRUFSTFlDT05fREVDTEFSRShhdG1lbF9zZXJpYWwsICJhdG1lbCxhdDkxcm05MjAwLXVzYXJ0
IiwNCj4gKyAgICAgICAgICAgICAgICAgICBhdG1lbF9lYXJseV9jb25zb2xlX3NldHVwKTsNCj4g
K09GX0VBUkxZQ09OX0RFQ0xBUkUoYXRtZWxfc2VyaWFsLCAiYXRtZWwsYXQ5MXNhbTkyNjAtdXNh
cnQiLA0KPiArICAgICAgICAgICAgICAgICAgIGF0bWVsX2Vhcmx5X2NvbnNvbGVfc2V0dXApOw0K
PiArDQo+ICAjZGVmaW5lIEFUTUVMX0NPTlNPTEVfREVWSUNFICAgKCZhdG1lbF9jb25zb2xlKQ0K
PiANCj4gICNlbHNlDQo+IC0tDQo+IDIuMzAuMg0KPiANCg0K
