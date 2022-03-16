Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7D7F74DA9CE
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Mar 2022 06:25:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353621AbiCPF0y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Mar 2022 01:26:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239007AbiCPF0w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Mar 2022 01:26:52 -0400
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9AB5A5D5FE
        for <linux-kernel@vger.kernel.org>; Tue, 15 Mar 2022 22:25:39 -0700 (PDT)
Received: by mail-pj1-x102c.google.com with SMTP id 15-20020a17090a098f00b001bef0376d5cso1398413pjo.5
        for <linux-kernel@vger.kernel.org>; Tue, 15 Mar 2022 22:25:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=4VXLa+bQza4asNsvRsBeTx6o89c2ufs9/OaL35zL23k=;
        b=uHN7xSsgP880Hr638C0NbhmgBDr1CfM1yG6kEOD+6lzRYu+6Ng8zeZ/y7ulSUSyuKv
         L8LhSZoLFNbvyfpYx5ZKy6xLGdk73K/VxduAug+WgAfKdgmQCiy4+j7atUrgzFw/wlcn
         7KVvh1AA0dsoiXhbO1yMiLBcu4P6+AKxWLMnFwJFyHUb8BHN3QSYiI+MPW5zXHfhaVDq
         uekLzQBhIjaEx7Pjxt7Lz0JEIgw1Rj0JYw00lmqdUT25AtDtJNhBzRgOk8Wf2IVuH6AA
         Q0KwikoxBc9tmB0j8WPdAL6aUoKishHwicXPdYL16oMwfUE7LoHwojUiSkCz/1xQsULi
         9Ijw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=4VXLa+bQza4asNsvRsBeTx6o89c2ufs9/OaL35zL23k=;
        b=0KvlSTAZBligM0sFVadW8KiK+UjQMpdTW1sZYAo/I5B3V1bmBLRdxulSj+/S6A9cPi
         uMZ+hq+VJRRY8jX1++smUSK+S7T8v1tNCoKcgYlE854Fz6lhwX8AgGBzrZr8WhOZvCcu
         8FzCHVIWOTC7uFWfD49foYKYZK1MYLjivpZb9E7SsqKKK2OlTbmusZkn7lBh0exXnLjB
         2AR7Y9ufIxvYlPFi8JPvXjIuTX2c/EBKuKa8OkS6CEPSYXJKoj8fXs1jAzf7nHnG8J3V
         Et8onSSAl0YzTJA74YOqNVDuEgUlKemtymNC5OhZTClcovWibiwwoi+a1Fofipptd0Zb
         jDPg==
X-Gm-Message-State: AOAM531nT1zzZiEIxU//wOK4tGs53hvduYJn1WeQQzwEy+h6AuD6dJhg
        DL0TGHLtVX6ip600Vf0adOHwB+eyfIhBZvd9XySpZyRrdeM=
X-Google-Smtp-Source: ABdhPJxWKW3AaOJQwkC6iKr2VdTaQ4Ug/eP67T3DupZkrcyYpkyTp8r3JNUSmK2Jgs3wQY4zwJEVb1iDQXK9NFiaXik=
X-Received: by 2002:a17:902:7296:b0:14b:4bc6:e81 with SMTP id
 d22-20020a170902729600b0014b4bc60e81mr31522519pll.132.1647408339183; Tue, 15
 Mar 2022 22:25:39 -0700 (PDT)
MIME-Version: 1.0
References: <20220316052133.26212-1-lukas.bulwahn@gmail.com>
In-Reply-To: <20220316052133.26212-1-lukas.bulwahn@gmail.com>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Tue, 15 Mar 2022 22:25:28 -0700
Message-ID: <CAPcyv4ita5JmK4noL0euebNgLDYYb6fmnDQZfksTr=FOqtqe+g@mail.gmail.com>
Subject: Re: [PATCH] MAINTAINERS: remove section LIBNVDIMM BLK: MMIO-APERTURE DRIVER
To:     Lukas Bulwahn <lukas.bulwahn@gmail.com>
Cc:     Linux NVDIMM <nvdimm@lists.linux.dev>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        kernel-janitors@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 15, 2022 at 10:21 PM Lukas Bulwahn <lukas.bulwahn@gmail.com> wrote:
>
> Commit f8669f1d6a86 ("nvdimm/blk: Delete the block-aperture window driver")
> removes the file drivers/nvdimm/blk.c, but misses to adjust MAINTAINERS.
>
> Hence, ./scripts/get_maintainer.pl --self-test=patterns complains about a
> broken reference.
>
> The section LIBNVDIMM BLK: MMIO-APERTURE DRIVER refers to the driver in
> blk.c, and some more generic nvdimm code in region_devs.c.
>
> As the driver is deleted, delete the section LIBNVDIMM BLK: MMIO-APERTURE
> DRIVER in MAINTAINERS as well.
>
> The remaining file region_devs.c is still covered by the section LIBNVDIMM:
> NON-VOLATILE MEMORY DEVICE SUBSYSTEM, and all patches to region_devs.c will
> still reach the same developers as before.
>
> Signed-off-by: Lukas Bulwahn <lukas.bulwahn@gmail.com>
> ---
> Dan, please pick this minor clean-up patch in your -next tree on top of
> the commit above.

Ah yes, looks good. Thank you for the fix up.
