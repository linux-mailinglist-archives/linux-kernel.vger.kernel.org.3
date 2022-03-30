Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BF4BD4ECF17
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Mar 2022 23:50:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351394AbiC3Vvx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Mar 2022 17:51:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351386AbiC3Vvv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Mar 2022 17:51:51 -0400
Received: from mail-ot1-x32a.google.com (mail-ot1-x32a.google.com [IPv6:2607:f8b0:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2029452E4A;
        Wed, 30 Mar 2022 14:50:05 -0700 (PDT)
Received: by mail-ot1-x32a.google.com with SMTP id a17-20020a9d3e11000000b005cb483c500dso15841487otd.6;
        Wed, 30 Mar 2022 14:50:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=/Bthg0jq8/Diwhpq69bZsSJ8jzbwEA8PqoPE66yQfog=;
        b=Nfga8Hiai6jnPWHrcn37JnCAYeEsSoYIS9lAUi9RUj2zZYm6zwUuleYAr7hSaiQ+g1
         ezHH1BNKWxE5sAnlDb/uVvp0fX1dtnGpx8Y+6IFrxHZxQaJY2tyB3TivVEKNXAe6UIsU
         Hx99eHfTEChpbiQP+3UPY/45nATjnpWrkSQXHOos+OBwIqEa6Z/H1Cf+fmpQCy7PF/y6
         r8aMcAl4DO8EOa36fBm9jnaV19bmtTp6vEv6abQBDv+tXv1DrOf/J+I3eH28D9Ru3QoD
         ucw4pTnSDYCTLLdjqV7iWlyghBr7hm1mpL+ZqHkcsQVfU6W9/AbMFC+hyAwt5tVsgDp1
         UVcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=/Bthg0jq8/Diwhpq69bZsSJ8jzbwEA8PqoPE66yQfog=;
        b=gwuwp4i137raIWUEryehgHk+kJpAvsL9tSWhDb8clvF9riz0tgmwLyG2sxrGORdrgF
         yZB7UDhwcASsux+9i5YWvf0Xk1JlRtDjnEAR7Y1rVxIO8/OaUY7+DaZvIpcrQbXOudl6
         JuuonlfIndE2HW2nNfIM0I3SbjYo0Etgr0IQ4b/og1oLMPIYITAtkYJt4Ljwlfjcm6ls
         l9DONRrbe+qT1zya6ug4qqJFG3lxQVrxuX72VY623Culv6TqKc0cXt5KrHY7WX9b6Wnf
         fPjr1DlSEOsSOwne/QJjTkWnMxkZfg6LT6/4Dyw4N2deve/TtX9FwpuvuqK0xHlbrV2T
         4iKQ==
X-Gm-Message-State: AOAM530un3pnM8oawvKnsnWl5W1osTawdHRJwul/fOQr2NpVihO8bzWb
        hyBHXvrdZu33u6nyA+SZqew=
X-Google-Smtp-Source: ABdhPJzYJPepEvTuy6SmKbubOCp4UcpWJ95SWPN6CgROFQTdx2QTEQRmi4KeYdD9Ta8dyzx18zTjfQ==
X-Received: by 2002:a05:6830:2478:b0:5c9:289c:597f with SMTP id x56-20020a056830247800b005c9289c597fmr4244500otr.130.1648677004423;
        Wed, 30 Mar 2022 14:50:04 -0700 (PDT)
Received: from marsc.168.1.7 ([2804:30c:b6b:3900:e3fc:1545:cb91:17fb])
        by smtp.gmail.com with ESMTPSA id w4-20020a4adec4000000b0032109de628esm10535874oou.6.2022.03.30.14.50.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Mar 2022 14:50:03 -0700 (PDT)
Date:   Wed, 30 Mar 2022 18:49:59 -0300
From:   Marcelo Schmitt <marcelo.schmitt1@gmail.com>
To:     corbet@lwn.net, mchehab+huawei@kernel.org, dlatypov@google.com,
        davidgow@google.com
Cc:     linux-doc@vger.kernel.org, linux-sparse@vger.kernel.org,
        cocci@inria.fr, smatch@vger.kernel.org,
        linux-kernel@vger.kernel.org, skhan@linuxfoundation.org,
        dan.carpenter@oracle.com, julia.lawall@inria.fr
Subject: [PATCH v3 2/2] Documentation: dev-tools: Enhance static analysis
 section with discussion
Message-ID: <62f461a20600b95e694016c4e5348ef2e260fa87.1648674305.git.marcelo.schmitt1@gmail.com>
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

Enhance the static analysis tools section with a discussion on when to
use each of them.

This was mainly taken from Dan Carpenter and Julia Lawall's comments on
a previous documentation patch for static analysis tools.

Lore: https://lore.kernel.org/linux-doc/20220329090911.GX3293@kadam/T/#mb97770c8e938095aadc3ee08f4ac7fe32ae386e6

Signed-off-by: Marcelo Schmitt <marcelo.schmitt1@gmail.com>
Acked-by: David Gow <davidgow@google.com>
Cc: Dan Carpenter <dan.carpenter@oracle.com>
Cc: Julia Lawall <julia.lawall@inria.fr>
---
Change log v2 -> v3:
- Changed the paragraph about Sparse to make it sound better (hopefully)
- Minor adjusts to make the considerations about Coccinelle sound better
  and be precise

 Documentation/dev-tools/testing-overview.rst | 32 ++++++++++++++++++++
 1 file changed, 32 insertions(+)

diff --git a/Documentation/dev-tools/testing-overview.rst b/Documentation/dev-tools/testing-overview.rst
index b5e02dd3fd94..0aaf6ea53608 100644
--- a/Documentation/dev-tools/testing-overview.rst
+++ b/Documentation/dev-tools/testing-overview.rst
@@ -146,3 +146,35 @@ Documentation/dev-tools/coccinelle.rst documentation page for details.
 
 Beware, though, that static analysis tools suffer from **false positives**.
 Errors and warns need to be evaluated carefully before attempting to fix them.
+
+When to use Sparse and Smatch
+-----------------------------
+
+Sparse does type checking, such as verifying that annotated variables do not
+cause endianness bugs, detecting places that use ``__user`` pointers improperly,
+and analyzing the compatibility of symbol initializers.
+
+Smatch does flow analysis and, if allowed to build the function database, it
+also does cross function analysis. Smatch tries to answer questions like where
+is this buffer allocated? How big is it? Can this index be controlled by the
+user? Is this variable larger than that variable?
+
+It's generally easier to write checks in Smatch than it is to write checks in
+Sparse. Nevertheless, there are some overlaps between Sparse and Smatch checks.
+
+Strong points of Smatch and Coccinelle
+--------------------------------------
+
+Coccinelle is probably the easiest for writing checks. It works before the
+pre-processor so it's easier to check for bugs in macros using Coccinelle.
+Coccinelle also creates patches for you, which no other tool does.
+
+For example, with Coccinelle you can do a mass conversion from
+``kmalloc(x * size, GFP_KERNEL)`` to ``kmalloc_array(x, size, GFP_KERNEL)``, and
+that's really useful. If you just created a Smatch warning and try to push the
+work of converting on to the maintainers they would be annoyed. You'd have to
+argue about each warning if can really overflow or not.
+
+Coccinelle does no analysis of variable values, which is the strong point of
+Smatch. On the other hand, Coccinelle allows you to do simple things in a simple
+way.
-- 
2.35.1

