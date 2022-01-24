Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9C0BB4977B8
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jan 2022 04:45:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241094AbiAXDpL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 23 Jan 2022 22:45:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241090AbiAXDpK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Jan 2022 22:45:10 -0500
Received: from mail-pg1-x531.google.com (mail-pg1-x531.google.com [IPv6:2607:f8b0:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 188F1C06173B
        for <linux-kernel@vger.kernel.org>; Sun, 23 Jan 2022 19:45:10 -0800 (PST)
Received: by mail-pg1-x531.google.com with SMTP id t32so14109162pgm.7
        for <linux-kernel@vger.kernel.org>; Sun, 23 Jan 2022 19:45:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=tb8ev88MIiS9qrS2N39+coBDw1ZgKiiPgwQGLIy8NO0=;
        b=gh96JrdmAPsc3vo6qQxKFADlpyd8LFLO5olb3vqBrStdF45pW+n0QcSP602gA3hBEU
         vrwHNLqoYKQBonkebuD1MwqDQcyL5qO1lMYU8hbac8rcOJHbhlsZGyKRw+UODPSXTTZx
         yCgf0I0vJxh7/bI1SDb3TmNMuuVdaDWgvo9TTXFDBl/sn+Ncl6wsufslVow0wP9nMiMh
         GxlLJ0NuIIwVTEWrjWm0kcxMfO8saGIbGaCK/ZrHSvfcWFqZsPXknCCsbK6B4Hdk5lqu
         ZYMv5wGvg9DWSvUzW5r5/6l+e2mjtDfIYe6Z15qR9a9yRKBupmIY5i/JLxnWUQeeN4qq
         GgIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=tb8ev88MIiS9qrS2N39+coBDw1ZgKiiPgwQGLIy8NO0=;
        b=sEgzsftxMutcRo1ePxYBOytVLo/++Y/tlewuBuEtK7TN0MKqH346RupfbtkyXIMJKJ
         SM92xAaea1n429XsTuvss9JQPftO45rKGTk53AnLD25E1ZL/j6Hh/xkC/r/RPYkJnFDZ
         9hI1f+jZ4LPXa2IPKdlg82yWsmXckuBfPuqNVvfRhP3oD6BSNUAQHT0K5yeM3iD1AXkY
         /xrkma1m1kJH9vUtvI1Dyody3Kbf5Vl9JADAIbti+ohuelDeWVH+Loh3BTvi9jBDPiJR
         jRW31o1ykPzIozZ/XYbZdXBHKE+F9VvF3WZsI6mFlqS82eebE8fqjv8coLom4ZDR+2v+
         jXCQ==
X-Gm-Message-State: AOAM532IYzIUb8OfE8oZwmLCx8MZ6DWrbsByj5IMN7i15TnrzT1d56XF
        Sx3NULYoyxKGqhCvCcmQa0U=
X-Google-Smtp-Source: ABdhPJxNnfREXnof87U37sNWFZ2xiV4qj18RlwYBQyDNpnGgxu5CdKxZB8dkppEQ/4BfzAznDv/Y4g==
X-Received: by 2002:a05:6a00:b84:b0:4c8:fe03:94f8 with SMTP id g4-20020a056a000b8400b004c8fe0394f8mr3563911pfj.33.1642995909597;
        Sun, 23 Jan 2022 19:45:09 -0800 (PST)
Received: from localhost.localdomain ([27.7.142.194])
        by smtp.gmail.com with ESMTPSA id p38sm9853390pgb.36.2022.01.23.19.45.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 23 Jan 2022 19:45:09 -0800 (PST)
From:   Jagath Jog J <jagathjog1996@gmail.com>
To:     gregkh@linuxfoundation.org, hdegoede@redhat.com,
        Larry.Finger@lwfinger.net
Cc:     fabioaiuto83@gmail.com, dan.carpenter@oracle.com,
        marcocesati@gmail.com, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org, jagathjog1996@gmail.com
Subject: [Patch  3/3] Staging: rtl8723bs: Inserting blank line after declaration
Date:   Mon, 24 Jan 2022 09:14:56 +0530
Message-Id: <20220124034456.8665-4-jagathjog1996@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220124034456.8665-1-jagathjog1996@gmail.com>
References: <20220124034456.8665-1-jagathjog1996@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix following checkpatch.pl warning by inserting blank line
WARNING: Missing a blank line after declarations

Signed-off-by: Jagath Jog J <jagathjog1996@gmail.com>
---
 drivers/staging/rtl8723bs/hal/hal_intf.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/staging/rtl8723bs/hal/hal_intf.c b/drivers/staging/rtl8723bs/hal/hal_intf.c
index 4868a69cdb8f..94ecefb9113d 100644
--- a/drivers/staging/rtl8723bs/hal/hal_intf.c
+++ b/drivers/staging/rtl8723bs/hal/hal_intf.c
@@ -181,6 +181,7 @@ void rtw_hal_disable_interrupt(struct adapter *padapter)
 u8 rtw_hal_check_ips_status(struct adapter *padapter)
 {
 	u8 val = false;
+
 	if (padapter->HalFunc.check_ips_status)
 		val = padapter->HalFunc.check_ips_status(padapter);
 
@@ -209,6 +210,7 @@ s32	rtw_hal_xmit(struct adapter *padapter, struct xmit_frame *pxmitframe)
 s32	rtw_hal_mgnt_xmit(struct adapter *padapter, struct xmit_frame *pmgntframe)
 {
 	s32 ret = _FAIL;
+
 	update_mgntframe_attrib_addr(padapter, pmgntframe);
 	/* pframe = (u8 *)(pmgntframe->buf_addr) + TXDESC_OFFSET; */
 	/* pwlanhdr = (struct rtw_ieee80211_hdr *)pframe; */
@@ -299,6 +301,7 @@ void rtw_hal_stop_thread(struct adapter *padapter)
 u32 rtw_hal_read_bbreg(struct adapter *padapter, u32 RegAddr, u32 BitMask)
 {
 	u32 data = 0;
+
 	if (padapter->HalFunc.read_bbreg)
 		 data = padapter->HalFunc.read_bbreg(padapter, RegAddr, BitMask);
 	return data;
@@ -312,6 +315,7 @@ void rtw_hal_write_bbreg(struct adapter *padapter, u32 RegAddr, u32 BitMask, u32
 u32 rtw_hal_read_rfreg(struct adapter *padapter, u32 eRFPath, u32 RegAddr, u32 BitMask)
 {
 	u32 data = 0;
+
 	if (padapter->HalFunc.read_rfreg)
 		data = padapter->HalFunc.read_rfreg(padapter, eRFPath, RegAddr, BitMask);
 	return data;
@@ -385,6 +389,7 @@ bool rtw_hal_c2h_valid(struct adapter *adapter, u8 *buf)
 s32 rtw_hal_c2h_handler(struct adapter *adapter, u8 *c2h_evt)
 {
 	s32 ret = _FAIL;
+
 	if (adapter->HalFunc.c2h_handler)
 		ret = adapter->HalFunc.c2h_handler(adapter, c2h_evt);
 	return ret;
-- 
2.17.1

