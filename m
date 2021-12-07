Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 05A8046B27B
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Dec 2021 06:40:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236329AbhLGFoH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Dec 2021 00:44:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236196AbhLGFoD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Dec 2021 00:44:03 -0500
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E8E2C061746
        for <linux-kernel@vger.kernel.org>; Mon,  6 Dec 2021 21:40:33 -0800 (PST)
Received: by mail-yb1-xb49.google.com with SMTP id e131-20020a25d389000000b005fb5e6eb757so23967869ybf.22
        for <linux-kernel@vger.kernel.org>; Mon, 06 Dec 2021 21:40:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=iv3XPkeNjzTuXlX7KV6sXtdefvb8MaEt+ItGcqhTHtw=;
        b=YvxDNLksB5J+1uPwEJLzRNjjTl8Tu1TqP9C6Zik9TGjnx6du9ewlFJktMT7ryUX/im
         xatUdH95b5/FJ5LZTbuZ8DC7AMb5s9ElAKwXsBFiGIdPKmEVZN64gvX/DFRSznnPxecS
         p6C/pzlrsz73YWNmNKSht7yZ+0oT0j6F1iuDEJVLRSRkPjLDLxArke6Gy/kfDKXHR4Xc
         xVICYQxlNq7V1+/4q8i3433BM/7yJkZZoTe/PYDhfDmNer+gbc1Rmm7Zq9FO8Ie7TmjW
         USpDXbPXZkkcUWH6bgFtagYds+sGgIAECDdfRHhQQHxcQdjeXVqCNIH1oDZXunlboAip
         YmxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=iv3XPkeNjzTuXlX7KV6sXtdefvb8MaEt+ItGcqhTHtw=;
        b=LWLVKWNv6EFPBoVxGrLZveSK2hL5fPvEK6HQlNtAzS2rmwmX1aDLYs3y9ExGzJU1af
         zIIdgOgsVbXOMdGvvn8woIUFKL2WdehmG3BbpbidjBy/jflvYPfLsW0PdKzBFmS2BEPA
         5A3yxtZSM7TTNxyNvMlOAaL8awh2G8ZKwb0j1kRLlV31CKiWVxYgIc9ZTyGZ1XZYMlbE
         qtAOp8oFQz/fAoDo8nsSUFkbsz0TlHb2ddobI9oGQgDJ6spf09OG20FcIqbpMJV3Sp3s
         A8f9nogyAMU5aIBpLo1v443vN7HwnfmBzpv8nFXFo9h2+fA1AUMMkLy7vPgN0GP0JXgJ
         Efqw==
X-Gm-Message-State: AOAM530gwRgqD8K1FMxaUuzxw5xyBwJjt/fh9LMNjKNtYcboMHTPTIte
        djzllPxO6SELLK17xchG/IaBwe8UWh/tr6A=
X-Google-Smtp-Source: ABdhPJyr2DmKjI06HJ74o6yAt1Y10x+Urym7uuqDfp2tB4pSp3HUX17yra0M4OVpibkcLEC060eRnPr7q/O1cO4=
X-Received: from sharinder.c.googlers.com ([fda3:e722:ac3:cc00:4f:4b78:c0a8:c73])
 (user=sharinder job=sendgmr) by 2002:a05:6902:1025:: with SMTP id
 x5mr48941341ybt.156.1638855632635; Mon, 06 Dec 2021 21:40:32 -0800 (PST)
Date:   Tue,  7 Dec 2021 05:40:12 +0000
Message-Id: <20211207054019.1455054-1-sharinder@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.34.1.400.ga245620fadb-goog
Subject: [PATCH v2 0/7] Documentation: KUnit: Rework KUnit documentation
From:   Harinder Singh <sharinder@google.com>
To:     davidgow@google.com, brendanhiggins@google.com, shuah@kernel.org,
        corbet@lwn.net
Cc:     linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        tim.bird@sony.com, Harinder Singh <sharinder@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The KUnit documentation was not very organized. There was little
information related to KUnit architecture and the importance of unit
testing.

Add some new pages, expand and reorganize the existing documentation.
Reword pages to make information and style more consistent.


Changes since v1:
https://lore.kernel.org/linux-kselftest/20211203042437.740255-1-sharinder@google.com/

--Fixed spelling mistakes
--Restored paragraph about kunit_tool introduction
--Added note about CONFIG_KUNIT_ALL_TESTS (Thanks Tim Bird for review
comments)
-- Miscellaneous changes


Harinder Singh (7):
  Documentation: KUnit: Rewrite main page
  Documentation: KUnit: Rewrite getting started
  Documentation: KUnit: Added KUnit Architecture
  Documentation: kunit: Reorganize documentation related to running
    tests
  Documentation: KUnit: Rework writing page to focus on writing tests
  Documentation: KUnit: Restyle Test Style and Nomenclature page
  Documentation: KUnit: Restyled Frequently Asked Questions

 .../dev-tools/kunit/architecture.rst          | 206 +++++++
 Documentation/dev-tools/kunit/faq.rst         |  73 ++-
 Documentation/dev-tools/kunit/index.rst       | 172 +++---
 .../kunit/kunit_suitememorydiagram.png        | Bin 0 -> 24174 bytes
 Documentation/dev-tools/kunit/run_manual.rst  |  57 ++
 Documentation/dev-tools/kunit/run_wrapper.rst | 247 ++++++++
 Documentation/dev-tools/kunit/start.rst       | 198 +++---
 Documentation/dev-tools/kunit/style.rst       | 101 ++--
 Documentation/dev-tools/kunit/usage.rst       | 570 ++++++++----------
 9 files changed, 1039 insertions(+), 585 deletions(-)
 create mode 100644 Documentation/dev-tools/kunit/architecture.rst
 create mode 100644 Documentation/dev-tools/kunit/kunit_suitememorydiagram.png
 create mode 100644 Documentation/dev-tools/kunit/run_manual.rst
 create mode 100644 Documentation/dev-tools/kunit/run_wrapper.rst


base-commit: 4c388a8e740d3235a194f330c8ef327deef710f6
-- 
2.34.1.400.ga245620fadb-goog

