Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AA2DF4FBA61
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Apr 2022 13:02:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345852AbiDKLEg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Apr 2022 07:04:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344902AbiDKLEB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Apr 2022 07:04:01 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0CA8C47;
        Mon, 11 Apr 2022 04:01:46 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 590741F7AC;
        Mon, 11 Apr 2022 11:01:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1649674905; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=VLW61QJTv1mS1iixu/oufPW4nB7MoJz4abXXNGERoBw=;
        b=hXUt6rPwHh7Vs4roB28o3Q9/zgpqyth62Q07ZdKCCAAXebLpHxlmG948sOL/LIYmoAb4RQ
        VfCUGfFAamkiBTf9BR2MsUZABDJ8WEjPuaXu8RpbC0LMjTioheoUF5eQNhMitH/sq2DCxB
        pgVF382g8CZXucxsI9eJzV9Wco+NyJk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1649674905;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=VLW61QJTv1mS1iixu/oufPW4nB7MoJz4abXXNGERoBw=;
        b=cNhAOTLlTGnBUTocPH70By6aJaNZGSb9l6NSjAB5Lp/Rh2fBq1pxxQoIsn4e+pLsC5CR52
        2BpoZg3K+vAN46BA==
Received: from localhost.localdomain (unknown [10.100.208.98])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 262D3A3B89;
        Mon, 11 Apr 2022 11:01:45 +0000 (UTC)
From:   Jiri Slaby <jslaby@suse.cz>
To:     gregkh@linuxfoundation.org
Cc:     linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jiri Slaby <jslaby@suse.cz>
Subject: [PATCH 5/6] Documentation: tty: n_gsm, delete "Additional Documentation"
Date:   Mon, 11 Apr 2022 13:01:42 +0200
Message-Id: <20220411110143.10019-6-jslaby@suse.cz>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220411110143.10019-1-jslaby@suse.cz>
References: <20220411110143.10019-1-jslaby@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

All of the URLs give 404. There is a little point to preserve them. If
really need be, we could try archive.org if the documents are not there
by a chance.

Signed-off-by: Jiri Slaby <jslaby@suse.cz>
---
 Documentation/driver-api/tty/n_gsm.rst | 10 ----------
 1 file changed, 10 deletions(-)

diff --git a/Documentation/driver-api/tty/n_gsm.rst b/Documentation/driver-api/tty/n_gsm.rst
index 49956509ad73..04308a7a194a 100644
--- a/Documentation/driver-api/tty/n_gsm.rst
+++ b/Documentation/driver-api/tty/n_gsm.rst
@@ -146,14 +146,4 @@ Major parts of the initialization program :
 	daemon(0,0);
 	pause();
 
-Additional Documentation
-------------------------
-More practical details on the protocol and how it's supported by industrial
-modems can be found in the following documents :
-
-- http://www.telit.com/module/infopool/download.php?id=616
-- http://www.u-blox.com/images/downloads/Product_Docs/LEON-G100-G200-MuxImplementation_ApplicationNote_%28GSM%20G1-CS-10002%29.pdf
-- http://www.sierrawireless.com/Support/Downloads/AirPrime/WMP_Series/~/media/Support_Downloads/AirPrime/Application_notes/CMUX_Feature_Application_Note-Rev004.ashx
-- http://wm.sim.com/sim/News/photo/2010721161442.pdf
-
 11-03-08 - Eric Bénard - <eric@eukrea.com>
-- 
2.35.1

