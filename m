Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0540A4B0408
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Feb 2022 04:43:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232836AbiBJDmp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Feb 2022 22:42:45 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:32962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229543AbiBJDmm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Feb 2022 22:42:42 -0500
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06E6123BDD
        for <linux-kernel@vger.kernel.org>; Wed,  9 Feb 2022 19:42:44 -0800 (PST)
Received: by mail-ej1-x62c.google.com with SMTP id e7so8064172ejn.13
        for <linux-kernel@vger.kernel.org>; Wed, 09 Feb 2022 19:42:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=kKRzEScg5J173EHITJeYv+1fCJ8FonUtOFLmbVJnnYo=;
        b=XHSroxGTPnprbGaz1CMR+L5UW6iCB9Y0ZU9+u6jr4oOlxbu0bQEHjaTgh0X4uDwq0h
         9MPnVYtQ94l/iKEoj8cZH2VtTtj/0zkGaL19Jz6I7JLoa7A9QNIQtOPGB1ij/jQ0hoS5
         dwT+TY6S33cK1Z1z0VhP63/SJnk/as+6dc0ky+5e2ftGcFtY/DaAT9R9wLh5V76viWwA
         w2T4S3LN6FfXo1LWwhARb4gCfjhg2md9FIE3ylNp3GkJnOGUeYVnMs7CsXEZ8fTyuvnq
         b48NqpV5QwHfcvjwbLJsUIGgLx5apQte/Nkvte9LCSZm5lrssHSJ/fYmAmiXHbXrd+Pp
         8feg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=kKRzEScg5J173EHITJeYv+1fCJ8FonUtOFLmbVJnnYo=;
        b=qNm4hPCgOWxZQhR81USUgH5ox9fiQ64SJSllzQjw3cAf15NMQg+OjSc0sBPZB+Ax2M
         o2JMJC1ceN7UkQfff5Ow5rX8t+i6TUin/Ca4lyxQcIQYXFgkzrxnRtuBruYG0nmr+7bw
         bNTsYpxb6j21HtZcrRCOPTtlY9Q/Ul2Q/urcFocs4dcwiEHdPs/A4/oRup4LOFvXHiZW
         vzrpnIATw2Ng15e80kHOG9eNm4ibU5wJXK6TnQFcmCkO3pIUeryurD6atUeErYJQoecy
         KLokgfBryxX3TZHN8gDslcSi+ftHvWMLXejzjpFmNJ0IptK5Vp6cOxbq+AEVConqC45Q
         sApg==
X-Gm-Message-State: AOAM533YAwNqhN9Fdf/cImsdriznN3luuuKTD0spQN3YWA2Sds6f6qkm
        y8La28WVarcDbBN+nEUhgMjRdhBeHcwEMct8sidCqM7de5Q5
X-Google-Smtp-Source: ABdhPJwVtPyrm9T0JfJpMs6dg/AjSO+E4puS+P4nZbx+fTyrVW6kOib0QsMhfHIzajqntKq+UUf7pAqAOQHE5Gtt/4g=
X-Received: by 2002:a17:907:3e8a:: with SMTP id hs10mr4794139ejc.112.1644464562564;
 Wed, 09 Feb 2022 19:42:42 -0800 (PST)
MIME-Version: 1.0
From:   Paul Moore <paul@paul-moore.com>
Date:   Wed, 9 Feb 2022 22:42:31 -0500
Message-ID: <CAHC9VhTJR7vwuSBRa1nmP4-EY-GMrJmeQ3F_tuihjqLxT23GQg@mail.gmail.com>
Subject: [GIT PULL] Audit fixes for v5.17 (#2)
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-audit@redhat.com, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

Another audit fix for v5.17-rcX, this time a single rather small but
important patch that fixes an oops/page-fault caused by improperly
accessing userspace memory.  Please merge for the next -rcX release.

Thanks,
-Paul

--
The following changes since commit f26d04331360d42dbd6b58448bd98e4edbfbe1c5:

 audit: improve audit queue handling when "audit=1" on cmdline
   (2022-01-25 13:22:51 -0500)

are available in the Git repository at:

 git://git.kernel.org/pub/scm/linux/kernel/git/pcmoore/audit.git
   tags/audit-pr-20220209

for you to fetch changes up to 7a82f89de92aac5a244d3735b2bd162c1147620c:

 audit: don't deref the syscall args when checking the openat2
        open_how::flags (2022-02-09 16:04:26 -0500)

----------------------------------------------------------------
audit/stable-5.17 PR 20220209

----------------------------------------------------------------
Paul Moore (1):
     audit: don't deref the syscall args when checking the openat2
            open_how::flags

kernel/auditsc.c | 2 +-
1 file changed, 1 insertion(+), 1 deletion(-)

-- 
paul-moore.com
