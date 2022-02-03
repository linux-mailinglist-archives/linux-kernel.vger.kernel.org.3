Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 06FB84A7E3D
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Feb 2022 04:10:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349166AbiBCDKV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Feb 2022 22:10:21 -0500
Received: from smtprelay-out1.synopsys.com ([149.117.87.133]:58146 "EHLO
        smtprelay-out1.synopsys.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234912AbiBCDKT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Feb 2022 22:10:19 -0500
Received: from mailhost.synopsys.com (sv2-mailhost2.synopsys.com [10.205.2.134])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (Client CN "mailhost.synopsys.com", Issuer "SNPSica2" (verified OK))
        by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id 1FEC2C011E;
        Thu,  3 Feb 2022 03:10:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1643857819; bh=NaJCGFmWgyzwwARmTRc656RNaTiTPB9cYweCnM6mEZ8=;
        h=From:To:CC:Subject:Date:References:In-Reply-To:From;
        b=ZxTenzqZHAjc73k7Wr+UPv9ntyhrLEEpW/IQYhO2Q1K+zbadjYBM3i1ejIJmaPEsD
         Gw0D0puVAxuq+NtnwxeY5QsgWT6Ug98IkEpIlbYKRf9aZyq/yvhdJVthwgOmJfq9ly
         Ty4Y2Ng13F2Xf+Ah4skQSOxmX4b4KoQD4sFb6+b37SGD8rHe3M9zzih0a2G9cAQYgP
         /0iNuXeeUUwyXDnH1kxD63RZL8ObcNbEh4a/yqLM3Coj6Qdh/kccvE/8uIE88ZlW3x
         HlZodx80/hfiWJeGmvZG0rgVqBJg12KKLtT/B3TDwp/iuscNGk1eBRQLXoBJ01veIG
         vAqstVHVSVIaA==
Received: from o365relay-in.synopsys.com (us03-o365relay3.synopsys.com [10.4.161.139])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (Client CN "o365relay-in.synopsys.com", Issuer "Entrust Certification Authority - L1K" (verified OK))
        by mailhost.synopsys.com (Postfix) with ESMTPS id 425EEA00A0;
        Thu,  3 Feb 2022 03:10:16 +0000 (UTC)
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1anam02lp2043.outbound.protection.outlook.com [104.47.57.43])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client CN "mail.protection.outlook.com", Issuer "DigiCert Cloud Services CA-1" (verified OK))
        by o365relay-in.synopsys.com (Postfix) with ESMTPS id D1EA8800B6;
        Thu,  3 Feb 2022 03:10:15 +0000 (UTC)
Authentication-Results: o365relay-in.synopsys.com; dmarc=pass (p=reject dis=none) header.from=synopsys.com
Authentication-Results: o365relay-in.synopsys.com; spf=pass smtp.mailfrom=thinhn@synopsys.com
Authentication-Results: o365relay-in.synopsys.com;
        dkim=pass (1024-bit key; unprotected) header.d=synopsys.com header.i=@synopsys.com header.b="PqSAPrni";
        dkim-atps=neutral
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XR99XBFlIbCmIyBfhVZi49q8C7CUpUQaiztX5Sx4wrjmRl6F7QaopeAjGlWJehFcd5jbOpLec5xI6cQxSJ7wsGidajmfwkr2OwlF0nNEIv41gWHtYjOb2J2iwx2vKA8YLxpflw51d1UATvRWNuP7nEfyge+i8hhzNqSz3KDm/gzovIEpViaV79zhjZD9iuXBnt9nkxsrDutZKzvXnz/xPJ0tjsHyNjOqWvMZwPNSX5w8mcs85ExjJKAiKCNdu+k6WNL8CNZ5/zc9SHfjF3tfj77vEWU9WuG55zKqzRDCtHzt3VQcIqG108BDeMFKhjFJlF7Yi13pniSfpVTvBqpGxA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NaJCGFmWgyzwwARmTRc656RNaTiTPB9cYweCnM6mEZ8=;
 b=f/5OL/YUNjIdPeLgIKe84xDey3u30Vy5JZBRoKacRb3Mq22FYVo302W8DF6Mi1pipxWSaAUKHPjtDcGeb53O7kaZxApeRatAhHecVibCFfBuQzQRERWbOni50kaf6S9+5E+MRLmsKMXOir3zHKC9nlCtxxL5ULUIKLkKSI6dAu8MyzBiVxqq8BLyF4lDSmQmjq5SuOgiIqp4AOZSqKjM5DITCpnAaT+T3Hn6qFhu32NJbhsAFTLNh7iWXiVwKx/Z7tPx/q2eP1pQMpdffVTDHAcAgVlPpiCsgXzAN49ZV88ohjBT7XIkiP1BMmJAAeyLbM6rHMK7UYe8nlqMrBs2gQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NaJCGFmWgyzwwARmTRc656RNaTiTPB9cYweCnM6mEZ8=;
 b=PqSAPrniDkob1vw6LuCzgEl7caEE598kf8hOCikqD6RsWorVFC4+qKa1vHMjK5nJX32ZyqYlGDHFiOH5ZHhpgxm8E/zFq7LaddpclKdOMywQrgjszd9E4IHKJOssXzhneC5ZjJ01IY0JP/9+5dFFK3Hl7aM/izzndxuKHA/e6eg=
Received: from BYAPR12MB4791.namprd12.prod.outlook.com (2603:10b6:a03:10a::12)
 by CH0PR12MB5137.namprd12.prod.outlook.com (2603:10b6:610:bc::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4951.12; Thu, 3 Feb
 2022 03:10:06 +0000
Received: from BYAPR12MB4791.namprd12.prod.outlook.com
 ([fe80::c5f4:5df4:b5bf:b13e]) by BYAPR12MB4791.namprd12.prod.outlook.com
 ([fe80::c5f4:5df4:b5bf:b13e%3]) with mapi id 15.20.4930.022; Thu, 3 Feb 2022
 03:10:05 +0000
X-SNPS-Relay: synopsys.com
From:   Thinh Nguyen <Thinh.Nguyen@synopsys.com>
To:     Sean Anderson <sean.anderson@seco.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>
CC:     Robert Hancock <robert.hancock@calian.com>,
        Baruch Siach <baruch@tkos.co.il>,
        Felipe Balbi <balbi@kernel.org>,
        Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Balaji Prakash J <bjagadee@codeaurora.org>
Subject: Re: [PATCH v3 4/7] usb: dwc3: Program GFLADJ
Thread-Topic: [PATCH v3 4/7] usb: dwc3: Program GFLADJ
Thread-Index: AQHYE7lxNJSV3L4eDkuXLlbBVDC+RKyBL6KA
Date:   Thu, 3 Feb 2022 03:10:05 +0000
Message-ID: <ddddf92b-79ff-1db6-23a9-51d1d790f794@synopsys.com>
References: <20220127200636.1456175-1-sean.anderson@seco.com>
 <20220127200636.1456175-5-sean.anderson@seco.com>
In-Reply-To: <20220127200636.1456175-5-sean.anderson@seco.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=synopsys.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: a8e3f517-de1b-42b3-b306-08d9e6c2ad55
x-ms-traffictypediagnostic: CH0PR12MB5137:EE_
x-microsoft-antispam-prvs: <CH0PR12MB5137D1D74D8959D8355A9CAFAA289@CH0PR12MB5137.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:3276;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: MTUuYbZatE8muMSDLBIZd5ZZBpuLNHX3sJT1OA1uW7eiW/XC7TTSHCdZro5Pj6J8TmmzHojryebou8gHcgz8EbOtPTJIndvg/aL9FiB4NprG9QPvHMdSfMFSVBnr3CbffM8nV4Axp7JpWnjfatDJD9q9KN2bYgMeuS1IOaDTsmnDG6ajAARf6LbQjZk4kf/VGbf0UjhUQS1IsY3DIoutuMmKvluNc5hpAFPk9JHXDm3GnnlsoW5ZnvBMw16yJcE7B11Jg/lOksUUgszcjPJR5wo3U2Ygpzvyw9yY8an3E0//upAbWokZXDy0jIHyA5qf7qT7wBIshY37+LhzqCUfDIeosjcji/HMaiTMyQSNCK/F9MRmDoVCmdD6gj/T6ozIFqXb+mha1jqkX5xmIR1tVJ31gb7ksFQTSZhJRBRbnYqQOJkP/gXRD7S75uz86gxpUv+t0ExE77U6CxsLIVkbwmODzxpxh+nk9WoiZW0MkFCByDzOGcUVPMWCsFYzdXROqX2VNz++OIIJ2bfdPSRlyxwt81aLbCzx0TTlU8Yzd81BXLR+6pJYuUZvTrWCso7h7LzykzI/IqNdLDS9QOLYBSjCujZE4jepulL9ZXYLD86KyVJg9/qEtDTlfSIHGKsQV8YiWNhzKzXd+YLNJXg3uIxB4ZJZW27hNeS+9DY5yvkHtkc2f/B2wUuN/my4cgBt0Th8P+WCYT9kJnMqm7vqvQSPdF7qEQjMfPjTobPvNHcQB9mnS6C2R+kCFRWQfMdo0PQIyeLH3UkSHWQVPlME1g==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR12MB4791.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(2906002)(26005)(186003)(71200400001)(31696002)(2616005)(6506007)(86362001)(6512007)(122000001)(38100700002)(83380400001)(38070700005)(316002)(31686004)(54906003)(36756003)(110136005)(5660300002)(8936002)(64756008)(66946007)(4326008)(8676002)(66446008)(66556008)(66476007)(76116006)(508600001)(6486002)(45980500001)(43740500002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Mzk5MU03YzFyMzFESE5lZDJWMzBUWkxLV25HTHB4L0pmV1NoK2RPWktXclM1?=
 =?utf-8?B?ejR0OG8wY3pIQ2hPVy9CY2JEN0pKVWhuWktIYnNRdHVxVUhsUi81dm5YQjA5?=
 =?utf-8?B?SEw4TDRlbTJ4bkpjZlo4cUprNHF1bG9HbEV6S2VKUkI4b2toMUFRVTl4SUlr?=
 =?utf-8?B?dFUzU08wNjlyMlc5QjJ3dU5xdVhKOW4vY3NzSGlaeW5saXBRSVIvdU9hMDNX?=
 =?utf-8?B?TC96U2ZxTmM1eXF1NHEvQ3M2RW1hY1NJcEIvVUpRVHJUdytod2lPVGpWdVRi?=
 =?utf-8?B?NU1WcWNlN09GWkVSS1FoRE5wZnVzNmV5UjRJdS90TzRaT3NNYmxXK2pYclZ4?=
 =?utf-8?B?aXMxd2FDSlRIQ096aTJhYWQvZTQrUEZVSUgyRDBmN2UyRFpXUEFqMkFsL3hs?=
 =?utf-8?B?TlRrMTFMNWkzRk9rZm9CM3BCQzhyTTRQb0hDb0EwQnRRM0JZRFlIcXJTUGJT?=
 =?utf-8?B?OXc0Vi82L0xENVNZTzViN05EZHVUR0l4UjM5cHNFTVZ6QnlJUS9yZFNSckdk?=
 =?utf-8?B?Q1VYUVNwUjVqZzhkZTNqUVJrTE0zZlVrcUh6ZFRwbCtxQ2tkUUJtL0tTdzFK?=
 =?utf-8?B?aUFMRmZNVHhPbm9jUkNvbm43aEtnd1FzTngvZ0NEVUM0TUI0MHQrSnNUZmRi?=
 =?utf-8?B?MSticVFBYUxNb2lWa1Q3MTAxMnh5TDFRL05PQnFQTldDOWdKY2p1d0JzSDZx?=
 =?utf-8?B?VlZXWWkvR1NTa1c2WDFRSDVDdFZXZStJZmZrbmNLWk5qNE1VRWVOdU45VXkv?=
 =?utf-8?B?eUI3RWs1TVAzZDVUZ1hlM3Ivb2dXRkFONHRkRmtZbndrVXIzN3ZrNWNZY3Ry?=
 =?utf-8?B?eGtJSkhBbitKbUYrZXZYaGZiQWNwOFVvU0twa1p4SG9OZitxcjFvNWJuM05L?=
 =?utf-8?B?UmVTWU93ZTZqRXlZRWhBVkgxN21udkZDMzdYUk1kREEwMktCQTliL2cxT2NQ?=
 =?utf-8?B?dHZLUU1udGNmRDBCMFJCdVBxRStRQUFjdzI5Y0pFMXBIK1RWN1RUcURSYWpZ?=
 =?utf-8?B?TWgyOURGa0dxLzd6S210ZkNyU0pqN282SzEzMkhxOVZBdGRjTjkvZDhobXha?=
 =?utf-8?B?UXhLQlRXRnJ5OHAzMkRpektia0JMVTNRbGlHM0xmbXhPb05YeVJsYVZOUjRT?=
 =?utf-8?B?aDFaRDJFS0NRZ05WWTdqeEwvZmtXandEMlA3Vk9DbkVVaFVObm5jYXFZcXpZ?=
 =?utf-8?B?cWFOYitJRSsvWjRvdW1DbVdYcFV5Qm82YUFqNWUyanFhVk52TEZGcjBlN0xB?=
 =?utf-8?B?TksxVlRGV2w0SDh1ZHRYWlNZVEtYY1JicURSRC8vSXdUK2xqNTlSWko3VGR1?=
 =?utf-8?B?a3dMM2pFK21nSTZoMGdBOFZyV1d1UTFJWEVucDVWZ1hyVTZabXpBZ0JSRWlC?=
 =?utf-8?B?bnMvZm1pVFJUb3EweGlVQmJXekIwMHlqSms2S2xlS3N0c3hGSFZ4Y2dyd3du?=
 =?utf-8?B?RVVjY0xkKzhOQnVBaEpadzFzZVJsT1ZJSHN0ejdkb0c2N1NmZGJFNFRiM2Y4?=
 =?utf-8?B?KzNMV0dQQWR6RlRCcElNRDViREIzeVQ0MHIwNkpPRWp4VHZDMFhRK0FPWjNM?=
 =?utf-8?B?bC9UQ05UL1VrNi9zTWI5ZWl5VEEzcEJpUTV5UCt4TEw3bGJGd29RTmtheDQr?=
 =?utf-8?B?QnNpQzVVMWkwbk9rdDdUbFZ3SHhycWVXajZ2dENLa3RsWFB1V2Z2S2JIbjFD?=
 =?utf-8?B?YVd6MUgrVy9iWW5SSzZoV0xkek5qSTA2RVQrYm1IZ3UvcE1vZDdta0U3MW10?=
 =?utf-8?B?ekYxLytKaHNpNGFtcDl4MEVCdlg3UDJMSnBiZEpVVlRqaDNrZ1RSMGlvL21O?=
 =?utf-8?B?TjV3OTlaMTNHUzB3R0ZsYmZkNnFVZkNhdUU4QzFLblR3S1g0aDgyOS8yRVBj?=
 =?utf-8?B?c3RidHoyNGhiVE1kaGtYTVpWb250cjROY0RMNFhLYmFMQWVIcnNWb0NJNGhy?=
 =?utf-8?B?ZWNTM3kxUTBSc0FWYVEvRzNSR01vMkpwQkhZenR1V2hKcVNkRkJncFM3U2Rk?=
 =?utf-8?B?TmNYTGprU2pmLytoY2FobnhjQm8zMXlndUFiWTFlZlVLaW5uTkpxc1l2eUJN?=
 =?utf-8?B?a1lMN0t0bmh3NUdZaEJycVhoRmczWlE3SEw0MVg5cE9OOE1GemMvbVdlYnNX?=
 =?utf-8?B?TzN6ZTZaV0pNRmpYK0VTRXRjNHJSUTIwejI4aFFLYURINmVYL29IVWg2WjVZ?=
 =?utf-8?B?V2c9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <0E9DAB14B8E26843B3A0527F2B70AC12@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: synopsys.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB4791.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a8e3f517-de1b-42b3-b306-08d9e6c2ad55
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Feb 2022 03:10:05.5129
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: c33c9f88-1eb7-4099-9700-16013fd9e8aa
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: c4ooxt0xf29go2grucjHw73H8kqys55d8XbARocfopWD0ze6l/jM+fu1fqtZ7q+Z97wO93P1NYSeQZFlgv1fhw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB5137
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

U2VhbiBBbmRlcnNvbiB3cm90ZToNCj4gR1VDVEwuUkVGQ0xLUEVSIGNhbiBvbmx5IGFjY291bnQg
Zm9yIGNsb2NrIGZyZXF1ZW5jaWVzIHdpdGggaW50ZWdlcg0KPiBwZXJpb2RzLiBUbyBhZGRyZXNz
IHRoaXMsIHByb2dyYW0gUkVGQ0xLX0ZMQURKIHdpdGggdGhlIHJlbGF0aXZlIGVycm9yDQo+IGNh
dXNlZCBieSBwZXJpb2QgdHJ1bmNhdGlvbi4gVGhlIGZvcm11bGEgZ2l2ZW4gaW4gdGhlIHJlZ2lz
dGVyIHJlZmVyZW5jZQ0KPiBoYXMgYmVlbiByZWFycmFuZ2VkIHRvIGFsbG93IGNhbGN1bGF0aW9u
IGJhc2VkIG9uIHJhdGUgKGluc3RlYWQgb2YNCj4gcGVyaW9kKSwgYW5kIHRvIGFsbG93IGZvciBm
aXhlZC1wb2ludCBhcml0aG1ldGljLg0KPiANCj4gQWRkaXRpb25hbGx5LCBjYWxjdWxhdGUgYSB2
YWx1ZSBmb3IgMjQwTUhaREVDUi4gVGhpcyBjb25maWd1cmVzIGENCj4gc2ltdWxhdGVkIDI0ME1o
eiBjbG9jayB1c2luZyBhIGNvdW50ZXIgd2l0aCBvbmUgZnJhY3Rpb25hbCBiaXQgKFBMUzEpLg0K
PiANCj4gVGhpcyByZWdpc3RlciBpcyBwcm9ncmFtbWVkIG9ubHkgZm9yIHZlcnNpb25zID49IDIu
NTBhLCBzaW5jZSB0aGlzIGlzDQo+IHRoZSBjaGVjayBhbHNvIHVzZWQgYnkgY29tbWl0IGRiMmJl
NGU5ZTMwYyAoInVzYjogZHdjMzogQWRkIGZyYW1lIGxlbmd0aA0KPiBhZGp1c3RtZW50IHF1aXJr
IikuDQo+IA0KPiBTaWduZWQtb2ZmLWJ5OiBTZWFuIEFuZGVyc29uIDxzZWFuLmFuZGVyc29uQHNl
Y28uY29tPg0KPiBSZXZpZXdlZC1ieTogUm9iZXJ0IEhhbmNvY2sgPHJvYmVydC5oYW5jb2NrQGNh
bGlhbi5jb20+DQo+IFRlc3RlZC1ieTogUm9iZXJ0IEhhbmNvY2sgPHJvYmVydC5oYW5jb2NrQGNh
bGlhbi5jb20+DQo+IC0tLQ0KPiANCj4gQ2hhbmdlcyBpbiB2MzoNCj4gLSBEZWZpbmUgZWFjaCB2
YXJpYWJsZSBvbiBpdHMgb3duIGxpbmUNCj4gLSBVcGRhdGUgY29tbWVudCB0byBub3RlcyBzb21l
IHRoaW5ncyBtZW50aW9uZWQgZHVyaW5nIHJldmlldw0KPiANCj4gQ2hhbmdlcyBpbiB2MjoNCj4g
LSBBbHNvIHByb2dyYW0gR0ZMQURKLjI0ME1IWkRFQ1INCj4gLSBEb24ndCBwcm9ncmFtIEdGTEFE
SiBpZiB0aGUgdmVyc2lvbiBpcyA8IDIuNTBhDQo+IA0KPiAgZHJpdmVycy91c2IvZHdjMy9jb3Jl
LmMgfCAzOSArKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKy0NCj4gIGRyaXZl
cnMvdXNiL2R3YzMvY29yZS5oIHwgIDMgKysrDQo+ICAyIGZpbGVzIGNoYW5nZWQsIDQxIGluc2Vy
dGlvbnMoKyksIDEgZGVsZXRpb24oLSkNCj4gDQo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL3VzYi9k
d2MzL2NvcmUuYyBiL2RyaXZlcnMvdXNiL2R3YzMvY29yZS5jDQo+IGluZGV4IDM4ZmVmNWM3NDM1
OS4uMThhZGRkZmJhM2RhIDEwMDY0NA0KPiAtLS0gYS9kcml2ZXJzL3VzYi9kd2MzL2NvcmUuYw0K
PiArKysgYi9kcml2ZXJzL3VzYi9kd2MzL2NvcmUuYw0KPiBAQCAtMzQ4LDYgKzM0OCw4IEBAIHN0
YXRpYyB2b2lkIGR3YzNfZnJhbWVfbGVuZ3RoX2FkanVzdG1lbnQoc3RydWN0IGR3YzMgKmR3YykN
Cj4gIHN0YXRpYyB2b2lkIGR3YzNfcmVmX2Nsa19wZXJpb2Qoc3RydWN0IGR3YzMgKmR3YykNCj4g
IHsNCj4gIAl1bnNpZ25lZCBsb25nIHBlcmlvZDsNCj4gKwl1bnNpZ25lZCBsb25nIGZsYWRqOw0K
PiArCXVuc2lnbmVkIGxvbmcgZGVjcjsNCj4gIAl1bnNpZ25lZCBsb25nIHJhdGU7DQo+ICAJdTMy
IHJlZzsNCj4gIA0KPiBAQCAtMzU4LDYgKzM2MCw3IEBAIHN0YXRpYyB2b2lkIGR3YzNfcmVmX2Ns
a19wZXJpb2Qoc3RydWN0IGR3YzMgKmR3YykNCj4gIAkJcGVyaW9kID0gTlNFQ19QRVJfU0VDIC8g
cmF0ZTsNCj4gIAl9IGVsc2UgaWYgKGR3Yy0+cmVmX2Nsa19wZXIpIHsNCj4gIAkJcGVyaW9kID0g
ZHdjLT5yZWZfY2xrX3BlcjsNCj4gKwkJcmF0ZSA9IE5TRUNfUEVSX1NFQyAvIHBlcmlvZDsNCj4g
IAl9IGVsc2Ugew0KPiAgCQlyZXR1cm47DQo+ICAJfQ0KPiBAQCAtMzY2LDkgKzM2OSw0MyBAQCBz
dGF0aWMgdm9pZCBkd2MzX3JlZl9jbGtfcGVyaW9kKHN0cnVjdCBkd2MzICpkd2MpDQo+ICAJcmVn
ICY9IH5EV0MzX0dVQ1RMX1JFRkNMS1BFUl9NQVNLOw0KPiAgCXJlZyB8PSAgRklFTERfUFJFUChE
V0MzX0dVQ1RMX1JFRkNMS1BFUl9NQVNLLCBwZXJpb2QpOw0KPiAgCWR3YzNfd3JpdGVsKGR3Yy0+
cmVncywgRFdDM19HVUNUTCwgcmVnKTsNCj4gKw0KPiArCWlmIChEV0MzX1ZFUl9JU19QUklPUihE
V0MzLCAyNTBBKSkNCj4gKwkJcmV0dXJuOw0KPiArDQo+ICsJLyoNCj4gKwkgKiBUaGUgY2FsY3Vs
YXRpb24gYmVsb3cgaXMNCj4gKwkgKg0KPiArCSAqIDEyNTAwMCAqIChOU0VDX1BFUl9TRUMgLyAo
cmF0ZSAqIHBlcmlvZCkgLSAxKQ0KPiArCSAqDQo+ICsJICogYnV0IHJlYXJyYW5nZWQgZm9yIGZp
eGVkLXBvaW50IGFyaXRobWV0aWMuIFRoZSBkaXZpc2lvbiBtdXN0IGJlDQo+ICsJICogNjQtYml0
IGJlY2F1c2UgMTI1MDAwICogTlNFQ19QRVJfU0VDIGRvZXNuJ3QgZml0IGluIDMyIGJpdHMgKGFu
ZA0KPiArCSAqIG5laXRoZXIgZG9lcyByYXRlICogcGVyaW9kKS4NCj4gKwkgKg0KPiArCSAqIE5v
dGUgdGhhdCByYXRlICogcGVyaW9kIH49IE5TRUNfUEVSX1NFQ09ORCwgbWludXMgdGhlIG51bWJl
ciBvZg0KPiArCSAqIG5hbm9zZWNvbmRzIG9mIGVycm9yIGNhdXNlZCBieSB0aGUgdHJ1bmNhdGlv
biB3aGljaCBoYXBwZW5lZCBkdXJpbmcNCj4gKwkgKiB0aGUgZGl2aXNpb24gd2hlbiBjYWxjdWxh
dGluZyByYXRlIG9yIHBlcmlvZCAod2hpY2hldmVyIG9uZSB3YXMNCj4gKwkgKiBkZXJpdmVkIGZy
b20gdGhlIG90aGVyKS4gV2UgZmlyc3QgY2FsY3VsYXRlIHRoZSByZWxhdGl2ZSBlcnJvciwgdGhl
bg0KPiArCSAqIHNjYWxlIGl0IHRvIHVuaXRzIG9mIDggcHBtLg0KPiArCSAqLw0KPiArCWZsYWRq
ID0gZGl2NjRfdTY0KDEyNTAwMFVMTCAqIE5TRUNfUEVSX1NFQywgKHU2NClyYXRlICogcGVyaW9k
KTsNCj4gKwlmbGFkaiAtPSAxMjUwMDA7DQo+ICsNCj4gKwkvKg0KPiArCSAqIFRoZSBkb2N1bWVu
dGVkIDI0ME1IeiBjb25zdGFudCBpcyBzY2FsZWQgYnkgMiB0byBnZXQgUExTMSBhcyB3ZWxsLg0K
PiArCSAqLw0KPiArCWRlY3IgPSA0ODAwMDAwMDAgLyByYXRlOw0KPiArDQo+ICsJcmVnID0gZHdj
M19yZWFkbChkd2MtPnJlZ3MsIERXQzNfR0ZMQURKKTsNCj4gKwlyZWcgJj0gfkRXQzNfR0ZMQURK
X1JFRkNMS19GTEFESl9NQVNLDQo+ICsJICAgICYgIH5EV0MzX0dGTEFESl8yNDBNSFpERUNSDQo+
ICsJICAgICYgIH5EV0MzX0dGTEFESl8yNDBNSFpERUNSX1BMUzE7DQo+ICsJcmVnIHw9IEZJRUxE
X1BSRVAoRFdDM19HRkxBREpfUkVGQ0xLX0ZMQURKX01BU0ssIGZsYWRqKQ0KPiArCSAgICB8ICBG
SUVMRF9QUkVQKERXQzNfR0ZMQURKXzI0ME1IWkRFQ1IsIGRlY3IgPj4gMSkNCj4gKwkgICAgfCAg
RklFTERfUFJFUChEV0MzX0dGTEFESl8yNDBNSFpERUNSX1BMUzEsIGRlY3IgJiAxKTsNCj4gKwlk
d2MzX3dyaXRlbChkd2MtPnJlZ3MsIERXQzNfR0ZMQURKLCByZWcpOw0KPiAgfQ0KPiAgDQo+IC0N
Cj4gIC8qKg0KPiAgICogZHdjM19mcmVlX29uZV9ldmVudF9idWZmZXIgLSBGcmVlcyBvbmUgZXZl
bnQgYnVmZmVyDQo+ICAgKiBAZHdjOiBQb2ludGVyIHRvIG91ciBjb250cm9sbGVyIGNvbnRleHQg
c3RydWN0dXJlDQo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL3VzYi9kd2MzL2NvcmUuaCBiL2RyaXZl
cnMvdXNiL2R3YzMvY29yZS5oDQo+IGluZGV4IDQ1Y2ZhN2Q5ZjI3YS4uZWI5YzFlZmNlZDA1IDEw
MDY0NA0KPiAtLS0gYS9kcml2ZXJzL3VzYi9kd2MzL2NvcmUuaA0KPiArKysgYi9kcml2ZXJzL3Vz
Yi9kd2MzL2NvcmUuaA0KPiBAQCAtMzg4LDYgKzM4OCw5IEBADQo+ICAvKiBHbG9iYWwgRnJhbWUg
TGVuZ3RoIEFkanVzdG1lbnQgUmVnaXN0ZXIgKi8NCj4gICNkZWZpbmUgRFdDM19HRkxBREpfMzBN
SFpfU0RCTkRfU0VMCQlCSVQoNykNCj4gICNkZWZpbmUgRFdDM19HRkxBREpfMzBNSFpfTUFTSwkJ
CTB4M2YNCj4gKyNkZWZpbmUgRFdDM19HRkxBREpfUkVGQ0xLX0ZMQURKX01BU0sJCUdFTk1BU0so
MjEsIDgpDQo+ICsjZGVmaW5lIERXQzNfR0ZMQURKXzI0ME1IWkRFQ1IJCQlHRU5NQVNLKDMwLCAy
NCkNCj4gKyNkZWZpbmUgRFdDM19HRkxBREpfMjQwTUhaREVDUl9QTFMxCQlCSVQoMzEpDQo+ICAN
Cj4gIC8qIEdsb2JhbCBVc2VyIENvbnRyb2wgUmVnaXN0ZXIqLw0KPiAgI2RlZmluZSBEV0MzX0dV
Q1RMX1JFRkNMS1BFUl9NQVNLCQkweGZmYzAwMDAwDQoNClJldmlld2VkLWJ5OiBUaGluaCBOZ3V5
ZW4gPFRoaW5oLk5ndXllbkBzeW5vcHN5cy5jb20+DQoNClRoYW5rcyBmb3IgdGhlIHdvcmssDQpU
aGluaA0K
