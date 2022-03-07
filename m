Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E26344D0807
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Mar 2022 20:57:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245211AbiCGT6T (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Mar 2022 14:58:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245234AbiCGT56 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Mar 2022 14:57:58 -0500
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 663248A6CA
        for <linux-kernel@vger.kernel.org>; Mon,  7 Mar 2022 11:57:03 -0800 (PST)
Received: by mail-pj1-x1036.google.com with SMTP id cx5so15074146pjb.1
        for <linux-kernel@vger.kernel.org>; Mon, 07 Mar 2022 11:57:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=jYGBOhY+YvOBE5ajs2EKO/Fw4vwhlIv5/OzecyNBxUY=;
        b=MhVTEzfX5LNA3eMH4yHZ97/d4z2HLkI847Lak9vMWfOCsnxCKRkJarB6Z0uoMDtHIM
         rLIx2BOpMYdKEUxZnuXYu05aPKWFhrr0yibtTroCkQdK+KT+UgxHfq1J29KiozjMHbii
         iBv9/FOQazz0oO+Pwamqw9fCHZEwuzKjUbWEQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=jYGBOhY+YvOBE5ajs2EKO/Fw4vwhlIv5/OzecyNBxUY=;
        b=q3GQ2pNDNY63k3+jMIj9NipS81Ll5jWNrHwiejSWmX81VOMfBb4hOBJctvrTdrauO0
         0OuTgUTxE32Ay0JZnKiWimLP0L6dvz+I033Sx228WgEGzenbiksO14sXTsCnCDWUTa2T
         0wW98j+zeMIKfWcMZPs3s/BAwxDAayohJQ95kL0V56aXnnnW1H0Yq7E/EHdj7t2toHRw
         uqWYMVoyo/sHpDudi6lCNDIQm1jesVNUkNcLXV85aJIHXAL7XEsOIfInTD5ktJm5fd1s
         T06gRtw/y8aDzA3ZbLct1XBRFjv8uKYUOK65cBYx2Zh3wBE4uGHXk42idrHgJRPrfQTg
         BkRA==
X-Gm-Message-State: AOAM530yvQ+TDi61BdaoeYhpZo8Uo2UISsAyuZgrkFZDbvlPG2eXUg40
        yHLq2n3fLPZqQq2GfTijpSOzRktK3DxzqA==
X-Google-Smtp-Source: ABdhPJzFSwEk/kHMWe/4LsmtSbJfExBxEBu2A+0J/xfhRd+JxYC9ib8tEgYrzcL586sB3ZUTNQEB8w==
X-Received: by 2002:a17:902:cccf:b0:14e:eb44:40a1 with SMTP id z15-20020a170902cccf00b0014eeb4440a1mr13882125ple.111.1646683022900;
        Mon, 07 Mar 2022 11:57:02 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id q12-20020a17090aa00c00b001bc6f1baaaesm164252pjp.39.2022.03.07.11.57.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Mar 2022 11:57:02 -0800 (PST)
Date:   Mon, 7 Mar 2022 11:57:02 -0800
From:   Kees Cook <keescook@chromium.org>
To:     Max Filippov <jcmvbkbc@gmail.com>
Cc:     linux-xtensa@linux-xtensa.org, Chris Zankel <chris@zankel.net>,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH 1/2] xtensa: rename PT_SIZE to PT_KERNEL_SIZE
Message-ID: <202203071157.2218B9B29@keescook>
References: <20220306064435.256328-1-jcmvbkbc@gmail.com>
 <20220306064435.256328-2-jcmvbkbc@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220306064435.256328-2-jcmvbkbc@gmail.com>
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Mar 05, 2022 at 10:44:34PM -0800, Max Filippov wrote:
> PT_SIZE is used by the xtensa port to designate kernel exception frame
> size. In preparation for struct pt_regs size change rename PT_SIZE to
> PT_KERNEL_SIZE for clarity and change its definition to always cover
> only the kernel exception frame.
> 
> Signed-off-by: Max Filippov <jcmvbkbc@gmail.com>

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook
