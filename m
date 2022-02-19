Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 530EE4BC940
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Feb 2022 17:01:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242579AbiBSQB0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 19 Feb 2022 11:01:26 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:36852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232663AbiBSQBY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 19 Feb 2022 11:01:24 -0500
Received: from esa1.hc3370-68.iphmx.com (esa1.hc3370-68.iphmx.com [216.71.145.142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96F39127571
        for <linux-kernel@vger.kernel.org>; Sat, 19 Feb 2022 08:01:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=citrix.com; s=securemail; t=1645286464;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=PJdfxfetqB5kClEE2VKBlz7xrpQTkbQw5ZJIVzr+S70=;
  b=fivpeDjeKDH0HF90ffEHO66xAQFgZ+yAzvugM0DQBy03hjDv5X2IXVy4
   0J0KT0ZZojEXbV0aYnbowHUpgXgLnGsXZOPY0xVXPoiqmsXLU1P6oY8DO
   jpgoOUsDxGoZ8F+lm+q6VJf4Z6Z+GPeV/6vtOqrveTaCMDDjMqpVlSraT
   8=;
Authentication-Results: esa1.hc3370-68.iphmx.com; dkim=pass (signature verified) header.i=@citrix.onmicrosoft.com
X-SBRS: 5.1
X-MesageID: 64983813
X-Ironport-Server: esa1.hc3370-68.iphmx.com
X-Remote-IP: 162.221.156.83
X-Policy: $RELAYED
IronPort-Data: A9a23:fafMjq+Rravokh6CiJXODrUD8XmTJUtcMsCJ2f8bNWPcYEJGY0x3z
 mIZDGnQPayDZjb3e94jatyz/R4Ov5aEn9U3GQBt/Cw8E34SpcT7XtnIdU2Y0wF+jyHgoOCLy
 +1EN7Es+ehtFie0Si+Fa+Sn9T8mvU2xbuKU5NTsY0idfic5Dndx4f5fs7Rh2NQw24HoW1rlV
 e7a+KUzBnf0g1aYDUpMg06zgEsHUCPa4W5wUvQWPJinjXeG/5UnJMt3yZKZdhMUdrJ8DO+iL
 9sv+Znilo/vE7XBPfv++lrzWhVirrc/pmFigFIOM0SpqkAqSiDfTs/XnRfTAKtao2zhojx/9
 DlCnaKWaAVqM6Tio9k+fSIIHCFzbJ9I6LCSdBBTseTLp6HHW37lwvEoB0AqJ4wIvO1wBAmi9
 9RBdmpLNErawbvrnvTrEYGAhex6RCXvFKoZtmtt0nfyCvE+TIqYa67L+cVZzHE7gcUm8fP2O
 ZZIOWE/NU+ojxtnHU1OUsoZzb+S1kLedC9Ct328roQK7D2GpOB2+Oe0a4eEEjCQfu1Ql1yb4
 Hjb42DwBB0yPcaajzGC9xqEgu7JgDO+W48IErC83uBljUfVxWEJDhASE1yhrpGRiUOzQNlYL
 E888So0qq0z6UntScPyNzWxpG+fpRdaXttUGfAg7imMzLbZ50CSAW1sZjhNZccvqcswRDEwz
 XeGmNTmATEpu7qQIVqG/7KVsTS2JyETIGkqaigDQg8IpdLkpekbjArIT9NpF6OdlND5GTjsh
 TuNqUAWnbQYjogTkai38l3MhDemq7DISBI44kPcWWfNxht0eIO/daSp71bB5PpNJYrfSUOO1
 FAGnMGZxOcQAIuBji2TTf0MDqOgof2CNVX0kQ4xN5os7TKg/zikZ484yDF8IAF1NcEAYhfmZ
 UbSvUVa45o7AZexRfYpOcTrUZ1slPW+U4S+PhzJUjZQSqZXVQ3E8ShAXnOz8Vu9n0ghwJMxK
 ZjOJK5AEk0mIahgyTO3QcIU3rkq2j0yyAvveHzr8/i0+eHAPSDIEN/pJHPLN7lkt/3c/G055
 v4Cb5Pi9vlJbAHpjsA7G6Y3JEtCE3U0DIueRyd/Jr/aeVoO9I3M5pbsLVIdl25Nwvw9egTgp
 CjVtqpkJLzX3yGvxeKiMC0LVV8XdcwjxU/XxAR1VbpS51AtYJy08IAUfIYtcL8s+YRLlKAoE
 qNcI57eWKkWG1wrHgjxi7Gn8OSOkzzx2Gqz09eNOmBjL/aMuSSSkjMbQucf3HZXVXfm3SfPi
 7ahyhnaUfI+q/dKV67rhAaU5wrp5xA1wbsqN2ORe4U7UBi8oeBCdn2q5tdqcp5kFPk27mbDv
 +pgKUxD/relTk5c2IShuJ1oWK/zTbMlRxICRzOzAHTfHXCyw1dPCLRoCY6gVTvcSHn16OOlY
 +BUxOv7K/oJgBBBtI8ULlqh5fhWCwfHz1OC8jlZIQ==
IronPort-HdrOrdr: A9a23:N4+djqNYmbQMBsBcT2/155DYdb4zR+YMi2TDiHofdfUFSKClfp
 6V8cjzjSWE9Qr4WBkb6LW90DHpewKSyXcH2/hsAV7EZniphILIFvAv0WKG+VPd8kLFh5dgPM
 tbAstD4ZjLfCJHZKXBkUiF+rQbsaG6GcmT7I+0pRYMcegpUdAa0+4QMHfBLqQcfngjOXNNLu
 v72iMxnUvGRZ14VLXYOlA1G8z44/HbnpPvZhALQzQ97hOVsD+u4LnmVzCFwxY3SVp0sPcf2F
 mAtza8yrSosvm9xBOZ/XTU9Y5qlNzozcYGLNCQi/ISNi7nhm+TFcdcsvy5zXIISdOUmRIXee
 r30lAd1gNImjXsl1SO0F7QMs/boW8TAjHZuAelaDDY0LPErXoBerR8bMRiA0HkAgMbzaFBOO
 gg5RPpi7NHSRzHhyjz/N7OSlVjkVe1u2MrlaoJg2VYSpZ2Us4bkWUzxjIdLH47JlOz1GnnKp
 gbMOjMoPJNNV+KZXHQuWdihNSqQ3QoBx+DBkwPoNac3TRalG1wixJw/r1Tol4QsJYmD5VU7e
 XNNapl0LlIU88NdKp4QOMMW9G+BGDBSQ/FdGiSPVPkHqcaPG+lke+83JwloOWxPJAYxpo7n5
 rMFFteqG4pYkrrTdaD2ZVamyq9NllVnQ6dvf22y6IJyIEUHoCbQhFrYGpe5vednw==
X-IronPort-AV: E=Sophos;i="5.88,381,1635220800"; 
   d="scan'208";a="64983813"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OFjL91kx3ggRqY+iTwnPfo5E6Mzbf6qvDw+FsmORlsZjsDOlV6dRL0CcKvE/lp1H0OPWsZQ+3lDnUJdLy7A0ATSwr9NjxAmwAfV1n75QV7etS0+C1+UJiKmBlBtC7zMxEbS/N5SGntaBugzBjFI/MGVmGcwOlx5TAIHrtZ/Hwrs/RzmwqV5p13tpbOw2n8PiUB7bzolqZ3uA0GqoG6LxHgXUTGRVKg7+MKnZlYYtkgbk1E7xiPO1z5XZLE92Co/flXyIwQrtGn/bQ1rIoOLZKz8ZJKRvPkAXSencn63WMUiByR+nxq/kEL/MwXPDSGJmAlu8C4kBYQX9gcW7JJMLvw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PJdfxfetqB5kClEE2VKBlz7xrpQTkbQw5ZJIVzr+S70=;
 b=CXYoztKbvzaxtxG97iyw8nlWsD5j+GzO9yn9CWx4263WDLkPQvzbibNpQgL+w1QHWhAMsn3kxx7yEATad/rzrqOUSbRc8M8WIoZn/a6lF2192RywVmnvTa4BM37mNZWdp9xTYVs5/tk837mjI7eAeP0JIaWfqwnf2jHNq7H5wP3rnXdeTbmkR0zQ5taPY6jDccgt5uHOlhW0UOugnGqwAUCMsYH4AgwffAq//Y/pi3KgBpAcupz61u+4ptnW19wif0BjDjIgdjVM9Z55aciQGd5NW0HqPUuf7zyfte1mB49LxN7l/Dmt9+wOXzK7lmmDj51ZALaFWxfDTCAyoT8Oxg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=citrix.com; dmarc=pass action=none header.from=citrix.com;
 dkim=pass header.d=citrix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=citrix.onmicrosoft.com; s=selector2-citrix-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PJdfxfetqB5kClEE2VKBlz7xrpQTkbQw5ZJIVzr+S70=;
 b=U74Fi3+jnm0+22hPCUzLkIQ2W/JWWNhzog/ItEHIMeBGxaGZMuIcCjVGIqIS8b9V+YgVBizx9g/yERN3I2AEQNLyIqlcEsWlQLHSG9yqvGec18zrXu2gSn3ltdp5YnCxqSBwFrUwlgw97fifQc0Muc8MfbCUyFy/d0np41TTvKA=
From:   Andrew Cooper <Andrew.Cooper3@citrix.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
CC:     "Poimboe, Josh" <jpoimboe@redhat.com>,
        "hjl.tools@gmail.com" <hjl.tools@gmail.com>,
        "x86@kernel.org" <x86@kernel.org>,
        "joao@overdrivepizza.com" <joao@overdrivepizza.com>,
        "keescook@chromium.org" <keescook@chromium.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "samitolvanen@google.com" <samitolvanen@google.com>,
        "ndesaulniers@google.com" <ndesaulniers@google.com>,
        "Milburn, Alyssa" <alyssa.milburn@intel.com>,
        Andrew Cooper <Andrew.Cooper3@citrix.com>
Subject: Re: [PATCH 00/29] x86: Kernel IBT
Thread-Topic: [PATCH 00/29] x86: Kernel IBT
Thread-Index: AQHYJOs5Da85u7qAy0mh4Eo9JbTuZqyaFoOAgACOIYCAAGVJAA==
Date:   Sat, 19 Feb 2022 16:00:59 +0000
Message-ID: <895e6eb9-39d9-78b3-51c5-95f4eee0cb7a@citrix.com>
References: <20220218164902.008644515@infradead.org>
 <7a241b81ccd21da02bc27379b0a837c09fe4f135.camel@intel.com>
 <20220219095827.GI23216@worktop.programming.kicks-ass.net>
In-Reply-To: <20220219095827.GI23216@worktop.programming.kicks-ass.net>
Accept-Language: en-GB, en-US
Content-Language: en-GB
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 8e9a3644-69b4-4e65-839f-08d9f3c10589
x-ms-traffictypediagnostic: DM6PR03MB3627:EE_
x-microsoft-antispam-prvs: <DM6PR03MB3627B6E3C9B07E8957887232BA389@DM6PR03MB3627.namprd03.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: mkJIhI1GnETQ71gBubPsP0abQzEyA82vKpaQiglo/+5RofYZVJ8D59VR24h1kd8RPIg7tlZKHlrfd0xMsUfZpgWorkXEKHm+CXZ0iNaPaYpkdMHYsdjm83eQksQonpHJLvt/JnMrZ/vH3H/YLT8f5ml0EHAutqkf0sX516s+LKCybu/vGSflDROjshxKS25drAv5hiGM+pJPBy6VgZn04ZEbhNuYZvIVZ/k2POyMi0otnfABBkJnJWEybTlRi3F11K9x7VyZJrL+WRLN/WTIpOtiZ3xejdkIXwEPHwVmmKBrSBCq02lmolAErUc3guREAOQA8KCD1m/Vq+RlwrgXrdr419GxGUM5jNv9tYJfCwsOiCra0SGvvK94y5ufD80h4w21e8eAUUIodFfr0Oeu2kvNcQrct/3IIMCYIBomw92VtNPXEy5n8dZy2AcWiLSW/7ui/zxD9/XlRlYuTg/NWcBbe5EYUzSORw5Notb3UNDcEQhgEzJhhRvLIw96r20zcQCTpbS0m8L8J/EWGFBD0HMKegUYqb8q+2jMyyilNeasFLE6DlKleYKB/FIRxTLMCZUegPzq6vl/QeSBeWLTe9ApYVamtJKz56G9iEH9Jhud8jnQFXisGwpKa3n1SSweyvvtluCapdaCIFBoOF6QJdgc+TY69nVK5mqj6sf/smd/lMH+jrWz2HPDDOOwUlaCqwFGh6ZuPMHDFarKrkF+D3l96NO46DsrLKQHrLCkDu0ovlRwwYgdJq4dfah0o4IMwJCf0Ofqx8ChSk49sddAhw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR03MB3623.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(38070700005)(508600001)(107886003)(6486002)(86362001)(53546011)(110136005)(31696002)(6506007)(186003)(6512007)(316002)(54906003)(2616005)(71200400001)(26005)(7416002)(4744005)(8936002)(2906002)(82960400001)(31686004)(38100700002)(5660300002)(91956017)(64756008)(66446008)(66476007)(66556008)(66946007)(76116006)(36756003)(122000001)(8676002)(4326008)(45980500001)(43740500002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?ZmhUUlM2T21qTjExRFdrbTdSTUdwWUxZWW1jdEFCek5aZHpzeWJ1VHNCbVR2?=
 =?utf-8?B?M0FTcjV1M2ZWVUY4dEc1VkErYUZIamFuczhXR3BpenZ1UGc1ZFZDTDVSTW5X?=
 =?utf-8?B?bHhDcVdlNDMvdzN4SUkyb3VoYTYyTm4yTVl6TktxOUc2dFh1MklWOUtQV0c1?=
 =?utf-8?B?S1pEZDd0Z0xRWkl3LzlmMkIwWHVUbmJjOGxVaFRNeWlJZllZcStjK1BpZHJw?=
 =?utf-8?B?ODZweTc2OGtiQVZKZHNsaVB5Yzl4bzFUK24rWTFlRGJjM252V0owVHN2L2pV?=
 =?utf-8?B?TDV4cDFiRGMxbE5jUEtFWTVFWjhPaDFDOXJyNzBBaHp4ZW9jSXVZTXI1djk5?=
 =?utf-8?B?U2JlNnpPdWpYeDJSVE54a0xLSXJxRmRXdnNtOUszcTJtN1hUVUJ0NkQzLzIx?=
 =?utf-8?B?djNrM2NWSThBMjRXYnpjWDlabk1MVEVGU2RZako3dkJsM1hkSEpMYllIU3B2?=
 =?utf-8?B?b2hldHU3dTlHZHRMdUtzN0pVZFcwejhVNjg3N0tnL0xhZDk0dUNsTkFXekR6?=
 =?utf-8?B?eVNYUlpmRXgyQ3B2Y3V3clBUOTYyOHlQOEhKU0xGelBwQmtZZVl2czlKYmd0?=
 =?utf-8?B?UVVmK2lnbWIrV0V1czhBUUpNbndJWFBucHZGbVJ3T3NsNUFYK3ZQOUFkY0VD?=
 =?utf-8?B?TWpBL09TeTh0SjRyU0NGVnlwNTBEWTV2a1gxS21Rd3UrQkllS2pLTy85S0p1?=
 =?utf-8?B?NzVQTlRrMWM1Z3RMdlIwTHpqNU83eFVhU2VCcWoxMk5jZkUxWElwR0lUbmVQ?=
 =?utf-8?B?aks2QWV4YVYwbk9Ic1EyT1pFUEZhNDAwWm9oSUl3bVY1YTgydkJ4M0JHaTlV?=
 =?utf-8?B?VytseFloUGNuZlJzQ3pOWnVIN290YzZNR3dUSDJnaWh6ejFhRlM1bVY1cGZz?=
 =?utf-8?B?M0VEeE8ycFNub3Rod2RkZnljN1RWZjVnZllSWUNIc1FadFkzUVBTcmZoSzVm?=
 =?utf-8?B?YWkvQWkvQjV3NitzcHZTQWd0U2tLM3V3TVB5NzlHVW5uWnpjdk5OdkJBeHR3?=
 =?utf-8?B?OXd3THUwanVhYWVYQWxNTHRiUTJQM0FXTWg2OFBTai85L0ZMRjRBUjltMnZQ?=
 =?utf-8?B?MmNQbWNBcWJrOFJaOWhuRHlBbzRSZmkzYUFqR284MlI5QlgxckRlS3pMYVY0?=
 =?utf-8?B?SVB0QVY3U1RwUi93YnZtMzlVbVk5ZzBjNkJXbncva3VzTy9lZ3dDdTYxQVBu?=
 =?utf-8?B?eWQxZitXemJNVzNOa1RlTDY0endVUHJSNkk0N3ZBeXozcjZ1b2F5amxDc2gx?=
 =?utf-8?B?NHdXNTFhS1NRcGU2ZEM3M21Sa1hPckJzcVJyS1BCemV4ejRlRzJ0akc4R0dW?=
 =?utf-8?B?aDRMaDVYZVQvU2RjUmMrKzJET0o1bjR1V1BkRDkzRUkwM0dYZHNmMzIwMUhO?=
 =?utf-8?B?cHY0TDlFdExpZlB4djRxTytlV2VBU0k3SGlYWTljWW8yNTZNeExTemJUbU5C?=
 =?utf-8?B?NkR0VFRiR0pOODlqYlFZaUxGUlVvSlJHVEJETkc1VUlvZkVtMy83MmZLMDFi?=
 =?utf-8?B?VkRPVEM1U0VjcHo4bW52M0JrV0UvNVMxaUFuVlh2STNmUkxtV3Z0VUFWVnJT?=
 =?utf-8?B?NVJERUQ3L2ZNd3Nua3lRTi9YMitWRG5pS0svV1FCdXkwM0NyOTg5U2o5eDBv?=
 =?utf-8?B?K255ZmY1N3ZIemJGZEVsR05oQUJWaW9UUkVreFRPZ0M5ak1yY3M5azBQWkRp?=
 =?utf-8?B?RXB1OVRRQWY3U0ZvY3NyeE4rdkxUZlRiRllidnAvaGdKdlAwVXJaUzArZy9M?=
 =?utf-8?B?NGpIcXE0WGJJRjVxMnhKVGM4QnRINmRwR3p3dm5hZDVGN0V6cWpmejJiSVpk?=
 =?utf-8?B?QmdMQWV0akdvbDh3YzFVenNKQnFadzhiQU5aNVJHVEk5bUVtZlpaQ0Z6OFcy?=
 =?utf-8?B?SnFVdDhoTVdJaHRSNWFzKzVMOWl0S2FoWHNld3ZoWmNaMTlFaHFJTGErYnVa?=
 =?utf-8?B?TGhaVkNMRHYxdlpMamJIZWxSZ21WU3RnYlVhbHdwOTlHWnRlT3krUGRxTERC?=
 =?utf-8?B?QkZjeDFZVHkxR1NQSGFDOEJtajA4SDd0V3duenRBV2ppa1hjeWQwLy9IdDdj?=
 =?utf-8?B?ZXY2ZXk1dkw2ZnphYjQzVjVTd2RvbDFVVEhaSUdBYjlKVGxPL0tkZTdkdGJh?=
 =?utf-8?B?azV3NzVrQXZ5Z0Y4YkxjL281b1FmSjIycVRzekM0L0RwWDN2YXRNUE5KQjlm?=
 =?utf-8?B?QjBiaFBCNUl6RkZWQS9aUXBPcnJvZUNmdnJHUjRxQTRsbzk0TkQ1d240M2dm?=
 =?utf-8?B?MGx5eUN3YmQzTGxDSjFHWTdza0dRPT0=?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <984C351C9C6E5D45B10C17030971D032@namprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR03MB3623.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8e9a3644-69b4-4e65-839f-08d9f3c10589
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Feb 2022 16:00:59.4584
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 335836de-42ef-43a2-b145-348c2ee9ca5b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: pC3K1w90NKZCnDpiO8BYyyGlhjWCABPzEzXYqomoxnOI74sgsBj0h0UHthloEYHWwJMO+aJ4w15CGOmBFoDW31L2zMGONZ8vT6bCgRJfQD0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR03MB3627
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

T24gMTkvMDIvMjAyMiAwOTo1OCwgUGV0ZXIgWmlqbHN0cmEgd3JvdGU6DQo+IE9uIFNhdCwgRmVi
IDE5LCAyMDIyIGF0IDAxOjI5OjQ1QU0gKzAwMDAsIEVkZ2Vjb21iZSwgUmljayBQIHdyb3RlOg0K
Pj4gT24gRnJpLCAyMDIyLTAyLTE4IGF0IDE3OjQ5ICswMTAwLCBQZXRlciBaaWpsc3RyYSB3cm90
ZToNCj4+PiBUaGlzIGlzIGFuIChhbG1vc3QhKSBjb21wbGV0ZSBLZXJuZWwgSUJUIGltcGxlbWVu
dGF0aW9uLiBJdCdzIGJlZW4NCj4+PiBzZWxmLWhvc3RpbmcNCj4+PiBmb3IgYSBmZXcgZGF5cyBu
b3cuIFRoYXQgaXMsIGl0IHJ1bnMgb24gSUJUIGVuYWJsZWQgaGFyZHdhcmUNCj4+PiAoVGlnZXJs
YWtlKSBhbmQgaXMNCj4+PiBjYXBhYmxlIG9mIGJ1aWxkaW5nIHRoZSBuZXh0IGtlcm5lbC4NCj4+
Pg0KPj4+IEl0IGlzIGFsc28gYWxtb3N0IGNsZWFuIG9uIGFsbG1vZGNvbmZpZyB1c2luZyBHQ0Mt
MTEuMi4NCj4+Pg0KPj4+IFRoZSBiaWdnZXN0IFRPRE8gaXRlbSBhdCB0aGlzIHBvaW50IGlzIENs
YW5nLCBJJ3ZlIG5vdCB5ZXQgbG9va2VkIGF0DQo+Pj4gdGhhdC4NCj4+IERvIHlvdSBuZWVkIHRv
IHR1cm4gdGhpcyBvZmYgYmVmb3JlIGtleGVjPw0KPiBQcm9iYWJseS4uLiA6LSkgSSd2ZSBuZXZl
ciBsb29rZWQgYXQgdGhhdCBjb2RlIHRob3VnaDsgc28gSSdtIG5vdA0KPiBleGFjdGx5IHN1cmUg
d2hlcmUgdG8gcHV0IHRoaW5ncy4NCj4NCj4gSSdtIGFzc3VtaW5nIGtleGVjIGRvZXMgYSBob3Qt
dW5wbHVnIG9mIGFsbCBidXQgdGhlIGJvb3QtY3B1IHdoaWNoIHRoZW4NCj4gbGVhdmVzIG9ubHkg
YSBzaW5nbGUgQ1BVIHdpdGggc3RhdGUgaW4gbWFjaGluZV9rZXhlYygpID8gRG9lcyB0aGUgYmVs
b3cNCj4gbG9vayByZWFzb25hYmxlPw0KDQpJZiB5b3Ugc2tpcCB3cml0aW5nIHRvIFNfQ0VUIG9u
IGhhcmR3YXJlIHRoYXQgZG9lc24ndCBoYXZlIGl0LCBwcm9iYWJseS4NCg0KfkFuZHJldw0K
