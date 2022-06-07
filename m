Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1873853FF33
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Jun 2022 14:43:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244102AbiFGMnu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Jun 2022 08:43:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244095AbiFGMnp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jun 2022 08:43:45 -0400
X-Greylist: delayed 62 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Tue, 07 Jun 2022 05:43:41 PDT
Received: from esa3.hc3370-68.iphmx.com (esa3.hc3370-68.iphmx.com [216.71.145.155])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06B753C492
        for <linux-kernel@vger.kernel.org>; Tue,  7 Jun 2022 05:43:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=citrix.com; s=securemail; t=1654605821;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=AMxbxifRHJTutpIUiZNqiXonnyReRScsIR+dW3InXgU=;
  b=d8Dk2KpB9OnsnxNK8vr/5uDYTFTmy+twb5AA5ltF3pju9kjn/GBUwlVo
   nweWspWYQ1zzk3TGVCJ8zse8shTJ0DjZI6I5V8005WnpTyCFncGIvujt6
   vA7h/W+UPk4NEPtr9xtCwfzFlCnLdd5H2hqn821Wgvsr2VkNMnhB5Um3/
   s=;
X-IronPort-RemoteIP: 104.47.70.107
X-IronPort-MID: 73038652
X-IronPort-Reputation: None
X-IronPort-Listener: OutboundMail
X-IronPort-SenderGroup: RELAY_O365
X-IronPort-MailFlowPolicy: $RELAYED
IronPort-Data: A9a23:UV9HWaz1ttBE/tYXiIJ6t+fpxyrEfRIJ4+MujC+fZmUNrF6WrkVRx
 mYYXDqCbvaNMDPzLop+OYzn9BwAvpODx4JkTlM9/yAxQypGp/SeCIXCJC8cHc8zwu4v7q5Dx
 59DAjUVBJlsFhcwnj/0bv656yMUOZigHtIQMsadUsxKbVIiGX5JZS5LwbZj2NY22YfhWmthh
 PupyyHhEA79s9JLGjp8B5Kr8HuDa9yr5Vv0FnRnDRx6lAe2e0s9VfrzFonoR5fMeaFGH/bSe
 gr25OrRElU1XfsaIojNfr7TKiXmS1NJVOSEoiI+t6OK2nCuqsGuu0qS2TV1hUp/0l20c95NJ
 NplrYSgUzdxFIr2p8dNFB5eNhp+Ev150eqSSZS/mZT7I0zuVVLJmq0rJmdpeIoS96BwHH1E8
 uEeJHYVdBefiumqwbW9DO5xmsAkK8qtN4Qa0p1i5WiBUbB6HtacG+OTvYAwMDQY36iiGd73Y
 cYDZCUpRxPHexBVYX8cCY4knffujX76G9FdgA3O/fFnvTWJpOB3+OTLN4D4cMayf9xqkU3Fm
 iXG4COnJA5PYbRzzhLAqBpAnNTnny/yXYsOE5W2/+V2hEzVzWsWYDUGBQWTovSjjEO6HdVFJ
 CQ8+DIprK0480GDVNTxXxSk5nWDu3Y0Q9dMHvcowACLxLDd7wuQCi4DVDEpQNgnstImAD8nz
 FmEm/v3CjF19r6YU3SQ8vGTtzzaESoUJGkNfi8NSw8M4vHspYgyilTESdMLOKStpsboAjy2z
 z3ihCIkiLgJltIj2KCy/FSBiDWpzqUlVSYw7wTTG2ijsQVwYdf9Y5TysACEq/FdMIyeU1+N+
 mAenNST5/wPCpfLkzGRROIKH/ei4PPt3CDgvGOD1qIJr1yFk0NPt6gJiN2iDC+F6vo5RAI=
IronPort-HdrOrdr: A9a23:2v0nxa4EwciAAtljxAPXwZGCI+orL9Y04lQ7vn2ZFiY5TiXIra
 qTdaogviMc0AxhI03Jmbi7Scq9qeu1z+843WBjB8bZYOCAghrmEGgC1/qu/9SEIUHDH4FmpM
 BdmsRFaeEYSGIK9foSgzPIXerIouP3lpxA7N22pxgCcegpUdAY0+4TMHf4LqQCfngjOXNPLu
 v42iMonVqdUEVSSv7+KmgOXuDFqdGOvonhewQ6Cxku7xTLpS+06ZbheiLonis2Yndq+/MP4G
 LFmwv26uGIqPeg0CLR0GfV8tB/hMbh8N1eH8aB4/JlaQkEyzzYJriJaYfy+Azdk9vfr2rCV+
 O85SvICv4Drk85uFvF+CcFlTOQiArGoEWStGNwyUGT3fARAghKSvapzLgpDCcwoSAbza5B+b
 MO0GSDu5VNCxTc2Cz7+tjTThlv0lG5uHw4jIco/jRiuKYlGclsRLYkjQpo+VY7bVDHwZFiFP
 MrANDX5f5Qf1/fZ3fFvnN3yNjpWngoBB+JTkULp8TQilFt7TpE5lpdwNZakmYL9Zo7RZUB7+
 PYMr5wnLULSsMNd6pyCOoIXMPyAG3QRhDHNn6UPD3cZeo6EmOIr4Sy7KQ+5emsdpBNxJwumI
 7ZWFcdrmI2c1KGM7z44HSKyGG4fIyQZ0Wc9igF3ekJhlTVfsuZDQSTDFYzjsCnv/ITRsXGRv
 fbAuMiP8Pe
X-IronPort-AV: E=Sophos;i="5.91,283,1647316800"; 
   d="scan'208";a="73038652"
Received: from mail-bn7nam10lp2107.outbound.protection.outlook.com (HELO NAM10-BN7-obe.outbound.protection.outlook.com) ([104.47.70.107])
  by ob1.hc3370-68.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 07 Jun 2022 08:42:35 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bXp5m12y0lpxUp6AuEz2wLtCH9+DmQpD0wsZ/t9EbQEw+rego9slERiH9x4j8UmrZedc7hPwo6LGigNWwZYs8LGoKwc9VXWEbu7QHnwAM+A1JMyMNewnv0OtUPEQz5a3OW9TywLszz94msK08h2cA87vRP0HlGZpVXoe0DsJwT8oNK1KemRwl8FzoF4n9D1Cp/f62q6NXxYO9nIh2ElQkbTCkKIicdC3X0j0teU7eMYQFDA1VLuoa/j4yZYxDAiaCZTXNtzwUTIcI1zVjClUKmyGRdcRqBAzqb9Sizd1J+indk05DSQBv4bBFu2fUBRcdZeWeYb5XigCP72VD332aw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AMxbxifRHJTutpIUiZNqiXonnyReRScsIR+dW3InXgU=;
 b=AGQrECscapXZjPu8AB8fsjKFk5gHCnxBjVldewK21dASLCzr9iwsMjBLZ7HcbKQwEEWbnTV9CDNlKDS+wBeQsGAWUSeova4sp1qgbaWPD7/w7zloDaTLDuDDsvgyEB0H8CR/oGMq6DOrzhzhq3Bl0zGPucorzfBBS70lXq6FtzhOymqg8aUv7zGzMSNkHY290sBRa0FteMKNCL06jjuxzsXe3RuRnT57v3/Sua3JCwbY6DI40o/CKe//VxkTZGS8iqPjjyoY9IcO5BqJh51nktdmM9oscvM5q5BK4DHVcCzT/88U8x2c/a/rFDmcfWogG7LbHsJWyaIB8Qx3CtksnA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=citrix.com; dmarc=pass action=none header.from=citrix.com;
 dkim=pass header.d=citrix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=citrix.onmicrosoft.com; s=selector2-citrix-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AMxbxifRHJTutpIUiZNqiXonnyReRScsIR+dW3InXgU=;
 b=e+SxbgtVtarDrIB6vkMxThV5ZiOOR+GUMYfj8XK2MZJZbG0gdEwFyFeB3K6oKXJKHxNO3Ey7IZCCu5GhQhtpKcoTuqv3KPFf3ZJYXHQru2ldgH6S5ASbA/ADGfzjtmhtm8jwq5fcOihX4UtPvv4Xs9+0zhB1D/me9X+iJW5bNBM=
Received: from BYAPR03MB3623.namprd03.prod.outlook.com (2603:10b6:a02:aa::12)
 by PH7PR03MB6918.namprd03.prod.outlook.com (2603:10b6:510:12e::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5314.19; Tue, 7 Jun
 2022 12:42:33 +0000
Received: from BYAPR03MB3623.namprd03.prod.outlook.com
 ([fe80::50a2:499b:fa53:b1eb]) by BYAPR03MB3623.namprd03.prod.outlook.com
 ([fe80::50a2:499b:fa53:b1eb%5]) with mapi id 15.20.5314.019; Tue, 7 Jun 2022
 12:42:33 +0000
From:   Andrew Cooper <Andrew.Cooper3@citrix.com>
To:     Joe Damato <jdamato@fastly.com>, "x86@kernel.org" <x86@kernel.org>
CC:     "jpoimboe@redhat.com" <jpoimboe@redhat.com>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "jiangshanlai@gmail.com" <jiangshanlai@gmail.com>,
        "bp@suse.de" <bp@suse.de>, "brgerst@gmail.com" <brgerst@gmail.com>,
        Andrew Cooper <Andrew.Cooper3@citrix.com>
Subject: Re: 5.19-rc1 x86 build failure
Thread-Topic: 5.19-rc1 x86 build failure
Thread-Index: AQHYemjkhmMFIj16x0GZjUVGXS5Qc61D40oA
Date:   Tue, 7 Jun 2022 12:42:33 +0000
Message-ID: <74fdda90-f015-5cb9-a2d2-137baf090c59@citrix.com>
References: <CALALjgwSm07Cnbm6WaK74ZSs4wJ7hs4B3wLOe7h4Y-7sJ5cUWg@mail.gmail.com>
In-Reply-To: <CALALjgwSm07Cnbm6WaK74ZSs4wJ7hs4B3wLOe7h4Y-7sJ5cUWg@mail.gmail.com>
Accept-Language: en-GB, en-US
Content-Language: en-GB
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=citrix.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 5d6f99df-9460-4c48-2225-08da48833167
x-ms-traffictypediagnostic: PH7PR03MB6918:EE_
x-microsoft-antispam-prvs: <PH7PR03MB6918F2285FA3553ACDA38983BAA59@PH7PR03MB6918.namprd03.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: asLpUesZhlM41ZITFR2Smq7swA6mDvzmrlFqysehsscSjsjlvEiklkVzu7bWtiDatWlrdZKsXcnPfEIWLL4yBhQ7y4LKMAGWPTb4BU33BCmpDRrpYRhEle8qVXuPwcB6ce1x5xswO6NqILLTS+/43ioPBzHcWT5Fio3a+ok1UsnprBebps5WE2jhsXDac7ZIkDu3mzzSVdeYudEa8omfz0jz8zBHV9UKWX4Y8oGMpUluq5mHmoN6hYqES2HKGWovpsBCWUzzBKR26ityTlvgx/dCzT4KKgvYvhrFE/WEablJqkVNudU3o15QVllNh4K4jh2UNyhRE2/FUmsmqfzhko1oUhjzEI2UcwKLqRppvS0knC5Q3CU2Acik5+5Rr4Gvonc6RponzMeCz27pJsfk82XDR92fawFi96lWdhiJTw/GR+CFgjTQZIk8X/zib3wWBIn9kJb5D7juP+VsMYejtV6StFm7HC6bXNxnHz0VhKE4gkQkqDlu3dHFH/hWtmwMsE3XRyab90B3qbr6FVVQfyWQrrXUpcTvgVeteXnCbYMvkui3fq2BLDsImT3wVIBhEVwtYBuHOOQG0u5yDXFJGMYopYoJWW6aG6L562/OBbIqkqRzyMek3pXb8YdCmTU2fTywCyFJlZ1qwMq9FbxESKfB5S9rsB2EPGZoT2DznpGxZ7Ivheg1jjgPL/4z9HbgvRuKRe6HqVDyxXDfSDFpWtT7ccwtDcnMDNqwyOR65RLKo1STVGLa6bc8hs1YUL7wSpqKiegdBCyQKp1Vpn+zog==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR03MB3623.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(508600001)(6486002)(31696002)(38070700005)(83380400001)(186003)(5660300002)(107886003)(2616005)(2906002)(86362001)(8936002)(6512007)(76116006)(91956017)(38100700002)(36756003)(31686004)(66946007)(110136005)(26005)(54906003)(4326008)(6506007)(71200400001)(122000001)(8676002)(82960400001)(53546011)(316002)(64756008)(66446008)(66476007)(66556008)(43740500002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?OHRGR245bTBXRWZacjJIN1IrVG5SRmRuSzQvV2I2d3pOaUFvU0tFcTNtV3NS?=
 =?utf-8?B?cE9jUmJvVkxqZHV0OUtCeGpuUnloSjVUemFjZE9YSDJWaVNUOGVseVlGUmdn?=
 =?utf-8?B?NWdvQ2tiM2FDRzBDdmxyKzRZZEN0ZGJWV0J1RGpWbkpCblMzVW5xNHBLL0k2?=
 =?utf-8?B?ZFBDRjViQlB4eEh1NGlTQVY3S0NiZzlZeWZFVW9MNWZjMWJOdkFKNThrOWRX?=
 =?utf-8?B?RFFrdzlmR2pvNktVWmVPT1ZVVytsV0dVVG0xTTFIYXpuejV2cUtqSHd2L29G?=
 =?utf-8?B?UDZvbkZBVjhkZmVGZ2hHY0lBaTN0amVlVkFFcDZsSmFkb0dncGlYMVZzU1Q2?=
 =?utf-8?B?RVhpRml1enJXRXE5bXduaXg0RWNBYU9TL3NTeHp6blpObit0RmhYd1hiVVV6?=
 =?utf-8?B?M2NBdTVyV0hpcDVpQ3dMSFpwTUdSRG9uL09GY0MrcWorVXRyN1VlWVZmWkdl?=
 =?utf-8?B?SFZ0SmU2eHNMKy9tN3YzVnBiRlBjRmxrcmI5NW5mWEpzcXZKTC9nWEs0aDBP?=
 =?utf-8?B?REhZemVIZHFTY3BHcDBZbG9zS3hxMzNhUGpNenJNZGFYSk5UV29hM0pwRHJG?=
 =?utf-8?B?bTlydWNRNVhaMG5oQlBrc01TVnpSMUFMUFJzN0kvNE5MMUR6YmtJZmFyb3Z2?=
 =?utf-8?B?OFVJT09vTE5zRXhzbm5zMFQ0THhTdmZacXZnUE9ockd3b1BNYlp2THdVQnRM?=
 =?utf-8?B?dWxuTyswZ1dKMnEwSC84NW9xaFhDd2doMDJBQ3oxNXFnNXI3Q1FGMHJ2U1R3?=
 =?utf-8?B?bWRreE1aK2UzdzJpRHRwS012cjhHN0NnY2lmREthZ2lvNzAzeHlBRmRxdkhD?=
 =?utf-8?B?eFhCZjVXSFRuMTFod0lVQndESTNJWlp3SGlTWURCSjdYdWlFMjIxeks3TGky?=
 =?utf-8?B?MW5mc0NzdGxpdTlFWEh5dzd1VXk3aXFWdGJubWxEMVdsVVI5Z0lMdVl4NmJT?=
 =?utf-8?B?L0Z5NUV5OC9LME41cDYwcWVYeUEyVlVRN2x3M3k1Z3lxVjhGcnhmTG5kcjhZ?=
 =?utf-8?B?MUh2dzRidXM3MVdMNm8rS3hIYVRteVdpajdtUHRDL0FpcElRVCtJNDNKRVJI?=
 =?utf-8?B?R2xvNGRsOXJObGszNk9oMHZGK1pBMlVjaFE1YXlWUkROUGc4WXNpbDdSNzJs?=
 =?utf-8?B?OGJjTmVySFZtenluYkRUZTBBSHJHUW53SDFzU0NhUVJKSTVhOEcyYTZXL3RD?=
 =?utf-8?B?dUFLS0tlN245K0RKSm5pRjBOMVNQcW5xWmhGeEIyampIY3pQWDBnWFZPQUto?=
 =?utf-8?B?QmliTFRxMHVkR3gzMU9BeHZKamVkZmtEWlNJeElBS0RxZUdQMklKMGNBZGp5?=
 =?utf-8?B?d290VWFzdVU0U25hWHAvSkVjTEtmdnhIWEtXUXBWVFIxcFFsQ09EZGhBUHNx?=
 =?utf-8?B?Z3FpOXJsYjdXekhwN0tnZW9KY21Bd28xWWtkRWJJNGF1cG5DRC9yZ3ZVVUo3?=
 =?utf-8?B?Sm5GUHo4V25ZZVVXQXovNDNZQW1SZU92eFJ0ZGlJSUZNcXJtSDRza0g2SkRr?=
 =?utf-8?B?bUdRbmZOaW5XUG5ZcGpRSFkxbCtSTUdZMWduNlVjZDRZZUtQeHhybStTNjhv?=
 =?utf-8?B?YU4rTGowTGxTRk1DL2EwQ0ZmbDF6dUF4WXFrMU5SUnB4ZFZKZ3h2UTBvOVkr?=
 =?utf-8?B?WWJsU3U1R0s0N3RWOW8yT2srRUJwTEpBUVZvUnNtUDFwQThpR1lKWG1vczEy?=
 =?utf-8?B?NzNxTkRvVzNUTnZ3OUJ2VXBYdE9RNC96cjIyTlc2TERKbEdYQnJXQzVldE04?=
 =?utf-8?B?UUNUNWdwMElSakdNcjc0dXAzNENJQkVIUkw0T2xubWZsVVp4M2JPWkl2MFR0?=
 =?utf-8?B?Q0VGZTF6M29ZOUlUWVVFOE82MXZYQzNaYUdmRDJlSVdvK0E0WFMzNVIvbGtX?=
 =?utf-8?B?UUpqaU1GVDQzcVVZbmFjaXZpWlc1eXJtb1drdGpBa2UrbXd0UDFLeXhrejM4?=
 =?utf-8?B?am9rUVNCK1BrWnJKb0pOVDE2d0ZRWUhHSmNsdjIvMzR1UTEyMzZZaGZpR1Er?=
 =?utf-8?B?Rld0VHNvL3A1QTR2VHMyenlSM1BvZXdGZDE0alVFK2hxOVNuaXQ3U1FVOHVl?=
 =?utf-8?B?azBzQXVkZC9lcTVZMlQralRJbGh3ZmdEa3puenRJZzRxMEptRUlNWS8vdHlm?=
 =?utf-8?B?eW4zOW9GR3VQbjNmN2VKOUtQZ2d4N2F6VUFFajhLbERucWMxclJNaUFPTVpQ?=
 =?utf-8?B?b2hiVmZPSjNjeGk3aUhkSXl1S2h5WEFlKzJSVGNCU0ExVGl5RTNKNlh4Zkd1?=
 =?utf-8?B?OWIzNXkrYWlpdXhHaWlyRjd6anhjS0t1c1d0OTVjR3hjbW9pMFpXa21XcVFY?=
 =?utf-8?B?SGRDeW9GNnQ0WXFDRDhvQjdTc1NxN2o3aDBsb0lGV2RuRkJzQjBDcWRndlhX?=
 =?utf-8?Q?vkM2ntfUDCb75AI0=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <7C6EFA37E9E36E43925E971850AFFF70@namprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: citrix.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR03MB3623.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5d6f99df-9460-4c48-2225-08da48833167
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Jun 2022 12:42:33.2948
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 335836de-42ef-43a2-b145-348c2ee9ca5b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 0iFM6QD9ATJhvb34QF6gmEPDGGUJnFksIh8x9JNlPdQuCi37LFOEV8wE8hCr0EQCo+Rm9axP3DAIHbWgq6dL5N99V6ONkFlcye7aeXUwNAo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR03MB6918
X-Spam-Status: No, score=-5.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gMDcvMDYvMjAyMiAxMzoxOSwgSm9lIERhbWF0byB3cm90ZToNCj4gR3JlZXRpbmdzOg0KPg0K
PiBNeSBhcG9sb2dpZXMgaWYgdGhpcyBpcyB0aGUgaW5jb3JyZWN0IHBsYWNlIHRvIHJlcG9ydCB0
aGlzLCBidXQgSSBnb3QgYQ0KPiBidWlsZCBlcnJvciB3aGVuIHRyeWluZyB0byBjb21waWxlIHRo
ZSBuZXQtbmV4dCA1LjE5LXJjMSB0cmVlLg0KPg0KPiBnaXQgYmlzZWN0IHNheXMgdGhhdCBjb21t
aXQgYTFlMmMwMzFlYzM5NCAoIng4Ni9tbTogU2ltcGxpZnkNCj4gUkVTRVJWRV9CUksoKSIpIGlz
IHJlc3BvbnNpYmxlIGZvciB0aGUgYnVpbGQgaXNzdWUgSSBhbSBoaXR0aW5nLg0KPg0KPiBJIGFt
IHBlcmZvcm1pbmcgdGhpcyBidWlsZCBvbiBhbiB4ODZfNjQgc3lzdGVtIHdpdGggR05VIEMxMSAo
VWJ1bnR1DQo+IDUuNC4wLTZ1YnVudHUxfjE2LjA0LjEyKSB2ZXJzaW9uIDUuNC4wIDIwMTYwNjA5
ICh4ODZfNjQtbGludXgtZ251KS4NCj4NCj4gVGhlIGFzc2VtYmxlciBvdXRwdXRzIGEgY3J5cHRp
YyBlcnJvciBtZXNzYWdlOg0KPg0KPiAvdG1wL2NjbkdPS1o1LnM6IEFzc2VtYmxlciBtZXNzYWdl
czoNCj4gL3RtcC9jY25HT0taNS5zOjk4OiBFcnJvcjogbWlzc2luZyAnKScNCj4gL3RtcC9jY25H
T0taNS5zOjk4OiBFcnJvcjogbWlzc2luZyAnKScNCj4gL3RtcC9jY25HT0taNS5zOjk4OiBFcnJv
cjogbWlzc2luZyAnKScNCj4gL3RtcC9jY25HT0taNS5zOjk4OiBFcnJvcjoganVuayBhdCBlbmQg
b2YgbGluZSwgZmlyc3QgdW5yZWNvZ25pemVkDQo+IGNoYXJhY3RlciBpcyBgVScNCj4gL3RtcC9j
Y25HT0taNS5zOjk5OiBFcnJvcjogbWlzc2luZyAnKScNCj4gL3RtcC9jY25HT0taNS5zOjk5OiBF
cnJvcjogbWlzc2luZyAnKScNCj4gL3RtcC9jY25HT0taNS5zOjk5OiBFcnJvcjogbWlzc2luZyAn
KScNCj4gL3RtcC9jY25HT0taNS5zOjk5OiBFcnJvcjoganVuayBhdCBlbmQgb2YgbGluZSwgZmly
c3QgdW5yZWNvZ25pemVkDQo+IGNoYXJhY3RlciBpcyBgVScNCj4NCj4gSSd2ZSBhc2tlZCBHQ0Mg
dG8gZ2VuZXJhdGUgdGhlIGFzc2VtYmx5IGFuZCBvdXRwdXQgc28gSSBjYW4gc2VlIG1vcmUNCj4g
c3BlY2lmaWNhbGx5IHdoZXJlIHRoaXMgaXNzdWUgaXMgKHZpYSAiLWZ2ZXJib3NlLWFzbSAtV2Es
LWFkaGxuPW91dHB1dCIpOg0KPg0KPiAgIDk2ICAgICAgICAgICAgICAgICAgICAgICAgICAgIC5w
dXNoc2VjdGlvbiAuYnJrX3Jlc2VydmF0aW9uLCJhdyIsQG5vYml0cw0KPiAgIDk3ICAgICAgICAg
ICAgICAgICAgICAgICAgICAgIC5icmsuZWFybHlfcGd0X2FsbG9jOg0KPiAgIDk4ID8/Pz8gMDAw
MDAwMDAgICAgICAgICAgICAgIC5za2lwICgoMiAqIDMpICogKCgxVUwpIDw8IDEyKSkNCj4gKioq
KiAgRXJyb3I6IG1pc3NpbmcgJyknDQo+ICoqKiogIEVycm9yOiBtaXNzaW5nICcpJw0KPiAqKioq
ICBFcnJvcjogbWlzc2luZyAnKScNCj4gKioqKiAgRXJyb3I6IGp1bmsgYXQgZW5kIG9mIGxpbmUs
IGZpcnN0IHVucmVjb2duaXplZCBjaGFyYWN0ZXIgaXMgYFUnDQo+ICAgOTggICAgICAwMDAwDQo+
ICAxMDAgICAgICAgICAgICAgICAgICAgICAgICAgICAgLnBvcHNlY3Rpb24NCj4NCj4gVGhpcyBj
b21lcyBmcm9tIGFyY2gveDg2L21tL2luaXQuYywgd2hpY2ggaGFzIHRoZSBmb2xsb3dpbmcgY29k
ZToNCj4NCj4gUkVTRVJWRV9CUksoZWFybHlfcGd0X2FsbG9jLCBJTklUX1BHVF9CVUZfU0laRSk7
DQo+DQo+IHdoZXJlaW4gSU5JVF9QR1RfQlVGX1NJWkUgKHZpYSBQQUdFX1NJWkUpIGhhcyBhICIx
VUwiIHdoaWNoIG1ha2VzIHRoZQ0KPiBhc3NlbWJsZXIgdW5oYXBweS4NCj4NCj4gSSBkb24ndCBy
ZWFsbHkga25vdyB3aGF0IHRoZSBjb3JyZWN0IHdheSB0byBmaXggdGhpcyBpczsgaXQgc2VlbXMg
dGhhdCB0aGUNCj4gbWFjcm8gX0FDIHNob3VsZCBoYW5kbGUgdGhpcyBpZiBBU1NFTUJMWSBpcyBk
ZWZpbmVkLCBJSVVDLCBidXQgdGhhdCBkb2VzDQo+IG5vdCBzZWVtIHRvIGJlIHRoZSBjYXNlIGF0
IHRoaXMgcG9pbnQgaW4gaW5pdC5jLg0KPg0KPiBQZXJoYXBzIEkgYW0gZG9pbmcgc29tZXRoaW5n
IGluY29ycmVjdCBkdXJpbmcgdGhlIGJ1aWxkIHByb2Nlc3MgY2F1c2luZw0KPiB0aGlzIHRvIGhh
cHBlbj8NCg0KVGhlIHByb2JsZW0gaXMgdGhhdCBfQUMoKSBpcyBldmFsdWF0ZWQgaW4gQyBjb250
ZXh0IChzbyBnYWlucyB0aGUgVUwvVUxMDQpzdWZmaXgpLCBhbmQgdGhlIEMnZCBzdHJpbmcgaXMg
ZmVkIGRpcmVjdGx5IGludG8gdGhlIGFzc2VtYmxlciAod2hlcmUNCm9sZGVyIGJpbnV0aWxzIGRv
ZXNuJ3QgdG9sZXJhdGUgdGhlIHN1ZmZpeCkuDQoNClNob3J0IG9mIGhhdmluZyBhIF9QQUdFX1NJ
WkUgd2hpY2ggaXMgYW4gZXhwbGljaXRseSBub24tQUMoKSdkIGNvbnN0YW50LA0KSSdtIG5vdCBz
dXJlIHdoYXQgdG8gc3VnZ2VzdC7CoCBJZGVhbGx5LCB5b3UnZCB3YW50IHRvIHRlbXBvcmFyaWx5
IGRlZmluZQ0KX19BU1NFTUJMWV9fIGFyb3VuZCB0aGUgZXhwYW5zaW9uIG9mIF9fc3RyaW5naWZ5
KCksIGJ1dCBJIGRvbid0IHRoaW5rDQp0aGF0J3MgcG9zc2libGUgYXMgUkVTRVJWRV9CUksoKSBp
cyBhIG1hY3JvIGl0c2VsZi4NCg0KfkFuZHJldw0K
