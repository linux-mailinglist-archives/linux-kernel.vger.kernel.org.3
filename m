Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EFD6E54A5EE
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Jun 2022 04:23:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353145AbiFNCPz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Jun 2022 22:15:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353444AbiFNCNq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jun 2022 22:13:46 -0400
Received: from challenge-bot.com (challenge-bot.com [IPv6:2602:fffa:fff:108a:0:16:3e15:92b8])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60B343526C
        for <linux-kernel@vger.kernel.org>; Mon, 13 Jun 2022 19:07:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=challenge-bot.com; s=20180430; h=Content-Transfer-Encoding:MIME-Version:
        Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=VGcRSjLbV9ZwhBfGleDibb3DqhkmCY5REWvPttnsKmE=; b=hCDYokHHkYRXevfvOlQR/aKGnF
        iktpm/cCXqT7ibOI3bCAz2IslF5oS7ilcHx2wkTl5q6IuC5CnDlvmFWjiZEET50oNOGy7HiySvM7Q
        VColeqOY4csXLccXUvusNODUkjuI94DcT79HaBur/BWY6bjAiPBAEHYv26fBVK2zajLk=;
Received: from ozzloy by challenge-bot.com with local (Exim 4.92)
        (envelope-from <ozzloy@challenge-bot.com>)
        id 1o0vy8-00087N-0a; Mon, 13 Jun 2022 19:07:48 -0700
From:   daniel watson <ozzloy@challenge-bot.com>
To:     Larry Finger <Larry.Finger@lwfinger.net>,
        Phillip Potter <phil@philpotter.co.uk>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Cc:     Daniel Watson <ozzloy@challenge-bot.com>
Subject: [PATCH 0/4] remove wrappers on _rtw_IOL_append_*_cmd
Date:   Mon, 13 Jun 2022 19:07:29 -0700
Message-Id: <cover.1655171591.git.ozzloy@challenge-bot.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Daniel Watson <ozzloy@challenge-bot.com>

This patchset removes the #define wrappers around the
rtl_IOL_append_*_cmd group of functions.  They are not needed.

Daniel Watson (4):
  staging: r8188eu: remove leading '_' on _rtw_IOL_append_WB_cmd
  staging: r8188eu: remove leading '_' on _rtw_IOL_append_WW_cmd
  staging: r8188eu: remove leading '_' on _rtw_IOL_append_WD_cmd
  staging: r8188eu: remove leading '_' on _rtw_IOL_append_WRF_cmd

 drivers/staging/r8188eu/core/rtw_iol.c    |  8 ++++----
 drivers/staging/r8188eu/include/rtw_iol.h | 24 ++++++++---------------
 2 files changed, 12 insertions(+), 20 deletions(-)

-- 
2.34.1

