Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AACA24BC1D0
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Feb 2022 22:24:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239726AbiBRVYj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Feb 2022 16:24:39 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:46500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239718AbiBRVYf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Feb 2022 16:24:35 -0500
Received: from esa4.hc3370-68.iphmx.com (esa4.hc3370-68.iphmx.com [216.71.155.144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0FCAD36B52
        for <linux-kernel@vger.kernel.org>; Fri, 18 Feb 2022 13:24:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=citrix.com; s=securemail; t=1645219458;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=H9QPwG7oM8Z7iAVzeqE6PsmduGgAQrCWRo8y9owvDzE=;
  b=NotQjGyUM/2p5IYrIKP5S+cVUjWqTNBKfl1ftNmFNzUX/hU6Pb+yQjA1
   IcyWutB79UIVTXhu0UzJBTkDN90f5lI1WWmtke9feOsvl+ch4xFselhow
   9Itkeddq7fOjSB2PSiL6NSnPM3eHMHBvKnrh6sSV60Mly1ri1VBls5Mdp
   U=;
Authentication-Results: esa4.hc3370-68.iphmx.com; dkim=pass (signature verified) header.i=@citrix.onmicrosoft.com
X-SBRS: 5.1
X-MesageID: 66797734
X-Ironport-Server: esa4.hc3370-68.iphmx.com
X-Remote-IP: 162.221.156.83
X-Policy: $RELAYED
IronPort-Data: A9a23:RE1C1qhIFV6wmSAEFMBwnObrX161FBcKZh0ujC45NGQN5FlHY01je
 htvXmyBOqrbZjSnc40ibYnlpB5VsJ/Qm9BgHANo+C43Ei8b9cadCdqndUqhZCn6wu8v7a5EA
 2fyTvGacajYm1eF/k/F3oDJ9CU6jefSLlbFILas1hpZHGeIcw98z0Iz8wIFqtQw24LhWVrd4
 YmaT/D3YzdJ5RYlagr41IrbwP9flKyaVOQw5wFWiVhj5TcyplFNZH4tDfjZw0jQG+G4KtWSV
 efbpIxVy0uCl/sb5nFJpZ6gGqECaua60QFjERO6UYD66vRJjnRaPqrWqJPwwKqY4tmEt4kZ9
 TlDiXC/YQtzGZPnsvwZahx/DipSYqoB8uGEfVHq5KR/z2WeG5ft6/BnDUVwNowE4OdnR2pJ8
 JT0KhhUMErF3bjvhuvmFK883azPL+GyVG8bklhmwSvUErANRpfbTr+RzdRZwC0xloZFGvO2i
 88xN2QwPUufOEEn1lE/Gbc6oN2Sm2jFeiQF8UqsrKQl6E3P01kkuFTqGIWMIYHbLSlPpW6bq
 2/d9GP+ATkRNMaYzDuY9zSrnOCntSX3VZkbCbm+9/Nwm3WcwWscDBBQXly+ydG9i0ijS5dcJ
 lYS9y4Gs6c/7gqoQ8P7Uhn+p2SL1jYVX8tLCOR87QCJwLfO5S6YAHQJSnhKb9lOnMo/Xz9sz
 EKVm9rvCRRmqrjTQnWYnp+PpDazJS8RM2YEaCksQgwC7N3u5oo0i3rnXoY9OK24lNv4HXf32
 T/ihDAzm7gJn+YK0auh9FzKij7qoYLGJiYZ7xvWUiSB5wJ2ZJKNboe17VHRq/1HKe6xTEGGv
 X0OnMW29u0CDZiR0ieKRY0lHLOtoeqCNznHqVFqFpglsT+q/haLf4dZ5xl5OkpzPtwFZzLxY
 V3BsEVa45o7AZexRfYpOcTrUZ1slPW+U4S+PhzJUjZQSpQrUzGs1jlqXEu3wmvBz09rm/98Z
 b7OJK5AEk0mIahgyTO3QcIU3rkq2j0yyAvveHzr8/i0+eHAPSDIEN/pJHPLN7lkt/3c/G055
 v4Cb5Pi9vlJbAHpjsA7G6Y3JEtCE3U0DIueRyd/Jr/aeVoO9I3M5pbsLVIdl25Nw/U9egTgp
 CjVtqpkJLzX3CyvxeKiMC0LVV8XdcwjxU/XxAR1VbpS51AtYJy08IAUfIYtcL8s+YRLlKAoE
 qBfJ53RXqoWEFwrHgjxi7Gk/eSOkzzx2Gqz09eNOmBjL/aMuSSSkjMbQucf3HZXVXfm3SfPi
 7ahyhnaUfI+q/dKV67rhAaU5wrp5xA1wbsqN2ORe4U7UBi8oeBCdn2q5tdqcp5kFPk27mbDv
 +pgKUxD/relTk5c2IShuJ1oWK/zTbMlRxICRzOzAHTfHXCyw1dPCLRoCY6gVTvcSHn16OOlY
 +BUxOv7K/oJgBBBtI8ULlqh5ftWCwfHz1OC8jlZIQ==
IronPort-HdrOrdr: A9a23:DmC4iK80EmwtSrsnNtxuk+F+db1zdoMgy1knxilNoENuHPBwxv
 rAoB1E73PJYW4qKQ0dcdDpAtjlfZtFnaQFoLX5To3SIzUO31HYbL2KjLGSjQEIfheeygcz79
 YZT0ETMqyTMbE+t7eG3ODaKadi/DDkytHSuQ629R4EJmsGC9AC0+46MHfgLqQffngaOXNTLu
 v62iMznUvYRZ1hVLXcOpBqZZmnm/T70LbdJTIWDR8u7weDyRmy7qThLhSe1hACFxtS3LYL6w
 H+4k7Ez5Tml8v+5g7X1mfV4ZgTssDm0MF/CMuFjdVQAinwizyveJ9qV9S5zXUISaCUmRIXee
 v30lEd1vdImirsl6aO0EPQMjzboXETArnZuASlaDXY0JbErXkBerR8bMpiA2rkAgwbzY1BOe
 twrhGkX9A8N2KxoA3to9fPTB1kjUyyvD4rlvMSlWVWVc8EZKZWtpF3xjIZLH4sJlOw1GkcKp
 glMCgc3ocgTXqKK3TC+mV/yt2lWXo+Wh+AX0gZo8SQlzxbhmpwwUcUzNEW2i5ozuNzd7BUo+
 Dfdqh4nrBHScEbKap7GecaWMOyTmjAWwjFPm6eKUnuUKsHJ3XOoZjq56hd3pDnRLUYiJ8p3J
 jRWlJRsmA/P0roFM2VxZVOtgvARW2sNA6dgv22J6IJ84EUaICbRBFreWpe5fdI+c9vcPEzc8
 zDTK5rPw==
X-IronPort-AV: E=Sophos;i="5.88,379,1635220800"; 
   d="scan'208";a="66797734"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Q7yftpINzagxXvFNf8wOxaZsyooLuSyJS567da2Da1NfWufoOWMRy1GIJkRpIEOHr4e1htVujTnrV051K4pAChogOY3VYis23sG1IMLxBVl1x++R8SW4POPncCbTR+jFAdUrsWTrlKt1drMiGY0ZP9jOtumlfuIXcFiDHsVkZ3LrSyu0diQdnD79W1kNatHkZ6kZQDKCZj4oPy04/OEiP/8awE/dUWlEbXCNn3vwduq4sYey4alupZFuCTq9tRfvjDXXmEzpSm2gKNLLjJKZQVEYuCMBNd75EpKvE7Ij8zoQKyUzW4WUCLOOVnZPkjEC0jNvBIKfRl9tcGy3L0wccg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=H9QPwG7oM8Z7iAVzeqE6PsmduGgAQrCWRo8y9owvDzE=;
 b=lt8QERkXF0YIifM/zMn/k1ODOju78tc7mevCQ3877pshQJq5xtYs7kO1NhMZbUvjiNKaI11+C4Ygc3Y0tyjkQ+BGQ1IJV47cR6oDy5/4nOzHKXfUZl+KQF/jVqyeiest5vlDEmCRbT0kRrg62CX7qveUYMO9sP9orxJ03aRnRSkIpIe933KcCtP5Q6PsaNNWyU3MgFk1W9TcaEhHBsvhuD20Yqw/q+eqtNf/EmogAHa424BHaQcV+Gm6m/nrMMClnSq0ZgnllmgosTy11BaLpcPboN0hzWTvl/MsuoGIat0ZFKfL1qF1EpJfwwym27y3B0fcHrfDdY9SI6AWuzLuxA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=citrix.com; dmarc=pass action=none header.from=citrix.com;
 dkim=pass header.d=citrix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=citrix.onmicrosoft.com; s=selector2-citrix-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=H9QPwG7oM8Z7iAVzeqE6PsmduGgAQrCWRo8y9owvDzE=;
 b=lTB037N/SWl77WtO0dOXRMuZIxtrOTNyW+ZxaYddtUgj+KitMdPG5qqeDWTttMgUM+KdXbKhOmzEqWTW62kPec7VkriJ84VeE3hpqaZwwWLE3vQ44DRefid1SO4dYsoQfu2jmrKi22shVUMK4WMW6Yk0zFaGpP8Ucbj/RkGfgy4=
From:   Andrew Cooper <Andrew.Cooper3@citrix.com>
To:     David Laight <David.Laight@ACULAB.COM>,
        Peter Zijlstra <peterz@infradead.org>,
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
Thread-Index: AQHYJOs4MY/fho88+Uaa/a9ERSiwKKyZyEiAgAAEwLCAAATdAA==
Date:   Fri, 18 Feb 2022 21:24:10 +0000
Message-ID: <c7fa2998-0532-b46c-7bfb-ed41620f10b8@citrix.com>
References: <20220218164902.008644515@infradead.org>
 <20220218171408.867389898@infradead.org>
 <96209eb7-f95c-41c5-12c1-da4dbbbf67f3@citrix.com>
 <bf7f2867a77e4ebe8c44fd0577a3ac55@AcuMS.aculab.com>
In-Reply-To: <bf7f2867a77e4ebe8c44fd0577a3ac55@AcuMS.aculab.com>
Accept-Language: en-GB, en-US
Content-Language: en-GB
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 72b26503-1d09-46f6-3c37-08d9f3250145
x-ms-traffictypediagnostic: MN2PR03MB4976:EE_
x-microsoft-antispam-prvs: <MN2PR03MB497692E0D85F971DB370EC78BA379@MN2PR03MB4976.namprd03.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7691;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 4s/uRmAz2GYQFZY8ob683w3gvdLHLMYgsbKlqjnp+gJSJ6aGhPmVzm8ppYY8ejm8v8YlfrhQoyVezdo45qfO8Rq5U4aNLq4sDSckwtj+CD694lG4ikLLtNn77gZCiqgI8U+iYyjHd4kv6Bv+unCHxPnZdRyLnFdt4IPoVuCgQ/MrGsNac9ZeGijCUO2TK5atmU7JGqbina4NyyK4IPEnp4OIzqPb6U4UUW2hPHn1Vkp1BnDwN44tMHaO1Dl7udB5KacOwQfz0xJ50lGwwdjsO+GCuB20oHTUeJ0gboMa/Yp7JLbtX5izjaZWspnsNTe/FL1id4ftHTJcKI8jUoxBieCLQaFxkyXFcaAUF4OqZ+QvtrP0RCYSgw9AXFJpyNy5/A5eDK9Z2+SMOmIpq/o1f3K68KdBJ1fnkrMY82jRVYu/0LNGFWkjjUI8bniiW//dSHUiHnPmYsQApImpLu+QZ2xaAtivUV5yZjW9/2Yb8Lzf0vNmSyKF8d7ugwi0jjY1jlog0SOolSn0SeepDqlw2RoT3+/qO4rKWmr8h5q6q4V81IU4VV4Qb0ZCU3K7sXEQrlIAl/VrKutpD+QxeRX0l/CMV7gbrf+u9ubjRndAHboFBelcsMq5uXhQcRIrk0FH505jx02SsCwRc+Ft2+JeVMU0y/7oVxoyJOu5sUip3sIP3pkXGVpnRIKdzr9BwFV1aiK5xlAQFd5E2GSKaPLNF+LOt9Pw2w6S7+kJdw03sn6VLsY4E/db73WR5/+3ajEVRSG4kRJNIeoKQWFO02S3kQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR03MB3623.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(71200400001)(31696002)(122000001)(2616005)(508600001)(6486002)(91956017)(2906002)(8676002)(4326008)(76116006)(66556008)(66946007)(66476007)(66446008)(64756008)(6506007)(110136005)(54906003)(82960400001)(4744005)(38100700002)(186003)(26005)(53546011)(31686004)(5660300002)(7416002)(107886003)(8936002)(86362001)(6512007)(38070700005)(316002)(36756003)(45980500001)(43740500002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?VC9BaWZIMnZvaTB5dm84N2kyQ2FCRzBXZU5LY29pMko0azBueTYyMHRFWHFN?=
 =?utf-8?B?YVBFelBCRVlJSUYzbGVpMTdES1Q1ZHdiQWhvTTBrWjUxNG1GWVZ2bjVkUjlB?=
 =?utf-8?B?dDJVdWE3T0ZZdWMxWFN4czI4ZzdUMC9zZkZQdlBBdGovUG51WWE4YnZRTy9Q?=
 =?utf-8?B?bVZxRmVaVklOd1FHeXo1LzN5MTNCWENCMlh5b1BSeW1hdXNaMTJpU3FyME1D?=
 =?utf-8?B?Y2U3djlRNFd4YlhRSTBnSUVVVTRFZWxvRWdycE9icDkzUXh6N1NJUUtCTGZr?=
 =?utf-8?B?bloyb1FGdHNZY1N6UVdkOHRncTF2UWF3cjR5eSt4L3diMldnWHIvb3BvREdQ?=
 =?utf-8?B?amYzeTFzbkx3T0hlMER3NHNycmhiY3BUSy9vME5TSElCbk83WCtsOXJQU01R?=
 =?utf-8?B?RUhTUEZRRCtzYjBvL1ZaMzNpSHdFSFd1MTBBdjdHMUdoeGFMK09VdlFqRWtv?=
 =?utf-8?B?OHd0eTJwK01HOVkxK2FmdVQvMUdPdWw2bUM1ajYwNEQ3WHlSTm9UVDBEZW41?=
 =?utf-8?B?dzIweGdPUnJzQUcva2RxT3hmdzRaZVNOZ2NKeXNKTFA0ZStRbmhmL0FzQ3Nh?=
 =?utf-8?B?VVExRHRseXdHbUUyUWtWbkFkMnlVSE1Wa1BTQlMxemFnV1N4YkxWZG5kZFJV?=
 =?utf-8?B?R2JRK1Y1V3ZYOXpDbmpSeEIxYlFLVGxmVWIxUm1xL29xZUFBWlpsWXBncVNQ?=
 =?utf-8?B?OUdHUURVRlNpMVR2SG92M0N2d1JVYk9BYWR1bTkzdDdoQzNhdGZrSVcvUXgw?=
 =?utf-8?B?aEhuaEk5ZWlRdkVtazA3RU9LZjEvWUhUSW00Nzd5L1U5Rm55eWlBem4vYU93?=
 =?utf-8?B?UlZVbHBQQzNBaGtaQSs4NDRpdngydm55YXlLNVVWNUdPNGFIWHRRWXZrYk9D?=
 =?utf-8?B?dkF5MVFSVDBkaDZZbWt0UFJ1ZGx6Z05QK3kySitPY1VxUHNUclFvaS9ZUW1w?=
 =?utf-8?B?NE5tNGduU3Urc0xIamRvNytDcndkZTRKdWZ3MGVWNUNGQWYxK25Gd1F2OG5E?=
 =?utf-8?B?WjFIbTNDSTZyTDkzbEc4NndrQVYxYy9TM2lyL2hjUFAvR0xUL1FDdFB5NFVL?=
 =?utf-8?B?K3ZMVWlZbEpOSGdrcVBHRlRsSmQrbkJ3Vm9EclhIeDVCVFdCdGpFOHBwWkxT?=
 =?utf-8?B?RUJ6VG5acnlNbHhsbU9NbG1WU0h0U1c5UlgrKzl4ZGpKZE5zTC8zTk9qT3Vj?=
 =?utf-8?B?dVFNYW1rVkQrdXZTNXp6WllHU2lzbDFhVEVsWmNQVFdPS0k3WXJmdVhBZExB?=
 =?utf-8?B?eGdBS1dPbFY2N0tZVDR6ejBwOWxPRlZidzdMWDRFekdqeEhrTm9YRE51T1JI?=
 =?utf-8?B?RGVPdklGbWZudThMaXNMUmVSaWQzMytqOXUzS0JURjBnRVFhTVovWmFac1d6?=
 =?utf-8?B?RlNoR3BYTXNmYzJUK25aT0lNSmZkUGJENHYrcXZTenFPSm4zcWExdHM0SmhU?=
 =?utf-8?B?ZXBmcEVyckFoTEUyMDViRVFBVEprNjk3U2g1QU1PVURpemZVWWswK1ZWLzY2?=
 =?utf-8?B?WHJ6Qm1pcXV0T2k1c2VGVU5PRU9waEFBcy9OKzZGUzZXQ1VUZmIydTJtUE5Z?=
 =?utf-8?B?YVRjTHdoNzBGWEZhdks4YkJ2cUFkSTZxTzNlbnNiaytpdUl0bXNLOHpydnBU?=
 =?utf-8?B?UnBKYTRrbnBJVzJoL25qaVNjUi9NUEJzVVFXVWVVQzJKZmZwc05Bb29DQ3M5?=
 =?utf-8?B?QXltVkJCU0V3MW9Ld3hHOFdqSlFyWlFXUVpNTVZVZk9NUVB0NFF2enFHKzVu?=
 =?utf-8?B?cTJtY01DVCtydktTYSs4N1MvQ1doTU8vRURIUmtrRmN0QWRIdHhaM0dsQ1Yx?=
 =?utf-8?B?d0pvUXpQc1pQZGJnVWt0S1R4WlpFaHRBSmRvM3FzdmpjcmNvQU5abHhCaFJ3?=
 =?utf-8?B?RlU1d0w3cUZBWHVzaUVUNWlZaG9tUFh4Umo1QkdhU1FqNE05YXU0c3VGbTZw?=
 =?utf-8?B?L2lhb0swdktqbTVlNlQvYUFaR3RBUmF5dEd6bHVTTEtrNlI2U2gxL1BTb0Vy?=
 =?utf-8?B?ek9UN3EzVi9KalBURXQyZFh0WkMwRVFlVjRtMm9RYUlQWU9aai9RTWJEVFgx?=
 =?utf-8?B?WjNzQWhwTG5WM1cvRUhTRDFVUFNTdmo0YlJKcW0xVmMvTjZUODNnSEwyR0VH?=
 =?utf-8?B?QmtKWDIyb043d0RBL2hsd2dqRklaQTZQNnVtWm5OejBJRFRVeUFZeHV4dVg3?=
 =?utf-8?B?b293RExGQzh5SzBQK0g2RXJCNzlOdGF2Q2RYRUJ6U1B6Y0FDRWsvaHlqMjV0?=
 =?utf-8?B?Z0d6R210UUVsLy9qR0taancxTG1RPT0=?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <B2A7EF095937284A85B620E63C191E67@namprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR03MB3623.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 72b26503-1d09-46f6-3c37-08d9f3250145
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Feb 2022 21:24:10.9196
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 335836de-42ef-43a2-b145-348c2ee9ca5b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: fb5Zy8oVJ4aNZrAGtf8CbFJpojZdxIXOhMmU3YgzMd5dV4mLgIUxNpwbjd5cRR/ZvObezDZdddGi1zYlm7oV2MrRWkiWuRporunjRFA2GXM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR03MB4976
X-OriginatorOrg: citrix.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gMTgvMDIvMjAyMiAyMToxMSwgRGF2aWQgTGFpZ2h0IHdyb3RlOg0KPiBGcm9tOiBBbmRyZXcg
Q29vcGVyDQo+PiBTZW50OiAxOCBGZWJydWFyeSAyMDIyIDIwOjUwDQo+Pg0KPj4gT24gMTgvMDIv
MjAyMiAxNjo0OSwgUGV0ZXIgWmlqbHN0cmEgd3JvdGU6DQo+Pj4gKy8qDQo+Pj4gKyAqIEEgYml0
IGNvbnZvbHV0ZWQsIGJ1dCBtYXRjaGVzIGJvdGggZW5kYnIzMiBhbmQgZW5kYnI2NCB3aXRob3V0
DQo+Pj4gKyAqIGhhdmluZyBlaXRoZXIgYXMgbGl0ZXJhbCBpbiB0aGUgdGV4dC4NCj4+PiArICov
DQo+Pj4gK3N0YXRpYyBpbmxpbmUgYm9vbCBpc19lbmRicihjb25zdCB2b2lkICphZGRyKQ0KPj4+
ICt7DQo+Pj4gKwl1bnNpZ25lZCBpbnQgdmFsID0gfioodW5zaWduZWQgaW50ICopYWRkcjsNCj4+
PiArCXZhbCB8PSAweDAxMDAwMDAwVTsNCj4+PiArCXJldHVybiB2YWwgPT0gfjB4ZmExZTBmZjM7
DQo+Pj4gK30NCj4+IEF0IHRoaXMgcG9pbnQsIEkgZmVlbCBJJ3ZlIGVhcm5lZCBhbiAiSSB0b2xk
IHlvdSBzbyIuIDopDQo+Pg0KPj4gQ2xhbmcgMTMgc2VlcyBzdHJhaWdodCB0aHJvdWdoIHRoZSB0
cmlja2VyeSBhbmQgZ2VuZXJhdGVzOg0KPj4NCj4+IGlzX2VuZGJyOsKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCAjIEBpc19lbmRicg0K
Pj4gwqDCoMKgwqDCoMKgwqAgbW92bMKgwqDCoCAkLTE2Nzc3MjE3LCAlZWF4wqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgICMgaW1tID0gMHhGRUZGRkZGRg0KPj4gwqDCoMKgwqDCoMKgwqAg
YW5kbMKgwqDCoCAoJXJkaSksICVlYXgNCj4+IMKgwqDCoMKgwqDCoMKgIGNtcGzCoMKgwqAgJC05
ODY5MzEzMywgJWVheMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCAjIGltbSA9IDB4RkEx
RTBGRjMNCj4+IMKgwqDCoMKgwqDCoMKgIHNldGXCoMKgwqAgJWFsDQo+PiDCoMKgwqDCoMKgwqDC
oCByZXRxDQo+IEkgdGhpbmsgaXQgaXMgZW5vdWdoIHRvIGFkZDoNCj4gCWFzbSgiIiwgIj1yIiAo
dmFsKSk7DQo+IHNvbWV3aGVyZSBpbiB0aGUgbWlkZGxlLg0KDQooRmlyc3QsIHlvdSBtZWFuICIr
ciIgbm90ICI9ciIpLCBidXQgbm8gLSB0aGUgcHJvYmxlbSBpc24ndCB2YWwuwqAgSXQncw0KYH4w
eGZhMWUwZmYzYCB3aGljaCB0aGUgY29tcGlsZXIgaXMgZnJlZSB0byB0cmFuc2Zvcm0gaW4gc2V2
ZXJhbCB1bnNhZmUgd2F5Lg0KDQp+QW5kcmV3DQo=
