Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DEF1E508F37
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Apr 2022 20:15:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1381461AbiDTSR7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Apr 2022 14:17:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1381457AbiDTSRl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Apr 2022 14:17:41 -0400
Received: from mail-oa1-x31.google.com (mail-oa1-x31.google.com [IPv6:2001:4860:4864:20::31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6AFE10BB
        for <linux-kernel@vger.kernel.org>; Wed, 20 Apr 2022 11:14:54 -0700 (PDT)
Received: by mail-oa1-x31.google.com with SMTP id 586e51a60fabf-e604f712ecso2808976fac.9
        for <linux-kernel@vger.kernel.org>; Wed, 20 Apr 2022 11:14:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=Aeun89AbIezXrfDdIt+YaeWMoDF1kxccdnwQFEnnj18=;
        b=Wrp200wsDIrmmMXrnvcerlksFLuIzM6xiTFSrVXUbwkq9jcaXTqKwqM3c2qMahgOuk
         FDpUclGA2swBeffzjPS6YXM8rMdaMXHliR1x1WMSftvPkojKml0uXrGTY/bEpReLdiXe
         bWz3RNyqmZYKGt9Mj/nZ8qNNSDaA0e6I441TBKZBtyaHJETZ/rDSVEMeAjfeptLMySSm
         KDhpAn9G0B58fkKYaphWGNw9Kkp8BhKUt3pFGJO9SVv+BUBTYITYe1uRsGgdJmFPQEuj
         chG34tAcHF72ytRKfzSGfYq3tUSjZQ0zCxR6gmkcFDk5MgHSY8qN4wIc7IvFLQe6FYHG
         37uA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=Aeun89AbIezXrfDdIt+YaeWMoDF1kxccdnwQFEnnj18=;
        b=JVgQr+VIJUry0C91btK5w3jH8ZwgrOAMPkftvGGET91v8cEAgd/mNyI+dEmr7x4EtX
         nk81gO5VdV6zb+nHblrB9Ilbmzy71w0BbjlYbUg+KkYkJn+G5bhebkDgZC5tVo/oedt8
         kRlJXq2xLkEAh/kPs2tJIGG+bIODiicdxW6belM3hIY8m2kXEDtnKjKfoevN2i1QBruk
         1KGSkA+PMjPWVR2a33T7MUqNndeI8knO2xE4GgiwpjMQ1v2YpSeuRd2080EljQCBpDKq
         1ClqBT4L85v6QNMMgri0QDQAkHHGC3Y6a9dF72KhUENyVMhm204PQiVXkAkULETeZnG7
         rCtA==
X-Gm-Message-State: AOAM531p5AumGepOP6/7asCt7/9JiRLt5J4dDgLdbtQluXxYJ8w/RqLT
        YfV1TaCz+LvRsTwsWgx3dV2OtFzgeIZY0G21QAO49Q==
X-Google-Smtp-Source: ABdhPJyFOzkGagGtzOCMreGveolweWFdGEHZFUqCsob2xUXn37YIG7GdWajfOFgADT+acsUDRYcg/jwVY9yWkopT2c0=
X-Received: by 2002:a05:6870:315:b0:e6:15d1:11a8 with SMTP id
 m21-20020a056870031500b000e615d111a8mr2260548oaf.289.1650478494062; Wed, 20
 Apr 2022 11:14:54 -0700 (PDT)
MIME-Version: 1.0
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Wed, 20 Apr 2022 11:14:43 -0700
Message-ID: <CAKwvOd=nEddFaTVQ80JrHcpjVv34=EhxJ9bb7rUFrRapuGFj2A@mail.gmail.com>
Subject: Fast Kernel Headers talk @ Plumbers?
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Arnd Bergmann <arnd@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>,
        "Jose E. Marchesi" <jemarch@gnu.org>,
        clang-built-linux <llvm@lists.linux.dev>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Ingo,
Jose and I are currently in the planning process to put together a
Kernel+Toolchain microconference track at Linux Plumbers Conference
this year (Sept 12-14) in Dublin, Ireland.

We were very excited to see numbers posted about improvements to
kernel build times from your work.  If you're planning on attending
plumbers and our MC gets approved, would you be able to present on
this work?

Would others be interested in such a topic?
-- 
Thanks,
~Nick Desaulniers
