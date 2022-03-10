Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A52504D408A
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Mar 2022 06:03:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239560AbiCJFEV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Mar 2022 00:04:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234788AbiCJFET (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Mar 2022 00:04:19 -0500
Received: from mail-pf1-x435.google.com (mail-pf1-x435.google.com [IPv6:2607:f8b0:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D15888090D
        for <linux-kernel@vger.kernel.org>; Wed,  9 Mar 2022 21:03:18 -0800 (PST)
Received: by mail-pf1-x435.google.com with SMTP id p8so4136119pfh.8
        for <linux-kernel@vger.kernel.org>; Wed, 09 Mar 2022 21:03:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=XdUthPD7bGCIRJZKP+8Puk835WZG8F4AIVu+APsltrY=;
        b=SKHyNhwcEjX2tukqsuJN2TnimK7XEQvX7Q51oYiRU0Ty9pbBuLOnL0B0N8QwI2pZCN
         nrZnhlisnP9Co6ZwELmv+HO2ibT7W3czzuL+U/dW66VH+7KKZn9+xDWH0wOtv3h3ZFIZ
         MVBNIWZRRwohrq2PKOXh3uNB/cpcdziS4Jhq0QkLt0dROf0jBYfPZRFiuK/CX5d1gxDA
         eFcbubed8IV7fGfx7xLnfYiK63kpx1KivTgA0quzYP/HpPZC4NggsPFHUSYKWc6bbSeu
         /waJW2ppM/k+0+jx1Tf2PYxV6Z7z/clJ00kE6bQSssJiCua3YXpy0TXQgYHxiOGA+Lby
         gdiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=XdUthPD7bGCIRJZKP+8Puk835WZG8F4AIVu+APsltrY=;
        b=IiUd/oXxi0TKSj6xYTHdoHWFBEO9rikkRi7AvmZiVxfkbR5RoMNC2sCGPU1p+0f+ea
         J4JRjgcBA+Z0lm3ugDhFuT8r7dYcDKP5qoRXELCtrnFPxHdUIi0LpPVMI1L8NElFguP6
         o5rC35ERgU+VLX64+wtAKMEOcnHEF7t55szzgX8Ed8Oap658aomyLPllhJ22qD2x6Py+
         eRRQrmrubYL8h6Y8xKDGgwJC9/WSAyH+xOBhYI1/1W+R2FUS/sEerq5Au7Pwci/Mh47L
         kEcmZz+JgKGOoC16cg7W0+Lp0YxxH2FdZptLOe7sJUiaM3iv25PlyJGKM7YtW6Mzmiyx
         IE6Q==
X-Gm-Message-State: AOAM533xeiwcYnzamAU2zVtXf0LiJ7UC+yHP7BxeQCx1+M/mofm94OLy
        gh05y7U9EOETPaVZ+DDUQ6+bHbZGrWkcFVA2tPrOVw==
X-Google-Smtp-Source: ABdhPJwdWnuTbalQWFuR+/JS2REBkQZ3MSK8Jn9rpx7iwKs3V0GYNIimf4MzwFgvlkY6qs+pVGtGNwW16T8gqIkEcrY=
X-Received: by 2002:a63:2c4c:0:b0:37c:4690:d4f1 with SMTP id
 s73-20020a632c4c000000b0037c4690d4f1mr2675350pgs.40.1646888598320; Wed, 09
 Mar 2022 21:03:18 -0800 (PST)
MIME-Version: 1.0
References: <20220304204655.3489216-1-ira.weiny@intel.com>
In-Reply-To: <20220304204655.3489216-1-ira.weiny@intel.com>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Wed, 9 Mar 2022 21:03:07 -0800
Message-ID: <CAPcyv4g9rz5qm=JVTsbu=nzsehka7nAVLCK7j3p4NzYRVEBiOg@mail.gmail.com>
Subject: Re: [PATCH] fs/dax: Fix missing kdoc for dax_device
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

On Fri, Mar 4, 2022 at 12:47 PM <ira.weiny@intel.com> wrote:
>
> From: Ira Weiny <ira.weiny@intel.com>
>
> struct dax_device has a member named ops which was undocumented.
>
> Add the kdoc.
>

Applied, but I fixed up the subject prefix to just "dax:" since this
is shared between the fs-dax and device-dax.
