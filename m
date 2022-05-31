Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E233A538F56
	for <lists+linux-kernel@lfdr.de>; Tue, 31 May 2022 12:56:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343634AbiEaKyx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 May 2022 06:54:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244808AbiEaKyu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 May 2022 06:54:50 -0400
Received: from mail-oa1-x2a.google.com (mail-oa1-x2a.google.com [IPv6:2001:4860:4864:20::2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B310A9AE50
        for <linux-kernel@vger.kernel.org>; Tue, 31 May 2022 03:54:48 -0700 (PDT)
Received: by mail-oa1-x2a.google.com with SMTP id 586e51a60fabf-f2bb84f9edso17765017fac.10
        for <linux-kernel@vger.kernel.org>; Tue, 31 May 2022 03:54:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=ufNUwZxQHasz8wDcoJok8yZozy9zrmIAnzBg9ziXQd8=;
        b=Sxxow1SvLSan4Kqi2GYx50OX/A3QH6MCuAeQEVFiGJ5c/kSeYaQsZ0BgzaCwMMZdBV
         h9taytanJmpZ6lWgNxHZqtH0aCe3bMHKik316TYpxwyQSDpS5iKG9oZxZoePiMOUeC/M
         CtDwcWEckEtmJZ+7GcfI2YGze9N53WDPcq+4qilV0BTFphkT2oENkCYhIbndew8PJabn
         +MvrrETdRIUyUkxHFKzC8eoMiNX2w5XdiOU/sVZM9XyYiy7hBICTLO0jnHA+Q1rFZQaS
         k9skk0YuMhmejWopQkipK/UC9kDkPTculBzdxPkssguZK7KTRj12b8DcYMdj/CGI0TYw
         8Qvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=ufNUwZxQHasz8wDcoJok8yZozy9zrmIAnzBg9ziXQd8=;
        b=gDS1C9OtLaySTsMWdxn28QHC2jMIOq2zg+BhVWLh9U4wL2ULzmh9eoPIQPM/EzvvDu
         8uLgMFNPuBQf1xAz2CJ+VT5/m8Tny++v/RpKwNr+XCwoVxJAC7MsYTc2aYoLcyGWQk5w
         E3oT1TsRLDG7Qj99ESqzOZcgF62yarmsN1i3Wss2QrODe9QGNTIAkpwsxtyL7gZlISmv
         d6Bh0HCUKKsViNDlqxNJIC3S3gd6yOEXrwfNzTCOJZugkCk16TPmrEDfp6FAotYLiSHj
         2kOKoGn0Mww/j81or3hkSAeDFAXZ65edI8KZ4eWLtSD5nZig/YgH+StcobK6DDcXaFEj
         2L+A==
X-Gm-Message-State: AOAM530FUYPfZ74L1Cot19F/GdkxdUP1pG9b9ELJ6eNy51k99I4mAzye
        tu37QgnZosKDtNoRZbF+C4Uxgg==
X-Google-Smtp-Source: ABdhPJwQHsI5V8/7erQebGH5aYKlWhMPruEsL/IRgvQjhTGr4BKrzaU0srmYXruCxKeEaotAi3ti1Q==
X-Received: by 2002:a05:6870:15cc:b0:ee:456f:c1e5 with SMTP id k12-20020a05687015cc00b000ee456fc1e5mr12469710oad.46.1653994486557;
        Tue, 31 May 2022 03:54:46 -0700 (PDT)
Received: from ?IPV6:2804:431:c7ca:e39c:980f:eaf1:7a30:10ef? ([2804:431:c7ca:e39c:980f:eaf1:7a30:10ef])
        by smtp.gmail.com with ESMTPSA id 24-20020aca2818000000b0032c18f04800sm2334846oix.1.2022.05.31.03.54.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 31 May 2022 03:54:46 -0700 (PDT)
Message-ID: <4b83ea18-e106-e7ec-d1d9-daa74aeaf990@linaro.org>
Date:   Tue, 31 May 2022 07:54:43 -0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: PROBLEM: with daemon.c after y2038 on 32-bits Kernel
Content-Language: en-US
To:     Arnd Bergmann <arnd@kernel.org>,
        =?UTF-8?Q?Arnaud_Pana=c3=afotis?= <arnaud.panaiotis@gmx.fr>
Cc:     y2038@lists.linaro.org, libc-alpha@sourceware.org,
        linux-kernel@vger.kernel.org
References: <CAK8P3a0bmE03wJ_iELrAMyFvamwd_r5aLsFBH=6=5YaueO=-kg@mail.gmail.com>
 <CAK8P3a3m5E2-w4sewEnb4WK68T1wduChR6eSUzsaWPicYhKPHQ@mail.gmail.com>
From:   Adhemerval Zanella <adhemerval.zanella@linaro.org>
In-Reply-To: <CAK8P3a3m5E2-w4sewEnb4WK68T1wduChR6eSUzsaWPicYhKPHQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 31/05/2022 05:33, Arnd Bergmann via Libc-alpha wrote:
> (cc correct libc-alpha list, sorry for the typo)
> 
> On Tue, May 31, 2022 at 10:24 AM Arnd Bergmann <arnd@kernel.org> wrote:
>> On 17/05/2022 09:51, Arnaud Panaïotis wrote:
>>> I'm working for a client to generate embedded 32-bits Linux Kernel working after y2038 issue.
>>>
>>> I generated a 5.15 Kernel thought Buildroot with Coreutils 9.0, GCC 11.2.0, Binutils 2.37, Glibc 2.34-9 and CFLAGS  -D_LARGEFILE_SOURCE -D_FILE_OFFSET_BITS=64  -D_TIME_BITS=64.
>>>
>>> I encounter an issue while working with OpenSSH (I initially contacted them before).
>>
>> To clarify: did you build just openssh with  -D_TIME_BITS=64, or did
>> you build the entire user space this way?
>>
>>> After 2038, /usr/sbin/sshd does not create an error but it child does generate this one:
>>> daemon() failed: Value too large for defined data type
>>>
>>> This happend here in sshd.c:
>>>
>>> 2019         /*
>>> 2020          * If not in debugging mode, not started from inetd and not already
>>> 2021          * daemonized (eg re-exec via SIGHUP), disconnect from the controlling
>>> 2022          * terminal, and fork.  The original process exits.
>>> 2023          */
>>> 2024         already_daemon = daemonized();
>>> 2025         if (!(debug_flag || inetd_flag || no_daemon_flag || already_daemon)) {
>>> 2026
>>> 2027                 if (daemon(0, 0) == -1)
>>> 2028                         fatal("daemon() failed: %.200s", strerror(errno));
>>
>> My guess is that there are parts of glibc that are not fully
>> y2038-safe at the moment, but
>> merely provide the interfaces for time64 applications.
>>
>>
>> In the glibc code, I see
>>
>> int
>> daemon (int nochdir, int noclose)
>> {
>> ...
>>                 if ((fd = __open_nocancel(_PATH_DEVNULL, O_RDWR, 0)) != -1
>>                     && (__builtin_expect (__fstat64 (fd, &st), 0)
>>                         == 0)) {
>> ...
>>                              } else {
>>                         __close_nocancel_nostatus (fd);
>>                         return -1;
>>                 }
>>      return (0);
>> }

Thanks for catching it, I have opened a bug report for it [1] and I will fix
and backport to 2.34 and 2.35.

[1] https://sourceware.org/bugzilla/show_bug.cgi?id=29203

>>
>> __fstatat64 (int fd, const char *file, struct stat64 *buf, int flags)
>> {
>>   struct __stat64_t64 st_t64;
>>   return __fstatat64_time64 (fd, file, &st_t64, flags)
>>          ?: __cp_stat64_t64_stat64 (&st_t64, buf);
>> }
>>
>> If I'm reading this correctly, daemon() internally uses the time32
>> version of 'stat', which fails for files with out-of-range timestamps.
>> Are you able to rebuild the ssh binary (or your entire distro, if that's
>> easier) against musl-1.2.x instead of glibc to see if the same thing
>> happens there?
>>
>>        Arnd
>>
>>> To reproduce:
>>>
>>> # date -s "2040-05-12"
>>> # hwclock --systohc
>>> # reboot
>>> # /usr/sbin/sshd
>>>
>>> Note this error occurs only after the reboot, and setting a date before 2038 also require a reboot to remove the error.
>>>
>>> strace and gdb trace linked.
>>>
>>> Let me know if you need additional information.
