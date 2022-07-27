Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7E0545821FE
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Jul 2022 10:24:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230294AbiG0IYi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Jul 2022 04:24:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229604AbiG0IYg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jul 2022 04:24:36 -0400
Received: from mx.kolabnow.com (mx.kolabnow.com [212.103.80.153])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E9E542ADE;
        Wed, 27 Jul 2022 01:24:33 -0700 (PDT)
Received: from localhost (unknown [127.0.0.1])
        by mx.kolabnow.com (Postfix) with ESMTP id B770C418F9;
        Wed, 27 Jul 2022 10:24:31 +0200 (CEST)
Authentication-Results: ext-mx-out003.mykolab.com (amavisd-new);
        dkim=pass (4096-bit key) reason="pass (just generated, assumed good)"
        header.d=kolabnow.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kolabnow.com; h=
        message-id:references:in-reply-to:subject:subject:from:from:date
        :date:content-transfer-encoding:content-type:content-type
        :mime-version:received:received:received; s=dkim20160331; t=
        1658910271; x=1660724672; bh=5Fqp+Ei7acFfHfu2chlfgxDJ2muQzoDt9uB
        RB1fZA0I=; b=DrkBLv/LoJZXQJ5jew1wQLy/oBA24L6rcEyuaDCyT3p9VLG7t7M
        AC0/pMR6glzLV77JYNuwdm+q2msVMatuXaqggNVBbee3OTuQLHCw0jxIa3o/dd77
        OfT5pgkz9qKYUAD4HB2Jscfu4xHq8iqKZtPjX7xzaUcaHW9+IG6nYu5onGY6Xlrz
        cIFZVw5UpyFhfhSFe8+L1Adb3V8cPOKTt8uOEXWy9HLtAjymCU5qy1Zg0XhLuqys
        i/KSmjmOw9yUY9tnujz1xCWCLo91WICPsA97lmjdT/gIGdSbDpMm8Zb1jAo8nFT1
        Bw0o3WokHsJS8xgAaZJZKR2JN9heRFun1WonnISYmdzCdd14+D7D8oV3AFp7M77V
        B+mkD1jR0kMT9WA7g4taLFqgu1kGb7t1pzeT9tFs0vhE/SFb7di6SQdTh5vAQ/mH
        xUlkbPsBsj+jMCzuecfGGZYfshi3wTPR5CSAp+5hGly2MWFun5gaANz/KBXeotqM
        dT3KfklEOT4BSXmbQgIXrPkw3tM7lEGNgUYOenYMyNKEfPlnyl1153oeHJ4V+qUx
        FPxxnJfc73fVZSeZnLi661d/u4tI0XXwklUMMdfulHIx8d52ZTD3mZ6d3ZwzxpmV
        HO80AncObTsWCGCvCNyDkp/SbO86txKGPLvrt5f6tezapA7InR4b6E0E=
X-Virus-Scanned: amavisd-new at mykolab.com
X-Spam-Score: -1.899
X-Spam-Level: 
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
        version=3.4.6
Received: from mx.kolabnow.com ([127.0.0.1])
        by localhost (ext-mx-out003.mykolab.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id J7D8uo3HKmMz; Wed, 27 Jul 2022 10:24:31 +0200 (CEST)
Received: from int-mx002.mykolab.com (unknown [10.9.13.2])
        by mx.kolabnow.com (Postfix) with ESMTPS id 4583E418E7;
        Wed, 27 Jul 2022 10:24:30 +0200 (CEST)
Received: from int-subm003.mykolab.com (unknown [10.9.37.3])
        by int-mx002.mykolab.com (Postfix) with ESMTPS id DEAD93AF2;
        Wed, 27 Jul 2022 10:24:29 +0200 (CEST)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Wed, 27 Jul 2022 10:24:28 +0200
From:   Federico Vaga <federico.vaga@vaga.pv.it>
To:     Jonathan Corbet <corbet@lwn.net>
Cc:     linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] doc:it_IT: align Italian documentation
In-Reply-To: <20220702210820.13118-1-federico.vaga@vaga.pv.it>
References: <20220702210820.13118-1-federico.vaga@vaga.pv.it>
Message-ID: <647c4d53ee57113a60d8f517eb5d32e8@vaga.pv.it>
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jon,

is there something wrong with this v2 patch? I did not get any feedback.

Thanks

On 2022-07-02 23:08, Federico Vaga wrote:
> Translation for the following patches
> 
> commit df05c0e9496c ("Documentation: Raise the minimum supported
> version of LLVM to 11.0.0")
> commit 333b11e541fe ("Documentation: Add minimum pahole version")
> commit 6d6a8d6a4ed0 ("docs: Update Sphinx requirements")
> commit 76ae847497bc ("Documentation: raise minimum supported version
> of GCC to 5.1")
> commit 59c6a716b14b ("Documentation/process/maintainer-pgp-guide:
> Replace broken link to PGP path finder")
> commit 85eafc63d032 ("docs: update file link location")
> commit 869f496e1aa6 ("docs: process: submitting-patches: Clarify the
> Reported-by usage")
> commit 6c5ccd24ff17 ("Remove mentions of the Trivial Patch Monkey")
> commit aa9b5e0df226 ("Documentation/process: fix self reference")
> commit b96ff02ab2be ("Documentation/process: fix a cross reference")
> commit 1f57bd42b77c ("docs: submitting-patches: make section about the
> Link: tag more explicit")
> commit a9d85efb25fb ("docs: use the lore redirector everywhere")
> commit 31c9d7c82975 ("Documentation/process: Add tip tree handbook")
> commit 604370e106cc ("Documentation/process: Add maintainer handbooks 
> section")
> commit bf33a9d42d0c ("docs: 5.Posting.rst: describe Fixes: and Link: 
> tags")
> commit c04639a7d2fb ("coding-style.rst: trivial: fix location of
> driver model macros")
> commit d5b421fe0282 ("docs: Explain the desired position of function
> attributes")
> commit 3577cdb23b8f ("docs: deprecated.rst: Clarify open-coded
> arithmetic with literals")
> commit db67eb748e7a ("docs: discourage use of list tables")
> commit 0e805b118662 ("docs: address some text issues with css/theme 
> support")
> commit 135707d3765e ("docs: allow to pass extra DOCS_CSS themes via 
> make")
> commit fe450eeb4e6f ("Documentation: in_irq() cleanup")
> commit 10855b45a428 ("docs: fix typo in
> Documentation/kernel-hacking/locking.rst")
> commit bc67f1c454fb ("docs: futex: Fix kernel-doc references")
> commit abf36fe0be7d ("docs: kernel-hacking: Remove inappropriate text")
> commit f35cf1a59e9a ("Documentation: kernel-hacking: minor edits for 
> style")
> commit f35cf1a59e9a ("Documentation: kernel-hacking: minor edits for 
> style")
> commit 980c3799c500 ("Documentation: kernel-doc: Promote two chapter
> headings to page title")
> commit e1be43d9b5d0 ("overflow: Implement size_t saturating arithmetic 
> helpers")
> commit 615f3eea0d5f ("Documentation: add note block surrounding
> security patch note")
> commit 587d39b260c4 ("Documentation: add link to stable release 
> candidate tree")
> commit 555d44932c67 ("Documentation: update stable tree link")
> commit 88d99e870143 ("Documentation: update stable review cycle 
> documentation")
> commit 0c603a5c704f ("Documentation/process: mention patch changelog
> in review process")
> commit 6d5aa418b3bd ("docs: submitting-patches: Fix crossref to 'The
> canonical patch format'")
> commit f1a693994b1c ("Documentation/process: use
> scripts/get_maintainer.pl on patches")
> commit 69ef0920bdd3 ("Docs: Add cpio requirement to changes.rst")
> commit 5a5866c28b43 ("Docs: Replace version by 'current' in 
> changes.rst")
> commit 9b5a7f4a2a8d ("x86/configs: Add x86 debugging Kconfig fragment
> plus docs")
> commit f1a693994b1c ("Documentation/process: use
> scripts/get_maintainer.pl on patches")
> commit e8c07082a810 ("Kbuild: move to -std=gnu11")
> 
> Signed-off-by: Federico Vaga <federico.vaga@vaga.pv.it>
> ---
> 
> v1 -> v2
> Fix wornings about duplicated use of `maintainers-include`

-- 
Federico Vaga
