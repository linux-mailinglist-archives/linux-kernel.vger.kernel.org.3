Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BC1474AD026
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Feb 2022 05:11:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346552AbiBHEKh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Feb 2022 23:10:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234521AbiBHEKc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Feb 2022 23:10:32 -0500
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3E91C0401E5;
        Mon,  7 Feb 2022 20:10:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1644293431; x=1675829431;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=nZPIeK4ptKqoJBHxwtSGA1YF6qX3VZuiint86EQx/20=;
  b=kBDJGGwOHeE1eiU0AwDPFb+yhdWL0u9pbNu4YT8Cxn5P6lSRjrVQvm6g
   j24Eo356fCbsooqErB8nDbWFo/k7H890KstYQ6hSgDeUId4vhsPZhVNJ3
   lKz7By0iPwJ3VUjQf4OwC3DtU8JWx+b/Je0K0jrCh0U3I0u9wUKp8AoiR
   0YA8BPx15eCWqlK/E1z6mYLzbrq5/tzJC1UNQKYOj9kx+q0QyKmEsAELD
   oBoC6ObMRsQluNvtYjiUnP8sCIejd82mQMkRnzbcLQnSDEjzV8XuPr9qo
   pwUgTka0FNzOk0ZLWJrFQd9jBwpV8Tk/gZ8JVUjT3XldrvNTqlyyi0dxF
   g==;
IronPort-SDR: U16yWEcd2c6h2RaQHfljM3yllENYCCN7+WG8O73nzA+WWAgLwC24cX+LlJGtWRjwCxNZPBOQba
 nmXyjS+lU1cMUsAH/+pwfnEyecxkqcE0qDkTJkJ/3r3XaPWIdcNYpqHiRt3xIxVjKh4mrYy4CX
 a5chWVCNQhpk6C9qJazQXfHXP3GDKNh0P8J5JzpV65R8Z1zkAgAPrWpxzFBS0VEQP2fI+GC3G2
 QPiSZeNghrcHCrH/9lXuo8DeD8qB0RPi83LlJ7kd7hyVKjFX+veEmImBt0XsFlUVW8ByQe63b4
 +WGs90sy/UVvLZDoNQLDNu9r
X-IronPort-AV: E=Sophos;i="5.88,351,1635231600"; 
   d="scan'208";a="145205878"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa4.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 07 Feb 2022 21:10:30 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Mon, 7 Feb 2022 21:10:29 -0700
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.17 via Frontend
 Transport; Mon, 7 Feb 2022 21:10:29 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QUrxsi+neB09YET+ex5ld8LmLue1BGzpE9vb1rhURMyWtWPJClVT3D7qsUt0CXmsf56b69kMPrrzem8U2NP9Wx/gL/VyvKCqz9+1MhFZl/mEcbZPViZ+QDtaovfjNXABql+D13ZwzC1UuSIRk05j5dt9wT+6g9ymqjlzu/krcE+hzLyVDfdD+DsrgTRaao+3ly7iOXvQFdHaz1Q5sBPU5G8wJfJFI71Cs/zbHLX7r6tyddy19PwnSrulmV7ukzzqa1fwMkylFpsmpUM+0BZ5xQ+y/p20BKhiXqL0USYtNCE2UxNE72sSyVP5CnsYcN2ALcGZxq38Owh6wErPp2owTw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nZPIeK4ptKqoJBHxwtSGA1YF6qX3VZuiint86EQx/20=;
 b=XYNasS5DeHnSDlJXTNfZsZRDPKoWhll9rZ12gpovyuwQleYEK1jltUfiibZgIjBx9B8ZFWKpEMdxWLp6em9/tf6Z5ZtLPPw6UcSXXeFnD7knPiQEwUHSHc0k/MJZQVQk56yGzD0m+1o4ZlF75T7/yDbz0eywGgHXCJYGTDn6EGNOeiqoav1Q2Ae1gyr5KQSP7QMyo313qIcDiofxMYKI3aAoVvglkCD68ij8NGCS9kobaSNBnpCBXx6t/S4+uUe9kg3Zq20vwEUbIuCeiUZsOWe6oQcWNfahVOB08RbgSgCOl5VjNoCAr2MbIkGKtxltxVBIzCw5fKJTyGxfLuE7YA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nZPIeK4ptKqoJBHxwtSGA1YF6qX3VZuiint86EQx/20=;
 b=pjUdcb7T4HZ/5Y7/NGnZSxsudrKZXbfmiuZbP3+21/uRwsZjfR3SzI9ko9gsKEscLhCJsIctmpNtgSHvc7hsXp2QgRc78i1VNw3ri/QGc2JhzmfEOSAQrJT8+yG+VGgrB/KNr9ueG6cjdfiHmeCkVQfvb5NhzgYqORnMaj8yTXY=
Received: from SA2PR11MB4874.namprd11.prod.outlook.com (2603:10b6:806:f9::23)
 by MN2PR11MB3951.namprd11.prod.outlook.com (2603:10b6:208:13b::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4951.12; Tue, 8 Feb
 2022 04:10:25 +0000
Received: from SA2PR11MB4874.namprd11.prod.outlook.com
 ([fe80::49cd:dd25:384:e918]) by SA2PR11MB4874.namprd11.prod.outlook.com
 ([fe80::49cd:dd25:384:e918%4]) with mapi id 15.20.4951.018; Tue, 8 Feb 2022
 04:10:25 +0000
From:   <Tudor.Ambarus@microchip.com>
To:     <krzysztof.kozlowski@canonical.com>, <herbert@gondor.apana.org.au>,
        <robh+dt@kernel.org>
CC:     <davem@davemloft.net>, <Nicolas.Ferre@microchip.com>,
        <Claudiu.Beznea@microchip.com>, <alexandre.belloni@bootlin.com>,
        <linux-crypto@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/3] dt-bindings: crypto: Convert Atmel AES to yaml
Thread-Topic: [PATCH 1/3] dt-bindings: crypto: Convert Atmel AES to yaml
Thread-Index: AQHYHKHL8qImLgFE70qvWtR3NAgIig==
Date:   Tue, 8 Feb 2022 04:10:25 +0000
Message-ID: <ec358f0f-e3e2-a97b-e09a-d397edc65c72@microchip.com>
References: <20220207032405.70733-1-tudor.ambarus@microchip.com>
 <20220207032405.70733-2-tudor.ambarus@microchip.com>
 <f8387f12-24f9-4a39-e9b8-3b83f1de078d@canonical.com>
In-Reply-To: <f8387f12-24f9-4a39-e9b8-3b83f1de078d@canonical.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 414c7590-dc2d-4d6a-07b2-08d9eab8eedf
x-ms-traffictypediagnostic: MN2PR11MB3951:EE_
x-microsoft-antispam-prvs: <MN2PR11MB395110E4FB4D268E4D6C72DBF02D9@MN2PR11MB3951.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: vU2MRr0bu9vYhxMqyB2DUhJYk0y9PWItRniRVrRCDfzevB9+rcRfnyb+JEI4UGcggg7Aaix5BtSaRhoPtb7Eaa7iize3ukLhT6tV4txWYt2Ol2UifuIAPc0p7x5uAdoScXhmnfW/9FbhVo5WXB/fCQUTe+EkxlWvpPaKhGzWNzQCHySRneDF1/wyofdq17eBoByKEsBJE9kFNBZ7sqJmaDQAisjT3bhmUfem3bWbXs03NZJfwY3Lms9/e9NJrvamybu0OkbnyBV0fZTJvTFArxwNzUJ4Fs5UWXqrztJYIVwk+hwkIvZatxT3TnUkF0/JpCvlEB3Kku2IUwbeJH7bxzVa+KgkJBDRlGxWDUiSW55tmOqK5ogqCMcaA5KlooDyPlofeY1GA70nArI+6VmCl8tb9sRdKVkBoRCSQzVEgnpAgpc1AqMn+/nG9T/7abN5cvZKd7hDoxiF8JW0EIBnhmsDWPQZZ9B1kRHvTYzoyGd2G2U2G2ZPM+SinOXxMVB/8PwQyYuhJ0iyNpQMid8wvG/2TRuPnrNZvh1RYskTGKATz45gz2o53O8C0MTJ/LVIquKVHTCSBTSGHNAZGJOtlwuWNfGXGtcxKXIONne0c6ylBYN6QjyncFCiN3c5TEgU7BlkRYsUQiFqt1c3XPOS1rx3zLWQHws0oeUwtpZpD4QZUSyytWdJE6BH7bS51yQEi88f+74Hos55O2ZQNv9cCo04ZNNarJCScHiunIc9SPFRIuLPDumJra8XVnOLPYJXbNeocO0feN5J+/dRwTuQdOD241tk8uwfWlB/27yxSZB2f6cig0+5wnh4RSmqqi70swtH15ZLquEsUxzGC6Bdb9MNhp0SbGGoD0th+H7s984ycYcvgSjy/CgtHME0FLQN2D0lfofdOIKz7PT9O76TYA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA2PR11MB4874.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(316002)(54906003)(508600001)(36756003)(6512007)(38100700002)(966005)(2906002)(31696002)(110136005)(26005)(66946007)(83380400001)(31686004)(38070700005)(5660300002)(91956017)(122000001)(66446008)(8936002)(4326008)(8676002)(2616005)(66556008)(71200400001)(6486002)(64756008)(53546011)(86362001)(76116006)(66476007)(186003)(6506007)(45980500001)(43740500002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?WjZFamRqTnJyUlNJLzFVVEt5VkNrSnc0S1p4MGFSUVRiU2VwTDhTK1BtTUNl?=
 =?utf-8?B?NjU3VUUwdWdpNHdTd293MVlFZkF3TUI0K1R1U0p1OS9XUW1oZ0Q1VmtPNkhU?=
 =?utf-8?B?Z1pYRERETXdhTCtZVWUzNWc5NmtUWkIrZlRJMUU4NGlDN2l6Vnh1emt2dDN2?=
 =?utf-8?B?dHZ4N1R2aGpRK1FSK1BQa1pHRjNZSXg1L0lVNVIyMjVDOTRjTFNIRko3Mzk0?=
 =?utf-8?B?b1VxVHlwZEluZE1SZGNpTzMwTVNMWnBocjFnZ3pvdU80bnR3M3VqNnlOL0pD?=
 =?utf-8?B?RGZSV2JJTkRzRkcxWHVSMWxQeXF5Y28vSE9qamU1UmRJYyt1VUR1blJVRVVv?=
 =?utf-8?B?eFJtbWxYMldTd2I2TEI5ZFpsSk9ZZ1l2ek8wVCtRYmhjbWhQNnVySVFPb004?=
 =?utf-8?B?c3dqWHp1MlFHa3JXYUFMOXB3T0JZMFpnYnFUa3JGV3F0LzlUbGg4WUkwWWNO?=
 =?utf-8?B?ZThhUURzYzhxUDhtUCtwTVlOZUV3TkxqcmI5SXdPM2Z6MGxrdk80cmllNGFp?=
 =?utf-8?B?NWpxcEJ0OVNlSDlMT0RiOHhFS1k4MGZSNDExMEoxQk1vQjZtaitFdk5RQ3Jw?=
 =?utf-8?B?dWRiK1ExZUlYa0NiZ1FYUytYdzhQZDArd0F2cEQ2ZGNzbWxVTEVQTjhUOTNP?=
 =?utf-8?B?end1Vng0ei9JOFhnRm93a2FNWWJweUhtbmt4OHNZUTJDV1FUR1FxWTdtb2RM?=
 =?utf-8?B?TjFGQnBoSG80NTc0Q3RqUHUva3FaSU53bTYxUUNWWlhhb0RydlpRUlZiMHlO?=
 =?utf-8?B?L3l6RzZLSllKK21NSldVb1U2UmxyYUJwNTRuOHY5d3padzV0SzJOWGd2UDJY?=
 =?utf-8?B?OTMrUnM2ZU9md0F6RUtnZWREVElDYVBxVzdWbkhETldyWW1vU1E3K04vTTRw?=
 =?utf-8?B?UkszWThGaUFQK3Yya051MVVwb2xOYW5ITFhlR0Z3N2lXMVZhdzdHZTVpNm43?=
 =?utf-8?B?QnNpSHpoU1NTNEx6dkx6K0RrTW44TW9VNnhUVmpuVy9DQWI1a25EREZYL2wr?=
 =?utf-8?B?cVFLcHhUOHptaVZIMFZZNDJ4RytXUXV2c0V1Sy9CcUozSkY4RmtCZ2VGZWQw?=
 =?utf-8?B?ODhlRW1KWi9oOHNTWHYwbkRzZEpnWkwwTUZZenBaNkhCZEFCc0tXZzNOdnZZ?=
 =?utf-8?B?SHZaei9JT0drYjM3b3IxV2VyN0x5WHVxMzVhLzB1YlZFVTYyQVZlbnNZZTVo?=
 =?utf-8?B?dXVYWDY4cEpueVRiY1BGNWY0UE0yc3lrYWc0Q3RCNHdOKzZRWlY3SDBlV0g0?=
 =?utf-8?B?a2QvNTVaSFBESmUxVEV4bkJmdHgrK0IyOGJBRHczRDZRZDhFTkdIcW9ibm9V?=
 =?utf-8?B?MFJKOUJuREZIQ2x0NnZjNUJDczJva1pJYnZ0YlRuRjRCUFU1ZkNSUXEwT05U?=
 =?utf-8?B?QWpsYmJlZFZaVlNINW80WnhsNmlqdEJFTU5TdE5lUGpJZHFpSHo5K2dpUkND?=
 =?utf-8?B?dmVXbjRubWRxSnlyRUxSd2NiTFlCMjh1c2xpeHlaQzNYL0N6QVN1Y3FISTNN?=
 =?utf-8?B?WTJBU3N6R3JZdHZjSTlib1pkbUxNLzdCTjFUUUdFMFgrV2JtekhGQSt3UUM1?=
 =?utf-8?B?SmdjU250bmFpYmxwenJGanFLdHU2czE5emJYWFVXWnUvWFBXQTlGSkxVRnNh?=
 =?utf-8?B?SUJSaHlvbU5sZEU4ZHFLbUtlZzFvaDlCRklGVWdYZ1VVVVZHNlFDb2tvb1NK?=
 =?utf-8?B?QXJKLzJCVDFQQlI5MkFsZCtNZUsyd0JyN0NGNWpQckZxYkJweEJ2em9jQ3NB?=
 =?utf-8?B?bzk0TGJsbis4bkpCVGl4dlEyVkN4ZnJoUlJGRElYOStBMUQ5RFozMEIyYmIy?=
 =?utf-8?B?cHBFVWVFNWJ4VGRpbnd4Y2hsT21FOXQ2ZWpiQWRZRWMveWdEOERmWUhhQkt0?=
 =?utf-8?B?TXczK3FMSmpLVHNjcVl1WkVsL21INXdZL3BzODZ1d2VrdGlIakMyRTJXVGdE?=
 =?utf-8?B?VXduS2hVWXpMTm1veldidk9PbWNnSnJab2s4WmtYdFRNY1h6dTk2eEFuUlJG?=
 =?utf-8?B?TGxKK1VIM254UmhTZ3dYUVByUkVkZExiby8wQlNqRTZqZDlTeHgyY29rRWM5?=
 =?utf-8?B?ZEFZcFl6WGN4ZEt1V0lDa3pKZ1F5aEx6a0dOZ3ZmZFJQV2NMUGJJMzNnZEJa?=
 =?utf-8?B?a3pzZnpwQTQxSGZpamJpV2FtbTlYeDRpZS9nVE1BRlFET0pXM1IwMFkxSHpu?=
 =?utf-8?B?akNYc1NuZzI5ZWQ1R0oyYWJ3TXZiUHh1a2JYSFhVNjl3QTJZMktZMUlESGdx?=
 =?utf-8?B?VEgrT1EwWHI4b2h6bTVUZnZIRzFRPT0=?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <8ABBB835EE6E8E40A25EB3E5B94DD43C@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA2PR11MB4874.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 414c7590-dc2d-4d6a-07b2-08d9eab8eedf
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Feb 2022 04:10:25.1799
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 7+p9eSWLvD3vtdakx+ZLIjMcQFNzCcv7M7dM37AbuCidKbJ88pEQUQlsbN7vHiyZXJuVOy53NlutZnG3Sw4ojL/6QB2ijQG8BUG9JsT9clU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR11MB3951
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGksIEtyenlzenRvZiwNCg0KT24gMi83LzIyIDE3OjU2LCBLcnp5c3p0b2YgS296bG93c2tpIHdy
b3RlOg0KPiBFWFRFUk5BTCBFTUFJTDogRG8gbm90IGNsaWNrIGxpbmtzIG9yIG9wZW4gYXR0YWNo
bWVudHMgdW5sZXNzIHlvdSBrbm93IHRoZSBjb250ZW50IGlzIHNhZmUNCj4gDQo+IE9uIDA3LzAy
LzIwMjIgMDQ6MjQsIFR1ZG9yIEFtYmFydXMgd3JvdGU6DQo+PiBDb252ZXJ0IEF0bWVsIEFFUyBk
b2N1bWVudGF0aW9uIHRvIHlhbWwgZm9ybWF0LiBXaXRoIHRoZSBjb252ZXJzaW9uIHRoZQ0KPj4g
Y2xvY2sgYW5kIGNsb2NrLW5hbWVzIHByb3BlcnRpZXMgYXJlIG1hZGUgbWFuZGF0b3J5LiBUaGUg
ZHJpdmVyIHJldHVybnMNCj4+IC1FSU5WQUwgaWYgImFlc19jbGsiIGlzIG5vdCBmb3VuZCwgcmVm
bGVjdCB0aGF0IGluIHRoZSBiaW5kaW5ncyBhbmQgbWFrZQ0KPj4gdGhlIGNsb2NrIGFuZCBjbG9j
ay1uYW1lcyBwcm9wZXJ0aWVzIG1hbmRhdG9yeS4gVXBkYXRlIHRoZSBleGFtcGxlIHRvDQo+PiBi
ZXR0ZXIgZGVzY3JpYmUgaG93IG9uZSBzaG91bGQgZGVmaW5lIHRoZSBkdCBub2RlLg0KPj4NCj4+
IFNpZ25lZC1vZmYtYnk6IFR1ZG9yIEFtYmFydXMgPHR1ZG9yLmFtYmFydXNAbWljcm9jaGlwLmNv
bT4NCj4+IC0tLQ0KPj4gIC4uLi9kZXZpY2V0cmVlL2JpbmRpbmdzL2NyeXB0by9hdG1lbCxhZXMu
eWFtbCB8IDY1ICsrKysrKysrKysrKysrKysrKysNCj4+ICAuLi4vYmluZGluZ3MvY3J5cHRvL2F0
bWVsLWNyeXB0by50eHQgICAgICAgICAgfCAyMCAtLS0tLS0NCj4+ICAyIGZpbGVzIGNoYW5nZWQs
IDY1IGluc2VydGlvbnMoKyksIDIwIGRlbGV0aW9ucygtKQ0KPj4gIGNyZWF0ZSBtb2RlIDEwMDY0
NCBEb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3MvY3J5cHRvL2F0bWVsLGFlcy55YW1s
DQo+Pg0KPj4gZGlmZiAtLWdpdCBhL0RvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9j
cnlwdG8vYXRtZWwsYWVzLnlhbWwgYi9Eb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3Mv
Y3J5cHRvL2F0bWVsLGFlcy55YW1sDQo+PiBuZXcgZmlsZSBtb2RlIDEwMDY0NA0KPj4gaW5kZXgg
MDAwMDAwMDAwMDAwLi5mNzdlYzA0ZGJhYmUNCj4+IC0tLSAvZGV2L251bGwNCj4+ICsrKyBiL0Rv
Y3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9jcnlwdG8vYXRtZWwsYWVzLnlhbWwNCj4+
IEBAIC0wLDAgKzEsNjUgQEANCj4+ICsjIFNQRFgtTGljZW5zZS1JZGVudGlmaWVyOiBHUEwtMi4w
LW9ubHkNCj4+ICslWUFNTCAxLjINCj4+ICstLS0NCj4+ICskaWQ6IGh0dHA6Ly9kZXZpY2V0cmVl
Lm9yZy9zY2hlbWFzL2NyeXB0by9hdG1lbCxhZXMueWFtbCMNCj4+ICskc2NoZW1hOiBodHRwOi8v
ZGV2aWNldHJlZS5vcmcvbWV0YS1zY2hlbWFzL2NvcmUueWFtbCMNCj4+ICsNCj4+ICt0aXRsZTog
QXRtZWwgQWR2YW5jZWQgRW5jcnlwdGlvbiBTdGFuZGFyZCAoQUVTKSBIVyBjcnlwdG9ncmFwaGlj
IGFjY2VsZXJhdG9yDQo+PiArDQo+PiArbWFpbnRhaW5lcnM6DQo+PiArICAtIFR1ZG9yIEFtYmFy
dXMgPHR1ZG9yLmFtYmFydXNAbWljcm9jaGlwLmNvbT4NCj4+ICsNCj4+ICtwcm9wZXJ0aWVzOg0K
Pj4gKyAgY29tcGF0aWJsZToNCj4+ICsgICAgY29uc3Q6IGF0bWVsLGF0OTFzYW05ZzQ2LWFlcw0K
Pj4gKw0KPj4gKyAgcmVnOg0KPj4gKyAgICBtYXhJdGVtczogMQ0KPj4gKw0KPj4gKyAgaW50ZXJy
dXB0czoNCj4+ICsgICAgbWF4SXRlbXM6IDENCj4+ICsNCj4+ICsgIGNsb2NrczoNCj4+ICsgICAg
bWF4SXRlbXM6IDENCj4+ICsNCj4+ICsgIGNsb2NrLW5hbWVzOg0KPj4gKyAgICBjb25zdDogYWVz
X2Nsaw0KPj4gKw0KPj4gKyAgZG1hczoNCj4+ICsgICAgaXRlbXM6DQo+PiArICAgICAgLSBkZXNj
cmlwdGlvbjogVFggRE1BIENoYW5uZWwNCj4+ICsgICAgICAtIGRlc2NyaXB0aW9uOiBSWCBETUEg
Q2hhbm5lbA0KPj4gKw0KPj4gKyAgZG1hLW5hbWVzOg0KPj4gKyAgICBpdGVtczoNCj4+ICsgICAg
ICAtIGNvbnN0OiB0eA0KPj4gKyAgICAgIC0gY29uc3Q6IHJ4DQo+PiArDQo+PiArcmVxdWlyZWQ6
DQo+PiArICAtIGNvbXBhdGlibGUNCj4+ICsgIC0gcmVnDQo+PiArICAtIGludGVycnVwdHMNCj4+
ICsgIC0gY2xvY2tzDQo+PiArICAtIGNsb2NrLW5hbWVzDQo+PiArICAtIGRtYXMNCj4+ICsgIC0g
ZG1hLW5hbWVzDQo+PiArDQo+PiArYWRkaXRpb25hbFByb3BlcnRpZXM6IGZhbHNlDQo+PiArDQo+
PiArZXhhbXBsZXM6DQo+PiArICAtIHwNCj4+ICsgICAgI2luY2x1ZGUgPGR0LWJpbmRpbmdzL2lu
dGVycnVwdC1jb250cm9sbGVyL2lycS5oPg0KPj4gKyAgICAjaW5jbHVkZSA8ZHQtYmluZGluZ3Mv
aW50ZXJydXB0LWNvbnRyb2xsZXIvYXJtLWdpYy5oPg0KPj4gKyAgICAjaW5jbHVkZSA8ZHQtYmlu
ZGluZ3MvY2xvY2svYXQ5MS5oPg0KPj4gKyAgICAjaW5jbHVkZSA8ZHQtYmluZGluZ3MvZG1hL2F0
OTEuaD4NCj4gDQo+IE9uZSBlbXB0eSBsaW5lIGZvciByZWFkYWJpbGl0eS4NCg0KT2suDQoNCj4g
DQo+PiArICAgIGFlczogYWVzQGY4MDM4MDAwIHsNCj4gDQo+IEdlbmVyaWMgbm9kZSBuYW1lLCBz
byAiY3J5cHRvIi4NCg0KSG0sIEknbSBub3QgY29udmluY2VkIHdoeSwgd291bGQgeW91IHBsZWFz
ZSBnaXZlIG1vcmUgZGV0YWlscyBhYm91dCB0aGlzDQpyZXF1aXJlbWVudD8gVGhpcyBJUCBpcyBj
YXBhYmxlIG9mIGRvaW5nIGp1c3QgQUVTIG9wZXJhdGlvbnMsIEkgZmluZCBpdA0KZ2VuZXJpYyBl
bm91Z2guIFdlIHVzZSB0aGUgImFlcyIgbmFtZSBvbiBhbGwgb3VyIFNvQ3MgdGhhdCBoYXZlIGEg
dmVyc2lvbg0Kb2YgdGhpcyBJUCwgdGhhdCB3b3VsZCBiZSBxdWl0ZSBhIGNoYW5nZS4gU28gSSB3
b3VsZCBwcmVmZXIgdG8ga2VlcCB0aGUNCiJhZXMiIG5hbWUgaWYgcG9zc2libGUuDQoNCj4gDQo+
PiArICAgICAgY29tcGF0aWJsZSA9ICJhdG1lbCxhdDkxc2FtOWc0Ni1hZXMiOw0KPj4gKyAgICAg
IHJlZyA9IDwweGUxODEwMDAwIDB4MTAwPjsNCj4+ICsgICAgICBpbnRlcnJ1cHRzID0gPEdJQ19T
UEkgMjcgSVJRX1RZUEVfTEVWRUxfSElHSD47DQo+PiArICAgICAgY2xvY2tzID0gPCZwbWMgUE1D
X1RZUEVfUEVSSVBIRVJBTCAyNz47DQo+PiArICAgICAgY2xvY2stbmFtZXMgPSAiYWVzX2NsayI7
DQo+PiArICAgICAgZG1hcyA9IDwmZG1hMCBBVDkxX1hETUFDX0RUX1BFUklEKDEpPiwNCj4+ICsg
ICAgICAgICAgICAgPCZkbWEwIEFUOTFfWERNQUNfRFRfUEVSSUQoMik+Ow0KPj4gKyAgICAgIGRt
YS1uYW1lcyA9ICJ0eCIsICJyeCI7DQo+PiArICAgICAgc3RhdHVzPSAib2theSI7DQo+PiArICAg
IH07DQo+IA0KPiBEcm9wIHRoZSBzdGF0dXMgcHJvcGVydHkuDQoNCk9rLiBUaGFua3MgZm9yIHJl
dmlld2luZy4NCnRhDQoNCj4gDQo+IEJlc3QgcmVnYXJkcywNCj4gS3J6eXN6dG9mDQoNCg==
