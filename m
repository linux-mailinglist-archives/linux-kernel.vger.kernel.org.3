Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6601857A85E
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Jul 2022 22:39:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239953AbiGSUjL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Jul 2022 16:39:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239876AbiGSUjE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jul 2022 16:39:04 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6C3852DEC
        for <linux-kernel@vger.kernel.org>; Tue, 19 Jul 2022 13:39:02 -0700 (PDT)
Received: from notapiano.myfiosgateway.com (pool-98-113-53-228.nycmny.fios.verizon.net [98.113.53.228])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: nfraprado)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id D78B566019F4;
        Tue, 19 Jul 2022 21:38:59 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1658263141;
        bh=D1EWl395kCS6h9fC4licHdb775gvbaCYO+elJhLtDmA=;
        h=From:To:Cc:Subject:Date:From;
        b=KRnBrc6/9DRdIeYev/BAVNY520rNMChpUdoTiasS8vIVBIMGrjCzdT0i9uW2AANbw
         xGHvCKiIjhRg7aKk3vT973p2Ppq6m0F7bDzyXPMbJ5fj/JBUchc/CwYEVDRgo3def3
         2ECRnE5npZeSAqT4Hu3lSN8f3QN7UvaPgLDwzqoSNQjBBQMnnPK3/0GHEzUI/MaUXt
         2Par5Ttoy6cM7JiyPlYBqVIXZYyPI4oi7Mgc2Miec0l3HwtnNMdap+Qsae0XDeFAwW
         TBEyHKA/LtQ0gdfppCJKe3K/NOFHwdpuNKAzvcsoXYTVhkTIDlw+UAFH2H3LkCHWGJ
         9HyZC+Jhgn58Q==
From:   =?UTF-8?q?N=C3=ADcolas=20F=2E=20R=2E=20A=2E=20Prado?= 
        <nfraprado@collabora.com>
To:     Douglas Anderson <dianders@chromium.org>
Cc:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>, kernel@collabora.com,
        =?UTF-8?q?N=C3=ADcolas=20F=2E=20R=2E=20A=2E=20Prado?= 
        <nfraprado@collabora.com>, Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@linux.ie>,
        Linus Walleij <linus.walleij@linaro.org>,
        Sam Ravnborg <sam@ravnborg.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: [PATCH 0/3] New eDP panels and a bugfix
Date:   Tue, 19 Jul 2022 16:38:53 -0400
Message-Id: <20220719203857.1488831-1-nfraprado@collabora.com>
X-Mailer: git-send-email 2.37.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


This series adds two new eDP panel entries in the first two patches, and
fixes a typo in the third one that prevented usage of the DT properties.

Please see the note in patch 1 for a question on hpd_reliable vs.
hpd_absent.


Nícolas F. R. A. Prado (3):
  drm/panel-edp: Add panel entry for R140NWF5 RH
  drm/panel-edp: Add panel entry for B120XAN01.0
  drm/panel-edp: Fix variable typo when saving hpd absent delay from DT

 drivers/gpu/drm/panel/panel-edp.c | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

-- 
2.37.0

