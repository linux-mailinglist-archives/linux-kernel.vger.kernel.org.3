Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2BDBC58F871
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Aug 2022 09:36:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234430AbiHKHgi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Aug 2022 03:36:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234387AbiHKHgh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Aug 2022 03:36:37 -0400
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80046760DC;
        Thu, 11 Aug 2022 00:36:35 -0700 (PDT)
Received: by mail-wr1-x435.google.com with SMTP id l22so20360389wrz.7;
        Thu, 11 Aug 2022 00:36:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc;
        bh=Q+M/Ei4z/9flNNflHidTkNITO8TheJ0Nv943Fts2T+A=;
        b=LVCH/Ij3Py21juhGxn1b+F6rrhGeClY5kgx0BI50aSwOxC7SW+pr5zxFIcPg07AuSg
         W7wDN3nCzN1mwDvntQqzrsuVqOksRF0+JKghyafWfZADJxXnJd6pwnOmkKI/dWxv2gvV
         AnORFv1U/C2OUC5+K4NTay4RdUlfBXXcZNTLf+pVo3zOdp76z2dSzob2E3qxQ2Craj8S
         vXuPimr5OoB+ksE59Fc7zhiZ6Cnqp28wexBeyPb6dNOCDdzhaRwyCmHJBcCmhHBNrnKs
         J1K6Ai/oP8+EHSrBJbRjNq1Xb0P67JV1Y4CSaRmXrKBHJwOHnaeqTKU40NGNh0VhkmNf
         b80w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc;
        bh=Q+M/Ei4z/9flNNflHidTkNITO8TheJ0Nv943Fts2T+A=;
        b=pyo/VsX0//T0l5EaSVdm2BgvD7Vyjor88a8Gj/fIRFtPjV2cDzZSxphZ1X3K2U25SH
         be3N9MD9NwJMChrgZjuCjDicy2vkqgp6iUPvVsrdWeKoONFmSpuOJc+rHfNKwgtpfKm4
         Pv/k8L/PgijcFF1WE8YN+CwkVAeud+GDbHHabhR5cLvAOs2HLTY8WfDTitcZHriIF6wS
         QUpUi9feBXX32Aplvln1g8EbvXzOHyRLWLz/hcf2hw0zAij8pqcFmF7bFUMnvm0hoxhm
         TMYbQ9pDLW0Wtt8z9wyufI50v2bLak9MoSql1j33rHTk3uTViXwaPJgz+ibP+5AmoYmY
         vDHg==
X-Gm-Message-State: ACgBeo2XexUgZT6J59F+u1QpIiSH9EQqBdmdusrPYXBnncWAO/GkfBED
        FaP+yKmJ9FJt5aArCHDROc8=
X-Google-Smtp-Source: AA6agR48A2aRx6lCPQhU0oFLhXbucTR2V2Whf6fqL9yZpK447fFs/42nkfgNMdFzeQEJ2kb+1njhZA==
X-Received: by 2002:a5d:6d07:0:b0:220:68a1:9ecb with SMTP id e7-20020a5d6d07000000b0022068a19ecbmr19963855wrq.116.1660203394052;
        Thu, 11 Aug 2022 00:36:34 -0700 (PDT)
Received: from debian ([2405:201:8005:8149:e5c9:c0ac:4d82:e94b])
        by smtp.gmail.com with ESMTPSA id l3-20020a05600c4f0300b003a4bb3f9bc6sm5142085wmq.41.2022.08.11.00.36.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Aug 2022 00:36:33 -0700 (PDT)
Date:   Thu, 11 Aug 2022 08:36:24 +0100
From:   "Sudip Mukherjee (Codethink)" <sudipm.mukherjee@gmail.com>
To:     Masahiro Yamada <masahiroy@kernel.org>,
        Michal Marek <michal.lkml@markovi.net>,
        Nick Desaulniers <ndesaulniers@google.com>
Cc:     linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org,
        torvalds@linux-foundation.org,
        Nathan Chancellor <nathan@kernel.org>,
        clang-built-linux <llvm@lists.linux.dev>
Subject: mainline build failure for arm64 allmodconfig with clang
Message-ID: <YvSxeDkmwxcJL+Z0@debian>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi All,

The latest mainline kernel branch fails to build for arm64 allmodconfig
with clang. The errors are:

sound/soc/sof/ipc3-topology.c:2343:4: error: format specifies type 'unsigned char' but the argument has type 'int' [-Werror,-Wformat]
                 SOF_ABI_MAJOR, SOF_ABI_MINOR, SOF_ABI_PATCH);
                 ^~~~~~~~~~~~~
./include/linux/dev_printk.h:150:67: note: expanded from macro 'dev_info'
        dev_printk_index_wrap(_dev_info, KERN_INFO, dev, dev_fmt(fmt), ##__VA_ARGS__)
                                                                 ~~~     ^~~~~~~~~~~
./include/linux/dev_printk.h:110:23: note: expanded from macro 'dev_printk_index_wrap'
                _p_func(dev, fmt, ##__VA_ARGS__);                       \
                             ~~~    ^~~~~~~~~~~
./include/uapi/sound/sof/abi.h:30:23: note: expanded from macro 'SOF_ABI_MAJOR'
#define SOF_ABI_MAJOR 3
                      ^
sound/soc/sof/ipc3-topology.c:2343:19: error: format specifies type 'unsigned char' but the argument has type 'int' [-Werror,-Wformat]
                 SOF_ABI_MAJOR, SOF_ABI_MINOR, SOF_ABI_PATCH);
                                ^~~~~~~~~~~~~
./include/linux/dev_printk.h:150:67: note: expanded from macro 'dev_info'
        dev_printk_index_wrap(_dev_info, KERN_INFO, dev, dev_fmt(fmt), ##__VA_ARGS__)
                                                                 ~~~     ^~~~~~~~~~~
./include/linux/dev_printk.h:110:23: note: expanded from macro 'dev_printk_index_wrap'
                _p_func(dev, fmt, ##__VA_ARGS__);                       \
                             ~~~    ^~~~~~~~~~~
./include/uapi/sound/sof/abi.h:31:23: note: expanded from macro 'SOF_ABI_MINOR'
#define SOF_ABI_MINOR 23
                      ^~
sound/soc/sof/ipc3-topology.c:2343:34: error: format specifies type 'unsigned char' but the argument has type 'int' [-Werror,-Wformat]
                 SOF_ABI_MAJOR, SOF_ABI_MINOR, SOF_ABI_PATCH);
                                               ^~~~~~~~~~~~~
./include/linux/dev_printk.h:150:67: note: expanded from macro 'dev_info'
        dev_printk_index_wrap(_dev_info, KERN_INFO, dev, dev_fmt(fmt), ##__VA_ARGS__)
                                                                 ~~~     ^~~~~~~~~~~
./include/linux/dev_printk.h:110:23: note: expanded from macro 'dev_printk_index_wrap'
                _p_func(dev, fmt, ##__VA_ARGS__);                       \
                             ~~~    ^~~~~~~~~~~
./include/uapi/sound/sof/abi.h:32:23: note: expanded from macro 'SOF_ABI_PATCH'
#define SOF_ABI_PATCH 0
                      ^
3 errors generated.

drivers/ntb/hw/idt/ntb_hw_idt.c:2409:28: error: format specifies type 'unsigned char' but the argument has type 'int' [-Werror,-Wformat]
                                "\t%hhu-%hhu.\t", idx, idx + cnt - 1);
                                        ~~~~           ^~~~~~~~~~~~~
                                        %d
drivers/ntb/hw/idt/ntb_hw_idt.c:2438:29: error: format specifies type 'unsigned char' but the argument has type 'int' [-Werror,-Wformat]
                                        "\t%hhu-%hhu.\t", idx, idx + cnt - 1);
                                                ~~~~           ^~~~~~~~~~~~~
                                                %d
drivers/ntb/hw/idt/ntb_hw_idt.c:2484:15: error: format specifies type 'unsigned char' but the argument has type 'int' [-Werror,-Wformat]
                        idx, data, src, ndev->peers[src].port);
                                   ^~~
3 errors generated.

For both, git bisect points to 0af5cb349a2c ("Merge tag 'kbuild-v5.20' of git://git.kernel.org/pub/scm/linux/kernel/git/masahiroy/linux-kbuild")

The last good build for arm64 clang was with e394ff83bbca ("Merge tag 'nfsd-6.0' of git://git.kernel.org/pub/scm/linux/kernel/git/cel/linux")

I will be happy to test any patch or provide any extra log if needed.


--
Regards
Sudip
