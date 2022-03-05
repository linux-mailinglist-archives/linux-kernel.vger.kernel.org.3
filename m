Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9DC1A4CE1C0
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Mar 2022 01:54:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230344AbiCEAzE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Mar 2022 19:55:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230016AbiCEAzB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Mar 2022 19:55:01 -0500
Received: from smtprelay-out1.synopsys.com (smtprelay-out1.synopsys.com [149.117.87.133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F3B55BE73;
        Fri,  4 Mar 2022 16:54:12 -0800 (PST)
Received: from mailhost.synopsys.com (sv1-mailhost1.synopsys.com [10.205.2.131])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (Client CN "mailhost.synopsys.com", Issuer "SNPSica2" (verified OK))
        by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id 8B780C09C9;
        Sat,  5 Mar 2022 00:54:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1646441651; bh=WGBSDXS4Y/ejZCyRO70N6roMlxQvnBjwTUiRapLh95g=;
        h=From:To:CC:Subject:Date:References:In-Reply-To:From;
        b=Zk9ugvf0Fva9yRnUHx6+Mb772o1kVMCNDD9c4sDyxD9Hf8nPmQJ6k+3PvYIUzdT1T
         /qsSdTcM+n0tiKT7gXaxdG9Zm3NIF/I/D9dzXGIUKk18i61YPRJXKyHghLGPlqHwzI
         bIWKOZ8+F0/zFHUCdJARM5wb0Udgvp+AVtiKe87EXKBy13c2G0VXCoX9HqHPVStLPd
         9Z6f1FZRbwTJZEwW0wXDn7Gz9oMYTYZ6sBdIK55mkJcQa1LI1Poilp8Uw4k2sgl2Jb
         YkQrx99zWTDfQdnCxAvoV1w9vznofRkn+bi92VDcx0IeV8Y5QA0RFXF7ehDCHBzOBo
         +Z+OQw0NuYmDQ==
Received: from o365relay-in.synopsys.com (us03-o365relay3.synopsys.com [10.4.161.139])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (Client CN "o365relay-in.synopsys.com", Issuer "Entrust Certification Authority - L1K" (verified OK))
        by mailhost.synopsys.com (Postfix) with ESMTPS id E7A87A0064;
        Sat,  5 Mar 2022 00:54:09 +0000 (UTC)
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam08lp2045.outbound.protection.outlook.com [104.47.74.45])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client CN "mail.protection.outlook.com", Issuer "DigiCert Cloud Services CA-1" (verified OK))
        by o365relay-in.synopsys.com (Postfix) with ESMTPS id CA8F580091;
        Sat,  5 Mar 2022 00:54:08 +0000 (UTC)
Authentication-Results: o365relay-in.synopsys.com; dmarc=pass (p=reject dis=none) header.from=synopsys.com
Authentication-Results: o365relay-in.synopsys.com; spf=pass smtp.mailfrom=thinhn@synopsys.com
Authentication-Results: o365relay-in.synopsys.com;
        dkim=pass (1024-bit key; unprotected) header.d=synopsys.com header.i=@synopsys.com header.b="JrXnCanz";
        dkim-atps=neutral
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OBjE4cRY3QQHbV94kc+eu1XDdQZxuJwULPS85Gih9+yv77YKs2kRp5kQYMlEIzmnTmBO3uDvFLn8MqK7uCRHVw3SlbkFwSiv8yhD39DuXqVx0zK0DIz0inzcG2H27U/Jy4n+YGkAxF2uvINWf7uFeUoBQzIXMabhuX2zbrXynSwvhxY8gK0ZG548uLC3J4D1Sc5dX2+RWoHHG1EYzBbfN8r4w6uR+RQSYpMskXTGtJCt2r3QOs3fuQ2XXDqyJas7MRwtPMoIq62L1lr+CyoA+Yil4L+fsEW+fpJCHqfhQoq5REPxqgT20oBWWJmpVtTPGfiqnDx0UNnut86jLpIw6w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WGBSDXS4Y/ejZCyRO70N6roMlxQvnBjwTUiRapLh95g=;
 b=HsQz4GSMrpPFOI/RyCSRQ62cDWh3KyOzxRAaDiSTMzeFgy6z7ocPw0kRy3gAn9vQEoeN7zus+jut+uetEa5ZbPvOXl0xW03FeP/3r9JE20gf0F1zMTjG8VpLv21JGayg0yBC2371udeVh+pUAq256KcusdFetWZWsuOMPdJ6ke3i4b255Zwhvq7ShuZLej1FVxIdqjP0eslsFuDQ9mfasVs5K2YBMAR26MLLzE9Q3nnXKkANpphuv7jGqySeeriDH5hK42QRwBVDM/HXmeJk4d55Drq3EADJG6iZQw8uipI8Udri894qwEpKcf4vrc6YqmDdjhAe9crOgI/RziWseg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synopsys.com; dmarc=pass action=none header.from=synopsys.com;
 dkim=pass header.d=synopsys.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WGBSDXS4Y/ejZCyRO70N6roMlxQvnBjwTUiRapLh95g=;
 b=JrXnCanzp+eKhR2mRjbg12xR9zKHUMMKYWkiPfHN5KUrIotuZaSi29oQzR7rqyMEVwTGgpCHRPKhf3f6siJ4bymDvGJEksy+nQjhPAMLfZtzvNjWOJGBrwFG51VZ5f/hDkLaYzsvDi4DDFgYZ6DRbrUtNtSV0FmVTuyw1GJbWI4=
Received: from BYAPR12MB4791.namprd12.prod.outlook.com (2603:10b6:a03:10a::12)
 by DM6PR12MB5519.namprd12.prod.outlook.com (2603:10b6:5:1b5::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5038.15; Sat, 5 Mar
 2022 00:53:48 +0000
Received: from BYAPR12MB4791.namprd12.prod.outlook.com
 ([fe80::141:3edf:164a:857b]) by BYAPR12MB4791.namprd12.prod.outlook.com
 ([fe80::141:3edf:164a:857b%4]) with mapi id 15.20.5038.017; Sat, 5 Mar 2022
 00:53:47 +0000
X-SNPS-Relay: synopsys.com
From:   Thinh Nguyen <Thinh.Nguyen@synopsys.com>
To:     Wesley Cheng <wcheng@codeaurora.org>,
        Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
        Wesley Cheng <quic_wcheng@quicinc.com>,
        Jung Daehwan <dh10.jung@samsung.com>
CC:     Felipe Balbi <balbi@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        "quic_jackp@quicinc.com" <quic_jackp@quicinc.com>
Subject: Re: [PATCH v2 1/2] usb: dwc3: Not set DWC3_EP_END_TRANSFER_PENDING in
 ep cmd fails
Thread-Topic: [PATCH v2 1/2] usb: dwc3: Not set DWC3_EP_END_TRANSFER_PENDING
 in ep cmd fails
Thread-Index: AQHYIZOvXlHACGixbUGMAnHCl5PyK6yTYqcAgADHvYCAALGHgIADVGEAgAA82ACAB34VgIAAlEuAgALM6QCAAD24AIAAAXqAgAADvQCABhmCgIAAJeOAgAAQ5ACAAA7AAIAF9GqAgAAw+IA=
Date:   Sat, 5 Mar 2022 00:53:46 +0000
Message-ID: <594fbaf7-d9f0-a3a0-e660-880e12418282@synopsys.com>
References: <1644836933-141376-1-git-send-email-dh10.jung@samsung.com>
 <1644836933-141376-2-git-send-email-dh10.jung@samsung.com>
 <ff604504-00df-0c1b-673e-892e42737f7a@synopsys.com>
 <20220215063925.GC144890@ubuntu>
 <63c8c9d1-9b07-a9f2-3639-a38641e19a7a@synopsys.com>
 <6a1322c4-9589-f4de-d42c-d38af2e12e82@quicinc.com>
 <e3332511-82d3-2892-ad72-a0c167273174@synopsys.com>
 <01c4d42e-93cd-d293-f4e3-8c136049d87c@codeaurora.org>
 <894d54ad-b6f9-b942-be99-fe3ad102051b@synopsys.com>
 <dbd00cb1-b5d0-24e7-ef72-dff3765c26cf@codeaurora.org>
 <810de66c-7d73-fae0-9356-b06b48134ad6@synopsys.com>
 <1714910d-f923-d0c7-72a9-0c1d098f783f@codeaurora.org>
 <4371e407-7791-b0b5-dc8c-ad0be09acba4@synopsys.com>
 <e165c644-4ad0-b103-4f8b-2d3bc1b211f1@codeaurora.org>
 <b2eca3ba-5c36-c788-629c-016bd36be8a7@synopsys.com>
 <b0196760-0495-bd8d-7f41-e46f971b0beb@codeaurora.org>
 <d043eea8-b72e-f1ab-7f0d-93b3b0503de0@synopsys.com>
 <15aac89a-bf1d-9f30-6a9a-6d8fe97268ac@codeaurora.org>
In-Reply-To: <15aac89a-bf1d-9f30-6a9a-6d8fe97268ac@codeaurora.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=synopsys.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 4204f1ca-a0c7-4718-f6a1-08d9fe429aee
x-ms-traffictypediagnostic: DM6PR12MB5519:EE_
x-microsoft-antispam-prvs: <DM6PR12MB55192CDAB920C29561D55F63AA069@DM6PR12MB5519.namprd12.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: uBwOpjtEuSxOggGhmKgfNy4u1ikSg7HjxNO5oxPFaibMtjjQ9YlM+iXYA/xgj+lkCIQ173c1jEuQAITkic3BnP0Zue0WBBelvxXfTG6JTZab+Ail+IDLomkOMorQ/eH4jFgX+xZ3feIh704esSb2zPqoIRCD4pa+ejLnR0EuNJEM6Aa/xccBOxLWImTTTMn3AONyXBfirtjq71WzizVPyiR/VCv7F9nc9OttK3ynZpokcMkyCAFrqC+YUu4npyTM8RVxNR/cgsYJUfJcxnu25JVpkSigtkRCeGbRRu9FKcmT58SLiRGgkcc71Btq4jP5QHUVtEZIZ2yxFQV21+uhhvlG2loSQFAuexnShtEmv0qZRz7fgfautPfFyd3Sh5zvh8wp4I2fZw3QYhYgLMQ2LSlNaliKUFk9gTiSVWpNnML+bCIiqho+hl0RiXZELfy3YrFfrj4BNHM1rRQKV02g19TAqitXiVq/0cek3Lldn7gsjXKJecnMYejdgmWB9bKq4BeKnTxJTsdtOPqQj1ToMSxdJvoO1q3tH+ReMWkOnRLGNZkD/x2SYQbhstMt2RVUYbBP0tixrWolwS+TkbgsA8jyyxTyeWms/w5BLLAfyYVhB/F7nK4qSc06b0jtTlHY+vNHc6g/s2L4PjrBeLtJuCTcNqTZwwLI5vvsJPSAdhWjX9+O+607GELG7A3vZsFQ567V48dW66k7C0XAgQhxidSGR9hgGG4aEq5/nYQ5LMMxZRp0aq8Yc4kpvAIfOOWp93bKLhMRpoabRgtiLOWg3DNm+9WRxbJvbgj4HVOQ53E8WgvPD3/TI+hX5p8pKauoi+HZRj1uEH7ouTep27/niq527ZapzEX6UBFFS3NdVjw=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR12MB4791.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(83380400001)(26005)(38070700005)(2616005)(186003)(5660300002)(36756003)(2906002)(8936002)(31686004)(8676002)(66446008)(66476007)(64756008)(66556008)(54906003)(110136005)(6506007)(66946007)(53546011)(6512007)(4326008)(76116006)(38100700002)(316002)(122000001)(508600001)(31696002)(86362001)(966005)(6486002)(71200400001)(45980500001)(43740500002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?NzNMY1dYL2p2eFVlSGROV1Qwb3VOZEowVHh3R2NaTkorZ2JLRW1mMXNmRkp5?=
 =?utf-8?B?MXo1bi9ReTFKQnArSisyYWFveUUzdjV3Z3Z4UVF5UXpuUEN1VWR5UnhtRmt0?=
 =?utf-8?B?YnRBVVRKL1duKyt5cllhWDBmRjRvM0xXRmQzbE5sMnFMZGkvT3ZZNUN0NDFI?=
 =?utf-8?B?ZW9Xa0Rra3FiYWpuSWloTUVUMVFtZHV1SnFPU1lSeUpkdjR1UmptSlBWWmI0?=
 =?utf-8?B?SnkvaVhnRXBEM01RNk5xV3VkaDFlUkNRTkVMdE5yaEVUS0FySmNPZ0Z2ZUo3?=
 =?utf-8?B?WUp1UFRFRFhFNitCZGcxS2laTDh2M08rUjFwYUdxcTc0UU9wdXB1SkU2OVBr?=
 =?utf-8?B?T2ZPeDhYNGJSMVVXZzVOMWI4dWlKR2lLcXZ6TlpRUU9nMzlBTU9QeHZSNWw4?=
 =?utf-8?B?VW1zdm1vaGNxTWpWaUpaWmY2SjNjTEpXM3ZRZXBYMmkvbHR0QTM5bS9rWjE3?=
 =?utf-8?B?MkVuekxuazNJdXVWUHhEdlRna2kyZmsyRGVTb1ZvTXdnbnAyOTQ4bFk3UlRi?=
 =?utf-8?B?L2dXZitjeGR2ZC9GcW85aW9ySGpZclJTZStxUUV6WTRFKzFWamg2UDZwZmRm?=
 =?utf-8?B?Z2hFb1I1NkRFQ1EwSFpuNG92ZUpLN2dyMVNwKzM5RGg1djA4bWdCdzNramw2?=
 =?utf-8?B?UTBiVUxUeU91ZXpYTVJPVzlucXVaUjNLVW80ZHM3RW9XcU9CVi95ZVFPb0NY?=
 =?utf-8?B?UHNiMFVUdElnKytLdHpiaXFnWEhHUWNIMTNvVmlFOWg0czJzQjVCbHN3NWZa?=
 =?utf-8?B?KzdCREVBODJ1cDFOVzdUSWNFZ3JpbmxCNXhQUGZNQmQ0NWpTV1l3cElxd3NE?=
 =?utf-8?B?SXh4eldZalRHbVdoRTd5anB2YkZ1RVJBL0hTRVlSbnZZSkRGWjNDSDVMM01J?=
 =?utf-8?B?SDI3bWJJNUxoYTZjQXRaZEZXbkhMKzVEbmZEOXJGcFU5NDRhVlpTUDZEa2I5?=
 =?utf-8?B?ODNJcUFCRTYwOEpzQlZSVUlvZzNtY0JaK3pMVjFKdUVYMm9qb3Q5ek9CUnk3?=
 =?utf-8?B?cEUyVTZ2VFAvbzBPN21MaWxER2M3M0xDRENUV0x4UFYrcUtHUjlVZGdqMjEr?=
 =?utf-8?B?MldVMVZFZHlGWVozOExqQ1NJeXN3N2JpWENPS2xidHAyVUNXd3BETnZlemdP?=
 =?utf-8?B?OVhzOXAvMHhyRGVHQWU4MzBiazgzOEQ0dm1wY1dXYk5nOHI3UWtkWGxCWDdB?=
 =?utf-8?B?Si8yK1QxWWpLUUkyNjRPMUdTTnpIczV2b1V3eTY4TUhJSFJWaXo1di9iUU9a?=
 =?utf-8?B?V0hUUXh4UWVQeE5OaFMvNzN0d0ZZS1ZaVC9LK1NMRkJwUUl3c1hZZlhnWVhs?=
 =?utf-8?B?c0VUbUtBMHZSdEdaWlViZmh2alA4Y0JYZ3lqaTR6UlM1eFRWNVNQU3IwYjdP?=
 =?utf-8?B?d0JqUXI2SjE4LzlDbThMbk9VbUdieUlkWkZIWEgwem01ZXpPQXBjdWlJSTRj?=
 =?utf-8?B?RWNMUUp2UW9iR3hIOUJrSnNiQ2pxc3ZIZUdSa0FnNFl1bVlnQ1FrU1k2MTBK?=
 =?utf-8?B?TnFzai8wbkJRNUI5Y3dKNFFVRmFDSk1vUGFJM1gxamwyRzAvMERtbVMxcTZv?=
 =?utf-8?B?dFBhN3IwUzZneXcrSS9yUmRLbzFqVCtPTkRtTmRjZmppUnFXR1NhQTZmT0g5?=
 =?utf-8?B?NnhzU2RsQUs4TDZxb3hMbmpraE9NQ2dINnBwYVBhYWM3eENua0I5UDFXYXVZ?=
 =?utf-8?B?ampQbm9WNUNRYldYVlkwTkVwS2V3TElBM0ZXR0hTaHFvTEt3RngzMDllb2Jh?=
 =?utf-8?B?NUoxa09zQnVVU1VtekJBYmt6WTgxTXNrOHpJNnA3TldOY2xFekh5NEhpRU04?=
 =?utf-8?B?UEhaOEc2bzhBNVJNT2daMi9HV0dEaWZOWFE4amVPK29rRXF3cDBSWHBreW1l?=
 =?utf-8?B?U2w5andzdVdVOFVvY2h4cVNyRDFMRzZuRW5ld3RIM01oejhoYjZCUG4ycUIr?=
 =?utf-8?B?VlNybmhMS2c0YXVuSTBlMFVCdDdMWEJNbVpLMEF3cDR6aGVyY2Y2YS9uUDdB?=
 =?utf-8?B?ZjVWSE5uRnhldFVKaHhyQkVxUnpRVDF5VFN0TFlZOEY3blROV0RwS0FRV09Q?=
 =?utf-8?B?ZzBvb1k5djUwSWNEUmZtM3ExTkhkQ2YybU5DSjh3UmRqMVNITFVOVXAwMUxo?=
 =?utf-8?B?UWNoV3lxVTJoN2hoM2IvTjdNNWkvOXlLM2JTZ3FmcHZET1daSXRoNCtMcERI?=
 =?utf-8?B?YWc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <684EE8D2657F824AADAE82A4E043B109@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: synopsys.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB4791.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4204f1ca-a0c7-4718-f6a1-08d9fe429aee
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Mar 2022 00:53:46.1691
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: c33c9f88-1eb7-4099-9700-16013fd9e8aa
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: d8fQdtbry3oOksI2WYihBjx/6C8i7/hseAxf6od6UeZHc9dXUgBpTFx6tmGkdirV61/U+jWgIPQhMgRLEhopgw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB5519
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

V2VzbGV5IENoZW5nIHdyb3RlOg0KPiBIaSBUaGluaCwNCj4gDQo+IE9uIDIvMjgvMjAyMiA3OjAy
IFBNLCBUaGluaCBOZ3V5ZW4gd3JvdGU6DQo+PiBXZXNsZXkgQ2hlbmcgd3JvdGU6DQo+Pj4gSGkg
VGhpbmgsDQo+Pj4NCj4+PiBPbiAyLzI4LzIwMjIgNTowOSBQTSwgVGhpbmggTmd1eWVuIHdyb3Rl
Og0KPj4+PiBIaSBXZXNsZXksDQo+Pj4+DQo+Pg0KPj4gPHNuaXA+DQo+Pg0KPj4+Pg0KPj4+PiBb
IDIxODEuNDgxOTU2ODY1ICAgICAgIDB4OWRjNjNmMjY1XSAgIGRiZ19jb21wbGV0ZTogZXA2aW46
IHRyYiBmZmZmZmZjMDFlN2Y1MmEwIChFNDM6RDQzKSBidWYgMDAwMDAwMDBlYmFmMDAwMCBzaXpl
IDF4IDAgY3RybCAwMDAwMDgxMCAoaGxjczpzQzpub3JtYWwpDQo+Pj4+IFsgMjE4MS40ODIwNDQ3
MzAgICAgICAgMHg5ZGM2M2Y4ZmNdICAgZGJnX2dhZGdldF9naXZlYmFjazogZXA2aW46IHJlcSBm
ZmZmZmY4ODYwNjU3NTAwIGxlbmd0aCA4LzggenNJID09PiAwDQo+Pj4+IFsgMjE4MS40ODIyMjI0
OTAgICAgICAgMHg5ZGM2NDA2NTFdICAgZXZlbnQgKDAwMDBjMDQwKTogZXAwb3V0OiBUcmFuc2Zl
ciBDb21wbGV0ZSAoc0lMKSBbU2V0dXAgUGhhc2VdDQo+Pj4+IFsgMjE4MS40ODIyNzMyNzEgICAg
ICAgMHg5ZGM2NDBhMjBdICAgZGJnX3RyYWNlX2xvZ19jdHJsOiBHZXQgSW50ZXJmYWNlIFN0YXR1
cyhJbnRmID0gNCwgTGVuZ3RoID0gMjApDQo+Pj4+IFsgMjE4MS40ODIzMzQ3ODIgICAgICAgMHg5
ZGM2NDBlYmNdICAgZGJnX2VwX3F1ZXVlOiBlcDZpbjogcmVxIGZmZmZmZjg4NjA2NTc1MDAgbGVu
Z3RoIDAvOCB6c0kgPT0+IC0xMTUNCj4+Pj4gWyAyMTgxLjQ4MjM1NzM4NiAgICAgICAweDlkYzY0
MTA2ZV0gICBkYmdfcHJlcGFyZTogZXA2aW46IHRyYiBmZmZmZmZjMDFlN2Y1MmIwIChFNDQ6RDQz
KSBidWYgMDAwMDAwMDBlYTU3ODAwMCBzaXplIDF4IDggY3RybCAwMDAwMDgxMSAoSGxjczpzQzpu
b3JtYWwpDQo+Pj4+IFsgMjE4MS40ODIzOTE4NjUgICAgICAgMHg5ZGM2NDEzMDRdICAgZGJnX3Nl
bmRfZXBfY21kOiBlcDZpbjogY21kICdVcGRhdGUgVHJhbnNmZXInIFtkMDAwN10gcGFyYW1zIDAw
MDAwMDAwIDAwMDAwMDAwIDAwMDAwMDAwIC0tPiBzdGF0dXM6IFN1Y2Nlc3NmdWwNCj4+Pj4gWyAy
MTgxLjQ4MjQ4NTYxNSAgICAgICAweDlkYzY0MWEwZF0gICBkYmdfc2VuZF9lcF9jbWQ6IGVwMG91
dDogY21kICdTdGFydCBUcmFuc2ZlcicgWzQwNl0gcGFyYW1zIDAwMDAwMDAwIGVmZmZhMDAwIDAw
MDAwMDAwIC0tPiBzdGF0dXM6IFN1Y2Nlc3NmdWwNCj4+Pj4gWyAyMTgxLjQ4MjU2NTMwMyAgICAg
ICAweDlkYzY0MjAwNl0gICBldmVudCAoMDAwMDEwYzApOiBlcDBvdXQ6IFRyYW5zZmVyIE5vdCBS
ZWFkeSBbMF0gKE5vdCBBY3RpdmUpIFtEYXRhIFBoYXNlXQ0KPj4+PiBbIDIxODEuNDgyNzE5NDE3
ICAgICAgIDB4OWRjNjQyYjk2XSAgIGV2ZW50ICgwMDAwMjA0MCk6IGVwMG91dDogVHJhbnNmZXIg
Q29tcGxldGUgKFNpbCkgW0RhdGEgUGhhc2VdDQo+Pj4+IFsgMjE4MS40ODI4MTQ5MzggICAgICAg
MHg5ZGM2NDMyYzBdICAgZGJnX2dhZGdldF9naXZlYmFjazogZXAwb3V0OiByZXEgZmZmZmZmODdk
Zjg0ZDkwMCBsZW5ndGggMjAvMjAgenNJID09PiAwDQo+Pj4+IFsgMjE4MS40ODI5MjYwODQgICAg
ICAgMHg5ZGM2NDNiMTZdICAgZXZlbnQgKDAwMDAyMGMyKTogZXAwaW46IFRyYW5zZmVyIE5vdCBS
ZWFkeSBbMF0gKE5vdCBBY3RpdmUpIFtTdGF0dXMgUGhhc2VdDQo+Pj4+IFsgMjE4MS40ODMwMjQy
NjEgICAgICAgMHg5ZGM2NDQyNzJdICAgZGJnX3NlbmRfZXBfY21kOiBlcDBpbjogY21kICdTdGFy
dCBUcmFuc2ZlcicgWzQwNl0gcGFyYW1zIDAwMDAwMDAwIGVmZmZhMDAwIDAwMDAwMDAwIC0tPiBz
dGF0dXM6IFN1Y2Nlc3NmdWwNCj4+Pj4NCj4+Pj4gVGhlIGNvbnRyb2wgc3RhdHVzIGlzbid0IGNv
bXBsZXRlZCBoZXJlLg0KPj4+Pg0KPj4+PiBbIDIxODEuNDgzMDY5NTIxICAgICAgIDB4OWRjNjQ0
NWQ3XSAgIGRiZ19lcF9kZXF1ZXVlOiBlcDJpbjogcmVxIGZmZmZmZjg3OWY1YThiMDAgbGVuZ3Ro
IDAvNjM2ODAgenNJID09PiAtMTE1DQo+Pj4+IFsgMjE4MS40OTYwNjg3OTIgICAgICAgMHg5ZGM2
ODE0YzldICAgZGJnX3NlbmRfZXBfY21kOiBlcDJpbjogY21kICdFbmQgVHJhbnNmZXInIFs1MGQw
OF0gcGFyYW1zIDAwMDAwMDAwIDAwMDAwMDAwIDAwMDAwMDAwIC0tPiBzdGF0dXM6IFRpbWVkIE91
dA0KPj4+Pg0KPj4+PiBCdXQgdGhlIGRlcXVldWUgbWF5IGNvbWUgd2hlbiBob3N0IGFscmVhZHkg
c2VudCBhIG5ldyBTZXR1cCBwYWNrZXQuDQo+Pj4+IFRoZSBlcDBvdXQgaGFzbid0IHN0YXJ0ZWQg
eWV0IGF0IHRoZSBwb2ludC4NCj4+Pj4NCj4+Pj4gRHVlIHRvIHZhcmlvdXMgc3lzdGVtIGxhdGVu
Y3ksIEkgY2FuIHNlZSB0aGF0IHRoaXMgY2FuIGhhcHBlbiB3aGVuDQo+Pj4+IHRoZSBkd2MzIGRy
aXZlciBoYXNuJ3QgcmVjZWl2ZWQgdGhlIGludGVycnVwdCBub3RpZmllZCB0aGUgc3RhdHVzIHN0
YWdlDQo+Pj4+IGV2ZW50IHlldC4NCj4+Pj4NCj4+Pj4gSWYgdGhhdCdzIHRoZSBjYXNlLCB0aGUg
aG9zdCBtYXkgaGF2ZSBhbHJlYWR5IHNlbnQgdGhlIFNldHVwIHBhY2tldA0KPj4+PiBhdCB0aGlz
IHBvaW50LiBTbyB0aGUgRW5kIFRyYW5zZmVyIG1heSBnZXQgc3R1Y2sgaWYgdGhlIFNldHVwIHBh
Y2tldA0KPj4+PiBpc24ndCBETUEgb3V0IHlldC4NCj4+Pj4NCj4+Pj4gQ2FuIHlvdSB0cnkgdGhl
IGNoYW5nZSBiZWxvdyB0byBzZWUgaWYgaXQgcmVzb2x2ZXMgdGhlIGlzc3VlPw0KPj4+IFRoYW5r
cywgVGhpbmguICBTdXJlIEknbGwgZ2l2ZSBpdCBhIHRyeSB3aXRoIHRoaXMgY2hhbmdlLiAgVGhp
cyBpcyB2ZXJ5DQo+Pj4gc2ltaWxhciB0byB0aGUgY2hhbmdlIHByb3Bvc2VkIGhlcmUgYXMgd2Vs
bDoNCj4+Pg0KPj4+IGh0dHBzOi8vdXJsZGVmZW5zZS5jb20vdjMvX19odHRwczovL2xvcmUua2Vy
bmVsLm9yZy9saW51eC11c2IvMjAyMjAyMTYwMDA4MzUuMjU0MDAtMy1xdWljX3djaGVuZ0BxdWlj
aW5jLmNvbS9fXzshIUE0RjJSOUdfcGchS2xnU3BORUxPWFF5ZElRdWFyQTNBNE5KWEljdkhzbFhx
ek9kQndZcVVJUjk3TXFkcDh6ZHllemhPQzlFSjZVcXhMeE0kIA0KPj4+DQo+Pg0KPj4gTm90IHN1
cmUgaWYgdGhpcyBjb21wbGV0ZWx5IHJlc29sdmVzIHRoZSBpc3N1ZSBoZXJlLiBUaGUgY2hhbmdl
IHNlZW1zIHRvDQo+PiBpc3N1ZSB0aGUgRW5kIFRyYW5zZmVyIGNvbW1hbmQgYmVmb3JlIFN0YXJ0
IFRyYW5zZmVyIGZvciB0aGUgbmV4dCBTZXR1cA0KPj4gc3RhZ2UgY29tcGxldGVzLiBBbHNvIGl0
J3MgbWlzc2luZyBzb21lIGNoZWNrcyBmb3IgYXN5bmMgY2FsbHMgdG8gdGhlDQo+PiBlbmRwb2lu
dCB0aGF0J3MgcGVuZGluZyBkZXF1ZXVlLiBBbHNvLCB3ZSBtYXkgbm90IG5lZWQgdG8gd2FpdCBm
b3IgRW5kDQo+PiBUcmFuc2ZlciBjb21tYW5kIHRvIHRpbWUgb3V0IGlmIHdlIGtub3cgdGhlIGNv
bmRpdGlvbiB0byBhdm9pZC4NCj4+DQo+Pj4gT25lIHRoaW5nIHRvIG1lbnRpb24gaXMgdGhhdCwg
SSdtIG5vdCBzdXJlIGhvdyBkZXBlbmRhYmxlIGNoZWNraW5nIHNvbGV5DQo+Pj4gdGhlIGVwMHN0
YXRlIHdvdWxkIGJlLiAgSSd2ZSBzZWVuIHNvbWUgc2NlbmFyaW9zIHdoZXJlIHdlJ2QgcnVuIGlu
dG8gdGhlDQo+Pj4gZW5kIHRyYW5zZmVyIHRpbWVvdXQgZHVyaW5nIHRoZSB0aW1lIGJldHdlZW4g
aW5zcGVjdGluZyB0aGUgU0VUVVAgcGFja2V0DQo+Pj4gKGR3YzNfZXAwX2luc3BlY3Rfc2V0dXAo
KSkgYW5kIHdoZW4gdGhlIGRhdGEgcGhhc2UgaXMgcXVldWVkLiAgVGhlDQo+Pj4gdGltaW5nIG9m
IHRoZSBkYXRhIHBoYXNlIGNhbiBwb3RlbnRpYWxseSBkaWZmZXIgaWYgaXQgaXMgYSB2ZW5kb3IN
Cj4+PiBzcGVjaWZpYyBjb250cm9sIHJlcXVlc3QuDQo+Pg0KPj4gVGhpcyB0aW1lb3V0IHNob3Vs
ZCBvbmx5IGFwcGx5IHRvIFNldHVwIHBhY2tldCBhbmQgU2V0dXAgc3RhZ2UuIEV2ZW4gaWYNCj4+
IGl0J3MgdmVuZG9yIHNwZWNpZmljIGNvbnRyb2wgcmVxdWVzdCwgaXQgc2hvdWxkIGJlIGZpbmUu
IEhvc3Qgc2hvdWxkIG5vdA0KPj4gaXNzdWUgYSBTZXR1cCBwYWNrZXQgdW50aWwgaXQgcmVjZWl2
ZXMgYSBzdGF0dXMgc3RhZ2UgKHVubGVzcyB0aGVyZSdzIGENCj4+IGRpc2Nvbm5lY3QgaW4gdGhl
IG1pZGRsZSBvZiBhIGNvbnRyb2wgdHJhbnNmZXIsIGJ1dCB0aGF0J3MgYSBkaWZmZXJlbnQNCj4+
IGlzc3VlKS4NCj4+DQo+PiBJZiB5b3UgZG8gc2VlIGEgcHJvYmxlbS4gV2UgY2FuIHRha2UgYSBs
b29rIGZ1cnRoZXIuDQo+Pg0KPiBTbyBmYXIgc28gZ29vZCB3LyB0aGUgdGVzdGluZy4gIEhhZCB0
byBtYWtlIGEgc21hbGwgY2hhbmdlIGluIHlvdXIgcGF0Y2gNCj4gdG8gZml4IGEgdHlwbzoNCj4g
ICAgICAgICAgICAgICAgIGlmICghKGR3YzNfZXAtPmZsYWdzICYgRFdDM19FUF9ERUxBWV9TVE9Q
KSkNCj4gICAgICAgICAgICAgICAgICAgICAgICAgY29udGludWU7DQo+IA0KPiAgICAgICAgICAg
ICAgICAgZHdjM19lcC0+ZmxhZ3MgJj0gfkRXQzNfRVBfREVMQVlfU1RPUDsNCj4gICAgICAgICAg
ICAgICAgIHJldCA9IGR3YzNfc3RvcF9hY3RpdmVfdHJhbnNmZXIoZHdjM19lcCwgdHJ1ZSwgdHJ1
ZSk7DQo+IA0KPiBXYXMgdXNpbmcgZGVwIGluc3RlYWQgb2YgZHdjM19lcC4gIFdpbGwgbGV0IHRo
aXMgcnVuIG92ZXIgdGhlIHdlZWtlbmQNCj4gYW5kIGdldCBiYWNrIHRvIHlvdS4NCj4gDQoNCk9r
LiBUaGlzIHNlZW1zIHRvIGNvbmZpcm0gbXkgc3VzcGljaW9uLiBDYW4geW91IHVwZGF0ZSB0aGUg
cGF0Y2ggd2l0aA0KdGhlIGZvbGxvd2luZyBhZGp1c3RtZW50Og0KDQpkaWZmIC0tZ2l0IGEvZHJp
dmVycy91c2IvZHdjMy9nYWRnZXQuYyBiL2RyaXZlcnMvdXNiL2R3YzMvZ2FkZ2V0LmMNCmluZGV4
IDNlNzVlYWExM2FiYy4uYzNmNzUyOWY2NGZjIDEwMDY0NA0KLS0tIGEvZHJpdmVycy91c2IvZHdj
My9nYWRnZXQuYw0KKysrIGIvZHJpdmVycy91c2IvZHdjMy9nYWRnZXQuYw0KQEAgLTIzMDksNiAr
MjMwOSwxMCBAQCBzdGF0aWMgaW50IGR3YzNfZ2FkZ2V0X2VwX2RlcXVldWUoc3RydWN0IHVzYl9l
cCAqZXAsDQogICAgICAgICAgICAgICAgaWYgKHIgPT0gcmVxKSB7DQogICAgICAgICAgICAgICAg
ICAgICAgICBzdHJ1Y3QgZHdjM19yZXF1ZXN0ICp0Ow0KDQorICAgICAgICAgICAgICAgICAgICAg
ICBpZiAoZHdjLT5lcDBzdGF0ZSAhPSBFUDBfU0VUVVBfUEhBU0UgJiYNCisgICAgICAgICAgICAg
ICAgICAgICAgICAgICAhZHdjLT5kZWxheWVkX3N0YXR1cykNCisgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgZGVwLT5mbGFncyB8PSBEV0MzX0VQX0RFTEFZX1NUT1A7DQorDQogICAgICAg
ICAgICAgICAgICAgICAgICAvKiB3YWl0IHVudGlsIGl0IGlzIHByb2Nlc3NlZCAqLw0KICAgICAg
ICAgICAgICAgICAgICAgICAgZHdjM19zdG9wX2FjdGl2ZV90cmFuc2ZlcihkZXAsIHRydWUsIHRy
dWUpOw0KDQpUaGlzIGlzIHRvIGF2b2lkIGEgY2FzZSBpZiB0aGUgZnVuY3Rpb24gZHJpdmVyIGhh
cyBzb21lIGRlcGVuZGVuY3kgZm9yDQpyZXF1ZXN0cyB0byByZXR1cm4gYmVmb3JlIHNlbmRpbmcg
dGhlIGNvbnRyb2wgc3RhdHVzIHVzaW5nIGRlbGF5ZWQNCnN0YXR1cywgd2hpY2ggY2FuIGNhdXNl
IGEgaGFuZy4NCg0KV2Ugb25seSBuZWVkIHRvIG1ha2Ugc3VyZSBub3QgdG8gaXNzdWUgRW5kIFRy
YW5zZmVyIGFmdGVyIHRoZSBzdGF0dXMNCnRyYW5zZmVyIHN0YXJ0ZWQgYW5kIGJlZm9yZSBpdHMg
Y29tcGxldGlvbiBpbnRlcnJ1cHQsIHdoaWNoIG1heSBwcmV2ZW50DQp0aGUgZHJpdmVyIGZyb20g
c3RhcnRpbmcgdGhlIFNldHVwIHN0YWdlLg0KDQpUaGFua3MsDQpUaGluaA0K
