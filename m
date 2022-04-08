Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 634D74F8C31
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Apr 2022 05:26:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233949AbiDHDTY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Apr 2022 23:19:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233933AbiDHDTP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Apr 2022 23:19:15 -0400
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07333147ACF
        for <linux-kernel@vger.kernel.org>; Thu,  7 Apr 2022 20:17:10 -0700 (PDT)
Received: by mail-wr1-x42c.google.com with SMTP id a2so1639305wrh.5
        for <linux-kernel@vger.kernel.org>; Thu, 07 Apr 2022 20:17:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=wgf4acvi/Fu9XD9s+6RSDDIAYNvp3TV3xYDZvoRiizI=;
        b=mThG2uh+y9NDaZQDzAG5owkYCagP9uLPIfSPzXCp+nKbUmTaX55IXCNvcV0ynpXMD5
         pAHWlaRqJt6OxSIyvTHWkVMPY6Hr+7lve1L85FRbXefX7geoX83QKFiTNC48/tlkcxMN
         yYExjDmMj+njeiqBmaVadv4cWM2OPTvR2WvG4aO2yj8inDpaIiTq5pH5zsy0gGJ1T5Et
         9591C/IN+bNUR10WjLg3/HvXQOh4RHqFTYg0TZb9UH0DLhC+cIhzXAj90eRjJ8hVNlbK
         uIkcjlkCQca837SQ2J/0VvFd/9tTO/dlcyL4jPxbK58UlPFDd4zrEei3WcSiNQacHRvA
         y27Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=wgf4acvi/Fu9XD9s+6RSDDIAYNvp3TV3xYDZvoRiizI=;
        b=nqsZMEYo2Jj7SXXSFPCJyiKR/puhdrLzparPT74QBG58z5ASsNw+n+up/L0nO83lUO
         Srmo8vRMq3wh4CcByF3fncrLOJrcM1aaozJTOTJunBzXdxffEFVb/WlpAM1ywuMdUJXM
         RcmbdhOlzNPCApVR8I2xUaGKjJKue5k1VF79mzA+HYsFkAmCC/LnzRMIofs5tKcAjvIj
         sHZXcg4yJd+wBjcpIZEYWC0vcq7nm+z5iN6m9qBPkGX3fcyGgQ51Wpa9cyy5F8dOJPZ5
         gCEAjEmiVZfTwNirgkbE7t2JV8iTGK18bo7yBlQPsJLdHV+7Ob4iS58x67M2KulL+k2h
         HRWA==
X-Gm-Message-State: AOAM532HiBcf9eTrdZBO8RiAM1RYOst57lDDq+54XHp0giw4v0WqEQlb
        EgHCknosYw6bBshnBjwSY4aSbsWq77mcvttExc00rq/VBFjouA==
X-Google-Smtp-Source: ABdhPJxznHvZLDULU3/WobBuRLKXZlgy2+OHkripz1WPu9KDNZRf6hiw54kNxuN7jCreRq0CUXQmdUwbTDEM0xgjwv8=
X-Received: by 2002:adf:ed09:0:b0:206:81c:1eda with SMTP id
 a9-20020adfed09000000b00206081c1edamr13735754wro.430.1649387828414; Thu, 07
 Apr 2022 20:17:08 -0700 (PDT)
MIME-Version: 1.0
References: <20220407193902.1981605-1-dlatypov@google.com>
In-Reply-To: <20220407193902.1981605-1-dlatypov@google.com>
From:   David Gow <davidgow@google.com>
Date:   Fri, 8 Apr 2022 11:16:57 +0800
Message-ID: <CABVgOSm-sDx8G0iphFXEgnsF-c9eu++bxtXjhOM_WHx-mkRiTA@mail.gmail.com>
Subject: Re: [PATCH] kunit: tool: cosmetic: don't specify duplicate kunit_shutdown's
To:     Daniel Latypov <dlatypov@google.com>
Cc:     Brendan Higgins <brendanhiggins@google.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        KUnit Development <kunit-dev@googlegroups.com>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        Shuah Khan <skhan@linuxfoundation.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL,
        USER_IN_DEF_SPF_WL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 8, 2022 at 3:39 AM Daniel Latypov <dlatypov@google.com> wrote:
>
> Context:
> When using a non-UML arch, kunit.py will boot the test kernel with these
> options by default:
> > mem=1G console=tty kunit_shutdown=halt console=ttyS0 kunit_shutdown=reboot
>
> For QEMU, we need to use 'reboot', and for UML we need to use 'halt'.
> If you switch them, kunit.py will hang until the --timeout expires.
>
> So the code currently unconditionally adds 'kunit_shutdown=halt' but
> then appends 'reboot' when using QEMU (which overwrites it).
>
> This patch:
> Having these duplicate options is a bit noisy.
> Switch so we only add 'halt' for UML.
>
> I.e. we now get
> UML: 'mem=1G console=tty console=ttyS0 kunit_shutdown=halt'
> QEMU: 'mem=1G console=tty console=ttyS0 kunit_shutdown=reboot'
>
> Side effect: you can't overwrite kunit_shutdown on UML w/ --kernel_arg.
> But you already couldn't for QEMU, and why would you want to?
>
> Signed-off-by: Daniel Latypov <dlatypov@google.com>
> ---

Thanks so much for fixing this: it had been quietly bugging me for a while.

This looks pretty good as is, but I have a few suggestions for
extending it which could be nice to have. I've put them inline below.

Either way,
Reviewed-by: David Gow <davidgow@google.com>

>  tools/testing/kunit/kunit_kernel.py | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/tools/testing/kunit/kunit_kernel.py b/tools/testing/kunit/kunit_kernel.py
> index 483f78e15ce9..9731ceb7ad92 100644
> --- a/tools/testing/kunit/kunit_kernel.py
> +++ b/tools/testing/kunit/kunit_kernel.py
> @@ -158,7 +158,7 @@ class LinuxSourceTreeOperationsUml(LinuxSourceTreeOperations):
>         def start(self, params: List[str], build_dir: str) -> subprocess.Popen:
>                 """Runs the Linux UML binary. Must be named 'linux'."""
>                 linux_bin = os.path.join(build_dir, 'linux')
> -               return subprocess.Popen([linux_bin] + params,
> +               return subprocess.Popen([linux_bin] + params + ['kunit_shutdown=halt'],

I'd slightly prefer it if we assigned these extra parameters to a
separate variable, rather than including them directly in the
subprocess.Popen call.

(One thing I'd like to do is to print out the command we're running,
which we do for Qemu, and having it in a variable that's passed in
would be convenient. I don't expect this patch to do that, but having
these parameters separate would make that future diff a little
smaller.)

>                                            stdin=subprocess.PIPE,
>                                            stdout=subprocess.PIPE,
>                                            stderr=subprocess.STDOUT,
> @@ -332,7 +332,7 @@ class LinuxSourceTree(object):
>         def run_kernel(self, args=None, build_dir='', filter_glob='', timeout=None) -> Iterator[str]:
>                 if not args:
>                         args = []
> -               args.extend(['mem=1G', 'console=tty', 'kunit_shutdown=halt'])
> +               args.extend(['mem=1G', 'console=tty'])

Does it make sense to also make these options UML only.

Under Qemu, the amount of memory is already passed separately to qemu,
so adding another limit here seems counterproductive. If an
architecture particularly needs it, we can add it to the
per-architecture config.

And console=tty is overridden by console=ttyS0 on x86_64 anyway, so
that also seems like it should be taken out. I tried commenting this
line out entirely, and at least x86_64 still worked.



>                 if filter_glob:
>                         args.append('kunit.filter_glob='+filter_glob)
>
>
> base-commit: b04d1a8dc7e7ff7ca91a20bef053bcc04265d83a
> --
> 2.35.1.1178.g4f1659d476-goog
>
