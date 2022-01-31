Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 561CC4A5397
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Feb 2022 00:56:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229852AbiAaX4h (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Jan 2022 18:56:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229626AbiAaX4g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Jan 2022 18:56:36 -0500
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B916AC061714;
        Mon, 31 Jan 2022 15:56:35 -0800 (PST)
Received: by mail-pl1-x62b.google.com with SMTP id y17so13926775plg.7;
        Mon, 31 Jan 2022 15:56:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:content-language:to:cc:from
         :subject:content-transfer-encoding;
        bh=ASc0QdUIAk6Y/qox9xZbv3MFamTMdzPLX28teiDe900=;
        b=PGfG2wLagFdyh3utS6ZoDA7ZDWhj8J+bY0omsxYmxx7zePhDIdasnw3wP0g+potsIJ
         m0h/RQF9rzof1Lq4sSUyDlMqBph8WKz/lkF1iG5cw8oKhM/H65UGTKzP/iedbIkj6Z7b
         h1sIiXy/7JcAL8o3AKxR7DFsUhXoXRCssTlhKdvw5ty0kg7QdPHCGqFHO6CjE7sCr06m
         ss7T8M0x3V3ruEbkyUD3T7XoDqqFcjTixMaiMJRDk6GF8x42bWA4N7IDuMtRsHpjq/o8
         DXdX9dQU5EVSp9Q96l53wkBmeQajiCBbrNn7h6IrVoljQheopbg7z6tiGnss12kCfJQd
         VuFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent
         :content-language:to:cc:from:subject:content-transfer-encoding;
        bh=ASc0QdUIAk6Y/qox9xZbv3MFamTMdzPLX28teiDe900=;
        b=x+hyy+SeyHX9qCNyFbAGyoQfOI1KQN8nLcRJMVJvAWMUs5j1UBzoY3vnuRzz3Gs9rQ
         hSlfhdF36NbeETFO8w4VaWFrlwVOL89KccCaIdvtgNiWWg3fU9eoRu4GOwBETfMiN4pq
         GwSkt72o8qs0hj8/g39b6mQBBX/diJUKJGkZYnG1wIapQBVD4bC6JHLloLiKTkRjQspr
         v2u75EwKAIv0Kr0H39+T3DKh840ISNucj+Bc4biyzPQOgfayaeKUdH3uB8lfNGTGRSGr
         d4wRbFR5K1VTpKYPvl70ZJOx1KJp0BqQKoEgzLSG/qDthN3YAaNqOsRp7P+ECT2/0z2f
         Nf9g==
X-Gm-Message-State: AOAM533+t7tq4ezdkP5NghbIyE2Lv3BvTIEaHxfEKeou4/DAr75jVfh8
        uVDKE93DMCmyzsi7seFDQ5M=
X-Google-Smtp-Source: ABdhPJzLZvetdGIXEW1s9FTrX8NejTliyZWjj5RmttyIZ34SohLKBs1AXCwi7LrjJ2aaOrWBAE9ZCQ==
X-Received: by 2002:a17:902:d2c8:: with SMTP id n8mr22948453plc.41.1643673395032;
        Mon, 31 Jan 2022 15:56:35 -0800 (PST)
Received: from [192.168.11.5] (KD106167171201.ppp-bb.dion.ne.jp. [106.167.171.201])
        by smtp.gmail.com with ESMTPSA id u2sm21432612pfk.15.2022.01.31.15.56.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 31 Jan 2022 15:56:34 -0800 (PST)
Message-ID: <b5b948b7-8e41-3bd6-1a52-44785c89c965@gmail.com>
Date:   Tue, 1 Feb 2022 08:56:29 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Content-Language: en-US
To:     Jonathan Corbet <corbet@lwn.net>
Cc:     linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Akira Yokosawa <akiyks@gmail.com>
From:   Akira Yokosawa <akiyks@gmail.com>
Subject: [PATCH 0/5] docs: pdfdocs: Improve LaTeX preamble (TOC, CJK fonts)
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

This is a follow-up series to the CJK font setting patch series [1]
upstreamed in v5.15.

[1]: https://lore.kernel.org/r/39d0fb0f-b248-bca4-2dac-df69e8d697b1@gmail.com

There is still a lot of room for improvement in the layout of PDF docs.

This series resolves issues listed below:

 1. Some of chapter and section counts in Table of Contents (TOC) in
    large PDF docs collide with chapter/section titles, e.g., Chapters 10,
    11, 12, and 13 and Section 10.10 in userspace-api.pdf.
 2. In docs of more than 99 pages, page counts in TOC are not aligned
    properly when maxdepth >= 2 is specified in toctree, e.g., Chapters 10,
    12, and 13 in userspace-api.pdf
 3. In TOC of Latin-script docs, quotation and apostrophe symbols look too
    wide, e.g., Section 2.2 in userspace-api.pdf.
 4. In TOC of translations, Korean chapter titles lose inter-phrase spaces.
 5. On systems without "Noto Sans CJK" fonts, CJK chapters in translations
    results in full of "TOFU" boxes, with a long build time and a large
    log file containing lots of missing-font warnings.
 6. In translations.pdf built by "make pdfdocs", ascii-art diagrams in CJK
    are not aligned properly.

Patch 1/5 resolves issues #1 and #2 by tweaking width parameters for TOC.

Patch 2/5 resolves issue #3 by switching CJK default font to the KR variant,
whose quotation and apostrophe symbols are half width.

Patch 3/5 resolves issue #4 by enabling CJKspace in TOC by default.

Patch 4/5 resolves issue #5 by conditionally skipping CJK contents in
PDF docs.

Patch 5/5 resolves issue #6 by moving font settings under
translations/conf.py to CJK-specific macros in main conf.py

This series is tested against Sphinx versions 1.7.9, 2.4.4, and 4.4.0.
It does not affect HTML docs.

        Thanks, Akira
--
Akira Yokosawa (5):
  docs: pdfdocs: Tweak width params of TOC
  docs: pdfdocs: Switch default CJK font to KR variants
  docs: pdfdocs: Enable CJKspace in TOC for Korean titles
  docs/translations: Skip CJK contents if suitable fonts not found
  docs: pdfdocs: Move CJK monospace font setting to main conf.py

 Documentation/conf.py                      | 81 ++++++++++++++++++----
 Documentation/translations/conf.py         | 12 ----
 Documentation/translations/ja_JP/index.rst |  4 +-
 Documentation/translations/ko_KR/index.rst |  5 +-
 Documentation/translations/zh_CN/index.rst |  4 +-
 Documentation/translations/zh_TW/index.rst |  4 +-
 6 files changed, 75 insertions(+), 35 deletions(-)
 delete mode 100644 Documentation/translations/conf.py


base-commit: 854d0982eef0e424e8108d09d9275aaf445b1597
-- 
2.17.1

