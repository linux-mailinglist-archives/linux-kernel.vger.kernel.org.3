Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 562BE4B50E4
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Feb 2022 14:00:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349966AbiBNM7n (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Feb 2022 07:59:43 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:49314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229631AbiBNM7m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Feb 2022 07:59:42 -0500
Received: from mail-lj1-x233.google.com (mail-lj1-x233.google.com [IPv6:2a00:1450:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B6D24BFDF
        for <linux-kernel@vger.kernel.org>; Mon, 14 Feb 2022 04:59:35 -0800 (PST)
Received: by mail-lj1-x233.google.com with SMTP id a42so6734275ljq.13
        for <linux-kernel@vger.kernel.org>; Mon, 14 Feb 2022 04:59:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition;
        bh=xE6oH1l8roCpLAC7Wz9reE1zFtexi58NOcCqLOgqq3I=;
        b=np/8FqqauGyYXpS75ffKq7DnlBqSgyv6Z+qbrdayhleRze/+Teqynbg4tyfYET+VJ6
         hN7l57X5dfB1NnF3x3SwVYlHesuy7QfcmSUfARJzpCn5eLv3QLuFI8XdHTeLBOclct69
         5y7h6gaqmIxp5jKdqklm0zWELoxps8chOU1Zdy4cE2w12Vvx8hJTBfn7/B/wE5kAy+7x
         xUdgWo651H6Aor614PAn3C1VAIFBOhewXdErz3Yd1t915KyMtcJob9YwiEporQ2rv/+D
         xRXH/q7U+qFDl8JrRG3MZ/3p1Mg+HI1U32mjHSp6xXdw9Aor2u0pwrIuQpHqvOiCUnPE
         FlFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=xE6oH1l8roCpLAC7Wz9reE1zFtexi58NOcCqLOgqq3I=;
        b=Hi/DaGxryyrAQIJumnp7L9OV6RepI7p9NWBk/97gcboHakt8yR8YYlssQDSFHCZBg2
         S9wKj/lSYB3ZlKmD0Yese+87loSXaRwzCIL9kpKOnNrsR/9blC2IP1d2sLOeq1xLA25o
         VbvH0XDXvxoRPKXQwyT2mqXYKszLokWLhNfUqw04oxbw3wmMF8bfVnZDh4ruCpUFc+7Y
         S8NPeeSAlMxITY5t/j7UCTxJDFNyUhYLr+3A/OzcIbpZcrevN+mEl02wuedSp6VbiukS
         iVrqurZLZwQOsvjJiIy9zgPuRsVEuRUMaMUil9OW1ndVTkLWeDzMtXFIRl4Ny089SPbL
         lQvg==
X-Gm-Message-State: AOAM532hYpOpx45x5K0/swvI5amXy9TCjFN8E/fZFOIpaf45+iMzQMnp
        CRsZr6XkfoUzZK/9DD4VuIzUBg==
X-Google-Smtp-Source: ABdhPJyl8EivjpsERn9JHrhdBXPMO3sde1+2Kx4h1aGZFLECQffjXhIaxa3O6uuBvpj4wUU/spjd2w==
X-Received: by 2002:a2e:a594:: with SMTP id m20mr8762680ljp.491.1644843573562;
        Mon, 14 Feb 2022 04:59:33 -0800 (PST)
Received: from jade (h-94-254-48-165.A175.priv.bahnhof.se. [94.254.48.165])
        by smtp.gmail.com with ESMTPSA id v26sm446752lfo.178.2022.02.14.04.59.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Feb 2022 04:59:33 -0800 (PST)
Date:   Mon, 14 Feb 2022 13:59:31 +0100
From:   Jens Wiklander <jens.wiklander@linaro.org>
To:     arm@kernel.org, soc@kernel.org
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        op-tee@lists.trustedfirmware.org,
        Yang Yingliang <yangyingliang@huawei.com>,
        sumit.garg@linaro.org
Subject: [GIT PULL] OP-TEE another fix for v5.17
Message-ID: <20220214125931.GA1332792@jade>
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

Please pull this small OP-TEE driver fix taking care of a broken return
code in the error path of the two probe functions in the OP-TEE driver.

Please note that this pull request is on top of the previously just merged
patch which introduced the problem fixed here.

Thanks,
Jens

The following changes since commit aceeafefff736057e8f93f19bbfbef26abd94604:

  optee: use driver internal tee_context for some rpc (2022-02-03 13:36:32 +0100)

are available in the Git repository at:

  git://git.linaro.org/people/jens.wiklander/linux-tee.git tags/optee-fix2-for-v5.17

for you to fetch changes up to 40eb0dcf4114cbfff4d207890fa5a19e82da9fdc:

  tee: optee: fix error return code in probe function (2022-02-14 12:36:48 +0100)

----------------------------------------------------------------
OP-TEE fix error return code in probe functions

----------------------------------------------------------------
Yang Yingliang (1):
      tee: optee: fix error return code in probe function

 drivers/tee/optee/ffa_abi.c | 4 +++-
 drivers/tee/optee/smc_abi.c | 4 +++-
 2 files changed, 6 insertions(+), 2 deletions(-)
