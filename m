Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8309E599439
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Aug 2022 06:47:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345949AbiHSEiu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Aug 2022 00:38:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243004AbiHSEir (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Aug 2022 00:38:47 -0400
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.17.10])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 680B42D1EB;
        Thu, 18 Aug 2022 21:38:36 -0700 (PDT)
Received: from leknes.fjasle.eu ([46.142.96.59]) by mrelayeu.kundenserver.de
 (mreue108 [212.227.15.183]) with ESMTPSA (Nemesis) id
 1MLA2e-1o6ogd3stm-00IAcv; Fri, 19 Aug 2022 06:38:02 +0200
Received: from localhost.fjasle.eu (bergen.fjasle.eu [IPv6:fdda:8718:be81:0:6f0:21ff:fe91:394])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (Client did not present a certificate)
        by leknes.fjasle.eu (Postfix) with ESMTPS id 4EF603C09F;
        Fri, 19 Aug 2022 06:38:00 +0200 (CEST)
Authentication-Results: leknes.fjasle.eu; dkim=none; dkim-atps=neutral
Received: by localhost.fjasle.eu (Postfix, from userid 1000)
        id 771FC23F; Fri, 19 Aug 2022 06:37:58 +0200 (CEST)
Date:   Fri, 19 Aug 2022 06:37:58 +0200
From:   Nicolas Schier <nicolas@fjasle.eu>
To:     Masahiro Yamada <masahiroy@kernel.org>
Cc:     linux-kbuild@vger.kernel.org, Ingo Molnar <mingo@kernel.org>,
        Rob Herring <robh@kernel.org>,
        Michal Marek <michal.lkml@markovi.net>,
        Nick Desaulniers <ndesaulniers@google.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] kbuild: remove the target in signal traps when
 interrupted
Message-ID: <Yv8TpkJkDYHJj2hX@bergen.fjasle.eu>
References: <20220807004809.69076-1-masahiroy@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <20220807004809.69076-1-masahiroy@kernel.org>
Jabber-ID: nicolas@jabber.no
X-Operating-System: Debian GNU/Linux bookworm/sid
X-Provags-ID: V03:K1:Yqdq/f5Jen/0ZdzyaBCmZ/ZXM3bdn1h3slDuhYfqDUN+KvZFTF0
 C7R16oYN5i1ewHFMd1alCQD2zaclYTvfs0hn3vvPMRplbzTrQLsnewhqTo79MtOJKNSi3ji
 sLmkjpCS8V3Aa5ts3Y2Fv43EX7WLTtZ+2Ij5i+0yJyePZcdvgPN7+P9yb0DQvVbSFc25W8F
 GwpG7NZqzh6CKxoN+NfTQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:w3rdDOdXIiY=:64P/+gQpetcYaq5hWoXQWj
 FwWV32xDNTli8HObF2SKy17ES69oH7LKNHlN3PGLEX5/B9jDyGghSvxwT1jz4xh9M5vCcG/YQ
 kMSZd+PQIbRseKwRx8/oAcnENm+jjcPsgdWFymLcEf+nQfL4XDho7JyItxphM9jnlw7VFHvJr
 Zp8V5UL6yawDVsCTd8i8FsiqOGoCcYapMuhrqHQfj4KAad0xaShUXgjqu6jv2fk07c664skk3
 TePwIbtQVmZmSDiRxvkS0ik+pamJjLdRA66ZysBkb6/DK9PAHxEqx+0V5q98mYGiylp/c4wVM
 mh9g4mw5/cdsd3FNevcYnY8E4ilgeqSoDTEdiU1g02BjvATb0PVrW6oKF8Pbdtm7ifcrM5WiP
 he/qhvmTeLe8g6Wm8afUjgsYxcwMcALhU2jRzSO1jKrOoIreo7iPTwfWJofuKY0RoPxcCQkg9
 OhCk6wj6crwpokf/DebJXnIwWLR2QrEI0fj3ttO35KO5ZRTam2Owf87q6j+/74ifiOoBeq5AJ
 Fxuxbb6xP5r/mCfibxn1cNvthemzlvHpYKIaD6XdQwxiZesIifL4IVXhGcqe9RRc5AGA7r6qE
 Sg/uPSFBlu+lq8vF0rNp+bEWiKVpjWPgOKQ/6a+Xfyzj4MuW9eiKyUPa00RiNRi2/eIE3cWJ0
 AMnfhE2RIxGfZyhlLoo+ckfl00r/+1Ihohu9itb1ONEaRF/dNwvr2MT9cPQrFb6E03fvuxorv
 AkOd7mG+cNhw2BRTw3DMtH92kQxgPPa0O2268A==
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun 07 Aug 2022 09:48:09 +0900 Masahiro Yamada wrote:
> When receiving some signal, GNU Make automatically deletes the target if
> it has already been changed by the interrupted recipe.
> 
> If the target is possibly incomplete due to interruption, it must be
> deleted so that it will be remade from scratch on the next run of make.
> Otherwise, the target would remain corrupted permanently because its
> timestamp had already been updated.
> 
> Thanks to this behavior of Make, you can stop the build any time by
> pressing Ctrl-C, and just run 'make' to resume it.
> 
> Kbuild also relies on this feature, but it is equivalently important
> for any build systems that make decisions based on timestamps (if you
> want to support stop/resume reliably).
> 
> However, this does not always work as claimed; Make immediately dies
> with Ctrl-C if its stderr goes into a pipe.
> 
>   [Test Makefile]
> 
>     foo:
>             echo hello > $@
>             sleep 3
>             echo world >> $@
> 
>   [Test Result]
> 
>     $ make                         # hit Ctrl-C
>     echo hello > foo
>     sleep 3
>     ^Cmake: *** Deleting file 'foo'
>     make: *** [Makefile:3: foo] Interrupt
> 
>     $ make 2>&1 | cat              # hit Ctrl-C
>     echo hello > foo
>     sleep 3
>     ^C$                            # 'foo' is often left-over
> 
> The reason is because SIGINT is sent to the entire process group.
> In this example, SIGINT kills 'cat', and 'make' writes the message to
> the closed pipe, then dies with SIGPIPE.
> 
> A typical bad scenario (as reported by [1], [2]) is to save build log
> by using the 'tee' command:
> 
>     $ make 2>&1 | tee log
> 
> Again, this can be problematic for any build systems based on Make, so
> I hope it will be fixed in GNU Make. The maintainer of GNU Make stated
> this is a long-standing issue and difficult to fix [3]. It has not been
> fixed yet as of writing.
> 
> So, we cannot rely on Make cleaning the target. We can do it by
> ourselves, in signal traps.
> 
> As far as I understand, Make takes care of SIGHUP, SIGINT, SIGQUIT, and
> SITERM for the target removal. I added the traps for them, and also for
> SIGPIPE just in case cmd_* rule prints something to stdout or stderr
> (but I did not observe an actual case where SIGPIPE was triggered).
> 
> [Note 1]
> 
> The trap handler might be worth explaining.
> 
>     rm -f $@; trap - $(sig); kill -s $(sig) $$
> 
> This lets the shell kill itself by the signal it caught, so the parent
> process can tell the child has exited on the signal. Generally, this is
> a proper manner for handling signals, in case the calling program (like
> Bash) may monitor WIFSIGNALED() and WTERMSIG() for WCE (Wait and
> Cooperative Exit) [4] although this may not be a big deal here because
> GNU Make handles SIGHUP, SIGINT, SIGQUIT in WUE (Wait and Unconditional
> Exit) and SIGTERM in IUE (Immediate Unconditional Exit).
> 
> [Note 2]
> 
> Reverting 392885ee82d3 ("kbuild: let fixdep directly write to .*.cmd
> files") would directly address [1], but it only saves if_changed_dep.
> As reported in [2], all commands that use redirection can potentially
> leave an empty (i.e. broken) target.
> 
> [Note 3]
> 
> Another (even safer) approach might be to always write to a temporary
> file, and rename it to $@ at the end of the recipe.
> 
>    <command>  > $(tmp-target)
>    mv $(tmp-target) $@
> 
> It would require a lot of Makefile changes, and result in ugly code,
> so I did not take it.
> 
> [Note 4]
> 
> A little more thoughts about a pattern rule with multiple targets (or
> a grouped target).
> 
>     %.x %.y: %.z
>             <recipe>
> 
> When interrupted, GNU Make deletes both %.x and %.y, while this solution
> only deletes $@. Probably, this is not a big deal. The next run of make
> will execute the rule again to create $@ along with the other files.
> 
> [1]: https://lore.kernel.org/all/YLeot94yAaM4xbMY@gmail.com/
> [2]: https://lore.kernel.org/all/20220510221333.2770571-1-robh@kernel.org/
> [3]: https://lists.gnu.org/archive/html/help-make/2021-06/msg00001.html
> [4]: https://www.cons.org/cracauer/sigint.html
> 
> Reported-by: Ingo Molnar <mingo@kernel.org>
> Reported-by: Rob Herring <robh@kernel.org>
> Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
> ---
> 
> If you are happy to help test this patch, that will be appreciated.
> 
> Without applying this patch,
> 
>     $ make -j<nr-proc> 2>&1 | tee log
> 
> Then, you will see an error reported in [1].
> You may need to repeat it dozen of times to reproduce it.
> The more CPU cores you have, the easier you will get the error.
> 
> Apply this patch, and repeat the same.
> You will no longer see that error (hopefully).
> 
> 
>  scripts/Kbuild.include | 23 ++++++++++++++++++++++-
>  1 file changed, 22 insertions(+), 1 deletion(-)
> 
> diff --git a/scripts/Kbuild.include b/scripts/Kbuild.include
> index ece44b735061..9432a7f33186 100644
> --- a/scripts/Kbuild.include
> +++ b/scripts/Kbuild.include
> @@ -100,8 +100,29 @@ echo-cmd = $(if $($(quiet)cmd_$(1)),\
>   quiet_redirect :=
>  silent_redirect := exec >/dev/null;
>  
> +# Delete the target on interruption
> +#
> +# GNU Make automatically deletes the target if it has already been changed by
> +# the interrupted recipe. So, you can safely stop the build by Ctrl-C (Make
> +# will delete incomplete targets), and resume it later.
> +#
> +# However, this does not work when the stderr is piped to another program, like
> +#  $ make >&2 | tee log
> +# Make dies with SIGPIPE before cleaning the targets.
> +#
> +# To address it, we cleans the target in signal traps.

s/cleans/clean/

> +#
> +# Make deletes the target when it catches SIGHUP, SIGINT, SIGQUIT, SIGTERM.
> +# So, we cover them, and also SIGPIPE just in case.
> +#
> +# Of course, this is unneeded for phony targets.
> +delete-on-interrupt = \
> +	$(if $(filter-out $(PHONY), $@), \
> +		$(foreach sig, HUP INT QUIT TERM PIPE, \
> +			trap 'rm -f $@; trap - $(sig); kill -s $(sig) $$$$' $(sig);))
> +
>  # printing commands
> -cmd = @set -e; $(echo-cmd) $($(quiet)redirect) $(cmd_$(1))
> +cmd = @set -e; $(echo-cmd) $($(quiet)redirect) $(delete-on-interrupt) $(cmd_$(1))
>  
>  ###
>  # if_changed      - execute command if any prerequisite is newer than
> -- 
> 2.34.1

Thanks for the patch and the verbose reasoning.  I would like to see 
stable@k.o added if you think it is appropriate (patch applies cleanly 
to 5.4, 5.15).

Reviewed-by: Nicolas Schier <nicolas@fjasle.eu>

Kind regards,
Nicolas
