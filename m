Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 64C815A2372
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Aug 2022 10:45:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245538AbiHZIpo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Aug 2022 04:45:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245323AbiHZIp1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Aug 2022 04:45:27 -0400
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.17.10])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3819442ADE;
        Fri, 26 Aug 2022 01:45:25 -0700 (PDT)
Received: from mail-ej1-f52.google.com ([209.85.218.52]) by
 mrelayeu.kundenserver.de (mreue108 [213.165.67.113]) with ESMTPSA (Nemesis)
 id 1N17cq-1pPP8j3jgY-012YGq; Fri, 26 Aug 2022 10:45:23 +0200
Received: by mail-ej1-f52.google.com with SMTP id bj12so1813878ejb.13;
        Fri, 26 Aug 2022 01:45:23 -0700 (PDT)
X-Gm-Message-State: ACgBeo0eQrJQyXEjSWFSteTMgkw05oxWIXvKZd9oYYfrRCXoOoAtii4i
        wVL+4r3i708ppcEF4ezfH/kA5XEntIeQhrEkK6s=
X-Google-Smtp-Source: AA6agR6rhA0U++DrfPtjQ5ooNZ/yKGtZYIy6GJv0mHxh03+9mAoj11Jd7qH4DYueP/o4Zfu5g9vzB6C+5LWRmCcuVk0=
X-Received: by 2002:a17:907:7610:b0:73d:afe8:9837 with SMTP id
 jx16-20020a170907761000b0073dafe89837mr4876186ejc.606.1661503523457; Fri, 26
 Aug 2022 01:45:23 -0700 (PDT)
MIME-Version: 1.0
References: <YwgCrqutxmX0W72r@gmail.com>
In-Reply-To: <YwgCrqutxmX0W72r@gmail.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Fri, 26 Aug 2022 10:45:07 +0200
X-Gmail-Original-Message-ID: <CAK8P3a3LnqdJ7bp+wjwUyb=7rQqL7W4nina-yQ5_Ff=XtaTr+A@mail.gmail.com>
Message-ID: <CAK8P3a3LnqdJ7bp+wjwUyb=7rQqL7W4nina-yQ5_Ff=XtaTr+A@mail.gmail.com>
Subject: Re: Should Linux set the new constant-time mode CPU flags?
To:     Eric Biggers <ebiggers@kernel.org>
Cc:     x86@kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org,
        Adam Langley <agl@google.com>,
        "Jason A. Donenfeld" <Jason@zx2c4.com>,
        Ard Biesheuvel <ardb@kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:y8v7NCKt3/qd+CLAHuwY/idNGwPwWEXDVyOl5SiFKJ5hYYOB7QX
 c1x0lkHA9pMS33sYv5LJtjITNykxYgyEH1b9+YaBrxdX3tkGqATmqazkEpwxRFLJRBXx40B
 XPea1Qwtt6z8FqAXDdzvdGY5W2RxeknNEfQjjzYaqdIu/fMi/e61sxW5u+2G8JKpsAZBoKK
 EWTIo5fOdJ4B2pL59r1KA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:urVfv5jJgKE=:be9xpUJV5ORYS66cNv2/gT
 b4GhqQ/I5/AOWN7Xi6GN3Ii6J87oPZckL1grLRWeIZUztrUb+nLo8ct4aebh8PK8e1F2YmVgl
 ceImpcTi0ftNPUijhLZNCyXO4ZozA8LGxe2BkvRr9aGb0nHTFg61APZbt8VRMOhig8AVqlfON
 AOZFYLdnyyT78wqS5AjLbECaF0CKGVkuNKDqAe4Il0XXbZoJzwVJTeX6TR5XxFK6Go+nVf9Fp
 2YPCYE+kmd2pFK789WMCnSnvQOV5bWAgJtCiqAWP0PomJUiB0kXzaeE7EALOYEYcS1fzokv4H
 VtSVi22puoICoHjM+Fi+l5qe6RYGOpD79Ytb3/FkMznLGJ48Y3p8gYFS9V8JZHhUNB3O0mguX
 +H8qN3k1m3bPxN5eTTCheQsUTPMb4yU0grH34jf/n7qpoOb8IRTKt5nRj7reIcfL26LtvCNw5
 u3uFzkeTL7I+4vPtLeCy/XRHXmdFAOwOjnJf5TIWUyJZW9tQpMx7LrwA01W4RxV87/jmFWLmH
 QNGYtrwxzqXpsoOH2hwClivK0y2JIrngjtn2+nBDAXNq1A5JjySlQ6i+FlvRmdEB1Z5nOhJSd
 bJJWzKi9bg63NBDvHqWUhMskSS6Mi61ja+Mp64NmNDXEOSYOo0ZtIqb2QPGlovB3EPM4P4JT0
 jsMFTLUWBC6ezJfxacPtYNz7PXUxkkgXJ/ZVwhMumoJyYFi9SlQmMDr5SP+qr7i6NhbobR62O
 L0xwzXuY9IRilcIQVi5EVwmYvk8zk+2ipDu5hA==
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 26, 2022 at 1:15 AM Eric Biggers <ebiggers@kernel.org> wrote:
>
> For arm64, it's not clear to me whether the DIT flag is privileged or not.  If
> privileged, I expect it would need to be set by the kernel just like the Intel
> flag.  If unprivileged, I expect there will still be work to do in the kernel,
> as the flag will need to be set when running any crypto code in the kernel.

7206dc93a58f ("arm64: Expose Arm v8.4 features") added the feature bit for
Armv8.4+ processors. From what I can tell from the documentation and the
kernel source, I see:

- if the feature is set in HWCAP (or /proc/cpuinfo), then the instruction DIT
  register is available in user space, and sensitive code can set or clear the
  constant-time mode for the local thread.
- On CPUs without the feature (almost all ARMv8 ones), the register should
  not be touched.
- The bit is context switched on kernel entry, so setting the bit in user space
  does not change the behavior inside of a syscall
- If we add a user space interface for setting the bit per thread on x86,
  the same interface could be supported to set the bit on arm64 to save
  user space implementations the trouble of checking the feature bits
- the in-kernel crypto code does not set the bit today but could be easily
  changed to do this for CPUs that support it, if we can decide on a policy
  for when to enable or disable it.

        Arnd
