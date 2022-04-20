Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 90665509402
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Apr 2022 01:55:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358634AbiDTX6h (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Apr 2022 19:58:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355420AbiDTX6g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Apr 2022 19:58:36 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 522813B2AC
        for <linux-kernel@vger.kernel.org>; Wed, 20 Apr 2022 16:55:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
        Content-ID:Content-Description:In-Reply-To:References;
        bh=e+xgcgU18VTRwMqLUzs4Xy1QA+xZ2Tfhxb4e6SvrCQg=; b=j/r4mEU0LtAqZYazlNWole3vav
        Dg7iosLqKdSIQbMVKd7gGljj9o5IoRZiJijjvZn4CHpeIG8ubDUwwkjtonAfe4mWUS2XZwdzdp+xY
        HSe30ewrvDys0CrO9JsquEYm5m6K64Uq3gVNgBgAvtGCheUBMxVrjg44KAQlvgs++hnWUF+p5CAyP
        7GshMb+0vcu3SSPiWkJNRK1JLJkCSGDhZqVNr9FzG0iT69gK/Zg5zGwihu7wi3fR6+P0Lra1KTdAD
        oVUsw2yNSWHoYU22OSBsrEtcC/bB0tK0j8SSsdKLfKbo+MAE61EhEdtKDj42Emci195r5aqtGyWsr
        mVPmH+fQ==;
Received: from [2601:1c0:6280:3f0::aa0b] (helo=bombadil.infradead.org)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nhKAl-00Av7L-Ex; Wed, 20 Apr 2022 23:55:47 +0000
From:   Randy Dunlap <rdunlap@infradead.org>
To:     linux-kernel@vger.kernel.org
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Jiri Slaby <jirislaby@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH] MAINTAINERS: fix location of moxa-smartio.rst
Date:   Wed, 20 Apr 2022 16:55:45 -0700
Message-Id: <20220420235545.17081-1-rdunlap@infradead.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The moxa-smartio.rst file was moved to a different location,
so update the MAINTAINERS file entry for it.

Quietens one build warning:

MAINTAINERS:29715: WARNING: unknown document: ../driver-api/serial/moxa-smartio

Reported-by: Stephen Rothwell <sfr@canb.auug.org.au>
Fixes: 5b437ae9fcbb ("Documentation: tty: move moxa-smartio.rst to tty")
Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: Jiri Slaby <jirislaby@kernel.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 MAINTAINERS |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -13313,7 +13313,7 @@ F:	drivers/net/phy/motorcomm.c
 MOXA SMARTIO/INDUSTIO/INTELLIO SERIAL CARD
 M:	Jiri Slaby <jirislaby@kernel.org>
 S:	Maintained
-F:	Documentation/driver-api/serial/moxa-smartio.rst
+F:	Documentation/driver-api/tty/moxa-smartio.rst
 F:	drivers/tty/mxser.*
 
 MR800 AVERMEDIA USB FM RADIO DRIVER
