Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 348E7521DA8
	for <lists+linux-kernel@lfdr.de>; Tue, 10 May 2022 17:09:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238246AbiEJPMw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 May 2022 11:12:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346127AbiEJPLx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 May 2022 11:11:53 -0400
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B149825B05B;
        Tue, 10 May 2022 07:45:21 -0700 (PDT)
Received: by mail-ej1-x62f.google.com with SMTP id kq17so33443077ejb.4;
        Tue, 10 May 2022 07:45:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=c+hsJzreaFfLVPyymmLrJkbyzmNJnJu0qYLtB9ahG6I=;
        b=Pvlrqisa1HswCwseRK15nENZEWQjoMc6spitn2A60Toeq2u4wyRG+3D8kZNYnnyuDY
         9B9drOlmdCDl44n0mlLh/ePzcVnHgzvsmA62fzw4U5HS0e3OpUiHr5zEOTf0wTBqLx2w
         npSUuQ19m0y2UrlY2sVD7f3VanQHN3FNAsHvhJmswelBFq0dnTJlrsZbePKQ2cdDwxKn
         FFs+aWCv83G8Vx7PImReftM1vgLqU6Hf0GElXyWqNRvaVy2Nw3uZU9EyNWrmLOsmfzA8
         U7NVEoxvhVTyYIegJb4iGIid9ZrGAmZGpm5Ubn4q+d+baPRupiqJotuFWPgCnzIpllWA
         ZQ3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=c+hsJzreaFfLVPyymmLrJkbyzmNJnJu0qYLtB9ahG6I=;
        b=brsOaKtHX94TyV7vErNm5kiEFf1J7vuUYBA1lSPxjA21EXxyC0LmrAfXd0WyG5mdkT
         SxebNjSe4jvmtFCA2mV3iZaS2KsWmINufKxUo7r1GJUlu562euiOD74hlRxnz+X2RMSD
         9E1ZwTgF7t8qKf5N2NsrUgRZCeuGmbYcTKDo7KWbiWAKT4ipp5OWd8GCtiBNgiLv0ESq
         HKio74NXFK7hx4JDXDzkWfo2opPulmCM3fDDNbaRtrm9D8mWWQ6VIiwXWDu8xIVK7rlc
         1uU9FN27nPwsjbCiHp4ed/lt32a+MxBu71zAmaO9VFKzkWUtAq5fY3Y+2M8fH4s1tiXp
         d8Kg==
X-Gm-Message-State: AOAM533qv9V6DD8TLxWvgTdMqhxW4aKl9x2szXV7i5OAP2oS6xHa8BqG
        ouifin2kgIGF3HbTexMq+m8=
X-Google-Smtp-Source: ABdhPJzbwex+ryg9LpRDhemVltmdQwfI6oaKvTEX7Dp179Go73CpJYXZYcOYN8rQYQA8rk/O4g1ujw==
X-Received: by 2002:a17:907:6d1f:b0:6fc:309f:8363 with SMTP id sa31-20020a1709076d1f00b006fc309f8363mr3370782ejc.655.1652193920050;
        Tue, 10 May 2022 07:45:20 -0700 (PDT)
Received: from localhost.localdomain (89-38-99-188.hosted-by-worldstream.net. [89.38.99.188])
        by smtp.gmail.com with ESMTPSA id z16-20020a170906241000b006fb6d9d25bfsm829652eja.22.2022.05.10.07.45.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 May 2022 07:45:19 -0700 (PDT)
From:   Yassine Oudjana <yassine.oudjana@gmail.com>
X-Google-Original-From: Yassine Oudjana <y.oudjana@protonmail.com>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Cc:     Yassine Oudjana <y.oudjana@protonmail.com>,
        Yassine Oudjana <yassine.oudjana@gmail.com>,
        linux-arm-msm@vger.kernel.org, linux-remoteproc@vger.kernel.org,
        linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org
Subject: [RFC PATCH 0/2] Make qcom-ngd-ctrl not wait indefinitely for already booted ADSP
Date:   Tue, 10 May 2022 18:42:17 +0400
Message-Id: <20220510144219.806391-1-y.oudjana@protonmail.com>
X-Mailer: git-send-email 2.36.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit a899d324863a3 ("slimbus: qcom-ngd-ctrl: add Sub System Restart support")
made qcom-ngd-ctrl wait for ADSP to become ready before starting to do its work.
Due to how the SSR notifications currently work though, if qcom-ngd-ctrl probes
after ADSP boots and becomes ready, it never receives a QCOM_SSR_AFTER_POWERUP
event notification and keeps waiting indefinitely, making SLIMbus never come up.

This series makes qcom_register_ssr_notifier call the notifier_call of the newly
registered notifier block with the last SSR event received from the remoteproc,
basically reporting the event that qcom-ngd-ctrl missed by registering late,
stopping it from waiting for an event that has already happened.

I'm not sure if this approach would have any unwanted consequences in other
drivers relying on SSR events however, hence I'm sending this as a RFC. This
can also be considered a bug report, so if anyone has a better fix then I'd
appreciate it getting applied instead of this one.

The second patch is a general fix that became necessary after the first patch,
and should likely be applied anyway.

Yassine Oudjana (2):
  remoteproc: qcom: Report last event on SSR notifier registration
  slimbus: qcom-ngd-ctrl: Initialize ngd_up_work before it can be
    scheduled

 drivers/remoteproc/qcom_common.c | 17 +++++++++++++----
 drivers/slimbus/qcom-ngd-ctrl.c  |  3 ++-
 2 files changed, 15 insertions(+), 5 deletions(-)

-- 
2.36.0

