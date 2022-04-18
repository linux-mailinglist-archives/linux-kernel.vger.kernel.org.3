Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A0273504BB6
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Apr 2022 06:36:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236506AbiDREhm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Apr 2022 00:37:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235907AbiDREhb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Apr 2022 00:37:31 -0400
Received: from mailout3.samsung.com (mailout3.samsung.com [203.254.224.33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6DD02AC
        for <linux-kernel@vger.kernel.org>; Sun, 17 Apr 2022 21:34:52 -0700 (PDT)
Received: from epcas5p4.samsung.com (unknown [182.195.41.42])
        by mailout3.samsung.com (KnoxPortal) with ESMTP id 20220418043450epoutp03ecec8f139bbea81aab8c9e8a6256dee8~m44jVblLV0181001810epoutp037
        for <linux-kernel@vger.kernel.org>; Mon, 18 Apr 2022 04:34:50 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20220418043450epoutp03ecec8f139bbea81aab8c9e8a6256dee8~m44jVblLV0181001810epoutp037
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1650256490;
        bh=T2KJeWBUgD5yl0KL35SrhrAKFzH2l/Y4SUQQeaRzTo0=;
        h=Date:Subject:Reply-To:From:To:CC:In-Reply-To:References:From;
        b=FuPrcY7JjWfGlMNL5impa1W9Cb05Em4ZjUzZu0LzVgpSfKSx3aiD1RAK3hwtGSuFD
         KD3FOx8YXs3hIKysfGX+E3vNYOwhCrODdxTws8UD77yQtvqV/0LuI9WQtW7wmnqxVk
         NHcSV5lfxavudWbu9z1JnZsZoOQHwxK0dSZ/fY/I=
Received: from epsmges5p1new.samsung.com (unknown [182.195.42.73]) by
        epcas5p2.samsung.com (KnoxPortal) with ESMTP id
        20220418043449epcas5p2757d641f87df90f035d4f79a2cae4798~m44ikaplf0923609236epcas5p2A;
        Mon, 18 Apr 2022 04:34:49 +0000 (GMT)
X-AuditID: b6c32a49-b01ff70000001917-26-625cea69bbc8
Received: from epcas5p1.samsung.com ( [182.195.41.39]) by
        epsmges5p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        8E.DA.06423.96AEC526; Mon, 18 Apr 2022 13:34:49 +0900 (KST)
Date:   Mon, 18 Apr 2022 10:04:42 +0530
Message-ID: <747830777.1512786.1650256482294@mail-kr5-3>
Mime-Version: 1.0
Subject: RE: [PATCH 1/1] kallsyms: add kallsyms_show_value definition in all
 cases
Reply-To: maninder1.s@samsung.com
Sender: Maninder Singh <maninder1.s@samsung.com>
From:   Maninder Singh <maninder1.s@samsung.com>
To:     Petr Mladek <pmladek@suse.com>,
        "mcgrof@kernel.org" <mcgrof@kernel.org>
CC:     "rostedt@goodmis.org" <rostedt@goodmis.org>,
        "senozhatsky@chromium.org" <senozhatsky@chromium.org>,
        "andriy.shevchenko@linux.intel.com" 
        <andriy.shevchenko@linux.intel.com>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "wangkefeng.wang@huawei.com" <wangkefeng.wang@huawei.com>,
        "wedsonaf@google.com" <wedsonaf@google.com>,
        "boqun.feng@gmail.com" <boqun.feng@gmail.com>,
        "christophe.leroy@csgroup.eu" <christophe.leroy@csgroup.eu>,
        "swboyd@chromium.org" <swboyd@chromium.org>,
        "ojeda@kernel.org" <ojeda@kernel.org>,
        "ast@kernel.org" <ast@kernel.org>,
        "gary@garyguo.net" <gary@garyguo.net>,
        "mbenes@suse.cz" <mbenes@suse.cz>,
        "ndesaulniers@google.com" <ndesaulniers@google.com>,
        "void@manifault.com" <void@manifault.com>,
        "jolsa@kernel.org" <jolsa@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Vaneet Narang <v.narang@samsung.com>,
        Onkarnath <onkarnath.1@samsung.com>
X-Priority: 3
X-Content-Kind-Code: NORMAL
In-Reply-To: <YlaWxh5qYCe40US7@alley>
X-Drm-Type: N,general
X-Msg-Generator: Mail
X-Msg-Type: PERSONAL
X-Reply-Demand: N
X-CMS-MailID: 20220418043442epcms5p553d88679c5357aaf33b2a4c1dc307ec3
Content-Type: multipart/mixed;
        boundary="----=_Part_1512785_2026329720.1650256482294"
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
X-Brightmail-Tracker: H4sIAAAAAAAAA02Sf1CTdRzH+z7Ps+cZO9GHMc6vaHmQhFDhdlf6rSOvtLjHE0urS0wLZzwB
        tzHWBuqy7pggKPFjEhStiehIcJDDye/ZOpBKZMIWYYBiYE46dijcsBpoxHy2q/9e9/68P9/P
        +/O5Lx8XtpDh/HRFFqtSSOWRpIBouRQT/Wz65J594oGvViCDuYFExYe/xNCs9zqFGpq0GLpR
        NkEhp90NUHe5HkcDHQYSjdYNYWhI5wJoWreAobMnawGqK5rmoYXf7/OQ7egYhqznT5Popxsu
        DHX1nACotdZMIq3nN4COGs+Cl8OYr3OcBHN/uA9jao7NYUy7fpRi8mwjFFNtyWbyuqd4jMV0
        jGQuV84TTFXPDsZe34IxJU0mwJibBgnGXt1NMR7LE9uXvSuIT2Hl6ftZ1bqNewVpf7S+ocwV
        H3SeclA5wBtTCIL4kH4OXtcbyEIg4AtpK4AOVzfuKxB0FLzr+ZvycTCNYOkJN68Q8Bc5BD5s
        C/XJofTbsL1zHvOxkI6AjsoG4LOE0mI417zWJ5N0HDR1XCR8LKK3Qk+1iecbhdNnKJjb08/j
        MgTDygIXwfFK2FrbDHwctBhh1Fnm18PgcP0UFeB7P54EHIvgkZtXcY5D4JjX6tdXwfoLxf7e
        Q9Dl7nu0I6TzALRZA6YN0Fxj8j/6KizUcSFweid0Trj9nsdhxZVzGKcvhcXzt7FA6LaqAEfB
        vOFGXmABz8yMfzADz9fNYdxxTwHo6r8NdGC1/r876v83juPVsHXKgPssOB0DzR3rOPkpWF46
        S3K8HuYUVBAcR8Dyz8apakCZwApWqc5IZdXPKyUK9kCcWpqhzlakxn2QmWEBj75z7JY2MDo2
        HdcFMD7oAmsW22811jtAOKHIVLCRouCimt37hMEpUs3HrCozWZUtZ9VdYCWfiFwe3JvaKBXS
        qdIsVsaySlYVqGL8oPAcLEn+nXpb/K31m5NOz8S+VMde+vWL/I3e8anapKtrBrZkDnnDx52v
        S25O9mq+Fb2iL1oiLtbgzZk7rQVlI7rJ16ry3mt/0Pn54FtpapHjh/l3NAOllk86NttVCbjx
        8J/LExPj/7rSFZQi22CT7QbO/LXXnh6R9lmXHRDvpXfIehNDBrNI251zTU7DtZHsJb9cyJ/f
        +vORuo8uzy18GHKHvTjz/rTEHqu1y5T3hIWK73dJNx30dGoSHnum99Bxz5tnosPmSp7U5n6T
        vDTaxcRPlBRFTLaVyHKNCf2uh3s07kTJg7sV7bTcqNu/y5piLpulPh1u2hRlWfUC75/E7YKF
        bcYXtSPJkYQ6TSqJxVVq6b/xI+1USQQAAA==
X-CMS-RootMailID: 20220413055318epcas5p3df3cdde54a559d4002a74de9f23289f2
References: <YlaWxh5qYCe40US7@alley>
        <20220413055305.1768223-1-maninder1.s@samsung.com>
        <CGME20220413055318epcas5p3df3cdde54a559d4002a74de9f23289f2@epcms5p5>
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

------=_Part_1512785_2026329720.1650256482294
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="utf-8"

Hi,

> 
> With the patch, kallsyms_show_value() might return true even when
> CONFIG_KALLYSMS are disabled. Did you check all users of this API
> that they could handle this?
> 
> For example, the comment in bpf_dump_raw_ok() suggests that
> it might require more kallsyms functionality.
>

Ok, we will check these other callers also, if it causes negative impact at other places.

> static inline bool bpf_dump_raw_ok(const struct cred *cred)
> {
> 	/* Reconstruction of call-sites is dependent on kallsyms,
> 	 * thus make dump the same restriction.
> 	 */
> 	return kallsyms_show_value(cred);
> }
> 
> You should definitely add into CC people from affected subsystems.
> I do not see:
> 
>     + Kees Cook who added/updated most of the callers
>     + BPF people that might require even more kallsyms functionality
>     + kprobe people that using it as well
>

Yes, I thought maintainer.pl has shown all people, but seems caller function owners
also need to be added, I will add  in next revision.



> > +/*
> > + * We show kallsyms information even to normal users if we've enabled
> > + * kernel profiling and are explicitly not paranoid (so kptr_restrict
> > + * is clear, and sysctl_perf_event_paranoid isn't set).
> > + *
> > + * Otherwise, require CAP_SYSLOG (assuming kptr_restrict isn't set to
> > + * block even that).
> > + */
> > +bool kallsyms_show_value(const struct cred *cred)
> > +{
> > +	switch (kptr_restrict) {
> > +	case 0:
> > +		if (kallsyms_for_perf())
> > +			return true;
> > +		fallthrough;
> > +	case 1:
> > +		if (security_capable(cred, &init_user_ns, CAP_SYSLOG,
> > +				     CAP_OPT_NOAUDIT) == 0)
> > +			return true;
> > +		fallthrough;
> > +	default:
> > +		return false;
> > +	}
> > +}
> 
> It is really weird that the function is declared in kallsyms.h
> and implemented in vsprintf.c.
>

Yes it does not look good.
Initially we thought to make it as static inline function in kallsyms.h only.
But as function is little big and it will increase code size, so we added
definition in vsprintf.c, because its alwyas compilable code and also it has
some wrapper APIs for kallsyms.
 
But as you suggested to make a new file, it will be good.

> What about splitting kallsyms.c into two source files where one
> would be always compiled? It would be usable also for the
> spring function introduced by
> https://lore.kernel.org/r/20220323164742.2984281-1-maninder1.s@samsung.com
> 
> It might be something like kallsyms_full.c and/or kallsyms_tiny.c.
>

This patch is not taken by Luis yet in module-tetsing branch.
So what will be the best approach to make new version of this patch ?

A) to make new file kallsyms_tiny.c and add only one definition in that file
and when above patch of spring functions is merged in next we can move definitions
to new file

or

B) we send patch to Luis's branch of module-testing with moving definition(of earlier patch)
to new file and current patch also.

Thanks,
Maninder Singh

------=_Part_1512785_2026329720.1650256482294
Content-Type: application/octet-stream
Content-Disposition: attachment; filename="rcptInfo.txt"
Content-Transfer-Encoding: base64

DQogICA9PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT0NCiAgICAgIFN1YmplY3QgICAgOiBSZTogW1BBVENIIDEvMV0g
a2FsbHN5bXM6IGFkZCBrYWxsc3ltc19zaG93X3ZhbHVlIGRlZmluaXRpb24gaW4gYWxsIGNhc2Vz
DQogICAgICBGcm9tICAgICAgIDogbnVsbA0KICAgICAgU2VudCBEYXRlICA6IDIwMjItMDQtMTMg
MTQ6NTQgIEdNVCs1OjMwDQogICA9PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT0NCiAgICAgICAgICAgICAgICAgIE5h
bWUgICAgICAgICAgICAgICAgVHlwZSAgICAgICAgICBKb2IgVGl0bGUgICAgICAgICAgICAgICAg
ICAgICAgIERlcHQuICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIENvbXBhbnkgICAgICAg
ICAgICAgICAgDQogICA9PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT0NCiAgICAgIE1hbmluZGVyIFNpbmdoICAgICAg
ICAgICAgICAgICBUTyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIFN5c3RlbSBT
L1cgR3JvdXAgL1NSSS1EZWxoaSAgICAgICAgICAgICAgIFNhbXN1bmfCoEVsZWN0cm9uaWNzwqAN
CiAgICAgIG1jZ3JvZkBrZXJuZWwub3JnICAgICAgICAgICAgICBDQw0KICAgICAgcm9zdGVkdEBn
b29kbWlzLm9yZyAgICAgICAgICAgIENDDQogICAgICBzZW5vemhhdHNreUBjaHJvbWl1bS5vcmcg
ICAgICAgQ0MNCiAgICAgIGFuZHJpeS5zaGV2Y2hlbmtvQGxpbnV4LmkuLi4gICBDQw0KICAgICAg
YWtwbUBsaW51eC1mb3VuZGF0aW9uLm9yZyAgICAgIENDDQogICAgICB3YW5na2VmZW5nLndhbmdA
aHVhd2VpLmNvbSAgICAgQ0MNCiAgICAgIHdlZHNvbmFmQGdvb2dsZS5jb20gICAgICAgICAgICBD
Qw0KICAgICAgYm9xdW4uZmVuZ0BnbWFpbC5jb20gICAgICAgICAgIENDDQogICAgICBjaHJpc3Rv
cGhlLmxlcm95QGNzZ3JvdXAuZXUgICAgQ0MNCiAgICAgIHN3Ym95ZEBjaHJvbWl1bS5vcmcgICAg
ICAgICAgICBDQw0KICAgICAgb2plZGFAa2VybmVsLm9yZyAgICAgICAgICAgICAgIENDDQogICAg
ICBhc3RAa2VybmVsLm9yZyAgICAgICAgICAgICAgICAgQ0MNCiAgICAgIGdhcnlAZ2FyeWd1by5u
ZXQgICAgICAgICAgICAgICBDQw0KICAgICAgbWJlbmVzQHN1c2UuY3ogICAgICAgICAgICAgICAg
IENDDQogICAgICBuZGVzYXVsbmllcnNAZ29vZ2xlLmNvbSAgICAgICAgQ0MNCiAgICAgIHZvaWRA
bWFuaWZhdWx0LmNvbSAgICAgICAgICAgICBDQw0KICAgICAgam9sc2FAa2VybmVsLm9yZyAgICAg
ICAgICAgICAgIENDDQogICAgICBsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnICAgQ0MNCiAg
ICAgIFZhbmVldCBOYXJhbmcgICAgICAgICAgICAgICAgICBDQyAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgIFN5c3RlbSBTL1cgR3JvdXAgL1NSSS1EZWxoaSAgICAgICAgICAgICAg
IFNhbXN1bmcgRWxlY3Ryb25pY3MNCiAgICAgIE9ua2FybmF0aCAgICAgICAgICAgICAgICAgICAg
ICBDQyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIFN5c3RlbSBTL1cgR3JvdXAg
L1NSSS1EZWxoaSAgICAgICAgICAgICAgIFNhbXN1bmcgRWxlY3Ryb25pY3MNCiAgID09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PQ0K

------=_Part_1512785_2026329720.1650256482294--
