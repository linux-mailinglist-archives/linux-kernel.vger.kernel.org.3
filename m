Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D82714D5439
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Mar 2022 23:09:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344046AbiCJWKl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Mar 2022 17:10:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240075AbiCJWKi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Mar 2022 17:10:38 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0174AD4470;
        Thu, 10 Mar 2022 14:09:37 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 926B261AD2;
        Thu, 10 Mar 2022 22:09:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B7A48C340E8;
        Thu, 10 Mar 2022 22:09:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1646950176;
        bh=tMUOhG6pFcuv+nm+xL9hctLl6S7C9WHjH9Uakei9h3Q=;
        h=From:To:Cc:Subject:Date:From;
        b=XlPypQDQiKimc+h5jKNd/kO20l9tAqk2BjsVoie/Ir707iCNJhlJgKriUcj3G2zdX
         8m01cRbngXRKN0YjPpanM5FEfNRSpfYRchDNbi2tLcAO9qCl/FbpIVHNx/qSQjo4HE
         r4PL8GZy442kLEBI7fKQAiDtPC/W//sp1Vtz6UKA22WfZ4Y7lAJeGkfCsrlqVVdR3Y
         ovazFtLUEt/TlGYsrimlshq2DcRGEDMrRmnCis+9h06SO3Dd65pkUANXuiwvRQhq8F
         t9bH9RpU5iz2pydQQJFd0F60Hybi4JRKNf+CoIM0Q+tbigNW7gqiYYw9i0rRaF/jMy
         OaWfZLNLMlYEA==
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Jonathan Corbet <corbet@lwn.net>
Cc:     Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        "Michael S . Tsirkin" <mst@redhat.com>, llvm@lists.linux.dev,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Bjorn Helgaas <bhelgaas@google.com>
Subject: [PATCH 0/2] linux/types.h: Tidy __bitwise, add __CHECKER__ hints
Date:   Thu, 10 Mar 2022 16:09:25 -0600
Message-Id: <20220310220927.245704-1-helgaas@kernel.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bjorn Helgaas <bhelgaas@google.com>

- Tidy up __bitwise__, which is unused except in the __bitwise definition

- Add hints about what __CHECKER__ means

Bjorn Helgaas (2):
  linux/types.h: Remove unnecessary __bitwise__
  Documentation/sparse: Add hints about __CHECKER__

 Documentation/dev-tools/sparse.rst | 2 ++
 include/linux/compiler_types.h     | 1 +
 include/uapi/linux/types.h         | 6 +++---
 3 files changed, 6 insertions(+), 3 deletions(-)

-- 
2.25.1

