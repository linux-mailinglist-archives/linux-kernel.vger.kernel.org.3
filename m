Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D86654DE3B1
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Mar 2022 22:48:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241194AbiCRVtu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Mar 2022 17:49:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232636AbiCRVtp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Mar 2022 17:49:45 -0400
Received: from esa1.hc3370-68.iphmx.com (esa1.hc3370-68.iphmx.com [216.71.145.142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE1BE104286;
        Fri, 18 Mar 2022 14:48:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=citrix.com; s=securemail; t=1647640101;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=kFOmTqbhVRfVPtCNXhC8to6G5ryJIEpEkiZ+9iVT3nk=;
  b=ePHbHHGbbpQNrm2tL0Bv+8CqoRtzsyhGoVTp/s6MI+Y3OVGEHv6qlAUR
   mP/CehNNxRJbcZ3JTn8aoli1t/qeoI/q8odqlxqDuqyED9KnQbX5ae4t/
   +iS/IXfFdm3nb57aWVF6ZHljK6sCi8hhqf1nPx5VowQQVxuWkG4JZjX25
   8=;
Authentication-Results: esa1.hc3370-68.iphmx.com; dkim=pass (signature verified) header.i=@citrix.onmicrosoft.com
X-SBRS: 5.1
X-MesageID: 67041905
X-Ironport-Server: esa1.hc3370-68.iphmx.com
X-Remote-IP: 162.221.156.83
X-Policy: $RELAYED
IronPort-Data: A9a23:vBrzcamoM4anPy7k8OxMZgXo5gy3IURdPkR7XQ2eYbSJt1+Wr1Gzt
 xJNXm/Qb6mDZGqmKN5+a4i+pE4Ov5CHy9FlSVBvpHhnHiMWpZLJC+rCIxarNUt+DCFioGGLT
 Sk6QoOdRCzhZiaE/n9BCpC48T8kk/vgqoPUUIYoAAgoLeNfYHpn2EoLd9IR2NYy24DiWlPV4
 7senuWEULOb828sWo4rw/rrRCNH5JwebxtB4zTSzdgS1LPvvyF94KA3fMldHFOhKmVgJcaoR
 v6r8V2M1jixEyHBqD+Suu2TnkUiGtY+NOUV45Zcc/DKbhNq/kTe3kunXRa1hIg+ZzihxrhMJ
 NtxWZOYbF01Our2wbUndgAGTRE5AvF855TIGC3q2SCT5xWun3rExvxvCAc9PJEC+/YxCmZLn
 RAaAGlTNFbZ3bvwme/lDLk37iggBJCD0Ic3k3ds1zzGS90hRojOWf7i7t5ExjYgwMtJGJ4yY
 uJHNmIzNUWYPnWjPH9GL7E1oMimo0LWYhpahF2TirYdszXMmVkZPL/Fb4OOJ43iqd9utkCRu
 mLP+Uz6DwscOdjZziCKmlquifXIhjjTQ58JGfuz8fsCqFGa2GFVCBQQTla9if24jFOuHdNZN
 0EQvCEpqMAa5Bz1ZtrwRRu1pDiDpBF0c95RFfAqrQKA0KzZ5y6HCWUeCD1MctorsIkxXzNC/
 luImc75QCBot7meSXuc8Ky8szy/I24WIHUEaCtCShEKi/H7rZ0+lADnT9BtCqe5g9T5Xzbqz
 FiiqCwggp0XjNUXzOO//Fbak3Sgq4ahZgg56x7eQ2aj7w5jf6aqYIun7VWd5vFFRK6ZVlCpr
 mkYnNLY5+cLZbmRkzaTSeEBB5mt5vCYIHjShkNpE5A99jOrvXm5cuh45CxiI29qP9wCdDuvZ
 1Xc0StU5ZlcO1OwYKN3ap73AMMvpYDqDfzsUvHZaIoIbpUZXAqA5itpTUGX2G/pnQ4nlqRXE
 YuUddaECXccFLh9yzy3V6ER3NcWKjsWnD2JA8qhllL+jOTYNCX9pao53EWmS7ol6OS++VTv1
 s8BafvN9EllT8bxW3yCmWIMFmwiIX8+DJHwjsVYcO+fPwZrcF0c5+/tLaAJINI8wfkM/gvc1
 jTkAxIDlgKj7ZHSAV/SAk2Pfo8DSnqWQZgTGSU3dWil1HE4CWpExPdOLsBnFVXLGQEK8BKVc
 xXnU5jYahisYm6ek9j4UXUbhNY6HPhMrVjSVxdJmBBlI/Zdq/Xho7cIhDfH+igUFTaQvsAju
 bCm3Q6zacNdG1s/Up+PM6rylwrZUZ0hdARaBRegzj57IhiEzWSXA3ap0q9fzz8kdH0vOQd2J
 y7JWExF9IEhUqc+8cXThLDskmtaO7AWI6auJEGCtezeHXCDpgKLmNYcOM7VLWG1fD6lo82KO
 LQKp8wQxdVaxT6mRaInSO01pU//jvOyz4JnIvNMRyyaMQ70Vus+fhFrH6Bn78Vw+1OQgiPvM
 mqn8dhGI7SZfsTjFV8aPg0+aeqfk/oTn1HvAT4deS0WOAcfEGK7bHhv
IronPort-HdrOrdr: A9a23:JmTpdK1uWHOsa3XEm6o+xgqjBRxyeYIsimQD101hICG9Lfb2qy
 n+ppgmPEHP5Qr5AEtQ5OxpOMG7MBbhHQYc2/hfAV7QZnibhILOFvAt0WKC+UytJ8SazIBgPM
 hbAtFD4bHLfDtHZIPBkXOF+rUbsZi6GcKT9J/jJh5WJGkAAcAB0+46MHfhLqQffngcOXNTLu
 v52iMznUvHRZ1hVLXdOpBqZZmgm/T70LbdJTIWDR8u7weDyRmy7qThLhSe1hACFxtS3LYL6w
 H+4kzEz5Tml8v+5g7X1mfV4ZgTssDm0MF/CMuFjdVQAinwizyveJ9qV9S5zXMISaCUmRQXee
 v30lMd1vdImjTsl6aO0F3QMjzboXMTArnZuAalaDXY0JTErXkBerV8bMpiA2XkAgwbzYtBOe
 twrhKkX9A8N2KwoA3to9fPTB1kjUyyvD4rlvMSlWVWVc8EZKZWtpF3xjIfLH4sJlOy1GkcKp
 gnMCgc3ocjTXqKK3TC+mV/yt2lWXo+Wh+AX0gZo8SQlzxbhmpwwUcUzNEW2i5ozuNxd7BUo+
 Dfdqh4nrBHScEbKap7GecaWMOyTmjAWwjFPm6eKUnuUKsHJ3XOoZjq56hd3pDhRLUYiJ8p3J
 jRWlJRsmA/P0roFM2VxZVOtgvARW2sNA6dvP22J6IJzYEUaICbQxFrEmpe4PdIi89vd/HmZw
 ==
X-IronPort-AV: E=Sophos;i="5.90,192,1643691600"; 
   d="scan'208";a="67041905"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Wny+lsRncy9896UexAujcYiCxD7lmpHo5AfIeVdLxWWk/S/s9GM4d1b+wmFuePoSEDIPeqA5npn1ZKIMgc5jUtQV7YfOdEh4N6FXMjo/kpN+lc3vQUXRjE7UoG7eOFep0Am7ylWqGyd4r5X7ax/vVgILbBg78pPwwcSCNMoAB7Oq42taQmxykVhN2vVkvXmtzUNYJ+UR6eTleTocG0EOYkQAkbeN9gcPtJ5n2dRfxm8GtKlcnozERbMN2VBTMLe5ugMYSZUoxFgoOiOZsE9xAa1NGLnie4/ls6YlwTq/6EJApTNuc1K+5+qMKBGIEcbKRm8/PZ27JrJOD9Wv8t2a5Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kFOmTqbhVRfVPtCNXhC8to6G5ryJIEpEkiZ+9iVT3nk=;
 b=n3abv8ziaPfbHF61QRY/ZQjKWweIYTXG0+RWeMdohNmFdYev1oZIPN4XF9Ee4yokxMaFU1kkrti+gUOHdkMEypY246u3IvcCkSukx6RboNuGIvNMSvdEuKU6lB7ytJFBjQja/Nkjm+jIXsOV8xvIoLucKlUZe2r/ZvOfRiubXlluxuKraRjm7SOeMQZFTYxlZb4BNN0k65Vwym59hagOoVM7uzpZaKjSlWc1bEjeKdam33nPDcxiNzlhAYun0OgueUZIi/yuvnriAypN7Ef58c2CSm/iN1pq2TpMTVhJFJAU1wGhMSNp3UaJxVGFSWXJoZnH/gpSAA5Mr1Ik5+ybNQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=citrix.com; dmarc=pass action=none header.from=citrix.com;
 dkim=pass header.d=citrix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=citrix.onmicrosoft.com; s=selector2-citrix-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kFOmTqbhVRfVPtCNXhC8to6G5ryJIEpEkiZ+9iVT3nk=;
 b=CToUAOWQCTWplNj5JT/g8jzLZoESpbDcaw0psJRqxK2iypQlZ3df8cS9sioweaLZxFtQubwFUVOxjBskMJwAldOc2hj3hhAZezFo+sa+GCWKGH6k2/APIMv9cXFmHLS2iFyIjDpQ+O6LTvjkf91uHK6jx7h/o6bSMOKFfwkIbQU=
From:   Andrew Cooper <Andrew.Cooper3@citrix.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        Andy Lutomirski <luto@kernel.org>
CC:     Nick Desaulniers <ndesaulniers@google.com>,
        "H. Peter Anvin" <hpa@zytor.com>, Bill Wendling <morbo@google.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Juergen Gross <jgross@suse.com>,
        Peter Zijlstra <peterz@infradead.org>,
        "llvm@lists.linux.dev" <llvm@lists.linux.dev>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-toolchains <linux-toolchains@vger.kernel.org>
Subject: Re: [PATCH v5] x86: use builtins to read eflags
Thread-Topic: [PATCH v5] x86: use builtins to read eflags
Thread-Index: AQHYOjAk+N160Jd7J0ub9fizhbeyG6zEETEAgAAJagCAAVTWAIAABZcAgAA6VAA=
Date:   Fri, 18 Mar 2022 21:48:14 +0000
Message-ID: <9a97330b-e5ee-7b7e-4c7a-cfdf15032094@citrix.com>
References: <20220210223134.233757-1-morbo@google.com>
 <20220301201903.4113977-1-morbo@google.com>
 <CAGG=3QWh90r5C3gmTj9zxiJb-mwD=PGqGwZZTjAfyi1NCb1_9w@mail.gmail.com>
 <AC3D873E-A28B-41F1-8BF4-2F6F37BCEEB4@zytor.com>
 <CAGG=3QVu5QjQK8m2FWiYn-XQuVBjUGXcbznSbK22jVMB5GAutw@mail.gmail.com>
 <F5296439-4CA3-4F31-BD91-5ED1510BC382@zytor.com>
 <CAKwvOdkk-C8HMemKs4+yoxvNDgTLmvZG1rmwjVXBqhsQ-cED5g@mail.gmail.com>
 <CAHk-=whJfKN8Jag=8DS=pbZR3TY90znUOP6Km+TLRJ9dZEgNqw@mail.gmail.com>
 <fd89333f-e470-a295-baf6-a736c55caeb5@citrix.com>
 <CAHk-=wj47CG0Y9GOFmGg4AYFvXhRFDX9x7E2Uxo9k-UX2wgR4g@mail.gmail.com>
 <83b33afc-8502-0065-60bc-3a91528632d8@kernel.org>
 <CAHk-=wj1Z_zzY7ADxaarorK5sh2xkwbcHxJTzW=bsYChWJGBGg@mail.gmail.com>
In-Reply-To: <CAHk-=wj1Z_zzY7ADxaarorK5sh2xkwbcHxJTzW=bsYChWJGBGg@mail.gmail.com>
Accept-Language: en-GB, en-US
Content-Language: en-GB
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 5edcbee1-2d67-4b6d-018c-08da09290183
x-ms-traffictypediagnostic: BY5PR03MB5030:EE_
x-microsoft-antispam-prvs: <BY5PR03MB5030355D250CB31C48119F99BA139@BY5PR03MB5030.namprd03.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 99Uo/KIExmLZVwM/JA5xGwu7i+U4T1cgLGKZ+hrK/KhsOCurQEKG04MQ9YzfhirT/gDv4RJZldIy+FcB46/qG5rJ7kyU+Wn4B7LQUFqJ2vgR8DC+mkZK+vCRkF6j5XyX5D3L5SWMPh2PHA55m9bvCllraVgklYDCXfQnlzUTDKnynhd1SQx2TLDZaf5WskwkFXOXhMPwPcL+iKBO4UZVmpTWJR8uTjQ6kHR2aHIABR2OSRk2WfIvtLEfwQ8ylYWjZMmQH+4bJHRqaC/AQcT87vyAdSmXVZeVE7C4sHG1tE8AagocrxNGmx4MYvGpz5Oifes1abCnGd6JGVGhvp2pNM4XVBV6nNgxTMTYB2a+5TPL2vRHv71EoGkwSJx306BUcQF6N/nAX49MfL/gy6IfwyP4OC5aM0zUnJfg1PgH6xJIc18Zjl37QsOAuOz+A7l+2+TGXQ5gO+1GUTVOvzhPif5xG1LAVQf6vkAfgM2lv7jV0H6ALcmI01mIvRW0NnIFRtplGx6MetWJYSRsFcyXy9nJRJpSNNDqJgRvlo/QlpeOjVqu9d4XqR5Be6nWlIKJbpzhoP2HfX3rnQCs0SdBhJRgQtrsWqgVI+GZawZrY7Wz+vrRujTP8iajj5jvTSuf7+qYVb+syKHvUoTG6//+AJtjlIM4AeyChdwwsr8W6Mz/z6VpWLSXHOPsobnwv4wdYl58iCkcI0O/IZHDoG1gD0IJdbkcYBTWRLXSRZd21HKtMvHLsP3R+OF0do4UBQRNdecjRMRWEqH9ZxaAggUG5Bk83Dw9KCW00uSL74JsaiwJFfxniw9LL+TXXS4BB6UMDmv4Pn8TuHixMHjjSpYg0ZVMsBEhEecZo2X7/RSDs6w=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR03MB3623.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(86362001)(31696002)(36756003)(4326008)(82960400001)(8676002)(186003)(2906002)(508600001)(38100700002)(26005)(110136005)(2616005)(31686004)(54906003)(5660300002)(6486002)(316002)(71200400001)(966005)(8936002)(91956017)(64756008)(66446008)(66946007)(7416002)(66476007)(66556008)(122000001)(6512007)(38070700005)(53546011)(6506007)(76116006)(45980500001)(43740500002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?L28zNEt2Zkd2V1RVZldXSVhsbXZ6WjVJT0o3aEtZU0dMQUFRcDcrSGNoMEtq?=
 =?utf-8?B?TlBmNFZvblk3Y3lQZmRyKzF3YkRQREJSK3hvUG1udU1uTVhoYXhpQy91d0ZF?=
 =?utf-8?B?eXNnYjdPVFhpZjJZVjVQOE9sbm5pVS9la0pyaUxFa2dTQTZiMkl0K1c5ditO?=
 =?utf-8?B?bXpPdTRNUUpZd011ZFZRcll6SDc5Z1NmemlBRi9MM3FxOVFKZDZIKzRXZlYx?=
 =?utf-8?B?bVliR0JrSk5BYXZjU2R0WVdYQ1VtNUVSbkUyUXdrOUlQWGp2MnRsQUR3ekRj?=
 =?utf-8?B?VldlZnhJbUs3ZmNYS0djMi9aTTBJRGZUZ0NXd2luY2p1R25CSTgvd2wyNW1m?=
 =?utf-8?B?S0VsMTRhdWgvUEpmUUtYZHB1Vm4vZUVSRkVQeDRaT08yYm0wb1BtWUVDczRD?=
 =?utf-8?B?M29xRzNUMU5kUm9majR1REd1MzR2b3dES3BtdGhjR0pvMFBZbzhUQW04a2tR?=
 =?utf-8?B?ZnBJMHdTOHdhVS8rMmU0b0VDVnEyUFVOaGlQYXZLL1ZBbm5Eb0R2VWZBejND?=
 =?utf-8?B?TFJxQ1I1RXo4T1FDbVk0Wi9XVmpFTTJwbzl4ZzRWYW1XcEpHQ25iQ3hlcEtn?=
 =?utf-8?B?ZHVFTlFsa2xncFFJOFlkKzZuaFdVODJCeXNFK3VmZ1FjT2tFeDNvL011dDhk?=
 =?utf-8?B?clUzMzFNeThGSDZwVG9jVmhpeUtJVXB3YUY2NGZiNFVMalcvOWdERmRiSndG?=
 =?utf-8?B?bUZueVJBeGxVWHNSUjhUQllsYmxDc0g5ZEFPNkVTV3FLVno2cHVPQzFpVm1R?=
 =?utf-8?B?Y2psWHFiWnM2aEhzOUVyYXd4VmRVT3BZcWQ5T2pNeGF0ZDVjWUw2enJTUi9E?=
 =?utf-8?B?MGN0YS9zK3AwMzlWRTRUTENWT2pyb0wrRXVmaUltcTVheDh2V0dKZEhjR0JM?=
 =?utf-8?B?dkJDdzg2RUxWTGd3VkdYTzRlTll6cUwzUjd2bnlsWnpGcnZ0NlRTTHlFNmp1?=
 =?utf-8?B?MkQxbHJMK2NhZ2NOZGVLTW1vTU54K0h5Ni9HN1JjQWRYcWlBcjBFeGl1MzA0?=
 =?utf-8?B?akg0M0R3cXdIemUwaUJBYkNHVU5SeU5pa2sxNHB2Tk5halZMbnFib0IvZ3B0?=
 =?utf-8?B?dW8rQVh0aXpPVWdLcWgzNUNqaSt3MUJWYzBYN3pIUWo2YUcvWmRQL21HczZR?=
 =?utf-8?B?ZlQ5ZXJmbE51QXRkL3lla05uR2JVeHlhTEwzMnh6Qm1ONURDdUFtcFozdnVp?=
 =?utf-8?B?c3VnSVVZUkFQQlJ0dDNSdVlkSTEwUVFydUowb3dnL2RycENmS3l6MFRpMzRG?=
 =?utf-8?B?ajRmV1d6MlQ2dnI1ZW9KQksxcnY0cGRYUk9tMTVDUXVLQkVQc0RvOU9EUVA2?=
 =?utf-8?B?d3N3YnJ5SVcvdVp0OWJkY2Fpbk45dGRnQ3FnbVl1MGh4RnViODUxSVBMYlN6?=
 =?utf-8?B?ejN6bUdwUlFlME03aVVJRU5PY3pkS3Rvc3ByUGdaOGdBM3JNUUhyOUthU0gv?=
 =?utf-8?B?SXNxQzdWQVVKbVl3cTlOUnJ3UWF2M1pNbVdjLzJTVGgvQ0NrVVpWV0QzUzRU?=
 =?utf-8?B?WHg5YnFKTnhtT0o0QzdtWWF4MUZyT1o2VVlSRyt3NWF2dVE2L3hzQlUyVnlP?=
 =?utf-8?B?QS9IbEVuOTJUdDRrUGZ5eVJlcmlMYjFVbkc1N2h0YTk2N210M1lFazh3cTh3?=
 =?utf-8?B?LzN2cWZ0Ri9mNWQzZ1FKZTdod01IQ2NKTFhkdFQrUWQ4TFQ5R3ZZbVhSTzJC?=
 =?utf-8?B?WEo2VGVxZzcvNGFmeE5hcXNFS01nNitVR2pMNDJVOUdPaHBvbC82bEljM0VH?=
 =?utf-8?B?bk5vVHlERVEvVFd4NFdWRTF6dDVIV25KWXI1RXc2Q1VOM0t0aU9iZU5SbXRF?=
 =?utf-8?B?d1hOTVFVSS9IdkFKbmkxR0JNYnQ3Z1BRbkpodGtqNm1YQks3SkhmNUllbU1J?=
 =?utf-8?B?S2RKa2FZVWdjeml3SHd6d0d5YnNLVnhyQzJMVTNiUHM0YU5tcitEL1RUa3lU?=
 =?utf-8?Q?KRdOdVYzcBrShfQFvmr2AVzbvZQeHa1A?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <0BBE4F80B3B85E4B9A35C69250845A61@namprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR03MB3623.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5edcbee1-2d67-4b6d-018c-08da09290183
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Mar 2022 21:48:14.9237
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 335836de-42ef-43a2-b145-348c2ee9ca5b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: XPKVdVFC5pq/g7yjf2RsvPlRSDAnaHZHPewEY5m4pt/w+MJq05Kz1Sg9AOfxQCbJ8NY/rsyKjiTNA31j6QkDTV0gN4PcHSDzymid3K5iRYs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR03MB5030
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

T24gMTgvMDMvMjAyMiAxODoxOSwgTGludXMgVG9ydmFsZHMgd3JvdGU6DQo+IFNpZGUgbm90ZSBh
bmQga2luZCBvZiByZWxhdGVkOiB3ZSBkbyBoYXZlIHRoaXMgaW4gdGhlIGtlcm5lbDoNCj4NCj4g
ICByZWdpc3RlciB1bnNpZ25lZCBsb25nIGN1cnJlbnRfc3RhY2tfcG9pbnRlciBhc20oX0FTTV9T
UCk7DQo+ICAgI2RlZmluZSBBU01fQ0FMTF9DT05TVFJBSU5UICIrciIgKGN1cnJlbnRfc3RhY2tf
cG9pbnRlcikNCj4NCj4gd2hpY2ggKm1pZ2h0KiBhbHNvIHNvbHZlIHRoZSByZWR6b25pbmcgaXNz
dWUuDQoNClNhZGx5IG5vdC7CoCBodHRwczovL2dvZGJvbHQub3JnL3ovY0d4NzRzS0UzDQoNCkdp
dmVuOg0KDQppbnQgcHVzaGYodm9pZCkNCnsNCsKgwqDCoCB1bnNpZ25lZCBsb25nIHJlZ2lzdGVy
IHNwIGFzbSgicnNwIik7DQrCoMKgwqAgdW5zaWduZWQgbG9uZyB4LCB5Ow0KDQrCoMKgwqAgYXNt
ICgibW92cSAkMSwgJTAiIDogIj1tIiAoeCkpOw0KDQrCoMKgwqAgYXNtICgicHVzaGZcblx0cG9w
ICUwIjogIj1yIiAoeSksICIrciIgKHNwKSk7DQoNCsKgwqDCoCByZXR1cm4geCArIHk7DQp9DQoN
CnRoZSBnZW5lcmF0ZWQgY29kZSBpczoNCg0KcHVzaGY6DQrCoMKgwqDCoMKgwqDCoCBtb3ZxICQx
LCAtOCglcnNwKQ0KwqDCoMKgwqDCoMKgwqAgcHVzaGYNCsKgwqDCoMKgwqDCoMKgIHBvcCAlcmF4
DQrCoMKgwqDCoMKgwqDCoCBhZGRswqDCoMKgIC04KCVyc3ApLCAlZWF4DQrCoMKgwqDCoMKgwqDC
oCByZXQNCg0Kc28gdGhlIHJzcCBjbG9iYmVyIGRvZXNuJ3QgcHJldmVudCB0aGUgcHVzaC9wb3Ag
cGFpciBmcm9tIHRyYXNoaW5nIHggaW4NCnRoZSByZWQgem9uZS4NCg0KVGhlIGJ1aWx0aW4gZG9l
cyBjYXVzZSBhIHN0YWNrIGZyYW1lIHRvIGJlIGZ1bGx5IHNldCB1cCwgYW5kIHggdG8gYmUNCmFs
bG9jYXRlZCB3aXRoaW4gaXQsIHJhdGhlciB0aGFuIGluIHRoZSByZWQgem9uZS4NCg0KRXhwZXJp
bWVudGluZyB3aXRoIHJzcCBjbG9iYmVycyBsZWFkcyB0byBodHRwczovL2dvZGJvbHQub3JnL3ov
czlzY3hyZTE5DQp3aGljaCBkZW1vbnN0cmF0ZXMgKGZvciBnY2MgYXQgbGVhc3QpIGl0IGRvZXMg
Y2hhbmdlIHRoZSBwb3NpdGlvbiBvZg0Kd2hlbiBhIHN0YWNrIGZyYW1lIGdldHMgc2V0IHVwIChp
biB0aGUgY2FzZSB0aGF0IHRoZXJlIGlzIGEgcGF0aCBub3QNCm90aGVyd2lzZSBuZWVkaW5nIGEg
c3RhY2sgZnJhbWUpIGJ1dCBkb2Vzbid0IHVuaWxhdGVyYWxseSBmb3JjZSBhIHN0YWNrDQpmcmFt
ZSB0byBiZSBzZXQgdXAuDQoNCkFzIHN1Y2gsIEknbSBub3Qgc3VyZSBob3cgY3VycmVudF9zdGFj
a19wb2ludGVyIGNhbiB3b3JrIGFzIGludGVuZGVkIGluDQphbGwgY2FzZXMuLi4NCg0KfkFuZHJl
dw0K
