Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0F76E4D408C
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Mar 2022 06:08:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239562AbiCJFJu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Mar 2022 00:09:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234788AbiCJFJs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Mar 2022 00:09:48 -0500
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 920B912BF4C
        for <linux-kernel@vger.kernel.org>; Wed,  9 Mar 2022 21:08:47 -0800 (PST)
Received: by mail-pj1-x1033.google.com with SMTP id kx6-20020a17090b228600b001bf859159bfso7262742pjb.1
        for <linux-kernel@vger.kernel.org>; Wed, 09 Mar 2022 21:08:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Vx3jrxPiNIo98gCv83TF5dMqDfpV8pYAw6iSM9f/F5k=;
        b=g/MJcp38patdOv3r8qxTwnp2zPKzdbMTTbWWm8bqFpWmkiUZ9EBt1NcDDtzBdNFEjE
         z14xUTv6AV8lVZOOK//7QzkvagSDHIDs0iBnhGb8ek/aRmvVq6sYd9K3U2S1rxaqXhhH
         n9twbc3yFgPv2WLcAslot1DG/Y93DfMoKFnmnA+s8/2cXlz3bxtmnmX5rGe+cjEgxqOz
         3MPSzhg1Mja+BFVKj4gEdVC4VnL2t7Dg5dgkU1JeiLNeDJr35SAjUa5YzImsmjJ1DCiC
         z4Tb28dqPA6j0nR72zj7MoyyDwW5k2H1OX/jMvhnpZ/H76NOtWksD7KLx7o8A+zixMzM
         0pKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Vx3jrxPiNIo98gCv83TF5dMqDfpV8pYAw6iSM9f/F5k=;
        b=LpUqy8bzcMI2iJpNG7YZGHISH4IedD25qRN0sSBBrVhF+C8+ZGa44DR1NS92iYPyFZ
         NBZ1ZC9B/VVagajepMJY8/CfYQ7vmy/Je/hVWcLAodru2B+ifw/6WQFYZWKDVMi+YW9Z
         2DbvDc3ReRJQx2HAAaFOY3Z2IwbxkiCMFeQ4tWoEkyn1pKlR8nBSFeGzrAV3Uu8bovOY
         O9FiNLn7dJY6uM/dGmNIy31t43D6uv2+9dfPc1JqQTJgoKrflzVaaAFgHoPOW/3Rtt+I
         w83Ol6geSAXrjioj79aRseNyR1+r/3XWozz2PgszadXKKKYJFwbqtGsabvMtVVeXhhco
         i9Hg==
X-Gm-Message-State: AOAM531pEAItIS/ER9Y/EhpKGGvcv1fzaN/eZZLLeCFxy67YFw4lIAHR
        Jizq3IdgMFrzrGle1x8MB7fcHzDsvvq6gwY0gGPsji72Omw=
X-Google-Smtp-Source: ABdhPJwbpnJGBhGCvtGDfxVPB8IEyjhbA0Vcu6XL0x5iAF4lObLLmyo2alFAEC40PFkEcocm/pnY+n3EqLanhKPd06Q=
X-Received: by 2002:a17:903:32d1:b0:151:da5c:60ae with SMTP id
 i17-20020a17090332d100b00151da5c60aemr3299570plr.34.1646888927080; Wed, 09
 Mar 2022 21:08:47 -0800 (PST)
MIME-Version: 1.0
References: <20220304203756.3487910-1-ira.weiny@intel.com>
In-Reply-To: <20220304203756.3487910-1-ira.weiny@intel.com>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Wed, 9 Mar 2022 21:08:36 -0800
Message-ID: <CAPcyv4juDzD4W_xAff2CdTFzKQhqfFkn93Zo_4Mw23v+Rq=1+g@mail.gmail.com>
Subject: Re: [PATCH] fs/dax: Fix run_dax() missing prototype
To:     "Weiny, Ira" <ira.weiny@intel.com>
Cc:     Vishal Verma <vishal.l.verma@intel.com>,
        Linux NVDIMM <nvdimm@lists.linux.dev>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 4, 2022 at 12:38 PM <ira.weiny@intel.com> wrote:
>
> From: Ira Weiny <ira.weiny@intel.com>
>
> The function run_dax() was missing a prototype when compiling with
> warnings.
>
> Add bus.h to fix this.
>

Always include the warning and the compiler in the changelog. I
suspect you hit this with LLVM and not gcc?

super.c has no business including bus.h. If the bots are tripping over
this a better fix is to move it into dax-private.h.
