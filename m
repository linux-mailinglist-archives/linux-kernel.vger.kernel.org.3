Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 799AB4CCA13
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Mar 2022 00:33:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237237AbiCCXeg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Mar 2022 18:34:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229809AbiCCXed (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Mar 2022 18:34:33 -0500
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com [IPv6:2607:f8b0:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B4B51598E7
        for <linux-kernel@vger.kernel.org>; Thu,  3 Mar 2022 15:33:42 -0800 (PST)
Received: by mail-pf1-x42a.google.com with SMTP id d187so6058842pfa.10
        for <linux-kernel@vger.kernel.org>; Thu, 03 Mar 2022 15:33:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=LlDf0G3gy4zP0KLKlph7n0pH0poTgm/9+vNFKpM1i0M=;
        b=jqNtxwM7bAAxYLrvRbdixlSBMCCci/lRY/AXW97/BTIVd9Lzziui5AvaBH1zS0DGl6
         q/DwqyQWFvczKnOrAs2O7qD8sHKKOTvSLkioI/6pWAHFLbX2K24LSCGzfTAfKz50e+Ra
         4vnWONu3I13Mi5cK2MfSd7Ni4fkam2J+HJ8SAmkzZnpI6MVQT/rfRkwQJHQXvAcnBu35
         pM3YaZkkm3UlDbLuUvmwdOmJ5bNuesH1TueqQukPhvwNf96/fDxAqEaccckmJEejpXSW
         RGJwNy7p+nzIIPJHD6eW/XLNqsQkt0IcQw5sazl94RA7/LVrifZvYdOUcPdcUyyZGcHh
         Qs8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=LlDf0G3gy4zP0KLKlph7n0pH0poTgm/9+vNFKpM1i0M=;
        b=qOI8KNgi71RJH0OniWOw+uhGEibzXqLuTbu65Bp+XD2dPBcHHJE9vuOrgTulcXXxsx
         qYMRGpAHAJVeSF2UjEIbAjroej8ixx+ve3gFiSl4ciNuBC8CWbMjTxtlC4DTnDwMasgz
         HjRO/z3DVrJXj0BbSwL+jNKVks3VPGtKkypNCyTm9MxniZwU7YwD52H/tQBC14fZ86gS
         +GtREt3592VN8ME0pV0enDQQ9oeqOk+L73n+xTg8HnzFR94UfcfTJOKp8/XT69QKf2lz
         OOLbZJoN5EOE3fw2r2XeTfnwtHJtMTBIZaDAKciy4gUNpIXlMbPl5bZCaL4D/BrhHpMq
         OnlA==
X-Gm-Message-State: AOAM531+k5Eu5PhGn7X6vvrfUdP5mPjPqOh0f5Co25WLxk/4Zh20o/hf
        K8UHaUoIkoJz3L9UFkHnflZ0jmWW0e8mkdG3LwsSFg==
X-Google-Smtp-Source: ABdhPJxywxpNYJGmS7I03Bafx+s0cUuvwtNDA0OEmJgEA/H+p85W5Vd9nXrDOhfu3m/eNp9Q5PfMb/mhIb4ipC3RxUc=
X-Received: by 2002:a65:6901:0:b0:378:8154:e2bf with SMTP id
 s1-20020a656901000000b003788154e2bfmr21301009pgq.401.1646350421796; Thu, 03
 Mar 2022 15:33:41 -0800 (PST)
MIME-Version: 1.0
From:   Yosry Ahmed <yosryahmed@google.com>
Date:   Thu, 3 Mar 2022 15:33:06 -0800
Message-ID: <CAJD7tkaidL-QKN-WrhcSfkXBOKqHJBsQ2_FkqAyoxzqTha7Hyw@mail.gmail.com>
Subject: Re: [PATCH 1/2] kselftest/vm: Rename TARGETS to BUILD_TARGETS
To:     apopple@nvidia.com
Cc:     akpm@linux-foundation.org, dave.hansen@intel.com,
        harish@linux.ibm.com, jhubbard@nvidia.com,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-mm@kvack.org, linuxram@us.ibm.com, rcampbell@nvidia.com,
        sandipan@linux.ibm.com, shuah@kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-18.1 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I ran into the same problem when running:

make -C tools/testing/selftests TARGETS=vm

I was going to send a fix but I found this one deep in the mailing list.

Reviewed-by: Yosry Ahmed <yosryahmed@google.com>
