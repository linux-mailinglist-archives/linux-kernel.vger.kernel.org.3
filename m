Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B255E479BFD
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Dec 2021 19:12:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231984AbhLRSMZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 18 Dec 2021 13:12:25 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:55612 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229729AbhLRSMY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Dec 2021 13:12:24 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id CA6DFB8077E
        for <linux-kernel@vger.kernel.org>; Sat, 18 Dec 2021 18:12:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B3CA1C36AE0;
        Sat, 18 Dec 2021 18:12:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1639851142;
        bh=QGnmW4l/kPq4TiylsDcWDOdzNWa7guP/n56sALNRcYA=;
        h=From:To:Cc:Subject:Date:From;
        b=mdOBqkiGKTDNcaA34N05YrPiBSy/F90VHm2CAIWZW0ybytMolhxHt520Wv6iOI2Xg
         OPXW858tPizG+rYrtUbtdvUCKdKuLFLk6gKlnZTWVH2QF7AG/34h6J33GRygazwTEg
         wT071A58GzGWc9pJa6t0RCVNGYp6Wc8IN+6ZP1go+4HZGbrdp6y7HDhoOXg0+nodn6
         BvVJhlCPljdOhX/I8EZ5XisVMskZY3pCA0vJNm4zv6+Y+YBPRR9UL01/huu8zRBi7T
         NnCjiQ6Lj5kVNA59Tev8S9FLR2mv06/Mt4Xlatb1yuTvvJHxOOXu6SBKd56AYXmzhq
         pxWEowoX6NXbw==
From:   Nicolas Saenz Julienne <nsaenz@kernel.org>
To:     Florian Fainelli <f.fainelli@gmail.com>
Cc:     Nicolas Saenz Julienne <nsaenz@kernel.org>,
        linux-kernel@vger.kernel.org,
        bcm-kernel-feedback-list@broadcom.com,
        linux-rpi-kernel@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org
Subject: [GIT PULL v2 1/1] bcm2835-bindings-2021-12-18
Date:   Sat, 18 Dec 2021 19:11:36 +0100
Message-Id: <20211218181135.192699-1-nsaenz@kernel.org>
X-Mailer: git-send-email 2.33.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Florian,

The following changes since commit fa55b7dcdc43c1aa1ba12bca9d2dd4318c2a0dbf:

  Linux 5.16-rc1 (2021-11-14 13:56:52 -0800)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/nsaenz/linux-rpi.git tags/bcm2835-bindings-2021-12-18

for you to fetch changes up to eafba51c545a165b29777cde1fc8b04781a0a8db:

  dt-bindings: soc: bcm: Convert brcm,bcm2835-vchiq to json-schema (2021-12-18 18:54:57 +0100)

----------------------------------------------------------------
Stefan Wahren converts VCHIQ's bindings to YAML format.

----------------------------------------------------------------
Stefan Wahren (1):
      dt-bindings: soc: bcm: Convert brcm,bcm2835-vchiq to json-schema

 .../bindings/soc/bcm/brcm,bcm2835-vchiq.txt        | 17 -------
 .../bindings/soc/bcm/brcm,bcm2835-vchiq.yaml       | 53 ++++++++++++++++++++++
 2 files changed, 53 insertions(+), 17 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/soc/bcm/brcm,bcm2835-vchiq.txt
 create mode 100644 Documentation/devicetree/bindings/soc/bcm/brcm,bcm2835-vchiq.yaml
