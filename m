Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2A2864695B2
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Dec 2021 13:30:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243178AbhLFMdj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Dec 2021 07:33:39 -0500
Received: from mga12.intel.com ([192.55.52.136]:62519 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S243132AbhLFMdf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Dec 2021 07:33:35 -0500
X-IronPort-AV: E=McAfee;i="6200,9189,10189"; a="217329018"
X-IronPort-AV: E=Sophos;i="5.87,291,1631602800"; 
   d="scan'208";a="217329018"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Dec 2021 04:30:05 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.87,291,1631602800"; 
   d="scan'208";a="748024789"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga006.fm.intel.com with ESMTP; 06 Dec 2021 04:30:01 -0800
Received: by black.fi.intel.com (Postfix, from userid 1000)
        id 5BCF4144; Mon,  6 Dec 2021 14:30:07 +0200 (EET)
From:   "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
To:     rafael@kernel.org
Cc:     ak@linux.intel.com, bp@alien8.de, dan.j.williams@intel.com,
        dave.hansen@linux.intel.com, hpa@zytor.com,
        kirill.shutemov@linux.intel.com, knsathya@kernel.org,
        linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
        mingo@redhat.com, rjw@rjwysocki.net,
        sathyanarayanan.kuppuswamy@linux.intel.com, tglx@linutronix.de,
        tony.luck@intel.com, x86@kernel.org
Subject: [PATCH 0/4] ACPI/ACPICA: Only flush caches on S1/S2/S3 and C3
Date:   Mon,  6 Dec 2021 15:29:48 +0300
Message-Id: <20211206122952.74139-1-kirill.shutemov@linux.intel.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <CAJZ5v0gLwSvPfWzYwiZXee8SiPiQQoxjfKfVn4jx6wK_9VVEeg@mail.gmail.com>
References: <CAJZ5v0gLwSvPfWzYwiZXee8SiPiQQoxjfKfVn4jx6wK_9VVEeg@mail.gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Does it look like you want?

Kirill A. Shutemov (4):
  ACPICA: Do not flush cache for on entering S4 and S5
  ACPI: PM: Remove redundant cache flushing
  ACPI: processor idle: Only flush cache on entering C3
  ACPI: PM: Avoid cache flush on entering S4

 drivers/acpi/acpica/hwesleep.c  | 3 ++-
 drivers/acpi/acpica/hwsleep.c   | 3 ++-
 drivers/acpi/acpica/hwxfsleep.c | 2 --
 drivers/acpi/processor_idle.c   | 3 ++-
 drivers/acpi/sleep.c            | 9 +++------
 5 files changed, 9 insertions(+), 11 deletions(-)

-- 
2.32.0

