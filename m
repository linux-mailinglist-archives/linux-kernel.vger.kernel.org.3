Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2133C591C0B
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Aug 2022 18:56:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239889AbiHMQ4Y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 13 Aug 2022 12:56:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239657AbiHMQ4W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 13 Aug 2022 12:56:22 -0400
Received: from sonic307-55.consmr.mail.gq1.yahoo.com (sonic307-55.consmr.mail.gq1.yahoo.com [98.137.64.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 252992C11A
        for <linux-kernel@vger.kernel.org>; Sat, 13 Aug 2022 09:56:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=netscape.net; s=a2048; t=1660409780; bh=wj6Y2O5mbxZygYcQLeN4Sx234XKcdhd3yk8zV2eGm6M=; h=Date:From:Subject:To:Cc:References:In-Reply-To:From:Subject:Reply-To; b=LnK75uJk7unYJKscw1DVq50vRWF+bZH+0xvS28Bw78xZOmjveW5KHAIxaj//1Zcfz2MSuQ/nd0VbETIJkvvDTrkKviwQJOcVJDWnLSWE7qtqAkHXRanDA1tR8T105cokgULZF8lSoLzg4uWZ00vvEhcCSqOSES9GXzS/OqCAYPEIAAt5R9Hq7QCu1xJm5rndObMkhyTVVT1JdPHW1DfCdKx4UqT+41xKAkBMG2OngnH0YkPyMxAOMnWuw/unk7CBzxcGung3Ye09g9ZFtOUc5c5+qSW9p6o45TvlGWNOzDnzhV8Ccjx+HvQBQ0ZvUpargRpnz1O5W0+lNYad/bdTLA==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1660409780; bh=7b0smHsFI7zwAmGO1JvzaihBfKlALmdXNlhmWAAK8HH=; h=X-Sonic-MF:Date:From:Subject:To:From:Subject; b=AdRkK29aQVyioLwtxNTebxbDpagU4E98QpkYHsG7AqnQ43h5Jre0D0uBM8vU7L/27W/xX6EJBGmQT8+X2WmZuwX10TOzt8E/VBt5CXrv90p8hnlpKctCE2vAu6Ww+VcdrULkL+qqOPTu2YqnprAkUzfDZrO3sRFcbfJU2Ce1OYhQBNx7QeaiY26NCdSRDqqarL8JcEBsKNhzLqrDUTOBS5XZ6HDnCpyItsm6UKEpEntymH2ZSrmGWokq+rksPlQWU9ac/xe20OIdC+5LdzeanBU+pg74wNrttXOjIrzfJoURjkh3IYBrzXmUqgUShbp4WcqEtOhS77N1SQcnxkO4mQ==
X-YMail-OSG: WD35BF0VM1ntu3yvQc3yoQ0..vE2hOtAPGs67EiPV9SV8JzAIIcwfKlbhD4uz4d
 avbcPXHSAg_Onnl9xEhfMF4Y52_q9ybIYEVXV0ZhmmLUIEYPdlVbjZYHw6DATwuyBgdw_EDZiisv
 1vT1YCdVaD0soUkhIbaJDLH0naDKR3MKZHE_owpnaocIK7HKCEHuNhKdonqI.UtDXzH0LYNbqFkE
 la_V63XidZwKMa.JS8NNItNvFMUqQir5J7G2kBVAKMi29qPWTYWzw8ePVjm.18JUEvsX4ub2Rb60
 hPfCPHuboKqeXAejgiiGXzHQM_xuMbyFYo_1i0BZd1qjaPkXnW3CzJDLaKpT2k180KkAcoPVE3F.
 D1cT8gts7M1pLzxI4WoKda5Thc5xzaFRgtkszfH7yHiODtmG3MHjBKyYmTQYqu..njpSDcjUK3eJ
 2kuw0m._L0C_fOrrxHZeirS5Dd0f.uPzYRLwVuNcPmGFawUU6rvpP.yLI3g3McDi7NzxUWgCRcwr
 ZfwBjllViD.hhEpCtOftpVWjVWDxScZeshy6m0AwL70AIkIuK2qlTUjUdgPhhDx3wpCIAxmfTfGb
 p3mQ5BPCUzF.lRMw5EVrYY4UYkUAskZ2OTrRNBpHovD6z5qpgRfWtwsjNWoF7KxeEl5Hq1BNHtEK
 yQShNZVioJSF7EDEki0uqcprI8d42LNbwRjUxxRBZLrUNxkCbxDyYPUXv.dnIgweacMh4vML1GmV
 d5JiPCBrpT2roEcYxr1jBlxU6az6OqEatfIvn_2VbEGyFa9TvH7wN4Q4fVzQNv7K4iZIYLYQqZXY
 KkervGAwybeoptPGsWo_DjYz467lvl8cjD0t0n9CMyYfQZwTazIwY.K2PMDLIz.WLp1jtzOvO934
 KYvbnxQ9am7dyBMUqdlS9zeF.g86atRxEMdIjXBTYcIlt7geRjOn.ZwWv611tdGNGzAPn_KUHvNE
 4oHR8V5yIN3nb4SJ13JxrZ3SJOitJIDQd4vRm7h1ii7gFITiMSWIttdxS65Aliq2zUocmoz7sz4i
 JlDK1MyLhHy6G7sJHQEqYEhWKKhDytUl2LTQblZ28BCI8vMA_jfJnd6N2fdkuvRyxSlIKVJxiRJk
 HoISNkqDb.Sx9VtEkZ8XAEWRmUy_yycgxv_RmAXviPU.xjnqdLQnXr3Ag2Sihmv2BLVOZTLrUHgm
 myFb.A1pmtvdWA.OfcsZ.O3HIan8cnz.YJ1WNHccG52sVJv51ibmTiw_wwt355JVGAS_6Y1E1xgx
 GPJgnayaNwxq69.LCYX32JvgOmoiBaUMNZoiqKFa88H5qH08LE2m6xZWZKQi2HVZ.FNBqshKzncW
 YafLHEy34W7ffBzFUW0hljf0aNE5yqoeQUh.Wv5mmvXncBa59ANwzTVcEZ8VFg.MR6wv9xDUhEdo
 ZBq_nqGx6M4LfInCqhe1NtZXrZLeyvxwQrX4vdn4av5fuc3TXD_v0U6Ka9Sw7MlQT5FJwlSKRJg5
 bt2Ohyt7y5364xw66xQkZTwbHjY7iLi7LjfedvnVd_nAUpTeTN96iz9Sz9YwE53fMxRmgAvUFx6_
 38UoHAMjKkz8fnsGkTCaKDPrm.4xl23Dt8uOIc.jhjmsDbNc7hpyJxGrG88jsN_.jmaV5GQHlyDV
 bDkxwMKU6jyNNk9iJksfN0FuZZPXBFe110tMPEgLlSd58PwBWNv7nGCsA0.tyU5MNGcnDZcMikD_
 8rVNvzzWjgAai_cKk5i_S.n6Di4Xn9SZpwVS3fYNZNB6zeClwbeu91LTj_JNkJJAkBpunORqAcVc
 DhpKTpRFb44qd5.0VMfdzxMlVMobAAtrEzOHt4EK56IyHmiq1_0VXd6NwU5U63CoKUmiVNIVInTY
 Q_KUzSB1RIN_XG4HrfJ52POPZYhoek.WZ8Lx1TFE53_cq2KVYVYZ9AfZCsFQcv51ejKpUIRYR_uf
 UKF3OP7.UK.6BLIbCUkXprQGgkRo17CHPffe.TSkAZUR5dYEp.hJKQFB7Lw6PSFB0ytMsMfqWbhh
 lW3fcmbh7epydMxmmxEPwlbCbBjCPV020EQFROC6SW6UIAQFGd5nYq0xOi9UdGrI1.IxVYZjeNh3
 JzdYt_bc0iRrqfx8N9gmy2dgyCFM0GfD8MbaLRXKmiZfIPcsAdDvL8T7eeeeSOr_YSKm6zaWWVcl
 4sK7D3rRY3BqFtcuvUPx0kQZ2gXNIhlmpNFjnFbhYVyWNnyPvV7lr6KNuKVcsmomnNUaBTVKDG60
 YoJqeuL6Lit9_
X-Sonic-MF: <brchuckz@aim.com>
Received: from sonic.gate.mail.ne1.yahoo.com by sonic307.consmr.mail.gq1.yahoo.com with HTTP; Sat, 13 Aug 2022 16:56:20 +0000
Received: by hermes--production-ne1-6649c47445-znbvb (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID c035781e424b923762e1bcb1fb8d4940;
          Sat, 13 Aug 2022 16:56:14 +0000 (UTC)
Message-ID: <a0ce2f59-b653-fa8b-a016-1335f05c86ae@netscape.net>
Date:   Sat, 13 Aug 2022 12:56:12 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.1.2
From:   Chuck Zmudzinski <brchuckz@netscape.net>
Subject: Re: [PATCH 0/3] x86: make pat and mtrr independent from each other
To:     Thorsten Leemhuis <regressions@leemhuis.info>,
        Juergen Gross <jgross@suse.com>,
        xen-devel@lists.xenproject.org, x86@kernel.org,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
Cc:     jbeulich@suse.com, Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Pavel Machek <pavel@ucw.cz>, Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        regressions@lists.linux.dev
References: <20220715142549.25223-1-jgross@suse.com>
 <efbde93b-e280-0e40-798d-dc7bf8ca83cf@leemhuis.info>
Content-Language: en-US
In-Reply-To: <efbde93b-e280-0e40-798d-dc7bf8ca83cf@leemhuis.info>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Mailer: WebService/1.1.20531 mail.backend.jedi.jws.acl:role.jedi.acl.token.atz.jws.hermes.aol
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/17/22 3:55 AM, Thorsten Leemhuis wrote:
> Hi Juergen!
>
> On 15.07.22 16:25, Juergen Gross wrote:
> > Today PAT can't be used without MTRR being available, unless MTRR is at
> > least configured via CONFIG_MTRR and the system is running as Xen PV
> > guest. In this case PAT is automatically available via the hypervisor,
> > but the PAT MSR can't be modified by the kernel and MTRR is disabled.
> > 
> > As an additional complexity the availability of PAT can't be queried
> > via pat_enabled() in the Xen PV case, as the lack of MTRR will set PAT
> > to be disabled. This leads to some drivers believing that not all cache
> > modes are available, resulting in failures or degraded functionality.
> > 
> > The same applies to a kernel built with no MTRR support: it won't
> > allow to use the PAT MSR, even if there is no technical reason for
> > that, other than setting up PAT on all cpus the same way (which is a
> > requirement of the processor's cache management) is relying on some
> > MTRR specific code.
> > 
> > Fix all of that by:
> > 
> > - moving the function needed by PAT from MTRR specific code one level
> >   up
> > - adding a PAT indirection layer supporting the 3 cases "no or disabled
> >   PAT", "PAT under kernel control", and "PAT under Xen control"
> > - removing the dependency of PAT on MTRR
>
> Thx for working on this. If you need to respin these patches for one
> reason or another, could you do me a favor and add proper 'Link:' tags
> pointing to all reports about this issue? e.g. like this:
>
>  Link: https://lore.kernel.org/regressions/YnHK1Z3o99eMXsVK@mail-itl/
>
> These tags are considered important by Linus[1] and others, as they
> allow anyone to look into the backstory weeks or years from now. That is
> why they should be placed in cases like this, as
> Documentation/process/submitting-patches.rst and
> Documentation/process/5.Posting.rst explain in more detail. I care
> personally, because these tags make my regression tracking efforts a
> whole lot easier, as they allow my tracking bot 'regzbot' to
> automatically connect reports with patches posted or committed to fix
> tracked regressions.
>
> [1] see for example:
> https://lore.kernel.org/all/CAHk-=wjMmSZzMJ3Xnskdg4+GGz=5p5p+GSYyFBTh0f-DgvdBWg@mail.gmail.com/
> https://lore.kernel.org/all/CAHk-=wgs38ZrfPvy=nOwVkVzjpM3VFU1zobP37Fwd_h9iAD5JQ@mail.gmail.com/
> https://lore.kernel.org/all/CAHk-=wjxzafG-=J8oT30s7upn4RhBs6TX-uVFZ5rME+L5_DoJA@mail.gmail.com/
>
> Ciao, Thorsten (wearing his 'the Linux kernel's regression tracker' hat)
>
> P.S.: As the Linux kernel's regression tracker I deal with a lot of
> reports and sometimes miss something important when writing mails like
> this. If that's the case here, don't hesitate to tell me in a public
> reply, it's in everyone's interest to set the public record straight.
>
> BTW, let me tell regzbot to monitor this thread:
>
> #regzbot ^backmonitor:
> https://lore.kernel.org/regressions/YnHK1Z3o99eMXsVK@mail-itl/

Hi Thorsten,

This appears stalled again and we are now over three months
from the first report of the regression, The only excuse for
ignoring your comments, and other comments on the patches
in this patch series for this long a time is that the patch series
for some reason cannot be considered a true regression. If this is a
regression, then, IMHO, this needs to have a higher priority by the
maintainers, or the maintainers need to explain why this regression
cannot be fixed in a more timely manner. But continued silence
by the maintainers is unacceptable, IMHO. This is especially true
in this case when multiple fixes for the regression have been
identified and the maintainers have not yet clearly explained why
at least a fix, even if temporary, cannot be applied immediately
while we wait for a more comprehensive fix.

At the very least, I would expect Juergen to reply here and say that
he is delayed but does plan to spin up an updated version and include
the necessary links in the new version to facilitate your tracking of
the regression. Why the silence from Juergen here?

Best regards,

Chuck
