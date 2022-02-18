Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3D2A44BBECE
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Feb 2022 18:56:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238803AbiBRR46 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Feb 2022 12:56:58 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:56474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235479AbiBRR4y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Feb 2022 12:56:54 -0500
Received: from mail-lj1-x235.google.com (mail-lj1-x235.google.com [IPv6:2a00:1450:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 011D9294
        for <linux-kernel@vger.kernel.org>; Fri, 18 Feb 2022 09:56:36 -0800 (PST)
Received: by mail-lj1-x235.google.com with SMTP id c10so5408542ljr.9
        for <linux-kernel@vger.kernel.org>; Fri, 18 Feb 2022 09:56:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition;
        bh=/4HrUgYlNj6NJRogd/KPSeqtVQ6+jaJ4N7YhgxWLksc=;
        b=Fb8rOUmirBXLpLWlunWMkI3j848IAbT9mkZyCA4v4kAoIn8BNEmJ4MvL2tsWauxvyt
         l8itxOTUVvOEE77Gy+YvzKbOZiHFPaL/HotivYcbsOHwwOuWkazagUFnNi1NJ3abRFxr
         08hL+DyjdNkFpKVv8jmndf1AuaJ4lskQmsNgdroRYdPzEnwBtkN3co3FJzFo1Khjvr69
         VWX5ZfBKS42CaHbGV34VO9FeHzh5fA90JtshQNLgaTGr5KdOkny7bO8EzLvxmtLyxWrR
         jzE69ftIHyqftRRLLLTAJiVSb5Et+l+qAVuY8WcW+8UNpjJLx1Yk5ee3cxU4LOmR2dkg
         EOhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=/4HrUgYlNj6NJRogd/KPSeqtVQ6+jaJ4N7YhgxWLksc=;
        b=pcDFPCs67u7UoaupZLqxpZv53RfAcbbokg6zoMbpvvBAefYmc/gvfm/FRO+h/Wpami
         s2Y0sL9/BFjEKqg6IkFmRaENaV+qEIyvkSJQyKxww6zLMUUaMDw08M6O7jsNKLlsQywe
         XWU2l14qucKv7JHgvPbqYPiY/KfszWKnEBLTOR6jTMm0EQspLnpNyxCje1lVrEMh0z28
         0zJbp9ki/nPwlWfyEyqBSHTJwYVb7PGCOBbv+jV3tkWy3nAYvpWFI0vsHIz57tvu5QHX
         +eiV0S9riJYaoeYVcCiBbIP9/GU4Bs1MmPH3RqFfklEKPrOxZwO2iow10UAr11K0Tzbb
         sFxQ==
X-Gm-Message-State: AOAM5336NftDZXKRqCNxJV442OpVRnjyo//GEBBPpkDiRdqlGaxZ4nvq
        h0meKIJKcVmkeyuTc4S9RD+ALQ==
X-Google-Smtp-Source: ABdhPJyLRo+IPJKJK5ltw12JckpLRaqYNiOrh1988ArjU1mdO+2843jJEwaZY3lKoE6FB5oadWg4jQ==
X-Received: by 2002:a2e:871a:0:b0:246:ee2:1109 with SMTP id m26-20020a2e871a000000b002460ee21109mr6399697lji.165.1645206995032;
        Fri, 18 Feb 2022 09:56:35 -0800 (PST)
Received: from jade (h-94-254-48-165.A175.priv.bahnhof.se. [94.254.48.165])
        by smtp.gmail.com with ESMTPSA id z26sm386410lja.139.2022.02.18.09.56.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Feb 2022 09:56:34 -0800 (PST)
Date:   Fri, 18 Feb 2022 18:56:32 +0100
From:   Jens Wiklander <jens.wiklander@linaro.org>
To:     arm@kernel.org, soc@kernel.org
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        op-tee@lists.trustedfirmware.org,
        Cai Huoqing <cai.huoqing@linux.dev>,
        Rijo Thomas <Rijo-john.Thomas@amd.com>
Subject: [GIT PULL] AMDTEE simplification for v5.18
Message-ID: <20220218175632.GA926082@jade>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello arm-soc maintainers,

Please pull this small AMDTEE driver simplification to use the LIST_HEAD()
macro instead for a global variable.

Note that this isn't a usual Arm driver update. This targets AMD instead,
but is part of the TEE subsystem.

Thanks,
Jens

The following changes since commit 26291c54e111ff6ba87a164d85d4a4e134b7315c:

  Linux 5.17-rc2 (2022-01-30 15:37:07 +0200)

are available in the Git repository at:

  git://git.linaro.org:/people/jens.wiklander/linux-tee.git tags/amdtee-for-v5.18

for you to fetch changes up to f7b67642dd98617dc569836cdcba041c7ff00cbb:

  tee: amdtee: Make use of the helper macro LIST_HEAD() (2022-02-14 10:57:55 +0100)

----------------------------------------------------------------
Small simplification in AMDTE driver

----------------------------------------------------------------
Cai Huoqing (1):
      tee: amdtee: Make use of the helper macro LIST_HEAD()

 drivers/tee/amdtee/call.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)
