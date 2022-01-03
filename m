Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0BCCE48382D
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jan 2022 22:02:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229669AbiACVCE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Jan 2022 16:02:04 -0500
Received: from dfw.source.kernel.org ([139.178.84.217]:33746 "EHLO
        dfw.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229504AbiACVCC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jan 2022 16:02:02 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7039661217;
        Mon,  3 Jan 2022 21:02:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CF3DCC36AE9;
        Mon,  3 Jan 2022 21:02:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1641243721;
        bh=maJiq2oegAKV/tw+qYSZGdN/UMePpmSMWL6lzTLaAOE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=kti5CSiBl6cpM4me44yxA5MKXlxlPxwr4NMoI3M9ZlI5gGFdce0SJSpl1pNrKJioH
         GyR8o29R1XSS37ONPQBIsGcjn7uHHIP8HK5zeObc+SZ1vc/1+kCBguuXwi42K1gpLK
         ExctdPYsyn4Kjx41vxgnQv8adoo8qqZT4CzFRe1E1iOfHJPM4ACuYwkawS5VQ7YVwn
         C6goGAWtq22X8e2SJgwxY+H9BZWv8gQyLPpEbHmnTe8QLuCV0t1wnF4T1f6a78kvAY
         bfMCTe45hTq4f/4s3KkziF/mzbZS8C1sUGTPQa9apwRjo+6G7SsiPoWPO0BbQdhyZM
         09/foX0io3CGQ==
Received: from mchehab by mail.kernel.org with local (Exim 4.94.2)
        (envelope-from <mchehab@kernel.org>)
        id 1n4USt-00086e-ML; Mon, 03 Jan 2022 22:01:59 +0100
From:   Mauro Carvalho Chehab <mchehab@kernel.org>
To:     Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
        Christoph Hellwig <hch@lst.de>
Subject: [PATCH 0/1] Detect the need of texlive-ctex
Date:   Mon,  3 Jan 2022 22:01:56 +0100
Message-Id: <cover.1641243581.git.mchehab@kernel.org>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <20220103215831.2e65bb94@coco.lan>
References: <20220103215831.2e65bb94@coco.lan>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jon,

Based on Christoph's report, it seems we need to add an extra dependency
for PDF builds.

Mauro Carvalho Chehab (1):
  scripts: sphinx-pre-install: add required ctex dependency

 scripts/sphinx-pre-install | 1 +
 1 file changed, 1 insertion(+)

-- 
2.33.1


