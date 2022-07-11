Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 777E3570A95
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Jul 2022 21:20:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230060AbiGKTU1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Jul 2022 15:20:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229622AbiGKTUZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jul 2022 15:20:25 -0400
Received: from fanzine2.igalia.com (fanzine.igalia.com [178.60.130.6])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C9F31A3B1
        for <linux-kernel@vger.kernel.org>; Mon, 11 Jul 2022 12:20:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
        s=20170329; h=Content-Transfer-Encoding:Content-Type:MIME-Version:Message-Id:
        Date:Subject:Cc:To:From:Sender:Reply-To:Content-ID:Content-Description:
        Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
        In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=7c7d6rskMkCYDjy6DAbXKPIeXjrUo9HRt6h1La1UYjI=; b=VBYzb6hel8xiSj8r/JdTvu51Y3
        qp6SbCXo4XhSmXzSD4QZKZBX4a1I8+C8Ib5WdkOkNxTW/10jRpyaR0qR8U8PvS4GDI3xAeyCL35sn
        LmpsSoEvEHZMI6LgWHATqPPmBo8T4IO5pO2Fpv5dR+NMu8wtjIwhKVhegoBx/wlwITEnE7Z1SoCdg
        lgfWRquRIRNNI6ieUfP9XPNWtudaF0GZcGAAG9u30noGZEa5mYAV34qcnfdG0N5wtb8C7+xZ/Oy0v
        gwkpfY6ZdYzTHx9fozoIHALFM26C38FYdiadGkEmQfsNNlONL3W1SBT0mrYMpJNA2RSiT+Ish/3EV
        Fz7k+7Dw==;
Received: from [177.45.248.119] (helo=localhost.localdomain)
        by fanzine2.igalia.com with esmtpsa 
        (Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
        id 1oAyx5-00CJom-TS; Mon, 11 Jul 2022 21:20:16 +0200
From:   =?UTF-8?q?Andr=C3=A9=20Almeida?= <andrealmeid@igalia.com>
To:     Alex Deucher <alexander.deucher@amd.com>,
        =?UTF-8?q?=27Christian=20K=C3=B6nig=27?= <christian.koenig@amd.com>,
        'Pan Xinhui' <Xinhui.Pan@amd.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Hawking Zhang <Hawking.Zhang@amd.com>,
        Tao Zhou <tao.zhou1@amd.com>,
        Felix Kuehling <Felix.Kuehling@amd.com>,
        Jack Xiao <Jack.Xiao@amd.com>, amd-gfx@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Cc:     kernel-dev@igalia.com,
        =?UTF-8?q?Andr=C3=A9=20Almeida?= <andrealmeid@igalia.com>
Subject: [PATCH 0/2] drm/amd/pm: Add GFXOFF status for vangogh
Date:   Mon, 11 Jul 2022 16:19:51 -0300
Message-Id: <20220711191953.145518-1-andrealmeid@igalia.com>
X-Mailer: git-send-email 2.37.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patchset adds support to get current status of GFXOFF in vangogh.
Given that the rest of the interface is already implemented, we just
need to plug one function.

This is implemented just for vangogh and not for all smu11 devices given
that this is specific for this device, and not to all the generation.

André Almeida (2):
  drm/amd/pm: Add GFXOFF registers for vangogh
  drm/amd/pm: Implement get GFXOFF status for vangogh

 .../inc/pmfw_if/smu11_driver_if_vangogh.h     | 12 +++++++++
 .../gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c  | 26 +++++++++++++++++++
 2 files changed, 38 insertions(+)

-- 
2.37.0

