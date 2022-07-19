Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B4A97579191
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Jul 2022 06:00:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236270AbiGSEAZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Jul 2022 00:00:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236125AbiGSEAS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jul 2022 00:00:18 -0400
Received: from mout.kundenserver.de (mout.kundenserver.de [217.72.192.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5FA2A1AE;
        Mon, 18 Jul 2022 21:00:11 -0700 (PDT)
Received: from leknes.fjasle.eu ([46.142.98.228]) by mrelayeu.kundenserver.de
 (mreue106 [212.227.15.183]) with ESMTPSA (Nemesis) id
 1Ml72g-1noRVu3IdA-00lSBM; Tue, 19 Jul 2022 05:59:38 +0200
Received: from localhost.fjasle.eu (bergen.fjasle.eu [IPv6:fdda:8718:be81:0:6f0:21ff:fe91:394])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (Client did not present a certificate)
        by leknes.fjasle.eu (Postfix) with ESMTPS id E52333C09F;
        Tue, 19 Jul 2022 05:59:33 +0200 (CEST)
Authentication-Results: leknes.fjasle.eu; dkim=none; dkim-atps=neutral
Received: by localhost.fjasle.eu (Postfix, from userid 1000)
        id 8F3AC3CE3; Tue, 19 Jul 2022 05:59:30 +0200 (CEST)
Date:   Tue, 19 Jul 2022 05:59:30 +0200
From:   Nicolas Schier <nicolas@fjasle.eu>
To:     Masahiro Yamada <masahiroy@kernel.org>
Cc:     linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] kconfig: shorten the temporary directory name for
 cc-option
Message-ID: <YtYsIg9hZ8NU+1MB@bergen.fjasle.eu>
References: <20220719023539.2199045-1-masahiroy@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220719023539.2199045-1-masahiroy@kernel.org>
Jabber-ID: nicolas@jabber.no
X-Operating-System: Debian GNU/Linux bookworm/sid
X-Provags-ID: V03:K1:OTRmgJqLptvpQeE/mUNgR+2Pnpc1ViPEJGuJDEDW7/5i8KLqyhh
 jNx0T2Y6d2aCfShBuzTiHfJ5GIveX3tzyzEOOeWmbS0Nw2MwHQKbBSZx6pRcCTPSlUYtZPJ
 scgdPLmrVaQz9cOgphML8Qg1vIv+mHWKhEggJ9bH3R13IYYzJDEjA0eG42jIMg4QS/omlEW
 fOMo+Y9LKoLaCDgXLZVzg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:V8dxThRCAqc=:R7wLnATUGAj+jGB/AQ4AuD
 iw1CzOi7NU67clAIJUOZtl94DKODROx29IJ8YYxZNP+9vDud3vqAHR84/Jo8/rUnYW9yR2XS0
 9orelnSioZL2bjHvTY5ZSFO6C2CkwFOxmUNFTd9QaoDDbv3GCcS/wlo9SF4CkG4aLOKPwdTMS
 ZFjX3uIYIz8PT/7iU2c8rBJxUHmK2//XFGPTWA0Ihn88yVnHdN9LEir9mPgSBo2MHlCyT3zVB
 amqx9t8U6G1b1P1x7w9OWY9G4oEyTVpwcOmxY0I6YJPvuU/8m1vgVL/l4SHxaxX09HKlIwtvn
 bjE82gRuJ6EO82znsli8Cy/1S4898lpxz4Bd8LxnM+PpV7323xJqZplZ1pUTNG2pqni8xwoRg
 o95ikhh29M5BGzCcK0JJafHxXdkPfU0m/gvK1/2zt4xWrpN2uDvPHaniN1axonP+Qot46JlO/
 EKvCpy1J/sIKhbbK/fuJMu5XRg0x+JC8HD/xrox1Rux9/Z4wDUlIiUeCfv02WlaQAMgXkDstT
 fV7dNvLoJm72RmMdfqWka2065iEquxrJ8FgP3u2E4oKNeEpX1aIR4KSC8JjL3IPDbY4yuGrFS
 XNoc1AtQxMIPu418ILB3po6eybG74OvMVUBXmEOv5FcKMDGENnKHcU072zKpDunc5n2iLC384
 EsRuW+e5BzoT8eLVabhGzQnZBkAK1wG/W54D6I5+RFEFhVJ5ZnmuY8ZM//wREWkzAA/d41xuf
 Q8CpOfRAxmCP/p6jXNeOhn+DtblLyEPNCGjNvQ==
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 19 Jul 2022 11:35:39 +0900 Masahiro Yamada wrote:
> Date:   Tue, 19 Jul 2022 11:35:39 +0900
> From: Masahiro Yamada <masahiroy@kernel.org>
> To: linux-kbuild@vger.kernel.org
> Cc: Masahiro Yamada <masahiroy@kernel.org>, linux-kernel@vger.kernel.org
> Subject: [PATCH] kconfig: shorten the temporary directory name for cc-option
> Message-Id: <20220719023539.2199045-1-masahiroy@kernel.org>
> X-Mailer: git-send-email 2.34.1
> X-Mailing-List: linux-kbuild@vger.kernel.org
> 
> The cc-option macro creates the temporary directory, .tmp_$$$$, which
> is expanded into .tmp_<PID><PID>, but the second <PID> is redundant.
> (<PID> is the process ID of the sub-shell)
> 
> If it were the Makefile code, .tmp_$$$$ would be the correct code.
> (see the TMPOUT macro in scripts/Malefile.compiler)

Typo: Malefile -> Makefile

> 
> In Makefile, '$$' is an escape sequence of '$'. Make expands '$$$$'
> into '$$', then shell expands it into the process ID.
> 
> This does not apply to Kconfig because Kconfig requires variable
> references to be enclosed by curly braces, like ${variable}.
> The '$' that is not followed by '{' loses its special function.
> 
> Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
> ---

Tested-by: Nicolas Schier <nicolas@fjasle.eu>

> 
>  scripts/Kconfig.include | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/scripts/Kconfig.include b/scripts/Kconfig.include
> index 0496efd6e117..c1f4222d223d 100644
> --- a/scripts/Kconfig.include
> +++ b/scripts/Kconfig.include
> @@ -25,7 +25,7 @@ failure = $(if-success,$(1),n,y)
>  
>  # $(cc-option,<flag>)
>  # Return y if the compiler supports <flag>, n otherwise
> -cc-option = $(success,mkdir .tmp_$$$$; trap "rm -rf .tmp_$$$$" EXIT; $(CC) -Werror $(CLANG_FLAGS) $(1) -c -x c /dev/null -o .tmp_$$$$/tmp.o)
> +cc-option = $(success,mkdir .tmp_$$; trap "rm -rf .tmp_$$" EXIT; $(CC) -Werror $(CLANG_FLAGS) $(1) -c -x c /dev/null -o .tmp_$$/tmp.o)
>  
>  # $(ld-option,<flag>)
>  # Return y if the linker supports <flag>, n otherwise
> -- 
> 2.34.1

-- 
epost|xmpp: nicolas@fjasle.eu          irc://oftc.net/nsc
↳ gpg: 18ed 52db e34f 860e e9fb  c82b 7d97 0932 55a0 ce7f
     -- frykten for herren er opphav til kunnskap --
