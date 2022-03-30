Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4EA034ECF0E
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Mar 2022 23:50:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351375AbiC3Vv2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Mar 2022 17:51:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351367AbiC3VvZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Mar 2022 17:51:25 -0400
Received: from mail-oo1-xc2c.google.com (mail-oo1-xc2c.google.com [IPv6:2607:f8b0:4864:20::c2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01F254ECE9;
        Wed, 30 Mar 2022 14:49:39 -0700 (PDT)
Received: by mail-oo1-xc2c.google.com with SMTP id v19-20020a056820101300b0032488bb70f5so3838919oor.5;
        Wed, 30 Mar 2022 14:49:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=rgtOCaQYJg3zKcFPdllEeiUjgiabRKTrH5ORYrE4T/w=;
        b=hcRkM3UUJebrww/R5w9mUzbe4kbD7nt8Zr27Ne3DO2YKmNtyuBhz7MdfCl7QN9pr1D
         p63Ln8FOd31sVxrxoAo1uiMPRE8nRqiSuFQf6SFMvEOSFOu+ouzalkWbW0gNGOI0yQUY
         9sVh6K6DMQ6mgi2LzfhO3DslOGMXYCnUM8GL4OvwzHclSR/J4xXUXaA2l6YBYM3lvmg9
         YM/st1cfT2fSt/TDAIJQZvX8ugc7IgzXs3SPFH/amVDI4+euD8VgKR3xncVgSbTNF+8m
         lwW9a6fkepdrD8e5r1rDJkNqoLeBMRRP497JdMNpDh5pP8recQEFKuAr5+TUbzkI6Yc4
         YcWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=rgtOCaQYJg3zKcFPdllEeiUjgiabRKTrH5ORYrE4T/w=;
        b=KQeeEE5fW9+tZXqV+QfbQk/B7WAqPdRGrL29oYSkPoyQHiFUjQkRpWYtNaQIBob+eA
         OSzScax7Q26sV/QT1vZ6DZ7Wq9XA2wxoB4BvBiUTl27fMj5oKhjC72nXHSIuk7/LZpq7
         eXDIJHFEHy8wOHXnSBYKDK3KQCXfDTYolA6eTNTwen7XqGZjv+jzxnCMy4Zon6Kd2gmi
         Wx9ExsM9HXH5YlS4/lXJJR0lP6aEDLECdzzmfNj0w0TS3Mw6Z9JD6HSt1pKucoa4h5JD
         vVpxP3xIMqEvVGsyhza782LTWwmEQWSA8Bq4a5ZNiD5FTUTr5Z8YEn7rm8Sl0vyyu0oD
         JRLA==
X-Gm-Message-State: AOAM530qBSJw2fZKQ7bGlDK2mIhNXD6Z8wutAxp+C6bhYwePbntUJdrp
        WqFG3AkWNnYsUNMksPKjqNI=
X-Google-Smtp-Source: ABdhPJyslGYd+OW+6Ie3G5pBE4WtxdK370h79rqT9IOF4vx5o9fKxTiYz+BQffxhQlVGrM1qsRu15A==
X-Received: by 2002:a4a:3c47:0:b0:320:f0d5:25a7 with SMTP id p7-20020a4a3c47000000b00320f0d525a7mr3914783oof.58.1648676978240;
        Wed, 30 Mar 2022 14:49:38 -0700 (PDT)
Received: from marsc.168.1.7 ([2804:30c:b6b:3900:e3fc:1545:cb91:17fb])
        by smtp.gmail.com with ESMTPSA id q40-20020a056830442800b005c9274907a0sm11613815otv.10.2022.03.30.14.49.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Mar 2022 14:49:37 -0700 (PDT)
Date:   Wed, 30 Mar 2022 18:49:33 -0300
From:   Marcelo Schmitt <marcelo.schmitt1@gmail.com>
To:     corbet@lwn.net, mchehab+huawei@kernel.org, dlatypov@google.com,
        davidgow@google.com
Cc:     linux-doc@vger.kernel.org, linux-sparse@vger.kernel.org,
        cocci@inria.fr, smatch@vger.kernel.org,
        linux-kernel@vger.kernel.org, skhan@linuxfoundation.org,
        dan.carpenter@oracle.com, julia.lawall@inria.fr
Subject: [PATCH v3 1/2] Documentation: dev-tools: Add a section for static
 analysis tools
Message-ID: <7d793c1b9f87d9cb8ac0e858e561e108c2bf0176.1648674305.git.marcelo.schmitt1@gmail.com>
References: <cover.1648674305.git.marcelo.schmitt1@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1648674305.git.marcelo.schmitt1@gmail.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Complement the Kernel Testing Guide documentation page by adding a
section about static analysis tools.

Signed-off-by: Marcelo Schmitt <marcelo.schmitt1@gmail.com>
Acked-by: Daniel Latypov <dlatypov@google.com>
Acked-by: Dan Carpenter <dan.carpenter@oracle.com>
Acked-by: Julia Lawall <julia.lawall@inria.fr>
Reviewed-by: David Gow <davidgow@google.com>
Reviewed-by: Shuah Khan <skhan@linuxfoundation.org>
---
Change log v2 -> v3:
- Added Julia's acknowledgment tag

Change log v1 -> v2:
- Brought generic tool characteristics to the intro paragraph
- Made explicit that these tools run at compile time
- Added a note of caution about false positives
- Updated Coccinelle info to make it sound better and be more skimmable

 Documentation/dev-tools/testing-overview.rst | 31 ++++++++++++++++++++
 1 file changed, 31 insertions(+)

diff --git a/Documentation/dev-tools/testing-overview.rst b/Documentation/dev-tools/testing-overview.rst
index 65feb81edb14..b5e02dd3fd94 100644
--- a/Documentation/dev-tools/testing-overview.rst
+++ b/Documentation/dev-tools/testing-overview.rst
@@ -115,3 +115,34 @@ that none of these errors are occurring during the test.
 Some of these tools integrate with KUnit or kselftest and will
 automatically fail tests if an issue is detected.
 
+Static Analysis Tools
+=====================
+
+In addition to testing a running kernel, one can also analyze kernel source code
+directly (**at compile time**) using **static analysis** tools. The tools
+commonly used in the kernel allow one to inspect the whole source tree or just
+specific files within it. They make it easier to detect and fix problems during
+the development process.
+
+Sparse can help test the kernel by performing type-checking, lock checking,
+value range checking, in addition to reporting various errors and warnings while
+examining the code. See the Documentation/dev-tools/sparse.rst documentation
+page for details on how to use it.
+
+Smatch extends Sparse and provides additional checks for programming logic
+mistakes such as missing breaks in switch statements, unused return values on
+error checking, forgetting to set an error code in the return of an error path,
+etc. Smatch also has tests against more serious issues such as integer
+overflows, null pointer dereferences, and memory leaks. See the project page at
+http://smatch.sourceforge.net/.
+
+Coccinelle is another static analyzer at our disposal. Coccinelle is often used
+to aid refactoring and collateral evolution of source code, but it can also help
+to avoid certain bugs that occur in common code patterns. The types of tests
+available include API tests, tests for correct usage of kernel iterators, checks
+for the soundness of free operations, analysis of locking behavior, and further
+tests known to help keep consistent kernel usage. See the
+Documentation/dev-tools/coccinelle.rst documentation page for details.
+
+Beware, though, that static analysis tools suffer from **false positives**.
+Errors and warns need to be evaluated carefully before attempting to fix them.
-- 
2.35.1

