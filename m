Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 77C625781D3
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Jul 2022 14:13:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234860AbiGRMM4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Jul 2022 08:12:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234891AbiGRMMs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jul 2022 08:12:48 -0400
Received: from sonic310-20.consmr.mail.gq1.yahoo.com (sonic310-20.consmr.mail.gq1.yahoo.com [98.137.69.146])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6179C24942
        for <linux-kernel@vger.kernel.org>; Mon, 18 Jul 2022 05:12:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=netscape.net; s=a2048; t=1658146366; bh=atlZN2FUSXZXKTvDhchlBWTqI7nDGrNSzBLjMzlP6Ok=; h=Date:Subject:To:Cc:References:From:In-Reply-To:From:Subject:Reply-To; b=QOawXelZ45CqVl1OWqXPgLoUTPoLrelvcnM9EG5ldTJ973MYeUHNUNivK4jg+edyEmF2U9+YNUwecdlVZb8AboOG/kjR1ZUc3zU21bXO8l/JySqlPB8+nL8zbFxjJOgbXwst/HJxrmvL18Xn0E+u5Q9UEvApCbMcy2odK65xdNYAVyaYVZ+gej1D5DreKOJvNRiNZQtxKC3RfFwH4J2FrK24pnYJcT61a/A58YnpRxzTt3bkT6arcTtH1q8A7ylGOZXF0gijsLe6IS8g/ZpIk81AEvExrwdySyESHALBp6EM82QGV5XY8muXL3snJmt02BJHXpl2u3nIwCkLxa825A==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1658146366; bh=+UuasDPfRrVExKfDj5duhoMrnEi7oPm6MX1wrmN9uIO=; h=X-Sonic-MF:Date:Subject:To:From:From:Subject; b=EVFCPysrHYL5vLJE0D6vsEGDQJkWGsSOEhOhp5T+VoImDQ2jqKsP9D3iDcB4vvUSizy5XtcOY//qLYdocAthquM7sxqMO6+mXYc1PoQkY5AWZOtNnz5hDtjEaZ7tNA8EflTD8GMjyTw3WgH8O13woFSgwnYZqKhQg2GXvfF9Ymce1jALgZwBdUmPGF0szF4pfPVdBu1q4+YVh8HsEOMooHdSForFocMYWAaMSU3Mw3yyHAikA4kfxOz4L+/U+WTWknWy61VCz1w+R2MqN52x6YkpoTqCkoLFzPzNDgGfIi7bBTt/HcjkZqoeNmPhYrXsKiO5Hj1mUH+LJRovt0FJlw==
X-YMail-OSG: 1QYvBngVM1koeAkrfz803RYjbFmsXqT_d_FpYOes5XUHDyB.re2tShb2SkhmTAQ
 _K3hy0Kwwp2XvsWR.1OcSyctFM1f7wARVD78ZqA2FfQz0Q8FtBHO5V66SUuOs4HdMgHWlSR.0T8Z
 ycLxHyXP8_cmQt6q8wcOUgiSOBoW_vV8rof72p4qKnRKDWQRQDGaxYf.Q.QP7E68e.4_B4aYqn.f
 JrC7DGzUPp0_5UM6r2cpQoxcEcFcWos79qvxHVwUdAQDx4UqqG8qG5vzmyU.FPj4QIl5exolZzFb
 Ut1L6LjlBpmJ.oqgS6tUcCU7z9mfj3eefhQmCwI97zXtPnol47vq0j.6acEO8NrdNOPlDD22bZuz
 4E2R_SDNKd017qnL3CGdQXhRBOpCOMe0kDptbu8ULXQl5SXDR5_76ZEvWSw_OsOrrasL2vYcmWUv
 Al.LJd5uL0s9yxxHx5BcL8OGyn_6_qy8m6dFKstTSC6qt0zoiLs9I96QcNVDOPFW8xjeT38a6qAk
 VgDIg.BH2VTgCAGV0jESfJaE1HpIs2L22YUS2udvVXP3yq6txTvjrFIL5uNZA_IwzWNCbjOpmFm4
 .DY66Zh82ke6nIxsutPEjVGSwPIttFZ607iPCr.prdBbAgbA4yTD9U9h_UwmjYHL.3C.uqGIg37L
 zOSUY8EJ_tvEgoNHfGkNSp5tDfByKJYNXspvl3HgPul168vr2nsR0U8PVXcWq01HerJ9lsE5o.pw
 twlLNUAUZNLz3KhIdkm3b5yW.iXNxqUQa9lu_7xW8JRprCYGk1fsojIAZ66MUNZwJOeCBDK6DLXu
 abPrIekssp3_yihxLvNU4E7s7ROeVXjiv5Z7ZeI.uPAQfAvCo8iUH.EwsAnpPMyLrNlzFXtLZgGZ
 l2V0un1mbnEoWpUAKQ3tN6F1fSA5L6eUkjPRnfvX0l24_NSBc2kRjFkV1As3rxtiCzVdDQXFAav0
 8EJAvpNBHF27uE1kJgCTc4A5pdNCNotzIULGgKn4lMx3fvdSuLSGzkfPp0m4HP1Nfk0VaR25m6Aq
 5KG08aqigYzKbi7SKnFkCK3MU84S_5f3RT89N2mjQRj78KYFmAwo7S8rP4r0N2KRyH2Chx_E1_KF
 dsov52hDF1VgAJhK32gxhnp.mqXySNFUlNlQQ8YpDl6OybmHhOz8A8_CU6tL6NuoCWEQiB_xqpKz
 RHo8XOyUTf9XGAjznwAju8IINwyOffs0nHQcV88o_uVJs_1fgcfzXDNu1aVGXo0DBEiw.60r6cZH
 ZaeZE1P9.O.h6vaBAFZq4XGojwzXXSugPnMR4y68h3ofGYy5LoQBD0eBLrfH70Z.2wXMK0joktx1
 9g65Baui19T.bYXVggiDJ2Kq38dQmTeRQMLfjBVgvbVv3x3.WQokYCeYyfZug0FKhYH3qh88lBpj
 ac2mpn0ZwdB6Srety67YpnscSdo.hlb.XQtIKPB9eU8d5qxXsX9vDMSZ9P2zMV4rAr_JElKo4HZT
 SxhLjk5yc8K07.ksNRoijfecLpaO9MU5ZTnsN4SWkwcFbFRLy8agga67vLWs2zOa4OufmhGlKdPF
 vTGPmN7e7ho9j_jf6FUc8aXwoHuTGUpBYP.gLfjiZ6d7tC_mlLGDd8SXNzETkOoVXs7CNxone6OA
 .2lP2k_1sa9eE3iB6jPJI6vtOf.zVmkSxfEFpIKWzL.JMcwimv8a75o04CRWnF93FDHYp.uc22mN
 FlOLpGyGlg2xtdzuuYU6HIGJGF1FM3Zf4ndSLm48Zaxi5Cnib2ZrYUtEpmOhBkVtq4oeFIG5P1pd
 .Oqw6sr5kZt_cy1scvBqAjcM3IDZbzhnFaFUShd6hR2sYK17wBAMgpcDc6nukTkHPi4EwzuislCn
 pu3O7nKt2UNxahLPE5.Wf6PC_o5Xau2k8emEygINaJD_immxf3vMO4z0oawbatArq1NhcIBu9Ayf
 cpy9l9lv46fXgbjtYd94Mek4Wm.dFQy_XAAVz8tYVSFEJEmXiXnxdrP2tqzRSvg6hy20w.L.Iaws
 BNQijkFHbF5kuphUA81hWOFRjmily5Bs6MmiP6cdEdIwXRtJNVY3lL9t89YABJu_naD2wqwEw6fG
 N0dOPN96H0TM__tQNdkxF4MYwv8G8RXDDW29pBZlTdeUWqzYmsGkWTJsD3DRF49PAnUNxrph3hgE
 THr2W7ZiTCFeQGVPrh0U.zUHbEGELJk8xu2PQZa1qMgWCaFQBmKh9fcrnHWss4AIiCINskLRkXET
 CqewlCMPm6E3VmSsraDZjeUip5lfWoJ1t4ykoBu6tSjCEsgOrwHsONc805QEZ2OU4Hkia.4F37J.
 6HsQ1kg--
X-Sonic-MF: <brchuckz@aim.com>
Received: from sonic.gate.mail.ne1.yahoo.com by sonic310.consmr.mail.gq1.yahoo.com with HTTP; Mon, 18 Jul 2022 12:12:46 +0000
Received: by hermes--production-ne1-7864dcfd54-5p9s9 (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID 78ba00f741e12bff5d9e9867188b86dc;
          Mon, 18 Jul 2022 12:12:45 +0000 (UTC)
Message-ID: <e2113207-623e-77cd-9e1c-fffe951bcd8d@netscape.net>
Date:   Mon, 18 Jul 2022 08:12:42 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v2] Subject: x86/PAT: Report PAT on CPUs that support PAT
 without MTRR
Content-Language: en-US
To:     Jan Beulich <jbeulich@suse.com>,
        Thorsten Leemhuis <regressions@leemhuis.info>,
        Borislav Petkov <bp@alien8.de>
Cc:     Dave Hansen <dave.hansen@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Juergen Gross <jgross@suse.com>,
        xen-devel@lists.xenproject.org, linux-kernel@vger.kernel.org
References: <9d5070ae4f3e956a95d3f50e24f1a93488b9ff52.1657671676.git.brchuckz.ref@aol.com>
 <9d5070ae4f3e956a95d3f50e24f1a93488b9ff52.1657671676.git.brchuckz@aol.com>
 <5ea45b0d-32b5-1a13-de86-9988144c0dbe@leemhuis.info>
 <56a6ab5f-06fb-fa11-5966-cb23cb276fa6@netscape.net>
 <d3555a74-d0cb-ca73-eb2e-082f882b5c81@suse.com>
 <1309c3f5-86c7-e4f8-9f35-e0d430951d49@netscape.net>
 <764ea65f-269a-6f32-c780-cbdd7cf09120@suse.com>
 <8eb62e12-17cf-cce6-666a-8ebb7915f461@netscape.net>
 <80b413d1-287a-61a3-656d-9ea680f00a90@suse.com>
From:   Chuck Zmudzinski <brchuckz@netscape.net>
In-Reply-To: <80b413d1-287a-61a3-656d-9ea680f00a90@suse.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Mailer: WebService/1.1.20407 mail.backend.jedi.jws.acl:role.jedi.acl.token.atz.jws.hermes.aol
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/18/2022 7:39 AM, Jan Beulich wrote:
> On 18.07.2022 13:31, Chuck Zmudzinski wrote:
> > On 7/18/2022 2:07 AM, Jan Beulich wrote:
> >> On 15.07.2022 21:53, Chuck Zmudzinski wrote:
> >>> Two things I see here in my efforts to get a patch to fix this regression:
> >>>
> >>> 1. Does Xen have plans to give Linux running in Dom0 write-access to the
> >>> PAT MSR?
> >>
> >> No, as this is not technically feasible (all physical CPUs should run
> >> with the same value in the MSR, or else other issues arise).
> >>
> >>> 2. Does Xen have plans to expose MTRRs to Linux running in Dom0?
> >>
> >> Yen does expose MTRRs to PV Dom0, but via a hypercall mechanism. I
> >> don't think there are plans on the Xen side to support the MSR
> >> interface (and hence to expose the CPUID bit), and iirc there are
> >> no plans on the Linux side to use the MTRR interface. This also
> >> wouldn't really make sense anymore now that it has become quite
> >> clear that Linux wants to have PAT working without depending on
> >> MTRR.
> > 
> > I am not so sure about that, given what Borislav Petkov
> > said when commenting on your patch here:
> > 
> > https://lore.kernel.org/lkml/YsRjX%2FU1XN8rq+8u@zn.tnic/
> > 
> > Specifically, Borislav Petkov wrote on Tue, 5 Jul 2022 18:14:23 +0200:
> > 
> > Actually, the current goal is to adjust Xen dom0 because:
> > 
> > 1. it uses the PAT code
> > 
> > 2. but then it does something special and hides the MTRRs
> > 
> > which is not something real hardware does.
> > 
> > So this one-off thing should be prominent, visible and not get in the
> > way.
> > 
> > --------------end of Borislav Petkov quote-----------
>
> And then, a day later, he said
>
> "So I'm being told that it would be generally beneficial for all kinds of
>  virtualization solutions to be able to support PAT only, without MTRRs
>  so it would be interesting to see how ugly it would become to decouple
>  PAT from MTRRs in Linux..."

What if it proves to be too ugly to decouple PAT from MTRRs? Then
I doubt that "Linux wants to have PAT working without depending
on MTRR." We can hope that Juergen's work to decouple PAT from
MTRRs is not so ugly that it cannot be done, but that is by no means
certain at this point. At the very least, this means the fix to the
regression
will be at least delayed considerably, and possibly this means this
regression will never be fixed in the mainline kernel release.

Chuck
