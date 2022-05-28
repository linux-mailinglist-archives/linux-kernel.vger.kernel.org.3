Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1EE21536E8D
	for <lists+linux-kernel@lfdr.de>; Sat, 28 May 2022 23:19:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230049AbiE1VRA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 28 May 2022 17:17:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230021AbiE1VQz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 28 May 2022 17:16:55 -0400
X-Greylist: delayed 90 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Sat, 28 May 2022 14:16:53 PDT
Received: from p-impout004.msg.pkvw.co.charter.net (p-impout004aa.msg.pkvw.co.charter.net [47.43.26.135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87ED0BC13
        for <linux-kernel@vger.kernel.org>; Sat, 28 May 2022 14:16:53 -0700 (PDT)
Received: from 2603-8090-2005-39b3-0000-0000-0000-100e.res6.spectrum.com.com ([24.31.246.181])
        by cmsmtp with ESMTP
        id v3mLnd6IdgPEBv3mLnEtsa; Sat, 28 May 2022 21:15:21 +0000
X-Authority-Analysis: v=2.4 cv=b8OhX/Kx c=1 sm=1 tr=0 ts=629290e9
 a=cAe/7qmlxnd6JlJqP68I9A==:117 a=cAe/7qmlxnd6JlJqP68I9A==:17
 a=IkcTkHD0fZMA:10 a=yQdBAQUQAAAA:8 a=OUNqcoRDPagEZD6Yk-wA:9 a=QEXdDO2ut3YA:10
 a=SzazLyfi1tnkUD6oumHU:22
From:   Larry Finger <Larry.Finger@lwfinger.net>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org,
        Larry Finger <Larry.Finger@lwfinger.net>
Subject: [PATCH 0/2] Fix some compile warnings in v5.18+
Date:   Sat, 28 May 2022 16:14:50 -0500
Message-Id: <20220528211452.32134-1-Larry.Finger@lwfinger.net>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-CMAE-Envelope: MS4xfL01EtJBTZhAxsRLA7g7829WUUPZ2voFUKSBTpeoMndJYhEwrDvLE9DNF8LOyJBS1GJRSfEZh+qJE1Op5qDcwEs9DLKjh60yioI0fylC1klA4LCTtMy5
 P+7euDN03RXxF6/XCnQRIonPnSA6rCStA/D4SRMioI/Lq0rMlRTE2L7ewosQ99ceucjTXvHv/unxZzbFnc6cwaSP0Wm63xKGlcKOKMVdVVSzARUuMI64mfpC
 VeHkOzSh+yn++5Aje88+5AU5jAopfGTV9aigg5R2lQRTYs2JwJarxXRGZHrQlOPs6oEY32XeaxfWjgO5V5sqP2u+mETXA5wdYvsF6fX+NoeXAm8nXghgprZ+
 ZK8Ec5Le
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,KHOP_HELO_FCRDNS,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Building driver r8188eu in staging with -warray-bounds exposes two places
where arrays are too small.

Signed-off-by: Larry Finger <Larry.Finger@lwfinger.net>


Larry Finger (2):
  staging: r8188eu: Fix warning of array overflow in ioctl_linux.c
  staging: r8188eu: Fix undersized array in rtw_xmit.c

 drivers/staging/r8188eu/include/rtw_xmit.h   | 2 +-
 drivers/staging/r8188eu/os_dep/ioctl_linux.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

-- 
2.36.1

