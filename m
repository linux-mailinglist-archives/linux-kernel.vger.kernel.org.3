Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DE3C94E8B9D
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Mar 2022 03:30:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237266AbiC1Bcc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 27 Mar 2022 21:32:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234256AbiC1Bcb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Mar 2022 21:32:31 -0400
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58BEA17E3C;
        Sun, 27 Mar 2022 18:30:51 -0700 (PDT)
Received: by mail-pj1-x1035.google.com with SMTP id gp15-20020a17090adf0f00b001c7cd11b0b3so8410227pjb.3;
        Sun, 27 Mar 2022 18:30:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:to:cc:references:subject
         :content-language:from:in-reply-to:content-transfer-encoding;
        bh=iaxB6e7brfKhObU9tXvhEhwSdXocJ3IGqdgj3hSkeGQ=;
        b=kmsUTnLRisb5IYlJnYlfbHb+ZQOjH5jmuhhE+Jhb2HE7PEQROvP/a0zyus2dndvGxE
         vlCqrSZlvG2Lm3twpQBZyK/pykw32glqoW8ovvyuyx8pp0NUlLPSePTRFJrYIvU8q9ED
         t/hkoFH9DoB5rzw8PpjZLS3un22cX8bve4/5yOWStDHatFN0FYVLlmN20+jApg4rz3cI
         a+ckM+TGCsjYImNaZVvOUKuR97hxyKkut3t9tTQL3tXNvWs0+Rab3CtWgKbg4Z2+iCYx
         SulsIcqlgJ+tY2WBqXgS5bd3zarb2FXfn60Nw5av0gAGeI1Jx7F6S3PqFZjUVCZQoLDM
         DWyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:to:cc
         :references:subject:content-language:from:in-reply-to
         :content-transfer-encoding;
        bh=iaxB6e7brfKhObU9tXvhEhwSdXocJ3IGqdgj3hSkeGQ=;
        b=I+1lQDf8lvWGsNW85Q3UEEUL5NngO+A+YQE+Hw99cF5AF0AVgV2mxQ2SKVMp4SPLP1
         CGZecaRLr6TOwuJnvlXahsPh3kz1C0+BRZqMv/LfaqhKCf0s18RNaH6uFOQ8pLgx5fNA
         Vk1Z27b8c+53ez4lHAAsEto4d3A7iuyVF29PAZBidkLXyKd1lDvh4cMSAv5H+JPiZgBy
         7wJtlTJFKrQxSePWNREuCKFaIpL0Yej77lCpot/eWbPx/08BtAHldeLRIPgdsKbmwUAh
         KNx693oDVdzIAAsALwUNY0r6GRgQhNZsGGWd7biRXEMNyPbc4/dpKt9BEd6ijFitdGd3
         VDPw==
X-Gm-Message-State: AOAM532aU6k4PIGWDXo6671y8KmjkqMKYO6oVQgYzFSECt9bxCFx4kzh
        NNHLYzqDiGGg4/T3po/bQM8=
X-Google-Smtp-Source: ABdhPJxpQ1vOBc6ZpZ4cHDRqiwv6CAhGJMTPwzkkr1bPWbOk8n/qsWx22vVbxEpHXLItnDEz6wp5Vg==
X-Received: by 2002:a17:90b:1e01:b0:1c6:cabc:b2d4 with SMTP id pg1-20020a17090b1e0100b001c6cabcb2d4mr26602091pjb.64.1648431050791;
        Sun, 27 Mar 2022 18:30:50 -0700 (PDT)
Received: from [192.168.11.5] (KD106167171201.ppp-bb.dion.ne.jp. [106.167.171.201])
        by smtp.gmail.com with ESMTPSA id g1-20020a17090adac100b001c67cedd84esm12010581pjx.42.2022.03.27.18.30.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 27 Mar 2022 18:30:50 -0700 (PDT)
Message-ID: <add46954-ee8d-dffb-d311-02368484ef36@gmail.com>
Date:   Mon, 28 Mar 2022 10:30:46 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
To:     Jonathan Corbet <corbet@lwn.net>
Cc:     linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        torvalds@linuxfoundation.org, Akira Yokosawa <akiyks@gmail.com>
References: <87wnghd78t.fsf@meer.lwn.net>
Subject: Re: [PATCH] docs: Add a document on how to fix a messy diffstat
Content-Language: en-US
From:   Akira Yokosawa <akiyks@gmail.com>
In-Reply-To: <87wnghd78t.fsf@meer.lwn.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jon,
Minor nits.  Please find inline comments bellow.

On Fri, 25 Mar 2022 15:58:42 -0600,
Jonathan Corbet <corbet@lwn.net> wrote:
[...]
> diff --git a/Documentation/maintainer/messy-diffstat.rst b/Documentation/maintainer/messy-diffstat.rst
> new file mode 100644
> index 000000000000..970eac087f67
> --- /dev/null
> +++ b/Documentation/maintainer/messy-diffstat.rst
> @@ -0,0 +1,96 @@
> +.. SPDX-License-Identifier: GPL-2.0
> +
> +=====================================
> +Handling messy pull-request diffstats
> +=====================================
> +
> +Subsystem maintainers routinely use ``git request-pull`` as part of the
> +process of sending work upstream.  Normally, the result includes a nice
> +diffstat listing showing which files will be touched and how much of each

        ... listing showing ... took half a second for me to parse.
How about dropping either "listing" or "showing" ?

> +will be changed.  Occasionally, though, a repository with a relatively
> +complicated development history will yield a massive diffstat containing a
> +great deal of unrelated work.  The result looks ugly and obscures what the
> +pull request is actually doing.  This document describes what is happening
> +and how to fix things up; it is derived from The Wisdom of Linus Torvalds,
> +found in Linus1_ and Linus2_.
> +
> +.. _Linus1: https://lore.kernel.org/lkml/CAHk-=wg3wXH2JNxkQi+eLZkpuxqV+wPiHhw_Jf7ViH33Sw7PHA@mail.gmail.com/
> +.. _Linus2: https://lore.kernel.org/lkml/CAHk-=wgXbSa8yq8Dht8at+gxb_idnJ7X5qWZQWRBN4_CUPr=eQ@mail.gmail.com/
> +
> +A Git development history proceeds as a series of commits.  In a simplified
> +manner, mainline kernel development looks like this::
> +
> +  ... vM --- vN-rc1 --- vN-rc2 --- vN-rc3 --- ... --- vN-rc7 --- vN
> +
> +If one wants to see what has changed between two points, a command like
> +will do the job::

Looks incomplete.  How about

   this will do the job::
,or
   below will do the job::

?  (Humble suggestion of a non-native)

> +
> +  $ git diff --stat --summary vN-rc2..vN-rc3
> +
> +Here, there are two clear points in the history; Git will essentially
> +"subtract" the beginning point from the end point and display the resulting
> +differences.  The requested operation is unambiguous and easy enough to
> +understand.
> +
> +When a subsystem maintainer creates a branch and commits changes to it, the
> +result in the simplest case is a history that looks like::
> +
> +  ... vM --- vN-rc1 --- vN-rc2 --- vN-rc3 --- ... --- vN-rc7 --- vN
> +                          |
> +                          +-- c1 --- c2 --- ... --- cN
> +
> +If that maintainer now uses ``git diff`` to see what has changed between
> +the mainline branch (let's call it "linus") and cN, there are still two
> +clear endpoints, and the result is as expected.  So a pull request
> +generated with ``git request-pull`` will also be as expected.  But now
> +consider a slightly more complex development history::
> +
> +  ... vM --- vN-rc1 --- vN-rc2 --- vN-rc3 --- ... --- vN-rc7 --- vN
> +                |         |
> +                |         +-- c1 --- c2 --- ... --- cN
> +                |                   /
> +                +-- x1 --- x2 --- x3
> +
> +Our maintainer has created one branch at vN-rc1 and another at vN-rc2; the
> +two were then subsequently merged into c2.  Now a pull request generated
> +for cN may end up being messy indeed, and developers often end up wondering
> +why.
> +
> +What is happening here is that there are no longer two clear end points for
> +the ``git diff`` operation to use.  The development culminating in cN
> +started in two different places; to generate the diffstat, ``git diff``
> +ends up having pick one of them and hoping for the best.  If the diffstat
> +starts at vN-rc1, it may end up including all of the changes between there
> +and the second origin end point (vN-rc2), which is certainly not what our
> +maintainer had in mind.  With all of that extra junk in the diffstat, it
> +may be impossible to tell what actually happened in the changes leading up
> +to cN.
> +
> +Maintainers often try to resolve this problem by, for example, rebasing the
> +branch or performing another merge with the linus branch, then recreating
> +the pull request.  This approach tends not to lead to joy at the receiving
> +end of that pull request; rebasing and/or merging just before pushing
> +upstream is a well-known way to get a grumpy response.
> +
> +So what is to be done?  The best response when confronted with this
> +situation is to indeed to a merge, but to do it privately, as if it were
                          do

        Thanks, Akira

> +the source of shame.  Create a new, throwaway branch and do the merge
> +there::
> +
> +  ... vM --- vN-rc1 --- vN-rc2 --- vN-rc3 --- ... --- vN-rc7 --- vN
> +                |         |                                      |
> +                |         +-- c1 --- c2 --- ... --- cN           |
> +                |                   /               |            |
> +                +-- x1 --- x2 --- x3                +------------+-- TEMP
> +
> +The merge operation resolves all of the complications resulting from the
> +multiple beginning points, yielding a coherent result that contains only
> +the differences from the mainline branch.  Now it will be possible to
> +generate a diffstat with the desired information::
> +
> +  $ git diff -C --stat --summary linus..TEMP
> +
> +Save the output from this command, then simply delete the TEMP branch;
> +definitely do not expose it to the outside world.  Take the saved diffstat
> +output and edit it into the messy pull request, yielding a result that
> +shows what is really going on.  That request can then be sent upstream.
> -- 

