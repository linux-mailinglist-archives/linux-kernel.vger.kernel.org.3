Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C35194B27E7
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Feb 2022 15:32:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238528AbiBKOcJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Feb 2022 09:32:09 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:35564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233400AbiBKOcH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Feb 2022 09:32:07 -0500
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [46.235.227.227])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68E4BC7;
        Fri, 11 Feb 2022 06:32:06 -0800 (PST)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: tonyk)
        with ESMTPSA id 7DBE51F46F54
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1644589925;
        bh=29lBVtLy8seRsiUvGY6ScBxlEOXD0OeQ1SR4fDNTO+g=;
        h=From:To:Cc:Subject:Date:From;
        b=P+xFUdJd1pjJcLJ67LAEOTBF7c8cxVyrMXEuS6x1NnUx1QMTXDz6ie94RTtFy6UiW
         RB+AzaifyzS89FtWXnKgZYyfsv4XXkRZpkHzqitAuQmiiTziE3u+YpcDZIwQ67QnC9
         +ax6T4uSYJnohU1LePli/0vjjDhmVJ5grhFV9hw/w38hDaWtXKNM8xnAU1WJxfUjjc
         0DWWp0mOe6FDHrCrU0tjaaPu6s1HVTOL5MBQn4bSYUuCNQ4LOO6pGTDB0zOImFc3Na
         FI+1OIkLKvVEWINSE/sGdFl6AcqWX8iU+YQmCuFp5pFmB96Mpe9jhHnJld9jGUXXBh
         5S1fIB7slhc0w==
From:   =?UTF-8?q?Andr=C3=A9=20Almeida?= <andrealmeid@collabora.com>
To:     Sanjay R Mehta <sanju.mehta@amd.com>,
        Mark Brown <broonie@kernel.org>, linux-spi@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel@collabora.com,
        Lucas Tanure <tanureal@opensource.cirrus.com>,
        Nehal Bakulchandra Shah <Nehal-Bakulchandra.shah@amd.com>,
        Charles Keepax <ckeepax@opensource.cirrus.com>
Cc:     =?UTF-8?q?Andr=C3=A9=20Almeida?= <andrealmeid@collabora.com>
Subject: [PATCH v2 0/3] spi: amd: Add support for new controller version
Date:   Fri, 11 Feb 2022 11:31:52 -0300
Message-Id: <20220211143155.75513-1-andrealmeid@collabora.com>
X-Mailer: git-send-email 2.35.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series do some cleanup and add support for new controller version,
AMDI0062.

Change from v1:
- Replace `if (version == 2)` with a more extensible switch case.

André Almeida (3):
  spi: amd: Use iopoll for busy waiting
  spi: amd: Remove needless rom_addr variable
  spi: amd: Add support for version AMDI0062

 drivers/spi/spi-amd.c | 89 ++++++++++++++++++++++++++++++++++---------
 1 file changed, 72 insertions(+), 17 deletions(-)

-- 
2.35.0

