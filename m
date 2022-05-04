Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9825051AEE1
	for <lists+linux-kernel@lfdr.de>; Wed,  4 May 2022 22:18:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377959AbiEDUVs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 May 2022 16:21:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377951AbiEDUVn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 May 2022 16:21:43 -0400
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com [IPv6:2a00:1450:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C08854C418
        for <linux-kernel@vger.kernel.org>; Wed,  4 May 2022 13:18:06 -0700 (PDT)
Received: by mail-lf1-x131.google.com with SMTP id w19so4220868lfu.11
        for <linux-kernel@vger.kernel.org>; Wed, 04 May 2022 13:18:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition;
        bh=/7SaxbrAKYy5nHjPeP6rKPzhr5cf0KgWZreybqQSSK0=;
        b=vH4P23aRILvPjXrFTf+PKSY5WZyteRVwqCQxiYPHQY4SnjhV5kTiBoIIHwMT3N3nzb
         n2gTDORYJZ3lIchUKu2QKuDBYZUJnTjm2A0iQh9tjc2GjceqpKx0eQcnQakbOeVlNKcP
         gYJElSdyE2lUs0EWGrRj5xbNIF9UK5mf3InKhQglmy2HC3/q9dDKE2ud97fB7Xt09juG
         ZQDZ5a0zyxlT7/vD1CAnIHMa4iRN96ujdZ+vj0ymSR8YEEY/gW2UKHA618uUEQpZBdmh
         wvrW4Ol5LienogN5JX72UVxYyEm465NfTwzhPyAZY2cSwFPw9PpzHH82RlAB68cPXKx2
         l0kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=/7SaxbrAKYy5nHjPeP6rKPzhr5cf0KgWZreybqQSSK0=;
        b=k+puqyKyDy1daKOy5xTDNwiwKYkfbb4KymUJ0mG7tPc47VqWirJfc7xSbIipuJCvJK
         mJIFfDhjqkiIqonzMOSAJVj9cM813+IICbqVKiNNnKa4O9MG076HLv5NcARhl4WWTbXp
         XZsPPsUKW/DZ1FAfD4MRu00zsl60dGcneD6sWjIcRrriLifmrs+f6FJheiWDw8e1lS2e
         pmnLLSU/0huNdQGez6tu0SmuGXyJjg+qKpurAl1zllhK4zQQdkafNh6zIQ7J5BK1qcSH
         nb0+cJAVeOQz0xF6R7+nGMPx10RLgoPbB6cbd7iK4yiux8f+N5dImd78aEP+JOo9qYwX
         7wfw==
X-Gm-Message-State: AOAM5300ZBrq6slcwd0dhlT6Y7OCkSZeKgI8PrncE5uCCqkF6nKMqdWO
        LNBAzjlw+N5iUO9vbMw4RsM48PTt25GiLQ==
X-Google-Smtp-Source: ABdhPJx7s9k+vQS15Ri0wixJykWHpgypG/aIMgqdCW4IpR8U7ii9SJNply59hEAHQaq76eBWTiLrqg==
X-Received: by 2002:a05:6512:10c2:b0:473:b559:2016 with SMTP id k2-20020a05651210c200b00473b5592016mr4584359lfg.641.1651695485120;
        Wed, 04 May 2022 13:18:05 -0700 (PDT)
Received: from jade (h-79-136-84-253.A175.priv.bahnhof.se. [79.136.84.253])
        by smtp.gmail.com with ESMTPSA id h18-20020a05651c159200b0025052e35be2sm1064541ljq.130.2022.05.04.13.18.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 May 2022 13:18:02 -0700 (PDT)
Date:   Wed, 4 May 2022 22:17:59 +0200
From:   Jens Wiklander <jens.wiklander@linaro.org>
To:     arm@kernel.org, soc@kernel.org
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        op-tee@lists.trustedfirmware.org
Subject: [GIT PULL] OP-TEE RPC arg for v5.19
Message-ID: <20220504201759.GA180315@jade>
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

Please pull these patches which improves performance when communicating
with OP-TEE in the secure world. A cache of argument structs is
implemented to minimize the number of alloc/free and possibly also
register/unregister of these buffers in the secure world. This boosts
the performance in particular in a FF-A configuration. It should also
save a bit of shared memory since each multiple a physical page now can
hold multiple argument structs, instead of one page per struct as it was
before.

The OP-TEE SMC ABI is also extended to pass an argument struct needed
for RPC together with the primary argument struct, in a manner similar
the OP-TEE FF-A ABI.

Thanks,
Jens

The following changes since commit 3123109284176b1532874591f7c81f3837bbdc17:

  Linux 5.18-rc1 (2022-04-03 14:08:21 -0700)

are available in the Git repository at:

  https://git.linaro.org/people/jens.wiklander/linux-tee.git tags/optee-rpc-arg-for-v5.19

for you to fetch changes up to 5b4018b959149eb5b5f3004fc0339674af67516b:

  optee: cache argument shared memory structs (2022-04-25 21:13:05 +0200)

----------------------------------------------------------------
OP-TEE RPC argument cache

Adds caching of the OP-TEE argument structure used to pass request to
secure world. This reduces quite a bit of unnecessary alloc/free and
possibly switching back and forth to secure work in order to register
the buffers in some configurations, most notably FF-A.

----------------------------------------------------------------
Jens Wiklander (4):
      optee: rename rpc_arg_count to rpc_param_count
      optee: add OPTEE_SMC_CALL_WITH_RPC_ARG and OPTEE_SMC_CALL_WITH_REGD_ARG
      optee: add FF-A capability OPTEE_FFA_SEC_CAP_ARG_OFFSET
      optee: cache argument shared memory structs

 drivers/tee/optee/call.c          | 238 +++++++++++++++++++++++++++++++-------
 drivers/tee/optee/core.c          |   1 +
 drivers/tee/optee/ffa_abi.c       |  36 ++++--
 drivers/tee/optee/optee_ffa.h     |  12 +-
 drivers/tee/optee/optee_private.h |  31 ++++-
 drivers/tee/optee/optee_smc.h     |  48 +++++++-
 drivers/tee/optee/smc_abi.c       | 197 +++++++++++++++++++++++++------
 7 files changed, 461 insertions(+), 102 deletions(-)
