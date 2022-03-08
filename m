Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4C3BA4D1538
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Mar 2022 11:53:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346010AbiCHKyh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Mar 2022 05:54:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243921AbiCHKyg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Mar 2022 05:54:36 -0500
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EFD9227FEF
        for <linux-kernel@vger.kernel.org>; Tue,  8 Mar 2022 02:53:39 -0800 (PST)
Received: by mail-pj1-x1032.google.com with SMTP id p3-20020a17090a680300b001bbfb9d760eso1869085pjj.2
        for <linux-kernel@vger.kernel.org>; Tue, 08 Mar 2022 02:53:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=message-id:date:mime-version:user-agent:subject:to:cc:references
         :from:in-reply-to;
        bh=FPaFIt8z7IJDXLuZKuaKwv3IfEeTs1LXQSxX7Aa3ML0=;
        b=YyIYr+SlA8BTzIN/DwLVTSVvlFGMU55xplwr/dTQMnCyXSxrGK8ISN8IGZT/8u86Zf
         QP+7l61MXkKX7dSJu1sPaL00zLo4ELxXgQOkI/q7HGSAXwVH4KzyPsP/kxDTlhH6wcW0
         pR5/VbWjTwPxYFw1RgV+FLmUPgK6WZbB4HiC8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :to:cc:references:from:in-reply-to;
        bh=FPaFIt8z7IJDXLuZKuaKwv3IfEeTs1LXQSxX7Aa3ML0=;
        b=BoZISQHwLB6x/oPNh1+UPRwMRlhYzyVVBoteQDgHY6L08+uoTOwj1Bl6+dn7aKTLen
         TK64ZDwo0tKaJYjOt0My5GjWFvZMtwysCK7ZvNNAsL5qGENwDtabbMN4DHQ+kGgtR70q
         qdMnWPh+9UjEN8fgZ69mWyRMRWLHMaRYIaua12tRX7A7YHE+vtbLwkrnw7WD5n1oTzYF
         DGom8VeVEH9tiZ69qVHK96NIko13tJi3robYDDHv8yGmFbFocfuh2VTRR7frJ9YqqzpX
         mR57I0mL9hl/hI21ouYruczYCcCuIFeR9MbNW9c1xSDwba29jQsQvWOo7f/3DVYAu6cU
         cJIw==
X-Gm-Message-State: AOAM531vfYow2umJaH+xj/IIEaKqNahjWF7Q6SmQItmvVl8/EebSG8r/
        RiiSZOubo7imQwvARKy6GdDyLxuN8c01HDBA
X-Google-Smtp-Source: ABdhPJwMXN5nUEXOA95/Egr4IGYhbdNTsa4rD2Fki68ae/QjRoeySPFHXsU0oaIxMoqSiOdqi/60Aw==
X-Received: by 2002:a17:90a:ab89:b0:1bc:71a7:f93a with SMTP id n9-20020a17090aab8900b001bc71a7f93amr3966543pjq.111.1646736819380;
        Tue, 08 Mar 2022 02:53:39 -0800 (PST)
Received: from [10.230.33.32] ([192.19.148.250])
        by smtp.gmail.com with ESMTPSA id z5-20020a056a00240500b004e15d39f15fsm19992579pfh.83.2022.03.08.02.53.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 08 Mar 2022 02:53:38 -0800 (PST)
Message-ID: <62c01368-b67f-66af-2e31-d62f4df75b61@broadcom.com>
Date:   Tue, 8 Mar 2022 11:53:35 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
Subject: Re: ftrace bug
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Ingo Molnar <mingo@redhat.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <9a86b2c9-1009-1683-442e-61c5a7dc8cf3@broadcom.com>
 <20220307082450.641ed866@gandalf.local.home>
From:   Arend van Spriel <arend.vanspriel@broadcom.com>
In-Reply-To: <20220307082450.641ed866@gandalf.local.home>
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
        boundary="0000000000002defb905d9b2cba0"
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--0000000000002defb905d9b2cba0
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 3/7/2022 2:24 PM, Steven Rostedt wrote:
> On Mon, 7 Mar 2022 12:26:45 +0100
> Arend van Spriel <arend.vanspriel@broadcom.com> wrote:
> 
>> Hi Steven,
>>
>> I wanted to use FTRACE on an ARM platform and I hit the following
>> warning which results in ftrace bug. This happens upon loading a module.
>> Looking up the warning I suspect the branch target is too far off. The
>> module is quite large and therefor not loaded in the modules section. Is
>> there a way to exclude a module. In ftrace_module_init I see a check for
>> !mod->num_ftrace_callsites. Is there a way to avoid creating ftrace
>> callsites in a module?
> 
> Are you sure it's the size. Just want to make sure that's the reason before
> going with different solutions.

Interpreting the warning statement in insn.c and given the fact that the 
module is loaded at 0xe3xxxxxx instead of kernel module space at 
0xbfxxxxxx I made this assumption, but ....

>>
>> Regards,
>> Arend
>>
>> ------------[ cut here ]------------
>>
>> WARNING: CPU: 2 PID: 1525 at arch/arm/kernel/insn.c:47
>> __arm_gen_branch+0x70/0x78
>>
>> CPU: 2 PID: 1525 Comm: insmod Tainted: P                  4.19.183 #2
>>
>> Hardware name: Generic DT based system
>>
>> [<c02139e4>] (unwind_backtrace) from [<c020d4f8>] (show_stack+0x20/0x24)
>>
>> [<c020d4f8>] (show_stack) from [<c0922aec>] (dump_stack+0x98/0xac)
>>
>> [<c0922aec>] (dump_stack) from [<c0919b98>] (__warn.part.0+0xcc/0xe8)
>>
>> [<c0919b98>] (__warn.part.0) from [<c0919d4c>]
>> (warn_slowpath_null+0x54/0x74)
>> [<c0919d4c>] (warn_slowpath_null) from [<c021225c>]
>> (__arm_gen_branch+0x70/0x78)
>> [<c021225c>] (__arm_gen_branch) from [<c02120e4>]
>> (ftrace_make_nop+0x64/0xec)
>> [<c02120e4>] (ftrace_make_nop) from [<c02ac2b0>]
>> (ftrace_process_locs+0x370/0x4b4)
>>
>> [<c02ac2b0>] (ftrace_process_locs) from [<c02af538>]
>> (ftrace_module_init+0x38/0x3c)
>>
>> [<c02af538>] (ftrace_module_init) from [<c02a47d8>]
>> (load_module+0x18d0/0x2570)
>> [<c02a47d8>] (load_module) from [<c02a56f8>]
>> (sys_finit_module+0xe0/0xf8)
>> [<c02a56f8>] (sys_finit_module) from [<c0201000>]
>> (ret_fast_syscall+0x0/0x58)
>> Exception stack(0xd9b1bfa8 to 0xd9b1bff0)
>>
>> bfa0:                   01170228 00000000 00000003 01170228 00000000
>> beb7ceb3
>> bfc0: 01170228 00000000 beb7cdc4 0000017b 00127010 00000000 00000000
>> 00000000
>> bfe0: beb7cc38 beb7cc28 0001a0dc 00012890
>>
>> ---[ end trace f48808a851a4544a ]---
>>
>> ------------[ cut here ]------------
>>
>> WARNING: CPU: 2 PID: 1525 at kernel/trace/ftrace.c:2034
>> ftrace_bug+0xfc/0x394
> 
> Three should be more content after the "cut here" that is very relevant (I
> hate that cut here, because I constantly need to tell people to show me
> more :-p I need to add a "ftrace bug cut here" line.)
> 
> 
> Could you show me the output right after that.

... here is the output I think you were looking for:

ftrace failed to modify 

[<a82ca82d>] (suspected corrupt symbol) 

  actual:   63:17:16:eb 

Initializing ftrace call sites 

ftrace record flags: 2000000 

  (0) 

  expected tramp: c0211b88 

ftrace failed to modify 

[<6c88ec64>] (suspected corrupt symbol) 

  actual:   72:ab:08:eb 

Initializing ftrace call sites 

ftrace record flags: 2000000 

  (0) 

  expected tramp: c0211b88 

ftrace failed to modify 

[<b1ed303a>] (suspected corrupt symbol) 

  actual:   04:12:04:eb 

Initializing ftrace call sites 

ftrace record flags: 2000000 

  (0) 

  expected tramp: c0211b88 

ftrace failed to modify 

[<eb2fee66>] (suspected corrupt symbol) 

  actual:   d6:7e:00:eb 

Initializing ftrace call sites 

ftrace record flags: 2000000 

  (0) 

  expected tramp: c0211b88

Regards,
Arend

--0000000000002defb905d9b2cba0
Content-Type: application/pkcs7-signature; name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="smime.p7s"
Content-Description: S/MIME Cryptographic Signature

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
XSlOP9s1dqWlRRnnNxV7BVC87lkKKy0+1M2DOF6qRYQlnW4EfOyCToYLAG5zeV+AjepMoX6J9bUz
yj4BlDtwH4HFjaRIlPPbdLshUA54/tV84x8woATuLGBq+hTZEpkZAgMBAAGjggHdMIIB2TAOBgNV
HQ8BAf8EBAMCBaAwgaMGCCsGAQUFBwEBBIGWMIGTME4GCCsGAQUFBzAChkJodHRwOi8vc2VjdXJl
Lmdsb2JhbHNpZ24uY29tL2NhY2VydC9nc2djY3IzcGVyc29uYWxzaWduMmNhMjAyMC5jcnQwQQYI
KwYBBQUHMAGGNWh0dHA6Ly9vY3NwLmdsb2JhbHNpZ24uY29tL2dzZ2NjcjNwZXJzb25hbHNpZ24y
Y2EyMDIwME0GA1UdIARGMEQwQgYKKwYBBAGgMgEoCjA0MDIGCCsGAQUFBwIBFiZodHRwczovL3d3
dy5nbG9iYWxzaWduLmNvbS9yZXBvc2l0b3J5LzAJBgNVHRMEAjAAMEkGA1UdHwRCMEAwPqA8oDqG
OGh0dHA6Ly9jcmwuZ2xvYmFsc2lnbi5jb20vZ3NnY2NyM3BlcnNvbmFsc2lnbjJjYTIwMjAuY3Js
MCcGA1UdEQQgMB6BHGFyZW5kLnZhbnNwcmllbEBicm9hZGNvbS5jb20wEwYDVR0lBAwwCgYIKwYB
BQUHAwQwHwYDVR0jBBgwFoAUljPR5lgXWzR1ioFWZNW+SN6hj88wHQYDVR0OBBYEFKb+3b9pz8zo
0QsCHGb/p0UrBlU+MA0GCSqGSIb3DQEBCwUAA4IBAQCHisuRNqP0NfYfG3U3XF+bocf//aGLOCGj
NvbnSbaUDT/ZkRFb9dQfDRVnZUJ7eDZWHfC+kukEzFwiSK1irDPZQAG9diwy4p9dM0xw5RXSAC1w
FzQ0ClJvhK8PsjXF2yzITFmZsEhYEToTn2owD613HvBNijAnDDLV8D0K5gtDnVqkVB9TUAGjHsmo
aAwIDFKdqL0O19Kui0WI1qNsu1tE2wAZk0XE9FG0OKyY2a2oFwJ85c5IO0q53U7+YePIwv4/J5aP
OGM6lFPJCVnfKc3H76g/FyPyaE4AL/hfdNP8ObvCB6N/BVCccjNdglRsL2ewttAG3GM06LkvrLhv
UCvjMYICbTCCAmkCAQEwazBbMQswCQYDVQQGEwJCRTEZMBcGA1UEChMQR2xvYmFsU2lnbiBudi1z
YTExMC8GA1UEAxMoR2xvYmFsU2lnbiBHQ0MgUjMgUGVyc29uYWxTaWduIDIgQ0EgMjAyMAIMMSnY
h9J/RI6gsHbuMA0GCWCGSAFlAwQCAQUAoIHUMC8GCSqGSIb3DQEJBDEiBCD9X9XvP7LHBv0hBE6L
5ryPRa9XC0R9grdHMAn1nhl0fjAYBgkqhkiG9w0BCQMxCwYJKoZIhvcNAQcBMBwGCSqGSIb3DQEJ
BTEPFw0yMjAzMDgxMDUzMzlaMGkGCSqGSIb3DQEJDzFcMFowCwYJYIZIAWUDBAEqMAsGCWCGSAFl
AwQBFjALBglghkgBZQMEAQIwCgYIKoZIhvcNAwcwCwYJKoZIhvcNAQEKMAsGCSqGSIb3DQEBBzAL
BglghkgBZQMEAgEwDQYJKoZIhvcNAQEBBQAEggEAdxMbFXC2F9C5aybF46OR3vSYcp2XUmR7OyQU
rIZ+aVJkI/+XEPAjd7iiA2TYoBOwdCQGAgZRUGoa3T+f1NrBGUq4om+SbLgdfs/Mwt4DO03/iEzz
FsgelncvixCvek+a8WUUsqvh8He3MA8F3FwBFS6lOtFcZEsYuk0D7pi/dgTypYxxwSK2nxxN1HpC
LumXd/MdFrBJAjucsoJoQW4v6aCbPSwtLS4c2P72Sji1CpaiIT5HLV6pYRqfHMa2dvaI+6bxRK9Z
HYJq4VfVPmcvqGgBCL+UsRe3TpHogqWkNGQbN137Pa1yUtrhQrtStMSh5Mz7AF0ks0258r4ssORh
Jw==
--0000000000002defb905d9b2cba0--
