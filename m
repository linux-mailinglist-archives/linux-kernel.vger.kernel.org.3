Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C4AE6463076
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Nov 2021 11:02:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240609AbhK3KFa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Nov 2021 05:05:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240601AbhK3KF3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Nov 2021 05:05:29 -0500
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6DCC7C061746
        for <linux-kernel@vger.kernel.org>; Tue, 30 Nov 2021 02:02:10 -0800 (PST)
Received: by mail-wr1-x429.google.com with SMTP id i5so43130121wrb.2
        for <linux-kernel@vger.kernel.org>; Tue, 30 Nov 2021 02:02:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=mxGGLWiQP1URa2RClGBG4bbowEUOqfLTXCyeksWHJak=;
        b=5f8ABW1zZtNjGY52IL+i4PbJ8cbZ23szB0iWo74difvp7IqT+JD6Kk7CCUo9/v+RgB
         /asJDH/j2rKieMVdk3LNhgKhxYqU6ZlIoNd7RJiEhOVFJdjfuqlKUYEtQ3+R/9ZAQ7YF
         6Vyi9+FnEgCXSWWbo3uskTucO22yeFP3INDaiejKeth45Dm0ZzjKdOsazQZTnJOH7jsJ
         D3+tAkMNLepuDlMZRXESq5FPZjiN1Jf+uAGzXa7xpc4niNhhUSKk0msiVF9wxwLQ6rth
         9jFf5jnK4wdJaeq95/6MAAws+UzpLE/zE6+Ocw5BdCz0vujXP8YvNMGvQJBAmqC+X1vE
         PCOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=mxGGLWiQP1URa2RClGBG4bbowEUOqfLTXCyeksWHJak=;
        b=J9XF/2z6IPTEYyfNKdPAJQWZmc3jAB9jBj9XtNqwwGjQqsEviFf9FcChyKSSs5zrr8
         CXONorfGdIpVOJq8Vrus7JTwoZmlK8zfbc6t/mHptDq861ZlkbIhhY1zCd2T8dN3cjF4
         LYelx0ts03HIsRyavb0fhvfnrZkLRxNyqw7T8Un3AbmPjz2e197pd408MMFH8LOU5CL7
         A6W+J+B+UgyhUMrZV56QrS72rJ8/nhsIpyUXNA78MJp9/pBZ25V5w7OY4Y9M1AhLqd/e
         DK/JEWMCXgL418ozZeG087CikrEbOhFkO/fvRImStXX9+XRyyWDJqQEIjM7zswALmXIs
         KB2w==
X-Gm-Message-State: AOAM531zLbLi4UPRzSfuJnCF3hg2tAWCJI/EPcmeddwOjVuN2ALZHkst
        yBzLcqhkJDaVijV4hptdYxV6SQ==
X-Google-Smtp-Source: ABdhPJz0zFU+8v8aXJOMRSoOlU4RtE0adVzFNEOwgHXFlg5BrDaJcdOIuhVOgvZz+Q6A+FYiEFmi5w==
X-Received: by 2002:a5d:61ca:: with SMTP id q10mr37714903wrv.102.1638266529024;
        Tue, 30 Nov 2021 02:02:09 -0800 (PST)
Received: from jackdaw.lan (82-65-169-74.subs.proxad.net. [82.65.169.74])
        by smtp.googlemail.com with ESMTPSA id e12sm21117166wrq.20.2021.11.30.02.02.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Nov 2021 02:02:08 -0800 (PST)
From:   Jerome Brunet <jbrunet@baylibre.com>
To:     Kevin Hilman <khilman@baylibre.com>,
        Neil Armstrong <narmstrong@baylibre.com>
Cc:     Jerome Brunet <jbrunet@baylibre.com>,
        linux-amlogic@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 0/2] arm64: dts: meson: p241: add internal sound support
Date:   Tue, 30 Nov 2021 11:01:57 +0100
Message-Id: <20211130100159.214489-1-jbrunet@baylibre.com>
X-Mailer: git-send-email 2.34.0
MIME-Version: 1.0
X-Patchwork-Bot: notify
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patchset adds support for the internal sound card of the s805x p241
reference design. Audio is available on HDMI and 3.5mm jack connector.

Jerome Brunet (2):
  arm64: dts: meson: p241: add vcc_5v regulator
  arm64: dts: meson: p241: add sound support

 .../boot/dts/amlogic/meson-gxl-s805x-p241.dts | 83 +++++++++++++++++++
 1 file changed, 83 insertions(+)

-- 
2.34.0

