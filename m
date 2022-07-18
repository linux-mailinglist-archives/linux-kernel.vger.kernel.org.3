Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AC4C157860F
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Jul 2022 17:11:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235183AbiGRPLa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Jul 2022 11:11:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233838AbiGRPL2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jul 2022 11:11:28 -0400
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D1B31CFEE
        for <linux-kernel@vger.kernel.org>; Mon, 18 Jul 2022 08:11:27 -0700 (PDT)
Received: by mail-ej1-x631.google.com with SMTP id b11so21771469eju.10
        for <linux-kernel@vger.kernel.org>; Mon, 18 Jul 2022 08:11:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=7F8+UCVWKbAQTKBNFCoH9X0sSLk2kYOf1pqvUZLzBOw=;
        b=AttdUXSlQQ23O7n53YGj3RpOZCZkERAaZ8RUL7dsYzNGZv4CgJGt3nd1yz4J0utSKD
         rlcKYbc2pRl2IWX6YZBfhH4dUzCq1euVjE9wyNpai5f8APvicipOhGGZ+KkM1HF1/cos
         zRukMw/OOLUl6wV4BNgQznA7zyXY3cPwWXgsLR847K/uhA5U/vdW2/Eh+O7PNIP0lg08
         U+9N5F0Akv2uELN+3TYELC7hOOrWsvoFNxV/ory/4xD5RgvaySeU8qMXFRvmjganrwkf
         5lXZgumWxFHR8XDyCRiFiwiCmjktNoysOK1Oy/7x70ebYLJkdF9AuW12ussAaiyFtZ9e
         UEsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=7F8+UCVWKbAQTKBNFCoH9X0sSLk2kYOf1pqvUZLzBOw=;
        b=uhNWzZ29cbjVwPRMekvywYRns/0FaRNbDl0ecwrCME/NtmmgGZpV8aYAh96a+aML6g
         SyaF4lKtXKGslW/IYKtFzhVwPbq+XL+b0hdgZ/0EKycmEeo92lCQcReTVsIj6Tim1NxO
         Js89T0lfTZzY7Uw9VzMxuIeyXoKtIqxfinhdDCz6XMRzUm/TARHofil9unITSBxVrv59
         uIkMlc1uX+Difif4KdI8NyZyQMEXbhr2593WrGpYf7+tac0Pipx0BhkI3awv7rEMyVFb
         CaaQVwa62hiJ+sTCShLxYEiQr0vECjUeVQNhXcD5qGwnhynE4DH6mH61/1jMQ9NDy9Dg
         DQMg==
X-Gm-Message-State: AJIora+mzBXdOHJEPHp3F/qyGfY98uWiU0wzdofVHrmpGxlb5zs76Kkn
        omvePNqzCO2rKBOaHXBBnoGo/LSsmT+TwfVk1GIvufAxxBRUDw==
X-Google-Smtp-Source: AGRyM1tSjRiJE8EBBkz12zOUZpQCQpNZz6k17kw++hvdoKtgtsgwua1Rxp/VjTOnPfWsavNFrxusXPBVYN+ElPg2jIM=
X-Received: by 2002:a17:907:7604:b0:72b:4ad5:b21c with SMTP id
 jx4-20020a170907760400b0072b4ad5b21cmr25523698ejc.412.1658157085104; Mon, 18
 Jul 2022 08:11:25 -0700 (PDT)
MIME-Version: 1.0
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Mon, 18 Jul 2022 20:41:13 +0530
Message-ID: <CA+G9fYuBK8yvEQb-DL9EjFSOcW1sfdj5gmg_kZEYHnPN+6mQkw@mail.gmail.com>
Subject: perf: util/annotate.c:1765:9: error: too few arguments to function 'init_disassemble_info'
To:     open list <linux-kernel@vger.kernel.org>,
        perf-users <perf-users@linaro.org>, regressions@lists.linux.dev,
        lkft-triage@lists.linaro.org
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Andres Freund <andres@anarazel.de>,
        andrew.burgess@embecosm.com,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Roman Gushchin <guro@fb.com>,
        Jakub Kicinski <jakub.kicinski@netronome.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

with reference to other email thread on perf build failure on Linus mainline [1]

I see perf build failure today on Linus mainline tree with this error [2]
with gcc-11.

Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>

  CC      util/annotate.o
  CC      util/block-info.o
  CC      bench/mem-functions.o
  MKDIR   tests/
  CC      tests/parse-events.o
util/annotate.c: In function 'symbol__disassemble_bpf':
util/annotate.c:1765:9: error: too few arguments to function
'init_disassemble_info'
 1765 |         init_disassemble_info(&info, s,
      |         ^~~~~~~~~~~~~~~~~~~~~
In file included from util/annotate.c:1718:
/usr/include/dis-asm.h:472:13: note: declared here
  472 | extern void init_disassemble_info (struct disassemble_info
*dinfo, void *stream,
      |             ^~~~~~~~~~~~~~~~~~~~~
make[4]: *** [tools/build/Makefile.build:97: util/annotate.o] Error 1

Please refer link [3] for more details,

[1] https://lore.kernel.org/bpf/20220715191641.go6xbmhic3kafcsc@awork3.anarazel.de/T/
[2] https://builds.tuxbuild.com/2C7WeIEmOBAGYdKtUjtXB0Yn7Ts/
[3] https://qa-reports.linaro.org/lkft/linux-mainline-master/build/v5.19-rc6-448-gff6992735ade/testrun/10863106/suite/build/test/gcc-11-lkftconfig-perf/history/

Best regards
Naresh Kamboju


--
Linaro LKFT
https://lkft.linaro.org
