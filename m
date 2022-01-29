Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 701194A306B
	for <lists+linux-kernel@lfdr.de>; Sat, 29 Jan 2022 17:05:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351193AbiA2QFh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 29 Jan 2022 11:05:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234506AbiA2QFg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Jan 2022 11:05:36 -0500
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0AEC6C061714
        for <linux-kernel@vger.kernel.org>; Sat, 29 Jan 2022 08:05:36 -0800 (PST)
Received: by mail-pj1-x102b.google.com with SMTP id z10-20020a17090acb0a00b001b520826011so13838883pjt.5
        for <linux-kernel@vger.kernel.org>; Sat, 29 Jan 2022 08:05:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=EqfKy3dtUhi7JBYRclICg0WdgZkWY6fzxwHSqCR6ZPI=;
        b=g19dEYIWrY3UQofi3mTplA5jprQAq+MBqAqRKYo4JfJ0Pdpaob4hQHLtMNBJ6kM98d
         ySvX1jCJ4XD5D1oxxSMd8FuLCDspE6BmyUVp5A9gWPecI4c3WMndUeUURDBJRE2qSUR3
         qmbwuWtJqEjqwDLH7z0QkWYmLTxn1c4D98NfhbJUokuuppYMqKLei1LskmF1ABQ4w0DD
         +TR6OHDaaD3pu8sBdjdFwxu+uA5YfD0FfFsFFcHX5s4eo0Z9Ih3AO4mprTlQY59GT2gT
         ahbnDK9QvI4OwQqobAAardMKZywVn6egZzgWdFgRuE5o84s2HrRpFi2XJueV8R2LjZR8
         p2Xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=EqfKy3dtUhi7JBYRclICg0WdgZkWY6fzxwHSqCR6ZPI=;
        b=M22VMiihNzZuRi1x4B1W7ygn+9DiwnxYo1wDkDwRxkOclyRYMlI9b2jL3a08JgKM0w
         gjjIZJMJ6oy4C8f5wetYOvRarTViANL71l30aaLe9s/2ppRBoqxHm4efS9AHns9CJxMl
         mSWLtPnAVPKhoZS7e9ekXHqotbFlcYure5DF3wgwxmXKhgtu1g4W82ZaMfRQbHLPeGLk
         GyYRJeX6KajefE4JQbnAb3vt7ouSeZt9kssTJWlh3ddVEcsR9Me69BMoKOPe28+aGAUM
         cAiwE+FPRP1Z/fQBXYzFrCJZxZBcsbVhnHQ5pH+mEXDkZCpZZVPqI4SF4Z3qNQPAVhee
         f5FQ==
X-Gm-Message-State: AOAM532ZAPU3XRCgaCmLKn341ZhMk1JgOIJ2uvMjrlc3ihqLGSPx0Wdx
        GO7Jo6VHLJOzdkhJf9aHqv4=
X-Google-Smtp-Source: ABdhPJzsgvSH+gGJzqQmXJ3UFugV6e/s7qFCPn8U5RFGkwOgTsyIqUUO+V4WiD7cr2Fs+Z4boxHHQQ==
X-Received: by 2002:a17:902:7e4a:: with SMTP id a10mr13264848pln.143.1643472335533;
        Sat, 29 Jan 2022 08:05:35 -0800 (PST)
Received: from localhost.localdomain ([171.78.146.184])
        by smtp.googlemail.com with ESMTPSA id t9sm5672868pjg.44.2022.01.29.08.05.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 29 Jan 2022 08:05:34 -0800 (PST)
From:   Abdun Nihaal <abdun.nihaal@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     Abdun Nihaal <abdun.nihaal@gmail.com>, Larry.Finger@lwfinger.net,
        phil@philpotter.co.uk, straube.linux@gmail.com, martin@kaiser.cx,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH v4 00/23] staging: r8188eu: remove unneeded ret variables
Date:   Sat, 29 Jan 2022 21:34:06 +0530
Message-Id: <cover.1643466748.git.abdun.nihaal@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patchset does the following to functions in ioctl_linux.c:
- Remove unneeded return variable in some functions.
  These functions cannot be converted to void either because it is an
  iw_handler function or the function does return error code.
- Propagate error code in rtw_p2p_get2 function
- Convert some functions that always return 0 to return void

v3 -> v4:
- Split the changes into smaller patches to make it easier to review
- Add a new patch to propagate error code in rtw_p2p_get2 function

v2 -> v3:
- Remove returns at the end of void functions to conform to coding style

v1 -> v2:
- As suggested by Greg, change functions that always return 0
  and whose return value is not used, to return void instead.
- Not removing return variables in rtw_p2p_get2 and rtw_p2p_set
  as they may need to be used.

Abdun Nihaal (23):
  staging: r8188eu: remove unneeded variable in rtw_wx_get_essid
  staging: r8188eu: remove unneeded variable in rtw_wx_get_enc
  staging: r8188eu: remove unneeded variable in rtw_p2p_get
  staging: r8188eu: remove unneeded variable in
    rtw_p2p_get_wps_configmethod
  staging: r8188eu: remove unneeded variable in
    rtw_p2p_get_go_device_address
  staging: r8188eu: remove unneeded variable in rtw_p2p_get_device_type
  staging: r8188eu: remove unneeded variable in rtw_p2p_get_device_name
  staging: r8188eu: remove unneeded variable in
    rtw_p2p_get_invitation_procedure
  staging: r8188eu: propagate error code in rtw_p2p_get2
  staging: r8188eu: convert rtw_p2p_set_go_nego_ssid to return void
  staging: r8188eu: convert rtw_p2p_setDN to return void
  staging: r8188eu: convert rtw_p2p_get_status to return void
  staging: r8188eu: convert rtw_p2p_get_req_cm to return void
  staging: r8188eu: convert rtw_p2p_get_role to return void
  staging: r8188eu: convert rtw_p2p_get_peer_ifaddr to return void
  staging: r8188eu: convert rtw_p2p_get_peer_devaddr to return void
  staging: r8188eu: convert rtw_p2p_get_peer_devaddr_by_invitation to
    return void
  staging: r8188eu: convert rtw_p2p_get_groupid to return void
  staging: r8188eu: convert rtw_p2p_get_op_ch to return void
  staging: r8188eu: convert rtw_p2p_invite_req to return void
  staging: r8188eu: convert rtw_p2p_set_persistent to return void
  staging: r8188eu: convert rtw_p2p_prov_disc to return void
  staging: r8188eu: convert rtw_p2p_got_wpsinfo to return void

 drivers/staging/r8188eu/os_dep/ioctl_linux.c | 155 +++++++------------
 1 file changed, 59 insertions(+), 96 deletions(-)

-- 
2.34.1

