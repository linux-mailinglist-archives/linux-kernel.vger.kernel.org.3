Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5547F542C14
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Jun 2022 11:55:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235641AbiFHJys (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Jun 2022 05:54:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236312AbiFHJyQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jun 2022 05:54:16 -0400
X-Greylist: delayed 63 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Wed, 08 Jun 2022 02:25:32 PDT
Received: from esa5.hc3370-68.iphmx.com (esa5.hc3370-68.iphmx.com [216.71.155.168])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2CCB9EC3CF
        for <linux-kernel@vger.kernel.org>; Wed,  8 Jun 2022 02:25:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=citrix.com; s=securemail; t=1654680331;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=qFYUMfzZQ+vj5Km9BAE8PcStJR3lpApwb9FRoiWqGkw=;
  b=grgpqJFN+XsSELA1P4ikRYvQvpdMl9Jw39FgVSS4VQR6h48s1RqcGMO6
   A/u/PHqLHFPJoPdrPem7rwW6ubLJ0hpLqlxZq2j4yFohqm/y4p8qgUiws
   agy7cCwxhRmpXt1hX2wnhGS4k/vO943w5hdmB5MmodWM0uC1bKgAlfkxp
   U=;
X-IronPort-RemoteIP: 104.47.56.175
X-IronPort-MID: 72469123
X-IronPort-Reputation: None
X-IronPort-Listener: OutboundMail
X-IronPort-SenderGroup: RELAY_O365
X-IronPort-MailFlowPolicy: $RELAYED
IronPort-Data: A9a23:B6mV+aIfqS+wK32+FE+RJJQlxSXFcZb7ZxGr2PjKsXjdYENShGYCz
 GMeUDyPP66DYGGhKNtxOozi90pV65fcm9JrGwdlqX01Q3x08seUXt7xwmUcns+xwm8vaGo9s
 q3yv/GZdJhcokf0/0vrav67xZVF/fngqoDUUYYoAQgsA149IMsdoUg7wbRh3NY42YHR7z6l4
 rseneWOYDdJ5BYsWo4kw/rrRMRH5amaVJsw5zTSVNgT1LPsvyB94KE3fMldG0DQUIhMdtNWc
 s6YpF2PEsE1yD92Yj+tuu6TnkTn2dc+NyDW4pZdc/DKbhSvOkXee0v0XRYRQR4/ttmHozx+4
 P5E6of3RQ0WBabBltgUVh50SXhuJLITrdcrIVDn2SCS52vvViK1ht5JVQQxN4Be/ftrC2ZT8
 /BeMCoKch2Im+OxxvS8V/VogcMgasLsOevzuFk5lW2fUalgHM6FGvqXjTNb9G5YasRmNPDSf
 ccGLxFoawzNeUZnMVYLEpMu2uyvgxETdhUH8g7L9PNtuAA/yiR73+PXMubXdeWWTNsW3Rylv
 GT9oF7QV0Ry2Nu3jGDtHmiXru3XmiL+UoUfPL617PhnhBuU3GN7IB8aXF6yvf6RhEelR9ZOb
 UcT/0IGvfhs3E+mVN/wW1u/unHslhwEXNtVGeo3wBuAxqrd/0CSAW1sZiZMdNE8puc3QzIw3
 1OElt+vAiZg2JWRSHSA5vKXoCm0NCw9M2APf2kHQBED7t2lp5s85jrNT99lH7W1h9vxEDDYz
 DWDrSx4jLIW5eYBz42g4EvKxT6hzrDDVAE4/B7Ldm2g5wJ9IoWiYuSVBUPz6P9BKMOSSQCHt
 X1dwsyGtrlRUNeKiTCHR/gLEPex/fGZPTbAgFlpWZ486zCq/H3ldodViN1jGHpU3g8/UWeBS
 CfuVcl5vfe/4FPCgXdLXr+M
IronPort-HdrOrdr: A9a23:VwP2dK2RbvJs06CMtWW4rQqjBetxeYIsimQD101hICG9Lfb0qy
 n+pp4mPEHP4wr5AEtQ4uxpOMG7MBDhHQYc2/hcAV7QZnidhILOFvAs0WKC+UysJ8SazIJgPM
 hbAs9D4bHLbGSSyPyKmDVQcOxQjuVvkprY49s2pk0FJW4FV0gj1XYBNu/xKDwVeOAyP+tcKH
 Pq3Lsjm9PPQxQqR/X+IkNAc/nIptXNmp6jSwUBHQQb5A6Hii7twKLmEjCDty1uEw9n8PMHyy
 zoggb57qKsv7WQ0RnHzVLe6JxQhZ/I1sZDPsqRkcIYQw+cyTpAJb4RGYFqjgpF5N1H22xa1+
 UkZC1Qefib3kmhO11dZyGdgjUIngxes0MKgmXo/EcL6faJOA7STfAxxL6xOyGplXbJ9rtHod
 129nPcuJxNARzamiPho9DOShFxj0Kx5WEviOgJkhVkIMMjgZJq3PoiFXluYd499ePBmfIaOf
 grCNuZ6OddcFucYXyctm5zwMa0VnB2GhudWEANtsGczjATxRlCvgEl7d1amm1F+IM2SpFC6e
 iBOqN0lKtWRstTaa5mHu8OTca+F2SISxPRN2CZJ0jhCcg8Sjnwgo+y5K9w6PCheZQOwpd3kJ
 PdUElAvWp3YE7qAd3m5uw9zvkMehTIYd3A8LAv23EigMyMeFPCC1zxdHk+1829vv4YHsrXH/
 6uJZM+OY6XEVfT
X-IronPort-AV: E=Sophos;i="5.91,285,1647316800"; 
   d="scan'208";a="72469123"
Received: from mail-co1nam11lp2175.outbound.protection.outlook.com (HELO NAM11-CO1-obe.outbound.protection.outlook.com) ([104.47.56.175])
  by ob1.hc3370-68.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 08 Jun 2022 05:24:27 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=S28DUF0t6Vkmc19z9sX5ISazBsHtL48BCUrrSaBFrFQayo1jWbyOJHXOi+uA58ljdvWBO0IRMnGZnN3FQgrUMdh8d6c3BKxS8BVbTml9hULkhhbWH8huB9HP9l2lzFcdGqRzJ5QuWN9TOh9r2cCae8AVGJoZtoVpngNc1H8Uy12BhWw8Rlg/B29DGItqlLow8o4dmNtO8z3yVuukskSZQ0LS3WTM2ccxwqxZXDk6fG9C8YfuOd0iMWU/mujpcp6Px038hKjWZG/TXC5Zf7Y0cSx1F1hwYsfIEC527RWWm3Ea4kho+KELHgqywrvHwF2zLQ+EfReISE7Rt4To0uTZ1A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qFYUMfzZQ+vj5Km9BAE8PcStJR3lpApwb9FRoiWqGkw=;
 b=d3ZlJ6I0tfV9jypuLOwb/2Fo9lvLwhNm8mKX28fVb58t/Fu5xzUv5KMHANasIdylL/8p8QdS67kSFiJuZnk1JnY7vrHQl+JGTmqcB4cGbYMMU6tkSkKHuL06bTTGdIX63da4ax/T897CueVnUKrowZmsNcGq42btwuhkzLmgeZuKXf03SZk3eLlTPYhTcfYI0XL37N+Wth27G90JALRkBZcbMW9jab/j/xIq3uHE32JEIZy2x3WwaYrTVw0atVG8uhA5cA0Fx2iXe2Jp5CMp/cUg3N58oUdVXFDNBzlNaCpRAivKVEyq5cH5ktlfIRJ6WWnBC7+0eVzUkeAMFh2g1w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=citrix.com; dmarc=pass action=none header.from=citrix.com;
 dkim=pass header.d=citrix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=citrix.onmicrosoft.com; s=selector2-citrix-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qFYUMfzZQ+vj5Km9BAE8PcStJR3lpApwb9FRoiWqGkw=;
 b=ZH2PrCtquOux/eb/DrrWnmDZHb0YgbAN8aJA9p1disV0cD99lE91ZKQ64C+1oJZRll2fdHsAIJZ5CE5gNfQ0pq+F0QZHT978/cojYVCU2LaOFp0rmU30BP8WEvOrswcalnTJl9BnE4r+NOh0eDWaC+G3cCrr/P9+GUziotI7zlc=
Received: from BYAPR03MB3623.namprd03.prod.outlook.com (2603:10b6:a02:aa::12)
 by SJ0PR03MB6454.namprd03.prod.outlook.com (2603:10b6:a03:396::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5314.13; Wed, 8 Jun
 2022 09:24:25 +0000
Received: from BYAPR03MB3623.namprd03.prod.outlook.com
 ([fe80::50a2:499b:fa53:b1eb]) by BYAPR03MB3623.namprd03.prod.outlook.com
 ([fe80::50a2:499b:fa53:b1eb%5]) with mapi id 15.20.5314.019; Wed, 8 Jun 2022
 09:24:25 +0000
From:   Andrew Cooper <Andrew.Cooper3@citrix.com>
To:     Josh Poimboeuf <jpoimboe@kernel.org>
CC:     Joe Damato <jdamato@fastly.com>, "x86@kernel.org" <x86@kernel.org>,
        "jpoimboe@redhat.com" <jpoimboe@redhat.com>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "jiangshanlai@gmail.com" <jiangshanlai@gmail.com>,
        "bp@suse.de" <bp@suse.de>, "brgerst@gmail.com" <brgerst@gmail.com>,
        Andrew Cooper <Andrew.Cooper3@citrix.com>
Subject: Re: 5.19-rc1 x86 build failure
Thread-Topic: 5.19-rc1 x86 build failure
Thread-Index: AQHYemjkhmMFIj16x0GZjUVGXS5Qc61D40oAgADOBwCAAIzzgA==
Date:   Wed, 8 Jun 2022 09:24:25 +0000
Message-ID: <b5e11680-9101-24ec-0977-c5d0ff8c98c2@citrix.com>
References: <CALALjgwSm07Cnbm6WaK74ZSs4wJ7hs4B3wLOe7h4Y-7sJ5cUWg@mail.gmail.com>
 <74fdda90-f015-5cb9-a2d2-137baf090c59@citrix.com>
 <20220608005956.hzvx3fapdmp25oun@treble>
In-Reply-To: <20220608005956.hzvx3fapdmp25oun@treble>
Accept-Language: en-GB, en-US
Content-Language: en-GB
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=citrix.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 0c963bfc-4eb8-451a-0409-08da4930ae26
x-ms-traffictypediagnostic: SJ0PR03MB6454:EE_
x-microsoft-antispam-prvs: <SJ0PR03MB64544A497E13F4DDFFD7A382BAA49@SJ0PR03MB6454.namprd03.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: hz6OhddMWzl2CRgPjHpM0NHV9MsqgIeDGUfMgfE32DMPVtH71EG6oWPqKFdoNkuyGdkqDdJbn0oMuhc0qyCbs9XmVak7gX/OPNR0ZplugCqQ1/LnCeSgpyxHnfIvMoIq+KSJ1Al0XpW5cIpOFN3VqfY3jmVos+XzGRgJIJHgq7HrsU2s/WnIfaE070jA7lvutmiFsObtBhmL+4z5rkrJXVmfabqHhdG/qmfP6ioDfstefB8Izf695bmPCFl/bY0aQEMtiyHDrMx4yIAFTcOgHzlKKZUjiaalQARZSuX45kuQOTGcmIEOeAtgr6JAgFRzBUN+2KH2M4uiezZPbxQzZ7UAi5ODD3w3kRWXLVF2DJGEBhJmgebgHzWHjI5kHo5I4h/xHWIIIB/w1OiwE2v/ZZZIRTp2dgS/zzd2kgmqxH51K0du/wLwwENdhK1ZTsA3Jbes6argsriAieYghYvZt/c58RkxPuAZvgdZ6UhVw1tgWuMlisKIcX1SGOHgUIv0YCUy8n8xYw+x3A580zxLoXy/EjDjYHo8vF16yZErD70QKyOwc+2EpqcoS9lgihyaEvi/FPO/SDHmXOaH5R6Gmgeb8JIk1VMCaXXhJxt9dyEsVNQDt2a6vqkxfBmnoU564648JOrOe6nqPTtDjOE+H/UzAr3Ca3dcni0CSTBdTXRvGnvsmSrgbKzgRK0tN0J7Bkt6x1rwEMax9iAcXw2DDRlZp/+onVs/2TDNqKXqMFH/aONqJtmoGruzk0ZNcMucF5Q0DZGaiRp/oS9mB2D3OA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR03MB3623.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(122000001)(82960400001)(8676002)(86362001)(4326008)(66946007)(64756008)(66556008)(66476007)(6486002)(66446008)(31686004)(2906002)(71200400001)(54906003)(38100700002)(6916009)(36756003)(91956017)(76116006)(31696002)(186003)(8936002)(508600001)(107886003)(4744005)(38070700005)(316002)(2616005)(5660300002)(6506007)(55236004)(53546011)(6512007)(26005)(43740500002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?dHo1eG9aK3Y5N0lqazdCVTJvYW1MNDZocnMzcS9kMUhKZFh0a2JuQ0VhcEtu?=
 =?utf-8?B?U3Y5T1lBMFY3dmRaMzlEWkMyRWZOTjlMbDFuNFhvOGZzdVcxakwvSzV6ZDI4?=
 =?utf-8?B?bEJseDNCRUJGbVpsUTB5VHEwYlM3eTk1NE1WNUlIa3BacDcxOVFlZjZhckJo?=
 =?utf-8?B?YUhmaVE3a0FzTi9KYnB2NE1qZnArTkJDek9KV1V6SVd2d0IxTXVueGpIRzFB?=
 =?utf-8?B?bk1TZFFFenp2eWVsVlBBYkxIWnJyTGd5TWNJMTN1aHM3NTRJMGdwei9xM1JF?=
 =?utf-8?B?aTA5UjNpdjVwamQ5SzRhdHQ2Z0RhdHpVVG9BS1M3YnN1ZkpoSEVwK0RTcnBB?=
 =?utf-8?B?MWx0TFpFaXFZQ2NncGdrMWVLcTJ5dTF6M09jbTJrTjJlMGFRKzlkK1VoSExU?=
 =?utf-8?B?T1JKUm9xc00rTFB6NE9KM28vTFhEV3JXUE9uSGVyWnV0b3VES0dNL0hkN1ZR?=
 =?utf-8?B?TjV6VTRQd2RpdDJKR0pEVmtLak80eXBpRVZVc2VyZ0tjcUFJRUlBeE92RElR?=
 =?utf-8?B?RzAxUkhBd1RRMzJhZjNEbElTYUtNVFE0b1VWZGQ1bTFKNGJVamRRVTMwWGI3?=
 =?utf-8?B?eFBBMlo5SENkMjBkSVNIaEQ1akJmSEt4MTBVei9DdWl6MTBzWldpMW5HdFdD?=
 =?utf-8?B?WTI5bG01cTFWQ2l2Q2FpYjRzSDRkbFg4Qzk0YWlvTzlabnZWWFFiZmlZQTJq?=
 =?utf-8?B?UVZNc1NUaFJRSEV1NVhoOUxZdm9rbVErNWRpT0JqSk5TRDlwdWlid2dxaUhC?=
 =?utf-8?B?QnpLQ1I5TGQ2S1E5cHZ4d0pVTHVLTllsMlF5Y2Y0elhZamUyU0YweHN6emlR?=
 =?utf-8?B?NHBjUXl6MjBzZCtYbXgxV0FpZEFHNEFQNFdZV1Z0dC9LQVgwNmtiM3B0OE5L?=
 =?utf-8?B?VjlEVU1tRVNPcUwxdjRlQzF2UmpqT2YrVEwwWS9MM1UyYkx5bFVRSXBNVXF5?=
 =?utf-8?B?R1JTNVk0RmdQdlVFaVlvazRTRml0WjE2MXdhTitFMnZMNW0rNTF2dXh0THRh?=
 =?utf-8?B?Nnhic0N5TmNEeEdvLzdlQ1pDZ0JPa3FnTklTNWFLZGZDWGtjdjM4eFNIZzQr?=
 =?utf-8?B?enBaV0FpQkpTRjU1WFd2TjZidkdCODVBdDl5Yk5jTmRseUYxVnUzL3c3ZWtO?=
 =?utf-8?B?cmI2eGVXcVozU2IranRoVkRFemtJYmVRam45K3U5THNyNnhNZVV5SGFDMG51?=
 =?utf-8?B?aElTM25naDlmUHY5NVlYYTBCSWpqTjJEWjV3TjlmdzBJRnlGMVl0VzRjbEZR?=
 =?utf-8?B?dVp2VyttV245TCtveWV6aGp3VXgybGZ5RVhRVjkxYit1elgxSlNqY1RJYXpm?=
 =?utf-8?B?K0NOOCtEMGRKdTcwY29rU3hQSFdBNWFwLytYTWpwSm5XcVJYRVY1cWJPV0xD?=
 =?utf-8?B?b0VDTUpkT1NvQWRWSUdJSlNPczNzMFZoOXBZRXlkYVNVMUFoMi9DK1lvcGtw?=
 =?utf-8?B?SStTSXhFZHNKckc4RHMwRjhSNjNEenBDMCtDSkpuODc4b29STm5veXp2Mlpp?=
 =?utf-8?B?aC9jMFRvZ0svUFo5eUFhczN4bXVVc0ZKeWl5VnFhZE5icWhzSzlhRmNoM1hq?=
 =?utf-8?B?dy83aUcxQkM4dlEzUVV2RklMQ0FPbmtkZGhMaWhEOE5vMjlKOGZMVCtHN2Nv?=
 =?utf-8?B?aXNKcFUxS2dUeCsxd0t0UGJqejNSQlF6OTNIbDF3MEpkQ2JBVlVuNW5ETnNY?=
 =?utf-8?B?YXk0SzBWZ1RFUFNNUC9DeHhSZk9aM2Q4SkFwT093VVhPa2Jjcm9UWUs5ZTk5?=
 =?utf-8?B?T1F1TURBdlc3RUpjbVBGL0F5c0ttWEQ4TGdlTEtCYkwyTCswN1dMM3FDcDVj?=
 =?utf-8?B?aDFTT0RRZXU1MXI4aGdJb3hvMVhwellSQ2NhS3R2Vm9aK1BVamJFY1pPcVIw?=
 =?utf-8?B?Q3ZLZ3dHUjFmN2tDeThGWGNuaVRhY3V2S0lFOFNHckZLdTVzOXZLZWRVa0xo?=
 =?utf-8?B?V2hXTGkwSGdlaTJPOVpzR1V4YW83OG5MeDBxV2NlV1dCVUtPNUh2S3RQY3g2?=
 =?utf-8?B?NFdKblZRekViRjNyVER5WG5ZbWxQaFFJQ1czVDUwTm9RSXBGT2tMVGNWYWdU?=
 =?utf-8?B?bE5VRWVxdVJhdmNIdXZnZC9jL0lzTk5zQXZpSlZ2S2RPR09vZ3dLK0tnQk5W?=
 =?utf-8?B?NGg0Vk9DeFJoQzB5UGRZeFFFMHdSSlMxNm5yTmVrRWdOT3dxdVIxTC9TN1lw?=
 =?utf-8?B?OGRyVmNOUjFrbXMxVHJzL1M2ZmpHMDBmbG11VG1ibDhkTzZ3OFYwcmdwb2Rq?=
 =?utf-8?B?ZEZIUldUUnZSRzZqVlh5UWQ4UjRZZitPWSswMFNrWkVzbUZab3ZPdkNhU2JH?=
 =?utf-8?B?Mm4wclRDY0p0RlpTMmJTaDFJTjEvbVRmWUpaZ0Z1OXZHdW9aS3dQdz09?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <4C93F29E64BC9C419119542D1A360820@namprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: citrix.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR03MB3623.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0c963bfc-4eb8-451a-0409-08da4930ae26
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Jun 2022 09:24:25.5175
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 335836de-42ef-43a2-b145-348c2ee9ca5b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: JB1RdxJPuy+RGZIQ58g1tvE4c3ZNUzCGWQ64DPTKNZcvJY2SburhD9hfn5q9N3fbcRdYrCh73j5VadeDN8Eb+YkV0zJt7dxEIoErTsKi+OU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR03MB6454
X-Spam-Status: No, score=-5.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gMDgvMDYvMjAyMiAwMTo1OSwgSm9zaCBQb2ltYm9ldWYgd3JvdGU6DQo+IEBAIC0xMzMsMTIg
KzEyNSwxNiBAQCBhc21saW5rYWdlIHZvaWQgX19pbml0IHg4Nl82NF9zdGFydF9yZXNlcnZhdGlv
bnMoY2hhciAqcmVhbF9tb2RlX2RhdGEpOw0KPiAgDQo+ICAjZW5kaWYgLyogX19pMzg2X18gKi8N
Cj4gICNlbmRpZiAvKiBfU0VUVVAgKi8NCj4gLSNlbHNlDQo+IC0jZGVmaW5lIFJFU0VSVkVfQlJL
KG5hbWUsc3opCQkJCVwNCj4gLQkucHVzaHNlY3Rpb24gLmJya19yZXNlcnZhdGlvbiwiYXciLEBu
b2JpdHM7CVwNCj4gLS5icmsubmFtZToJCQkJCQlcDQo+IC0xOgkuc2tpcCBzejsJCQkJCVwNCj4g
LQkuc2l6ZSAuYnJrLm5hbWUsLi0xYjsJCQkJXA0KPiArDQo+ICsjZWxzZSAgLyogX19BU1NFTUJM
WSAqLw0KPiArDQo+ICsjZGVmaW5lIFJFU0VSVkVfQlJLKG5hbWUsIHNpemUpCQkJCVwNCj4gKwku
cHVzaHNlY3Rpb24gLmJya19yZXNlcnZhdGlvbiwgImF3IjsJCVwNCj4gK19fYnJrXyMjbmFtZToJ
CQkJCQlcDQo+ICsxOgkuc2tpcCBzaXplOwkJCQkJXA0KPiArCS5zaXplIF9fYnJrXyMjbmFtZSwg
LiAtIDFiOwkJCVwNCj4gIAkucG9wc2VjdGlvbg0KDQpXaGlsZSBJIHRoaW5rIGFib3V0IGl0IGJl
Zm9yZSB5b3Ugd3JpdGUgdGhlIHBhdGNoIHByb3Blcmx5LCB5b3Ugb3VnaHQgdG8NCmhhdmUgYSAu
dHlwZSBpbiBoZXJlIHRvbywgc2VlaW5nIGFzIHRoZSBDIHNpZGUgbm93IGdldHMgb25lLg0KDQp+
QW5kcmV3DQo=
