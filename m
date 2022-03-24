Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3E77A4E5C79
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Mar 2022 01:54:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346929AbiCXAz0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Mar 2022 20:55:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346920AbiCXAzX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Mar 2022 20:55:23 -0400
Received: from mail-pf1-x435.google.com (mail-pf1-x435.google.com [IPv6:2607:f8b0:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3693659B
        for <linux-kernel@vger.kernel.org>; Wed, 23 Mar 2022 17:53:53 -0700 (PDT)
Received: by mail-pf1-x435.google.com with SMTP id b15so2754081pfm.5
        for <linux-kernel@vger.kernel.org>; Wed, 23 Mar 2022 17:53:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=piJRl+6ho54xwmr7pghjDhTXicnYnpxRZsVKlizVP2w=;
        b=ncbD6aUUYjopy6AUFwQmMJZaAS/Ak50tCwzvAEHKQDJ95bHstm8IcBwG/iFpqZ2I8k
         LJUqBujXQ/n42gzMRD9L1ixtxppDwm4oj3j3Q8FjAeRfHlmypm8Hp4pWm9bZU9z8Ylf+
         BooCoRZUFuCba9TOOiHjCFU96riHpf/g5U8TurQh/YJs0vaMXV2A+splVllIRrrzRzLa
         j+LULl3Ovs2gT62HcbcDwKzsf3XBFSvQJvSbOLIl+Z2jiUDGLpPNZNpVX1/5I8yNP0Of
         CyzYWcWuQBYpUSUASoOW1IibSyVPxKGtW/ZCOe5Q2jriz+L7hGi5eA3lmVQgaKXtlZVZ
         Dt2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=piJRl+6ho54xwmr7pghjDhTXicnYnpxRZsVKlizVP2w=;
        b=MybojoWXrE0N6/gU1skkysT/N4HOEZxga/6bKuQqndhmji2qFrLqBZ822j3hhcjncE
         D3MZAU4CixPw1w8S224HIrN71cOHGitc/FoKuIdQ7UbRTgNDMW5pwrb/bQQaQ9sNj346
         lYUpBGzecS4O2XAayLmfw0u/BLgudHP2MIqHd/buid4ZAGEyfHBeOqbD2wuLxdVM4jr8
         qVJLf93jE9Qf15oiE+pbAka7E2GiBr7ZvaaRrqUObsB7vis/sccoXuDw/3co3DvbfIwp
         dQIaw+MnW+Hkd6iXzFLhUROBRmaLeIx4XbBOhs4gOiohu4h1Lrxqb5aZOo45nO/4xkJ7
         /lUQ==
X-Gm-Message-State: AOAM531LOadovyDXlcPEYe8NXeeDCqUdm/q47qQDWTbZTZn6MNyjV7G/
        obFiyzRSF+i+P40ekeL+UpRG2Fm51ozrZgooJxs/4U+e4o8=
X-Google-Smtp-Source: ABdhPJxHN2wGkD2Tc/WqYsncT+yBTS4vCZ9XwGQvUgkbmHypLKbrccnEjmzxfzKvoZ0ITBzS/OdSkRLQ3MP8RVxzqA4=
X-Received: by 2002:aa7:86c6:0:b0:4fa:46d:6005 with SMTP id
 h6-20020aa786c6000000b004fa046d6005mr2684054pfo.86.1648083232815; Wed, 23 Mar
 2022 17:53:52 -0700 (PDT)
MIME-Version: 1.0
References: <20220321220408.2381974-1-trix@redhat.com>
In-Reply-To: <20220321220408.2381974-1-trix@redhat.com>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Wed, 23 Mar 2022 17:53:45 -0700
Message-ID: <CAPcyv4jBh6v_=hBimbU=-dqV2GTEnuqxB26i5QTu4jBETpcRXQ@mail.gmail.com>
Subject: Re: [PATCH] nvdimm/blk: Fix title level
To:     Tom Rix <trix@redhat.com>
Cc:     Jonathan Corbet <corbet@lwn.net>,
        Linux Doc Mailing List <linux-doc@vger.kernel.org>,
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

On Mon, Mar 21, 2022 at 3:04 PM <trix@redhat.com> wrote:
>
> From: Tom Rix <trix@redhat.com>
>
> make htmldocs fails with
> Sphinx parallel build error:
> docutils.utils.SystemMessage: ...nvdimm.rst:146:
>   (SEVERE/4) Title level inconsistent:
>
> PMEM-REGIONs, Atomic Sectors, and DAX
> ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
>
> The PMEM vs BLK section was removed without changing
> the PMEM-REGIONS... title line.  Replace '^' with '_'.
>
> Fixes: f8669f1d6a86 ("nvdimm/blk: Delete the block-aperture window driver")
> Signed-off-by: Tom Rix <trix@redhat.com>
> ---

Looks good, thanks for the fix!

Jon, I'll take this through the nvdimm tree.
