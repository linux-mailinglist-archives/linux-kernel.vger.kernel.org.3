Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C897D51CF0F
	for <lists+linux-kernel@lfdr.de>; Fri,  6 May 2022 04:48:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1388359AbiEFCvv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 May 2022 22:51:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234479AbiEFCvt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 May 2022 22:51:49 -0400
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C368B5C759;
        Thu,  5 May 2022 19:48:06 -0700 (PDT)
Received: by mail-pj1-x102a.google.com with SMTP id z5-20020a17090a468500b001d2bc2743c4so5762250pjf.0;
        Thu, 05 May 2022 19:48:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:from:to:cc:subject:references:mime-version
         :content-disposition:in-reply-to;
        bh=Qn/FCRe6ikmZ0D8cIGMrAu399NCLzjkcF3KaCfh8Y1E=;
        b=L5AvtlXeOQQkbwm6vwDrjMEl6yCbiYfJVNA8TcZ/0gEuNErk10gQ6z96wdVQzHpiGB
         V+OlpckKUQeIETl/K4IIChdxgr5jTKVqBH+QaYiTbdnEsTGp1tgRIiETqG+yrL3duKvh
         WEZjFMPJ1dzAQPV2k1wkCnSUInUTWKGReIEwoI2QrjaUcI9k3xNpkB4TqWt6TtSBhW4t
         nZAgHsifUPZHgBikQr2cgzLR0cCCbz7S4RUfORt08d+23/wFqP3ecqlh8oqcif5s7bvQ
         v/u5jdz5TFGAziUs5P5dVzRwsuaAxhbO+Mw48lSPwwSER5TPyQX31l7H43lvgzojxbQw
         MSdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:from:to:cc:subject:references
         :mime-version:content-disposition:in-reply-to;
        bh=Qn/FCRe6ikmZ0D8cIGMrAu399NCLzjkcF3KaCfh8Y1E=;
        b=Y59mrqk1+7pBBsTFy2V+yU7cwU2l0lwgca71VRfZEfwrKAI37Q7c+JtmtycYkWSjKc
         kCoG2YaOPMOXFQ3r1wJcGIMmhtTA0orT7Zy3wP8061OmoCKM9k5QbICDkX6yWHUsnFib
         NuYVksCMXvcslrvszzLbzEsIER7m7MlvqxLN3LYtTgVvKLspF6lDQJoMM+A2TFFCGKVu
         S9sFhtG3Twe5mkTdvu+NQbyQHCSIwTq74Hvl089jsuV1D/JWPLXwHXff5xPF6EvOkuaE
         jiwIFGKXf77p+awlfywO32eNeqwlNtOJtgC5oZYGv5kp8HeDm7fHz5ivfowOykE9yyBv
         3VTg==
X-Gm-Message-State: AOAM5333WM2DuYLLYJfyrpoIMv48OB9+sL4aYPfhkmfqClUAMRfXH4+o
        jSydTJSG9n7Ml0+2M8jGfFM=
X-Google-Smtp-Source: ABdhPJyKuJaQFpqa+4PgRSDgRF97xmDyaGXAxo/h2UIXy5cO6Z+WNXNIe39wnZNhpRal5o00w+OE0A==
X-Received: by 2002:a17:90a:4d04:b0:1d9:3f18:f4dd with SMTP id c4-20020a17090a4d0400b001d93f18f4ddmr1595685pjg.111.1651805286294;
        Thu, 05 May 2022 19:48:06 -0700 (PDT)
Received: from localhost ([193.203.214.57])
        by smtp.gmail.com with ESMTPSA id e30-20020a631e1e000000b003c14af5060asm2020165pge.34.2022.05.05.19.48.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 May 2022 19:48:05 -0700 (PDT)
Message-ID: <62748c65.1c69fb81.2aa2d.4a7b@mx.google.com>
X-Google-Original-Message-ID: <20220506024804.GA356087@cgel.zte@gmail.com>
Date:   Fri, 6 May 2022 02:48:04 +0000
From:   CGEL <cgel.zte@gmail.com>
To:     akpm@linux-foundation.org
Cc:     akpm@linux-foundation.org, david@redhat.com,
        kbuild-all@lists.01.org, corbet@lwn.net, bsingharora@gmail.com,
        mike.kravetz@oracle.com, yang.yang29@zte.com.cn,
        sfr@canb.auug.org.au, thomas.orgis@uni-hamburg.de,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org
Subject: Re: [PATCH] delayacct: track delays from write-protect copy
References: <20220408103708.2495882-1-yang.yang29@zte.com.cn>
 <202204082220.1w5xTsNt-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202204082220.1w5xTsNt-lkp@intel.com>
X-Spam-Status: No, score=-0.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SCC_BODY_URI_ONLY,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi
    I found this patch is first merged into linux-next, and dropped silently
without sending any mail. Could you please tell the reason? Thanks!
    It was merged by this:
    https://lore.kernel.org/all/20220409031312.583D3C385A4@smtp.kernel.org/
  
