Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2F15C4DBFB7
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Mar 2022 07:52:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230080AbiCQGxg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Mar 2022 02:53:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230042AbiCQGxX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Mar 2022 02:53:23 -0400
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com [IPv6:2607:f8b0:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0315FE6C57;
        Wed, 16 Mar 2022 23:52:05 -0700 (PDT)
Received: by mail-pf1-x42a.google.com with SMTP id s42so6148781pfg.0;
        Wed, 16 Mar 2022 23:52:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=uJWcE2jFJ9mIKDgXPPI83qOA+MOx6pJaPjrxpvWVjuQ=;
        b=pn7KiUlHNsHO4kgalgbLqrRX4GyI7J+AowftiG4P3mZ5dTvSQCNPg2ZWBhtesfjmIM
         N3cPBJWcqFbKrjAErwJnH/o4rNd1NUD5GPaEpdh7gcrNYX1epO0I+Rp1F1hmenAanSXt
         uqqG8gt5bCyj1E4wH4rZOKc6X/fM1sdbNJJPkyBU0o/OycGB4qG1kaIi+tPtZVQptfwB
         UjCYWKGXqyqW9GsNbdoqWwp9MWzNkq2rK0qpcpLF8wKEvPtXDcFPuCXYcXQa5W9tkiSa
         NvEkSEk5HvJrCsxoFulWonbDWG0mctUpUZLPwaGie/cef6yMhJZx5gUdnNfD6XSlLP83
         YnoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=uJWcE2jFJ9mIKDgXPPI83qOA+MOx6pJaPjrxpvWVjuQ=;
        b=OQBaCT89UL3nVzO2fnZBwOEJCNd+xTnj672zEb+ddvItFZB0NM3DxnzlMGFwP4q1D7
         tqtoMugBdhf4Kc0HA76OxxjpyYBm/mkUdU8jI60yoSrqjiuyGZ0GrLfTuUkQr0NsF0hu
         jnu9pxi2pmzLBAKbREZTaXBxvxfCqxrXK4hsV/A2htrtVrYmmdW7bkc8hUZuAOfI6Fnv
         5dHTMQRqrmAlPhBsGTqA2GaM5e3s5qRYNf3r/BpGcAw94N4GteQCAQeIljn6upJH95PQ
         agYEzHNCF12pXRGYR+1h2SInz6cmpfjMIudR0qnilJRPab+2d/OgsbXgEAXW4dpRTF50
         eX8w==
X-Gm-Message-State: AOAM532MJ/srfoyaCJq0XL+isa9VSwywGjz/JkOb0/oRzAvZyKr8jW2i
        gddAL/1Sp0QkHjy8cLpYTjE=
X-Google-Smtp-Source: ABdhPJwMZ0+vZrZgH2U8ovXGf+0CrhP3LZbrB5y3Env6a6w2gkNoTlUebUgT4XCRbajOzz7Hr0QEog==
X-Received: by 2002:a05:6a00:1a11:b0:4f7:bf07:c068 with SMTP id g17-20020a056a001a1100b004f7bf07c068mr3174982pfv.81.1647499925032;
        Wed, 16 Mar 2022 23:52:05 -0700 (PDT)
Received: from ubuntu ([140.121.198.208])
        by smtp.gmail.com with ESMTPSA id z16-20020a056a00241000b004f3a647ae89sm5701736pfh.174.2022.03.16.23.52.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Mar 2022 23:52:04 -0700 (PDT)
Date:   Thu, 17 Mar 2022 14:51:59 +0800
From:   Chih-En Lin <shiyn.lin@gmail.com>
To:     Borislav Petkov <bp@alien8.de>
Cc:     corbet@lwn.net, tglx@linutronix.de, mingo@redhat.com,
        dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org
Subject: Re: [PATCH] Documentation: x86: Fix obsolete name of page fault
 handler
Message-ID: <20220317065159.GA10609@ubuntu>
References: <20220314155901.227257-1-shiyn.lin@gmail.com>
 <YjIyZyDfg6+Hsq9a@zn.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YjIyZyDfg6+Hsq9a@zn.tnic>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
Thanks for reviewing.
I will fix all stuff mentioned.
Also, before submitting the next patch,
I will read/follow submitting-patch.rst carefully.

Thanks!
