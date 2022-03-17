Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 085564DCFE9
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Mar 2022 22:08:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230094AbiCQVIV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Mar 2022 17:08:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230059AbiCQVIS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Mar 2022 17:08:18 -0400
Received: from esa1.hc3370-68.iphmx.com (esa1.hc3370-68.iphmx.com [216.71.145.142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 446D818463A
        for <linux-kernel@vger.kernel.org>; Thu, 17 Mar 2022 14:07:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=citrix.com; s=securemail; t=1647551221;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=SfvrK10UVpNU8Iu1RppWPtt9yFn5gMoKFCPHu4DZcPA=;
  b=AVDqVH9/8bG+7AQ7BWTc5EOe0bkJjCFCTF1wIPseSC2P77ubcn6Qzm4j
   MOJlmIQyqwu0ur8XX8VfRFDUd/FHmKFyYNpt7YqoBviyxi8HO1JqXWtt4
   Hp9ALwvn+haNpxuvbcX6/hlYUYKyLFYYcQVEzAZFZ8RIkrP9J9lVqHQ5c
   I=;
Authentication-Results: esa1.hc3370-68.iphmx.com; dkim=pass (signature verified) header.i=@citrix.onmicrosoft.com
X-SBRS: 5.1
X-MesageID: 66949328
X-Ironport-Server: esa1.hc3370-68.iphmx.com
X-Remote-IP: 162.221.156.83
X-Policy: $RELAYED
IronPort-Data: A9a23:WiIQHa0LenrFmjkaPPbD5eV2kn2cJEfYwER7XKvMYLTBsI5bpzwCz
 mYfWGGDaP/ZZDDyLtt+adm/p0gE7MDdzdMxSgVlpC1hF35El5HIVI+TRqvS04J+DSFhoGZPt
 Zh2hgzodZhsJpPkjk7xdOCn9xGQ7InQLlbGILes1htZGEk1EE/NtTo5w7Rj2tUx3oDia++wk
 YiaT/P3aQfNNwFcagr424rbwP+4lK2v0N+wlgVWicFj5DcypVFMZH4sDfjZw0/DaptVBoaHq
 9Prl9lVyI97EyAFUbtJmp6jGqEDryW70QKm0hK6UID66vROS7BbPg/W+5PwZG8O4whlkeydx
 /0Tr8TvF0AOIZeXo8ciC0NVFAAkEYpZreqvzXiX6aR/zmXDenrohf5vEFs3LcsT/eMf7WNmr
 KJCbmpXN1ba2rzwkOnTpupE36zPKOHCOo8Ft24m5jbeFfs8GrjIQrnQ5M8e1zA17ixLNaiAN
 pZIMmA/BPjGSz5GFnU8Ms4HoN6Pm0LQSzpTqk2Ti6VitgA/yyQuieOwYbI5YOeiR8pPmV2Dj
 nnb5Gm/CRYfXPSHxCaI6GCEh+nBhyr3VYseUrqi+ZZCkA3N7m8eEhsbUR28u/bRoki3R9JWL
 WQX9zAooKx081akJvH5XhulsDuHswQaVt54DeI38keOx7DS7gLfAXILJhZFado7pIoqQjsu3
 V+AntXyLSJgvafTSn+H8LqQ6zSoNkA9KXIeYgcHQBED7t2lp5s85jrLSshmOKq0lcHuXzXxx
 S2a6iQzmd07jdYC/7eq4VfdxTmro/DhSwkv7AL/UWWi4Qd0IoWiYuSA9V/B8/9EIJ2xSliHo
 WhBlc+D6uwHEZCKkmqKWuplNLel6u2MLTnagFN1BLEu8DOi/3PldodViBl0PG9gNscJf2+vb
 EK7kQ9Y+pIVPHKsdqJxS4awDdk6i6nmCdnhEPvTa7Jmfpd1ZCeD/SdzeVSX2WH91kQh+Yk6O
 JGUdu62AHoaALghxz2zL9rxypdymHp4nzmKA8mmkVL3itJyeUJ5V59bKgPRMKce85nfmybqq
 4xSMOrQ5zJABbiWjjbszaYfKlUDLH4eDJ/wqtBKeuPrHjeKCF3NGNeKn+p/JtUNc7B9076Ro
 yrjAhMwJE/X3yWvFOmcVpx0hFoDt75bpGlzAyEjNE3AN5MLMdf2t/d3m3fakNAaGA1fIRxcE
 qFtlyaoWK0nptH7F9I1N8WVQGtKLkjDuO52F3D5CAXThrY5L+AzxvfqfxH06A4FBTetuM01r
 tWIj12HHsZeGF04Up6JNZpDKm9dW1BHxIqeuGOSfrFulLjEqtA2e0QdcNdqSy3zFfkz7mTDj
 FvHafvpjeLMv5U04LH0aVOs9O+U/x9FNhMCRQHztO/uXQGDpzbL6dIQAY6gIGGGPEupqfrKW
 Amg56ylWBHxtA0R6NQU/ncC5f9W2uYDUJcBl1U6RiqXNwr3Yl6iS1HftfRyWmR27uYxkSO9W
 16V+8kcPrOMOcj/F0UWKhZjZeOGvcz4UBGLhRjpCC0WPBNKwYc=
IronPort-HdrOrdr: A9a23:Qw3AiKpBMoSntk6VuQlkMEsaV5uLL9V00zEX/kB9WHVpm5Oj+f
 xGzc516farslossSkb6Ky90KnpewK5yXbsibNhc4tKLzOWx1dAS7sSrLcKogeQVBEWk9Q96U
 4OSdkHNDSdNykZsS++2njELz9C+qjGzEnLv5ak854Fd2gDAMsMj3YbNu/YKDwNeOAvP+tiKH
 P23Lshm9PUQwVvUi3NPAhiYwGsnayvqLvWJTo9QzI34giHij2lrJTgFQKD4xsYWzRThZ8/7G
 nsiWXCl+aemsD+7iWZ+37Y7pxQltek4MBEHtawhs8cLSipohq0Zb5mR6aJsFkO0aOSARcR4Z
 zxSiUbToNOAkDqDyeISNzWqlDdOQMVmjvfIJmj8CPeSILCNWkH4oF69Pxkm1PimjsdVZdHof
 92Niuixulq5VmrplWM2/HYEx5tjUa6unwkjKoaiGFeS5IXbPtLoZUY5149KuZLIMvW0vFuLA
 BVNrCW2B+WSyLsU1nJ+m10hNC8VHU6GRmLBkAEp8yOyjBT2HR01VERysATlmoJsMtVcegJ28
 3UdqBz0L1eRM4faqxwQO8HXMusE2TIBRbBKnibL1jrHLwOf3jNt5n06rMo4/zCQu1E8LIi3J
 DaFF9Iv287fEzjTcWIwZ1Q6xjIBH6wWDz8o/surqSReoeMMoYDHRfzPWzGyfHQ0cn3KverL8
 qOBA==
X-IronPort-AV: E=Sophos;i="5.90,190,1643691600"; 
   d="scan'208";a="66949328"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UjjzvqEr8rnHbHQrr5mL+6BZ4IbOpnC9h12U82o2p7mxe4Rs/LQBobQzvDmF1/FJo9sZwg11pa8geR74rQXotEd4s/PVOSIHjVTrJBVXYGLucYX1s08lzk4CL8bwf1VKFf5OLB9DnA1C41kMuFxftV2p7iQidCkdA+3QVz59BtdS821k4n4/y0tmMgix9AZIrIeXQ5/JHrVEswFLHWjfmav5iHeI2vj6Rs1MoH3Ku6xUD1Ocb+iSj01or8rSm/hlrVflJnjLMcZZuFbZUZTQB8cUBpWOVWT8RSQLaL90sinw0IwejyLTHUm4vnwfBRZ9Mf0zgHQBRhSgtBlqYmH2fw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SfvrK10UVpNU8Iu1RppWPtt9yFn5gMoKFCPHu4DZcPA=;
 b=dy0D0UdhqKS1RM7cJ4EzdpoUg/mYtYuwa3/9Olk2dIrbJ4rwWXmCS1k2v9B6aYYluz11icjva67ZhtIUsbQL/tNCkmeXsFw8TV37q9VeSfZ9HLrQJgetmZvsobijDPvAB9kQdXTQfdBYxh4sn5j+NhtB8iEKvHtT4PbgeUE87qI86WP2l18ne9XqrJ8ayCq9CY/PMxpZ3oHGIo/3pM7LwTUxS28xkXc3dF7sl6hl8EWL6pxWVEMtcsm/7fKotSS4Xvv/giKsTHVdqoY55n7kD2RLCovm5jKzXnYe81PnJ6c9Yiw4fPcuxdRH/HhZWXs82Xs8k/1IMXaAk3MuPCZqDw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=citrix.com; dmarc=pass action=none header.from=citrix.com;
 dkim=pass header.d=citrix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=citrix.onmicrosoft.com; s=selector2-citrix-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SfvrK10UVpNU8Iu1RppWPtt9yFn5gMoKFCPHu4DZcPA=;
 b=kOCd3oFFehzTSAJ3QoxTdlgr59k/KcGW9MkZnEjwqYk+npHBfvYLJE5ggEO4ciL6SoSK94T2IGtncPQYPLzb39xLvoERPRTXux+kIpHDRp9hWIKXxoo8Ihdty2DzsufODN2i3gGQa7fREwU71NjKsV5ZSLU9emboKdPQWh/g91Y=
From:   Andrew Cooper <Andrew.Cooper3@citrix.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        Nick Desaulniers <ndesaulniers@google.com>
CC:     "H. Peter Anvin" <hpa@zytor.com>, Bill Wendling <morbo@google.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>,
        "Nathan Chancellor" <nathan@kernel.org>,
        Juergen Gross <jgross@suse.com>,
        "Peter Zijlstra" <peterz@infradead.org>,
        Andy Lutomirski <luto@kernel.org>,
        "llvm@lists.linux.dev" <llvm@lists.linux.dev>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-toolchains <linux-toolchains@vger.kernel.org>,
        Andrew Cooper <Andrew.Cooper3@citrix.com>
Subject: Re: [PATCH v5] x86: use builtins to read eflags
Thread-Topic: [PATCH v5] x86: use builtins to read eflags
Thread-Index: AQHYOjAk+N160Jd7J0ub9fizhbeyG6zEETEA
Date:   Thu, 17 Mar 2022 21:05:52 +0000
Message-ID: <fd89333f-e470-a295-baf6-a736c55caeb5@citrix.com>
References: <20220210223134.233757-1-morbo@google.com>
 <20220301201903.4113977-1-morbo@google.com>
 <CAGG=3QWh90r5C3gmTj9zxiJb-mwD=PGqGwZZTjAfyi1NCb1_9w@mail.gmail.com>
 <AC3D873E-A28B-41F1-8BF4-2F6F37BCEEB4@zytor.com>
 <CAGG=3QVu5QjQK8m2FWiYn-XQuVBjUGXcbznSbK22jVMB5GAutw@mail.gmail.com>
 <F5296439-4CA3-4F31-BD91-5ED1510BC382@zytor.com>
 <CAKwvOdkk-C8HMemKs4+yoxvNDgTLmvZG1rmwjVXBqhsQ-cED5g@mail.gmail.com>
 <CAHk-=whJfKN8Jag=8DS=pbZR3TY90znUOP6Km+TLRJ9dZEgNqw@mail.gmail.com>
In-Reply-To: <CAHk-=whJfKN8Jag=8DS=pbZR3TY90znUOP6Km+TLRJ9dZEgNqw@mail.gmail.com>
Accept-Language: en-GB, en-US
Content-Language: en-GB
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: c4271c11-a58f-464f-b646-08da0859ebba
x-ms-traffictypediagnostic: DM5PR03MB3050:EE_
x-microsoft-antispam-prvs: <DM5PR03MB3050F12563F61499A7700BAABA129@DM5PR03MB3050.namprd03.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ULimp0TZ9Mm7gBHh0oPGROlOo59Pi0k7epQcewRU4s2GFtg4QMxqFPdH0upQsqx9xyhuTKKiR8JcniqBhcIXXG21nCDQ+yX+5Vr2BPtPggy/B2rXobSn0J2r1m2QDoEk8amLFW504pW2TTBg8Y2zngzzfGW9MQtoVgNUdBE7rtNVTwKQoGEAKMVyNtE+IOiPCeQkF00QQEP7uh1OGCkesGAF4wgjJC/CE1jkyYFyxdX1D1CyNtIX8g3iMFwrxYIMKcdbQhRfDWWDV/s3sfYfw1DzUQTVxCLCMpPznRW7w0djBoHTDvJPlVKdiKc1devRjeK9sp0WiC8B2RX+4AVjcUYMjEqu30du1oDMOTcJ4a4/U0zXDn16yeeXv052rrUgtMw2Wmqt/82KN+pcj6BnJy3N4st+EN9io7odPdbBL9jMDNtxEHjy8UZDUtJIIUTCHzCeIasXNpMUs9EXSjL6IfP3+ZhPwXZoLTOFmthqeRmvdNlZNW3QNRloedzG9++tLHhCujHhtUNcKpkk881iJucdHWlLvN8LAoVbSqh7YtqP+ZTH0+ZOTeet7yoCvi2k6js8DleYVa7jw294JA4Uq2ut7nRxne9FrFw7mu7jM3WlH8nK4ob8NFSQCg7nThQgbMMWPRc7edooXlNqI5ansHPMdvZGyH/hU9Z1ejhHZ7wjfZ0H/eXQHqLKq00At8PfIB9/vRX7JVcH4mbLMellTet9H4buijMUTMIj/APSYcvdaDTcY8gM9DOGGEyrEUziAOOxDDV3y/oVI3WWWUTXJeIAgaOET3kMDNunyTdIUbHCCwdIMjS7XRDy3QpqNPiJ99004LmSN/7I3tjc7Ye0eIgDP3OQ/Q8o86FUJ8vcbTQLQhEXMCpxo1Pc+gh42BmT/CFsYJgzB59+HQnl/nRLMVYDVHMbRgf4skKfwtjfgi/J4bOVyC3fDDmudtoIzy4C
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR03MB3623.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(5660300002)(38100700002)(8936002)(7416002)(6486002)(966005)(508600001)(91956017)(82960400001)(4326008)(38070700005)(76116006)(8676002)(66946007)(66556008)(64756008)(66476007)(66446008)(122000001)(54906003)(110136005)(186003)(86362001)(316002)(31696002)(53546011)(71200400001)(31686004)(26005)(2906002)(6506007)(2616005)(6512007)(107886003)(36756003)(43740500002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?eXd6elVWZjlneUtKSGxtMWt6eUQ0ZVJMM2ZWMkZldXBacjlpWFJFczZLeFc0?=
 =?utf-8?B?YytnYVJRTkNEOHV1OXRDQ0xneXhJUEVOUm9jQ055K0QyRjJNRDNzS2R6NVE2?=
 =?utf-8?B?RUxCVUdnNk1JVkovbWlGcDJHWUVJblFZaS9SZzd0Umw4UWUrV2NJeWE4djdG?=
 =?utf-8?B?OHNsOWpOaGkvWFNVTXloRDV5Z3p1eW1SWlMxalQzTkpvYnZGWEttOUNJUFRU?=
 =?utf-8?B?YVZLMGJoM1lwRnhkNS9ERkh4M0hRby9EN3RQYzM0M3dOOTRhL2h0SHh1QXdW?=
 =?utf-8?B?bm9rN0ZtYUVES2NGRUN2cDRpNkNYQmFDT0xxRGFOZ09OOXdOL3pScUdhTVFh?=
 =?utf-8?B?VFFWa0UzTEZEYlVqUDk2MUhUemYxWCtaWWN0eWMrdE1RZkRZWE5wUDZaQVoz?=
 =?utf-8?B?WDVnUEljYjJpMi81aWd3OEJQdjVJb2FSVFV1ZFozdWVVVEllYno4aXZnb0F1?=
 =?utf-8?B?MHU1cU1vZGdYb3luSU5HMWl3NXl0UDZ2eUI2THBIb3l3aWNnRnFGajBuYklJ?=
 =?utf-8?B?UDg4SnJMc2R4NXcvcU94VHlvWlFrZytxemVQZTNsUnFvL3ptemJ1VmZKeG1K?=
 =?utf-8?B?ZHlhU1U3WVNuUEtURTBYRnMxRVUvSkZVeUhya3ltTGd1aU9idTJPNFpTbGhw?=
 =?utf-8?B?QmJhMDl0dWh1N3M1Yy92UW9rQkx1Rk5zM3RkZ0NzUStqQ0l6Q0V5RFNOeU5y?=
 =?utf-8?B?aWw4cndKUFB3cnJkemlLV1haKzNiR2hQSGI3SzU5ZExvVElES0JjUkNUWWFv?=
 =?utf-8?B?aHZ4aDYwejVQYXFrZUZmYkM0MzVVZXZObUF4TTREdVgzUG1yYUM4d0J6YVkx?=
 =?utf-8?B?SUl2NmQ4ekovYWdFTVlaMm5FcGxrZ0ZrNlIwc3Rwa3NVNmtmNjdKZUlkK1BO?=
 =?utf-8?B?M1dxOGNub2M1VVE3eE9QLzd4MkNqNDVxOXFNL3hzSDFUNlpIMVFvTmNoU1VV?=
 =?utf-8?B?QWU0bDNlRjBhUGdFVTV6WjlEK1FmVk9YdnRKT3JUTGMvdU1SVDlnc0pRczN4?=
 =?utf-8?B?L1pwUXlUQjRFbHpUOFUwSkVyZ1ZSRHhGQUFUWWw3bDJ2Z05TT21VL1J2YStJ?=
 =?utf-8?B?U290bUs2cFJjL1hFZVJGaHRVQVhCWHp1ZTBMUnFsSkdSd3dGeHJRcU9Eb2hE?=
 =?utf-8?B?T0IxQXdiWEwxUkl4VVZWSTZPMG50UVNEeTdCYmlMbjd2a1hwM244TjJwQm5M?=
 =?utf-8?B?TDNGemJhWXcwNVQxNkxJck9oOGQrYUJGbTU0TEIwSHU1aFlvdDNGaEhqc0dy?=
 =?utf-8?B?VUxLc0xTeG1McnlOdENKOUt3VUFwT0JzbDd2SXR6TTJPMHpVMmIybFJ0YlpO?=
 =?utf-8?B?cWEvWjBFaWpOZHVvWUFGVTg2SU9QdnRTNGlKTzBqdGRGN3lSWDZUa0g4YkIx?=
 =?utf-8?B?WkgzUnlnc1FjcnYxQXdHOEo3dWJRWW95SHFWREo1cFpZS3BxbUFOTFljVHRl?=
 =?utf-8?B?TnlhdUVZbFg5eVc3aGh2Z3FNNmVTcDdkS3RpcmdadzdNalRhZkkvVEsyY1A4?=
 =?utf-8?B?ajdvbk9CR3duSGZPYzYzL2lvcnUxMWZIY096V0cxQTBCb1ZZbHJjU0xrYzJh?=
 =?utf-8?B?alJXNVdLVEoybk1oL0pNQjhWaWcrUUJXUEM3UVdVa3R5VkU4MER0MlJGUVVL?=
 =?utf-8?B?TnRKeHJjenhKZTkrZ0FkMGNqdXRnUlh1V1pXN2RQZkMraHNsTU1LR01NSWhq?=
 =?utf-8?B?TXUyMzZyQ2VQN3MrcHM0U0ZsZkM1N1pzWjNsb2VpcFdnbjJnM0xONDJYbFF2?=
 =?utf-8?B?ZTBPN1NJT3hGZEQ4cnJFYnVXdXUvY3kxazdKOFlPd1JnMitPeEc1NkRRL1hy?=
 =?utf-8?B?SjF5d1BrcVd1b2h3Mmp2VnJCT0UvN2o2VXZkeFJGZnFvdm9uek1sa2VmYjR2?=
 =?utf-8?B?Q2JuSllhb3YvMDhPQS9ONXplbVhUODhlSThPakp5NzMrV0hrSURRZzJGK3dv?=
 =?utf-8?Q?/k1HiboSReOdZo4fGibpXkFNpUYQFNSB?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <7CDBA5BA75CEF44D98665C1B53EB529A@namprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR03MB3623.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c4271c11-a58f-464f-b646-08da0859ebba
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Mar 2022 21:05:52.5871
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 335836de-42ef-43a2-b145-348c2ee9ca5b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: A2ARDDGu+oUF35hbfGe2hK5zCD/AhE8vOn5JuJbjRXk41wrnXF+xSXqc4M5g6kYrTQe792kyAonOx1Tb7GAu0c+8AiUxmz83J0Yelwt9mYA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR03MB3050
X-OriginatorOrg: citrix.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gMTcvMDMvMjAyMiAxODo1MiwgTGludXMgVG9ydmFsZHMgd3JvdGU6DQo+IE9uIFRodSwgTWFy
IDE3LCAyMDIyIGF0IDExOjAwIEFNIE5pY2sgRGVzYXVsbmllcnMNCj4gPG5kZXNhdWxuaWVyc0Bn
b29nbGUuY29tPiB3cm90ZToNCj4+Pj4gT25lIGNoYW5nZSB5b3UgbWF5IHNlZSBkdWUgdG8gdGhp
cyBwYXRjaCBpcyB0aGUgY29tcGlsZXIgbW92aW5nIHRoZQ0KPj4+PiAicG9wICUuLi4iIGluc3Ry
dWN0aW9uIGF3YXkgZnJvbSB0aGUgInB1c2hmIiBpbnN0cnVjdGlvbi4gVGhpcyBjb3VsZA0KPj4+
PiBoYXBwZW4gaWYgdGhlIGNvbXBpbGVyIGRldGVybWluZXMgdGhhdCBpdCBjb3VsZCBwcm9kdWNl
IGJldHRlciBjb2RlIGJ5DQo+Pj4+IGRvaW5nIHNvLS0tZS5nLiB0byByZWR1Y2UgcmVnaXN0ZXIg
cHJlc3N1cmUuIFRoZSAiZ2NjIC1PMiIgZXhhbXBsZQ0KPj4+PiBiZWxvdyBzaG93cyB0aGlzIGNv
ZGUgbW92ZW1lbnQuDQo+IEhvbmVzdGx5LCB0aGF0IHBhcnQgd29ycmllcyBtZSBhIF9sb3RfLg0K
Pg0KPiBXaHk/DQo+DQo+IEJlY2F1c2UgY2xhbmcgaW4gcGFydGljdWxhciBoYXMgYWxyZWFkeSBt
ZXNzZWQgdXAgZWZsYWdzIGhhbmRsaW5nDQo+IG9uY2UsIGJ5IHNwaWxsaW5nIGNvbmRpdGlvbiBj
b2RlcyAoaW4gdGhlIGZvcm0gb2YgZWZsYWdzKSBvbnRvIHRoZQ0KPiBzdGFjaywgYW5kIHRoZW4g
bG9hZGluZyB0aGVtIGxhdGVyIHdpdGggYSAicG9wZiIuDQo+DQo+IEFuZCBpdCBkaWQgc28gYWNy
b3NzIGEgZnVuY3Rpb24gY2FsbCBUSEFUIE1PRElGSUVEICdJRicuIFRoaXMgd2FzIGENCj4gbWFq
b3IgYnVnIGluIGNsYW5nIGJhY2sgaW4gMjAxNSBvciBzbywgYW5kIG1hZGUgaXQgdW51c2FibGUg
Zm9yIHRoZQ0KPiBrZXJuZWwuDQo+DQo+IFNlZSBmb3IgZXhhbXBsZQ0KPg0KPiAgICAgaHR0cHM6
Ly9sb3JlLmtlcm5lbC5vcmcvYWxsL0NBK2ljWlVVN3k1QVRTTFZfMFRHemk1bTVkZVdBRExtQU1C
a0FUMzJGS0d5VVdOU0pTQUBtYWlsLmdtYWlsLmNvbS8NCj4NCj4gZm9yIHNvbWUga2VybmVsIGRp
c2N1c3Npb24sIGFuZCBzZXBhcmF0ZWx5DQo+DQo+ICAgICBodHRwczovL2xpc3RzLmxsdm0ub3Jn
L3BpcGVybWFpbC9sbHZtLWRldi8yMDE1LUp1bHkvMDg4Nzc0Lmh0bWwNCj4NCj4gZm9yIGp1c3Qg
bGx2bSBkaXNjdXNzaW9ucy4NCj4NCj4gSXQgaXMgcGVyaGFwcyB0ZWxsaW5nIHRoYXQgdGhlIExM
Vk0gZGlzY3Vzc2lvbiBJIGZvdW5kIHNlZW1zIHRvIHRhbGsNCj4gbW9yZSBhYm91dCB0aGUgcGVy
Zm9ybWFuY2UgaW1wYWN0LCBub3QgYWJvdXQgdGhlIGZhY3QgdGhhdCBUSEUNCj4gR0VORVJBVEVE
IENPREUgV0FTIFdST05HLg0KPg0KPiBUaGF0IGNvbXBpbGVyIGJ1ZyB3b3VsZCBiYXNpY2FsbHkg
ZW5hYmxlIG9yIGRpc2FibGUgaW50ZXJydXB0cyBpbg0KPiByYW5kb20gcGxhY2VzIC0gYmVjYXVz
ZSBjbGFuZyBkZXZlbG9wZXJzIHRob3VnaHQgdGhhdCAnZWZsYWdzJyBpcyBvbmx5DQo+IGFib3V0
IHRoZSBjb25kaXRpb24gY29kZXMuDQoNCkkgd2FzIGlkbHkgcGxheWluZyB3aXRoIHRoaXMgYnVp
bHRpbiBpbiByZXNwb25zZSB0byB0aGUgdGhyZWFkLCBhbmQNCmZvdW5kIHRoYXQgR0NDIGhhcyBh
IGZhciBtb3JlIHNlcmlvdXMgYnVnIHRoYW4gQ2xhbmcgaGFkLg0KDQpodHRwczovL2djYy5nbnUu
b3JnL2J1Z3ppbGxhL3Nob3dfYnVnLmNnaT9pZD0xMDQ5NzENCg0KSWYgdGhlIG9wdGltaXNlciBj
b25jbHVkZWQgdGhhdCB0aGUgcmVzdWx0IG9mIHRoZSByZWFkZmxhZ3MgYnVpbHRpbiBpcw0KdW51
c2VkLCBpdCBnZW5lcmF0ZXM6DQoNCmJyb2tlbjoNCsKgwqDCoCBwdXNoZg0KwqDCoMKgIHJldA0K
DQp+QW5kcmV3DQo=
