Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3AE3F57CE9F
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Jul 2022 17:10:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229703AbiGUPKS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Jul 2022 11:10:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229436AbiGUPKO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jul 2022 11:10:14 -0400
Received: from mail-yb1-f181.google.com (mail-yb1-f181.google.com [209.85.219.181])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ECAB910FE1;
        Thu, 21 Jul 2022 08:10:12 -0700 (PDT)
Received: by mail-yb1-f181.google.com with SMTP id l11so3207481ybu.13;
        Thu, 21 Jul 2022 08:10:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=lSEkzI6pRbstA/Oh6kmd3hOikcvzXjihZBaXq4sZTT4=;
        b=HZyCUela9CqSVYe/Coi6+uGK47DaPg23YiuSxgaFcEl4PUIMtpDCTVOGsrmEm1skf7
         v9+PB0AycFjJ4CsPZQeBLVEURiEdaEDOvKg0+bIiDAKeWRhFT74+dEtBSELzqAOq8JP/
         JXwgyhjhT598kHCkvpZVuJUDbtVASlp4J9wZN9Ku7RJ+4JrDps9fU6Tfb9f71WTsOAes
         ZTHXR0umD6iM1PYrUjcnfIT8V6YZLy5bhyz5eefUJDG1dMtwafkI8xSS8w2khXT4yGS6
         YeJOacEuNrK+lJojKMmcEvlk7yZEVw+FU3eXG/AVKo808VorDZ3/NhHivAEoy9S1j6DT
         18jg==
X-Gm-Message-State: AJIora8aL2IphX6cc9t896vSA+oDItI8nS6DiWn/e1nk8U1EH7ltZCuw
        JlaUCeLYl0DDsMzkThTd2ap8kF/ji4ox5taTwQg=
X-Google-Smtp-Source: AGRyM1ssRkahU3f/aHn31AUQWAWkr9ySF2Co+yd9YBgfI+gXsxCy20WxYxme4nKL4IAIrcVCzGtcEv6Dgbi9JH+CTUE=
X-Received: by 2002:a05:6902:1207:b0:66e:f2d2:6e91 with SMTP id
 s7-20020a056902120700b0066ef2d26e91mr43353752ybu.153.1658416211952; Thu, 21
 Jul 2022 08:10:11 -0700 (PDT)
MIME-Version: 1.0
References: <20220719115013.744751-1-zhangqifu@bytedance.com> <YtbmOlaDdKCVBUFI@agluck-desk3.sc.intel.com>
In-Reply-To: <YtbmOlaDdKCVBUFI@agluck-desk3.sc.intel.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Thu, 21 Jul 2022 17:10:01 +0200
Message-ID: <CAJZ5v0heCMbbcJ4As-wRTcm=oTaOPdWw64z5=phz9LRCVwyOsg@mail.gmail.com>
Subject: Re: [PATCH] Documentation: ACPI: EINJ: Fix obsolete example
To:     "Luck, Tony" <tony.luck@intel.com>,
        Qifu Zhang <zhangqifu@bytedance.com>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Len Brown <lenb@kernel.org>,
        Jarkko Sakkinen <jarkko@kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 19, 2022 at 7:13 PM Luck, Tony <tony.luck@intel.com> wrote:
>
> On Tue, Jul 19, 2022 at 07:50:13PM +0800, Qifu Zhang wrote:
> > Since commit 488dac0c9237 ("libfs: fix error cast of negative value in
> > simple_attr_write()"), the EINJ debugfs interface no longer accepts
> > negative values as input. Attempt to do so will result in EINVAL.
> >
> > Signed-off-by: Qifu Zhang <zhangqifu@bytedance.com>
>
> Reviewed-by: Tony Luck <tony.luck@intel.com>

Applied as 5.20 material, thanks!
