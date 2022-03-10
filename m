Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 55CF74D5285
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Mar 2022 20:47:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241800AbiCJTsL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Mar 2022 14:48:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233157AbiCJTsI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Mar 2022 14:48:08 -0500
Received: from esa5.hc3370-68.iphmx.com (esa5.hc3370-68.iphmx.com [216.71.155.168])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A25E6199D41
        for <linux-kernel@vger.kernel.org>; Thu, 10 Mar 2022 11:47:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=citrix.com; s=securemail; t=1646941624;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=BgDltcew9AwMG1cAjOXyfwAgzirV47kEqjBEVQbIx/E=;
  b=fZmHnv6cR5vJkgXUzGb9yLtt05Rq1gzIr1q1fCSwa0yFtZ4wRZDSGTi6
   IWPDEVSG+VUj2zvhddDOAt3MpuP8xuUYpIwWnvDoneR3QSYx9RrPB84Te
   ytREwhA5WxodgC+WM+JoLOi8xQPuG5A50A3cBg/pcUMGDf/vcbGLHB+tq
   8=;
Authentication-Results: esa5.hc3370-68.iphmx.com; dkim=pass (signature verified) header.i=@citrix.onmicrosoft.com
X-SBRS: 5.1
X-MesageID: 65427452
X-Ironport-Server: esa5.hc3370-68.iphmx.com
X-Remote-IP: 162.221.156.83
X-Policy: $RELAYED
IronPort-Data: A9a23:TAi1pauXVYZf940y6jzJwEXBJefnVFBZMUV32f8akzHdYApBsoF/q
 tZmKWiFPquIZmfwct4gOom/p08BsZTdn4BqSgE6rX1jHioV+JbJXdiXEBz9bniYRiHhoOOLz
 Cm8hv3odp1coqr0/0/1WlTZhSAgk/nOHNIQMcacUsxLbVYMpBwJ1FQyw4bVvqYy2YLjW1jU4
 YuoyyHiEATNNwBcYzp8B52r8HuDjNyq0N/PlgVjDRzjlAa2e0g9VPrzF4noR5fLatA88tqBb
 /TC1NmEElbxpH/BPD8HfoHTKSXmSpaKVeSHZ+E/t6KK2nCurQRquko32WZ1he66RFxlkvgoo
 Oihu6BcRi9qPK6X29oYTiBgPGJAN4hc5bL8I2ig5Jn7I03uKxMAwt1rBUAye4YZ5vx2ESdF8
 vlwxDIlN07ZwbjsmfTiF7cq1p9LwMrDZevzvllJyz3DAOlgapfEW6jQvvdT3Ssqh9AIFvHbD
 yYcQWQyME6fP0AVUrsRILwTs82wvT72Tyd3qnK4/oV0+i/5xiUkhdABN/KKI4fXFK25hH2wr
 Wva9mD4BFcfPcaezzOe2nu2g6nEmiaTcI4bCrD+9vdsm1CV7mgSDgAGE1q9vfS9zEW5Xrp3I
 VQ88y4voK5iskCmJvHiXhm8iH2JpBgRX5xXCeJSwAiLw6zI40CfD3INXzdHQNUjuIk9QjlC/
 liNktzBHzFjsLSJD3ma89+8tjOvMCg9LmIYYyIACwwf7LHLpIA1kwKKS9NLE7C8hd6zHiv/q
 xiOrS4jl/AQgNQN2qGT41/KmXSvq4LPQwpz4R/YNkqv7gpjbZKsT4Wt5R7Q6vMoBJbJEHGCs
 WIClszY6/oBZbmIlSqCR80XEb2p7urDOzrZ6XZzEJ0x3zCs/WO/Z4dW4SE4KEoBGsUFYz7tZ
 AnIuR5N6ZpUIlOubKlqc8SwDdgnye7rEtGNaxzPRoMQON4rLlbBpXwwIx7Lt4zwrKQyueI9O
 szYT8OxNE41Sppt6SCrStwfwaB+k0jS2ljvbZz8yh2m15+Xa3iUVaoJPTOyUwwp0E+XiF6Lq
 ogCbqNm3z0aCbSjOXePreb/OHhXdSBTOHzglyBAmgdvyCJCEXppNfLeyKhJl2dNz/UMzbegE
 p1QtyZlJLvDaZ/vdF3ihpNLMuqHsXNDQZQTZ3JE0bGAgSRLXGpXxP1DH6bbhJF+nACZ8dZ6T
 uMeZ+KLCelVRzLM9lw1NMeh8tw/LU/w3VzeYUJJhQTTmbY6F2QlHfe+ImPSGNQmVHLr5aPSX
 ZX8vu8kfXbzb1s7V5uHAB5e51iwoWIciIpPs7jgebFulLHX2NEycUTZ16ZvS+lVcEmr7mbKh
 m6+XEZDzcGQ8tBdzTU8rf3dx2tfO7AlRRQy8qiyxeveCBQ2CUL4mN4eCrnUJW6BPI42kY37D
 dhoIzjHGKRvtH5BspZmEqYtyqQ75tD1oKRdwBgiF3LOB2lHwJs6SpVa9aGjbpFw+4I=
IronPort-HdrOrdr: A9a23:6yZLU63tFnd1BDs3H4k0kQqjBRJyeYIsimQD101hICG9Lfb3qy
 n+ppsmPEHP5Ar5AEtQ5expOMG7MBfhHQYc2/heAV7QZniYhILOFvAi0WKC+UyuJ8SazI9gPM
 hbAtBD4bHLfDpHZIPBkXSF+rUbsZm6GcKT9JzjJh5WJGkAAcwBnmRE40SgYzdLrWF9dMAE/f
 Gnl616Tk+bCA0qh7OAdx84tob41rj2vaOjRSRDKw8s6QGIgz/twqX9CQKk0hAXVC4K6as+8E
 De+jaJpZmLgrWe8FvxxmXT55NZlJ/K0d1YHvGBjcATN3HFlhuoXoJ8QLeP1QpF4t1HqWxa1e
 UkkS1QePib2EmhOF1dZiGdgjUI5Qxer0MKD2Xo2UcL7/aJHw7SQPAx+76xOiGpmnbI+usMjZ
 6jlljpxKa+R3n77VTAzsmNWBdwmkWup30+1eYVknxESIMbLKRctIoF4SpuYd099Q/Bmcga+d
 NVfYrhDTdtACSnRmGcunMqzM2nX3w1EBvDSk8eutaN2zwTmHxi1UMXyMEWg39FrfsGOtV5zv
 WBNr4tmKBFT8cQY644DOAdQdGvAmiIRR7XKmqdLVnuCalCMXPQrJz85qkz+YiRCdE15Yp3nI
 6EXEJTtGY0dU6rAcqS3IdT+hSIW2m5VSSF8LAW23G4gMyLeFPGC1z3dLl1qbrTnxw2OLyuZ8
 qO
X-IronPort-AV: E=Sophos;i="5.90,171,1643691600"; 
   d="scan'208";a="65427452"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Tx24JAF0pVw1/oKzqWcz0iYN7pdivDMsA8jMHBbiEJY+tf07f6pH+lI5aqOVgv3iCFGjiTIe3bOJxxFltP5AMJqDuY1IMPQ7oopsgDGq3xP/JCoxcTP4U9DVJ0/AuouUqFIbjbzuRn4knyZqbNRmQT37WX4fiJhyzAPmJrvZNcVn9MRvPoi4wM6uGc2HxSIjIJxIHMdD64uR1hx7syM5KYo+qEMrnCrw3afBb/+Y/Q/lzDrGRpIJ2kcbxyGXJAB9RxiQB/GDTxICqglDZn4E6cm3B8WOyvDXfoqvM1RJxLvpdv9sMhcY2eQerW13XRoGH7U6V1XlqYnHnQwmEUzHFQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BgDltcew9AwMG1cAjOXyfwAgzirV47kEqjBEVQbIx/E=;
 b=gD9OKVw46QRByFOStAI1qFCyki0bH+FyWzvsWqV13a7+u3p3tytYtZZrCliD1QXQBmnSZSjcnYXfcoUvLDGC6LFeZZpGXWkEy5qOGcROPYQKP2Rg9oKhEiuWjlrM6IEY82lcxpPZCBy31LauVYPikUmOFps1xrvQD7YtfsPik1yU8v8jSCyOrocrChnc6R+Ra6fI9FFBRryumCKur20w4N2Sv8HgMGbtr2P4kLiD1kCkOuHPlaMzsxf5uaKV1lec7hdqTns/4IddXDYgl+qTOPWPCLJVU2IwCExwwssFKDIJCpM1f+9wukLFMJwBYoq+EMkVrs9Ioz9zypjSt9GMxg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=citrix.com; dmarc=pass action=none header.from=citrix.com;
 dkim=pass header.d=citrix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=citrix.onmicrosoft.com; s=selector2-citrix-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BgDltcew9AwMG1cAjOXyfwAgzirV47kEqjBEVQbIx/E=;
 b=iVIw75amVzhrCPqBoAQcodhRt/sOIneHYIzmC/pbYzAe02S7cQ7Gmsck2jPKRROAdr/PsGhNurKOJ/jNfCjJtJv4IipsXY/AU4WKLoN8deLWmwgpAhV2m3iHiaxK9nHNp4bkg6dbhQxJ2pMkQh3DvKY9XFQyYJWqalWObCfBQ5k=
From:   Andrew Cooper <Andrew.Cooper3@citrix.com>
To:     Bharata B Rao <bharata@amd.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "x86@kernel.org" <x86@kernel.org>,
        "kirill.shutemov@linux.intel.com" <kirill.shutemov@linux.intel.com>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "bp@alien8.de" <bp@alien8.de>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
        "will@kernel.org" <will@kernel.org>,
        "shuah@kernel.org" <shuah@kernel.org>,
        "oleg@redhat.com" <oleg@redhat.com>,
        "ananth.narayan@amd.com" <ananth.narayan@amd.com>,
        "Andrew Cooper" <Andrew.Cooper3@citrix.com>
Subject: Re: [RFC PATCH v0 3/6] x86: Enable Upper Address Ignore(UAI) feature
Thread-Topic: [RFC PATCH v0 3/6] x86: Enable Upper Address Ignore(UAI) feature
Thread-Index: AQHYNLebTUcnJFmJckKqzLkQmpfxIw==
Date:   Thu, 10 Mar 2022 19:46:59 +0000
Message-ID: <7fccb7f2-fc88-993e-e1b2-919448844112@citrix.com>
References: <20220310111545.10852-1-bharata@amd.com>
 <20220310111545.10852-4-bharata@amd.com>
In-Reply-To: <20220310111545.10852-4-bharata@amd.com>
Accept-Language: en-GB, en-US
Content-Language: en-GB
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: ea32d557-5e9a-4deb-a002-08da02cebdca
x-ms-traffictypediagnostic: SN6PR03MB4415:EE_
x-microsoft-antispam-prvs: <SN6PR03MB44151D31D10AD4E1E4B02FD7BA0B9@SN6PR03MB4415.namprd03.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: gzPc0W9gTKgYudr91xyufv/Q/60c9EVXzvd34B5saVOpoBOaedcAlcCMMldwSnECHwHVpMMB1triIlQdrfUonXmlt+jkpYmyH9gDDGGK2J5AzIP9e6m+xDy+sO3yenyX6E8bHrxBzopGgeCBt6HzkYueVIrCmmH6gVNg5lBEGuGUhwXM6Wl9m4rbVYP8feKYgTQlQYcJtnTv0vYDGn0muasxixtL2BaW1KhjI/ne68DswCMItQUXWPP3fYGPLwz48cBsJm7pE/8aTOBIdh05p6YHDyUqvHwZ8nppRnWJzjMAgG9wjXepkCXZcN2/bcG5QlKjS7eAeycbmYEJA51jPPMCV7u6fR2/ITQegd3N21oX6IWtevEIZrGMsB4ncfK/Gp1pSi2f6vrDvDdW1jsN5CR/HeMHvR/LS4rSR/aDSjRRe+ZBK7RZNUpPJdmsfJm748IQyqnOv9DwGi2vDOfm3kzGFo2lVunCHk0qrSY0BfgJM8dkit/0k3cNHLxdjl7mkjpkkuDL1rZ3lBbHuYKwT0hNOJu/azvuqXjC1TNPn3q5GEdTtxjCLx28S+yqAmACmmt77+pJYLFI/YqssdqxqyQahN9ue3Jz1wtAtY0yN5JdaH6AfosBEUTGn9CaHmMCgxNgsSQgqnDsJp/6Dwk/dfP7SeumlyAmjLSaqCfqlNURmOISY5CSKtBXhQbU1AKN7xDph6/Uu7ZK8u3QVmNRIj3+h2EuhWjJDazNZggGBCsjpI+tqnfO14u34s2j3Csnan5tWC7TLlq3LN5c6MLKDA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR03MB3623.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(54906003)(110136005)(6512007)(66946007)(6506007)(316002)(76116006)(82960400001)(26005)(53546011)(91956017)(38100700002)(186003)(71200400001)(2906002)(107886003)(7416002)(4326008)(5660300002)(8676002)(122000001)(508600001)(66476007)(66446008)(64756008)(66556008)(6486002)(83380400001)(31686004)(36756003)(8936002)(86362001)(31696002)(2616005)(38070700005)(43740500002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Z24yc0tXeXhzcnJVSURoY1BSTGZGTW9UUXRCNkpnQWcrQzFIVnBIUm5INmIr?=
 =?utf-8?B?eFU0MXJKS1BvVXdYcURpYTN5WWhiODMvQzF2VTViWjhLTWtHQlVGTXU3NXBa?=
 =?utf-8?B?RWorOGx6VW4rYkYwYys1OWF1ZTA3VGZhQU01YUVrakxENXhPZHBDYzNja3g0?=
 =?utf-8?B?WVZjU0EwZ0ExeVZjNkJoeWNrK1JtUEtRc29OK3ZrLzMwdVFSRHNOWlNYcWJn?=
 =?utf-8?B?SGlGYVVPWDZ2RHkwVWRZV0pYK1l4OEVNY2lJekt5QWtwMXFNZ3ZNT3BQcXFs?=
 =?utf-8?B?RHpmSDBhUXNZTDlNckRWaTU1ZVdJV1ROZ29GSURUSU1tS2tObmhGSW5naTVC?=
 =?utf-8?B?b1l2cjM2Yml6RDY5TEhpelA4bmRIUDNqSnBGVktnbUZvK1hXYXFTN2o2cnNG?=
 =?utf-8?B?Q3JRS1lWTFRvdTk2SXdUTkxIck1ZNUd5NTFEWnlDWEVPNmgzaFRHZFZGMys1?=
 =?utf-8?B?TSt0b1N2c004dTFRenJTK2lBY2gra2w1WU5ZR3puSFpQTTdRdk5BM0F5TUll?=
 =?utf-8?B?MU9iU04wMnZUYWNhaHFRSEF1N2phalc3Y3IyV2VuQU16RTRXbzI4aDJGOVNQ?=
 =?utf-8?B?QWx3ajNpNnk1aGpIL1BBTDIrQTZXSTYvZ0FscFN1RzB6S20xQkswY2JyV0x4?=
 =?utf-8?B?aWpwYmNCbEpJcHFHSS9HUGV2Q1Y5d2xxTkV2ZFhPRCtsV2Nsa3NaT25MRW4z?=
 =?utf-8?B?dHpoZitTU05OWVIzMUNGeGhNWE5TQzdkSy9YTDk3M0lZVUxGTkJSc2hmNWhw?=
 =?utf-8?B?OFB1VmlTbTF4UjFhSXl1NmoxWHA3bHRmL0xnazFKUEJZZ2d4bDU2OFplSlRu?=
 =?utf-8?B?eEJaSlBnWi9sdFNacGdYVk5qV3kzRC8vUzdNWEkzY1BiV0xJcUdVQlB1bEpY?=
 =?utf-8?B?NEhVdWVhWXIvb21CSkVaYW8yUXRwQitnb3MwcTEwR3lBQ3NuQ3ozNjdPbmlx?=
 =?utf-8?B?ZWNoSlJHQ09vRVlpSndzV1dYRk56bTF2cmNWK0lXOGx3RlBiVGEwOTBPV2lU?=
 =?utf-8?B?UTk2b05ESjBlRXQ4Szd1cllNcDFnZlI0WWh6OWVWTVJzakRDVG9Ia3hSek1Z?=
 =?utf-8?B?eXJReGlhcXo3akxXa3YwaUhKOHhIRFF0b0FSOUFLOW9LS2ZPR3NEZmtmWk92?=
 =?utf-8?B?YVVhM003VmdlRFg2YTdGd0tmNXdqVkhNbGtRNVhtRktXUU9kSWp4ZEJLRWk5?=
 =?utf-8?B?YkllU3FMcFRkVWxoSUV6Z1EwOTVETytURjUyVEVnM1BlYjMyNXJ0Z3lQcktJ?=
 =?utf-8?B?dVFIeEtieTdRS05LZ09rdWw1bml0dVEzdTAvUmthTGVJQkhFVzBLSWhweFlI?=
 =?utf-8?B?ZlhxNENNOXZ3M2NNUThRMlA0SWJSWFVxdjlrL1hhdm1VRk9rMjNwSmRUZGx5?=
 =?utf-8?B?UEcxSTRXcWlKTHkrVnZ4UGVtbExkR3U4RkYvZU1HOFkxL2R2blBEZ1NDWTRU?=
 =?utf-8?B?dXA5OHpRa2xINllhU0NnOSs3eUJzeFRSTzJqdTZDQXovSXJRV1RZWXc0ek8z?=
 =?utf-8?B?RXlEYmVHVFlXZHBRV25wdVY4Z0hNNGlTZS93SzBqZ2RabzBoVnhjYXhBSjlF?=
 =?utf-8?B?aE9NeXo0ZlJOdjIwSE5GWkFmUnh2NnZiRTdsaDRZSmkwZWlDTXorZEl2WlVv?=
 =?utf-8?B?amdJM2hZNHAzV1d5Sldoa0t3OVIvUUhNTHlUSG1GSENJdW9ySW1YblNvZ2FY?=
 =?utf-8?B?dU43UzJjK2tKSmxjd21HSzhoa0U5cHQxWi9sRzJPM3JSYy8zamhEc1N2aklr?=
 =?utf-8?B?MFphcnNscG5mQmZSYmIzZWM1S1V5aDNBem1rVkk5M1RUWjJZYzBTdmRJZ3pB?=
 =?utf-8?B?TVcraWtZTDFmRHozcUtTMy83ZTBMa3N2SXhWZXZNc3N2ZWVsOHphRHp4Rkta?=
 =?utf-8?B?L1NnSHg2blcyMWlwWmlic04xWURMTTk1aGZ0UU8xK0pFaDRhMnVoTmxOZTdF?=
 =?utf-8?Q?89gn/2vD0trdPMY5mtYJfe1VnnCSmwZM?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <DEDE6834CBAB5D4EA42EF9DED8128065@namprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR03MB3623.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ea32d557-5e9a-4deb-a002-08da02cebdca
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Mar 2022 19:46:59.6256
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 335836de-42ef-43a2-b145-348c2ee9ca5b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ZoeZ/+1W/cnqOtUSiIGjOEWpfG4rySmdD5/WlMV2doz1/UeK1dKg/x2YeF87acei7rwDr4LK6ga9VBojkrKqy5JYL30oaGXaM2u2gu2qZ0A=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR03MB4415
X-OriginatorOrg: citrix.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gMTAvMDMvMjAyMiAxMToxNSwgQmhhcmF0YSBCIFJhbyB3cm90ZToNCj4gZGlmZiAtLWdpdCBh
L2FyY2gveDg2L2tlcm5lbC9zZXR1cC5jIGIvYXJjaC94ODYva2VybmVsL3NldHVwLmMNCj4gaW5k
ZXggZjdhMTMyZWI3OTRkLi4xMjYxNWIxYjRhZjUgMTAwNjQ0DQo+IC0tLSBhL2FyY2gveDg2L2tl
cm5lbC9zZXR1cC5jDQo+ICsrKyBiL2FyY2gveDg2L2tlcm5lbC9zZXR1cC5jDQo+IEBAIC03NDAs
NiArNzQwLDEyIEBAIGR1bXBfa2VybmVsX29mZnNldChzdHJ1Y3Qgbm90aWZpZXJfYmxvY2sgKnNl
bGYsIHVuc2lnbmVkIGxvbmcgdiwgdm9pZCAqcCkNCj4gIAlyZXR1cm4gMDsNCj4gIH0NCj4gIA0K
PiArc3RhdGljIGlubGluZSB2b2lkIF9faW5pdCB1YWlfZW5hYmxlKHZvaWQpDQo+ICt7DQo+ICsJ
aWYgKGJvb3RfY3B1X2hhcyhYODZfRkVBVFVSRV9VQUkpKQ0KPiArCQltc3Jfc2V0X2JpdChNU1Jf
RUZFUiwgX0VGRVJfVUFJKTsNCj4gK30NCj4gKw0KPiAgLyoNCj4gICAqIERldGVybWluZSBpZiB3
ZSB3ZXJlIGxvYWRlZCBieSBhbiBFRkkgbG9hZGVyLiAgSWYgc28sIHRoZW4gd2UgaGF2ZSBhbHNv
IGJlZW4NCj4gICAqIHBhc3NlZCB0aGUgZWZpIG1lbW1hcCwgc3lzdGFiLCBldGMuLCBzbyB3ZSBz
aG91bGQgdXNlIHRoZXNlIGRhdGEgc3RydWN0dXJlcw0KPiBAQCAtMTE0Niw2ICsxMTUyLDggQEAg
dm9pZCBfX2luaXQgc2V0dXBfYXJjaChjaGFyICoqY21kbGluZV9wKQ0KPiAgDQo+ICAJeDg2X2lu
aXQucGFnaW5nLnBhZ2V0YWJsZV9pbml0KCk7DQo+ICANCj4gKwl1YWlfZW5hYmxlKCk7DQoNCkkg
d291bGQgdGhpbmsgaW5jcmVkaWJseSBjYXJlZnVsbHkgYmVmb3JlIGVuYWJsaW5nIFVBSSBieSBk
ZWZhdWx0Lg0KDQpTdWZmaWNlIGl0IHRvIHNheSB0aGF0IEludGVsIHdlcmUgdGFsa2VkIGRvd24g
ZnJvbSA3IGJpdHMgdG8gNiwgYW5kDQphcHBhcmVudGx5IEFNRCBkaWRuJ3QgZ2V0IHRoZSBzYW1l
IG1lbW8gZnJvbSB0aGUgb3JpZ2luYWwgcmVxdWVzdGVycy4NCg0KVGhlIHByb2JsZW0gaXMgdGhh
dCBVQUkgKyBMQTU3IG1lYW5zIHRoYXQgYWxsIHRoZSBwb2lzb24gcG9pbnRlcnMgY2Vhc2UNCmZ1
bmN0aW9uaW5nIGFzIGEgZGVmZW5jZS1pbi1kZXB0aCBtZWNoYW5pc20sIGFuZCBiZWNvbWUgbGVn
YWwgcG9pbnRlcnMNCnBvaW50aW5nIGF0IHJhbmRvbSBwb3NpdGlvbnMgaW4gdXNlciBvciBrZXJu
ZWwgc3BhY2UuDQoNCn5BbmRyZXcNCg==
