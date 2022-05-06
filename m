Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 23D5E51D88A
	for <lists+linux-kernel@lfdr.de>; Fri,  6 May 2022 15:10:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237119AbiEFNN6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 May 2022 09:13:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1392266AbiEFNNa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 May 2022 09:13:30 -0400
Received: from mail-pf1-x42d.google.com (mail-pf1-x42d.google.com [IPv6:2607:f8b0:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7F8B69496;
        Fri,  6 May 2022 06:09:38 -0700 (PDT)
Received: by mail-pf1-x42d.google.com with SMTP id g8so6217781pfh.5;
        Fri, 06 May 2022 06:09:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:from:subject:to:cc
         :content-language:content-transfer-encoding;
        bh=730230Vo8kmZKuX3J8vSRodOD61MMfJ0qibRzQlh44w=;
        b=nLAKnOkGT6kyGPOjiY6PmkE+lQCREgWvD7EXQehVZwSl68+4NgGsFR+VUsozP8WMr9
         kbkpvfp0Q8TzPW+VcdT/mIzDGoghbdO+Si8YMbyNk6ntj5z5KkIeIZF8jvcmJZ2Hqf+s
         ElJYdygoqS4g2oI4gkH2osb7OUVr3IgU1rwis48xZfdy825+VQ2RKaTlHmoxhmNHmrTe
         TVap6oZ/bW0u57iQeeAgWaRIEnBeR6TXO4RGbqe6GjWQN7m3MXZVwkHelwZ6jn8xpjlt
         txyepkpmKoEChPB6dIG/TWjTzZ3JkPCZ42ToheaF7nAvWe9EmRSYnxJIwOzjBYj8e55i
         bUHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:from
         :subject:to:cc:content-language:content-transfer-encoding;
        bh=730230Vo8kmZKuX3J8vSRodOD61MMfJ0qibRzQlh44w=;
        b=1s0a9q9YMJM8RQAq6X1NFQCAcBaL/FAnY5N3AucyOIopTjxvOC0U3U4ra31jlSCks1
         8by5Xcs8bY5BbvdDgJ0ZieL16pNqF2llFcJ8T5PCtEW5pnaEaPuNVYcJH22pJ5xFh8Nf
         xQHf1khv6ogch/HguyZHNrHlILHzOnNmxkjbNQ3VYP5usXWYpgjaeDGHo8ynTlR/sq4O
         6oLcaOuZd6HbTh3rwSIeMEdpS4fLIlxrIIuTScp312w7Y7p9n1QTgr7yA4xfD6sXt2qT
         YCInF+XguFXd0gfRdokORKiUOhMafqxlRmjIPqgW0d0rRTEwgE4aXlxmJdJATuWRyc3G
         TfEA==
X-Gm-Message-State: AOAM530xkAYwS80bcBs3Ygl+h2p88XWfTIZbmHp9Cjz+rYxsRv+/QZxd
        OtzSsEUrrXGNOwVu1IwTT+4=
X-Google-Smtp-Source: ABdhPJxAvb3r62U6mvX4eZGsPzJ77W2YGDQosacfQtNy6rjh1ILYEH/UsquGh3yM55fD3D53rrgplA==
X-Received: by 2002:aa7:970f:0:b0:50d:301e:e6ce with SMTP id a15-20020aa7970f000000b0050d301ee6cemr3492354pfg.61.1651842577916;
        Fri, 06 May 2022 06:09:37 -0700 (PDT)
Received: from [192.168.11.5] (KD106167171201.ppp-bb.dion.ne.jp. [106.167.171.201])
        by smtp.gmail.com with ESMTPSA id 6-20020a170902c24600b0015e8d4eb20dsm1667412plg.87.2022.05.06.06.09.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 06 May 2022 06:09:37 -0700 (PDT)
Message-ID: <fdfecc82-d41e-6d8a-738d-4beb6faa27fb@gmail.com>
Date:   Fri, 6 May 2022 22:09:31 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
From:   Akira Yokosawa <akiyks@gmail.com>
Subject: [PATCH -next] docs: vm/page_owner: Tweak literal block in STANDARD
 FORMAT SPECIFIERS
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Shenghong Han <hanshenghong2019@email.szu.edu.cn>,
        Jiajian Ye <yejiajian2018@email.szu.edu.cn>,
        Chongxi Zhao <zhaochongxi2019@email.szu.edu.cn>,
        Yinan Zhang <zhangyinan2019@email.szu.edu.cn>,
        Yixuan Cao <caoyixuan2019@email.szu.edu.cn>,
        Yongqiang Liu <liuyongqiang13@huawei.com>,
        Yuhong Feng <yuhongf@szu.edu.cn>,
        Haowen Bai <baihaowen@meizu.com>,
        Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

A semantic conflict between commit 5603f9bdea68 ("docs: vm/page_owner:
use literal blocks for param description") and a change queued for v5.19
authored by Jiajian Ye ("tools/vm/page_owner_sort.c: support sorting
blocks by multiple keys") results in a warning from "make htmldocs"
saying:

  [...]/vm/page_owner.rst:176: WARNING: Literal block expected; none foun=
d.

This is because a literal block in ReST ends at a line which has the
same indent as the paragraph preceding it.  In this case the one with
no indent.

Indent the two "For --xxxx option:" lines by two columns and make the
whole section a literal block.

While at it, fix indents by white spaces of "ator" keys.

Reported-by: Shenghong Han <hanshenghong2019@email.szu.edu.cn>
Signed-of-by: Akira Yokosawa <akiyks@gmail.com>
Cc: Jiajian Ye <yejiajian2018@email.szu.edu.cn>
Cc: Chongxi Zhao <zhaochongxi2019@email.szu.edu.cn>
Cc: Yinan Zhang <zhangyinan2019@email.szu.edu.cn>
Cc: Yixuan Cao <caoyixuan2019@email.szu.edu.cn>
Cc: Yongqiang Liu <liuyongqiang13@huawei.com>
Cc: Yuhong Feng <yuhongf@szu.edu.cn>
Cc: Haowen Bai <baihaowen@meizu.com>
Cc: Jonathan Corbet <corbet@lwn.net>
---
Hi Andrew,

This is kind of a follow-up fix of commit 5603f9bdea68 ("docs:
vm/page_owner: use literal blocks for param description"), which I
sent the other day [1] as a fix against v5.18-rc1 and merged into
v5.18-rc5.

The fix in mainline results in a minor semantic conflict with your
tree destined for v5.19, and causes another warning from "make html".
Shenghong Han submitted a patch around the key lists using the ReST
table construct [2] based on Haowen Bai's earlier attempt [3], but
it seems the effort has stalled.

Hence I'm submitting this patch against your tree as a resolution
of the semantic conflict, with additional indent fixes as were done
in [2].

[1]: https://lore.kernel.org/r/cfd3bcc0-b51d-0c68-c065-ca1c4c202447@gmail=
=2Ecom/
[2]: https://lore.kernel.org/r/20220429181926.10658-1-hanshenghong2019@em=
ail.szu.edu.cn/
[3]: https://lore.kernel.org/r/1650956829-31013-3-git-send-email-baihaowe=
n@meizu.com/

Note: By making the whole section a literal block, excessive inline
literal markers around --sort and --curl options can be avoided.

For example, in a normal ReST paragraph,

  For --sort option:

will be converted by Sphinx to

  For =E2=80=93sort option:

in HTML, where the "=E2=80=93" is an "endash" symbol.

Such conversions could be prevented by putting inline literal markers
around:

  For ``--sort`` option:

However, it would degrade the readability of the .rst file as
plain-text.  In this particular case, making the whole section
a literal block should be a better option, at long as the section
consists only of those key lists.

        Thanks, Akira
--
 Documentation/vm/page_owner.rst | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/Documentation/vm/page_owner.rst b/Documentation/vm/page_owne=
r.rst
index 25622c715823..f5c954afe97c 100644
--- a/Documentation/vm/page_owner.rst
+++ b/Documentation/vm/page_owner.rst
@@ -173,7 +173,7 @@ STANDARD FORMAT SPECIFIERS
 =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D
 ::
=20
-For --sort option:
+  For --sort option:
=20
 	KEY		LONG		DESCRIPTION
 	p		pid		process ID
@@ -183,9 +183,9 @@ For --sort option:
 	T		txt		full text of block
 	ft		free_ts		timestamp of the page when it was released
 	at		alloc_ts	timestamp of the page when it was allocated
-        ator            allocator       memory allocator for pages
+	ator		allocator	memory allocator for pages
=20
-For --curl option:
+  For --curl option:
=20
 	KEY		LONG		DESCRIPTION
 	p		pid		process ID
@@ -193,4 +193,4 @@ For --curl option:
 	n		name		task command name
 	f		free		whether the page has been released or not
 	st		stacktrace	stack trace of the page allocation
-        ator            allocator       memory allocator for pages
+	ator		allocator	memory allocator for pages
--=20
2.25.1

