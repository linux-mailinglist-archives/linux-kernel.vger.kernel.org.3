Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A294E51542B
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Apr 2022 20:57:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1380196AbiD2TAw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Apr 2022 15:00:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355618AbiD2TAt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Apr 2022 15:00:49 -0400
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D949CE657
        for <linux-kernel@vger.kernel.org>; Fri, 29 Apr 2022 11:57:30 -0700 (PDT)
Received: by mail-pj1-x1035.google.com with SMTP id o69so6497129pjo.3
        for <linux-kernel@vger.kernel.org>; Fri, 29 Apr 2022 11:57:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=2vtS1l3ByqcKp4N7+o2M0gYmr7gF9CuohmWWp8cIX+M=;
        b=7BTPYeZm6O6br9G8ZnSMamE4WFCR+yQdOZo77dRK50AG8mGG3VK9Hn0vPinMR+ESJm
         SsKWquBLv2xxGeLcIDsMT08i/xHTrL/nhZLRLSAnlhwrW5VRZF9rnSWQaLuIB2KFmiNb
         hbdNQ9QZur5zCasj4RxCZqgBpht29OnNnVAcZBY47ZpI+8AUbkIkxgNFaG7jkGCfP56o
         JdWaEI/sCIsRYSWOV5BilhskD0iw6G7Y1MGI4YiwhHfQclPmc6fQvQyRfx1XaYwqccbS
         wtQ0w0Bym4ZSVMvSs6ydYtnqaAPMWO60WI4wgmgwCNdpV+xalKPEyHy2SzTOnQFTp2SU
         Jb8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=2vtS1l3ByqcKp4N7+o2M0gYmr7gF9CuohmWWp8cIX+M=;
        b=DLCRl5HNYeLI1W+uFPMMEdsyTXuttPAPQ+JxwJOfL0Ya2DWIzTz3UQS8FRKT7CielJ
         8t8qJ/FfCbjcOqU9sCYFh/61e86WlRQQE4aiMYL0zazHijEfaEZsxNwfdga0N4tjUG2w
         2HM3xHHZHZIIB1rrIZgb3CaczKBE7abUhFkSQvVBdmtkBjbO4LKMnVuvJm8b5AvIlDHG
         YNLyPG4riQT4ccbNzGtzYp5WnNLAsk+rQCpnrfZIZBK7uAAPoOmeHrP3LNDmHKFUXSK7
         z7UBgtV/VHnsgcG9X2Ki84xYHTYFQnVA/PnqrSUEPQZAGrERckjyOAmv1cVqUvk39iSw
         khOA==
X-Gm-Message-State: AOAM530oSM3lZnG5jzB/lb/pk4u3VQeLvEb9liozgD0RUODNjygWEZSw
        Tl0WqKN7tifIujOKN2Afb19VBEC+fFX8jGXsNgs5ag==
X-Google-Smtp-Source: ABdhPJwdqLhfstoZ6bPoO4KDf1n09Pq3Iw1TL9z97hcDMOCJaLSFAAWLKM/fIGq+rBZgLfZKdp7cOIdPUkhY1qXhOrM=
X-Received: by 2002:a17:902:da81:b0:15d:37b9:70df with SMTP id
 j1-20020a170902da8100b0015d37b970dfmr796734plx.34.1651258650114; Fri, 29 Apr
 2022 11:57:30 -0700 (PDT)
MIME-Version: 1.0
References: <20220429074334.21771-1-msuchanek@suse.de>
In-Reply-To: <20220429074334.21771-1-msuchanek@suse.de>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Fri, 29 Apr 2022 11:57:19 -0700
Message-ID: <CAPcyv4i_frNg+pvayHyDcMSRLfGiCLDmSpPcCtocTKrAeypijQ@mail.gmail.com>
Subject: Re: [PATCH] testing: nvdimm: asm/mce.h is not needed in nfit.c
To:     Michal Suchanek <msuchanek@suse.de>
Cc:     Linux NVDIMM <nvdimm@lists.linux.dev>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Jeff Moyer <jmoyer@redhat.com>, Jane Chu <jane.chu@oracle.com>,
        Borislav Petkov <bp@suse.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 29, 2022 at 12:43 AM Michal Suchanek <msuchanek@suse.de> wrote:
>
> asm/mce.h is not available on arm, and it is not needed to build nfit.c.
> Remove the include.
>
> It was likely needed for COPY_MC_TEST
>
> Fixes: 3adb776384f2 ("x86, libnvdimm/test: Remove COPY_MC_TEST")
> Signed-off-by: Michal Suchanek <msuchanek@suse.de>

Yup, good catch, applied.
