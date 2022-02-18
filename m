Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 07DEA4BC161
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Feb 2022 21:50:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239545AbiBRUuO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Feb 2022 15:50:14 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:45846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233019AbiBRUuM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Feb 2022 15:50:12 -0500
Received: from esa2.hc3370-68.iphmx.com (esa2.hc3370-68.iphmx.com [216.71.145.153])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C77E57CDEE
        for <linux-kernel@vger.kernel.org>; Fri, 18 Feb 2022 12:49:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=citrix.com; s=securemail; t=1645217394;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=G5h3ImUe40jnCEP2OrfwbHuQeaSHG1+e2wyGWrtyIWM=;
  b=DUrg/54V7km/EJwaeGZiLBjsAtk9HUIPmVnYefJPRe3dB5g/DWTKtXfI
   J6kOo8MveVCmLQtpSbFxFEZE2xGVBjsSDSfklvLg+YosdDokaiKYydfTm
   fX4iu34K0fGLn4FdiuozUFeTgZZqmUvrQgaljhkfyyT0BJpFYiss6Fqns
   4=;
Authentication-Results: esa2.hc3370-68.iphmx.com; dkim=pass (signature verified) header.i=@citrix.onmicrosoft.com
X-SBRS: 5.1
X-MesageID: 64549521
X-Ironport-Server: esa2.hc3370-68.iphmx.com
X-Remote-IP: 162.221.156.83
X-Policy: $RELAYED
IronPort-Data: A9a23:7koFgq7cnbeD3/Y3r4In4AxRtGXAchMFZxGqfqrLsTDasY5as4F+v
 mYdUG/Ua6zeZTHxeN53bdy29R9UvMXSytFrSQVtqi1mHi5G8cbLO4+Ufxz6V8+wwmwvb67FA
 +E2MISowBUcFyeEzvuVGuG96yE6j8lkf5KkYAL+EnkZqTRMFWFx2XqPp8Zj2tQy2YLgU1vX0
 T/Pi5a31GGNimYc3l08s8pvmDs31BglkGpF1rCWTakjUG72zxH5PrpGTU2CByKQrr1vNvy7X
 47+IISRpQs1yfuP5uSNyd4XemVSKlLb0JPnZnB+A8BOiTAazsA+PzpS2FPxpi67hh3Q9+2dx
 umhurTtFT4Cb6/1t90DaClpKjB8O5VcoqXYdC3XXcy7lyUqclPpyvRqSko3IZcZ6qB8BmQmG
 f4wcW5XKErZ3qTvnez9GrIEascLdaEHOKs2vH16wC6fJvEhWZ3ZGI3B5MNC3Sd2jcdLdRrbT
 5RFNGY+MU6ZC/FJEnE4Op4njNewv1nAf2ZWhk+VpqMe23eGmWSd15CyaYGIK7RmX/59nUuVv
 WnB+GfRCREAM9me1D/D9Wij7sfJkS7gUZ8WEry17OVCj1qUyWgeThYRUDOTuvC8i1K5X8xWL
 UES0iUpqqc2+QqgSdyVdxS8sWWft1gZWt5aDvc8wACL1qfQpQ2eAwAsSzdba5o8qdMyTDom/
 laTmpXiAjkHmLmUT2+Ns7SZtzW/PQALImIYIywJVw0I55/kuo5bpgKfEP5gHbSzg9mzHiv/q
 xiSoTQznac7jMgFzay38FnLxTW2qfDhTAk84S3QQG+/4hl4eoO9Zp664B7Q6vMoBISBSViEt
 n8Js9KT4OAHEdeGkynlaOUPGPe14PGBKxXThFduG98q8DHFxpK4VdkOunckfh4va5taP2+yC
 KPOhe9PzMIPBVD7b5ZYWpyKO/UT3KrmLc6/TO+BO7KifaNNXAOA+ShvY2uZ0GbsjFUgnMkDB
 HuLTSq/JS1EUPo6lVJaU89YiOZ2nX5mmQs/ULiml0zP7FaIWJKCpV7p2nOqZ/tx0q6LqR69H
 z13Z5rTkEU3vAETj0DqHW8vwbIicSlT6XPe8ZU/mgu/zuxOQTBJ5xj5m+5JRmCdt/4J/tokB
 1nkMqOi9HLxhGfcNSKBYW15ZbXkUP5X9CxnYHV2YQ75hyZ6O+5DCZvzkbNuLNHLE8Q5kJZJo
 wQtIZ3cUpyjtByck9jiUXUNhNM7L0n67e5/FyGkfCI+b/Zdq//hobfZkv/U3HBWVEKf7JJmy
 5X5j1+zacdTFmxKUZeNANryngzZgJTosL8rN6c+CoIIIxuEHUkDA3GZs8Lb1OlWd02Yn2PCj
 1z+7NVxjbClnrLZOeLh3Mish4yoD/F/DgxdGWza5qyxLi7U4iyoxooobQpCVWm1uL/ckEl6W
 dho8g==
IronPort-HdrOrdr: A9a23:7yyNpqr3VQs7OQZKgak9DnoaV5uPL9V00zEX/kB9WHVpm5Oj+P
 xGzc526farslsssSkb6K290KnpewK4yXbsibNhc4tKLzOWxFdAS7sSrLcKogeQVBEWk9Qy6U
 4OSdkGNDSdNykYsS++2njDLz9C+qjGzEnLv5an854Fd2gDAMsAjzuRSDzraXGeLDM2X6bRf6
 Dsgvav0gDQH0j/Gf7LYUXtMdKzxeHjpdbDW1orFhQn4A6BgXeD87jhCSWV2R8YTndm3aoi2X
 KtqX272oyT99WAjjPM3W7a6Jpb3PH7zMFYOcCKgs8Jbh3xlweTYph7UbHqhkF2nAjv0idurD
 D/mWZmAy1B0QKWQohzm2q15+DU6kdr15Yl8y7BvZKsm72jeNtwMbs/uWsQSGqm16NnhqAg7E
 sD5RPoi3IcZymw7RjV9pzGUQpnmVGzpmdnmekPj2ZHWY9bc7NJq5cDlXklWqvoMRiKoLzPKt
 MeR/00JcwmBW+yfjTcpC1i0dasVnM8ElOPRVUDoNWc13xTkGpix0UVycQDljNYnahNB6Vs9q
 DBKOBlhbtORsgZYeZ0A/oAW9K+DijITQjXOGyfLFz7HOUMOm7LqZTw/LIpjdvaNaAg3d83gt
 DMQVlYvWk9dwbnDtCPxoRC9lTXTGC0TV3Wu4hjDlhCy8vBrZbQQF++oWEV4rydSq8kc77mst
 6ISedrP8M=
X-IronPort-AV: E=Sophos;i="5.88,379,1635220800"; 
   d="scan'208";a="64549521"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=F4fk0xxhoJxHGCmV9ytxBf+IJSYgpfeShoy1Wgi7IzgB+bHmVhoTMhAfzr1vQVGu0T7MMzITzMqdGnE6FkVDc+xl2Bus3JcEMgkOMDazBg0D2da6ztTXRpIjJHVgSstrBXRcob7hpT0/6/NbzgzVby2E8qd0W+1HZ/0h1BuefILIRnjzYhhB2qrbiXwZaRQvy9I+kmdnjO5ugo23h7J47PlHj+6RmBKMdnJCf7GH5Styy9g6n0bEzzPVmZIEjBpS7+HFFib93xZNywvdyiUqZBjvCqUX6MEd8g52cv5evIYW7QOzLELzQjCUlmGs9m5HqSp3KzU20QLYJI/QI77DEw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=G5h3ImUe40jnCEP2OrfwbHuQeaSHG1+e2wyGWrtyIWM=;
 b=ghi3DWQqEaDlQ8CVaRKOV2rcYKgmqo5gmKghQ04qsk8PeEXAmvb/w8m7pV8qcIVnSff7bsvxUTsl0sWXqw9Aadi4U6SBxAXzCB1C5gCs9zLaOw+TFssaL0/2vsg96qX8UzgKn0C8V9aTWUeB5HBk/Lx651efdE86rnEK1bYa4zsCHoORVjDDsfaMlZUUN/22d+o5+EFjDO/W6Ru+T3rhpCnIZytKITlUndDVBhM3HO/IhEZqnPmSh5snO5QCCZlvzHNUiM+gtiwBLQ6GMeuhLHmQObEzrCciQ2GMbFqFfKpaZTHac80xMS9POUVBWmNDjCvOpmBp6sK1WKDaJjjujQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=citrix.com; dmarc=pass action=none header.from=citrix.com;
 dkim=pass header.d=citrix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=citrix.onmicrosoft.com; s=selector2-citrix-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G5h3ImUe40jnCEP2OrfwbHuQeaSHG1+e2wyGWrtyIWM=;
 b=rax9Nb39FDgtEnSuu+1p/nMfYPKsmhbICpLJVnKMFhC4DaDTbXRuEogq41hrFu+FC1uwH1FIqcZoCq5745KzdnWiBLgf/FV3B8P1NsQW0GlUAFyoBtc6t+qkSLv6PCt4Sv4Cdl6iAUb4cyGe4CsuuOQUGiPbILo58SBtBeylFu8=
From:   Andrew Cooper <Andrew.Cooper3@citrix.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        "x86@kernel.org" <x86@kernel.org>,
        "joao@overdrivepizza.com" <joao@overdrivepizza.com>,
        "hjl.tools@gmail.com" <hjl.tools@gmail.com>,
        "jpoimboe@redhat.com" <jpoimboe@redhat.com>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "ndesaulniers@google.com" <ndesaulniers@google.com>,
        "keescook@chromium.org" <keescook@chromium.org>,
        "samitolvanen@google.com" <samitolvanen@google.com>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "alyssa.milburn@intel.com" <alyssa.milburn@intel.com>,
        Andrew Cooper <Andrew.Cooper3@citrix.com>
Subject: Re: [PATCH 05/29] x86: Base IBT bits
Thread-Topic: [PATCH 05/29] x86: Base IBT bits
Thread-Index: AQHYJOs4MY/fho88+Uaa/a9ERSiwKKyZyEiA
Date:   Fri, 18 Feb 2022 20:49:45 +0000
Message-ID: <96209eb7-f95c-41c5-12c1-da4dbbbf67f3@citrix.com>
References: <20220218164902.008644515@infradead.org>
 <20220218171408.867389898@infradead.org>
In-Reply-To: <20220218171408.867389898@infradead.org>
Accept-Language: en-GB, en-US
Content-Language: en-GB
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 0911c925-a7c7-4d11-be6a-08d9f3203270
x-ms-traffictypediagnostic: CO1PR03MB5874:EE_
x-microsoft-antispam-prvs: <CO1PR03MB5874CBCDD9D5B8BB99AAF1FEBA379@CO1PR03MB5874.namprd03.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: VQ+O/r9FgAFz5QGb4QKl5f4kcfao4i0a/fQmbpapgqhU6tRe2zVA90vLok76XKfpuqn8JRGVhQfqacJafF+o+oi6MNePnUtKyOpkulqpRilHBmIHzFRHgmQSgbK4QshFSZ39fpOLO9zYS2gDfmKJOcQ54EjRf6vEJs+d5HYrpUs9W6/mzKPvIX+ufJ8MiqDWaZg1I7UOGwZFAWDhcEbAC2mHjf93iglA5u2+mSmxNjXLFDH50KmiJk7SivdfJiDL4gCS5stp/N3hmUcBCfi1si+2+AD02LRbHIEHZ1nsbvVavoe9H1i+PQEKKQI49/OalAoRsBY+zy1w5mWvwNSuKFcY3MigqamQV4jMg5yZ5Hq8kDOw9UDr5M4gJSJ9ZYhQwaE47JMf7eP9ex2IWMcG+4JuJYZlRIQysq2wwL6woVN/5laZ7Y3w1O1dZLXm9fG3fZyuZoKt2xSf0rF/jYadsAuU4OsX0ny+HsDnGPv8RgJ3hCOo4p/TpBJxQzel39BrIHcBvJpIm+vLZ6sFm0WdvsmUV9+MFOClMnY/hUfcFcVEvSIPtUorrYvKDxfd3m/1POUXR9S6CXRnvMcmyInIXV2AMXNoEoNzZeRU75EAsF7VvCdmMjwZTrvLEIPUH/M53q4B1t+2A5kBeJfpGunzKSDhMPDAdGqw8lRJX4O+uuMkpqlnCVG5KzmdZV8pCqZkhbx2klt5AqFWC2fSAkwfDSifRIzjRbZpea54b2KmOsxxaXDoXGCut8Vq+AM2Rn+cC72+aNI4HWKRfYitrlvLmA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR03MB3623.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(38070700005)(186003)(71200400001)(26005)(6512007)(6506007)(107886003)(53546011)(2616005)(76116006)(2906002)(91956017)(66556008)(31696002)(66446008)(86362001)(66946007)(4326008)(64756008)(66476007)(8676002)(122000001)(316002)(82960400001)(110136005)(54906003)(5660300002)(508600001)(38100700002)(7416002)(8936002)(36756003)(31686004)(6486002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?R083SGJENWxqdjZzZXVyeFhDa0U3UTY5ZmYyS0IrN1R4TElnZUw5KzFVZkNC?=
 =?utf-8?B?SlI2UEVucnFwZDY2WTdQeVVPZWJjSGNSZjErdHJtZ1h4cmlTUW1vTTcvS1Uy?=
 =?utf-8?B?YTg1K01WT25ZTDFkR3dUTnBXY1ErTlN3NHhuRjRkQWFTSXpQRmRUYW1GZDdI?=
 =?utf-8?B?Q2NZZThCMnYrT3ZNbE9razc3cTVCYW5USVBoaU9Ma1NUZlNRRFJ1VEdYa083?=
 =?utf-8?B?aVBsWDZZbXl4NE5uS0d4TE93U3ZCdFh0djVlWmZhRjViOWdPWDBlT2dvNHk1?=
 =?utf-8?B?UXJkMUpZR2UyNzlUaHFzNWJaSkgxZWttVFJ6TnpFVHJyaXllMTRyUHRCUklw?=
 =?utf-8?B?M05yb01Uc2JEOS9VajlEWm9QZVNNazZhNmFYRjZLWkZiOWdEOEtFNWwyM2xa?=
 =?utf-8?B?WDJ3d2lBM1Q2bTFWdHErU1ZDWDVwalVmQkkzWkRQd0NGdjViQ2hRaTRRaTh4?=
 =?utf-8?B?QStuZjl0MnhjN05qZW5oS2NaNFVKTTFLOGtiNnpBTWY4enptSTFxUFZGQmtz?=
 =?utf-8?B?c3ZDVGgzb0hwUFhWNnBJOVpYbFQxRG9UUVczTzZHZEIweExCUTJZYklkNkEr?=
 =?utf-8?B?TU1PK1BtRjIwamtmbE9wcVF5WXpJcUk1QTR3TjM5d3czdEpsbVRvR004UmxP?=
 =?utf-8?B?T0M0c3c2SkFpU0ZQT3ZPd3phWjNTQ3dqdlNzUWt5cm82SWZBWTQ0NFVVMDVC?=
 =?utf-8?B?TDZiRzdwZG1XUkx2T2tEWEsxVWdWalJPNG9hVDhHWFZubmZFUEx2Mjh0N001?=
 =?utf-8?B?UVJRZWRxRE83V0duZW9pamk5YTVBN0NvVmhOVW5xVDVjUFJ6TzN6ajJLZTVw?=
 =?utf-8?B?UW9UR0o1YVdFRzRYTy9qOEExY09YMVRXMGduVGxGNzlFQk5Md3JaYnRZcGpk?=
 =?utf-8?B?cTQ4TS9aQnlZMWtJQjFMY2E3OGVBclI3ZXk4SFk1R2t4K2xXditWaDA0UG81?=
 =?utf-8?B?S1Fnb1pJV2xxQmpOZFlNeXVtdUphbGhWL0RTRU9STEJjMjRQbXZyTmRCSHMw?=
 =?utf-8?B?RkRMQjNGREJtcGNsR05QV0FCYzNiWHRiczI1NnhsZGkyS3ppeE55TjdydnZU?=
 =?utf-8?B?Z0g2ZjF1TmN5MGhqSnB1bVUwcnl1dGZ2RnM3ZmR0UDI4aTFaeWFQZ1JRTzdu?=
 =?utf-8?B?ZWkxVmw5Wks2UGFKbnRJNTlwNGVkV2hhMVZSVEk1N2dZRno4MThmenFBV0Nw?=
 =?utf-8?B?TjVKVjI2c1p4RzBQZytPRm1jejBxbUFXSDN3WU9NVmp3M3dGa3k4ZERxdFUr?=
 =?utf-8?B?MTUvVjVKa3E0OCtaT2lEazFGb29YWG5LOVZ3SkFRbTE1dUNHeUhUS0l0dEFS?=
 =?utf-8?B?djJuUk9lQ3JTYkFJVXJ1UGQ1QlNGYkJYNVd6b0ViVkZoNklTKzlJam1NQ1Vj?=
 =?utf-8?B?dDdoc2c5YllCeUdwZFJLQlJKREFHSGFDV2tGbC8wWnV0SUl6T2R5czVYa0RB?=
 =?utf-8?B?ODN0SnVDNFdTMFFlcktYRlp3Y0RDZXA5dmxFRzZGTlpnVE1FK1BKZ3Z1K2k3?=
 =?utf-8?B?TEZTY3RnYXhMWE9DemhMVEZYK3dUWlBtV3R6QlJaWEh2VlErbVpEV2tCVHhl?=
 =?utf-8?B?cmxZR0haNE5HeW9KZU9vdEZzekFJM3ROQjc0TmtWNTM4blZrdkFMUW5FQ1Jj?=
 =?utf-8?B?bmJLWHpPbWptczlsQ0lDb29jSWRycXVTK1doUVlyYkpNaS9Nc2xDZjVpQnJ2?=
 =?utf-8?B?S3RncFFSMnBvMTZsSHE2Y2VIWkZ0WFBicEVrd21SU3ZVbmQ1VUowcHNSQ0gv?=
 =?utf-8?B?SGxjdXBOWnNGSS82NHlsMFNWRzZQRnlYbldMU3RmQ29wQ0xyclFKQXhLenh6?=
 =?utf-8?B?bEttVk9XRDh4SlNTWDFkeFYwdTA5bmNwL3JIV29YN3I4TTNEeXVkV09WV0Jm?=
 =?utf-8?B?Y3hvVjkzREhwcVFJUzQrOS9vRklNVnpYZVFQUjJQM2VnaG10NmlTUzlsQ0tD?=
 =?utf-8?B?R1U4ZS84VXVGYnZsSkROaWYxdktFUW9vc1MvbzRDaEdBeHlQcTg4dWFNb1pr?=
 =?utf-8?B?Tnp2ZGExMmxaUUlxaUVGQlBuWmhCUkFqOFRCZEVaWlhVQWN3T0VlYUJJSmlu?=
 =?utf-8?B?VDlTbTBaVVkxQXlNazN5dkxsSDZwSXB2RER1bGdWWkJGazZEaUx5TWg4aXBy?=
 =?utf-8?B?Wm41ek5pN2pGcW5zSjd6aEpLMjZtUVMvVC9Od3Y5WWJXRXNwM1c3WS9lUFJQ?=
 =?utf-8?B?dUJQUyt0cUN2UUg2UndwU1NQaGIxL0ZweEM5dld2VDBVNE8raVRaekJDaDBK?=
 =?utf-8?B?MTNzQnVyMVIveFVBaUFWTkhCeWFBPT0=?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <A2AC8DC018FA504CBDA632F336C90763@namprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR03MB3623.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0911c925-a7c7-4d11-be6a-08d9f3203270
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Feb 2022 20:49:45.8982
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 335836de-42ef-43a2-b145-348c2ee9ca5b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: FMJi6sCuOaXsp09MRiMbYdkDhgXJglb1UlCo9Icko0tOGe9g/GDxqR1y77jeYw5a7yXqFim+WVOAoF/X9qmeZag7Z0+WUjmlxu16nSUPRK4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR03MB5874
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

T24gMTgvMDIvMjAyMiAxNjo0OSwgUGV0ZXIgWmlqbHN0cmEgd3JvdGU6DQo+ICsvKg0KPiArICog
QSBiaXQgY29udm9sdXRlZCwgYnV0IG1hdGNoZXMgYm90aCBlbmRicjMyIGFuZCBlbmRicjY0IHdp
dGhvdXQNCj4gKyAqIGhhdmluZyBlaXRoZXIgYXMgbGl0ZXJhbCBpbiB0aGUgdGV4dC4NCj4gKyAq
Lw0KPiArc3RhdGljIGlubGluZSBib29sIGlzX2VuZGJyKGNvbnN0IHZvaWQgKmFkZHIpDQo+ICt7
DQo+ICsJdW5zaWduZWQgaW50IHZhbCA9IH4qKHVuc2lnbmVkIGludCAqKWFkZHI7DQo+ICsJdmFs
IHw9IDB4MDEwMDAwMDBVOw0KPiArCXJldHVybiB2YWwgPT0gfjB4ZmExZTBmZjM7DQo+ICt9DQoN
CkF0IHRoaXMgcG9pbnQsIEkgZmVlbCBJJ3ZlIGVhcm5lZCBhbiAiSSB0b2xkIHlvdSBzbyIuIDop
DQoNCkNsYW5nIDEzIHNlZXMgc3RyYWlnaHQgdGhyb3VnaCB0aGUgdHJpY2tlcnkgYW5kIGdlbmVy
YXRlczoNCg0KaXNfZW5kYnI6wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgICMgQGlzX2VuZGJyDQrCoMKgwqDCoMKgwqDCoCBtb3ZswqDC
oMKgICQtMTY3NzcyMTcsICVlYXjCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgIyBpbW0g
PSAweEZFRkZGRkZGDQrCoMKgwqDCoMKgwqDCoCBhbmRswqDCoMKgICglcmRpKSwgJWVheA0KwqDC
oMKgwqDCoMKgwqAgY21wbMKgwqDCoCAkLTk4NjkzMTMzLCAlZWF4wqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgICMgaW1tID0gMHhGQTFFMEZGMw0KwqDCoMKgwqDCoMKgwqAgc2V0ZcKgwqDC
oCAlYWwNCsKgwqDCoMKgwqDCoMKgIHJldHENCg0KSGVyZSdzIG9uZSBJIHByZXBhcmVkIGVhcmxp
ZXI6DQoNCi8qDQrCoCogSW4gc29tZSBjYXNlcyB3ZSBuZWVkIHRvIGluc3BlY3QvaW5zZXJ0IGVu
ZGJyNjQgaW5zdHJ1Y3Rpb25zLg0KwqAqDQrCoCogVGhlIG5haXZlIHdheSwgbWVte2NtcCxjcHl9
KHB0ciwgIlx4ZjNceDBmXHgxZVx4ZmEiLCA0KSwgb3B0aW1pc2VzDQp1bnNhZmVseQ0KwqAqIGJ5
IHBsYWNpbmcgMHhmYTFlMGZmMyBpbiBhbiBpbW0zMiBvcGVyYW5kLCBhbmQgbWFya3MgYSBsZWdh
bCBpbmRpcmVjdA0KwqAqIGJyYW5jaCB0YXJnZXQgYXMgZmFyIGFzIHRoZSBDUFUgaXMgY29uY2Vy
bmVkLg0KwqAqDQrCoCogZ2VuX2VuZGJyNjQoKSBpcyB3cml0dGVuIGRlbGliZXJhdGVseSB0byBh
dm9pZCB0aGUgcHJvYmxlbWF0aWMNCm9wZXJhbmQsIGFuZA0KwqAqIG1hcmtlZCBfX2NvbnN0X18g
YXMgaXQgaXMgc2FmZSBmb3IgdGhlIG9wdGltaXNlciB0byBob2lzdC9tZXJnZS9ldGMuDQrCoCov
DQpzdGF0aWMgaW5saW5lIHVpbnQzMl90IF9fYXR0cmlidXRlX2NvbnN0X18gZ2VuX2VuZGJyNjQo
dm9pZCkNCnsNCsKgwqDCoCB1aW50MzJfdCByZXM7DQoNCsKgwqDCoCBhc20gKCAibW92ICR+MHhm
YTFlMGZmMywgJVtyZXNdXG5cdCINCsKgwqDCoMKgwqDCoMKgwqDCoCAibm90ICVbcmVzXVxuXHQi
DQrCoMKgwqDCoMKgwqDCoMKgwqAgOiBbcmVzXSAiPSZyIiAocmVzKSApOw0KDQrCoMKgwqAgcmV0
dXJuIHJlczsNCn0NCg0Kd2hpY2ggc2hvdWxkIGJlIHJvYnVzdCBhZ2FpbnN0IGV2ZW4gdGhlIG1v
c3QgZW50ZXJwcmlzaW5nIG9wdGltaXNlci4NCg0KfkFuZHJldw0KDQpQLlMuIENsYW5nIElBUyBo
YWQgYmV0dGVyIG5ldmVyIGdldCAiY2xldmVyIiBlbm91Z2ggdG8gb3B0aW1pc2Ugd2hhdCBpdA0K
ZmluZHMgaW4gYXNtIHN0YXRlbWVudHMuLi4NCg==
