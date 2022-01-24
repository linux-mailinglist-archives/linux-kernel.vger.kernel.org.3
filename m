Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D59D04985C4
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jan 2022 18:05:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235398AbiAXRFa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jan 2022 12:05:30 -0500
Received: from mta-p8.oit.umn.edu ([134.84.196.208]:33460 "EHLO
        mta-p8.oit.umn.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244138AbiAXRFW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jan 2022 12:05:22 -0500
Received: from localhost (unknown [127.0.0.1])
        by mta-p8.oit.umn.edu (Postfix) with ESMTP id 4JjGZT4vC3z9vjCJ
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jan 2022 17:05:21 +0000 (UTC)
X-Virus-Scanned: amavisd-new at umn.edu
Received: from mta-p8.oit.umn.edu ([127.0.0.1])
        by localhost (mta-p8.oit.umn.edu [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id wwcWM2FjLjYF for <linux-kernel@vger.kernel.org>;
        Mon, 24 Jan 2022 11:05:21 -0600 (CST)
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com [209.85.216.71])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mta-p8.oit.umn.edu (Postfix) with ESMTPS id 4JjGZT2m6bz9vjC7
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jan 2022 11:05:21 -0600 (CST)
DMARC-Filter: OpenDMARC Filter v1.3.2 mta-p8.oit.umn.edu 4JjGZT2m6bz9vjC7
DKIM-Filter: OpenDKIM Filter v2.11.0 mta-p8.oit.umn.edu 4JjGZT2m6bz9vjC7
Received: by mail-pj1-f71.google.com with SMTP id q8-20020a17090a064800b001b4ee55e378so241744pje.2
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jan 2022 09:05:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=umn.edu; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=iqOvQckE4DPpe/gz80hlCWLF/acf9yFaFDsgsRhtXZY=;
        b=czZ1znNCyFZoXGfMGTRQpY2QtLcSB0nqHP6Qv2BEwEtBbrFdR3EEjPAtvBBJ2rdKp1
         HCWt/yP1Uz6TUK5+DCAUbmhjfwwbeygHk6e1pINjALHkZiuZ7X3fGXVzC4ja/Uffy3Pm
         m3cGceoUfMcKY5gFjN5U3aHa31r5FJ53R4SduFG1taFo7vp7W57sSSyOhRD9HcDYl8P2
         ZwMydl4q3y05ziPmP1wV9YGvHMUEqf1628SaqjuAKegh5garAkZUc09Rx9cpSH9F1jUy
         kL7fgZO90+bdz4fB3nk2e0LepQwdWwOwh021tQT+3AZp5oVuMyKjQ+YYzz9guxDVk9eE
         G+0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=iqOvQckE4DPpe/gz80hlCWLF/acf9yFaFDsgsRhtXZY=;
        b=1EqLNONOdEJIOKprxZrrN9qe+mwT7Ykfsd4+OVHneF9bCXOIHTfNsx369nvw5zZeFn
         fEET37vT6o6MN1gbe0aHeUarq1UDnip+Q0JVdpUfCsC99hOql71CPSo4JxiNfItD6oyh
         +1L8h8QBFszWoeD8rQASljIq9yEAm1J/lBke46T4GjnFpM3pjqvTVa7EER998pmZHxVS
         jEC5FCyaXFXGShF4rNlmbY9xPASLSsQxWM9CbkW0EKaJloMax9rzbxvAVCMczknGQGUH
         5D4ofbi6iuqPCO8XeQyU6aul0SfPDsPvD/KfbkssClZc1tv/GTCehueg6Ii/juf4O3tt
         bh5Q==
X-Gm-Message-State: AOAM533dVacFT3khi0u3F2WK7sIjQk+MjpGmApgjvENCvZ7o/B0hszHB
        xQSN4HjTg2FO0qM6/mJSPgI3L+xBpA7OudIaQRpe7hge+5gYqKeEpCqdwNmks18V5nUpnfhOjhK
        GNMO4rV0tl0CWZCPsbt1xyfO7UTzw
X-Received: by 2002:a17:902:f243:b0:14b:1f32:e923 with SMTP id j3-20020a170902f24300b0014b1f32e923mr9628337plc.121.1643043920605;
        Mon, 24 Jan 2022 09:05:20 -0800 (PST)
X-Google-Smtp-Source: ABdhPJz6FN3UZbzNKOs+OIFcyGQ4fo0vfGGg3hCscMIg92FDOZqeD2qwe0OOD+rjCAyx1dQOnHgVQA==
X-Received: by 2002:a17:902:f243:b0:14b:1f32:e923 with SMTP id j3-20020a170902f24300b0014b1f32e923mr9628306plc.121.1643043920288;
        Mon, 24 Jan 2022 09:05:20 -0800 (PST)
Received: from zqy787-GE5S.lan ([36.4.61.248])
        by smtp.gmail.com with ESMTPSA id s2sm2882596pgq.38.2022.01.24.09.05.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Jan 2022 09:05:20 -0800 (PST)
From:   Zhou Qingyang <zhou1615@umn.edu>
To:     zhou1615@umn.edu
Cc:     kjlu@umn.edu, Mauro Carvalho Chehab <mchehab@kernel.org>,
        Zhen Lei <thunder.leizhen@huawei.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Michael Schimek <mschimek@gmx.at>, linux-media@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] media: bttv: Fix a NULL pointer dereference in setup_window_lock()
Date:   Tue, 25 Jan 2022 01:05:13 +0800
Message-Id: <20220124170515.58519-1-zhou1615@umn.edu>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In setup_window_lock(), the return value of videobuf_sg_alloc() is
assigned to variable new and there is a dereference of it after
that. the return value of videobuf_sg_alloc() could be NULL on
failure of allocation, which could lead to a NULL pointer dereference.

Fix this bug by adding a NULL check of new.

This bug was found by a static analyzer.

Builds with 'make allyesconfig' show no new warnings,
and our static analyzer no longer warns about this code.

Fixes: e5bd0260e7d3 ("V4L/DVB (5077): Bttv cropping support")
Signed-off-by: Zhou Qingyang <zhou1615@umn.edu>
---
The analysis employs differential checking to identify inconsistent 
security operations (e.g., checks or kfrees) between two code paths 
and confirms that the inconsistent operations are not recovered in the
current function or the callers, so they constitute bugs. 

Note that, as a bug found by static analysis, it can be a false
positive or hard to trigger. Multiple researchers have cross-reviewed
the bug.

 drivers/media/pci/bt8xx/bttv-driver.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/media/pci/bt8xx/bttv-driver.c b/drivers/media/pci/bt8xx/bttv-driver.c
index 8cc9bec43688..6338f98d845d 100644
--- a/drivers/media/pci/bt8xx/bttv-driver.c
+++ b/drivers/media/pci/bt8xx/bttv-driver.c
@@ -2182,6 +2182,8 @@ static int setup_window_lock(struct bttv_fh *fh, struct bttv *btv,
 		struct bttv_buffer *new;
 
 		new = videobuf_sg_alloc(sizeof(*new));
+		if (!new)
+			return -ENOMEM;
 		new->crop = btv->crop[!!fh->do_crop].rect;
 		bttv_overlay_risc(btv, &fh->ov, fh->ovfmt, new);
 		retval = bttv_switch_overlay(btv,fh,new);
-- 
2.25.1

