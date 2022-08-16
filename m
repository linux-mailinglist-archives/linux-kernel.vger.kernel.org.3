Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EEFB05963D1
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Aug 2022 22:40:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237253AbiHPUkb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Aug 2022 16:40:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237251AbiHPUk2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Aug 2022 16:40:28 -0400
Received: from mail-qv1-xf2d.google.com (mail-qv1-xf2d.google.com [IPv6:2607:f8b0:4864:20::f2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6718F78BEF;
        Tue, 16 Aug 2022 13:40:27 -0700 (PDT)
Received: by mail-qv1-xf2d.google.com with SMTP id d1so8765978qvs.0;
        Tue, 16 Aug 2022 13:40:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:from:to:cc;
        bh=zVz88dPG3SS5bq8mIZmcCFkcMATpyXDqFd/31Ajfy40=;
        b=ggQIrIccsV+1lpm/KhcCBgwF0bYNbdtZMwgVN//PJn0nk9pgsiDyN2/2Ktm9m+K7SJ
         D0Ak9ohGg/P+UhiCmsxgIOum7CuxbSXJE76nqG9oCLVt/uLaDNBjo4ZgPE8F9fFgnOfM
         LkuW80PHBzZ7E/qjmxC6gnCecjaSPHv42y09dbAO8XsBYpLSRyTc5hodFKSWDxqTU7Z9
         fVQx5YjRI1bwJvXa8tvIAEALgRToYjjiA56la2zc7ns6xf1fBbiViYiB5Jilvjx9DT/P
         L0G0JsHsRhgruuDEnpi90I2dro/iyMrQZJr14+oJO3ywmjxC707jhoZ5H4Lanthhl6Xt
         KjZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:x-gm-message-state:from:to:cc;
        bh=zVz88dPG3SS5bq8mIZmcCFkcMATpyXDqFd/31Ajfy40=;
        b=eF8g7eWSkY3yO4+Mgn8yLTnDOa5iOooccy+8RStLjTkW5yCnUqda+S6xzObxYyh1Ta
         wvlYaPRcVQMbfXx82TE0UPuB31zCWPicMqqJTeJBnSnzOTbC/8UpyJmEI0jxGbekYnCc
         5ExJd2zRcm3452y6WY6ecnR7SPbfnnOvr6R8fnOAEwIF5GWqzQO2vsgjDWcr3eTurZIc
         bKIVN5XL7ldfR4kAURop5E1ruRgWEruF3/lkDTWIKp0FMvRL63uPJ1+VJqZhUor0umzk
         zRiZHZJKppYLBrZ/RMPqUu/AFMh3Yh7YCuMx/Vlzihfes+pGqveSAnyzVxzEZjmH1byO
         v0bg==
X-Gm-Message-State: ACgBeo1ub/KnHVIYArwvuPB8RyhAuQdnYrqkwznZzghm8C54vsVqMUmh
        L0gyoay2N1vNrw5rngN767Bh6hWODLc=
X-Google-Smtp-Source: AA6agR7Q0NEmHVJRSIDwJrsBTNmweil8tt9OTVSy93/WYc/2Nl+EKhIjSVW1zXDZbszDONuv2bGyIQ==
X-Received: by 2002:ad4:5c85:0:b0:474:7ce3:5fb with SMTP id o5-20020ad45c85000000b004747ce305fbmr19606157qvh.76.1660682426308;
        Tue, 16 Aug 2022 13:40:26 -0700 (PDT)
Received: from fionn.redhat.com ([142.189.102.90])
        by smtp.gmail.com with ESMTPSA id h5-20020a05620a400500b006b615cd8c13sm12703014qko.106.2022.08.16.13.40.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Aug 2022 13:40:25 -0700 (PDT)
Sender: John Kacur <jkacur@gmail.com>
From:   John Kacur <jkacur@redhat.com>
To:     RT <linux-rt-users@vger.kernel.org>
Cc:     lkml <linux-kernel@vger.kernel.org>,
        Clark Williams <williams@redhat.com>,
        Kate Carcia Poulin <kcarcia@redhat.com>,
        Leah Leshchinsky <lleshchi@redhat.com>,
        Manasi Godse <gmanasi13@gmail.com>,
        Valentin Schneider <vschneid@redhat.com>,
        John Kacur <jkacur@redhat.com>
Subject: [ANNOUNCE] rteval-v3.5
Date:   Tue, 16 Aug 2022 16:40:05 -0400
Message-Id: <20220816204005.271589-1-jkacur@redhat.com>
X-Mailer: git-send-email 2.37.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I am pleased to announce the release of v3.5 of rteval

With this release we have removed misc.py and consolidated this
functionality in systopology.py There have been improvements to
systopology that take into account whether cpus are offline.

Using this interface there are changes that allow the user to input
cpulists in short form, ie, 0-4 instead of 0,1,2,3,4

Using these interfaces, reporting has been fixed so that offline cpus are considered in early reporting.

Leah added a patch that adds measurement and load cpus information to
the final report.

Valentin fixed a problem he uncovered testing on arm where the list of
load cpus was empty. This problem was caused by some of the above changes 
where an older interface produced a cpulist in string format but
the newer ones produce python lists.

Finally, we have a number of changes from Manasi. She made it possible
to download a kernel from kernel.org to the correct location for rteval whether you are running from git or from an rpm. This is used by kcompile in rteval which compiles a kernel as a load. She also made the interface more flexible for the user when specifying an alternative kernel to compile from the default.
(Look at the following command line options for this)
-S KERNEL_VERSION, --source-download=KERNEL_VERSION
                        download a source kernel from kernel.org and exit
--kcompile-source=TARBALL

These changes are especially useful for developers who may need to test
newer kernels with rteval, but also for rt-developers who are using
rteval directly from git and need to set it up before using.

Enjoy!

John

To fetch

Clone
git://git.kernel.org/pub/scm/utils/rteval/rteval.git

Branch: main
Tag: v3.5

Tarballs available here:
https://kernel.org/pub/linux/utils/rteval

Older version tarballs are available here:
https://kernel.org/pub/linux/utils/rteval/older

John Kacur (11):
  rteval: Create common  functions in CpuList and SysTopology
  rteval: Make use of systopology instead of misc in rteval-cmd
  rteval: Make use of systopology instead of misc in hackbench
  rteval: Make use of systopology instead of misc in kcompile
  rteval: Make use of systopology instead of misc in stressng module
  rteval: Make use of systopology instead of misc in cyclictest
  rteval: cyclictest: Reset cpulist from newly calculated cpus
  rteval: Allow user to enter compressed cpu-lists, fix reporting
  rteval: Move cpuinfo to systopology.py and delete misc.py
  rteval: Use "with" for open of loadavg
  rteval: Update version number to v3.5

Leah Leshchinsky (1):
  rteval: Add measurement and load location to run report

Manasi Godse (5):
  rteval: Add option for downloading kernel
  rteval: Add man page entry for -S, --source-download option
  rteval: restrict kernel source download with invalid file extensions
  rteval: fix regex in kcompile to calculate patch number for kernel
    prefix
  rteval: enhancement to --kcompile-source option for kernel tarball

Valentin Schneider (1):
  rteval: Fix loads cpulist restriction

 doc/rteval.8                             |   4 +
 rteval-cmd                               | 137 ++++++++++++++++++-----
 rteval.spec                              |   2 +-
 rteval/misc.py                           | 116 -------------------
 rteval/modules/loads/__init__.py         |  15 ++-
 rteval/modules/loads/hackbench.py        |  32 +++---
 rteval/modules/loads/kcompile.py         | 113 +++++++++++--------
 rteval/modules/loads/stressng.py         |  17 +--
 rteval/modules/measurement/__init__.py   |  10 +-
 rteval/modules/measurement/cyclictest.py |  69 +++++++-----
 rteval/rtevalConfig.py                   |   1 +
 rteval/rteval_text.xsl                   |   8 ++
 rteval/systopology.py                    | 134 +++++++++++++++++++---
 rteval/version.py                        |   2 +-
 14 files changed, 393 insertions(+), 267 deletions(-)
 delete mode 100755 rteval/misc.py

-- 

