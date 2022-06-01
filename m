Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DBB0353AF12
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Jun 2022 00:50:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231459AbiFAVTw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Jun 2022 17:19:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231180AbiFAVTt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Jun 2022 17:19:49 -0400
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.126.135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C59A3A76E7;
        Wed,  1 Jun 2022 14:19:38 -0700 (PDT)
Received: from leknes.fjasle.eu ([46.142.96.91]) by mrelayeu.kundenserver.de
 (mreue011 [212.227.15.167]) with ESMTPSA (Nemesis) id
 1MnJUy-1nUtIA27Iy-00jLcz; Wed, 01 Jun 2022 21:49:58 +0200
Received: from localhost.fjasle.eu (bergen.fjasle.eu [IPv6:fdda:8718:be81:0:6f0:21ff:fe91:394])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (Client did not present a certificate)
        by leknes.fjasle.eu (Postfix) with ESMTPS id ABFE93C09F;
        Wed,  1 Jun 2022 21:49:56 +0200 (CEST)
Authentication-Results: leknes.fjasle.eu; dkim=none; dkim-atps=neutral
Received: by localhost.fjasle.eu (Postfix, from userid 1000)
        id 694BF27B9; Wed,  1 Jun 2022 21:49:55 +0200 (CEST)
Date:   Wed, 1 Jun 2022 21:49:55 +0200
From:   Nicolas Schier <nicolas@fjasle.eu>
To:     Masahiro Yamada <masahiroy@kernel.org>
Cc:     linux-kbuild@vger.kernel.org,
        Nick Desaulniers <ndesaulniers@google.com>,
        linux-kernel@vger.kernel.org, Josh Poimboeuf <jpoimboe@redhat.com>,
        Michal Marek <michal.lkml@markovi.net>
Subject: Re: [PATCH 2/4] kbuild: clean .tmp_* pattern by make clean
Message-ID: <YpfC42gQGDJiMMNT@bergen.fjasle.eu>
References: <20220528154704.2576290-1-masahiroy@kernel.org>
 <20220528154704.2576290-2-masahiroy@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <20220528154704.2576290-2-masahiroy@kernel.org>
Jabber-ID: nicolas@jabber.no
X-Operating-System: Debian GNU/Linux bookworm/sid
X-Provags-ID: V03:K1:iWTC9Fl0s+F1OypqFKLOqkbj83zsZ//QByOdoNj6YEXh0YX+PLt
 E+b8wieuJIY9Pkg98zqSC18mjpdoK4pyi9a5/4uSSDKUtftd2fq2C2LiTV07y8JNsaxzqaj
 GB/9oxbZmIDmvq/mlhF+qVBhsHO9ABu0fjWIkWlAxZAdknuX3r5RYsyQ/PjWIgpbBV3zHM1
 ++MOmZ4ncIN9Woa/yjNlg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:HPgegc6THJM=:e24xwd5frNJbGKgbys85Fo
 oKM78EGdhZ0oSrl+2blQX6alQJjIUVIBR7tXSHg/lUWWXIjrWzFhkNi6JgJAq7X2Bpv5LPIoY
 D7q51XWHJMnNcmPlq6s0JG6wBS/wPPqafkesWdRLKbPnTqQoOGOZ7gjCQnEgeVA+UfSbcseF1
 73A/KkWd2lMaMqX6/EGI76Wone4slykcugSfBAjZydDU9tndfUC0hr29kAHwCgh8lZhUxLk23
 l9TFmISMiMfZgkWdti6+dC2HWI6TbarbYBrvjFUGaiUAGYJg7+GIFa9x+SnHfEAbGBdfAro7z
 ilWmcPw0otrgfzmSJkOJvR8JwL/wo+SzXXJJltCFB2OgKuIMo7NX6xwPSMk8HL3Z/WeLJHp3B
 xuMRVE6QfKpqDKdauYLx3zu6NmTe76lJyu9LoRoUA64VlqHFpP1nNAZxVEqe6fVgDUFzjkCVq
 f/zxkbWKYqA1ksiI9DqmmPvXhXUkRCk/icJB1bMDLoau3+DFrPCo5zQsm3MqE7KZepREe9GPZ
 F7QBkKH/K2nx+oUsvAn3IZZBYeN0Xu4Q202qahzdHfzntCJLqEGcKZFSXLNwPWiitQXc2UMib
 nIirUb0tc7SgHknTQkflU0ymxAmaDJR5ZAFJVIL9NwH7FnCFotvq8jPwrtxUNs6c8uIBATCDQ
 e9lZKPyeRGu/igg4hkyWPf8/kdd5Hg+/Eg8IGMjSNqlpiPBlL8CJ3wLi9AM7I9iqBXnXea43g
 0PvJ7Pd/L2BwYfMXmJcR8oM0O8wRMdAKkJlrdA==
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun 29 May 2022 00:47:02 +0900, Masahiro Yamada wrote:
> Change the "make clean" rule to remove all the .tmp_* files.
> 
> .tmp_objdiff is the only exception, which should be removed by
> "make mrproper".
> 
> Rename the record directory of objdiff, .tmp_objdiff to .objdiff to
> avoid the removal by "make clean".
> 
> Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
> ---
> 
>  Makefile                | 4 ++--
>  scripts/link-vmlinux.sh | 3 ---
>  scripts/objdiff         | 2 +-
>  3 files changed, 3 insertions(+), 6 deletions(-)
> 
...
> diff --git a/scripts/objdiff b/scripts/objdiff
> index 72b0b63c3fe1..68b8d74e5c6f 100755
> --- a/scripts/objdiff
> +++ b/scripts/objdiff
> @@ -32,7 +32,7 @@ if [ -z "$SRCTREE" ]; then
>  	exit 1
>  fi
>  
> -TMPD=$SRCTREE/.tmp_objdiff
> +TMPD=$SRCTREE/.objdiff
>  
>  usage() {
>  	echo >&2 "Usage: $0 <command> <args>"

scripts/objdiff still has two occurrences of .tmp_objdiff (in the 
comment block at the top).
