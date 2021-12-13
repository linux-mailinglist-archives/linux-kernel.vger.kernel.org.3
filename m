Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3AD50473028
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Dec 2021 16:09:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239982AbhLMPJH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Dec 2021 10:09:07 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:57648 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233162AbhLMPJH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Dec 2021 10:09:07 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id C5C46B810AC;
        Mon, 13 Dec 2021 15:09:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 30321C34602;
        Mon, 13 Dec 2021 15:09:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1639408144;
        bh=HUvAyfKpicJy9wW4Pcsd6d9ZeDEin/MVCIT1qXKAzwM=;
        h=From:To:Cc:Subject:Date:From;
        b=ZRzFTkeHZKLj0xi+okug4C87XFs+ohLUFaLK6GAOSU1CTBAmS1qyCqp6UW+RxxFsf
         W6FJ8JRBYvagtLKizF1wRUDswdSMdyLY4X2wWH27Gd1KqGwIcdfTFgAE8A1nJ7bP1W
         3b28bZtLrilvOg/ltO77V38RuBfC1fFun0izlaZ3eHWP032VQQURCBMzNPxPPX2o5l
         uduiLPSbSf0OoPDQm0wfUhgif9x2+TYwHUOUu5ImmynDqu3uQIXZsQVmyUW+b7sDJm
         HC3LzJl2gD82cmbY/LZhrOLRtqJOUBWsyvazH+Z1if1e4E/kXBnpANJwUTmZqQT9Ll
         KGXUvYiGcEaVw==
From:   broonie@kernel.org
To:     Alex Deucher <alexdeucher@gmail.com>
Cc:     Alex Deucher <alexander.deucher@amd.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Monk Liu <Monk.Liu@amd.com>, shaoyunl <shaoyun.liu@amd.com>
Subject: linux-next: manual merge of the amdgpu tree with the drm-misc tree
Date:   Mon, 13 Dec 2021 15:08:59 +0000
Message-Id: <20211213150859.1208442-1-broonie@kernel.org>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

Today's linux-next merge of the amdgpu tree got a conflict in:

  drivers/gpu/drm/amd/amdgpu/amdgpu_device.c

between commit:

  a90ad3c2afe5b ("drm/amdgpu:implement SRIOV gpu_reset (v2)")

from the drm-misc tree and commit:

  428890a3fec13 ("drm/amdgpu: adjust the kfd reset sequence in reset sriov function")

from the amdgpu tree.

I fixed it up (see below) and can carry the fix as necessary. This
is now fixed as far as linux-next is concerned, but any non trivial
conflicts should be mentioned to your upstream maintainer when your tree
is submitted for merging.  You may also want to consider cooperating
with the maintainer of the conflicting tree to minimise any particularly
complex conflicts.

diff --cc drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index cbb2bbb21f55b,4224be2413381..0000000000000
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
