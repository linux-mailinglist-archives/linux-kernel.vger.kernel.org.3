Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4D91E533746
	for <lists+linux-kernel@lfdr.de>; Wed, 25 May 2022 09:20:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244320AbiEYHU0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 May 2022 03:20:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244308AbiEYHUY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 May 2022 03:20:24 -0400
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 400A0261A
        for <linux-kernel@vger.kernel.org>; Wed, 25 May 2022 00:20:21 -0700 (PDT)
Received: by mail-wm1-x32a.google.com with SMTP id p19so3462022wmg.2
        for <linux-kernel@vger.kernel.org>; Wed, 25 May 2022 00:20:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=uYFYfxoNsvqjWq3cVk8VAYueu2Qkp0ObH+2Y6ZW4tVQ=;
        b=XGpLDihouofUM8O+WmU1hMyTds9voxGLf2+10wlHnzh7857rKLTFOqqXtMoSjsfNvP
         Fr5/cKEMJ4/Z0pLAKITrhaptemgAWoTemUTcbHDdeJ0jPzlt7IPwzI1eNbBxWK4p/ieo
         OcO+hgtPh/7vrrg9VpQ3A2L+PuPAcVRdWSaNsCGkkDa1tukQN4TXCuNYulrDRpo3Bxq1
         LLOgpadflKlxpb+nUge2e2FE2vlqm0wWaw9T7Ml0niU0IM2gz6D6cCA1RfygadWp/MxG
         gYOacGo98zJFr91/uk30yQ8wWmAsxzjuqY4ncIrFaB9DzdBeX/pX61FK0DWB+JoGU/es
         nzXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=uYFYfxoNsvqjWq3cVk8VAYueu2Qkp0ObH+2Y6ZW4tVQ=;
        b=6j1ymtOa0+/DasdTdfzujQkDGmRIsyLiamZJZKtb0tuPx7QZe00OjbcWn5i3copVcA
         5MkR7WOVliYs/5OsNaltVNu8BP1R77Ho3OAesS6uK6omAICOrT3lNuc5GazzUg0Y+wYP
         Z9cAEQNvzJcVfMfuGWTTaSSzEKz/7aEzxkQH+v32XtPWN1yXbxkSR5/is3FQMaycdyKl
         eMR52PslBWSc181oF0G82/SAHywYHp0tl6wy9AztwkA6q/foKsukb2ESxesBwuJuwIqu
         0OkX+4IzcS86CIdqkVQ6bRxTXol7fHFoV4qYCLOgUrmkQ3t0u8eyDshMWFBVcV3CLUFK
         6rYw==
X-Gm-Message-State: AOAM531Ov6zJMdcvrVdCHl+31r9RHvz+vsBx8YeFsJDhaNjFJj4Zqxtj
        xhe2bfHU39Hefc3x9h8igSlclw==
X-Google-Smtp-Source: ABdhPJzJ6lz+uvAOJ07h80qckjrMvByvZ0P4qBjlYnuhD69PdbR1PHuv8YidpCb+7KBJOIQ0a9GHxQ==
X-Received: by 2002:a05:600c:3482:b0:397:4abe:9f8e with SMTP id a2-20020a05600c348200b003974abe9f8emr6827443wmq.71.1653463219696;
        Wed, 25 May 2022 00:20:19 -0700 (PDT)
Received: from localhost.localdomain (laubervilliers-658-1-213-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.gmail.com with ESMTPSA id g14-20020a5d46ce000000b0020ff3a2a925sm1529240wrs.63.2022.05.25.00.20.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 May 2022 00:20:19 -0700 (PDT)
From:   Neil Armstrong <narmstrong@baylibre.com>
To:     Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Kevin Hilman <khilman@baylibre.com>,
        linux-amlogic@lists.infradead.org,
        Jerome Brunet <jbrunet@baylibre.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Miaoqian Lin <linmq006@gmail.com>
Cc:     Neil Armstrong <narmstrong@baylibre.com>
Subject: Re: [PATCH] meson-mx-socinfo: Fix refcount leak in meson_mx_socinfo_init
Date:   Wed, 25 May 2022 09:20:16 +0200
Message-Id: <165346315887.272786.7785185844599075827.b4-ty@baylibre.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220524065729.33689-1-linmq006@gmail.com>
References: <20220524065729.33689-1-linmq006@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Tue, 24 May 2022 10:57:29 +0400, Miaoqian Lin wrote:
> of_find_matching_node() returns a node pointer with refcount
> incremented, we should use of_node_put() on it when not need anymore.
> Add missing of_node_put() to avoid refcount leak.
> 
> 

Thanks, Applied to https://git.kernel.org/pub/scm/linux/kernel/git/amlogic/linux.git (v5.20/drivers)

[1/1] meson-mx-socinfo: Fix refcount leak in meson_mx_socinfo_init
      https://git.kernel.org/amlogic/c/a2106f38077e78afcb4bf98fdda3e162118cfb3d

These changes has been applied on the intermediate git tree [1].

The v5.20/drivers branch will then be sent via a formal Pull Request to the Linux SoC maintainers
for inclusion in their intermediate git branches in order to be sent to Linus during
the next merge window, or sooner if it's a set of fixes.

In the cases of fixes, those will be merged in the current release candidate
kernel and as soon they appear on the Linux master branch they will be
backported to the previous Stable and Long-Stable kernels [2].

The intermediate git branches are merged daily in the linux-next tree [3],
people are encouraged testing these pre-release kernels and report issues on the
relevant mailing-lists.

If problems are discovered on those changes, please submit a signed-off-by revert
patch followed by a corrective changeset.

[1] https://git.kernel.org/pub/scm/linux/kernel/git/amlogic/linux.git
[2] https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git
[3] https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git

-- 
Neil
