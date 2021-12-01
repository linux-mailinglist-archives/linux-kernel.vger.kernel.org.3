Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E3291464988
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Dec 2021 09:22:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347932AbhLAIZi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Dec 2021 03:25:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229564AbhLAIZc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Dec 2021 03:25:32 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E894C061574;
        Wed,  1 Dec 2021 00:22:12 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id CF4E1B81DE5;
        Wed,  1 Dec 2021 08:22:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 830C5C53FD0;
        Wed,  1 Dec 2021 08:22:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1638346929;
        bh=TLal6vDUO7FSD6lUwwLUXTgfABTdnazP4nUQ1mVE3us=;
        h=From:To:Cc:Subject:Date:From;
        b=BYnEaGlOciEMfd54xpMxaB7FJionNWe6rDcfb1hIjL1HMnMRJvpviWl/SpFQ2Zixq
         xxe8kDvHJCnV2LC183lSIwiy4NrLyKweFAHHnP9m9B+3ItSuRtnbFDSi1XLy8kn4Wp
         Hm3dXCnWZjIz6STcQdamdrf6WcSzQkz6IOy3Ij5JiYb1BJjVs3WVvYfbgC2P3puKNk
         VNu/aSL7NMj593vOUSQzrboM1ihrt7uFS6EeY89L8j29nwKbSCZ5oEdKxS93ZbTs0Z
         CsPrqGPv2Osscppw4r6T9tqkJSqKHYfwRVGvnySArRR9ofXAYohtWioISki7+n6bdV
         aUv0XiXpNS4zw==
Received: from mchehab by mail.kernel.org with local (Exim 4.94.2)
        (envelope-from <mchehab@kernel.org>)
        id 1msKsP-0043D1-PS; Wed, 01 Dec 2021 09:22:05 +0100
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        Jonathan Corbet <corbet@lwn.net>
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        linux-kernel@vger.kernel.org,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Akira Yokosawa <akiyks@gmail.com>
Subject: [PATCH 0/1] Docs: use RTD dark mode if available
Date:   Wed,  1 Dec 2021 09:22:02 +0100
Message-Id: <cover.1638346585.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.33.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Mauro Carvalho Chehab <mchehab@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jon,

As we're analyzing some theme alternatives, one of the things that annoys
me more at our theme is that it doesn't come with a dark mode.

At least here, I strongly prefer dark themes, as it seems to be a lot more
comfortable to my eyes, specially in the morning.

There's an extension to the RTD theme that allows building the docs with a
dark theme, with a button to select normal mode.

As this comes almost for free, optionally enable the dark mode extension if
such theme is installed at the machine.

Mauro Carvalho Chehab (1):
  docs: add support for dark mode

 Documentation/conf.py | 8 ++++++++
 1 file changed, 8 insertions(+)

-- 
2.33.1


