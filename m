Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CD6E94E3817
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Mar 2022 05:59:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236619AbiCVE4C (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Mar 2022 00:56:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236572AbiCVE4B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Mar 2022 00:56:01 -0400
Received: from mail-pg1-x533.google.com (mail-pg1-x533.google.com [IPv6:2607:f8b0:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF17D12622
        for <linux-kernel@vger.kernel.org>; Mon, 21 Mar 2022 21:54:34 -0700 (PDT)
Received: by mail-pg1-x533.google.com with SMTP id c11so11809343pgu.11
        for <linux-kernel@vger.kernel.org>; Mon, 21 Mar 2022 21:54:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:user-agent:in-reply-to:references
         :message-id:mime-version:content-transfer-encoding;
        bh=pblxpdrF0kohkN+9AwhzRLZ+2LkZsUhH75tVKqMjGXI=;
        b=mMM53ZZESoD6bptZas136uMSrLsZcO/mkUu+P4P5wps0ahmh8jVK49kbv31FeJvea4
         HrRYuMU4O4Cuyc/HILUdRyyZ+8vvi3rPw67SkP9UPTyJ2uDQ2wLmTnMvVvAv1WwitV7e
         EsfbVjserl+GYyl4DN8SAdJk+V/yk1Kk7Mf4c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:user-agent:in-reply-to
         :references:message-id:mime-version:content-transfer-encoding;
        bh=pblxpdrF0kohkN+9AwhzRLZ+2LkZsUhH75tVKqMjGXI=;
        b=iFsvvhc8yAoH7VgE3F5HXHyuwCL8/LI1/qxREFiImCcROEFFm85BUkqTk3+C0bjg/V
         4Q5Vtu5pSb6eMCldpeZ6zoMUmryi+lbZrVYQKcuIN0s+ZfjL1iV/Lah4qNA9uPBzWAP8
         D/IWD3x9yY6YeEEJIoMjmYSyY+K8sdMaTpOq0o8kd0oNtUc0MPYAd63SNFSFMKxoquE6
         WroQvMSNTrTlBnUpb9WY8Jeep6+zX40+ffbRKL75IMCQ1Ca4nD+W4mw1Fgw7WQxHcFEQ
         3u03MyGOWh21zoQSoY4jVoIPauokf01woXXSDTf2/T2fB9PnXF6MdDgTbCnYbMRiopb8
         CmMg==
X-Gm-Message-State: AOAM533xA56brzpnzyOBZGo5LoH/PHopn5qC3dR7BfPsuebKIQCSVlCd
        sOV6TrUkZiQHieLxN7cup9vMOpJr2jyEYA==
X-Google-Smtp-Source: ABdhPJy8sHcvrw0CVZdqritG0oinkC4GAXZf452V3qDv9AX5QHVz1jsjNxQg1YhYi2B4hmqVihLHlg==
X-Received: by 2002:a63:4c5c:0:b0:383:1b87:2d20 with SMTP id m28-20020a634c5c000000b003831b872d20mr1959090pgl.294.1647924874501;
        Mon, 21 Mar 2022 21:54:34 -0700 (PDT)
Received: from [127.0.0.1] (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id h6-20020a056a00218600b004f65315bb37sm22400787pfi.13.2022.03.21.21.54.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 21 Mar 2022 21:54:34 -0700 (PDT)
Date:   Mon, 21 Mar 2022 21:54:32 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
CC:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [GIT PULL] seccomp update for v5.18-rc1
User-Agent: K-9 Mail for Android
In-Reply-To: <CAHk-=whtmuyBzuHULNWcP3==ixcb8yCb-QVEokZeDJESG_TEbA@mail.gmail.com>
References: <202203210806.78B1156916@keescook> <CAHk-=whtmuyBzuHULNWcP3==ixcb8yCb-QVEokZeDJESG_TEbA@mail.gmail.com>
Message-ID: <CF7E8A5F-F80A-4FF2-8B0A-028C475DD045@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On March 21, 2022 7:45:51 PM PDT, Linus Torvalds <torvalds@linux-foundatio=
n=2Eorg> wrote:
>On Mon, Mar 21, 2022 at 8:07 AM Kees Cook <keescook@chromium=2Eorg> wrote=
:
>>
>> Please pull this tiny seccomp update for v5=2E18-rc1=2E
>
>Well, that *really* didn't work at all=2E
>
>  In file included from samples/seccomp/dropper=2Ec:29:
>  usr/include/linux/ptrace=2Eh:50: warning: "PTRACE_GETREGSET" redefined
>     50 | #define PTRACE_GETREGSET        0x4204
>        |
>   In file included from samples/seccomp/dropper=2Ec:24:
>  /usr/include/sys/ptrace=2Eh:153: note: this is the location of the
>previous definition
>    153 | #define PTRACE_GETREGSET PTRACE_GETREGSET
>        |
>  [=2E=2E=2E]
>
>=2E=2E and a lot of similar warnings=2E

Oh, eww=2E Apologies! That didn't happen for my builders, but yeah, that c=
ode is super fragile anyway, so this just confirms my suspicion that the ch=
anges weren't useful=2E I'll drop it from my tree=2E

--=20
Kees Cook
