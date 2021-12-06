Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BAD4046A376
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Dec 2021 18:48:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343904AbhLFRvl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Dec 2021 12:51:41 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:27137 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S245735AbhLFRvk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Dec 2021 12:51:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1638812891;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=o/oc+mSz+IALBefIcLxcpEdGXyhAlfIPSpxF81ufReY=;
        b=ExPSasxz1wU9CaQCY88hXxO+KwV0XFc8MK+aVyg4c61eccEGN8Aucb5YgH3s9Q8wOdavN4
        ZUuYjnojOIKqFikqLMgVJbc3X2nCF+fn4pLXClTs4vrexHOX9kIhhKPSbHED4UnueJGS45
        Tn9C+Gd0AzwJuOfqCaUxsRZ55P6VVbY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-407-Evx0G1QEPWqTVdP3xq5OrA-1; Mon, 06 Dec 2021 12:48:10 -0500
X-MC-Unique: Evx0G1QEPWqTVdP3xq5OrA-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id D10FE180832C;
        Mon,  6 Dec 2021 17:48:08 +0000 (UTC)
Received: from x1.localdomain (unknown [10.39.192.105])
        by smtp.corp.redhat.com (Postfix) with ESMTP id AA1255DF4F;
        Mon,  6 Dec 2021 17:48:07 +0000 (UTC)
From:   Hans de Goede <hdegoede@redhat.com>
To:     Lee Jones <lee.jones@linaro.org>,
        Andy Shevchenko <andy@infradead.org>,
        Mika Westerberg <mika.westerberg@linux.intel.com>
Cc:     Hans de Goede <hdegoede@redhat.com>, linux-kernel@vger.kernel.org
Subject: [PATCH resend 0/1] mfd: intel_soc_pmic: Use CPU-id check instead of _HRV check to differentiate variants
Date:   Mon,  6 Dec 2021 18:48:05 +0100
Message-Id: <20211206174806.197772-1-hdegoede@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Lee,

This patch seems to have fallen through the cracks,
so I'm resending it now.

Note it already has a Reviewed-by from Andy so AFAICT it is
ready for merging.

Regards,

Hans


Hans de Goede (1):
  mfd: intel_soc_pmic: Use CPU-id check instead of _HRV check to
    differentiate variants

 drivers/mfd/intel_soc_pmic_core.c | 28 +++-------------------------
 1 file changed, 3 insertions(+), 25 deletions(-)

-- 
2.33.1

