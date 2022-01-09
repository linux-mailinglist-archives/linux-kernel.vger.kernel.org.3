Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 310BB488AD1
	for <lists+linux-kernel@lfdr.de>; Sun,  9 Jan 2022 18:09:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236109AbiAIRJ2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 9 Jan 2022 12:09:28 -0500
Received: from bhuna.collabora.co.uk ([46.235.227.227]:57102 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234264AbiAIRJ1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Jan 2022 12:09:27 -0500
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: alyssa)
        with ESMTPSA id 637D01F437F6
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1641748166;
        bh=8W7vBIEgSnoCkPMKRIa5QuPFZzJdKKSxbNZQLAq5WS8=;
        h=From:To:Cc:Subject:Date:From;
        b=orqjbdhdJuzL5HMSFOiSCRnMmdn5Fxos4p/nbM0D204YVG9TkYv0wRScQsjK5Ru+p
         fK5BHNKQmmE805OlbwoDPUSTDF1wv0uoQOPeA8sWslJCiyuUhu6WSQhT8SRJ4pedI0
         QUZ6GeqbBGXfBlQmcLdYB/fHJGvuSlIYThxLhHMssyJdyXuRsN2mPv79ARcbb6ws8p
         8dAI7jdWcmaeTiUmj1oajpzRM6hoR9hDyy+1+M+B+tNKRbnowfh4TwEJP0LlieW6gH
         pYsH3J2KTl143grl2tHwCVftv87mDKCpoGk7VR+4BWm7IqF/ZQlSrghhBw1QjRx40e
         x3vReOwgRkt9w==
From:   Alyssa Rosenzweig <alyssa.rosenzweig@collabora.com>
To:     dri-devel@lists.freedesktop.org
Cc:     Rob Herring <robh@kernel.org>,
        Tomeu Vizoso <tomeu.vizoso@collabora.com>,
        Steven Price <steven.price@arm.com>,
        Alyssa Rosenzweig <alyssa.rosenzweig@collabora.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>, linux-kernel@vger.kernel.org
Subject: [PATCH 0/2] drm/panfrost: Clean up our feature lists
Date:   Sun,  9 Jan 2022 12:09:17 -0500
Message-Id: <20220109170920.2921-1-alyssa.rosenzweig@collabora.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We've cargo culted a large number of useless feature bits from kbase.
We're about to add support for a number of new Mali GPUs into mainline.
Let's cut down on the copy-paste required and clean up the feature lists
first.

Alyssa Rosenzweig (2):
  drm/panfrost: Remove features meant for userspace
  drm/panfrost: Merge some feature lists

 drivers/gpu/drm/panfrost/panfrost_features.h | 212 +------------------
 1 file changed, 7 insertions(+), 205 deletions(-)

-- 
2.34.1

