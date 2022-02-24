Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D58FB4C25D2
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Feb 2022 09:23:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230128AbiBXIUD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Feb 2022 03:20:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230124AbiBXIUB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Feb 2022 03:20:01 -0500
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [IPv6:2a01:488:42:1000:50ed:8234::])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B370B251E79;
        Thu, 24 Feb 2022 00:19:30 -0800 (PST)
Received: from ip4d144895.dynamic.kabel-deutschland.de ([77.20.72.149] helo=[192.168.66.200]); authenticated
        by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
        id 1nN9LQ-0003ur-Ui; Thu, 24 Feb 2022 09:19:25 +0100
Message-ID: <974cf8f2-06f3-99a5-9a77-6d7b7cc8271a@leemhuis.info>
Date:   Thu, 24 Feb 2022 09:19:24 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Content-Language: en-BS
To:     Kees Cook <keescook@chromium.org>, Jonathan Corbet <corbet@lwn.net>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Stefano Zacchiroli <zack@upsilon.cc>,
        Steven Rostedt <rostedt@goodmis.org>,
        Laura Abbott <labbott@kernel.org>,
        Julia Lawall <julia.lawall@inria.fr>,
        Wenwen Wang <wenwen@cs.uga.edu>, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-hardening@vger.kernel.org
References: <20220224001403.1307377-1-keescook@chromium.org>
From:   Thorsten Leemhuis <linux@leemhuis.info>
Subject: Re: [PATCH] Documentation/process: Add Researcher Guidelines
In-Reply-To: <20220224001403.1307377-1-keescook@chromium.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-bounce-key: webpack.hosteurope.de;linux@leemhuis.info;1645690770;edb46c4e;
X-HE-SMSGID: 1nN9LQ-0003ur-Ui
X-Spam-Status: No, score=0.1 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URI_DOTEDU autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 24.02.22 01:14, Kees Cook wrote:
> As a follow-up to the UMN incident[1], the TAB took the responsibility
> to document Researcher Guidelines so there would be a common place to
> point for describing our expectations as a developer community.
> 
> Document best practices researchers should follow to participate
> successfully with the Linux developer community.
> 
> [1] https://lore.kernel.org/lkml/202105051005.49BFABCE@keescook/
> 
> Co-developed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Co-developed-by: Jonathan Corbet <corbet@lwn.net>
> Signed-off-by: Jonathan Corbet <corbet@lwn.net>
> Co-developed-by: Stefano Zacchiroli <zack@upsilon.cc>
> Signed-off-by: Stefano Zacchiroli <zack@upsilon.cc>
> Co-developed-by: Steven Rostedt <rostedt@goodmis.org>
> Signed-off-by: Steven Rostedt <rostedt@goodmis.org>
> Acked-by: Steve Rostedt <rostedt@goodmis.org>
> Acked-by: Laura Abbott <labbott@kernel.org>
> Reviewed-by: Julia Lawall <julia.lawall@inria.fr>
> Reviewed-by: Wenwen Wang <wenwen@cs.uga.edu>
> Signed-off-by: Kees Cook <keescook@chromium.org>
> ---
>  Documentation/admin-guide/index.rst           |   1 +
>  .../admin-guide/researcher-guidelines.rst     | 141 ++++++++++++++++++

Hmm, the intro for "Documentation/admin-guide/" states that "The
following manuals are written for users of the kernel", but the added
text afaics providing nothing regular users care about. So wouldn't it
be better if this lived below Documentation/process/ ? It might not a
really good fit either, but I'd say it's the better place.

But well, the best person to know is Jonathan, who is listed as a
Co-developer above, so maybe I'm wrong my suggestion is a bad one.

>  2 files changed, 142 insertions(+)
>  create mode 100644 Documentation/admin-guide/researcher-guidelines.rst
> 
> diff --git a/Documentation/admin-guide/index.rst b/Documentation/admin-guide/index.rst
> index 1bedab498104..7fff0730204d 100644
> --- a/Documentation/admin-guide/index.rst
> +++ b/Documentation/admin-guide/index.rst
> @@ -35,6 +35,7 @@ problems and bugs in particular.
>     :maxdepth: 1
>  
>     reporting-issues
> +   researcher-guidelines
>     security-bugs
>     bug-hunting
>     bug-bisect
> diff --git a/Documentation/admin-guide/researcher-guidelines.rst b/Documentation/admin-guide/researcher-guidelines.rst
> new file mode 100644
> index 000000000000..993f32d1166c
> --- /dev/null
> +++ b/Documentation/admin-guide/researcher-guidelines.rst
> @@ -0,0 +1,141 @@
> +.. SPDX-License-Identifier: GPL-2.0
> +
> +.. _researcher_guidelines:
> +
> +Researcher Guidelines
> ++++++++++++++++++++++
> +
> +The Linux kernel community

Nitpicking: wondering if this maybe should be something like "The Linux
kernel developer community" (or "Linux kernel's..."?).

> welcomes transparent research on the Linux
> +kernel, the activities involved in producing it, and any other byproducts
> +of its development. Linux benefits greatly from this kind of research, and
> +most aspects of Linux are driven by research in one form or another.
> +
> +The community greatly appreciates if researchers can share preliminary
> +findings before making their results public, especially if such research
> +involves security. Getting involved early helps both improve the quality
> +of research and ability for Linux to improve from it. In any case,
> +sharing open access copies of the published research with the community
> +is recommended.
> +
> +This document seeks to clarify what the Linux kernel community considers
> +acceptable and non-acceptable practices when conducting such research. At
> +the very least, such research and related activities should follow
> +standard research ethics rules. For more background on research ethics
> +generally, ethics in technology, and research of developer communities
> +in particular, see:
> +
> +* `History of Research Ethics <https://www.unlv.edu/research/ORI-HSR/history-ethics>`_
> +* `IEEE Ethics <https://www.ieee.org/about/ethics/index.html>`_
> +* `Developer and Researcher Views on the Ethics of Experiments on
> +   Open-Source Projects <https://arxiv.org/pdf/2112.13217.pdf>`_
> +
> +The Linux kernel community expects that everyone interacting with the
> +project is participating in good faith to make Linux better. Research on
> +any publicly-available artifact (including, but not limited to source
> +code) produced by the Linux kernel community is welcome, though research
> +on developers must be distinctly opt-in.
> +
> +Passive research that is based entirely on publicly available sources,
> +including posts to public mailing lists and commits to public
> +repositories, is clearly permissible. Though, as with any research,
> +standard ethics must still be followed.
> +
> +Active research on developer behavior,

Nitpicking: when reading this for the first time I here wondered what is
precisely meant by "Active research". Is this maybe an established term
in academia I'm simply not aware of? If not, maybe simply writing
something like "Other research on developer behavior" or "Research on
developer behavior where you engage in development" avoid this.

> however, must be done with the
> +explicit agreement of, and full disclosure to, the individual developers
> +involved. Developers cannot be interacted with/experimented on without
> +consent; this, too, is standard research ethics.
> +
> +To help clarify: 

Follow up to above remark: If "Active research" stays above, I'd say it
might be worth repeating the term here to make clear what's being clarified.

> sending patches to developers *is* interacting
> +with them, but they have already consented to receiving *good faith
> +contributions*. Sending intentionally flawed/vulnerable patches or
> +contributing misleading information to discussions is not consented
> +to. Such communication can be damaging to the developer (e.g. draining
> +time, effort, and morale) and damaging to the project by eroding
> +the entire developer community's trust in the contributor (and the
> +contributor's organization as a whole), undermining efforts to provide
> +constructive feedback to contributors, and putting end users at risk of
> +software flaws.

Nitpicking again: Quite a long sentence. Maybe split it up with
something like a "s!, undermining !; such an approach would thus undermine"

> +Participation in the development of Linux itself by researchers, as
> +with anyone, is welcomed and encouraged. Research into Linux code is
> +a common practice, especially when it comes to developing or running
> +analysis tools that produce actionable results.
> +
> +When engaging with the developer community, sending a patch has
> +traditionally been the best way to make an impact. Linux already has
> +plenty of known bugs -- what's much more helpful is having vetted fixes.
> +Before contributing, carefully read the documentation on
> +:doc:`submitting patches <../process/submitting-patches>`,
> +:doc:`reporting issues <reporting-issues>`, and
> +:doc:`handling serious flaws <security-bugs>`.

Wonder if Documentation/process/{development-process.rst,5.Posting.rst}
should be linked as well.

Additionally not my area of expertise, but from what I'd noticed it
seems it's better to avoid the :doc:`foo` tag if there is no strict need
(and I don't think there is one in this case). For the background see here:

https://lore.kernel.org/all/cover.1623824363.git.mchehab+huawei@kernel.org/

Most of those patches got applied meanwhile afaik.

> Send a patch (including
> +a commit log with all the details listed below), and follow up on any
> +feedback from other developers.
> +
> +When sending patches produced from research, the commit logs should
> +contain at least the following details, so that developers have
> +appropriate context for understanding the contribution. Answer:
> +
> +* What is the specific problem that has been found?
> +* How could the problem be reached on a running system?
> +* What effect would encountering the problem have on the system?
> +* How was the problem found? Specifically include details about any
> +  testing, static or dynamic analysis programs, and any other tools or
> +  methods used to perform the work.
> +* Which version of Linux was the problem was found on? Using the most
> +  recent release or a recent :doc:`linux-next branch <../process/howto>`
> +  is strongly preferred.
> +* What was changed to fix the problem, and why it is believed to be correct?
> +* How was the change build tested and run-time tested?
> +* What prior commit does this change fix? This should go in a "Fixes:"
> +  tag as the documentation describes.
> +* Who else has reviewed this patch? This should go in appropriate
> +  "Reviewed-by:" tags; see below.
> +
> +For example::
> +
> +  From: Author <author@email>
> +  Subject: [PATCH] drivers/foo_bar: Add missing kfree()
> +
> +  The error path in foo_bar driver does not correctly free the allocated
> +  struct foo_bar_info. This can happen if the attached foo_bar device
> +  rejects the initialization packets sent during foo_bar_probe(). This
> +  would result in a 64 byte slab memory leak once per device attach,
> +  wasting memory resources over time.
> +
> +  This flaw was found using an experimental static analysis tool we are
> +  developing, LeakMagic[1], which reported the following warning when
> +  analyzing the v5.15 kernel release:
> +
> +   path/to/foo_bar.c:187: missing kfree() call?
> +
> +  Add the missing kfree() to the error path. No other references to
> +  this memory exist outside the probe function, so this is the only
> +  place it can be freed.
> +
> +  x86_64 and arm64 defconfig builds with CONFIG_FOO_BAR=y using GCC
> +  11.2 show no new warnings, and LeakMagic no longer warns about this
> +  code path. As we don't have a FooBar device to test with, no runtime
> +  testing was able to be performed.
> +
> +  [1] https://url/to/leakmagic/details
> +
> +  Reported-by: Researcher <researcher@email>
> +  Fixes: aaaabbbbccccdddd ("Introduce support for FooBar")
> +  Signed-off-by: Author <author@email>
> +  Reviewed-by: Reviewer <reviewer@email>
> +
> +If you are a first time contributor it is recommended that the patch
> +itself be vetted by others privately before being posted to public lists.
> +(This is required if you have been explicitly told your patches need
> +more careful internal review.) These people are expected to have their
> +"Reviewed-by" tag included in the resulting patch. Finding another
> +developer familiar with Linux contribution, especially within your own
> +organization, and having them help with reviews before sending them to
> +the public mailing lists tends to significantly improve the quality of the
> +resulting patches, and there by reduces the burden on other developers.

I like the section, but I wonder why it's needed here. Is there anything
specific to patches produced from research in it there I missed when
reading it? If not: Wouldn't it be better to include that section as a
TLDR in Documentation/process/submitting-patches.rst and point there
instead? We already have at least two places describing how to submit
patches, creating yet another one (even if it's just in such a brief
version) somehow feels slightly wrong to me.

OTOH I fully understand that having things in one place has it's
benefits. If that's wanted, why not put that text as TLDR in
submitting-patches.rst and maintain a copy here? Sure, keeping things in
sync has downsides, but I'd say it's the lesser evil. A copy could also
be avoided by briefly mentioning some of the important bits found in
another document; that's the approach I took in my patches regarding
regressions. To quote:

```
+#. Report your issue as outlined in
Documentation/admin-guide/reporting-issues.rst,
+   it already covers all aspects important for regressions and repeated
+   below for convenience. Two of them are important: start your
report's subject
+   with "[REGRESSION]" and CC or forward it to `the regression mailing list
+   <https://lore.kernel.org/regressions/>`_ (regressions@lists.linux.dev).
```

For full context see:
https://lore.kernel.org/regressions/cover.1644994117.git.linux@leemhuis.info/T/#u

> +If no one can be found to internally review patches and you need
> +help finding such a person, or if you have any other questions
> +related to this document and the developer community's expectations,
> +please reach out to the private Technical Advisory Board mailing list:
> +<tech-board@lists.linux-foundation.org>.

HTH, Ciao, Thorsten
