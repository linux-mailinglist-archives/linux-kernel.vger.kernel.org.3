Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 51C2A51567E
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Apr 2022 23:14:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235107AbiD2VRt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Apr 2022 17:17:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234756AbiD2VRq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Apr 2022 17:17:46 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 4A406D3AD7
        for <linux-kernel@vger.kernel.org>; Fri, 29 Apr 2022 14:14:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1651266866;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=nyt4ykn1QhR0YTgPdt1Y5HFsS6fBE+SgIfjhrvt9+bs=;
        b=abQCw6TVS+BdpHaHcZiLkqsXYGZ1N9AbZ7bF2+6EDuS3/5UtDwuLvtNzXeWO80JLfh61uu
        E6YcXkm4Sg9j0gjQiAUEIj4mXBZmx/WPL362EfEZdyXorSKiTNYBNmJ5Dn80vS27ZFVJKp
        plQaiOzriEbZPO0iJu3VidiyCddcbQg=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-37--AYCXKXxNS-NpUo7Cg87pw-1; Fri, 29 Apr 2022 17:14:23 -0400
X-MC-Unique: -AYCXKXxNS-NpUo7Cg87pw-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 8A7743C0F091;
        Fri, 29 Apr 2022 21:14:22 +0000 (UTC)
Received: from emerald.lyude.net (unknown [10.22.8.66])
        by smtp.corp.redhat.com (Postfix) with ESMTP id B4573111DCF9;
        Fri, 29 Apr 2022 21:14:20 +0000 (UTC)
From:   Lyude Paul <lyude@redhat.com>
To:     ibm-acpi-devel@lists.sourceforge.net,
        platform-driver-x86@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-hwmon@vger.kernel.org,
        Hans de Goede <hdegoede@redhat.com>,
        Mark Pearson <markpearson@lenovo.com>
Subject: [PATCH 0/2] Fix detection of 2nd fan on X1C9
Date:   Fri, 29 Apr 2022 17:14:16 -0400
Message-Id: <20220429211418.4546-1-lyude@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.3
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some recent changes broke detection of the second fan on the X1 Carbon
9th generation, so here's some patches to fix it.

Lyude Paul (2):
  platform/x86: thinkpad_acpi: Restore X1 Carbon 9th Gen dual fan quirk
  platform/x86: thinkpad_acpi: Don't probe 2nd fan if enabled by quirk

 drivers/platform/x86/thinkpad_acpi.c | 26 +++++++++++++-------------
 1 file changed, 13 insertions(+), 13 deletions(-)

-- 
2.35.1

