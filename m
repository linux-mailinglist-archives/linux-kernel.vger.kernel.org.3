Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4ABC04B7C30
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Feb 2022 02:12:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245218AbiBPA6E (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Feb 2022 19:58:04 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:45210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239849AbiBPA6C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Feb 2022 19:58:02 -0500
Received: from esa5.hc3370-68.iphmx.com (esa5.hc3370-68.iphmx.com [216.71.155.168])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33042DCE11
        for <linux-kernel@vger.kernel.org>; Tue, 15 Feb 2022 16:57:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=citrix.com; s=securemail; t=1644973072;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=eh7ih7FMFUamqe/SnZKNwoLZz9pzQtXrg9UmEiqeLC0=;
  b=B52VO2wlGUh/7uKsBibiXearG6fOtQiFA3WaVp8pr4P49akIC/lB4f+r
   MZNJZTpjZ7mmVMUmiv3nQyffDMLmV1L+adgM8urv/aPuUn4vtvmUgRu62
   mbSCbdOq53h76Ni/VxW0pR3kbLHmQ0Lpzr1PT2pFeaBJefEjwmk8wKS77
   g=;
Authentication-Results: esa5.hc3370-68.iphmx.com; dkim=pass (signature verified) header.i=@citrix.onmicrosoft.com
IronPort-SDR: bdbE+qR7dBHaKmqXzwjTWtxggogksaO2UXH04c4jSSC8mquObH/7p+qWTWybMiLJHJRu1TSNma
 YIYyeVavBzkFLa4EpFwMi29pwyvBk5s0QGVdnGS9uMplZqI+BCYHlyTSwBDNN2fTq1SCik4Q3T
 rE/P4O4VPFjN5gDX79uJLeE+5r4fES8jYq3vQnKYhoccXu9GNkno63qMuRn1U9fhEccfUIvbd9
 g38jPZO/5SyU7ExJdH/kJL7RN+QPDHisHCnGV5QXGb/4eEDxWPU8HEi9wzPdYMXuVu6mK8awmO
 B4NzkbxfEGX1NmMSNjYXw30N
X-SBRS: 5.1
X-MesageID: 63742122
X-Ironport-Server: esa5.hc3370-68.iphmx.com
X-Remote-IP: 162.221.156.83
X-Policy: $RELAYED
IronPort-Data: A9a23:VaSwBK4guikfckPMXdFcLQxRtDjBchMFZxGqfqrLsTDasY5as4F+v
 mFMWWrXPq6DNmf9edogYIyy/E1T6JPcmIBjTgZt/y9jHi5G8cbLO4+Ufxz6V8+wwmwvb67FA
 +E2MISowBUcFyeEzvuV3zyIQUBUjclkfJKlYAL/En03FV8MpBsJ00o5wbZj29Mw3bBVPivW0
 T/Mi5yHULOa82Yc3lI8s8pvfzs24ZweEBtB1rAPTagjUG32zhH5P7pGTU2FFFPqQ5E8IwKPb
 72rIIdVXI/u10xF5tuNyt4Xe6CRK1LYFVDmZnF+A8BOjvXez8CbP2lS2Pc0MC9qZzu1c99Zl
 +lQ5bmyQjUQE6TyhsIFUCMFQz98MvgTkFPHCSDXXc27ykTHdz3nwul0DVFwNoodkgp1KTgQr
 7pCcmlLN03dwbLtqF64YrAEasALBc/nJo4A/FpnyinUF60OSpHfWaTao9Rf2V/cg+gQRqmCP
 ZNDM1KDajzOTxRWAmwKKasGgcvztmWmQX4BjXeK8P9fD2/7k1UqjemF3MDuUtiLQ9hF20WVv
 GTL+0znDRwAct+S0zyI9jSrnOCntSHjX4MXHrq13uRnjF2a2ioYDxh+fV23rOKwl0q4Wt9FM
 GQb/S0hqaV0/0uuJvH5WwO9iHqFpQIHHd5RFfAqrg2A1ML8+A+cB3QDSiBIbtEgnMAxQjMu2
 xmCmNaBLT5oubq9TmyQ7LuOrC2/ISkHP2ZEbigBJSMd7sXuupMbjxTBVN9vHae5yNrvFlnYw
 D2HtyM5gLY7hs4R0KC64FWBhCijzrDJTApz+gLQWnmN4QZwZYrjbIutgXDLvahoL4uDSFSF+
 n8elKCjAPsmVM/X0nbXGaNUQe/vt63t3CDgbUBHQKU8pxGv8EyaUIlu/hdmJ300YtgGdmq8C
 KPMgj956JhWNXqsSKZ4ZYOtFsgnpZTd+cTZuuP8NYQXPMUoHOOT1GQ3PBPLgTix+KQ5ufxnY
 f+mndCQ4WH24EiN5B6/XK8j3LAi3UjSLkuDFMmgn3xLPVdzDUN5qIvp0nPTNojVD4ve+W05F
 uqz0ePQln2zt8WkP0HqHXY7dwxiEJTCLcmeRzZrXuCCOBF6P2oqFuXcx7gsE6Q8wfgJx7qRp
 CDsCxYCoLYauZEhAV/XApyEQOmxNauTUFphZXB8VbpW8yRLjXmTAFc3KMJsIOhPGB1Lxv9oV
 fgVE/hs8dwUIgkrDw81NMGnxKQ7LUzDrVvXY0KNPWhuF7Y9Fleh0oK1IWPSGNwmU3PfWT0W+
 Ob7iGs2gPMrGmxfMSohQKv0kQ3o5SFHwL0asomhCoA7RXgAObNCckTZpvQ2P9sNOVPEwD6b3
 ByRGhAWua/GpIpdzTUDrfnsQ16BH7QsE0xEMXPc6LrqZyDW8nD6md1LUfqSfCCbX2Txof3wa
 eJQxvD6EfsGgFcV7NYsT+c1lfozt4n1urtX7gV4B3GXPV6lPaxtfyud1s5Vu6wTmrIA4VmqW
 liC88VxMKmSPJ+3C0YYIQcoN7zR1fwdljTIw+4yJUH2uH1+8LadCB0ANBiQki1NarByNdp9k
 +smvccX7S25iwYrbYna3nwFqTzUIyVZAas9t5wcDIv6sSYRywlPMc7GFyv7wJCTcNEQYEMkF
 SCZ2fjZjLNGy0ucL3dqTSrR3fBQjIglsQxRyANQPEyAn9fIi6Nl3BBV9jhrHA1Zwg8ejrB2M
 2lvcUZ0Ob+P73Fjg80aBzKgHARIBRu4/E3tygRWyD2FHhfwDmGdfncgPeut/VwC9zMOdzdWy
 7iU1WL5XGu4Z8r2xCYzBRZopvGLoQadLeEedBRLx/i4IqQ=
IronPort-HdrOrdr: A9a23:oIKD8KknVMTf6rDNVyiRp5QpUq7pDfOIimdD5ihNYBxZY6Wkfp
 +V88jzhCWZtN9OYhwdcIi7SdS9qXO1z+8R3WGIVY3SEjUOy1HYUL2KirGSggEIeheOudK1sJ
 0PT0EQMqyIMbEXt7eY3OD8Kadb/DDlytHpuQ699QYUcegCUcgJhG0ZajpzUHcGPzWubaBJTq
 Z0jfA3wwZIDE5nCPhTcUN1ONQryee79q7OUFojPVoK+QOOhTSn5PrRCB6DxCoTVDtJ3PML7X
 XFuxaR3NThj9iLjjvnk0PD5ZVfn9XsjvFZAtaXt8QTIjLwzi61eYVaXaGYtjxdmpDs1L9qqq
 iIn/4TBbU115rjRBDynfIr4Xi47N8a0Q6n9bZfuwq6nSW2fkNgNyMLv/MnTvKQ0TtfgDg76t
 MX44vRjesmMfuL9h6NluTgRlVkkFG5rmEllvNWh3tDUZEGYLsUtoAH+lhJea1wVh4SxbpXWN
 WGNvusr8q+sGnqG0zxry1q2pihT34zFhCJTgwLvdGUySFfmDR8w1EDzMISk38c/NZlIqM0q9
 jsI+BtjvVDX8UWZaVyCKMIRta2EHXERVbJPHiJKVrqGakbMzbGqoLx4r8y+Oa2EaZ4gacaid
 DEShdVpGQyc0XhBYmH24BK6AnERCGnUTHk2qhlltFEU33HNczW2AG4OSITevqb0oIi65fgKo
 WO0bptcoreEVc=
X-IronPort-AV: E=Sophos;i="5.88,371,1635220800"; 
   d="scan'208";a="63742122"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KBBYlJG/1DYfw3WY5wKg6fOkcZvK7AKqu5ft8zqGdDwUnKVFsd8YF8wrW6fxGmNH+lcFRCr3b7dhgih7Ra9nhHszMc/EDyl45OjcoE0Pl3wh8MyseLHJWML7seP/rDzmHHSrzbmGfTw9GkMnr/W1Fyvz6X6OeJFEp3XpxFTFSRHS1H507Ok/M6WZ6xil0CpcTLM3klt5irPTedZac/cFZ/Jeazmy+5/AsYipUdVG5PFa3dzHYhY+zDdJSy0V4tlxww1WFZyDPjwC3lAhVzmhWocrTk7DBnWHhcVHFm3igHpYSSAtCbnbZFGpyD2qVhQvA6iOSKzSgiTmpA576Yga2w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eh7ih7FMFUamqe/SnZKNwoLZz9pzQtXrg9UmEiqeLC0=;
 b=PlNBZNF/ZwnizWCO6X6AbYogN4LJ+lFPmYI/qllYOOKO+9UMaHR0xIKDXma3G/B+MzAorZ+vh4wVypiAw3brrgVld5xU378RZFTg0gFLn9STNJDkSOl/dvUrEAcOZege3xUXC+lOyWMzSGRQX+3jIgfPYnXyB7IlUQ10LdjaVs1sM3zGBAW2UTaR3H84OWgu/N6yAwy2a1i8yabDdTWmwvn2TKfNHsQvb9sjgl9k8oM9u2qGciH5938d7gl3V2ynKlhyLPCgc8caRCKX7xddxTIIapgD6dhXlBunwtf5x8NSuGG9GAltsqwxemHpeUcWj9hwRNGIVhEZnejgcLba5A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=citrix.onmicrosoft.com; s=selector2-citrix-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eh7ih7FMFUamqe/SnZKNwoLZz9pzQtXrg9UmEiqeLC0=;
 b=B9wyUmAlUc4D9GLu9Z60FKNVJ69pPdgvWWrYO+EF8iFyUf4b71I7FlzzmP4oUNXm9FR9v6yezawIrAWeIQsi5+iqFDS8rSzAzEfIFZxh9zv1qyG05FHG0bU2nWKBcEm6n+BB9Ms/fM0BYpbSEu3X86atVbNLxIk3+oS5fIcambs=
From:   Andrew Cooper <Andrew.Cooper3@citrix.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Joao Moreira <joao@overdrivepizza.com>
CC:     Kees Cook <keescook@chromium.org>,
        "x86@kernel.org" <x86@kernel.org>,
        "hjl.tools@gmail.com" <hjl.tools@gmail.com>,
        "jpoimboe@redhat.com" <jpoimboe@redhat.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "ndesaulniers@google.com" <ndesaulniers@google.com>,
        "samitolvanen@google.com" <samitolvanen@google.com>,
        "llvm@lists.linux.dev" <llvm@lists.linux.dev>
Subject: Re: [RFC][PATCH 6/6] objtool: Add IBT validation / fixups
Thread-Topic: [RFC][PATCH 6/6] objtool: Add IBT validation / fixups
Thread-Index: AQHX38R0G51p8OjCjEWQgZqKh2L/EKxBFgIAgEm1i4CAACxYAIAAHTIAgAAUYwCAA7AsgIAHBz6A
Date:   Wed, 16 Feb 2022 00:57:47 +0000
Message-ID: <a599d509-8995-0eb6-65a1-5d8505e4851e@citrix.com>
References: <20211122170301.764232470@infradead.org>
 <20211122170805.338489412@infradead.org>
 <6ebb0ab131c522f20c094294d49091fc@overdrivepizza.com>
 <202202081541.900F9E1B@keescook>
 <ad6c2633f39e39583bc5c5eaf7ccbe52@overdrivepizza.com>
 <202202082003.FA77867@keescook>
 <9ea50c51ee8db366430c9dc697a83923@overdrivepizza.com>
 <20220211133803.GV23216@worktop.programming.kicks-ass.net>
In-Reply-To: <20220211133803.GV23216@worktop.programming.kicks-ass.net>
Accept-Language: en-GB, en-US
Content-Language: en-GB
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.0
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: f24edaf9-7492-4eac-fc55-08d9f0e75986
x-ms-traffictypediagnostic: DS7PR03MB5573:EE_
x-microsoft-antispam-prvs: <DS7PR03MB557379EDA815BFC25BA472E8BA359@DS7PR03MB5573.namprd03.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7691;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: v354ZuGY1pZlh0GHB4pPK1x8m5g+M8qklOcgXveiKY+klq1VVxv5zOnDdoa2TlsRzTk2zhDphZ+ttZxnfT16gjuZdyT69R5CfMvc2/wPsrwBHnzACyo6lKThhS792ZhCTN2/I8JwcPEvDexd/r1Qt0RDO9Uit5SS2YQBgtbiQzKlsVo1R94gHhmWiKB88Gl8gcAev8fX2A5nOnyAD5BWpGepB8xrcIAH0fC8uuwidq4LuKBNntBvpvu51/w6s81/QUa826u01hJKnCBF6p5l8QQ03m31qKe6CQabG1ozGA/jve16W4xjIyoJf9J7DBWcAdUvRGefvkspQAWSTT6ips/Vnb4+BYmIp2+WcOkoEJI6LZnUJGpyvnn9nch9XGZlUOaWLh10W62VX/6mF5B0+6IQqMNOhvY5BCzL3Pd7P4hzL8B7+aJZ5Z8NesZ6lrBch4FY+xUR1/gCfX5DSrAlJ3WQGZGCNOaYCLekFod+p0JvLNSroFrN+gd9o8xX2spXdDRR5us5dL/iLMUraaasTAUEGX0jmOpDyIX+tJhGmva+0p/IKSe1uuyUdBEWKQO8Pzdqef2Q1KBX9KP/hIjOejvl+bKn69N4C5IAZyDbuxGXVsuCV4Fs8rRmR2KE4F/ukSCMdF9HXOl5ZyzDmBs7YsHwYSPGucbNsDbMZ9lV2OQtqh2EuTwn4p9UDMGEPrO2EkiuQealmNRRxIX8r1XfKvOLKKCU36ZC44BVfHBgUTm3dGMeyDkdtGr0eLENqKvf/BKLGLK+chdQapmTkeYXyw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR03MB3623.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(54906003)(316002)(66946007)(76116006)(91956017)(508600001)(66556008)(6506007)(66446008)(64756008)(66476007)(38070700005)(4326008)(53546011)(31696002)(86362001)(6512007)(110136005)(6486002)(8676002)(71200400001)(31686004)(122000001)(26005)(2616005)(7416002)(4744005)(82960400001)(2906002)(36756003)(38100700002)(186003)(8936002)(5660300002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?cG0ySWNLcm5zOUpwYWd0RGpnVmVaTWY0emliSkxmNmRPYzdob1JNelh4MVMv?=
 =?utf-8?B?ZHRCNWJIaEdsNHEyWUp6YmRnNkdLTjg4Vkw0UGlTcEt2ZVlZZjZUUGUwWUpS?=
 =?utf-8?B?T0V2cDJUSUoxWDRKUFFJU0tXci9mZmJHL0wzNTlzUFA4RUs0RERUcllneUxq?=
 =?utf-8?B?VlBWdXNCVGdpWXFURXpZc0RpZDdDMjJ6bGU3OGRSNjlXMWJjcklzaTltSUR2?=
 =?utf-8?B?SG9TQXZSejAybnRUYmFYOXdFSUkvaSs1amdqQ0tWVXV6blZhMzFEUkxqYU9K?=
 =?utf-8?B?L1ovaXFUYUdFNnhONFdzTUo5aHplTVgwVXB0S1c1MlYzaHRRU3l4aFU4b1FX?=
 =?utf-8?B?eURoaGQwTnRvTXZUMzNQRlY2bHZ3eVB3bTU1aG9SdHRkYzlxOXU1STdubis0?=
 =?utf-8?B?bEU3UzBNQms1eHhXWnRLM1pES3hHQlhua3RGdUREWUdBdTAzc1dTbkN2aDA1?=
 =?utf-8?B?aFNGd1doSW9ZdmN1cTU5b3ZxU3ZtUE1LQXVyWDdQSFJDK05uMzVBRWk2SEYr?=
 =?utf-8?B?dE9FYVdoLzFsa2xJVDZnTUxOcnV4Mm1QZjdMbFBkVERNMk1MMGJuQzB0Vith?=
 =?utf-8?B?MWJZMkd3aitGdS96eUZEN2FvaHV1ai9UWmJpQ1RGOEp0dGg1UTRXTlBBaVIv?=
 =?utf-8?B?TmhuU1owdWs1d3VWT3FiYnJCK0RPakgrY2JhWldEa3BxK2ZuQkhHb003ckhv?=
 =?utf-8?B?RklLZVU4TXZjVXNNRzdXeEZ1S204M1hqcUdFck8yZnVUNEEwM1ltUUpaOGl0?=
 =?utf-8?B?OHBqL3J0TFV1SFhzaEhWRTVJZWE5ZGFXS3FMVkcwVTZjMlJ5VngreDlDQ1lG?=
 =?utf-8?B?TmFvbTZLU3l6NUUwZEloUmxsTEhLa0dzODF2WVVYMVV4Z2szNk1TTE9oODVN?=
 =?utf-8?B?OXJtaUNFNHdlaytZM1VvN01OKzl2ZGFxWEJqSi9DZUUrMHdnRHphbHpXN3dD?=
 =?utf-8?B?ak14OVhleHNSZHdtYUVSbkFoamZ3N0UxU2cvU3IwMzBONE1BV3Y5cElQT0tk?=
 =?utf-8?B?UzkrR1ZraS93bzZYSUN2M3V3SHFDWG9iQzNMeEVVcEt5TWRUeUI5YThPU3lG?=
 =?utf-8?B?dWVBZXhscXVyOTZscGpUSGpJT2tBL3E3RktqRGFTczlLSkVzbVlRK1NxRXZS?=
 =?utf-8?B?OWZWQ0VYYVRiNUFrM0xpMUxIZFBiaWhSMGFZYnQxNk9MOVdZYXhndnV4U2tL?=
 =?utf-8?B?SDY1RGJvcEpXcHA4RHdWYlBUZnFvdlNjQU96QWpCcE5vbDlCVTdDVmNhc2to?=
 =?utf-8?B?eTBYSTE5b1E4SEUrV2dwMzhCdkxPd0dMSWhwamNsT2IrWDRmT3JoN0RLQ1lR?=
 =?utf-8?B?N2ZadzcwVUNkaVBkWm00NUhmTWhvM2dJU1NwOFhPaHJEdmN0b3hOenBFMlpK?=
 =?utf-8?B?ZUJZKzBicWdmckdJYTBWT0R6YTM3UzhRbXhIN3ZqWWt2Y0ZXb2xHYXA3Rk9S?=
 =?utf-8?B?cmNjOXNKU2hyL1gyK0UwaVFCcW9CZFNoOXpvN1k2WkxXTVBJM1hVaXVRT2ZG?=
 =?utf-8?B?SHkrazVDU254empodjBzT2ZyazgxSUZ3NDNpY3NrT0FQMkZ2YTY2T25sbnZI?=
 =?utf-8?B?THYvVHAzNXdOVVdYRjZnNW5OUkY4OVRtaFBRdUdGeHNXdUxwSU1UYlFXTnFU?=
 =?utf-8?B?NGhsRE9TMlpzMm1KMTFtQ3d4OHN2L2dMWmVrZkF3ckhHWTRQODlLSURwNUF3?=
 =?utf-8?B?ZW5wTUQ2T1hCc2UxT2N6VE5ZTHdlaU9NRFNNQXZZZVp4ZE5DWEhyc2daK0dP?=
 =?utf-8?B?clRYdU9XalhWaWJLR1dWbWVyMEVnVjg2TzBjOWtRd3BEazNlNmZFTGZqdkdL?=
 =?utf-8?B?bG5wL0liYnBPdGpoYUJrRzFqUktiN3FESHd4NlBHR3ZPdkxJMVlCTTUzTUpz?=
 =?utf-8?B?V0hnNytObHdxSVRLK3kxYXdBSjA1NFVJZ2d3dTIvUkJxdkNDL1V1cXJqNlg3?=
 =?utf-8?B?OWFyaVkzSmVEaWlMVzFaL2g5bS91K0pHWEdldFdIeWg5c2h1cFV3YlR4bVdQ?=
 =?utf-8?B?Z3F2K0xaS2tMMTY5WkIzYURzNGpZSDNpeUlQS3pTdnAyaFhqVklYQzI4TEtR?=
 =?utf-8?B?cytnY1lhYnhvSy90SlY3WHYvenJmemxDUFg5cm5Ed1E2OVRUVEFxcngvZGNW?=
 =?utf-8?B?NFhCdit3cFJTWGRXNUdMRHpJRVA5KzVDc1lHQzZLaXljSDFIUjdRalRRa3Bx?=
 =?utf-8?B?cVhvRUhnL1RnbVdlUjV1a1g3YkljK3VSTEVNWFRtdTl3Uk1FeDZIeXoxRG4z?=
 =?utf-8?B?SHhsZ2ozakZ0bUhXU3RPbUl2bFR3PT0=?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <9958A22146AB684E9401012157EC4DF4@namprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR03MB3623.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f24edaf9-7492-4eac-fc55-08d9f0e75986
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Feb 2022 00:57:47.8984
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 335836de-42ef-43a2-b145-348c2ee9ca5b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Lts+ojD/5lAIZ6qst5/7ZFym/eigd8MtxBxhLbD4wNO/ahmYCHMTrlEN3f7HKTDKPvbaDGRQ1FJse5VYPUspAFd0YbpkODJXPAwzAGzf9sc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR03MB5573
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

T24gMTEvMDIvMjAyMiAxMzozOCwgUGV0ZXIgWmlqbHN0cmEgd3JvdGU6DQo+IE5vdywgdGhpcyBz
ZXR1cCBwcm92aWRlczoNCj4NCj4gIC0gbWluaW1hbCBzaXplIChwbGVhc2UgeWVsbCBpZiB0aGVy
ZSdzIGEgc21hbGxlciBvcHRpb24gSSBtaXNzZWQ7DQo+ICAgIHMvdWQyL2ludDMvID8pDQoNCkl0
J3MgcHJvYmFibHkgYmVzdCBub3QgdG8gb3ZlcmxvYWQgaW50My7CoCAjQlAgaXMgYWxyZWFkeSBo
YXMgbWFnaWMNCnByb3BlcnRpZXMsIGFuZCB3aGF0IGhhcHBlbnMgaWYgc29tZW9uZSB3YW50cyB0
byBicmVha3BvaW50IG9uZSBvZiB0aGVzZT8NCg0KSSdsbCBtYWtlIG15IHVzdWFsIGludG8gc3Vn
Z2VzdGlvbiBmb3IgNjRiaXQgYnVpbGRzLg0KDQp1ZDIgaXMgdGhlIHNlbnNpYmxlIGFwcHJvYWNo
LCB3aXRoIGEgY2F2ZWF0IHRoYXQgd2hhdGV2ZXIgaXMgaGlkaW5nIGhlcmUNCnNob3VsZCBoYXZl
IG1ldGFkYXRhLg0KDQp+QW5kcmV3DQo=
