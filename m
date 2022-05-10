Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 746E7522556
	for <lists+linux-kernel@lfdr.de>; Tue, 10 May 2022 22:17:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230463AbiEJURi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 May 2022 16:17:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229468AbiEJURh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 May 2022 16:17:37 -0400
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 324FF1BEAB
        for <linux-kernel@vger.kernel.org>; Tue, 10 May 2022 13:17:36 -0700 (PDT)
Received: by mail-pl1-x62f.google.com with SMTP id n18so17762213plg.5
        for <linux-kernel@vger.kernel.org>; Tue, 10 May 2022 13:17:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=poInoMRDMAyFPERzf3TuvkYoli3B3ZRtvFA2DZ7+QuU=;
        b=Aw23TlWZZS2FnRrrRBhkwOsxgQKqGm7shosIK0f+LI427MQZf64fMzusuz0qIhkZNq
         XicMBtimef3MJHKtSLZgYdhZXi1/qHc/18YKBBvqNisN9gNXJJHrSAL45wTZNs0eaBh7
         0cLG+ymeAFvqkzeg2LPc/VqjYftu6Ru5X60r0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=poInoMRDMAyFPERzf3TuvkYoli3B3ZRtvFA2DZ7+QuU=;
        b=4i85nVHc2wp7dXgFhrqjOqyeySg7H3lowXL1DfFiM4RJ9/r0uMoGMrTYSNGU37L+Xr
         rEabkQeOJlS9ONlMOfBVdymUAOZ1Bhfr8Jf6Od5UUrf19b4pb734zkEJOKEnO219xACB
         5u2RYuChsui4/HNGWsPCstwqSagsKJ3koJa76iqYcH6TEUODtonezDUSGxmXkfby5BG3
         1s2ewIcL3xWK9EB7drizlMlXv98Szh+lO/M0J7NSfTcYezrpoPvEmKnYDbRDXB+kmcIn
         1C19cTWu9VlMExnFsrDbEyTVpEqFDcChfFGQSXi9i2Or6x1iCeSepiFIbAbZT53+LVTy
         7g1g==
X-Gm-Message-State: AOAM530Kn5qZmPEZDOdXEYKZAJ+W0jdJ7U3V/wKnEX6IjbU7ZqYDB+H5
        Ew4ejeYxWdlLmBeZM00FstOFSg==
X-Google-Smtp-Source: ABdhPJxmq6Ox83jEddwu6Xv+2Ce/pOzQwMQlLEyL1SMHKmCZ2WXcEocBB0aVaO3xFdpIm8MAxoNm8Q==
X-Received: by 2002:a17:903:40c3:b0:15e:9d4a:5d24 with SMTP id t3-20020a17090340c300b0015e9d4a5d24mr21927232pld.77.1652213855736;
        Tue, 10 May 2022 13:17:35 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id g10-20020aa7818a000000b0050dc76281a6sm11126456pfi.128.2022.05.10.13.17.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 May 2022 13:17:35 -0700 (PDT)
Date:   Tue, 10 May 2022 13:17:34 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Ira Weiny <ira.weiny@intel.com>
Cc:     Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Fenghua Yu <fenghua.yu@intel.com>,
        Rick Edgecombe <rick.p.edgecombe@intel.com>,
        "Shankar, Ravi V" <ravi.v.shankar@intel.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH V10 08/44] Documentation/pkeys: Add initial PKS
 documentation
Message-ID: <202205101316.C611115CC3@keescook>
References: <20220419170649.1022246-1-ira.weiny@intel.com>
 <20220419170649.1022246-9-ira.weiny@intel.com>
 <202205091501.132944B2C7@keescook>
 <YnqeYBzvatHL1XYZ@iweiny-desk3>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YnqeYBzvatHL1XYZ@iweiny-desk3>
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 10, 2022 at 10:18:24AM -0700, Ira Weiny wrote:
> Both Rick and I have been able to run with the following options to qemu:
> 
> qemu-system-x86_64 ... -machine accel=tcg -cpu qemu64,+pks ...

Ah-ha! Thank you; this works for me. :) I can confirm the tests run as
expected. :)

-- 
Kees Cook
