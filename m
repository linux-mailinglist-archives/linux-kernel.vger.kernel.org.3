Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B299F4671BD
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Dec 2021 06:54:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378531AbhLCFxG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Dec 2021 00:53:06 -0500
Received: from smtprelay-out1.synopsys.com ([149.117.73.133]:55530 "EHLO
        smtprelay-out1.synopsys.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231182AbhLCFxF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Dec 2021 00:53:05 -0500
Received: from mailhost.synopsys.com (sv1-mailhost2.synopsys.com [10.205.2.132])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (Client CN "mailhost.synopsys.com", Issuer "SNPSica2" (verified OK))
        by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id DF0EB459EB;
        Fri,  3 Dec 2021 05:49:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1638510582; bh=jWW4B50ioAzqvYlcfPug1Y0poNQWLwAbxOuhs0O9Z7U=;
        h=From:To:CC:Subject:Date:References:In-Reply-To:From;
        b=gP5owDNzOdu05Fjl0r7LtMJL4Q4phYY2PUNb70yxcMuEd4JFrcB9tZiBtZpp8Humb
         qey1AaSzgCCFK85gQ9VRHuT2mcfysw7SGukrbLHs6ihU4qXOK39zwHxSoxehhT9HtO
         0jbIDmdlq1sjlUoJ1I6foTiF7jlHez6dsqF9sA+QTlJ1Cvg3sjTC0R55nhNHB94Wsj
         nc79kKu8bxB6PIbihg0xTd+66qNrPv+osoRHYzer7wFgZIVxm3+VBSjqVpqPO9afex
         8fm3CsnCmi4k9iNGEjeWFPWR6s5D5Sx7Dj27vQlpkonTZn01ODWBiF+7/Jlnh8VYoF
         tSrzohY8FD3cw==
Received: from o365relay-in.synopsys.com (us03-o365relay3.synopsys.com [10.4.161.139])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (Client CN "o365relay-in.synopsys.com", Issuer "Entrust Certification Authority - L1K" (verified OK))
        by mailhost.synopsys.com (Postfix) with ESMTPS id E3DD0A0070;
        Fri,  3 Dec 2021 05:49:40 +0000 (UTC)
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (unknown [104.47.57.44])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client CN "mail.protection.outlook.com", Issuer "DigiCert Cloud Services CA-1" (verified OK))
        by o365relay-in.synopsys.com (Postfix) with ESMTPS id E59D1800B9;
        Fri,  3 Dec 2021 05:49:39 +0000 (UTC)
Authentication-Results: o365relay-in.synopsys.com; dmarc=pass (p=reject dis=none) header.from=synopsys.com
Authentication-Results: o365relay-in.synopsys.com; spf=pass smtp.mailfrom=hminas@synopsys.com
Authentication-Results: o365relay-in.synopsys.com;
        dkim=pass (1024-bit key; unprotected) header.d=synopsys.com header.i=@synopsys.com header.b="ippwCz6t";
        dkim-atps=neutral
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PpJWOk1neiLGgIVMV0r7wGJAhjY4coC8jvTg2ALaiMworzHYgQj3RiHhzWZ+ktgA/RjrpSfwtB//J4vxXxviGqLzJ4bckwykniDPDTpFzTVqRwd+xBrejDjxl5XN7kzQrP4DJi+Ci+tyfxVxBgMQj8TCHNoNaFZfz1zGONmMtP+fFx8pUOIcb//csb/Y5QDpK5STEXVFoK72M18oFqkhLrMD3HhWRzg398oJ25u7tm8lQzc+WdmzIandkYhCFnGJaG1iOf0yaZNsrewRUbrbWThBGyTRHr0bC+OnYlo02DgPMGi4cFFSISrLuCqX57hUKTcIuJY8obU3L/hx4qN2LA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jWW4B50ioAzqvYlcfPug1Y0poNQWLwAbxOuhs0O9Z7U=;
 b=VtwPcJB3ASNPltlHMprpcQWN75KADWzxyp0YqrFDDr6gkSDnf4GJW1PQZNQ5JswMtdjfULVqgyOiWKgBobCmNZ7hYU9NnR705yfe+A28UgwWhHuyD+wp9FaCWFmWCbYhUY3vf97xJnclWPWGAMZVAP3jqQS6lHtg1zsqES5LK+rXJzbYo9JfNiJbG12oXMcX9zhnWZqXMArux9KmSP5ZZeyHBrbem9KGLwxEzZ/VRqUg9Xjyb2RupTPiz3EPzMmC4XKJX3PJVv/4RU7zohsc1Lic3YVg1yqeVyfn/6HA7jiWjN7A7D4mXsJ4XRQ5loy7ARPxjv674YdoCheWTfz01Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synopsys.com; dmarc=pass action=none header.from=synopsys.com;
 dkim=pass header.d=synopsys.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jWW4B50ioAzqvYlcfPug1Y0poNQWLwAbxOuhs0O9Z7U=;
 b=ippwCz6tj4/R77ggVn85OUAKWInVqjnTfRi9oahnVtkO49B+u9DPM+5ujQB26qyAMjM7plbkjz4fpvbVSaXKOodJwTmWj+xi7Qh4U6CAwtg19zwckNrEAM2SlAYyR/UcxvvZxkLKSIewiaug2HrixL78Aaq41RoPHyXDMo9wy9E=
Received: from DM6PR12MB3419.namprd12.prod.outlook.com (20.178.199.32) by
 DM6PR12MB2650.namprd12.prod.outlook.com (20.176.116.23) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4734.21; Fri, 3 Dec 2021 05:49:36 +0000
Received: from DM6PR12MB3419.namprd12.prod.outlook.com
 ([fe80::bc96:b3ed:1aa5:57b6]) by DM6PR12MB3419.namprd12.prod.outlook.com
 ([fe80::bc96:b3ed:1aa5:57b6%7]) with mapi id 15.20.4734.024; Fri, 3 Dec 2021
 05:49:36 +0000
X-SNPS-Relay: synopsys.com
From:   Minas Harutyunyan <Minas.Harutyunyan@synopsys.com>
To:     John Keeping <john@metanate.com>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>
CC:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Argishti Aleksanyan <argishti.aleksanyan@synopsys.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] usb: dwc2: gadget: initialize max_speed from params
Thread-Topic: [PATCH] usb: dwc2: gadget: initialize max_speed from params
Thread-Index: AQHX56CQFWIuKlwH/UKk1NRUnt5+YqwgQ9mA
Date:   Fri, 3 Dec 2021 05:49:36 +0000
Message-ID: <a2ce248f-79d9-f9a3-f184-e033409fe2b8@synopsys.com>
References: <20211202171748.3035874-1-john@metanate.com>
In-Reply-To: <20211202171748.3035874-1-john@metanate.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.2
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=synopsys.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 770ca0c1-a810-4779-afa7-08d9b620b040
x-ms-traffictypediagnostic: DM6PR12MB2650:
x-microsoft-antispam-prvs: <DM6PR12MB2650F687C2FAAA4433F25650A76A9@DM6PR12MB2650.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1824;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: PvI0fY970+nt7iUctix+53fD8h+TvD15YHPAsL7XcKsxdwPcXeAMEMTMxAf0BB1DaEgvTCwPE9DrhFsUgkH3QAHDVAJ0t+gdMBwn52L3tw3phk0PnAhtC03sntFST+eSu4xcLhROhPy++fw86jGN/JykRaAev1zFT/DW+uiGTIoLi/6b5TaX7FvKhbKD9oN3FpH4It2tSdegRWV6K5U0iu2vAqi2AX9vWu4ryoChB7mAboWnz+JsZzmeRnLLnI0Ud1WdrwKoA/vUM0TNG5+cjrTSMxKpZ7ce/sVSOH4D7Qvw7AHTzfCpx2TlZYg0VYI9m+zBRqRkERWPPBxHvLno3bcl4UD4+/OX9BnOOrF1S2C/+DwBUSM0xnQ9hsmD1Oud2AjhG6hNNv6KxuLFmUwP13hr+JYId7caytLg+L8ESbNtkIaPqMPIW2Fxweddbcj9e4LmNL7GEUWV3WC/lY87jbgDDYM6ng+Bcxpl/+rVMixjDeSFGq9C/d8yYLqSfPMKWOm7IEw+W/Xrf7fUBcckwFYSWjBvvMjzwrYDKeu23jsilsC4KAAlom7hbedOeyE7L3d/VA2nYdKbN3uh9yyC3VB+/72310gFF1xXZi7XNUxtfKg+LQH7KEAOBV1Ptta3XYkrDKZ3FCpAGKHhNKc2X8yvdt6m8iScL3QKSthCWFGLoYsvylatSEz3FtM7iHCMC3LeiuwMRLhR1MQ+HijCiARxL/K3Q4PHP7G2kRTKhueP/D81EVX5UXirrYJ3wn5HX036X3lImLUING4QVnNWjQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB3419.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(26005)(6506007)(122000001)(83380400001)(38070700005)(6486002)(2906002)(54906003)(64756008)(186003)(110136005)(5660300002)(316002)(31686004)(86362001)(8676002)(66476007)(2616005)(66446008)(6512007)(36756003)(8936002)(31696002)(53546011)(4326008)(91956017)(66946007)(66556008)(76116006)(71200400001)(38100700002)(508600001)(45980500001)(43740500002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?a1oyWkYyaEZEMUlsaG1Wb0Vqd0ZIZ0o0NytwNld0dlpCWlA4eSs0d3lkS1Fr?=
 =?utf-8?B?YTl1ZHZXU0FCQkdiWGh2cTlLUnBENkFRMm9vR3lrNXhmSTk3TDdmOVdJb1ZX?=
 =?utf-8?B?TG1LNWRRUzVVR0VPTC95TDdnWExQM2tCY3NlT0tISWc4QUJNTk13dVkxczNR?=
 =?utf-8?B?cllqTDI1cFlmU3JCT1dvRTM0b2Y1WmV1SDF3YVgvejZjQ2swUnFCWEowL2ZO?=
 =?utf-8?B?TlpzYUdzQUJrd1BDYURtU2tIdGlUQm11QmlKYWtMd1VvWFQzVFhVZWxaUlFL?=
 =?utf-8?B?bjFQbWNjdHIwWWREdE13UFBLcTBDdy9pNzN3MWplaUpyMGtVamlSY2dmTEpX?=
 =?utf-8?B?RTR5dlV4RGc3TlRnSXNRVE1KSGRSTXlIZnNUUGU1TzJ6YnRUSHMrOTM1WmNJ?=
 =?utf-8?B?OHpXOTYrTmtqWEMvREJ6VVZsczdtTWdSTDFyR0p0czFPQ0M2L3cxdGIrcTdx?=
 =?utf-8?B?TjU5aEFJQzVUUUpaVGNWQWpRT0VVb3piaUE5dktnMGpMY29QZlk2YjdUalBh?=
 =?utf-8?B?UEtDaElJYVBlQmtZOEhJRVY0RDFtb0hLd0diMlVYRGZPSCtQS0sxTVBKUGd3?=
 =?utf-8?B?ZHFqK2p4WThSaG5JcTJ6MnBDd1lISFNTQU8wTHUyeThOakx5VWEwT0VoWTk3?=
 =?utf-8?B?aDRhTDFhSjVLZG5YY2NJdEczSC9sdHFVT0plUWR4b3RvQ2pDc2F6dTJ2enhG?=
 =?utf-8?B?UTF3aFIwUlVhamtUQmsrR2dXM1NTTXgxYzJzQUdFN2ZrczRBQ0hkQWlBTldW?=
 =?utf-8?B?ZzRvMWluUUR2dHU5M2xXaEpOR1l6KzQwRTZJb3FVaVpRUTFtUnEzS3QwbHhR?=
 =?utf-8?B?USt3KzVwSU1CRW13SjUwMlFuTXhKUzM5NVlrN0NJNmZCTDNCS1VoaTdPTnhG?=
 =?utf-8?B?ZEY0SXZLY2ZIdHFscTNIcjdCaDJ0eHhvaTUraUtQUzRVS09RQ0FxUk53VWM3?=
 =?utf-8?B?M3ZobjJCSm9hY0xpUGVGck9kTU1uRkF0STNoWTVYQ1RpclZKQkhVUW9mNUww?=
 =?utf-8?B?MC9YMHZrclcrZU0xbWQ4ODRROGZGWFpmVlZ4THU1NlNIVnRwYlMvTjdrSEkw?=
 =?utf-8?B?V1A3TnpodHBEUm1FWFlvMldKbVcvRnZQTy9KY21QUmliNzllanZlaHZzdFRF?=
 =?utf-8?B?WWhua2tSV0t5bDFXWlExbTI4anRmV1hpY3kralJxcE4yZ01HQmVBM0RCMmR2?=
 =?utf-8?B?MzlZdGROcjVnSXcxQldFaUtXZklEMGFzYXhKaCtldFJYYTdqeUlxbXhXclZM?=
 =?utf-8?B?Z2RpdURpNVo1U1ZReTNseFVEZm9Wand0dHdicHpIclZmY3BTYUhUQTJ6WW5F?=
 =?utf-8?B?aVRycjlHaTMrTE9Ubk1uMXlidTZVdmxvTUx2cVZRZUFKdjY5aTQwZG5UZWNB?=
 =?utf-8?B?TkZmOUtNS2htTFJRSFFTWGFzdGlCOFNlejU0NWRNZ0xGWk5zK3RmK1BDeVg4?=
 =?utf-8?B?Qi9rU01GOEJHZjVJUy9FQm5uUGp3aFNiZFNMMHZ4SW1oVFhNSVpPeXEzOTBZ?=
 =?utf-8?B?U2ZmSDB1dVZ4Z0lnazl1b2pQU2w5NTlBRWlEd09ac1BGKzlrSTBKVXJRdllu?=
 =?utf-8?B?SjN5Z2drZlFtRGRnVzRWT0wvb3E1Rzhab0tOQXlYV3lxU2NJdkppUkZYT3dB?=
 =?utf-8?B?M3dzUTJQdFRzM3dFek5GdHprTWlZYk9MdG50OXhyNnFCRU5XY2NKZDhseWJl?=
 =?utf-8?B?RjhyQnBkcUc3RUtBcDU4RmpRZWJIV2RldGZEelpvYUFHWjV3RU1kS2xwazcy?=
 =?utf-8?B?Mk5GYU1QRXFoTWJFUDJsRU9hb2pucXhpWTZLM0M0ZE8zNk0wZGY0NzBIQ2Jm?=
 =?utf-8?B?R1k3MkR6eTNMc1VrSEQrNjBkWmJ1Q1ZobmlNdWRzb2RMUCtzMzlxbVpLa1lC?=
 =?utf-8?B?c0dxQ3VDTlRjMXRPNU9aQTZ4R2E5Nk92RmJLaS9DUmtPUE55MDgxUG9ncnUz?=
 =?utf-8?B?dk9pVXhPT09sUWFNTGdMa3h0bkoxbmErUklQTEFncWVvaUdnN2VYRG40aUZJ?=
 =?utf-8?B?Mm52RVhGenR0N1B0R0ZKeDh1SmplNVpyUllPZUlWRmcvUmlUTUVlNXJsVXoz?=
 =?utf-8?B?YW9tV0hrTFI5cm5JUG4raVU4U1R2UXFSQWUvNjAyWmU4eGUzakpRTXgzbHI5?=
 =?utf-8?B?bG11ZmRXblpXbTdSOUJJT01XMTdKR1FmUFQ1YUtBYklLTGxENFc1UlF5MUhE?=
 =?utf-8?B?eEE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <3BF6B57FCBE4D94AABCAAABED3CC670B@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: synopsys.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3419.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 770ca0c1-a810-4779-afa7-08d9b620b040
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Dec 2021 05:49:36.0784
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: c33c9f88-1eb7-4099-9700-16013fd9e8aa
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: eC5CFOTESGvK9U2iGSfOGdKJe/fDjcq5r9SOG1ls+bndZgXCsQ6CEXurV4dpEJCWz7w2Y712oKIcU86iup/CFA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB2650
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgSm9obiwNCg0KT24gMTIvMi8yMDIxIDk6MTcgUE0sIEpvaG4gS2VlcGluZyB3cm90ZToNCj4g
RFdDMiBtYXkgYmUgcGFpcmVkIHdpdGggYSBmdWxsLXNwZWVkIFBIWSB3aGljaCBpcyBub3QgY2Fw
YWJsZSBvZg0KPiBoaWdoLXNwZWVkIG9wZXJhdGlvbi4gIFJlcG9ydCB0aGlzIGNvcnJlY3RseSB0
byB0aGUgZ2FkZ2V0IGNvcmUgYnkNCj4gc2V0dGluZyBtYXhfc3BlZWQgZnJvbSB0aGUgY29yZSBw
YXJhbWV0ZXJzLg0KPiANCj4gUHJpb3IgdG8gY29tbWl0IDUzMjRiYWQ2NmYwOWYgKCJ1c2I6IGR3
YzI6IGdhZGdldDogaW1wbGVtZW50DQo+IHVkY19zZXRfc3BlZWQoKSIpIHRoaXMgZGlkbid0IGNh
dXNlIHRoZSBoYXJkd2FyZSB0byBiZSBjb25maWd1cmVkDQo+IGluY29ycmVjdGx5LCBhbHRob3Vn
aCB0aGUgc3BlZWQgbWF5IGhhdmUgYmVlbiByZXBvcnRlZCBpbmNvcnJlY3RseS4gIEJ1dA0KPiBh
ZnRlciB0aGF0IGNvbW1pdCBwYXJhbXMuc3BlZWQgaXMgdXBkYXRlZCBiYXNlZCBvbiBhIHZhbHVl
IHBhc3NlZCBpbiBieQ0KPiB0aGUgZ2FkZ2V0IGNvcmUgd2hpY2ggbWF5IHNldCBpdCB0byBhIGZh
c3RlciBzcGVlZCB0aGFuIGlzIHN1cHBvcnRlZCBieQ0KPiB0aGUgaGFyZHdhcmUuICBJbml0aWFs
aXNpbmcgdGhlIG1heF9zcGVlZCBwYXJhbWV0ZXIgZW5zdXJlcyB0aGUgc3BlZWQNCj4gcGFzc2Vk
IHRvIGR3YzJfZ2FkZ2V0X3NldF9zcGVlZCgpIHdpbGwgYmUgb25lIHN1cHBvcnRlZCBieSB0aGUg
aGFyZHdhcmUuDQo+IA0KPiBGaXhlczogNTMyNGJhZDY2ZjA5ZiAoInVzYjogZHdjMjogZ2FkZ2V0
OiBpbXBsZW1lbnQgdWRjX3NldF9zcGVlZCgpIikNCj4gU2lnbmVkLW9mZi1ieTogSm9obiBLZWVw
aW5nIDxqb2huQG1ldGFuYXRlLmNvbT4NCj4gLS0tDQo+ICAgZHJpdmVycy91c2IvZHdjMi9nYWRn
ZXQuYyB8IDEzICsrKysrKysrKysrKy0NCj4gICAxIGZpbGUgY2hhbmdlZCwgMTIgaW5zZXJ0aW9u
cygrKSwgMSBkZWxldGlvbigtKQ0KPiANCj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvdXNiL2R3YzIv
Z2FkZ2V0LmMgYi9kcml2ZXJzL3VzYi9kd2MyL2dhZGdldC5jDQo+IGluZGV4IGI4ODRhODNiMjZh
NmUuLjJiYzAzZjQxYzcwYWQgMTAwNjQ0DQo+IC0tLSBhL2RyaXZlcnMvdXNiL2R3YzIvZ2FkZ2V0
LmMNCj4gKysrIGIvZHJpdmVycy91c2IvZHdjMi9nYWRnZXQuYw0KPiBAQCAtNDk3NCw3ICs0OTc0
LDE4IEBAIGludCBkd2MyX2dhZGdldF9pbml0KHN0cnVjdCBkd2MyX2hzb3RnICpoc290ZykNCj4g
ICAJCWhzb3RnLT5wYXJhbXMuZ19ucF90eF9maWZvX3NpemUpOw0KPiAgIAlkZXZfZGJnKGRldiwg
IlJYRklGTyBzaXplOiAlZFxuIiwgaHNvdGctPnBhcmFtcy5nX3J4X2ZpZm9fc2l6ZSk7DQo+ICAg
DQo+IC0JaHNvdGctPmdhZGdldC5tYXhfc3BlZWQgPSBVU0JfU1BFRURfSElHSDsNCj4gKwlzd2l0
Y2ggKGhzb3RnLT5wYXJhbXMuc3BlZWQpIHsNCj4gKwljYXNlIERXQzJfU1BFRURfUEFSQU1fTE9X
Og0KPiArCQloc290Zy0+Z2FkZ2V0Lm1heF9zcGVlZCA9IFVTQl9TUEVFRF9MT1c7DQo+ICsJCWJy
ZWFrOw0KPiArCWNhc2UgRFdDMl9TUEVFRF9QQVJBTV9GVUxMOg0KPiArCQloc290Zy0+Z2FkZ2V0
Lm1heF9zcGVlZCA9IFVTQl9TUEVFRF9GVUxMOw0KPiArCQlicmVhazsNCj4gKwlkZWZhdWx0Og0K
PiArCQloc290Zy0+Z2FkZ2V0Lm1heF9zcGVlZCA9IFVTQl9TUEVFRF9ISUdIOw0KPiArCQlicmVh
azsNCj4gKwl9DQo+ICsNCj4gICAJaHNvdGctPmdhZGdldC5vcHMgPSAmZHdjMl9oc290Z19nYWRn
ZXRfb3BzOw0KPiAgIAloc290Zy0+Z2FkZ2V0Lm5hbWUgPSBkZXZfbmFtZShkZXYpOw0KPiAgIAlo
c290Zy0+Z2FkZ2V0Lm90Z19jYXBzID0gJmhzb3RnLT5wYXJhbXMub3RnX2NhcHM7DQo+IA0KDQpK
dXN0IHNldHRpbmcgZ2FkZ2V0J3MgbWF4X3NwZWVkIGRvZXNuJ3QgcmVzb2x2ZSBkZXNjcmliZWQg
aXNzdWUuIEFmdGVyIA0Kc2V0dGluZyBnYWRnZXQncyBtYXhfc3BlZWQgaW4geW91ciBwYXRjaCwg
aXQgZG9lc24ndCB1c2VkIGluIGRyaXZlciBhdCANCmFsbC4gUGVyIG1lLCB5b3UgbmVlZCBhbHNv
IGZpeCBkd2MyX2dhZGdldF9zZXRfc3BlZWQoKSBmdW5jdGlvbiBieSANCmNoZWNraW5nIHJlcXVl
c3RlZCBzcGVlZCB3aXRoIG1heF9zcGVlZDogaWYgcmVxdWVzdGVkIHNwZWVkIGhpZ2hlciB0aGFu
IA0KbWF4X3NwZWVkIHRoZW4gc2V0IHNwZWVkIHRvIG1heF9zcGVlZC4NCg0KVGhhbmtzLA0KTWlu
YXMNCg==
