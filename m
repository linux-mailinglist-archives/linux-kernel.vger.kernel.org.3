Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 01BB85758FC
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Jul 2022 03:09:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232713AbiGOBJP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Jul 2022 21:09:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232313AbiGOBJB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jul 2022 21:09:01 -0400
X-Greylist: delayed 62 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Thu, 14 Jul 2022 18:08:59 PDT
Received: from esa5.hc3370-68.iphmx.com (esa5.hc3370-68.iphmx.com [216.71.155.168])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 454572ED5A
        for <linux-kernel@vger.kernel.org>; Thu, 14 Jul 2022 18:08:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=citrix.com; s=securemail; t=1657847339;
  h=from:to:subject:date:message-id:references:in-reply-to:
   content-id:content-transfer-encoding:mime-version;
  bh=PjZlhbs1mQIVtwqwMdeL5Y7tuYCGhGR7jeXorXs0DjE=;
  b=BdTl/7vQf4mFZauYTyqbnu1rD0ViVicC60sogwRArq1cKNNPnb+8XfCb
   N2Y5DWb0If8BzIvNz9QdmukGnJ0NIw7+Pnz/zwdtK+Zxqczsjf6OwIvx1
   ErIIHrLIl+GSrBc/UUVZti2vIsf1foxmwaLAf/CMuTL7B2jszmQQ0QdCN
   Q=;
X-IronPort-RemoteIP: 104.47.55.105
X-IronPort-MID: 75150551
X-IronPort-Reputation: None
X-IronPort-Listener: OutboundMail
X-IronPort-SenderGroup: RELAY_O365
X-IronPort-MailFlowPolicy: $RELAYED
IronPort-Data: A9a23:APndSq/TAGby1L745O0rDrUDlX+TJUtcMsCJ2f8bNWPcYEJGY0x3m
 mRNDG7Sbq6Kamrxe412YInn8BsF7cTTx9Q2SwM6riw8E34SpcT7XtnIdU2Y0wF+jyHgoOCLy
 +1EN7Es+ehtFie0Si+Fa+Sn9z8kvU2xbuKUIPbePSxsThNTRi4kiBZy88Y0mYctitWia++3k
 YqaT/b3ZRn0gVaYDkpOs/jZ8Ew24Kyp0N8llgdWic5j7Qe2e0Y9VPrzFYnpR1PkT49dGPKNR
 uqr5NlVKUuAon/Bovv8+lrKWhViroz6ZGBiuVIPM0SWuTBQpzRa70oOHKF0hXG7Kdm+t4sZJ
 N1l7fRcQOqyV0HGsLx1vxJwS0mSMUDakVNuzLfWXcG7liX7n3XQL/pGJ0hqEtci6s1LBT8Rs
 qQyMTQRRE2kiLfjqF67YrEEasULCuDOZdtan046iDbTALAhXIzJRLjM6ZlAxjAsi8tSHPHYI
 c0EdT5oaxeGaBpKUrsVIMtmwKH02T+iLnsB8A/9SakfugA/yCRY1rT3PcWTUduNXchPxW6Tp
 37c/nS/CRYfXDCa4WXYqy/027KW9c/9cIktKOOH56N3u2DJz3IdB0ZNX16Kovbs3yZSXPoac
 ST44BEGr6076FCwSd/VUBq/r3qJ+BUbXrJ4F+w89RHIyafO5QudLnYLQyQHa9E8ssIyAzsw2
 Te0c8jBADVutPiQViib/7LN9TeqY3FNcCkFeDMOShYD75/7uoYvgxnTT9FlVqmoktnyHjK2y
 DePxMQju4guYQcw//3T1Tj6b/iE//AlkiZdCt3rY1+Y
IronPort-HdrOrdr: A9a23:rnKZbKyMWwGtejNo73/IKrPxgOskLtp133Aq2lEZdPULSKGlfp
 GV9sjziyWetN9IYgBZpTgZUJPwC080hqQFmrX5Wo3SETUO2VHYZ72KiLGP/9SOIVybygcw78
 Zdmu1FeaTN5DtB/IrHCWuDYrEdKbC8mcjG69s2jU0dKz2CAJsQjDuRfzzrd3GeMzM2Z6bReq
 D92uN34x6bPVgHZMWyAXcIG8LZocfQqZ7gaRkaQzY69Qinl1qTmfDHOind+i1bfyJEwL8k/2
 SAuRf+/L+fv/ayzQKZ/3PP7q5RhMDqxrJ4dY2xY4kuW3XRYzSTFcZcso65zXUISSaUmRIXee
 z30lQd1gJImjTsly+O0F3QMkLboUwTAjfZuCKlaD3Y0IPErXsBerV8bcgySGqk12Mw+N57y6
 5FxGSfqt5eCg7Bhj3045zSWwhtjVfcmwtVrQc/tQ0qbWIlUs4nkaUPuEdOVJsQFiPz744qVO
 FoEcHH/f5TNVeXdWrQsGVjyMGlGi1bJGbPfmES/siOlzRGlnFwyEUVgMQZg3cb7Zo4D51J/f
 7NPKhknKxHCsUWcaV+DuEcRtbfMB2FfTvcdGaJZVj3HqAOPHzA75bx/bUu/emvPIcFyZMj8a
 6xJW+wdVRCCX4GJff+raGjqCq9PllVdQ6duv129tx+pqD2QqbtPGmKVE0u+vHQ0MkiPg==
X-IronPort-AV: E=Sophos;i="5.92,272,1650945600"; 
   d="scan'208";a="75150551"
Received: from mail-mw2nam10lp2105.outbound.protection.outlook.com (HELO NAM10-MW2-obe.outbound.protection.outlook.com) ([104.47.55.105])
  by ob1.hc3370-68.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 14 Jul 2022 21:07:54 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=G6K5AWzCUZuwIbVoUyAkzaahw18je5bdEe61SnxApI6ewUqP3YIBeCHw3PkXMdhGJtcMyKg4sDDbPtPctU5dPUhpbqIN2DoIbRw8I3s3PElRUcEBEsHkvgRFtGk7SAgHa5CpItAg+EhNQnbfUmua/X4QXfpTpVcp9gUt1BU6yZKbPYDD0ltjjVDDS/VJ01Jj5F2O39Kk2nFKJ13+3tMNteyP8uMC9+kjMpKEDaK30Zmw6tVnlyMDXWvJhUGy43jZbKbQtUbp5N0UrQXH2QHG9pDiotzIfWXh0ApKaPwEcSBpwPkWJPdrvmqoNM8v1wUN4YooUNwtgoXDjPlc67iArw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PjZlhbs1mQIVtwqwMdeL5Y7tuYCGhGR7jeXorXs0DjE=;
 b=Um36nVDuoOOPUP4pztbrBVFhdMeR1e4pAakp2/nGxGDTywaRLz0klbHQHRJcIi/5oo0GKosiG+HRUnU0z7yfdKuqpuYNWB6dNC96I5a3QqfYwSOFSyQoeLnYOlwrPR+Pif8CkJuHGuB5fUp2HHA15GrhXDnhy/FLOBkB6DIPkuYCSLy0ujibovh/Zh/WqYTKdOKeiX/hv6mFqjsf6UANM1eGWYf+X2RmOUwGZ1e9HH2RygEDqpDhlWjki/+W4196fY4LTA6HYba4aIuFggNcBkoe5ejXaowV9wcjvys+OgsnMdjzcNN2IPyoTWgOKMBb6xa/jfJjuJYufpKZk06zaA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=citrix.com; dmarc=pass action=none header.from=citrix.com;
 dkim=pass header.d=citrix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=citrix.onmicrosoft.com; s=selector2-citrix-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PjZlhbs1mQIVtwqwMdeL5Y7tuYCGhGR7jeXorXs0DjE=;
 b=wAYfdrgsd9eg9n1cBwHCDrHkIrnLPXraX5+9+VstWOttl3cDP2uJao/6S/5sFOfCA/87LJmWASipUTqRAmWM2VQT2X7vPHdETp5aZgzexrShG7myUS9XtXGjpZkiggxNbzoXsbVaCiEL0un1y+Cij6k3fEgKiak1MGLZ+jnRHqU=
Received: from BYAPR03MB3623.namprd03.prod.outlook.com (2603:10b6:a02:aa::12)
 by BLAPR03MB5555.namprd03.prod.outlook.com (2603:10b6:208:29b::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5417.16; Fri, 15 Jul
 2022 01:07:53 +0000
Received: from BYAPR03MB3623.namprd03.prod.outlook.com
 ([fe80::bd46:feab:b3:4a5c]) by BYAPR03MB3623.namprd03.prod.outlook.com
 ([fe80::bd46:feab:b3:4a5c%4]) with mapi id 15.20.5417.026; Fri, 15 Jul 2022
 01:07:52 +0000
From:   Andrew Cooper <Andrew.Cooper3@citrix.com>
To:     Jim Mattson <jmattson@google.com>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: Retbleed (RSBA vs BTC)
Thread-Topic: Retbleed (RSBA vs BTC)
Thread-Index: AQHYl+dP+dYch63h+0ykgrKLAesJ1A==
Date:   Fri, 15 Jul 2022 01:07:52 +0000
Message-ID: <f68c283c-cfc9-bc63-5d0f-143295a575d4@citrix.com>
References: <CALMp9eS5pBrKWe=LbWXON6bhTdhbX9rB2aF+c-h_a0=SXfyj7A@mail.gmail.com>
In-Reply-To: <CALMp9eS5pBrKWe=LbWXON6bhTdhbX9rB2aF+c-h_a0=SXfyj7A@mail.gmail.com>
Accept-Language: en-GB, en-US
Content-Language: en-GB
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=citrix.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 8dd5602e-bb6f-4d45-40d0-08da65fe7196
x-ms-traffictypediagnostic: BLAPR03MB5555:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ciaw8uztzrKvDO03AQrQopz4L/df+ODvKfsVmFrjh6bhn49pD8F2PermlBsGgoR9NkbAYmmE4rbMTsVEuPLCJ1Tngeug6psHwgarEKWL/RCINSeB8pSKqsvRmYM0I0f6KUpWDoPhWx52fac57xliPlTr8yYBtQRxWcZ9wnACjLuIkzpDKS+LAAQdt92gKBgCJbyYYahN9nRatgGZvU9O8M2Iw9Aszn5VfkdsSY3mL0B00i24f6EqvJSyUxmz+zMTWz3m2x8BaXnfCX3/VYpyloOREJ1I7IK39TIv/H0Roo3l2A3fU02zq5zRJyaJgw361t+0YnnngGBX7D/ZttT1dsF+FiwQd3/sCVeVH6U3/0tU7iVTsPb7Al/P+CQFqxOggs7c95a19f5D7HGNWRrkbf63p2j8nCzgVm6saB+FW5anzqkTDMuZcMDhA49rifmOUuXuRlC0iAERl/6y2MIQKiPkFw2TqzxQFYNuWvIGm0k3ok9XJCdYQnV7kD9i+WQU/noeri48BVtzUxlz2cH2iR5TOFdIkiqG3XxZA67IPJRSI5b8r7uksv+468JrIOUhDVSqIUAVtN+gVysMRYx3gkNj6gGxj63j63YJTkujbqFTd9+yIHjUsKcD78yGBhJkLcuATwj760Kbi310cCXapxQn/Onr26Rk/YwHo/1+ykEnTo9fTfN5YGMD288llmSbZ0Kc5eLSiJysHtgkKJwBs+qhR88+G9pdP9tehhJAI84GR+a1gPPRdoCnhw8sVisaT30DXTdkCc0Mb5d9MUHRq4jEKWnru9cOAYSrp0iPwvrnMdLUAIxAuy+gMzZq3vyFRSHUAPG6PODoYRMvX08eVnDjMWbBPljyc4HuEGr5I45TDG+Npwx7Qo9OLYoQ53+B
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR03MB3623.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(376002)(396003)(136003)(366004)(346002)(39860400002)(110136005)(31696002)(6512007)(31686004)(41300700001)(53546011)(6506007)(478600001)(91956017)(86362001)(5660300002)(36756003)(71200400001)(26005)(76116006)(316002)(82960400001)(38100700002)(66476007)(2906002)(2616005)(6486002)(122000001)(64756008)(186003)(38070700005)(8676002)(66946007)(66446008)(83380400001)(66556008)(8936002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?bDNneDRxNWxkRk0vSFVhbUFYdnYzK0h3SVhsY1ZRUHc3TWxHQy9DUVRqTjhY?=
 =?utf-8?B?ak9BcU9PS1FDb0U5emZtekV6T3RTWW1iV25GUVdOK3FmbkRGeUl3aytZTkp1?=
 =?utf-8?B?MUpnM1VGZldNMzFINWlKL1k3dFNCSnh4T01naGVPK3VkMlZsR08zK3hub1lD?=
 =?utf-8?B?RkdrT2l1YWNVbEZ2bldaeEdOZ041VFY2SlBNMWZhVWR5QWM5Ylo3VzVuNzdX?=
 =?utf-8?B?Y1RkWHRQVkdRYllncDBPVHhjUFNyVURUam9iYy8wMjNaUmZEVkxMMDBOVEJR?=
 =?utf-8?B?NzV5dURWSmR2aXVhN2kxcWo5dVFUc0RoajdUMDloTmtSNWpZNEVka0FpRVh2?=
 =?utf-8?B?RmxKQ3B6enhwejArazQrb3FzMEJPeWhHNzIxZ21DT2NqMHJicXpTUVR2SXg1?=
 =?utf-8?B?TlFtT3FZTVl3L2ZSRHQ1T3FjR1gyMW1adXV2QWd5N0YyVVB4SlpYVFk2MThi?=
 =?utf-8?B?K2NjdCtVNy92eXpNSUNROUFZKzVyejc3ckVHcXpZZm9JZFJpK0dpRndSTGJC?=
 =?utf-8?B?K3FzTWswMDVRaE4rRWxRNjA0V1N6N1FraXZ5VmZEcVA3bFNUbFgrMVBObWFq?=
 =?utf-8?B?VHpmaHIyWUNkL0hSTTRsSFdhVGZ6amhBT0pxcFpZWExtVkNldjkvSmJ3UDNk?=
 =?utf-8?B?VkljYkY3dUhBYlpqOVV0Z25KSzFHYm9oUWU2ajVuTjRDZDM5ZTB0cklCcExI?=
 =?utf-8?B?YkJVeCtiWmZHSGN1eEk0M0xZZzJMREkwcGlUSlFkZTdudWRpNmc1eExlQjBs?=
 =?utf-8?B?dS9uVi9PbjNqTFNQdEtTY2U3UjJhL3dOQWJQK25zNVpkc3YrRDNkMTV2MHF2?=
 =?utf-8?B?WGlFZnFZUTNJSG0rUnN6ZHJrQUs0aC9nRzhTVm5UOUVRWlBiS1p4bXl5Y2xo?=
 =?utf-8?B?T2l3NDdUV211VFdPK0hVNVVPQ1Z3d2ZtZ2NHZkNoa0NSclIyU3pZUGlRVEpz?=
 =?utf-8?B?SHVTTWZHUzZNTUd4ZDhGZXZ2MmEvSU0xTFczalBEaWk0SWI3MzRiWEpPb1dq?=
 =?utf-8?B?V1BYZmZ4Q1k4R0h0emdRZXU5dzZIdmtJZ21pZ09RejNScFgvQWVjcll1djM3?=
 =?utf-8?B?U0RVNXRXb0xocDRjcGJRd0QvNEJTQ2x6RDRiUURDVjNwb041SGtEcm9GLzhw?=
 =?utf-8?B?cFlwbzBDNkxaMVpldzZXQktmSjhRUDYwa3J2aTRvdU9BOWJHQUhrSy9oMmZM?=
 =?utf-8?B?eUlOSkZ2MC94TnNKSE05OW9kNzR3QWNsZG05T25lTHVMeU5WeFpYWDl5UmJF?=
 =?utf-8?B?QkZxRlEzd3BIOG94Q2RTZUtELzJEQ1BUS05iRWlLeTgrSFdsTjhycnJjbXpi?=
 =?utf-8?B?OThKakZLYldNS0JaMFg3US85eDk0OUtZdDhLQUx6N0tsSVp2NHVidWFyVXg2?=
 =?utf-8?B?bHM1WC9HK3dRYVhkcFRib2hib2RhVWV5RHlJaHBmbWVSZTRvdFYyRmdqYUI0?=
 =?utf-8?B?T2lKaDRnMXhIaUMxTW1RZ0MrNjlnVzBmL3hOTDFHcWlib0hVR1hHRDhyS01u?=
 =?utf-8?B?QU1rdDdrVElseFdaVDhTV3drcTdNUXBNZGZSYU1yQlp2dTVKblMyTkZERmxi?=
 =?utf-8?B?NTU0YitRc1Q0cm5qemlWVEY0ckFqS092elFZVlNBTFF4bW9DeS83NGlrTHhJ?=
 =?utf-8?B?aWtIR0gyU25aMm1DSC81K1FTZjhzNFpoUkZxbThWRkRkQnZ4U0diSWVzdWtQ?=
 =?utf-8?B?YmttK1hmTytpT1YzcmxvZkFIWEllUURsRjlUdm9KTUtyVEJTUEROT2JHVlhs?=
 =?utf-8?B?YnVKYVh0aHpXeFFNQWFBQStpckdDRk1TeVFoTGpWTTU4SlBSSkJxZnhpeU5s?=
 =?utf-8?B?MXl4NmdxQ215dnlpSnBIYkQwK29rR2oxTno1NGhYQ3pBZXNseW5lZ3JLVGNa?=
 =?utf-8?B?MnR0OHRCWjFCeFE3MTNpV2pnZi8weHFjQTdKem9PY2JIc3hySHBoT2xCRjk3?=
 =?utf-8?B?aHBYWE1VU2tiMm9rems3bEdFeWo0UUxTQXFIbXR0c2lvaXcwMVpkd3hhSEZj?=
 =?utf-8?B?blZxR1J1R2wxd1JBR2NseE1maGFYVlhwS2RjT1Z6N2IzR0VUV2FBcHBMSVFD?=
 =?utf-8?B?cnhPT2VEbi8yd1Z2LzFuY1VQMUhOYkFJZXJiYTloUU9Vb21ZTjZJMkw2RVBM?=
 =?utf-8?Q?AYDcdK2xEvrcc+kUSxzMYWvy8?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <61C2C4FC08106D47B4EE59310E4F6A49@namprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: citrix.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR03MB3623.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8dd5602e-bb6f-4d45-40d0-08da65fe7196
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Jul 2022 01:07:52.7961
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 335836de-42ef-43a2-b145-348c2ee9ca5b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: OnleGZqw9T5slfwIlI/Q9TorP8A9bQBhQCF4zwT82aMxKaMkscp52kmjGrQkSs62P1mHhyB9nh0QHCla8CFjrGKfmczQ8a5w94nztpYmsFY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BLAPR03MB5555
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gMTUvMDcvMjAyMiAwMToyOSwgSmltIE1hdHRzb24gd3JvdGU6DQo+IFdoYXQgaXMgdGhlIHZh
bHVlIGluIGNvbmZsYXRpbmcgdGhlIEludGVsIGFuZCBBTUQgZmluZGluZ3MgdW5kZXIgdGhlDQo+
IHNhbWUgbW9uaWtlciAoYXJjaC94ODYva2VybmVsL2NwdS9jb21tb24uYyk/IFRoZSB2dWxuZXJh
YmlsaXRpZXMgc2VlbQ0KPiBxdWl0ZSBkaWZmZXJlbnQgdG8gbWUuDQoNClRoZXkgYXJlIGVudGly
ZWx5IGRpZmZlcmVudCwgYmV5b25kIHRoZSBmYWN0IHRoYXQgdGhleSBib3RoIHBlcnRhaW4gdG8N
CnRoZSBgcmV0YCBpbnN0cnVjdGlvbi4NCg0KU3VmZmljZSBpdCB0byBzYXkgdGhhdCBJIHRyaWVk
IHZlcnkgaGFyZCB0byBwcmV2ZW50IHRoaXMgY29uZnVzaW9uLi4uDQoNCj4gVGhlIEludGVsIENQ
VXMgdGFnZ2VkIHdpdGggUkVUQkxFRUQgc2hvdWxkIGFscmVhZHkgcmVwb3J0IFJTQkEuIFRoZQ0K
PiBwYXBlciBqdXN0IGhpZ2hsaWdodHMgdGhpcyBwcmV2aW91c2x5IGRpc2Nsb3NlZCB2dWxuZXJh
YmlsaXR5LiBPciBhcmUNCj4gdGhlcmUgSW50ZWwgQ1BVcyBzdWJqZWN0IHRvIFJldGJsZWVkIHRo
YXQgZG9uJ3QgcmVwb3J0IFJTQkEsIGFuZCBJJ20NCj4ganVzdCBjb25mdXNlZD8NCg0KVGhlcmUg
YXJlIENQVXMgd2hpY2ggc3VmZmVyIGZyb20gUlNCQSwgdGhhdCBkb24ndCBoYXZlIE1TUl9BUkNI
X0NBUFMgYW5kDQp0aGVyZWZvcmUgY2FuJ3QgZW51bWVyYXRlIGl0Lg0KDQpJSVJDLCBNU1JfQVJD
SF9DQVBTIG9ubHkgYXBwZWFyZWQgd2l0aCBDYXNjYWRlIExha2UgKG9yIHRoZXJlYWJvdXRzKSwg
c28NCnRoZSBlYXJsaWVyIFNreWxha2UgQ1BVcyAod2hpY2ggYXJlIHRoZSBtYWpvcml0eSBzdWJq
ZWN0IG9mICJJbnRlbA0KUmV0YmxlZWQiKSBsYWNrIHRoZSBSU0JBIGVudW1lcmF0aW9uLg0KDQo+
IE9uIHRoZSBBTUQgc2lkZSwgaG93ZXZlciwgQnJhbmNoIFR5cGUgQ29uZnVzaW9uIGlzIGEgbXVj
aCBiaWdnZXIgZGVhbC4NCj4gQWxsIGluc3RydWN0aW9ucyBhcmUgc3ViamVjdCB0byBzdGVlcmlu
ZyBieSBCVEksIG5vdCBqdXN0IHJldHVybnMgd2l0aA0KPiBhbiBlbXB0eSBSU0IuDQo+DQo+IERv
bid0IHRoZXNlIHR3byB2dWxuZXJhYmlsaXRpZXMgZGVzZXJ2ZSBzZXBhcmF0ZSBuYW1lcyAoYW5k
IGRvbid0IHdlDQo+IGFscmVhZHkgaGF2ZSBhIG5hbWUgZm9yIHRoZSBmaXJzdCBvbmUpPw0KPg0K
PiBUYW5nZW50aWFsbHksIEkgYmVsaWV2ZSB0aGF0IHRoZSBmb2xsb3dpbmcgbGluZSBpcyB3cm9u
ZzoNCj4gVlVMTkJMX0lOVEVMX1NURVBQSU5HUyhTS1lMQUtFX1gsIFg4Nl9TVEVQUElOR19BTlks
IE1NSU8gfCBSRVRCTEVFRCksDQo+DQo+IFN0ZXBwaW5ncyA1LCA2LCBhbmQgNyBhcmUgIkNhc2Nh
ZGUgTGFrZSwiIHdpdGggZUlCUlMsIGFuZCBJIGRvbid0DQo+IHRoaW5rIENhc2NhZGUgTGFrZSBz
dWZmZXJzIGZyb20gUlNCQS4NCg0KQXMgZG9jdW1lbnRlZCwgQ2FzY2FkZSBMYWtlIGRvZXMgc3Vm
ZmVyIFJTQkEgd2hlbiBlSUJSUyBpc24ndCBhY3RpdmUsIHNvDQppdCdzIG5vdCBhIGJpbmFyeSBh
ZmZsaWN0aW9uIHN0YXRlLg0KDQp+QW5kcmV3DQo=
